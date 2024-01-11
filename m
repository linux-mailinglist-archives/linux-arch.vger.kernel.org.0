Return-Path: <linux-arch+bounces-1344-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 119FB82AB46
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 10:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74DF8B27162
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019E31173B;
	Thu, 11 Jan 2024 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zhmeMRoN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fOhSEC/z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n5vdaQLj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qnePHNC/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D57CFC1D;
	Thu, 11 Jan 2024 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 660AF221F5;
	Thu, 11 Jan 2024 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704966630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Mj6jPnJr85UCQs+wlaxAUOi0bHdTY1sfEBADyVhRcZI=;
	b=zhmeMRoN+n/KzlejibfCEME/2lrVb18mU1wOreFQPpkxsKMeS3y0WT4Wo5dzDQyxUfWz4c
	9E+dAQ9rBbIK+d/1vHtIDsOx6XUpq24BC/y2Zyogxz2Ng69Fum5NY4r60VGfxA0WdzeS1S
	aRuAbjGxgmJzy1cAo6Y2o3QXrPSPvvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704966630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Mj6jPnJr85UCQs+wlaxAUOi0bHdTY1sfEBADyVhRcZI=;
	b=fOhSEC/z/SqIdNetNERk0GhrG0fzuxSOxzLovsgNkD9TjAXb8K+/s4XahRwf7UiYcsVZ04
	RJcqZaeDpbesRLBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704966553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Mj6jPnJr85UCQs+wlaxAUOi0bHdTY1sfEBADyVhRcZI=;
	b=n5vdaQLjj+6fLo0adhHGyS21wSr8rPUdrR19FmWjovQpKM71P17fOnwyytaI/W/ie9jgrI
	dSfurJx/gj1tbF41THcarSXDQXOVdvxaNSmn66NpLwHDkVRCMh4iNHdmPmHawJ8L0NfnFA
	ROH0aFqC2sbHtWhapAaSgtWhUXQHxIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704966553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Mj6jPnJr85UCQs+wlaxAUOi0bHdTY1sfEBADyVhRcZI=;
	b=qnePHNC/5FfnR9YWBa4FSXDzCNAykQbW/tRjdriaeYynjX0ycqXBjzubGSY2iyp9cr5Xy7
	olABhQ+wJlcdafDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 72342138E5;
	Thu, 11 Jan 2024 09:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 26zDGpm5n2WQMgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Thu, 11 Jan 2024 09:49:13 +0000
Message-ID: <1fd1a3ca-edeb-4bf6-a12d-a8087a180d36@suse.de>
Date: Thu, 11 Jan 2024 10:50:43 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] arch/x86: Move internal setup_data structures into
 setup_data.h
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>, kernel test robot <lkp@intel.com>
Cc: ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bhelgaas@google.com, arnd@arndb.de, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, javierm@redhat.com, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20240108095903.8427-3-tzimmermann@suse.de>
 <202401090800.UOBEKB3W-lkp@intel.com>
 <20240109175814.GA5981@dev-arch.thelio-3990X>
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
In-Reply-To: <20240109175814.GA5981@dev-arch.thelio-3990X>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZmdV1Iv0xYAmP5whbMR1P70e"
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
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MIME_BASE64_TEXT(0.10)[];
	 SIGNED_PGP(-2.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	 BAYES_HAM(-3.00)[100.00%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[25];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,git-scm.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com,lists.linux.dev,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZmdV1Iv0xYAmP5whbMR1P70e
Content-Type: multipart/mixed; boundary="------------j6Cwys0LP2kdoAZ1E9hEPCWY";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Nathan Chancellor <nathan@kernel.org>, kernel test robot <lkp@intel.com>
Cc: ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bhelgaas@google.com, arnd@arndb.de, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, javierm@redhat.com, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org
Message-ID: <1fd1a3ca-edeb-4bf6-a12d-a8087a180d36@suse.de>
Subject: Re: [PATCH v4 2/4] arch/x86: Move internal setup_data structures into
 setup_data.h
References: <20240108095903.8427-3-tzimmermann@suse.de>
 <202401090800.UOBEKB3W-lkp@intel.com>
 <20240109175814.GA5981@dev-arch.thelio-3990X>
In-Reply-To: <20240109175814.GA5981@dev-arch.thelio-3990X>

--------------j6Cwys0LP2kdoAZ1E9hEPCWY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDkuMDEuMjQgdW0gMTg6NTggc2NocmllYiBOYXRoYW4gQ2hhbmNlbGxvcjoN
Cj4gT24gVHVlLCBKYW4gMDksIDIwMjQgYXQgMDg6Mjg6NTlBTSArMDgwMCwga2VybmVsIHRl
c3Qgcm9ib3Qgd3JvdGU6DQo+PiBIaSBUaG9tYXMsDQo+Pg0KPj4ga2VybmVsIHRlc3Qgcm9i
b3Qgbm90aWNlZCB0aGUgZm9sbG93aW5nIGJ1aWxkIHdhcm5pbmdzOg0KPj4NCj4+IFthdXRv
IGJ1aWxkIHRlc3QgV0FSTklORyBvbiB0aXAveDg2L2NvcmVdDQo+PiBbYWxzbyBidWlsZCB0
ZXN0IFdBUk5JTkcgb24gZWZpL25leHQgdGlwL21hc3RlciB0aXAvYXV0by1sYXRlc3QgbGlu
dXMvbWFzdGVyIHY2LjcgbmV4dC0yMDI0MDEwOF0NCj4+IFtJZiB5b3VyIHBhdGNoIGlzIGFw
cGxpZWQgdG8gdGhlIHdyb25nIGdpdCB0cmVlLCBraW5kbHkgZHJvcCB1cyBhIG5vdGUuDQo+
PiBBbmQgd2hlbiBzdWJtaXR0aW5nIHBhdGNoLCB3ZSBzdWdnZXN0IHRvIHVzZSAnLS1iYXNl
JyBhcyBkb2N1bWVudGVkIGluDQo+PiBodHRwczovL2dpdC1zY20uY29tL2RvY3MvZ2l0LWZv
cm1hdC1wYXRjaCNfYmFzZV90cmVlX2luZm9ybWF0aW9uXQ0KPj4NCj4+IHVybDogICAgaHR0
cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1sa3AvbGludXgvY29tbWl0cy9UaG9tYXMtWmlt
bWVybWFubi9hcmNoLXg4Ni1Nb3ZlLVVBUEktc2V0dXAtc3RydWN0dXJlcy1pbnRvLXNldHVw
X2RhdGEtaC8yMDI0MDEwOC0xODAxNTgNCj4+IGJhc2U6ICAgdGlwL3g4Ni9jb3JlDQo+PiBw
YXRjaCBsaW5rOiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwMTA4MDk1OTAz
Ljg0MjctMy10emltbWVybWFubiU0MHN1c2UuZGUNCj4+IHBhdGNoIHN1YmplY3Q6IFtQQVRD
SCB2NCAyLzRdIGFyY2gveDg2OiBNb3ZlIGludGVybmFsIHNldHVwX2RhdGEgc3RydWN0dXJl
cyBpbnRvIHNldHVwX2RhdGEuaA0KPj4gY29uZmlnOiB4ODZfNjQtcmhlbC04LjMtYnBmICho
dHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAyNDAxMDkvMjAyNDAx
MDkwODAwLlVPQkVLQjNXLWxrcEBpbnRlbC5jb20vY29uZmlnKQ0KPj4gY29tcGlsZXI6IENs
YW5nQnVpbHRMaW51eCBjbGFuZyB2ZXJzaW9uIDE3LjAuNiAoaHR0cHM6Ly9naXRodWIuY29t
L2xsdm0vbGx2bS1wcm9qZWN0IDYwMDk3MDhiNDM2NzE3MWNjZGJmNGI1OTA1Y2I2YTgwMzc1
M2ZlMTgpDQo+PiByZXByb2R1Y2UgKHRoaXMgaXMgYSBXPTEgYnVpbGQpOiAoaHR0cHM6Ly9k
b3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjQwMTA5LzIwMjQwMTA5MDgwMC5V
T0JFS0IzVy1sa3BAaW50ZWwuY29tL3JlcHJvZHVjZSkNCj4+DQo+PiBJZiB5b3UgZml4IHRo
ZSBpc3N1ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2NvbW1pdCAoaS5lLiBub3QganVzdCBhIG5l
dyB2ZXJzaW9uIG9mDQo+PiB0aGUgc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRkIGZv
bGxvd2luZyB0YWdzDQo+PiB8IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtw
QGludGVsLmNvbT4NCj4+IHwgQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1r
YnVpbGQtYWxsLzIwMjQwMTA5MDgwMC5VT0JFS0IzVy1sa3BAaW50ZWwuY29tLw0KPj4NCj4+
IEFsbCB3YXJuaW5ncyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KPj4NCj4+ICAgICBJ
biBmaWxlIGluY2x1ZGVkIGZyb20gYXJjaC94ODYvcmVhbG1vZGUvcm0vd2FrZW1haW4uYzoz
Og0KPj4gICAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBhcmNoL3g4Ni9ib290L2Jvb3QuaDoy
NDoNCj4+ICAgICBJbiBmaWxlIGluY2x1ZGVkIGZyb20gYXJjaC94ODYvaW5jbHVkZS9hc20v
c2V0dXAuaDoxMDoNCj4+ICAgICBJbiBmaWxlIGluY2x1ZGVkIGZyb20gYXJjaC94ODYvaW5j
bHVkZS9hc20vcGFnZV90eXBlcy5oOjc6DQo+PiAgICAgSW4gZmlsZSBpbmNsdWRlZCBmcm9t
IGluY2x1ZGUvbGludXgvbWVtX2VuY3J5cHQuaDoxNzoNCj4+ICAgICBJbiBmaWxlIGluY2x1
ZGVkIGZyb20gYXJjaC94ODYvaW5jbHVkZS9hc20vbWVtX2VuY3J5cHQuaDoxODoNCj4+ICAg
ICBJbiBmaWxlIGluY2x1ZGVkIGZyb20gYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9ib290
cGFyYW0uaDo1Og0KPj4+PiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZXR1cF9kYXRhLmg6MTA6
MjA6IHdhcm5pbmc6IGZpZWxkICdkYXRhJyB3aXRoIHZhcmlhYmxlIHNpemVkIHR5cGUgJ3N0
cnVjdCBzZXR1cF9kYXRhJyBub3QgYXQgdGhlIGVuZCBvZiBhIHN0cnVjdCBvciBjbGFzcyBp
cyBhIEdOVSBleHRlbnNpb24gWy1XZ251LXZhcmlhYmxlLXNpemVkLXR5cGUtbm90LWF0LWVu
ZF0NCj4+ICAgICAgICAxMCB8ICAgICAgICAgc3RydWN0IHNldHVwX2RhdGEgZGF0YTsNCj4+
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPj4gICAgIDEgd2Fy
bmluZyBnZW5lcmF0ZWQuDQo+IA0KPiBJIHRoaW5rIHRoaXMgd2FybmluZyBpcyBleHBlY3Rl
ZC4gVGhpcyBzdHJ1Y3R1cmUgaXMgbm93IGluY2x1ZGVkIGluIHRoZQ0KPiByZWFsbW9kZSBw
YXJ0IG9mIGFyY2gveDg2LCB3aGljaCBoYXMgaXRzIG93biBzZXQgb2YgYnVpbGQgZmxhZ3Ms
DQo+IGluY2x1ZGluZyAtV2FsbCwgd2hpY2ggaW5jbHVkZXMgLVdnbnUgb24gY2xhbmcuIFRo
ZSBrZXJuZWwgb2J2aW91c2x5DQo+IHVzZXMgR05VIGV4dGVuc2lvbnMgYW5kIHN0YXRlcyB0
aGlzIGNsZWFybHkgd2l0aCAnLXN0ZD1nbnUxMScsIHNvDQo+IC1Xbm8tZ251IGlzIHVuY29u
ZGl0aW9uYWxseSBhZGRlZCB0byBLQlVJTERfQ0ZMQUdTIGZvciBjbGFuZy4gSXQgc2VlbXMN
Cj4gdGhhdCBzYW1lIHRyZWF0bWVudCBpcyBuZWVkZWQgZm9yIFJFQUxNT0RFX0NGTEFHUywg
d2hpY2ggYWxzbyBtYXRjaGVzDQo+IGFyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9NYWtlZmls
ZSwgc2VlIGNvbW1pdCA2YzNiNTZiMTk3MzAgKCJ4ODYvYm9vdDoNCj4gRGlzYWJsZSBDbGFu
ZyB3YXJuaW5ncyBhYm91dCBHTlUgZXh0ZW5zaW9ucyIpOg0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L01ha2VmaWxlIGIvYXJjaC94ODYvTWFrZWZpbGUNCj4gaW5kZXggMWEwNjhk
ZTEyYTU2Li4yNDA3NmRiNTk3ODMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L01ha2VmaWxl
DQo+ICsrKyBiL2FyY2gveDg2L01ha2VmaWxlDQo+IEBAIC01Myw2ICs1Myw5IEBAIFJFQUxN
T0RFX0NGTEFHUyArPSAtZm5vLXN0YWNrLXByb3RlY3Rvcg0KPiAgIFJFQUxNT0RFX0NGTEFH
UyArPSAtV25vLWFkZHJlc3Mtb2YtcGFja2VkLW1lbWJlcg0KPiAgIFJFQUxNT0RFX0NGTEFH
UyArPSAkKGNjX3N0YWNrX2FsaWduNCkNCj4gICBSRUFMTU9ERV9DRkxBR1MgKz0gJChDTEFO
R19GTEFHUykNCj4gK2lmZGVmIENPTkZJR19DQ19JU19DTEFORw0KPiArUkVBTE1PREVfQ0ZM
QUdTICs9IC1Xbm8tZ251DQo+ICtlbmRpZg0KDQpUaGFua3MuIFNoYWxsIEkgaW5jbHVkZSB0
aGlzIGNoYW5nZSBpbiB0aGUgcGF0Y2hzZXQ/DQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoN
Cj4gICBleHBvcnQgUkVBTE1PREVfQ0ZMQUdTDQo+ICAgDQo+ICAgIyBCSVRTIGlzIHVzZWQg
YXMgZXh0ZW5zaW9uIGZvciBmaWxlcyB3aGljaCBhcmUgYXZhaWxhYmxlIGluIGEgMzIgYml0
DQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXIN
ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0cmFzc2Ug
MTQ2LCA5MDQ2MSBOdWVybmJlcmcsIEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFuZHJldyBN
eWVycywgQW5kcmV3IE1jRG9uYWxkLCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgwOSAoQUcg
TnVlcm5iZXJnKQ0K

--------------j6Cwys0LP2kdoAZ1E9hEPCWY--

--------------ZmdV1Iv0xYAmP5whbMR1P70e
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmWfufMFAwAAAAAACgkQlh/E3EQov+Ah
zhAAgyKH/nDt76sEkM59OsOGhqE1rWXhDW6k9pJxX4JG5gER9op5czApHYzb1zUp2UgAaYVcfaW2
NkJkxGoBI8jwYQSQDcP/m3mFd86Rs06oHKUNNIn8OEIgJG6lSlHce59oeBblILCQLWjA6+swV3Zn
AuWwLX1h8VfIlseUmxeAUBI6VUlD/1zUcBm69IjDWLMi1Ia2cDsHsh0m8/BSchwBSog3tv82bKnO
x/VzuoxSh/3tzuzoeqx04oV3T7qMRn47MsgZf6WA6z/k5WnGBgWnrdQSdlAPCUrYJnhV2pEX8Qr9
U4g5IEDlQLSj4RayC+znUBcPvd9eiRURqLfviKsjbgd71lrEXtMin2AuocfSRK0JzqOSP1poK/Cu
KLu5UmOP5iLRw/Zm+QYB0/i8N9lKd8rOc9VyjwpMQefl1SHWTRTIKPoEMgMLgQFC2Sqt3zIoizLk
USSsHL9Iqq4+sdJWDpyNEB0xo+Zb3efRBeesZWhaEflKzeEua3sOsiidqoCuhrAkIe7ll1PZJ2NX
uM/jTMxH9Jzd02WzSQzwjPz+iz59J7i6RkpmKSiH1RrT3RjD7vhiksnkbjKandI95ZCTugAxxqMg
vQJf2cdStHZ1LQ3in/QCL4RcYBrMTqQT8K4ospjOi+7x4k8SbsvLdmOVVmrM+jHbl1m1HlsfdhzT
YnA=
=4q+T
-----END PGP SIGNATURE-----

--------------ZmdV1Iv0xYAmP5whbMR1P70e--

