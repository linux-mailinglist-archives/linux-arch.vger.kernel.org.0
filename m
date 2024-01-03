Return-Path: <linux-arch+bounces-1241-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EFD822EDD
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 14:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70421F2430E
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9840719BAF;
	Wed,  3 Jan 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DJbpP4Eq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CJOTcYTz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DJbpP4Eq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CJOTcYTz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA31A58F;
	Wed,  3 Jan 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 925C01FD14;
	Wed,  3 Jan 2024 13:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704289529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bgQCk8Sslen0nkUdO/qZVSvfT4I9jShiXNrvVGeXa9M=;
	b=DJbpP4EqYmK4CXcGCjMjaAZ/2jA7xNKV+g2grHwvkr28/rqmYGYsa1afDFe8LJ4jjxELEF
	8tYhkTQgK75itnRNUVPor17OI43K1x6vUZxMyiUdojF5cuzBwmdG5fQUvfMTKNnTbjWcb3
	YgGbLXem/TiBHYaHzcloMqpVsgkRYbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704289529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bgQCk8Sslen0nkUdO/qZVSvfT4I9jShiXNrvVGeXa9M=;
	b=CJOTcYTzohMX8JAiGL0smr1Wap7hV/YUB6qKQTPuCV8pVKHCW7swoje0dvZZW15p6RPxWN
	IMvzQ809bL7Wn8AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704289529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bgQCk8Sslen0nkUdO/qZVSvfT4I9jShiXNrvVGeXa9M=;
	b=DJbpP4EqYmK4CXcGCjMjaAZ/2jA7xNKV+g2grHwvkr28/rqmYGYsa1afDFe8LJ4jjxELEF
	8tYhkTQgK75itnRNUVPor17OI43K1x6vUZxMyiUdojF5cuzBwmdG5fQUvfMTKNnTbjWcb3
	YgGbLXem/TiBHYaHzcloMqpVsgkRYbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704289529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bgQCk8Sslen0nkUdO/qZVSvfT4I9jShiXNrvVGeXa9M=;
	b=CJOTcYTzohMX8JAiGL0smr1Wap7hV/YUB6qKQTPuCV8pVKHCW7swoje0dvZZW15p6RPxWN
	IMvzQ809bL7Wn8AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B1661398A;
	Wed,  3 Jan 2024 13:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kpBrBflklWWTOwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 03 Jan 2024 13:45:29 +0000
Message-ID: <71c8ef97-5824-4f82-8fc1-d0bb2bc8cc03@suse.de>
Date: Wed, 3 Jan 2024 14:45:28 +0100
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
 <97f118fc-b38f-4bcc-83d3-4d3c13edf7a0@suse.de>
 <CAMj1kXF-1TXYzheS-e_rGKnV+6FrkZe+e2sfCixyUzxSQE7X6w@mail.gmail.com>
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
In-Reply-To: <CAMj1kXF-1TXYzheS-e_rGKnV+6FrkZe+e2sfCixyUzxSQE7X6w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6umUVFPDXnGuJS7l4lIsgHjM"
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 HAS_ATTACHMENT(0.00)[];
	 MIME_BASE64_TEXT_BOGUS(1.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLfgmttzabnpkr34rizty4fwu5)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MIME_BASE64_TEXT(0.10)[];
	 MX_GOOD(-0.01)[];
	 SIGNED_PGP(-2.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[21];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linutronix.de,redhat.com,alien8.de,linux.intel.com,kernel.org,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DJbpP4Eq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CJOTcYTz
X-Spam-Score: -6.30
X-Rspamd-Queue-Id: 925C01FD14

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6umUVFPDXnGuJS7l4lIsgHjM
Content-Type: multipart/mixed; boundary="------------vMFpz67OQkoWFvlbOHg0VJ77";
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
Message-ID: <71c8ef97-5824-4f82-8fc1-d0bb2bc8cc03@suse.de>
Subject: Re: [PATCH v2 2/3] arch/x86: Add <asm/ima-efi.h> for
 arch_ima_efi_boot_mode
References: <20231215122614.5481-1-tzimmermann@suse.de>
 <20231215122614.5481-3-tzimmermann@suse.de>
 <CAMj1kXHrn-PxpMGnR4VoHv7kHvQYyf8SS9i1irm9Gi_uBseciw@mail.gmail.com>
 <97f118fc-b38f-4bcc-83d3-4d3c13edf7a0@suse.de>
 <CAMj1kXF-1TXYzheS-e_rGKnV+6FrkZe+e2sfCixyUzxSQE7X6w@mail.gmail.com>
In-Reply-To: <CAMj1kXF-1TXYzheS-e_rGKnV+6FrkZe+e2sfCixyUzxSQE7X6w@mail.gmail.com>

--------------vMFpz67OQkoWFvlbOHg0VJ77
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDMuMDEuMjQgdW0gMTQ6MTEgc2NocmllYiBBcmQgQmllc2hldXZlbDoNCj4g
T24gVHVlLCAyIEphbiAyMDI0IGF0IDE1OjA3LCBUaG9tYXMgWmltbWVybWFubiA8dHppbW1l
cm1hbm5Ac3VzZS5kZT4gd3JvdGU6DQo+Pg0KPj4gSGlpIEFyZA0KPj4NCj4+IEFtIDE5LjEy
LjIzIHVtIDEyOjM4IHNjaHJpZWIgQXJkIEJpZXNoZXV2ZWw6DQo+Pj4gSGkgVGhvbWFzLA0K
Pj4+DQo+Pj4gT24gRnJpLCAxNSBEZWMgMjAyMyBhdCAxMzoyNiwgVGhvbWFzIFppbW1lcm1h
bm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+IHdyb3RlOg0KPj4+Pg0KPj4+PiBUaGUgaGVhZGVy
IGZpbGUgPGFzbS9lZmkuaD4gY29udGFpbnMgdGhlIG1hY3JvIGFyY2hfaW1hX2VmaV9ib290
X21vZGUsDQo+Pj4+IHdoaWNoIGV4cGFuZHMgdG8gdXNlIHN0cnVjdCBib290X3BhcmFtcyBm
cm9tIDxhc20vYm9vdHBhcmFtcy5oPi4gTWFueQ0KPj4+PiBkcml2ZXJzIGluY2x1ZGUgPGxp
bnV4L2VmaS5oPiwgYnV0IGRvIG5vdCB1c2UgYm9vdCBwYXJhbWV0ZXJzLiBDaGFuZ2VzDQo+
Pj4+IHRvIGJvb3RwYXJhbS5oIG9yIGl0cyBpbmNsdWRlZCBoZWFkZXJzIGNhbiBlYXNpbHkg
dHJpZ2dlciBsYXJnZSwNCj4+Pj4gdW5uZXNzYXJ5IHJlYnVpbGRzIG9mIHRoZSBrZXJuZWwu
DQo+Pj4+DQo+Pj4+IE1vdmluZyB4ODYncyBhcmNoX2ltYV9lZmlfYm9vdF9tb2RlIHRvIDxh
c20vaW1hLWVmaS5oPiBhbmQgaW5jbHVkaW5nDQo+Pj4+IDxhc20vc2V0dXAuaD4gc2VwYXJh
dGVzIHRoYXQgZGVwZW5kZW5jeSBmcm9tIHRoZSByZXN0IG9mIHRoZSBFRkkNCj4+Pj4gaW50
ZXJmYWNlcy4gVGhlIG9ubHkgdXNlciBpcyBpbiBpbWFfZWZpLmMuIEFzIHRoZSBmaWxlIGFs
cmVhZHkgZGVjbGFyZXMNCj4+Pj4gYSBkZWZhdWx0IHZhbHVlIGZvciBhcmNoX2ltYV9lZmlf
Ym9vdF9tb2RlLCBtb3ZlIHRoaXMgZGVmaW5lIGludG8NCj4+Pj4gYXNtLWdlbmVyaWMgZm9y
IGFsbCBvdGhlciBhcmNoaXRlY3R1cmVzLg0KPj4+Pg0KPj4+PiBXaXRoIGFyY2hfaW1hX2Vm
aV9ib290X21vZGUgcmVtb3ZlZCBmcm9tIGVmaS5oLCA8YXNtL2Jvb3RwYXJhbS5oPiBjYW4N
Cj4+Pj4gbGF0ZXIgYmUgcmVtb3ZlZCBmcm9tIGZ1cnRoZXIgeDg2IGhlYWRlciBmaWxlcy4N
Cj4+Pj4NCj4+Pg0KPj4+IEFwb2xvZ2llcyBpZiBJIG1pc3NlZCB0aGlzIGluIHYxIGJ1dCBp
cyB0aGUgbmV3IGFzbS1nZW5lcmljIGhlYWRlcg0KPj4+IHJlYWxseSBuZWNlc3Nhcnk/IENv
dWxkIHdlIGluc3RlYWQgdHVybiBhcmNoX2ltYV9lZmlfYm9vdF9tb2RlIGludG8gYQ0KPj4+
IGZ1bmN0aW9uIHRoYXQgaXMgYSBzdGF0aWMgaW5saW5lIHsgcmV0dXJuIHVuc2V0OyB9IGJ5
IGRlZmF1bHQsIGJ1dCBjYW4NCj4+PiBiZSBlbWl0dGVkIG91dCBvZiBsaW5lIGluIG9uZSBv
ZiB0aGUgeDg2L3BsYXRmb3JtL2VmaS5jIHNvdXJjZSBmaWxlcywNCj4+PiB3aGVyZSByZWZl
cnJpbmcgdG8gYm9vdF9wYXJhbXMgaXMgZmluZT8NCj4+DQo+PiBJIGNhbm5vdCBmaWd1cmUg
b3V0IGhvdyB0byBkbyB0aGlzIHdpdGhvdXQgKnNvbWV0aGluZyogaW4gYXNtLWdlbmVyaWMg
b3INCj4+IGFkZGluZyBpZi1DT05GSUdfWDg2IGd1YXJkcyBpbiBpbWEtZWZpLmMuDQo+Pg0K
Pj4gQnV0IEkgbm90aWNlZCB0aGF0IGxpbnV4L2VmaS5oIGFscmVhZHkgY29udGFpbnMgMiBv
ciAzIGlmZGVmIGJyYW5jaGVzDQo+PiBmb3IgeDg2LiBXb3VsZCBpdCBiZSBhbiBvcHRpb24g
dG8gbW92ZSB0aGlzIGNvZGUgaW50byBhc20vZWZpLmgNCj4+IChpbmNsdWRpbmcgYSBoZWFk
ZXIgZmlsZSBpbiBhc20tZ2VuZXJpYyBmb3IgdGhlIG5vbi14ODYgdmFyaWFudHMpIGFuZA0K
Pj4gYWRkIHRoZSBhcmNoX2ltYV9lZmlfYm9vdF9tb2RlKCkgaGVscGVyIHRoZXJlIGFzIHdl
bGw/ICBBdCBsZWFzdCB0aGF0DQo+PiB3b3VsZG4ndCBiZSBhIGhlYWRlciBmb3Igb25seSBh
IHNpbmdsZSBkZWZpbmUuDQo+Pg0KPiANCj4gQ291bGQgd2UganVzdCBtb3ZlIHRoZSB4ODYg
aW1wbGVtZW50YXRpb24gb3V0IG9mIGxpbmU/DQo+IA0KPiBTbyBzb21ldGhpbmcgbGlrZSB0
aGlzIGluIGFyY2gveDg2L2luY2x1ZGUvYXNtL2VmaS5oDQo+IA0KPiBlbnVtIGVmaV9zZWN1
cmVib290X21vZGUgeDg2X2ltYV9lZmlfYm9vdF9tb2RlKHZvaWQpOw0KPiAjZGVmaW5lIGFy
Y2hfaW1hX2VmaV9ib290X21vZGUgeDg2X2ltYV9lZmlfYm9vdF9tb2RlKCkNCj4gDQo+IGFu
ZCBhbiBpbXBsZW1lbnRhdGlvbiBpbiBvbmUgb2YgdGhlIHJlbGF0ZWQgLmMgZmlsZXM6DQo+
IA0KPiBlbnVtIGVmaV9zZWN1cmVib290X21vZGUgeDg2X2ltYV9lZmlfYm9vdF9tb2RlKHZv
aWQpDQo+IHsNCj4gICAgICByZXR1cm4gYm9vdF9wYXJhbXMuc2VjdXJlX2Jvb3Q7DQo+IH0N
Cj4gDQo+ID8NCg0KV2VsbCwgdGhhdCdzIGp1c3QgZW5vdWdoIHRvIGF2b2lkIGJvb3RfcGFy
YW1zIHdpdGhpbiB0aGUgaGVhZGVyIGZpbGUuIA0KQnV0IGl0IHNob3VsZCB3b3JrLg0KDQpC
ZXN0IHJlZ2FyZHMNClRob21hcw0KDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBo
aWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkg
R21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2LCA5MDQ2MSBOdWVybmJlcmcsIEdlcm1hbnkNCkdG
OiBJdm8gVG90ZXYsIEFuZHJldyBNeWVycywgQW5kcmV3IE1jRG9uYWxkLCBCb3VkaWVuIE1v
ZXJtYW4NCkhSQiAzNjgwOSAoQUcgTnVlcm5iZXJnKQ0K

--------------vMFpz67OQkoWFvlbOHg0VJ77--

--------------6umUVFPDXnGuJS7l4lIsgHjM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmWVZPgFAwAAAAAACgkQlh/E3EQov+AJ
vw//VaeSm+zaQNIXBXqsae3NByomZpBCTYc8YDAWvyw9l/Y/cvW6RarDmsIHZS0GfAwO0olM4JQP
rPG/BZ837MZ/AJI+/Qmmjv7vN/E4C0dlPPDqdwRZGKINvwo3GD/SFIby5Y3hZio+0iYDHgrq+p2F
VBbEbwQ8ElHZXT1E+QYuBfegwJPIzj5v8PywdZnhAn77zm2Aq8wFdtmsy1wvKNuKBQRBVGndYagT
qBW5mfe20cCPlHKIsIeeMEqSmCC5ZtNxXKEnM+2gJtVb/HMtdv1wFQDT+cFk7y2UtcP0Clm0ahyA
eOqE0N/skrLzd9B7PwThmiarLKBglT3Nlgbm2+tmDjeZSVu0kWVVEKVs2zIQtuLweioPtOZZSbie
Yh2SfTdBsqiNyFHrJcISd+bsZD02dR0fICV1y1LV531z+FHFBUadMbqI485QwIox5V6rqdcImpcE
mryhogZBeoJ+4c1NTdaSJQT0Sd6YKeubICdsrTrdfIudd3vw1d0koQLdo2epll68vSXZKdiYa6Lz
+gk5h4NaRNeCg8GmA4uWzorVGo7labuky60yjLobCpMBxyNnvgMBeub2A1fiZaZp3k+2uMlMQaee
fs1ZihVC1oCNZGZ9jfWP/UVatIPNbYUtAIW9couGWO1lLIEA720o624V2QBI0qDRK8Ntkz9bTCVd
pBg=
=Nnki
-----END PGP SIGNATURE-----

--------------6umUVFPDXnGuJS7l4lIsgHjM--

