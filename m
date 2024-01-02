Return-Path: <linux-arch+bounces-1231-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE9A821D5F
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 15:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D421F22CC2
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 14:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806B31078F;
	Tue,  2 Jan 2024 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F6WKApO+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+9dAoq18";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F6WKApO+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+9dAoq18"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB510A08;
	Tue,  2 Jan 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 783D421CD5;
	Tue,  2 Jan 2024 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704204431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2pKW3MOvzlLddZ8wgZpZ0Qkpaa3ApoAPPuTxT5p1ZAQ=;
	b=F6WKApO+r2ZU30ximQyD5FQDaNAaX0li7FenxLAj3qwi7rwrUT6vbfe7wGfApwPKjvxnVR
	Xx4X0u3N2isHL3J6/iZCFMX6NngL0byNjeuZE5AFPbvEKCjJqUI+7eDJRrjCIsKtVP7tHN
	7Zc1ZPD0Aav+YmDTQZ232m6KNTCdP58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704204431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2pKW3MOvzlLddZ8wgZpZ0Qkpaa3ApoAPPuTxT5p1ZAQ=;
	b=+9dAoq18ms6dYGA0+pQrqGAVAdmP0l/DayAjXcTwFRmYSauYC5JqR+Sm5mUbdVClGbRW55
	Ugp4ITda/Zat79Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704204431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2pKW3MOvzlLddZ8wgZpZ0Qkpaa3ApoAPPuTxT5p1ZAQ=;
	b=F6WKApO+r2ZU30ximQyD5FQDaNAaX0li7FenxLAj3qwi7rwrUT6vbfe7wGfApwPKjvxnVR
	Xx4X0u3N2isHL3J6/iZCFMX6NngL0byNjeuZE5AFPbvEKCjJqUI+7eDJRrjCIsKtVP7tHN
	7Zc1ZPD0Aav+YmDTQZ232m6KNTCdP58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704204431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2pKW3MOvzlLddZ8wgZpZ0Qkpaa3ApoAPPuTxT5p1ZAQ=;
	b=+9dAoq18ms6dYGA0+pQrqGAVAdmP0l/DayAjXcTwFRmYSauYC5JqR+Sm5mUbdVClGbRW55
	Ugp4ITda/Zat79Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBA181340C;
	Tue,  2 Jan 2024 14:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WBk7OI4YlGUHWwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 02 Jan 2024 14:07:10 +0000
Message-ID: <97f118fc-b38f-4bcc-83d3-4d3c13edf7a0@suse.de>
Date: Tue, 2 Jan 2024 15:07:10 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arch/x86: Add <asm/ima-efi.h> for
 arch_ima_efi_boot_mode
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
References: <20231215122614.5481-1-tzimmermann@suse.de>
 <20231215122614.5481-3-tzimmermann@suse.de>
 <CAMj1kXHrn-PxpMGnR4VoHv7kHvQYyf8SS9i1irm9Gi_uBseciw@mail.gmail.com>
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
In-Reply-To: <CAMj1kXHrn-PxpMGnR4VoHv7kHvQYyf8SS9i1irm9Gi_uBseciw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------V1rJHPDmuLABI0b4MEA4rKIk"
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.79
X-Spamd-Result: default: False [-3.79 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 HAS_ATTACHMENT(0.00)[];
	 MIME_BASE64_TEXT_BOGUS(1.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLf6fmkuiuubj71hj5sz5bt3qt)];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
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
--------------V1rJHPDmuLABI0b4MEA4rKIk
Content-Type: multipart/mixed; boundary="------------he60F04tXY0KIGYaLWTuKqnB";
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
Message-ID: <97f118fc-b38f-4bcc-83d3-4d3c13edf7a0@suse.de>
Subject: Re: [PATCH v2 2/3] arch/x86: Add <asm/ima-efi.h> for
 arch_ima_efi_boot_mode
References: <20231215122614.5481-1-tzimmermann@suse.de>
 <20231215122614.5481-3-tzimmermann@suse.de>
 <CAMj1kXHrn-PxpMGnR4VoHv7kHvQYyf8SS9i1irm9Gi_uBseciw@mail.gmail.com>
In-Reply-To: <CAMj1kXHrn-PxpMGnR4VoHv7kHvQYyf8SS9i1irm9Gi_uBseciw@mail.gmail.com>

--------------he60F04tXY0KIGYaLWTuKqnB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGlpIEFyZA0KDQpBbSAxOS4xMi4yMyB1bSAxMjozOCBzY2hyaWViIEFyZCBCaWVzaGV1dmVs
Og0KPiBIaSBUaG9tYXMsDQo+IA0KPiBPbiBGcmksIDE1IERlYyAyMDIzIGF0IDEzOjI2LCBU
aG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4gd3JvdGU6DQo+Pg0KPj4g
VGhlIGhlYWRlciBmaWxlIDxhc20vZWZpLmg+IGNvbnRhaW5zIHRoZSBtYWNybyBhcmNoX2lt
YV9lZmlfYm9vdF9tb2RlLA0KPj4gd2hpY2ggZXhwYW5kcyB0byB1c2Ugc3RydWN0IGJvb3Rf
cGFyYW1zIGZyb20gPGFzbS9ib290cGFyYW1zLmg+LiBNYW55DQo+PiBkcml2ZXJzIGluY2x1
ZGUgPGxpbnV4L2VmaS5oPiwgYnV0IGRvIG5vdCB1c2UgYm9vdCBwYXJhbWV0ZXJzLiBDaGFu
Z2VzDQo+PiB0byBib290cGFyYW0uaCBvciBpdHMgaW5jbHVkZWQgaGVhZGVycyBjYW4gZWFz
aWx5IHRyaWdnZXIgbGFyZ2UsDQo+PiB1bm5lc3NhcnkgcmVidWlsZHMgb2YgdGhlIGtlcm5l
bC4NCj4+DQo+PiBNb3ZpbmcgeDg2J3MgYXJjaF9pbWFfZWZpX2Jvb3RfbW9kZSB0byA8YXNt
L2ltYS1lZmkuaD4gYW5kIGluY2x1ZGluZw0KPj4gPGFzbS9zZXR1cC5oPiBzZXBhcmF0ZXMg
dGhhdCBkZXBlbmRlbmN5IGZyb20gdGhlIHJlc3Qgb2YgdGhlIEVGSQ0KPj4gaW50ZXJmYWNl
cy4gVGhlIG9ubHkgdXNlciBpcyBpbiBpbWFfZWZpLmMuIEFzIHRoZSBmaWxlIGFscmVhZHkg
ZGVjbGFyZXMNCj4+IGEgZGVmYXVsdCB2YWx1ZSBmb3IgYXJjaF9pbWFfZWZpX2Jvb3RfbW9k
ZSwgbW92ZSB0aGlzIGRlZmluZSBpbnRvDQo+PiBhc20tZ2VuZXJpYyBmb3IgYWxsIG90aGVy
IGFyY2hpdGVjdHVyZXMuDQo+Pg0KPj4gV2l0aCBhcmNoX2ltYV9lZmlfYm9vdF9tb2RlIHJl
bW92ZWQgZnJvbSBlZmkuaCwgPGFzbS9ib290cGFyYW0uaD4gY2FuDQo+PiBsYXRlciBiZSBy
ZW1vdmVkIGZyb20gZnVydGhlciB4ODYgaGVhZGVyIGZpbGVzLg0KPj4NCj4gDQo+IEFwb2xv
Z2llcyBpZiBJIG1pc3NlZCB0aGlzIGluIHYxIGJ1dCBpcyB0aGUgbmV3IGFzbS1nZW5lcmlj
IGhlYWRlcg0KPiByZWFsbHkgbmVjZXNzYXJ5PyBDb3VsZCB3ZSBpbnN0ZWFkIHR1cm4gYXJj
aF9pbWFfZWZpX2Jvb3RfbW9kZSBpbnRvIGENCj4gZnVuY3Rpb24gdGhhdCBpcyBhIHN0YXRp
YyBpbmxpbmUgeyByZXR1cm4gdW5zZXQ7IH0gYnkgZGVmYXVsdCwgYnV0IGNhbg0KPiBiZSBl
bWl0dGVkIG91dCBvZiBsaW5lIGluIG9uZSBvZiB0aGUgeDg2L3BsYXRmb3JtL2VmaS5jIHNv
dXJjZSBmaWxlcywNCj4gd2hlcmUgcmVmZXJyaW5nIHRvIGJvb3RfcGFyYW1zIGlzIGZpbmU/
DQoNCkkgY2Fubm90IGZpZ3VyZSBvdXQgaG93IHRvIGRvIHRoaXMgd2l0aG91dCAqc29tZXRo
aW5nKiBpbiBhc20tZ2VuZXJpYyBvciANCmFkZGluZyBpZi1DT05GSUdfWDg2IGd1YXJkcyBp
biBpbWEtZWZpLmMuDQoNCkJ1dCBJIG5vdGljZWQgdGhhdCBsaW51eC9lZmkuaCBhbHJlYWR5
IGNvbnRhaW5zIDIgb3IgMyBpZmRlZiBicmFuY2hlcyANCmZvciB4ODYuIFdvdWxkIGl0IGJl
IGFuIG9wdGlvbiB0byBtb3ZlIHRoaXMgY29kZSBpbnRvIGFzbS9lZmkuaCANCihpbmNsdWRp
bmcgYSBoZWFkZXIgZmlsZSBpbiBhc20tZ2VuZXJpYyBmb3IgdGhlIG5vbi14ODYgdmFyaWFu
dHMpIGFuZCANCmFkZCB0aGUgYXJjaF9pbWFfZWZpX2Jvb3RfbW9kZSgpIGhlbHBlciB0aGVy
ZSBhcyB3ZWxsPyAgQXQgbGVhc3QgdGhhdCANCndvdWxkbid0IGJlIGEgaGVhZGVyIGZvciBv
bmx5IGEgc2luZ2xlIGRlZmluZS4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KPiANCj4g
DQo+IA0KPiANCj4gDQo+PiB2MjoNCj4+ICAgICAgICAgICogcmVtb3ZlIGV4dHJhIGRlY2xh
cmF0aW9uIG9mIGJvb3RfcGFyYW1zIChBcmQpDQo+Pg0KPiANCj4gUGxlYXNlIGRvbid0IHB1
dCB0aGUgcmV2aXNpb24gbG9nIGhlcmUsIGJ1dCBiZWxvdyB0aGUgLS0tIHNvIHRoYXQgJ2dp
dA0KPiBhbScgd2lsbCBpZ25vcmUgaXQuDQo+IA0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IFRo
b21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KPj4gLS0tDQo+PiAgIGFy
Y2gveDg2L2luY2x1ZGUvYXNtL2VmaS5oICAgICAgIHwgIDMgLS0tDQo+PiAgIGFyY2gveDg2
L2luY2x1ZGUvYXNtL2ltYS1lZmkuaCAgIHwgMTEgKysrKysrKysrKysNCj4+ICAgaW5jbHVk
ZS9hc20tZ2VuZXJpYy9LYnVpbGQgICAgICAgfCAgMSArDQo+PiAgIGluY2x1ZGUvYXNtLWdl
bmVyaWMvaW1hLWVmaS5oICAgIHwgMTYgKysrKysrKysrKysrKysrKw0KPj4gICBzZWN1cml0
eS9pbnRlZ3JpdHkvaW1hL2ltYV9lZmkuYyB8ICA1ICstLS0tDQo+PiAgIDUgZmlsZXMgY2hh
bmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGFyY2gveDg2L2luY2x1ZGUvYXNtL2ltYS1lZmkuaA0KPj4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgaW5jbHVkZS9hc20tZ2VuZXJpYy9pbWEtZWZpLmgNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZWZpLmggYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9lZmkuaA0KPj4gaW5kZXggYzQ1NTViMjY5YTFiLi45OWYzMTE3NmM4OTIgMTAwNjQ0
DQo+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9lZmkuaA0KPj4gKysrIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vZWZpLmgNCj4+IEBAIC00MTgsOSArNDE4LDYgQEAgZXh0ZXJuIGlu
dCBfX2luaXQgZWZpX21lbW1hcF9zcGxpdF9jb3VudChlZmlfbWVtb3J5X2Rlc2NfdCAqbWQs
DQo+PiAgIGV4dGVybiB2b2lkIF9faW5pdCBlZmlfbWVtbWFwX2luc2VydChzdHJ1Y3QgZWZp
X21lbW9yeV9tYXAgKm9sZF9tZW1tYXAsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZvaWQgKmJ1Ziwgc3RydWN0IGVmaV9tZW1fcmFuZ2UgKm1lbSk7DQo+
Pg0KPj4gLSNkZWZpbmUgYXJjaF9pbWFfZWZpX2Jvb3RfbW9kZSBcDQo+PiAtICAgICAgICh7
IGV4dGVybiBzdHJ1Y3QgYm9vdF9wYXJhbXMgYm9vdF9wYXJhbXM7IGJvb3RfcGFyYW1zLnNl
Y3VyZV9ib290OyB9KQ0KPj4gLQ0KPj4gICAjaWZkZWYgQ09ORklHX0VGSV9SVU5USU1FX01B
UA0KPj4gICBpbnQgZWZpX2dldF9ydW50aW1lX21hcF9zaXplKHZvaWQpOw0KPj4gICBpbnQg
ZWZpX2dldF9ydW50aW1lX21hcF9kZXNjX3NpemUodm9pZCk7DQo+PiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvaW5jbHVkZS9hc20vaW1hLWVmaS5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
aW1hLWVmaS5oDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAw
MDAwLi5iNGQ5MDRlNjZiMzkNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2ltYS1lZmkuaA0KPj4gQEAgLTAsMCArMSwxMSBAQA0KPj4gKy8qIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQo+PiArI2lmbmRlZiBfQVNNX1g4
Nl9JTUFfRUZJX0gNCj4+ICsjZGVmaW5lIF9BU01fWDg2X0lNQV9FRklfSA0KPj4gKw0KPj4g
KyNpbmNsdWRlIDxhc20vc2V0dXAuaD4NCj4+ICsNCj4+ICsjZGVmaW5lIGFyY2hfaW1hX2Vm
aV9ib290X21vZGUgYm9vdF9wYXJhbXMuc2VjdXJlX2Jvb3QNCj4+ICsNCj4+ICsjaW5jbHVk
ZSA8YXNtLWdlbmVyaWMvaW1hLWVmaS5oPg0KPj4gKw0KPj4gKyNlbmRpZiAvKiBfQVNNX1g4
Nl9JTUFfRUZJX0ggKi8NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1nZW5lcmljL0ti
dWlsZCBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvS2J1aWxkDQo+PiBpbmRleCBkZWYyNDI1Mjhi
MWQuLjRmZDE2ZTcxZThjZCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMv
S2J1aWxkDQo+PiArKysgYi9pbmNsdWRlL2FzbS1nZW5lcmljL0tidWlsZA0KPj4gQEAgLTI2
LDYgKzI2LDcgQEAgbWFuZGF0b3J5LXkgKz0gZnRyYWNlLmgNCj4+ICAgbWFuZGF0b3J5LXkg
Kz0gZnV0ZXguaA0KPj4gICBtYW5kYXRvcnkteSArPSBoYXJkaXJxLmgNCj4+ICAgbWFuZGF0
b3J5LXkgKz0gaHdfaXJxLmgNCj4+ICttYW5kYXRvcnkteSArPSBpbWEtZWZpLmgNCj4+ICAg
bWFuZGF0b3J5LXkgKz0gaW8uaA0KPj4gICBtYW5kYXRvcnkteSArPSBpcnEuaA0KPj4gICBt
YW5kYXRvcnkteSArPSBpcnFfcmVncy5oDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20t
Z2VuZXJpYy9pbWEtZWZpLmggYi9pbmNsdWRlL2FzbS1nZW5lcmljL2ltYS1lZmkuaA0KPj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZjg3ZjVlZGVm
NDQwDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9pbmNsdWRlL2FzbS1nZW5lcmljL2lt
YS1lZmkuaA0KPj4gQEAgLTAsMCArMSwxNiBAQA0KPj4gKy8qIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wKyAqLw0KPj4gKw0KPj4gKyNpZm5kZWYgX19BU01fR0VORVJJQ19J
TUFfRUZJX0hfDQo+PiArI2RlZmluZSBfX0FTTV9HRU5FUklDX0lNQV9FRklfSF8NCj4+ICsN
Cj4+ICsjaW5jbHVkZSA8bGludXgvZWZpLmg+DQo+PiArDQo+PiArLyoNCj4+ICsgKiBPbmx5
IGluY2x1ZGUgdGhpcyBoZWFkZXIgZmlsZSBmcm9tIHlvdXIgYXJjaGl0ZWN0dXJlJ3MgPGFz
bS9pbWEtZWZpLmg+Lg0KPj4gKyAqLw0KPj4gKw0KPj4gKyNpZm5kZWYgYXJjaF9pbWFfZWZp
X2Jvb3RfbW9kZQ0KPj4gKyNkZWZpbmUgYXJjaF9pbWFfZWZpX2Jvb3RfbW9kZSBlZmlfc2Vj
dXJlYm9vdF9tb2RlX3Vuc2V0DQo+PiArI2VuZGlmDQo+PiArDQo+PiArI2VuZGlmIC8qIF9f
QVNNX0dFTkVSSUNfRkJfSF8gKi8NCj4+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3Jp
dHkvaW1hL2ltYV9lZmkuYyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2VmaS5jDQo+
PiBpbmRleCAxMzgwMjliZmNjZTEuLjU2YmJlZTI3MWNlYyAxMDA2NDQNCj4+IC0tLSBhL3Nl
Y3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2VmaS5jDQo+PiArKysgYi9zZWN1cml0eS9pbnRl
Z3JpdHkvaW1hL2ltYV9lZmkuYw0KPj4gQEAgLTYsMTAgKzYsNyBAQA0KPj4gICAjaW5jbHVk
ZSA8bGludXgvbW9kdWxlLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9pbWEuaD4NCj4+ICAg
I2luY2x1ZGUgPGFzbS9lZmkuaD4NCj4+IC0NCj4+IC0jaWZuZGVmIGFyY2hfaW1hX2VmaV9i
b290X21vZGUNCj4+IC0jZGVmaW5lIGFyY2hfaW1hX2VmaV9ib290X21vZGUgZWZpX3NlY3Vy
ZWJvb3RfbW9kZV91bnNldA0KPj4gLSNlbmRpZg0KPj4gKyNpbmNsdWRlIDxhc20vaW1hLWVm
aS5oPg0KPj4NCj4+ICAgc3RhdGljIGVudW0gZWZpX3NlY3VyZWJvb3RfbW9kZSBnZXRfc2Jf
bW9kZSh2b2lkKQ0KPj4gICB7DQo+PiAtLQ0KPj4gMi40My4wDQo+Pg0KPj4NCg0KLS0gDQpU
aG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkwNDYx
IE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3IE15ZXJzLCBBbmRy
ZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChBRyBOdWVybmJlcmcp
DQo=

--------------he60F04tXY0KIGYaLWTuKqnB--

--------------V1rJHPDmuLABI0b4MEA4rKIk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmWUGI4FAwAAAAAACgkQlh/E3EQov+Dm
pA/+JRK9PXbdRtmUTfa/5uA51d+UH55VpdzEwG8LeCqSRLp2RZll0AWZe2ipcvVSlBrXJ5uVMNxY
Zf5loRJtJ5a5it0TW7Kjmt3247yGnmyt+jiEanStL7Cwr3ztqutyHGfLXxUl+bvpC9ZBMXDjDiIN
iZkyt7lztidvRZiAu6tg/1mJzQdmy4T5AM7mS9qi+0G8ch1BvH+fw0cBa0EZiWFn9s8AvFygLb0+
TJRVdTZ37Gin4d/nJLSfAHPzDyZ30GiBiU0vcVDe8CZjvmOSgaVto5hMXEfCfEF3Cej2/Kk+uc3E
Z/hs9WzltCXGvoHrsTVU+fIBfMr9ExP9QkE0MuCX/2GCrVlWrpyL6ddKBO5SmdS5mJDpkizUFgpq
yBPo4GP7jVgciwyglVIt1eDhmKNcrN35856BEoU9H18tiZHJX7uyolg6Lv6xHrDw0N8NwYouDgnT
3/bWGzCOUvdkEJ5YZvpjn7abqgiYEhATz9kSI3Ksh1b3eFwXycNgBoP1e7gO9mIUVhD1Ir1bl1HA
yJsQbWz/QXzFTW0S/LPIoRCVKSfHt13pGfVzQeN4bOk7JsauCAYtug/DA59LqeCui6t4o3vCvwef
K6izAD1yYcotl6pCExBLz3dlB8bBDRx8W+OYXkNk3+Jbtkj8mYT166XUx2+uXzDj5hwkffyNE51w
7KQ=
=+CAT
-----END PGP SIGNATURE-----

--------------V1rJHPDmuLABI0b4MEA4rKIk--

