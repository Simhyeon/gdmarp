"use strict;"

import axios from "axios";
import fs from "fs";

class MediaWiki {
	constructor(baseUrl, botId, botPwd) {
		this.baseUrl = baseUrl;
		this.apiUrl = baseUrl + "/api.php";
		this.botId = botId;
		this.botPwd = botPwd;
	}

	/// Get page
	getPage(title) {
		axios.get(this.apiUrl, {
			params: { 
				action: "parse", prop : "wikitext", page: title, format: "json" 
			}
		}).then(response => {
			let data = response.data;
			console.log(JSON.stringify(data.parse.wikitext["*"], null, 4))
		}).catch(error => {
			console.log(error);
		})
	}

	/// This always replace page's content with given content
	async postPage(title, content) {
		let loginTokenResp = await this.getLoginTKResponse();
		let loginToken = loginTokenResp.data.query.tokens.logintoken;
		let cookie = loginTokenResp.headers["set-cookie"].join(';');

		let loginResp = await this.postLogin(loginToken, cookie);
		let loginCookie = loginResp.headers["set-cookie"].join(';');

		let csrfResp =  await this.getCsrfResponse(loginCookie);
		let csrfToken = csrfResp.data.query.tokens.csrftoken
		
		let editResponse = this.editPage( title, content, csrfToken, loginCookie);
		console.log(editResponse.data);
	}

	/// GEt 
	async getLoginTKResponse() {
		// Get Login Token
		return axios.get(this.apiUrl, {
			params : { action: "query", meta: "tokens", type: "login", format: "json" }
		}).then(response => {
			return response;
		}).catch(error => {
			console.log(error);
		})
	}

	async postLogin(loginToken, cookie) {
		let body = {
			action: 'login',
			lgname: this.botId,
			lgpassword: this.botPwd,
			lgtoken: loginToken,
			format: 'json'
		}
		let bodyData = new URLSearchParams(body).toString();

		// Log in 
		return axios.post(this.apiUrl, bodyData, { 
			headers: {
				Cookie: cookie,
			} 
		}).then(resp => {
			return resp;
		}).catch(error => {
			console.log(error);
		})
	}

	async getCsrfResponse(cookie) {
		// Get csrf token if login was successful
		return axios.get(this.apiUrl, {
			params: {
				action: "query",
				meta: "tokens",
				format: "json" 
			}, 
			headers: {
				Cookie: cookie
			}
		}).then(response => {
			// return csrfToken
			return response;
		}).catch(error => {
			console.log(error);
		})
	}

	async editPage(title, content, csrfToken, cookie) {
		// Post request
		let body = {
			action: "edit",
			title: title,
			text: content,
			token: csrfToken,
			format: "json"
		}
		let bodyData = new URLSearchParams(body).toString();
		return axios.post( this.apiUrl, bodyData, { 
			headers: {
				Cookie: cookie,
				"Content-Type": "multipart/form-data"
			} 
		}).then(response => {
			let data = response.data;
			console.log(JSON.stringify(data, null, 4))
		}).catch(error => {
			console.log(error);
		})
	}

}

function main() {
	// Initial Config
	axios.defaults.withCredentials = true;

	const file_path = process.argv0;
	const file_content = fs.readFileSync(file_path);
	let mw = new MediaWiki("http://wiki.simoncreek.xyz/w", process.env.bot_id, process.env.bot_pwd);
	mw.postPage(process.env.mw_title, file_content);
}

// -----------------------
// Main function
main();
