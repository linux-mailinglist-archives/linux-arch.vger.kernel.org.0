Return-Path: <linux-arch+bounces-207-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3253F7E98D3
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 10:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FDA1C2037B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 09:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94C218C0F;
	Mon, 13 Nov 2023 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ERFtAi0H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PC5YoXrU"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722018E1F;
	Mon, 13 Nov 2023 09:22:41 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C0510D4;
	Mon, 13 Nov 2023 01:22:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0B4721900;
	Mon, 13 Nov 2023 09:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1699867356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D3Jfk6wPDPn61d9SkNQs0RWFcu0gEIcj0L1gosyNYP8=;
	b=ERFtAi0H+/DmiIIYjA+Bg4Dqa4ttdxaixobGeq6zAd8e+voDaBuTYYHh5mShTHIydQhYDO
	BhFcwI5MgzxmaiPz4c610/cjl7TD0zbozg0vkTGoSHKBIS6XiSOHus9Z3cm/EXoHv3uFMr
	tQTYZ6bZatOp7TGSp8ez0Y/9Ot7gCRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1699867356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D3Jfk6wPDPn61d9SkNQs0RWFcu0gEIcj0L1gosyNYP8=;
	b=PC5YoXrUjX6g/jXM/N5NHV/AtDbhH4BfCbejheLebBTK6Ge4VnlGBOz0UYqdOwNIsJHxfc
	+iLd84dtD/q1/YBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FD2B13398;
	Mon, 13 Nov 2023 09:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Dta+DNzqUWVjCwAAMHmgww
	(envelope-from <tzimmermann@suse.de>); Mon, 13 Nov 2023 09:22:36 +0000
Message-ID: <ba7e407c-d091-410d-92a5-19ec25224bd2@suse.de>
Date: Mon, 13 Nov 2023 10:22:35 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v5 0/5] ppc, fbdev: Clean up fbdev mmap helper
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
References: <20230922080636.26762-1-tzimmermann@suse.de>
 <169984352204.1887074.16685503842131763450.b4-ty@ellerman.id.au>
Content-Language: en-US
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
In-Reply-To: <169984352204.1887074.16685503842131763450.b4-ty@ellerman.id.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bhtCdMnClY6lSHNIfviMvszc"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bhtCdMnClY6lSHNIfviMvszc
Content-Type: multipart/mixed; boundary="------------ZnC76XYWWYK1mLFHw8ZmTwef";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Message-ID: <ba7e407c-d091-410d-92a5-19ec25224bd2@suse.de>
Subject: Re: (subset) [PATCH v5 0/5] ppc, fbdev: Clean up fbdev mmap helper
References: <20230922080636.26762-1-tzimmermann@suse.de>
 <169984352204.1887074.16685503842131763450.b4-ty@ellerman.id.au>
In-Reply-To: <169984352204.1887074.16685503842131763450.b4-ty@ellerman.id.au>

--------------ZnC76XYWWYK1mLFHw8ZmTwef
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDEzLjExLjIzIHVtIDAzOjQ1IHNjaHJpZWIgTWljaGFlbCBFbGxlcm1hbjoNCj4g
T24gRnJpLCAyMiBTZXAgMjAyMyAxMDowNDo1NCArMDIwMCwgVGhvbWFzIFppbW1lcm1hbm4g
d3JvdGU6DQo+PiBDbGVhbiB1cCBhbmQgcmVuYW1lIGZiX3BncHJvdGVjdCgpIHRvIHdvcmsg
d2l0aG91dCBzdHJ1Y3QgZmlsZS4gVGhlbg0KPj4gcmVmYWN0b3IgdGhlIGltcGxlbWVudGF0
aW9uIGZvciBQb3dlclBDLiBUaGlzIGNoYW5nZSBoYXMgYmVlbiBkaXNjdXNzZWQNCj4+IGF0
IFsxXSBpbiB0aGUgY29udGV4dCBvZiByZWZhY3RvcmluZyBmYmRldidzIG1tYXAgY29kZS4N
Cj4+DQo+PiBUaGUgZmlyc3QgdHdvIHBhdGNoZXMgdXBkYXRlIGZiZGV2IGFuZCByZXBsYWNl
IGZiZGV2J3MgZmJfcGdwcm90ZWN0KCkNCj4+IHdpdGggcGdwcm90X2ZyYW1lYnVmZmVyKCkg
b24gYWxsIGFyY2hpdGVjdHVyZXMuIFRoZSBuZXcgaGVscGVyJ3Mgc3RyZWFtLQ0KPj4gbGlu
ZWQgaW50ZXJmYWNlIGVuYWJsZXMgbW9yZSByZWZhY3RvcmluZyB3aXRoaW4gZmJkZXYncyBt
bWFwDQo+PiBpbXBsZW1lbnRhdGlvbi4NCj4+DQo+PiBbLi4uXQ0KPiANCj4gUGF0Y2hlcyAz
LTUgYXBwbGllZCB0byBwb3dlcnBjL2ZpeGVzLg0KPiANCj4gWzMvNV0gYXJjaC9wb3dlcnBj
OiBSZW1vdmUgdHJhaWxpbmcgd2hpdGVzcGFjZXMNCj4gICAgICAgIGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcG93ZXJwYy9jLzMyMjk0OGMzMTk4Y2Y4MGU3YzEwZDk1M2RkYWQyNGViZDg1
NzU3Y2QNCj4gWzQvNV0gYXJjaC9wb3dlcnBjOiBSZW1vdmUgZmlsZSBwYXJhbWV0ZXIgZnJv
bSBwaHlzX21lbV9hY2Nlc3NfcHJvdCBjb2RlDQo+ICAgICAgICBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3Bvd2VycGMvYy8xZjkyYTg0NGMzNWU0ODNjMDBiYWI4YTdiN2QzOWM1NTVlZTc5
OWQ4DQo+IFs1LzVdIGFyY2gvcG93ZXJwYzogQ2FsbCBpbnRlcm5hbCBfX3BoeXNfbWVtX2Fj
Y2Vzc19wcm90KCkgaW4gZmJkZXYgY29kZQ0KPiAgICAgICAgaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wb3dlcnBjL2MvZGVlYmU1ZjYwN2Q3ZjcyZjgzYzQxMTYzMTkxYWQwYzFjNDM1NjM4
NQ0KDQpHcmVhdCwgdGhhbmtzIGEgbG90IQ0KDQo+IA0KPiBjaGVlcnMNCg0KLS0gDQpUaG9t
YXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2Fy
ZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkwNDYxIE51
ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3IE15ZXJzLCBBbmRyZXcg
TWNEb25hbGQsIEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChBRyBOdWVybmJlcmcpDQo=


--------------ZnC76XYWWYK1mLFHw8ZmTwef--

--------------bhtCdMnClY6lSHNIfviMvszc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmVR6tsFAwAAAAAACgkQlh/E3EQov+Db
+Q//VC9xdTxmoG7kkH+AyylOR0zi9TCw9c4m+AppLVu16/wmZST6snqAPRBzoXQDrPXOyWaLujR8
1bKd+/5KUf07wboA5UOV+6z4DMOC7E0eGAwWsfYvgpPML4y5mD1UWeRoSqXuHGNiVeQoDavIgK91
PPck79Iio2/66zBh9P9/0QSHvJGKGcsuLVSd6ACxtgp+ADNdperGmT+7gAoqEoOeUiA5OhvVGv1l
3Juv91vCU7x5bgCsfvr0p3BXGAdWBG0B2eGiUhdtNM1dBdxWXn8zbvgMxkyCImceZkgJebZDvuLO
psEzobD5NvsM41DAQEpxLshhL8Eq+6/No9c0oUhmLcN7BDgagRanlJXRRSnMSIx8kvLAOs4YvcZ2
5sR+UAIx6NM7fQhdq4CoGCE05Ff/s571qRlDB8TaTnb9l4+ooLYWcM3wtEqJSO9RdD98orMiE5H1
1APxpQwq+Mg+oEM3/QprJSCu68Iu9I8E8ArjugGP7eRw83sN/VJM7EB3NrDgZ3/V0znFCSb11JP1
WAjoF0X09yHMivD91jm+pVeNcM5TLOTC0Fv11VZHbDMtaLSpwGi4Pn6fyFVrFHLvotckv70TFRvz
rqNzZtQjManvzCGFBQVtNIWGXZgi7eWiK8mWsyFHOcYhhlw2646Bdoi81E93egf9QvWJXQV7MxvK
epo=
=KjZf
-----END PGP SIGNATURE-----

--------------bhtCdMnClY6lSHNIfviMvszc--

