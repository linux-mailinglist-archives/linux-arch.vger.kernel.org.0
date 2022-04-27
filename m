Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87B511148
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 08:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbiD0Gkp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 02:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbiD0Gkp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 02:40:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0131D336;
        Tue, 26 Apr 2022 23:37:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE819210EB;
        Wed, 27 Apr 2022 06:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651041452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hIAZm9r1VDhAElkE1+2svEA6lw1ewe4ogFbmiroQgP4=;
        b=p9gYvueF1siXdTXd9t0+h6KpT9vy0RBkQ5GDeRB2NZ4QadZ1DUbkQ1soFwuR/YIye8V+Lb
        RER9L++lDxAgGgTes9u5QfZ2B5td/67dtnFzANpoDN9CBH3TlzirGHZJgF4VaFdtMUV+ZJ
        XYFdbP3xbsmzuYLHS215ZIk2j9V9ieA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15E101323E;
        Wed, 27 Apr 2022 06:37:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3dCQA6zkaGIgEwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 27 Apr 2022 06:37:32 +0000
Message-ID: <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com>
Date:   Wed, 27 Apr 2022 08:37:31 +0200
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
 <20220426134021.11210-3-jgross@suse.com> <Ymgtb2dSNYz7DBqx@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
In-Reply-To: <Ymgtb2dSNYz7DBqx@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Tv20wGOiy6FQjb02RJyTGGbf"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Tv20wGOiy6FQjb02RJyTGGbf
Content-Type: multipart/mixed; boundary="------------g3LQIICVaZ9MN3qiKd20kOyb";
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
Message-ID: <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com>
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com> <Ymgtb2dSNYz7DBqx@zn.tnic>
In-Reply-To: <Ymgtb2dSNYz7DBqx@zn.tnic>

--------------g3LQIICVaZ9MN3qiKd20kOyb
Content-Type: multipart/mixed; boundary="------------UBo4NeYC7LUvi1M7vp3Ag3TK"

--------------UBo4NeYC7LUvi1M7vp3Ag3TK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDQuMjIgMTk6MzUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMjYsIDIwMjIgYXQgMDM6NDA6MjFQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+ICAgLyogcHJvdGVjdGVkIHZpcnR1YWxpemF0aW9uICovDQo+PiAgIHN0YXRpYyB2b2lk
IHB2X2luaXQodm9pZCkNCj4+ICAgew0KPj4gICAJaWYgKCFpc19wcm90X3ZpcnRfZ3Vlc3Qo
KSkNCj4+ICAgCQlyZXR1cm47DQo+PiAgIA0KPj4gKwlwbGF0Zm9ybV9zZXRfZmVhdHVyZShQ
TEFURk9STV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUNDRVNTKTsNCj4gDQo+IEtpbmRhIGxv
bmctaXNoIGZvciBteSB0YXN0ZS4gSSdsbCBwcm9iYWJseSBjYWxsIGl0Og0KPiANCj4gCXBs
YXRmb3JtX3NldCgpDQo+IA0KPiBhcyBpdCBpcyBpbXBsaWNpdCB0aGF0IGl0IHNldHMgYSBm
ZWF0dXJlIGJpdC4NCg0KT2theSwgZmluZSB3aXRoIG1lLg0KDQo+IA0KPj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L21tL21lbV9lbmNyeXB0X2lkZW50aXR5LmMgYi9hcmNoL3g4Ni9tbS9t
ZW1fZW5jcnlwdF9pZGVudGl0eS5jDQo+PiBpbmRleCBiNDNiYzI0ZDJiYjYuLjYwNDNiYTZj
ZDE3ZCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L21tL21lbV9lbmNyeXB0X2lkZW50aXR5
LmMNCj4+ICsrKyBiL2FyY2gveDg2L21tL21lbV9lbmNyeXB0X2lkZW50aXR5LmMNCj4+IEBA
IC00MCw2ICs0MCw3IEBADQo+PiAgICNpbmNsdWRlIDxsaW51eC9tbS5oPg0KPj4gICAjaW5j
bHVkZSA8bGludXgvbWVtX2VuY3J5cHQuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L2NjX3Bs
YXRmb3JtLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtLWZlYXR1cmUuaD4NCj4+
ICAgDQo+PiAgICNpbmNsdWRlIDxhc20vc2V0dXAuaD4NCj4+ICAgI2luY2x1ZGUgPGFzbS9z
ZWN0aW9ucy5oPg0KPj4gQEAgLTU2Niw2ICs1NjcsMTAgQEAgdm9pZCBfX2luaXQgc21lX2Vu
YWJsZShzdHJ1Y3QgYm9vdF9wYXJhbXMgKmJwKQ0KPj4gICAJfSBlbHNlIHsNCj4+ICAgCQkv
KiBTRVYgc3RhdGUgY2Fubm90IGJlIGNvbnRyb2xsZWQgYnkgYSBjb21tYW5kIGxpbmUgb3B0
aW9uICovDQo+PiAgIAkJc21lX21lX21hc2sgPSBtZV9tYXNrOw0KPj4gKw0KPj4gKwkJLyog
U2V0IHJlc3RyaWN0ZWQgbWVtb3J5IGFjY2VzcyBmb3IgdmlydGlvLiAqLw0KPj4gKwkJcGxh
dGZvcm1fc2V0X2ZlYXR1cmUoUExBVEZPUk1fVklSVElPX1JFU1RSSUNURURfTUVNX0FDQ0VT
Uyk7DQo+IA0KPiBIdWgsIHdoYXQgZG9lcyB0aGF0IGhhdmUgdG8gZG8gd2l0aCBTTUU/DQoN
CkkgcGlja2VkIHRoZSBmdW5jdGlvbiB3aGVyZSBzZXZfc3RhdHVzIGlzIGJlaW5nIHNldCwg
YXMgdGhpcyBzZWVtZWQgdG8gYmUNCnRoZSBjb3JyZWN0IHBsYWNlIHRvIHNldCB0aGUgZmVh
dHVyZSBiaXQuDQoNCkxvb2tpbmcgYXQgaXQgaW4gbW9yZSBkZXRhaWwgaXQgbWlnaHQgYmUg
cHJlZmVyYWJsZSB0byBkbyBpdCBpbg0Kc2V2X3NldHVwX2FyY2goKSBpbnN0ZWFkLg0KDQoN
Ckp1ZXJnZW4NCg==
--------------UBo4NeYC7LUvi1M7vp3Ag3TK
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------UBo4NeYC7LUvi1M7vp3Ag3TK--

--------------g3LQIICVaZ9MN3qiKd20kOyb--

--------------Tv20wGOiy6FQjb02RJyTGGbf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJo5KsFAwAAAAAACgkQsN6d1ii/Ey97
qQgAnhF1BQYikeBdShj94UJG4leGZg9I17mVpNA5whmgpqA9u8YaGSbb2KLlrW0qGAx5sJu1Zy2m
JYfTWc8Nqs9N67fq8iocL/5iiaULgIeYvAsr62I1znZELFaw9MAuCMQOZhPoVC39Rrsucp0RR39a
9nt/YL+8cu91+kbMcF7QkZ0ORb1Y5ZWOBRyIWkDRkGU/uFnmot16zNpuF1ccqzJagi/84SxlRbFE
e1B/3xYM/WyBCXFKKDNjYA27ct1EMkzIZ1lohSZSB0IgyWgN3nzB6d8ngjnrZhs3ChyhcTrawE/b
SgiX7TNHX44Q3PTTAyZs3FvJ5tVDGSSDXuJ4wAlVwg==
=niPG
-----END PGP SIGNATURE-----

--------------Tv20wGOiy6FQjb02RJyTGGbf--
