Return-Path: <linux-arch+bounces-1291-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580C8826A1B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 10:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE924282D34
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C566C8DE;
	Mon,  8 Jan 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bnb7nZ39";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aFBb7mVt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bnb7nZ39";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aFBb7mVt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36C1170D;
	Mon,  8 Jan 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42EF321DAE;
	Mon,  8 Jan 2024 09:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704704614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UyIk1mMRNZfoLM2xat6N+TsqH8WOEz1R3erf63p9wUM=;
	b=Bnb7nZ39wWXLVUYhWZUWfgcYx8nhfpBSJYMigncWPvt836eh5HsEVhUQvPFArWsMuW0YU3
	aFbcWt8mVSQnMadLrsSiBUBIsDbMH145UgbBCBOCFinc+vrUrhfESL0k/fXJ8E2Baqjigu
	W4J46mDreuiXLW1aPUUEDzMafxoelsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704704614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UyIk1mMRNZfoLM2xat6N+TsqH8WOEz1R3erf63p9wUM=;
	b=aFBb7mVtN20cwrfSwTOJzFs86zWtpp5rTisdNeeeUc3TVaeC7fkhKJGtFBLpkNV7/TUeou
	aNgI59AWB9t5bsCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704704614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UyIk1mMRNZfoLM2xat6N+TsqH8WOEz1R3erf63p9wUM=;
	b=Bnb7nZ39wWXLVUYhWZUWfgcYx8nhfpBSJYMigncWPvt836eh5HsEVhUQvPFArWsMuW0YU3
	aFbcWt8mVSQnMadLrsSiBUBIsDbMH145UgbBCBOCFinc+vrUrhfESL0k/fXJ8E2Baqjigu
	W4J46mDreuiXLW1aPUUEDzMafxoelsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704704614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UyIk1mMRNZfoLM2xat6N+TsqH8WOEz1R3erf63p9wUM=;
	b=aFBb7mVtN20cwrfSwTOJzFs86zWtpp5rTisdNeeeUc3TVaeC7fkhKJGtFBLpkNV7/TUeou
	aNgI59AWB9t5bsCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAEA013496;
	Mon,  8 Jan 2024 09:03:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EKCEMGW6m2WYCQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 08 Jan 2024 09:03:33 +0000
Message-ID: <b9d50890-4a37-447d-98b0-c6224736056c@suse.de>
Date: Mon, 8 Jan 2024 10:03:33 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arch/x86: Do not include <asm/bootparam.h> in
 several files
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bhelgaas@google.com, arnd@arndb.de, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, javierm@redhat.com, linux-arch@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20240104095421.12772-1-tzimmermann@suse.de>
 <20240104095421.12772-5-tzimmermann@suse.de>
 <CAMj1kXHEJubE42e6cUiEUv=Z66d9Gqw0EM7Wts9hrHzf8ZDsGQ@mail.gmail.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <CAMj1kXHEJubE42e6cUiEUv=Z66d9Gqw0EM7Wts9hrHzf8ZDsGQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kNV6ARZhHSS66wSY9odTDMEn"
X-Spam-Level: ***
X-Spam-Level: 
X-Spam-Score: 0.60
X-Rspamd-Queue-Id: 42EF321DAE
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Bnb7nZ39;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aFBb7mVt
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.60 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 HAS_ATTACHMENT(0.00)[];
	 MIME_BASE64_TEXT_BOGUS(1.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLfgmttzabnpkr34rizty4fwu5)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MIME_BASE64_TEXT(0.10)[];
	 MX_GOOD(-0.01)[];
	 SIGNED_PGP(-2.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[21];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linutronix.de,redhat.com,alien8.de,linux.intel.com,kernel.org,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from]

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------kNV6ARZhHSS66wSY9odTDMEn
Content-Type: multipart/mixed; boundary="------------7ZhY8LWZRgWQhQgpITPi8D2o";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bhelgaas@google.com, arnd@arndb.de, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, javierm@redhat.com, linux-arch@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org
Message-ID: <b9d50890-4a37-447d-98b0-c6224736056c@suse.de>
Subject: Re: [PATCH v3 4/4] arch/x86: Do not include <asm/bootparam.h> in
 several files
References: <20240104095421.12772-1-tzimmermann@suse.de>
 <20240104095421.12772-5-tzimmermann@suse.de>
 <CAMj1kXHEJubE42e6cUiEUv=Z66d9Gqw0EM7Wts9hrHzf8ZDsGQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHEJubE42e6cUiEUv=Z66d9Gqw0EM7Wts9hrHzf8ZDsGQ@mail.gmail.com>

--------------7ZhY8LWZRgWQhQgpITPi8D2o
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDQuMDEuMjQgdW0gMTc6NTEgc2NocmllYiBBcmQgQmllc2hldXZlbDoNCj4g
T24gVGh1LCA0IEphbiAyMDI0IGF0IDEwOjU0LCBUaG9tYXMgWmltbWVybWFubiA8dHppbW1l
cm1hbm5Ac3VzZS5kZT4gd3JvdGU6DQo+Pg0KPj4gUmVtb3ZlIHRoZSBpbmNsdWRlIHN0YXRl
bWVudCBmb3IgPGFzbS9ib290cGFyYW0uaD4gZnJvbSBzZXZlcmFsIGZpbGVzDQo+PiB0aGF0
IGRvbid0IHJlcXVpcmUgaXQuIExpbWl0cyB0aGUgZXhwb3N1cmUgb2YgdGhlIGJvb3QgcGFy
YW1ldGVycw0KPj4gd2l0aGluIHRoZSBMaW51eCBrZXJuZWwgY29kZS4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4+
IEFja2VkLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPg0KPj4NCj4+IC0t
LQ0KPj4NCj4+IHYzOg0KPj4gICAgICAgICAgKiByZXZlcnQgb2YgZTgyMC90eXBlcy5oIHJl
cXVpcmVkDQo+PiB2MjoNCj4+ICAgICAgICAgICogY2xlYW4gdXAgbWlzYy5oIGFuZCBlODIw
L3R5cGVzLmgNCj4+ICAgICAgICAgICogaW5jbHVkZSBib290cGFyYW0uaCBpbiBzZXZlcmFs
IHNvdXJjZSBmaWxlcw0KPj4gLS0tDQo+PiAgIGFyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9h
Y3BpLmMgICAgICAgfCAyICsrDQo+PiAgIGFyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9jbWRs
aW5lLmMgICAgfCAyICsrDQo+PiAgIGFyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9lZmkuYyAg
ICAgICAgfCAyICsrDQo+PiAgIGFyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9taXNjLmggICAg
ICAgfCAzICsrLQ0KPj4gICBhcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvcGd0YWJsZV82NC5j
IHwgMSArDQo+PiAgIGFyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9zZXYuYyAgICAgICAgfCAx
ICsNCj4+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20va2V4ZWMuaCAgICAgICAgICB8IDEgLQ0K
Pj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5oICAgIHwgMiArLQ0KPj4g
ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZXYuaCAgICAgICAgICAgIHwgMyArKy0NCj4+ICAg
YXJjaC94ODYvaW5jbHVkZS9hc20veDg2X2luaXQuaCAgICAgICB8IDIgLS0NCj4+ICAgYXJj
aC94ODYva2VybmVsL2NyYXNoLmMgICAgICAgICAgICAgICB8IDEgKw0KPj4gICBhcmNoL3g4
Ni9rZXJuZWwvc2V2LXNoYXJlZC5jICAgICAgICAgIHwgMiArKw0KPj4gICBhcmNoL3g4Ni9w
bGF0Zm9ybS9wdmgvZW5saWdodGVuLmMgICAgIHwgMSArDQo+PiAgIGFyY2gveDg2L3hlbi9l
bmxpZ2h0ZW5fcHZoLmMgICAgICAgICAgfCAxICsNCj4+ICAgYXJjaC94ODYveGVuL3ZnYS5j
ICAgICAgICAgICAgICAgICAgICB8IDEgLQ0KPj4gICAxNSBmaWxlcyBjaGFuZ2VkLCAxOCBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9ib290L2NvbXByZXNzZWQvYWNwaS5jIGIvYXJjaC94ODYvYm9vdC9jb21wcmVzc2Vk
L2FjcGkuYw0KPj4gaW5kZXggMThkMTVkMWNlODdkLi5mMTk2YjFkMWRkZjggMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvYWNwaS5jDQo+PiArKysgYi9hcmNo
L3g4Ni9ib290L2NvbXByZXNzZWQvYWNwaS5jDQo+PiBAQCAtNSw2ICs1LDggQEANCj4+ICAg
I2luY2x1ZGUgIi4uL3N0cmluZy5oIg0KPj4gICAjaW5jbHVkZSAiZWZpLmgiDQo+Pg0KPj4g
KyNpbmNsdWRlIDxhc20vYm9vdHBhcmFtLmg+DQo+PiArDQo+PiAgICNpbmNsdWRlIDxsaW51
eC9udW1hLmg+DQo+Pg0KPj4gICAvKg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Jvb3Qv
Y29tcHJlc3NlZC9jbWRsaW5lLmMgYi9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvY21kbGlu
ZS5jDQo+PiBpbmRleCBjMWJiMTgwOTczZWEuLmUxNjJkN2Y1OWNjNSAxMDA2NDQNCj4+IC0t
LSBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9jbWRsaW5lLmMNCj4+ICsrKyBiL2FyY2gv
eDg2L2Jvb3QvY29tcHJlc3NlZC9jbWRsaW5lLmMNCj4+IEBAIC0xLDYgKzEsOCBAQA0KPj4g
ICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4gICAjaW5jbHVkZSAi
bWlzYy5oIg0KPj4NCj4+ICsjaW5jbHVkZSA8YXNtL2Jvb3RwYXJhbS5oPg0KPj4gKw0KPj4g
ICBzdGF0aWMgdW5zaWduZWQgbG9uZyBmczsNCj4+ICAgc3RhdGljIGlubGluZSB2b2lkIHNl
dF9mcyh1bnNpZ25lZCBsb25nIHNlZykNCj4+ICAgew0KPj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2Jvb3QvY29tcHJlc3NlZC9lZmkuYyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9l
ZmkuYw0KPj4gaW5kZXggNmVkZDAzNGIwYjMwLi5mMmU1MGY5NzU4ZTYgMTAwNjQ0DQo+PiAt
LS0gYS9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvZWZpLmMNCj4+ICsrKyBiL2FyY2gveDg2
L2Jvb3QvY29tcHJlc3NlZC9lZmkuYw0KPj4gQEAgLTcsNiArNyw4IEBADQo+Pg0KPj4gICAj
aW5jbHVkZSAibWlzYy5oIg0KPj4NCj4+ICsjaW5jbHVkZSA8YXNtL2Jvb3RwYXJhbS5oPg0K
Pj4gKw0KPj4gICAvKioNCj4+ICAgICogZWZpX2dldF90eXBlIC0gR2l2ZW4gYSBwb2ludGVy
IHRvIGJvb3RfcGFyYW1zLCBkZXRlcm1pbmUgdGhlIHR5cGUgb2YgRUZJIGVudmlyb25tZW50
Lg0KPj4gICAgKg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9t
aXNjLmggYi9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvbWlzYy5oDQo+PiBpbmRleCBjMGQ1
MDJiZDg3MTYuLjAxYzg5YzQxMGVmZCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2Jvb3Qv
Y29tcHJlc3NlZC9taXNjLmgNCj4+ICsrKyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9t
aXNjLmgNCj4+IEBAIC0zMyw3ICszMyw2IEBADQo+PiAgICNpbmNsdWRlIDxsaW51eC9lbGYu
aD4NCj4+ICAgI2luY2x1ZGUgPGFzbS9wYWdlLmg+DQo+PiAgICNpbmNsdWRlIDxhc20vYm9v
dC5oPg0KPj4gLSNpbmNsdWRlIDxhc20vYm9vdHBhcmFtLmg+DQo+PiAgICNpbmNsdWRlIDxh
c20vZGVzY19kZWZzLmg+DQo+Pg0KPj4gICAjaW5jbHVkZSAidGR4LmgiDQo+PiBAQCAtNTMs
NiArNTIsOCBAQA0KPj4gICAjZGVmaW5lIG1lbXB0ciB1bnNpZ25lZA0KPj4gICAjZW5kaWYN
Cj4+DQo+PiArc3RydWN0IGJvb3RfcGFyYW07DQo+PiArDQo+IA0KPiBUeXBvPw0KDQpJbmRl
ZWQNCg0KPiANCj4gSW50ZXJlc3RpbmdseSwgaXQgc3RpbGwgYnVpbGRzIGZpbmUgZm9yIG1l
IHdpdGhvdXQgYW55IHdhcm5pbmdzLg0KPiANCj4gDQo+PiAgIC8qIGJvb3QvY29tcHJlc3Nl
ZC92bWxpbnV4IHN0YXJ0IGFuZCBlbmQgbWFya2VycyAqLw0KPj4gICBleHRlcm4gY2hhciBf
aGVhZFtdLCBfZW5kW107DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Jvb3QvY29t
cHJlc3NlZC9wZ3RhYmxlXzY0LmMgYi9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvcGd0YWJs
ZV82NC5jDQo+PiBpbmRleCA1MWY5NTdiMjRiYTcuLmM4ODJlMWY2N2FmMCAxMDA2NDQNCj4+
IC0tLSBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9wZ3RhYmxlXzY0LmMNCj4+ICsrKyBi
L2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9wZ3RhYmxlXzY0LmMNCj4+IEBAIC0xLDUgKzEs
NiBAQA0KPj4gICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4gICAj
aW5jbHVkZSAibWlzYy5oIg0KPj4gKyNpbmNsdWRlIDxhc20vYm9vdHBhcmFtLmg+DQo+PiAg
ICNpbmNsdWRlIDxhc20vZTgyMC90eXBlcy5oPg0KPj4gICAjaW5jbHVkZSA8YXNtL3Byb2Nl
c3Nvci5oPg0KPj4gICAjaW5jbHVkZSAicGd0YWJsZS5oIg0KPj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2Jvb3QvY29tcHJlc3NlZC9zZXYuYyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3Nl
ZC9zZXYuYw0KPj4gaW5kZXggNDU0YWNkN2EyZGFmLi4xM2JlYWU3NjdlNDggMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvc2V2LmMNCj4+ICsrKyBiL2FyY2gv
eDg2L2Jvb3QvY29tcHJlc3NlZC9zZXYuYw0KPj4gQEAgLTEyLDYgKzEyLDcgQEANCj4+ICAg
ICovDQo+PiAgICNpbmNsdWRlICJtaXNjLmgiDQo+Pg0KPj4gKyNpbmNsdWRlIDxhc20vYm9v
dHBhcmFtLmg+DQo+PiAgICNpbmNsdWRlIDxhc20vcGd0YWJsZV90eXBlcy5oPg0KPj4gICAj
aW5jbHVkZSA8YXNtL3Nldi5oPg0KPj4gICAjaW5jbHVkZSA8YXNtL3RyYXBuci5oPg0KPj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2tleGVjLmggYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9rZXhlYy5oDQo+PiBpbmRleCBjOWY2YTZjNWRlM2MuLjkxY2E5YTllZTNh
MiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2tleGVjLmgNCj4+ICsr
KyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2tleGVjLmgNCj4+IEBAIC0yNSw3ICsyNSw2IEBA
DQo+Pg0KPj4gICAjaW5jbHVkZSA8YXNtL3BhZ2UuaD4NCj4+ICAgI2luY2x1ZGUgPGFzbS9w
dHJhY2UuaD4NCj4+IC0jaW5jbHVkZSA8YXNtL2Jvb3RwYXJhbS5oPg0KPj4NCj4+ICAgc3Ry
dWN0IGtpbWFnZTsNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
bWVtX2VuY3J5cHQuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21lbV9lbmNyeXB0LmgNCj4+
IGluZGV4IDM1OWFkYTQ4NmZhOS4uYzFhOGEzNDA4YzE4IDEwMDY0NA0KPj4gLS0tIGEvYXJj
aC94ODYvaW5jbHVkZS9hc20vbWVtX2VuY3J5cHQuaA0KPj4gKysrIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vbWVtX2VuY3J5cHQuaA0KPj4gQEAgLTE1LDcgKzE1LDcgQEANCj4+ICAgI2lu
Y2x1ZGUgPGxpbnV4L2luaXQuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L2NjX3BsYXRmb3Jt
Lmg+DQo+Pg0KPj4gLSNpbmNsdWRlIDxhc20vYm9vdHBhcmFtLmg+DQo+PiArc3RydWN0IGJv
b3RfcGFyYW1zOw0KPj4NCj4gDQo+IFVuZm9ydHVuYXRlbHksIHRoZSBTRVYvU05QIGNvZGUg
aXMgYSBiaXQgb2YgYSBrbHVkZ2UgZ2l2ZW4gdGhhdCBpdA0KPiBkZWNsYXJlcyByb3V0aW5l
cyBpbiBoZWFkZXJzIHVuZGVyIGFyY2gveDg2L2luY2x1ZGUvYXNtLCBhbmQgZGVmaW5lcw0K
PiB0aGVtIGluIHR3byBkaWZmZXJlbnQgcGxhY2VzICh0aGUgZGVjb21wcmVzc29yIGFuZCB0
aGUga2VybmVsIHByb3BlcikuDQo+IA0KPiBTbyB3aGlsZSBJIGZlZWwgdGhhdCB3ZSBzaG91
bGQgYXZvaWQgcmVseWluZyBvbiBpbmNvbXBsZXRlIHN0cnVjdA0KPiBkZWZpbml0aW9ucywg
dGhpcyBvbmUgKGFuZCB0aGUgb25lIGJlbG93KSBzZWVtcyBmaW5lIHRvIG1lIGZvciBub3cu
DQo+IElmL3doZW4gc29tZW9uZSBnZXRzIGFyb3VuZCB0byBjbGVhbmluZyB1cCB0aGUgU0VW
L1NOUCBoZWFkZXIgZmlsZXMsDQo+IHRvIHNwbGl0IHRoZSBpbml0IGNvZGUgZnJvbSB0aGUg
bW9yZSB3aWRlbHkgdXNlZCBtbSB0eXBlcyBldGMsIHdlIGNhbg0KPiByZXZpc2l0IHRoaXMu
DQoNClRoYW5rcw0KDQo+IA0KPiANCj4+ICAgI2lmZGVmIENPTkZJR19YODZfTUVNX0VOQ1JZ
UFQNCj4+ICAgdm9pZCBfX2luaXQgbWVtX2VuY3J5cHRfaW5pdCh2b2lkKTsNCj4+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZXYuaCBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3Nldi5oDQo+PiBpbmRleCA1YjRhMWNlM2QzNjguLjhkYWQ4YjE2MTNiZiAxMDA2NDQN
Cj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Nldi5oDQo+PiArKysgYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9zZXYuaA0KPj4gQEAgLTEzLDcgKzEzLDYgQEANCj4+DQo+PiAgICNp
bmNsdWRlIDxhc20vaW5zbi5oPg0KPj4gICAjaW5jbHVkZSA8YXNtL3Nldi1jb21tb24uaD4N
Cj4+IC0jaW5jbHVkZSA8YXNtL2Jvb3RwYXJhbS5oPg0KPj4gICAjaW5jbHVkZSA8YXNtL2Nv
Y28uaD4NCj4+DQo+PiAgICNkZWZpbmUgR0hDQl9QUk9UT0NPTF9NSU4gICAgICAxVUxMDQo+
PiBAQCAtMjIsNiArMjEsOCBAQA0KPj4NCj4+ICAgI2RlZmluZSAgICAgICAgVk1HRVhJVCgp
ICAgICAgICAgICAgICAgICAgICAgICB7IGFzbSB2b2xhdGlsZSgicmVwOyB2bW1jYWxsXG5c
ciIpOyB9DQo+Pg0KPj4gK3N0cnVjdCBib290X3BhcmFtczsNCj4+ICsNCj4+ICAgZW51bSBl
c19yZXN1bHQgew0KPj4gICAgICAgICAgRVNfT0ssICAgICAgICAgICAgICAgICAgLyogQWxs
IGdvb2QgKi8NCj4+ICAgICAgICAgIEVTX1VOU1VQUE9SVEVELCAgICAgICAgIC8qIFJlcXVl
c3RlZCBvcGVyYXRpb24gbm90IHN1cHBvcnRlZCAqLw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3g4Nl9pbml0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS94ODZf
aW5pdC5oDQo+PiBpbmRleCBjODc4NjE2YTE4YjguLmYwNjI3MTU1NzhhMCAxMDA2NDQNCj4+
IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3g4Nl9pbml0LmgNCj4+ICsrKyBiL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3g4Nl9pbml0LmgNCj4+IEBAIC0yLDggKzIsNiBAQA0KPj4gICAj
aWZuZGVmIF9BU01fWDg2X1BMQVRGT1JNX0gNCj4+ICAgI2RlZmluZSBfQVNNX1g4Nl9QTEFU
Rk9STV9IDQo+Pg0KPj4gLSNpbmNsdWRlIDxhc20vYm9vdHBhcmFtLmg+DQo+PiAtDQo+PiAg
IHN0cnVjdCBnaGNiOw0KPj4gICBzdHJ1Y3QgbXBjX2J1czsNCj4+ICAgc3RydWN0IG1wY19j
cHU7DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NyYXNoLmMgYi9hcmNoL3g4
Ni9rZXJuZWwvY3Jhc2guYw0KPj4gaW5kZXggYzkyZDg4NjgwZGJmLi41NjRjZmY3ZWQzM2Eg
MTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYw0KPj4gKysrIGIvYXJj
aC94ODYva2VybmVsL2NyYXNoLmMNCj4+IEBAIC0yNiw2ICsyNiw3IEBADQo+PiAgICNpbmNs
dWRlIDxsaW51eC92bWFsbG9jLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9tZW1ibG9jay5o
Pg0KPj4NCj4+ICsjaW5jbHVkZSA8YXNtL2Jvb3RwYXJhbS5oPg0KPj4gICAjaW5jbHVkZSA8
YXNtL3Byb2Nlc3Nvci5oPg0KPj4gICAjaW5jbHVkZSA8YXNtL2hhcmRpcnEuaD4NCj4+ICAg
I2luY2x1ZGUgPGFzbS9ubWkuaD4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwv
c2V2LXNoYXJlZC5jIGIvYXJjaC94ODYva2VybmVsL3Nldi1zaGFyZWQuYw0KPj4gaW5kZXgg
Y2NiMDkxNWU4NGUxLi40OTYyZWM0MmRjNjggMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9r
ZXJuZWwvc2V2LXNoYXJlZC5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvc2V2LXNoYXJl
ZC5jDQo+PiBAQCAtOSw2ICs5LDggQEANCj4+ICAgICogYW5kIGlzIGluY2x1ZGVkIGRpcmVj
dGx5IGludG8gYm90aCBjb2RlLWJhc2VzLg0KPj4gICAgKi8NCj4+DQo+PiArI2luY2x1ZGUg
PGFzbS9zZXR1cF9kYXRhLmg+DQo+PiArDQo+PiAgICNpZm5kZWYgX19CT09UX0NPTVBSRVNT
RUQNCj4+ICAgI2RlZmluZSBlcnJvcih2KSAgICAgICBwcl9lcnIodikNCj4+ICAgI2RlZmlu
ZSBoYXNfY3B1ZmxhZyhmKSBib290X2NwdV9oYXMoZikNCj4+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9wbGF0Zm9ybS9wdmgvZW5saWdodGVuLmMgYi9hcmNoL3g4Ni9wbGF0Zm9ybS9wdmgv
ZW5saWdodGVuLmMNCj4+IGluZGV4IDAwYTkyY2IyYzgxNC4uOTQ0ZTAyOTBmMmMwIDEwMDY0
NA0KPj4gLS0tIGEvYXJjaC94ODYvcGxhdGZvcm0vcHZoL2VubGlnaHRlbi5jDQo+PiArKysg
Yi9hcmNoL3g4Ni9wbGF0Zm9ybS9wdmgvZW5saWdodGVuLmMNCj4+IEBAIC0zLDYgKzMsNyBA
QA0KPj4NCj4+ICAgI2luY2x1ZGUgPHhlbi9odmMtY29uc29sZS5oPg0KPj4NCj4+ICsjaW5j
bHVkZSA8YXNtL2Jvb3RwYXJhbS5oPg0KPj4gICAjaW5jbHVkZSA8YXNtL2lvX2FwaWMuaD4N
Cj4+ICAgI2luY2x1ZGUgPGFzbS9oeXBlcnZpc29yLmg+DQo+PiAgICNpbmNsdWRlIDxhc20v
ZTgyMC9hcGkuaD4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2
aC5jIGIvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdmguYw0KPj4gaW5kZXggYWRhMzg2OGMw
MmMyLi45ZTlkYjYwMWJkNTIgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni94ZW4vZW5saWdo
dGVuX3B2aC5jDQo+PiArKysgYi9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2aC5jDQo+PiBA
QCAtNCw2ICs0LDcgQEANCj4+DQo+PiAgICNpbmNsdWRlIDx4ZW4vaHZjLWNvbnNvbGUuaD4N
Cj4+DQo+PiArI2luY2x1ZGUgPGFzbS9ib290cGFyYW0uaD4NCj4+ICAgI2luY2x1ZGUgPGFz
bS9pb19hcGljLmg+DQo+PiAgICNpbmNsdWRlIDxhc20vaHlwZXJ2aXNvci5oPg0KPj4gICAj
aW5jbHVkZSA8YXNtL2U4MjAvYXBpLmg+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVu
L3ZnYS5jIGIvYXJjaC94ODYveGVuL3ZnYS5jDQo+PiBpbmRleCBkOTdhZGFiODQyMGYuLmY3
NTQ3ODA3YjBiZCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L3hlbi92Z2EuYw0KPj4gKysr
IGIvYXJjaC94ODYveGVuL3ZnYS5jDQo+PiBAQCAtMiw3ICsyLDYgQEANCj4+ICAgI2luY2x1
ZGUgPGxpbnV4L3NjcmVlbl9pbmZvLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+
DQo+Pg0KPj4gLSNpbmNsdWRlIDxhc20vYm9vdHBhcmFtLmg+DQo+PiAgICNpbmNsdWRlIDxh
c20vc2V0dXAuaD4NCj4+DQo+PiAgICNpbmNsdWRlIDx4ZW4vaW50ZXJmYWNlL3hlbi5oPg0K
Pj4gLS0NCj4+IDIuNDMuMA0KPj4NCj4+DQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdy
YXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1h
bnkgR21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2LCA5MDQ2MSBOdWVybmJlcmcsIEdlcm1hbnkN
CkdGOiBJdm8gVG90ZXYsIEFuZHJldyBNeWVycywgQW5kcmV3IE1jRG9uYWxkLCBCb3VkaWVu
IE1vZXJtYW4NCkhSQiAzNjgwOSAoQUcgTnVlcm5iZXJnKQ0K

--------------7ZhY8LWZRgWQhQgpITPi8D2o--

--------------kNV6ARZhHSS66wSY9odTDMEn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmWbumUFAwAAAAAACgkQlh/E3EQov+Cm
rg/+KYja1FtkL75NuMzQLF0Xlw5db303pOTqmV93upgXTwrdj2rh25R/WehqyTVPHRTkpCaVRp8C
DoMyWa4VvkjTG9zIYlfOyynnYVM3eDFt4P3jk06M1bPZZPaaeUAGJxisvB8dKs60LgQ1gFU+GJTI
2xPunkkuZpK9Km/XGRvFOEQdjbdWjsyRHJGpgZs8IAHfBmpMgm1jV9GkkqGQruBQkqFlnj16j3dv
UaLPB9BUvBiVQoFrz106tfpPOswC15JxnDKHQELEHkhHC/jgY38vyn+CfQlNV9l5Y+TWdLCoG08Z
sS1dJqCnAnTuIceGHKVBMW38jrpJbJOiMhO4sUQ3jU2OQYpIMyjaiv093N1SUUiHr6Ax2zh9xifs
1KpORqDslk0HjKYzxjvxbf89CYqJnDpQ4raRrEANst7jd9ecSWF0WqpwkaeDym2hvouYF3Q6zAAb
Ji7sh+j+Q7TQ+SoeLx++naXR7RxhJ2nwmMo0cEjNpzMbXJFffk/7QowZqwynyJtBh4X/Js42lZJ1
E82wWqUSC4m+QJqHOVW73gfDRGojC+1ah09pvJYSIXcg1QNwzwVOx9C/b51Q9398jknTswKmr6Bx
XIFW2y+lDYGM1uz1X8jTyNiPl8cPXiY+5nD0uLZ3zpLTQvmXcwdf1Nueq66hwsNlqHtCxIQ7o3/t
X74=
=SYGO
-----END PGP SIGNATURE-----

--------------kNV6ARZhHSS66wSY9odTDMEn--

