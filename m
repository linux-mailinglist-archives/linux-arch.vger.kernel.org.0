Return-Path: <linux-arch+bounces-1368-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A874682D4CB
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 08:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09701C21212
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7475D4428;
	Mon, 15 Jan 2024 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="feAzD62b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0Sasfhgc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="feAzD62b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0Sasfhgc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C877489;
	Mon, 15 Jan 2024 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 414D521DA5;
	Mon, 15 Jan 2024 07:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705305527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dlZWexjBzPW5ooyCVz21kzNECq7VS7ZlJlher26Rd9w=;
	b=feAzD62byRHGPBeyynmUtivbLbhEq51ZKQMwxuULeHpZDXYqGCACyo/RHJGIUdy/KS6jzO
	qe0Phx/2d48EXVdJYLg31/vfqwOLMUVXXu1P6AnR4e2O758bzEbT01HtwFOU7ozLuQDwMh
	v5z2iPnpA5x89XFeVOyAOYMD8X8pUVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705305527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dlZWexjBzPW5ooyCVz21kzNECq7VS7ZlJlher26Rd9w=;
	b=0Sasfhgc4pB1FS0UTwd4a4cv/k5vjgrX6pJ1+YshAx7ToW8pPTmHNYx4zAylwd5PIoGehV
	2w+1YGsp79s7QKDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705305527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dlZWexjBzPW5ooyCVz21kzNECq7VS7ZlJlher26Rd9w=;
	b=feAzD62byRHGPBeyynmUtivbLbhEq51ZKQMwxuULeHpZDXYqGCACyo/RHJGIUdy/KS6jzO
	qe0Phx/2d48EXVdJYLg31/vfqwOLMUVXXu1P6AnR4e2O758bzEbT01HtwFOU7ozLuQDwMh
	v5z2iPnpA5x89XFeVOyAOYMD8X8pUVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705305527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dlZWexjBzPW5ooyCVz21kzNECq7VS7ZlJlher26Rd9w=;
	b=0Sasfhgc4pB1FS0UTwd4a4cv/k5vjgrX6pJ1+YshAx7ToW8pPTmHNYx4zAylwd5PIoGehV
	2w+1YGsp79s7QKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB46713712;
	Mon, 15 Jan 2024 07:58:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hr96KLblpGWGeQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 15 Jan 2024 07:58:46 +0000
Message-ID: <3e2f70ab-c4de-4fae-9365-4f6f77c847c5@suse.de>
Date: Mon, 15 Jan 2024 08:58:45 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] arch/x86: Remove unnecessary dependencies on
 bootparam.h
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: nathan@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bhelgaas@google.com, arnd@arndb.de, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, javierm@redhat.com, linux-arch@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20240112095000.8952-1-tzimmermann@suse.de>
 <CAMj1kXGxNTvCca+9TfUfvp06ppyD9XiyO59khYXg88VkyFm1rw@mail.gmail.com>
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
In-Reply-To: <CAMj1kXGxNTvCca+9TfUfvp06ppyD9XiyO59khYXg88VkyFm1rw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------SELvXPdRwuL855MvPw4WOkpW"
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=feAzD62b;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0Sasfhgc
X-Spamd-Result: default: False [-3.80 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
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
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 414D521DA5
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------SELvXPdRwuL855MvPw4WOkpW
Content-Type: multipart/mixed; boundary="------------M5SmtNFPrQKoNShNeu4RV0nF";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: nathan@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bhelgaas@google.com, arnd@arndb.de, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, javierm@redhat.com, linux-arch@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org
Message-ID: <3e2f70ab-c4de-4fae-9365-4f6f77c847c5@suse.de>
Subject: Re: [PATCH v5 0/4] arch/x86: Remove unnecessary dependencies on
 bootparam.h
References: <20240112095000.8952-1-tzimmermann@suse.de>
 <CAMj1kXGxNTvCca+9TfUfvp06ppyD9XiyO59khYXg88VkyFm1rw@mail.gmail.com>
In-Reply-To: <CAMj1kXGxNTvCca+9TfUfvp06ppyD9XiyO59khYXg88VkyFm1rw@mail.gmail.com>

--------------M5SmtNFPrQKoNShNeu4RV0nF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTIuMDEuMjQgdW0gMTg6Mjggc2NocmllYiBBcmQgQmllc2hldXZlbDoNCj4g
T24gRnJpLCAxMiBKYW4gMjAyNCBhdCAxMDo1MCwgVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1t
ZXJtYW5uQHN1c2UuZGU+IHdyb3RlOg0KPj4NCj4+IFJlZHVjZSBidWlsZCB0aW1lIGluIHNv
bWUgY2FzZXMgYnkgcmVtb3ZpbmcgdW5uZWNlc3NhcnkgaW5jbHVkZSBzdGF0ZW1lbnRzDQo+
PiBmb3IgPGFzbS9ib290cGFyYW0uaD4uIFJlb3JnYW5pemUgc29tZSBoZWFkZXIgZmlsZXMg
YWNjb3JkaW5nbHkuDQo+Pg0KPj4gV2hpbGUgd29ya2luZyBvbiB0aGUga2VybmVsJ3MgYm9v
dC11cCBncmFwaGljcywgSSBub3RpY2VkIHRoYXQgdG91Y2hpbmcNCj4+IGluY2x1ZGUvbGlu
dXgvc2NyZWVuX2luZm8uaCB0cmlnZ2VycyBhIGNvbXBsZXRlIHJlYnVpbGQgb2YgdGhlIGtl
cm5lbA0KPj4gb24geDg2LiBJdCB0dXJucyBvdXQgdGhhdCB0aGUgYXJjaGl0ZWN0dXJlJ3Mg
UENJIGFuZCBFRkkgaGVhZGVycyBpbmNsdWRlDQo+PiA8YXNtL2Jvb3RwYXJhbS5oPiwgd2hp
Y2ggZGVwZW5kcyBvbiA8bGludXgvc2NyZWVuX2luZm8uaD4uIEJ1dCBub25lIG9mDQo+PiB0
aGUgZHJpdmVycyBoYXZlIGFueSBidXNpbmVzcyB3aXRoIGJvb3QgcGFyYW1ldGVycyBvciB0
aGUgc2NyZWVuX2luZm8NCj4+IHN0YXRlLg0KPj4NCj4+IFRoZSBwYXRjaHNldCBtb3ZlcyBj
b2RlIGZyb20gYm9vdHBhcmFtLmggYW5kIGVmaS5oIGludG8gc2VwYXJhdGUgaGVhZGVyDQo+
PiBmaWxlcyBhbmQgcmVtb3ZlcyBvYnNvbGV0ZSBpbmNsdWRlIHN0YXRlbWVudHMgb24geDg2
LiBJIGRpZA0KPj4NCj4+ICAgIG1ha2UgYWxsbW9kY29uZmlnDQo+PiAgICBtYWtlIC1qMjgN
Cj4+ICAgIHRvdWNoIGluY2x1ZGUvbGludXgvc2NyZWVuX2luZm8uaA0KPj4gICAgdGltZSBt
YWtlIC1qMjgNCj4+DQo+PiB0byBtZWFzdXJlIHRoZSB0aW1lIGl0IHRha2VzIHRvIHJlYnVp
bGQuIFJlc3VsdHMgd2l0aG91dCB0aGUgcGF0Y2hzZXQNCj4+IGFyZSBhcm91bmQgMjAgbWlu
dXRlcy4NCj4+DQo+PiAgICByZWFsICAgIDIwbTQ2LDcwNXMNCj4+ICAgIHVzZXIgICAgMzU0
bTI5LDE2NnMNCj4+ICAgIHN5cyAgICAgMjhtMjcsMzU5cw0KPj4NCj4+IEFuZCB3aXRoIHRo
ZSBwYXRjaHNldCBhcHBsaWVkIGl0IGdvZXMgZG93biB0byBsZXNzIHRoYW4gb25lIG1pbnV0
ZS4NCj4+DQo+PiAgICByZWFsICAgIDBtNTYsNjQzcw0KPj4gICAgdXNlciAgICA0bTAsNjYx
cw0KPj4gICAgc3lzICAgICAwbTMyLDk1NnMNCj4+DQo+PiBUaGUgdGVzdCBzeXN0ZW0gaXMg
YW4gSW50ZWwgaTUtMTM1MDAuDQo+Pg0KPj4gdjU6DQo+PiAgICAgICAgICAqIHNpbGVuY2Ug
Y2xhbmcgd2FybmluZ3MgZm9yIHJlYWwtbW9kZSBjb2RlIChOYXRoYW4pDQo+PiAgICAgICAg
ICAqIHJldmVydCBib290L2NvbXByZXNzZWQvbWlzYy5oIChrZXJuZWwgdGVzdCByb2JvdCkN
Cj4+IHY0Og0KPj4gICAgICAgICAgKiBmaXggZndkIGRlY2xhcmF0aW9uIGluIGNvbXByZXNz
ZWQvbWlzYy5oIChBcmQpDQo+PiB2MzoNCj4+ICAgICAgICAgICoga2VlcCBzZXR1cF9oZWFk
ZXIgaW4gYm9vdHBhcmFtLmggKEFyZCkNCj4+ICAgICAgICAgICogaW1wbGVtZW50IGFyY2hf
aW1hX2VmaV9ib290X21vZGUoKSBpbiBzb3VyY2UgZmlsZSAoQXJkKQ0KPj4gdjI6DQo+PiAg
ICAgICAgICAqIG9ubHkga2VlcCBzdHJ1Y3QgYm9vdF9wYXJhbXMgaW4gYm9vdHBhcmFtLmgg
KEFyZCkNCj4+ICAgICAgICAgICogc2ltcGxpZnkgYXJjaF9pbWFfZWZpX2Jvb3RfbW9kZSBk
ZWZpbmUgKEFyZCkNCj4+ICAgICAgICAgICogdXBkYXRlZCBjb3ZlciBsZXR0ZXINCj4+DQo+
PiBUaG9tYXMgWmltbWVybWFubiAoNCk6DQo+PiAgICBhcmNoL3g4NjogTW92ZSBVQVBJIHNl
dHVwIHN0cnVjdHVyZXMgaW50byBzZXR1cF9kYXRhLmgNCj4+ICAgIGFyY2gveDg2OiBNb3Zl
IGludGVybmFsIHNldHVwX2RhdGEgc3RydWN0dXJlcyBpbnRvIHNldHVwX2RhdGEuaA0KPj4g
ICAgYXJjaC94ODY6IEltcGxlbWVudCBhcmNoX2ltYV9lZmlfYm9vdF9tb2RlKCkgaW4gc291
cmNlIGZpbGUNCj4+ICAgIGFyY2gveDg2OiBEbyBub3QgaW5jbHVkZSA8YXNtL2Jvb3RwYXJh
bS5oPiBpbiBzZXZlcmFsIGZpbGVzDQo+Pg0KPiANCj4gVGhpcyBsb29rcyBvayB0byBtZSwg
dGhhbmtzIGZvciBzdGlja2luZyB3aXRoIGl0Lg0KPiANCj4gRm9yIHRoZSBzZXJpZXMsDQo+
IA0KPiBSZXZpZXdlZC1ieTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCg0K
VGhhbmsgeW91IHNvIG11Y2guIENhbiB0aGlzIHNlcmllcyBnbyB0aHJvdWdoIHRoZSB4ODYg
dHJlZT8NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KLS0gDQpUaG9tYXMgWmltbWVybWFu
bg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMg
R2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkwNDYxIE51ZXJuYmVyZywgR2Vy
bWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3IE15ZXJzLCBBbmRyZXcgTWNEb25hbGQsIEJv
dWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChBRyBOdWVybmJlcmcpDQo=

--------------M5SmtNFPrQKoNShNeu4RV0nF--

--------------SELvXPdRwuL855MvPw4WOkpW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmWk5bYFAwAAAAAACgkQlh/E3EQov+CI
Jg/+JV+6b+UEvjyYpb9g6+0eMSqeUYO4xAmbmNI8tS+ILRWYjxPq1LS5jvrlnhDYEDEXcdmmzkKi
Mh3eN8Xrux4gT9oqrlG0WqtJGCPE3MKqBP7fUoXxmEj565EkFnjIW4TPsZn6M629fIV+a3XBX8Uu
glVRo4pyOSK8ARj15irdKzZV9FhVrar0bYMW1KG9+A08HLG8ohwf84l5SxaXwyqUaWki+q4pfdHT
8PQq6384lW9D0pfC9Qg6/XwxUrv+0F57SLaXFBXChIW3klHpYdjtCddkYjq+W3B1tWBBXyIe5aRE
y0uNX7lnl7acBru9rOhgVFsanhd9t8iaGTV5tcXs8UwY8XpaLnTuR4O1QkqrdcSubR4AQuoA5v03
TyVGhgFG2EHDih0xYY7j7DAl4RrvF/ew/GsA4AnNc+JUuMqfD7ySzsG12yqIMZWSObeWfbMlllFs
mnANJ0u7OyHo+di/QNKFjo5wd4tQaVVISJu0dA2ErABm6K5UujEaQSy3XyK2dwZNqlYPsj3onEtV
atT31xjMO9L8M4YimjRGKs1v0JNezTQ86OSp5AisoGvabGBAduwo5TBO1e163vZPvaTqz+u2zC0a
EVjMBqgKNj0LZy5rIuhQzV6tUAOImj9F1UYryUV75Yrlryh0jZ95cQT2XVhwOX1WvbE0N9P7vcJW
0Sg=
=h4X2
-----END PGP SIGNATURE-----

--------------SELvXPdRwuL855MvPw4WOkpW--

