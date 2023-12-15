Return-Path: <linux-arch+bounces-1075-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E74F8147CB
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 13:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0E11F2163C
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ADE28E3F;
	Fri, 15 Dec 2023 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i/pGtVXM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8tzYgFag";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G8FNUhEe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hLBRZVpu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492352C690;
	Fri, 15 Dec 2023 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E79661F830;
	Fri, 15 Dec 2023 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702642537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cXejokhcc/7TU0v1LC2IicSK5aHa5LG7r8uGMwm8VTE=;
	b=i/pGtVXM4d4SnE3SgHFUArpm+rtGlZ26YnyPQtMFy1LaQhM02RfnF/rs6WbDkFogXXdfu9
	ORyjz7b7vmVWAsZtF9x5ObguIJcM44/QO+nhRgzLbuQ5nZCMA8axUZ0teEHbfEukltqWi3
	s2v6YDhLl6xnXlfHCZAtE5dmDcRdgq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702642537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cXejokhcc/7TU0v1LC2IicSK5aHa5LG7r8uGMwm8VTE=;
	b=8tzYgFag98HDo3pfF3VUTzBh+0IZAcCsT9ap9e2x/DACr1WaqQ2lOeF/ueM1Wvf2FPYi5C
	h6vKIkwU4o8bPDBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702642536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cXejokhcc/7TU0v1LC2IicSK5aHa5LG7r8uGMwm8VTE=;
	b=G8FNUhEeSgvEauzOoI/2zkdAl74FgnKLfg/Wcvzj/WkeWeel+5DNu8YyFpgNz8jENWbKsB
	+B43gBbqGdg3Gjes4IfWPhDdLrb7DHNQnGVdy1COTo3XUk8AaFxZ76nO2frkbpTj44XUhY
	TYhOixFnES8X/F7Blv4qSPgYpMlf7w4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702642536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cXejokhcc/7TU0v1LC2IicSK5aHa5LG7r8uGMwm8VTE=;
	b=hLBRZVpu4v8TvSKSZsNwRDb/slCVm9MP87Xh7/JuCksgq5DuPG8bJm2BJMCG6HjCYqOEWn
	BgqbldYpt7VYtfCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7036113A08;
	Fri, 15 Dec 2023 12:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id zPlMGmhDfGV5RAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Fri, 15 Dec 2023 12:15:36 +0000
Message-ID: <3b1624a9-bdb7-4c7c-af32-42998051a333@suse.de>
Date: Fri, 15 Dec 2023 13:15:35 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arch/x86: Move struct pci_setup_rom into pci_setup.h
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
References: <20231206125433.18420-1-tzimmermann@suse.de>
 <20231206125433.18420-2-tzimmermann@suse.de>
 <CAMj1kXEOXh10v7dz-Y4hVM0y1VxR3YFxSxuE9a3wE0LbMsy2UA@mail.gmail.com>
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
In-Reply-To: <CAMj1kXEOXh10v7dz-Y4hVM0y1VxR3YFxSxuE9a3wE0LbMsy2UA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LFMG7Re4Q0h0pPw3uvd4K5PM"
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.59
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.79
X-Spamd-Result: default: False [-3.79 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 HAS_ATTACHMENT(0.00)[];
	 MIME_BASE64_TEXT_BOGUS(1.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLthqzz6q5hnubohss7ffybi86)];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MIME_BASE64_TEXT(0.10)[];
	 SIGNED_PGP(-2.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[21];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linutronix.de,redhat.com,alien8.de,linux.intel.com,kernel.org,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------LFMG7Re4Q0h0pPw3uvd4K5PM
Content-Type: multipart/mixed; boundary="------------4P5uPzLuQ9odS0SbJY4PGd3W";
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
Message-ID: <3b1624a9-bdb7-4c7c-af32-42998051a333@suse.de>
Subject: Re: [PATCH 1/3] arch/x86: Move struct pci_setup_rom into pci_setup.h
References: <20231206125433.18420-1-tzimmermann@suse.de>
 <20231206125433.18420-2-tzimmermann@suse.de>
 <CAMj1kXEOXh10v7dz-Y4hVM0y1VxR3YFxSxuE9a3wE0LbMsy2UA@mail.gmail.com>
In-Reply-To: <CAMj1kXEOXh10v7dz-Y4hVM0y1VxR3YFxSxuE9a3wE0LbMsy2UA@mail.gmail.com>

--------------4P5uPzLuQ9odS0SbJY4PGd3W
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQXJkDQoNCkFtIDA3LjEyLjIzIHVtIDE2OjM1IHNjaHJpZWIgQXJkIEJpZXNoZXV2ZWw6
DQo+IEhlbGxvIFRob21hcywNCj4gDQo+IE9uIFdlZCwgNiBEZWMgMjAyMyBhdCAxMzo1NCwg
VGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+IHdyb3RlOg0KPj4NCj4+
IFRoZSB0eXBlIGRlZmluaXRpb24gb2Ygc3RydWN0IHBjaV9zZXR1cF9yb20gaW4gPGFzbS9w
Y2kuaD4gcmVxdWlyZXMNCj4+IHN0cnVjdCBzZXR1cF9kYXRhIGZyb20gPGFzbS9ib290cGFy
YW0uaD4uIE1hbnkgZHJpdmVycyBpbmNsdWRlDQo+PiA8bGludXgvcGNpLmg+LCBidXQgZG8g
bm90IHVzZSBib290IHBhcmFtZXRlcnMuIENoYW5nZXMgdG8gYm9vdHBhcmFtLmgNCj4+IG9y
IGl0cyBpbmNsdWRlZCBoZWFkZXIgZmlsZXMgY291bGQgZWFzaWx5IHRyaWdnZXIgYSBsYXJn
ZSwgdW5uZWNlc3NhcnkNCj4+IHJlYnVpbGQgb2YgdGhlIGtlcm5lbC4NCj4+DQo+PiBNb3Zp
bmcgc3RydWN0IHBjaV9zZXR1cF9yb20gaW50byBpdHMgb3duIGhlYWRlciBmaWxlIGF2b2lk
IGluY2x1ZGluZw0KPj4gPGFzbS9ib290cGFyYW0uaD4gaW4gPGFzbS9wY2kuaD4uIFVwZGF0
ZSB0aGUgb25seSB0d28gdXNlcnMgb2YgdGhlDQo+PiBzdHJ1Y3QgaW4gdGhlIHg4NiBQQ0kg
Y29kZSBhbmQgaW4gdGhlIEVGSSBjb2RlLiBBbHNvIHJlbW92ZSB0aGUgaW5jbHVkZQ0KPj4g
c3RhdGVtZW50IGZvciB4ODZfaW5pdC5oLCB3aGljaCBpcyB1bm5lY2Vzc2FyeSBidXQgcHVs
bHMgaW4gYm9vdHBhcmFtcy5oLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBaaW1t
ZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KPj4gLS0tDQo+PiAgIGFyY2gveDg2L2lu
Y2x1ZGUvYXNtL3BjaS5oICAgICAgICAgICAgICB8IDEzIC0tLS0tLS0tLS0tLS0NCj4+ICAg
YXJjaC94ODYvaW5jbHVkZS9hc20vcGNpX3NldHVwLmggICAgICAgIHwgMTkgKysrKysrKysr
KysrKysrKysrKw0KPj4gICBhcmNoL3g4Ni9wY2kvY29tbW9uLmMgICAgICAgICAgICAgICAg
ICAgfCAgMSArDQo+PiAgIGRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIveDg2LXN0dWIu
YyB8ICAxICsNCj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxMyBk
ZWxldGlvbnMoLSkNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gveDg2L2luY2x1ZGUv
YXNtL3BjaV9zZXR1cC5oDQo+Pg0KPiANCj4gVGhhbmtzIGZvciBjbGVhbmluZyB0aGlzIHVw
Lg0KPiANCj4gV291bGQgaXQgYmUgbW9yZSBhcHByb3ByaWF0ZSB0byBtb3ZlIGFsbCBzZXR1
cF9kYXRhIHJlbGF0ZWQNCj4gZGVmaW5pdGlvbnMgaW50byBhIHNlcGFyYXRlIGhlYWRlciBl
bnRpcmVseT8NCj4gDQo+IC0gdGhlIFNFVFVQXyBkZWZpbmVzDQo+IC0gc3RydWN0IHNldHVw
X2RhdGENCj4gLSBzdHJ1Y3QgcGNpX3NldHVwX3JvbQ0KPiAtIHN0cnVjdCAgIGphaWxob3Vz
ZV9zZXR1cF9kYXRhDQo+IGV0YyBldGMNCj4gDQo+IHN0cnVjdCBzZXR1cF9oZWFkZXIgaGFz
IGEgc2V0dXBfZGF0YSBmaWVsZCB3aGljaCBpcyB0aGUgcm9vdCBvZiB0aGUNCj4gc2V0dXBf
ZGF0YSBsaW5rZWQgbGlzdCwgYnV0IGl0IGlzIHR5cGVkIGFzIF9fdTY0IHNvIGl0IGRvZXNu
J3QNCj4gYWN0dWFsbHkgbmVlZCB0byBrbm93IHRoZSByZWFsIHR5cGUgb2YgdGhlIGFzc29j
aWF0ZWQgc3RydWN0cy4NCj4gDQo+IFRoYXQgd2F5LCB5b3UgY2FuIGF2b2lkIGNyZWF0aW5n
IGEgc3BlY2lhbCBhc20vcGNpX3NldHVwLmggdGhhdCBvbmx5DQo+IGNvdmVycyB0aGlzIG9u
ZSBwYXJ0aWN1bGFyIGRlZmluaXRpb24uDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nLg0KDQpJ
J3ZlIG5vdyBtb3ZlZCBldmVyeXRoaW5nIGZyb20gPGFzbS9ib290cGFyYW0uaD4gZXhjZXB0
IHN0cnVjdCANCmJvb3RwYXJhbXMgaW50byBpdHMgb3duIGhlYWRlciBmaWxlIDxhc20vc2V0
dXBfZGF0YS5oPi4gc3RydWN0IA0KcGNpX3NldHVwX3JvbSByZW1haW5zIGluIHBjaS5oLiBB
bmQgbW9zdCBoZWFkZXJzIG5vdyBpbmNsdWRlIA0Kc2V0dXBfZGF0YS5oLCB3aGlsZSBhIGZl
dyBzb3VyY2UgZmlsZXMgc3RpbGwgcmVxdWlyZSBib290cGFyYW0uaC4gSSdsbCANCnNlbmQg
dGhpcyBvdXQgaW4gdGhlIG5leHQgaXRlcmF0aW9uLg0KDQpUaW1lIGZvciByZWNvbXBpbGlu
ZyBnb2VzIGRvd24gZnJvbSA1OCBzZWMgdG8gNTYgc2VjLiBJdCdzIG1vc3RseSBib3VuZCAN
CmJ5IHRoZSBsaW5rZXIgbm93Lg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KPiAN
Cj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGNpLmggYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9wY2kuaA0KPj4gaW5kZXggYjQwYzQ2MmI0YWYzLi5iM2FiODBh
MDMzNjUgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wY2kuaA0KPj4g
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcGNpLmgNCj4+IEBAIC0xMCw3ICsxMCw2IEBA
DQo+PiAgICNpbmNsdWRlIDxsaW51eC9udW1hLmg+DQo+PiAgICNpbmNsdWRlIDxhc20vaW8u
aD4NCj4+ICAgI2luY2x1ZGUgPGFzbS9tZW10eXBlLmg+DQo+PiAtI2luY2x1ZGUgPGFzbS94
ODZfaW5pdC5oPg0KPj4NCj4+ICAgc3RydWN0IHBjaV9zeXNkYXRhIHsNCj4+ICAgICAgICAg
IGludCAgICAgICAgICAgICBkb21haW47ICAgICAgICAgLyogUENJIGRvbWFpbiAqLw0KPj4g
QEAgLTEyNCwxNiArMTIzLDQgQEAgY3B1bWFza19vZl9wY2lidXMoY29uc3Qgc3RydWN0IHBj
aV9idXMgKmJ1cykNCj4+ICAgfQ0KPj4gICAjZW5kaWYNCj4+DQo+PiAtc3RydWN0IHBjaV9z
ZXR1cF9yb20gew0KPj4gLSAgICAgICBzdHJ1Y3Qgc2V0dXBfZGF0YSBkYXRhOw0KPj4gLSAg
ICAgICB1aW50MTZfdCB2ZW5kb3I7DQo+PiAtICAgICAgIHVpbnQxNl90IGRldmlkOw0KPj4g
LSAgICAgICB1aW50NjRfdCBwY2lsZW47DQo+PiAtICAgICAgIHVuc2lnbmVkIGxvbmcgc2Vn
bWVudDsNCj4+IC0gICAgICAgdW5zaWduZWQgbG9uZyBidXM7DQo+PiAtICAgICAgIHVuc2ln
bmVkIGxvbmcgZGV2aWNlOw0KPj4gLSAgICAgICB1bnNpZ25lZCBsb25nIGZ1bmN0aW9uOw0K
Pj4gLSAgICAgICB1aW50OF90IHJvbWRhdGFbXTsNCj4+IC19Ow0KPj4gLQ0KPj4gICAjZW5k
aWYgLyogX0FTTV9YODZfUENJX0ggKi8NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9wY2lfc2V0dXAuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BjaV9zZXR1cC5o
DQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5iNGIy
NDZlZjZmMmINCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3BjaV9zZXR1cC5oDQo+PiBAQCAtMCwwICsxLDE5IEBADQo+PiArLyogU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4+ICsjaWZuZGVmIF9BU01fWDg2X1BDSV9T
RVRVUF9IDQo+PiArI2RlZmluZSBfQVNNX1g4Nl9QQ0lfU0VUVVBfSA0KPj4gKw0KPj4gKyNp
bmNsdWRlIDxhc20vYm9vdHBhcmFtLmg+DQo+PiArDQo+PiArc3RydWN0IHBjaV9zZXR1cF9y
b20gew0KPj4gKyAgICAgICBzdHJ1Y3Qgc2V0dXBfZGF0YSBkYXRhOw0KPj4gKyAgICAgICB1
aW50MTZfdCB2ZW5kb3I7DQo+PiArICAgICAgIHVpbnQxNl90IGRldmlkOw0KPj4gKyAgICAg
ICB1aW50NjRfdCBwY2lsZW47DQo+PiArICAgICAgIHVuc2lnbmVkIGxvbmcgc2VnbWVudDsN
Cj4+ICsgICAgICAgdW5zaWduZWQgbG9uZyBidXM7DQo+PiArICAgICAgIHVuc2lnbmVkIGxv
bmcgZGV2aWNlOw0KPj4gKyAgICAgICB1bnNpZ25lZCBsb25nIGZ1bmN0aW9uOw0KPj4gKyAg
ICAgICB1aW50OF90IHJvbWRhdGFbXTsNCj4+ICt9Ow0KPj4gKw0KPj4gKyNlbmRpZiAvKiBf
QVNNX1g4Nl9QQ0lfU0VUVVBfSCAqLw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3BjaS9j
b21tb24uYyBiL2FyY2gveDg2L3BjaS9jb21tb24uYw0KPj4gaW5kZXggZGRiNzk4NjAzMjAx
Li5jNmNiYjkxODIxNjAgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9wY2kvY29tbW9uLmMN
Cj4+ICsrKyBiL2FyY2gveDg2L3BjaS9jb21tb24uYw0KPj4gQEAgLTE3LDYgKzE3LDcgQEAN
Cj4+ICAgI2luY2x1ZGUgPGFzbS9zZWdtZW50Lmg+DQo+PiAgICNpbmNsdWRlIDxhc20vaW8u
aD4NCj4+ICAgI2luY2x1ZGUgPGFzbS9zbXAuaD4NCj4+ICsjaW5jbHVkZSA8YXNtL3BjaV9z
ZXR1cC5oPg0KPj4gICAjaW5jbHVkZSA8YXNtL3BjaV94ODYuaD4NCj4+ICAgI2luY2x1ZGUg
PGFzbS9zZXR1cC5oPg0KPj4gICAjaW5jbHVkZSA8YXNtL2lycWRvbWFpbi5oPg0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIveDg2LXN0dWIuYyBiL2Ry
aXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIveDg2LXN0dWIuYw0KPj4gaW5kZXggMWJmZGFl
MzRkZjM5Li4wYzg3OGViZTUyNTcgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJl
L2VmaS9saWJzdHViL3g4Ni1zdHViLmMNCj4+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvZWZp
L2xpYnN0dWIveDg2LXN0dWIuYw0KPj4gQEAgLTE3LDYgKzE3LDcgQEANCj4+ICAgI2luY2x1
ZGUgPGFzbS9ib290Lmg+DQo+PiAgICNpbmNsdWRlIDxhc20va2FzbHIuaD4NCj4+ICAgI2lu
Y2x1ZGUgPGFzbS9zZXYuaD4NCj4+ICsjaW5jbHVkZSA8YXNtL3BjaV9zZXR1cC5oPg0KPj4N
Cj4+ICAgI2luY2x1ZGUgImVmaXN0dWIuaCINCj4+ICAgI2luY2x1ZGUgIng4Ni1zdHViLmgi
DQo+PiAtLQ0KPj4gMi40My4wDQo+Pg0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFw
aGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55
IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpH
RjogSXZvIFRvdGV2LCBBbmRyZXcgTXllcnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBN
b2VybWFuDQpIUkIgMzY4MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------4P5uPzLuQ9odS0SbJY4PGd3W--

--------------LFMG7Re4Q0h0pPw3uvd4K5PM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmV8Q2gFAwAAAAAACgkQlh/E3EQov+Aw
Sg/+NBNdbL6f//sRxclLSQYdr902Ouk7vUhVqSVeXwdyxTQ+B6LS0EAK022Ew9rjgPvcsLOZ5WQ1
Ua/DpCpvIpf8cRb12Pp7axfgEoXzdLkECwI+PlLPGFkkRZY0+Le6gpmTgxQzFT1uWYkav96V6xxj
j6ZHn8+FmKxP/GELe+VZrDHZpSoilqVG4lngCUGbzUlBXiyn/QO24amfUbwTw49ytfzxV8Zxe0fU
zkNMUVjL+ljmo/tnOwc4kuH1edoEwHxkL1E4FsP/GtYVNmaB49yEYinx8CKCW/PpIyQArFEsghrg
XT7Y+cGIoozDszsu69+cVjz3BJ19qppXWXuQNBlaeNeMYhIzY/WFLZiTY3S3Kgwr1STB8oaUxlzC
AA9v1HAP+Lf3L1usJrytx1qqZmFkiF4fBZ2EgFC9eVZWvf/FEbjqCcx3Pa8oaSMbVMCzMBQgHAjv
TVuMzkiOMSXy3AxWU3BdTvPI1LleINl3pgYCbkCpboDDBDBk8nGUmjeofj/o56w4xmfBsjtJJtRX
+6IMDz4wSDt0SF6fbY9w1UnqB13HdnqmBKfhFOBUJYQiasWONHtipyRY/P3bvfufdYXC9Bg/E0P3
SNRRfBrPS4Wf9xeqndxx9xIw/YiuhHYdMFWWwhxpvP25TVeUUgmoys41DClAsulNC8/uoM5CnOim
TXs=
=H34h
-----END PGP SIGNATURE-----

--------------LFMG7Re4Q0h0pPw3uvd4K5PM--

