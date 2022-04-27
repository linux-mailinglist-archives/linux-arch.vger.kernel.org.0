Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A0651110E
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 08:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbiD0GYJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 02:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiD0GYI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 02:24:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CFF7091E;
        Tue, 26 Apr 2022 23:20:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F32A210EB;
        Wed, 27 Apr 2022 06:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651040456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tRo34n/wFbXNNEGrJxuKAKttKtLy++EbrN/0sbLAuLU=;
        b=D+p83EMNol8Q5YflmfSLqYlSL6m+x+BioBiax6DtLYHppB6Bu50y31riJJBbu4NG3T+7Ku
        8ktYbnnmCt5gnjnvbl5SE3bzZtmlNsUgJaMzREI5C3beFpLiWOmhiosZpX7lrqN8oqYd3G
        IcinBTrMxrnYcuYp7ma664kok8/MuvU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BC1F1323E;
        Wed, 27 Apr 2022 06:20:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fc8iEcfgaGLnDAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 27 Apr 2022 06:20:55 +0000
Message-ID: <f7dca1db-8e4f-a793-231b-a69423451463@suse.com>
Date:   Wed, 27 Apr 2022 08:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-2-jgross@suse.com> <YmgsYvWQchxub8cW@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 1/2] kernel: add platform_has() infrastructure
In-Reply-To: <YmgsYvWQchxub8cW@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GT0cvmmMNAIgVAEXsN8EMHj0"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------GT0cvmmMNAIgVAEXsN8EMHj0
Content-Type: multipart/mixed; boundary="------------N0WDsQdFlRa8hwn0BEJ0uY0Y";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <olekstysh@gmail.com>
Message-ID: <f7dca1db-8e4f-a793-231b-a69423451463@suse.com>
Subject: Re: [PATCH 1/2] kernel: add platform_has() infrastructure
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-2-jgross@suse.com> <YmgsYvWQchxub8cW@zn.tnic>
In-Reply-To: <YmgsYvWQchxub8cW@zn.tnic>

--------------N0WDsQdFlRa8hwn0BEJ0uY0Y
Content-Type: multipart/mixed; boundary="------------0m0IZeiwI66kdGOBcI9J7h2H"

--------------0m0IZeiwI66kdGOBcI9J7h2H
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDQuMjIgMTk6MzEsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMjYsIDIwMjIgYXQgMDM6NDA6MjBQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvcGxhdGZvcm0tZmVhdHVyZS5jIGIva2VybmVsL3Bs
YXRmb3JtLWZlYXR1cmUuYw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAw
MDAwMDAwMDAwMC4uMmQ1MmY4NDQyY2Q1DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9r
ZXJuZWwvcGxhdGZvcm0tZmVhdHVyZS5jDQo+PiBAQCAtMCwwICsxLDcgQEANCj4+ICsvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4gKw0KPj4gKyNpbmNsdWRlIDxs
aW51eC9jYWNoZS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybS1mZWF0dXJlLmg+
DQo+PiArDQo+PiArdW5zaWduZWQgbG9uZyBfX3JlYWRfbW9zdGx5IHBsYXRmb3JtX2ZlYXR1
cmVzW1BMQVRGT1JNX0ZFQVRfQVJSQVlfU1pdOw0KPiANCj4gUHJvYmFibHkgX19yb19hZnRl
cl9pbml0Lg0KDQpZZXMsIGdvb2QgaWRlYS4NCg0KPiANCj4+ICtFWFBPUlRfU1lNQk9MX0dQ
TChwbGF0Zm9ybV9mZWF0dXJlcyk7DQo+IA0KPiBZb3UgcHJvYmFibHkgc2hvdWxkIG1ha2Ug
dGhhdCB0aGluZyBzdGF0aWMgYW5kIHVzZSBvbmx5IGFjY2Vzc29ycyB0bw0KPiBtb2RpZnkg
aXQgaW4gY2FzZSB5b3Ugd2FubmEgY2hhbmdlIHRoZSB1bmRlcmx5aW5nIGRhdGEgc3RydWN0
dXJlIGluIHRoZQ0KPiBmdXR1cmUuDQoNClRoZSBxdWVzdGlvbiBpcyB3aGV0aGVyIHdlIHRo
aW5rIHRoYXQgdGhvc2UgcGxhdGZvcm0gZmVhdHVyZXMgd2lsbCBiZSB1c2VkDQppbiBob3Qg
cGF0aHMgb3Igbm90LiBJZiBzbyB0aGUgaW5saW5lIGFjY2Vzc29ycyAoYXQgbGVhc3QgdGhl
IHBsYXRmb3JtX2hhcygpDQpvbmUpIHdvdWxkIGJlIHByZWZlcnJlZCBJTU8uDQoNCk9UT0gg
cmVhbGx5IHBlcmZvcm1hbmNlIGNyaXRpY2FsIGNhc2VzIGNvdWxkIHVzZSBzdGF0aWNfYnJh
bmNoIG9yIHN1Y2guDQoNCg0KSnVlcmdlbg0K
--------------0m0IZeiwI66kdGOBcI9J7h2H
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0m0IZeiwI66kdGOBcI9J7h2H--

--------------N0WDsQdFlRa8hwn0BEJ0uY0Y--

--------------GT0cvmmMNAIgVAEXsN8EMHj0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJo4MYFAwAAAAAACgkQsN6d1ii/Ey86
5gf+MT9EGStrBqHSYrnfMZLB74QV1EFSCMN8zW3eR1cgrrxb5+yzw2QbB2/V3B/KkXIpWpWcBiPH
+3G1SmlrvpRmCXWGieytw1Yh+HF/fC+eC9czBpya+VpPunC+LoWZewWC14DQbWb6nPulSysvSpeN
sJMFD6P0oQkwTa+cioNJ8Hb508wUbsb/NElzu5kCvy2hpsKB8YS6iSCpjfNyZ0P0vJ0HPeVlx4Pj
IQM30i/ZkREDEGBFbep9IDbwOf1X1n23UaLXi6yjk9zIbuCjaakWPdS0vTNsn1UX21/U9+fEhqBp
6slDwitOQpEQ+hgMeWWpVEyWXOqM44sw6bmGuX9ogQ==
=UkqB
-----END PGP SIGNATURE-----

--------------GT0cvmmMNAIgVAEXsN8EMHj0--
