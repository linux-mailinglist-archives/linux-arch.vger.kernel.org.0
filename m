Return-Path: <linux-arch+bounces-1076-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B078147D2
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 13:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81465285687
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772328DCF;
	Fri, 15 Dec 2023 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s0oD9i33";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uSq5ujeY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s0oD9i33";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uSq5ujeY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782762D78D;
	Fri, 15 Dec 2023 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C27C1F829;
	Fri, 15 Dec 2023 12:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702642588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RVUKgENLwsqLmnMHHfQXB4LaSi/Y0682T+goQKC13K0=;
	b=s0oD9i33XcFjZUUmVnnb+7R88iguc+jroXDD7jgn8igxoj/YAYpr2bxpwB1mbRawxe1SCn
	mixVjfB9mGVu+YW6h7TI/n5XAw3QhppqzWovJZLRhl1TKpqEMdTufFZ+E6Up/d+rIdefe1
	saa3mfTTnm81bWggwc1aUrhVFzQPK6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702642588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RVUKgENLwsqLmnMHHfQXB4LaSi/Y0682T+goQKC13K0=;
	b=uSq5ujeYOsb3LsWTT+nNeXkgdEn1bHMxZXDPKUPbKzEYSn1K3muZGJwHyGgRIqcKe4fmoV
	6rgFWK36+/YR5yAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702642588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RVUKgENLwsqLmnMHHfQXB4LaSi/Y0682T+goQKC13K0=;
	b=s0oD9i33XcFjZUUmVnnb+7R88iguc+jroXDD7jgn8igxoj/YAYpr2bxpwB1mbRawxe1SCn
	mixVjfB9mGVu+YW6h7TI/n5XAw3QhppqzWovJZLRhl1TKpqEMdTufFZ+E6Up/d+rIdefe1
	saa3mfTTnm81bWggwc1aUrhVFzQPK6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702642588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RVUKgENLwsqLmnMHHfQXB4LaSi/Y0682T+goQKC13K0=;
	b=uSq5ujeYOsb3LsWTT+nNeXkgdEn1bHMxZXDPKUPbKzEYSn1K3muZGJwHyGgRIqcKe4fmoV
	6rgFWK36+/YR5yAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DF24013A08;
	Fri, 15 Dec 2023 12:16:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aLYCNJtDfGV5RAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Fri, 15 Dec 2023 12:16:27 +0000
Message-ID: <220f5a93-5eed-4a1d-8c84-e8e09adef6cf@suse.de>
Date: Fri, 15 Dec 2023 13:16:27 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arch/x86: Add <asm/ima-efi.h> for
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
References: <20231206125433.18420-1-tzimmermann@suse.de>
 <20231206125433.18420-3-tzimmermann@suse.de>
 <CAMj1kXHq5CxdNei24MOnX_78h70bJQYd8HMQnT80DSqwZkFuSQ@mail.gmail.com>
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
In-Reply-To: <CAMj1kXHq5CxdNei24MOnX_78h70bJQYd8HMQnT80DSqwZkFuSQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5kvNB39zOiwhHSSfE35u3i3I"
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
--------------5kvNB39zOiwhHSSfE35u3i3I
Content-Type: multipart/mixed; boundary="------------A1oU9wEQFL0rLOQVB0f9J8Wj";
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
Message-ID: <220f5a93-5eed-4a1d-8c84-e8e09adef6cf@suse.de>
Subject: Re: [PATCH 2/3] arch/x86: Add <asm/ima-efi.h> for
 arch_ima_efi_boot_mode
References: <20231206125433.18420-1-tzimmermann@suse.de>
 <20231206125433.18420-3-tzimmermann@suse.de>
 <CAMj1kXHq5CxdNei24MOnX_78h70bJQYd8HMQnT80DSqwZkFuSQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHq5CxdNei24MOnX_78h70bJQYd8HMQnT80DSqwZkFuSQ@mail.gmail.com>

--------------A1oU9wEQFL0rLOQVB0f9J8Wj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDcuMTIuMjMgdW0gMTY6Mzcgc2NocmllYiBBcmQgQmllc2hldXZlbDoNCj4g
T24gV2VkLCA2IERlYyAyMDIzIGF0IDEzOjU0LCBUaG9tYXMgWmltbWVybWFubiA8dHppbW1l
cm1hbm5Ac3VzZS5kZT4gd3JvdGU6DQo+Pg0KPj4gVGhlIGhlYWRlciBmaWxlIDxhc20vZWZp
Lmg+IGNvbnRhaW5zIHRoZSBtYWNybyBhcmNoX2ltYV9lZmlfYm9vdF9tb2RlLA0KPj4gd2hp
Y2ggZXhwYW5kcyB0byB1c2Ugc3RydWN0IGJvb3RfcGFyYW1zIGZyb20gPGFzbS9ib290cGFy
YW1zLmg+LiBNYW55DQo+PiBkcml2ZXJzIGluY2x1ZGUgPGxpbnV4L2VmaS5oPiwgYnV0IGRv
IG5vdCB1c2UgYm9vdCBwYXJhbWV0ZXJzLiBDaGFuZ2VzDQo+PiB0byBib290cGFyYW0uaCBv
ciBpdHMgaW5jbHVkZWQgaGVhZGVycyBjYW4gZWFzaWx5IHRyaWdnZXIgbGFyZ2UsDQo+PiB1
bm5lc3NhcnkgcmVidWlsZHMgb2YgdGhlIGtlcm5lbC4NCj4+DQo+PiBNb3ZpbmcgeDg2J3Mg
YXJjaF9pbWFfZWZpX2Jvb3RfbW9kZSB0byA8YXNtL2ltYS1lZmkuaD4gYW5kIGluY2x1ZGlu
Zw0KPj4gPGFzbS9ib290cGFyYW0uaD4gc2VwYXJhdGVzIHRoYXQgZGVwZW5kZW5jeSBmcm9t
IHRoZSByZXN0IG9mIHRoZSBFRkkNCj4+IGludGVyZmFjZXMuIFRoZSBvbmx5IHVzZXIgaXMg
aW4gaW1hX2VmaS5jLiBBcyB0aGUgZmlsZSBhbHJlYWR5IGRlY2xhcmVzDQo+PiBhIGRlZmF1
bHQgdmFsdWUgZm9yIGFyY2hfaW1hX2VmaV9ib290X21vZGUsIG1vdmUgdGhpcyBkZWZpbmUg
aW50bw0KPj4gYXNtLWdlbmVyaWMgZm9yIGFsbCBvdGhlciBhcmNoaXRlY3R1cmVzLg0KPj4N
Cj4+IFdpdGggYXJjaF9pbWFfZWZpX2Jvb3RfbW9kZSByZW1vdmVkIGZyb20gZWZpLmgsIDxh
c20vYm9vdHBhcmFtLmg+IGNhbg0KPj4gbGF0ZXIgYmUgcmVtb3ZlZCBmcm9tIGZ1cnRoZXIg
eDg2IGhlYWRlciBmaWxlcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVy
bWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4+IC0tLQ0KPj4gICBhcmNoL3g4Ni9pbmNs
dWRlL2FzbS9lZmkuaCAgICAgICB8ICAzIC0tLQ0KPj4gICBhcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9pbWEtZWZpLmggICB8IDEyICsrKysrKysrKysrKw0KPj4gICBpbmNsdWRlL2FzbS1nZW5l
cmljL0tidWlsZCAgICAgICB8ICAxICsNCj4+ICAgaW5jbHVkZS9hc20tZ2VuZXJpYy9pbWEt
ZWZpLmggICAgfCAxNiArKysrKysrKysrKysrKysrDQo+PiAgIHNlY3VyaXR5L2ludGVncml0
eS9pbWEvaW1hX2VmaS5jIHwgIDUgKy0tLS0NCj4+ICAgNSBmaWxlcyBjaGFuZ2VkLCAzMCBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
YXJjaC94ODYvaW5jbHVkZS9hc20vaW1hLWVmaS5oDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBpbmNsdWRlL2FzbS1nZW5lcmljL2ltYS1lZmkuaA0KPj4NCj4+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9lZmkuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2VmaS5o
DQo+PiBpbmRleCBjNDU1NWIyNjlhMWIuLjk5ZjMxMTc2Yzg5MiAxMDA2NDQNCj4+IC0tLSBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2VmaS5oDQo+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9lZmkuaA0KPj4gQEAgLTQxOCw5ICs0MTgsNiBAQCBleHRlcm4gaW50IF9faW5pdCBl
ZmlfbWVtbWFwX3NwbGl0X2NvdW50KGVmaV9tZW1vcnlfZGVzY190ICptZCwNCj4+ICAgZXh0
ZXJuIHZvaWQgX19pbml0IGVmaV9tZW1tYXBfaW5zZXJ0KHN0cnVjdCBlZmlfbWVtb3J5X21h
cCAqb2xkX21lbW1hcCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdm9pZCAqYnVmLCBzdHJ1Y3QgZWZpX21lbV9yYW5nZSAqbWVtKTsNCj4+DQo+PiAtI2Rl
ZmluZSBhcmNoX2ltYV9lZmlfYm9vdF9tb2RlIFwNCj4+IC0gICAgICAgKHsgZXh0ZXJuIHN0
cnVjdCBib290X3BhcmFtcyBib290X3BhcmFtczsgYm9vdF9wYXJhbXMuc2VjdXJlX2Jvb3Q7
IH0pDQo+PiAtDQo+PiAgICNpZmRlZiBDT05GSUdfRUZJX1JVTlRJTUVfTUFQDQo+PiAgIGlu
dCBlZmlfZ2V0X3J1bnRpbWVfbWFwX3NpemUodm9pZCk7DQo+PiAgIGludCBlZmlfZ2V0X3J1
bnRpbWVfbWFwX2Rlc2Nfc2l6ZSh2b2lkKTsNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9pbWEtZWZpLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pbWEtZWZpLmgN
Cj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjNmZTA1
NDkzNzA3Nw0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9h
c20vaW1hLWVmaS5oDQo+PiBAQCAtMCwwICsxLDEyIEBADQo+PiArLyogU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4+ICsjaWZuZGVmIF9BU01fWDg2X0lNQV9FRklf
SA0KPj4gKyNkZWZpbmUgX0FTTV9YODZfSU1BX0VGSV9IDQo+PiArDQo+PiArI2luY2x1ZGUg
PGFzbS9ib290cGFyYW0uaD4NCj4+ICsNCj4+ICsjZGVmaW5lIGFyY2hfaW1hX2VmaV9ib290
X21vZGUgXA0KPj4gKyAgICAgICAoeyBleHRlcm4gc3RydWN0IGJvb3RfcGFyYW1zIGJvb3Rf
cGFyYW1zOyBib290X3BhcmFtcy5zZWN1cmVfYm9vdDsgfSkNCj4+ICsNCj4gDQo+IENvdWxk
IHlvdSBwbGVhc2UgY2hlY2sgd2hldGhlciB0aGlzIGtsdWRnZSBpcyBzdGlsbCBuZWVkZWQg
bm93IHRoYXQgd2UNCj4gbm8gbG9uZ2VyIGhhdmUgY29uZmxpY3RpbmcgZGVjbGFyYXRpb25z
IG9mIGJvb3RfcGFyYW1zPyAoaS5lLiwgZHJvcA0KPiB0aGUgKHsgfSkgYW5kIHRoZSBleHRl
cm4gZGVjbGFyYXRpb24pDQoNCkkgZHJvcHBlZCB0aGlzIGFuZCBpbmNsdWRlIHNldHVwLmgg
aW5zdGVhZC4gQXBwZWFycyB0byB3b3JrLg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+
IA0KPiANCj4gDQo+PiArI2luY2x1ZGUgPGFzbS1nZW5lcmljL2ltYS1lZmkuaD4NCj4+ICsN
Cj4+ICsjZW5kaWYgLyogX0FTTV9YODZfSU1BX0VGSV9IICovDQo+PiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9hc20tZ2VuZXJpYy9LYnVpbGQgYi9pbmNsdWRlL2FzbS1nZW5lcmljL0tidWls
ZA0KPj4gaW5kZXggZGVmMjQyNTI4YjFkLi40ZmQxNmU3MWU4Y2QgMTAwNjQ0DQo+PiAtLS0g
YS9pbmNsdWRlL2FzbS1nZW5lcmljL0tidWlsZA0KPj4gKysrIGIvaW5jbHVkZS9hc20tZ2Vu
ZXJpYy9LYnVpbGQNCj4+IEBAIC0yNiw2ICsyNiw3IEBAIG1hbmRhdG9yeS15ICs9IGZ0cmFj
ZS5oDQo+PiAgIG1hbmRhdG9yeS15ICs9IGZ1dGV4LmgNCj4+ICAgbWFuZGF0b3J5LXkgKz0g
aGFyZGlycS5oDQo+PiAgIG1hbmRhdG9yeS15ICs9IGh3X2lycS5oDQo+PiArbWFuZGF0b3J5
LXkgKz0gaW1hLWVmaS5oDQo+PiAgIG1hbmRhdG9yeS15ICs9IGlvLmgNCj4+ICAgbWFuZGF0
b3J5LXkgKz0gaXJxLmgNCj4+ICAgbWFuZGF0b3J5LXkgKz0gaXJxX3JlZ3MuaA0KPj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvaW1hLWVmaS5oIGIvaW5jbHVkZS9hc20t
Z2VuZXJpYy9pbWEtZWZpLmgNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAw
MDAwMDAwMDAwMDAuLmY4N2Y1ZWRlZjQ0MA0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIv
aW5jbHVkZS9hc20tZ2VuZXJpYy9pbWEtZWZpLmgNCj4+IEBAIC0wLDAgKzEsMTYgQEANCj4+
ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsgKi8NCj4+ICsNCj4+ICsj
aWZuZGVmIF9fQVNNX0dFTkVSSUNfSU1BX0VGSV9IXw0KPj4gKyNkZWZpbmUgX19BU01fR0VO
RVJJQ19JTUFfRUZJX0hfDQo+PiArDQo+PiArI2luY2x1ZGUgPGxpbnV4L2VmaS5oPg0KPj4g
Kw0KPj4gKy8qDQo+PiArICogT25seSBpbmNsdWRlIHRoaXMgaGVhZGVyIGZpbGUgZnJvbSB5
b3VyIGFyY2hpdGVjdHVyZSdzIDxhc20vaW1hLWVmaS5oPi4NCj4+ICsgKi8NCj4+ICsNCj4+
ICsjaWZuZGVmIGFyY2hfaW1hX2VmaV9ib290X21vZGUNCj4+ICsjZGVmaW5lIGFyY2hfaW1h
X2VmaV9ib290X21vZGUgZWZpX3NlY3VyZWJvb3RfbW9kZV91bnNldA0KPj4gKyNlbmRpZg0K
Pj4gKw0KPj4gKyNlbmRpZiAvKiBfX0FTTV9HRU5FUklDX0ZCX0hfICovDQo+PiBkaWZmIC0t
Z2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZWZpLmMgYi9zZWN1cml0eS9pbnRl
Z3JpdHkvaW1hL2ltYV9lZmkuYw0KPj4gaW5kZXggMTM4MDI5YmZjY2UxLi41NmJiZWUyNzFj
ZWMgMTAwNjQ0DQo+PiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9lZmkuYw0K
Pj4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZWZpLmMNCj4+IEBAIC02LDEw
ICs2LDcgQEANCj4+ICAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPj4gICAjaW5jbHVk
ZSA8bGludXgvaW1hLmg+DQo+PiAgICNpbmNsdWRlIDxhc20vZWZpLmg+DQo+PiAtDQo+PiAt
I2lmbmRlZiBhcmNoX2ltYV9lZmlfYm9vdF9tb2RlDQo+PiAtI2RlZmluZSBhcmNoX2ltYV9l
ZmlfYm9vdF9tb2RlIGVmaV9zZWN1cmVib290X21vZGVfdW5zZXQNCj4+IC0jZW5kaWYNCj4+
ICsjaW5jbHVkZSA8YXNtL2ltYS1lZmkuaD4NCj4+DQo+PiAgIHN0YXRpYyBlbnVtIGVmaV9z
ZWN1cmVib290X21vZGUgZ2V0X3NiX21vZGUodm9pZCkNCj4+ICAgew0KPj4gLS0NCj4+IDIu
NDMuMA0KPj4NCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERl
dmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpGcmFua2Vu
c3RyYXNzZSAxNDYsIDkwNDYxIE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2byBUb3Rldiwg
QW5kcmV3IE15ZXJzLCBBbmRyZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2
ODA5IChBRyBOdWVybmJlcmcpDQo=

--------------A1oU9wEQFL0rLOQVB0f9J8Wj--

--------------5kvNB39zOiwhHSSfE35u3i3I
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmV8Q5sFAwAAAAAACgkQlh/E3EQov+Ce
nhAAjLFIqLK1w+K8mQK4cHQOo7LZ30AwMya4wk1KNOBrE2EqsmwdO5+orckEH1Fkh46MHJdnxbKn
RTria6zMdqbpw/irfjW+zasheRN+rAmwXlDPRcoxhgFHdbB97FSGgty2gFfZV33zEt49OdN2BXpW
4n9R0/nUrp1+im+vCPxZFFV+08onXqyL6jedldwdmNlTmbRx1xUK2KL1++lfm9764V1AomaXcrNl
GkfCD5eo8Pj3jbJ10RtzYZlwMZpin4qynCW0eNuHAu0A3zz6xxSaq7LTccdWpqjyQtEATeDYWSvY
7WuzZjx5WoXlIbB8O6umW1gDIJJBPtCR9JTyOC4bfT4m0EZ5N4HnSE/kHhmfgS91dVtZEgF4U242
drt5rdJbtbG167/ljG4SqhgoboWywyRV7t/Z1OQk5bgKOuP/V+tLtKdJxD9qvnsZETDHdfC8irUS
EgB18n9zt6aXmcYBzj7jOCvS3zzos8iZI0SzurHB7rjDmZVbiGLXUvRWTY2no1fp/QhemXCgj+bu
j7Hb0yYSxx0hE8br7UEwasvF8b+k4CKAV5UKpnOIGlAi+N71VtKTH3sndW7+LGRbhrEoeQrdqELL
8QzspLHStQKWx8FRn43aLZ0sUNkb8mAHIU4gzzXOCHG5nl6nki13SA1wKv2hXviGAURSNueaXkRX
39c=
=88iJ
-----END PGP SIGNATURE-----

--------------5kvNB39zOiwhHSSfE35u3i3I--

