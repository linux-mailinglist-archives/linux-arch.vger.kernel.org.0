Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249215117BE
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 14:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiD0Msq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 08:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiD0Mso (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 08:48:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8593525B;
        Wed, 27 Apr 2022 05:45:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A51F1F74D;
        Wed, 27 Apr 2022 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651063532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f7ZHfk6vc4zgMEvq1EHLWCpOl8Ctk3WE3DXvA6Vjt/4=;
        b=LiLK+JGui8QqQfh8W0x16+mObrzQ4Fje12HfJW7hZ94icLHhk5/gxq7NXXopwsraglIWhT
        Qd+AOsn2O2Sdx7LAy0xcvnBIeKxo3jyuqUv8fKgeFG52VhHZAC84a1GKao9KAOQYtVsvJz
        LsOjzmiktuf5OEUJjFiQxiW5Rg42mrI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8719C1323E;
        Wed, 27 Apr 2022 12:45:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KZu6H+s6aWKXRAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 27 Apr 2022 12:45:31 +0000
Message-ID: <3f15f128-4d77-14e2-20ca-ea2e4a7d4181@suse.com>
Date:   Wed, 27 Apr 2022 14:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
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
 <YmhNNrLW+tM2gnZB@osiris> <49e33b14-b439-340b-aa59-a6c77daa4929@suse.com>
 <Ymk2gXuNGFhIQ2zQ@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
In-Reply-To: <Ymk2gXuNGFhIQ2zQ@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5RSoFKl9gkDkNvOmD7dR6fME"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5RSoFKl9gkDkNvOmD7dR6fME
Content-Type: multipart/mixed; boundary="------------WqbtrtgMwxh4M25yqpBhfhy8";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Arnd Bergmann <arnd@arndb.de>, Vasily Gorbik <gor@linux.ibm.com>,
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
Message-ID: <3f15f128-4d77-14e2-20ca-ea2e4a7d4181@suse.com>
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com> <Ymgtb2dSNYz7DBqx@zn.tnic>
 <YmhNNrLW+tM2gnZB@osiris> <49e33b14-b439-340b-aa59-a6c77daa4929@suse.com>
 <Ymk2gXuNGFhIQ2zQ@zn.tnic>
In-Reply-To: <Ymk2gXuNGFhIQ2zQ@zn.tnic>

--------------WqbtrtgMwxh4M25yqpBhfhy8
Content-Type: multipart/mixed; boundary="------------lFn82CY4z1MtnopLJeWnduYk"

--------------lFn82CY4z1MtnopLJeWnduYk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDQuMjIgMTQ6MjYsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBB
cHIgMjcsIDIwMjIgYXQgMDg6NDA6MDhBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEkgd2FzIHBsYW5uaW5nIHRvIGxvb2sgYXQgdGhlIHg4NiBjcHUgZmVhdHVyZXMgdG8g
c2VlIHdoZXRoZXIgc29tZSBvZg0KPj4gdGhvc2UgbWlnaHQgYmUgY2FuZGlkYXRlcyB0byBi
ZSBzd2l0Y2hlZCB0byBwbGF0Zm9ybSBmZWF0dXJlcyBpbnN0ZWFkLg0KPiANCj4gSSdkIHNh
eSAibmV2ZXIgdG91Y2ggYSBydW5uaW5nIHN5c3RlbSIgdW5sZXNzIHRoZSBwbGF0Zm9ybSBm
ZWF0dXJlcyBhcmUNCj4gb2YgYW4gYWR2YW50YWdlLi4uDQoNCkRlcGVuZHMgb24gdGhlIHVz
ZSBjYXNlIElNSE8uDQoNCkFsbCBmZWF0dXJlcyBiZWluZyBiYXNlZCBvbiBhIGNwdWlkIGJp
dCBhcmUgbm8gY2FuZGlkYXRlcy4gU2FtZSBhcHBsaWVzDQp0byBhbGwgZmVhdHVyZXMgdXNl
ZCBmb3IgYWx0ZXJuYXRpdmUgaGFuZGxpbmcgKGFzc3VtaW5nIHdlIGRvbid0IHdhbnQNCnRv
IGV4cGFuZCB0aGF0IHRvIHBsYXRmb3JtIGZlYXR1cmVzKS4NCg0KSSByZWFsbHkgaGF2ZSBu
byBpZGVhIHdoZXRoZXIgdGhpcyB3aWxsIGxlYXZlIGFueSBjYW5kaWRhdGVzLiBJbiBjYXNl
DQppdCBkb2VzLCBpdCBtaWdodCBiZSBpbnRlcmVzdGluZyB0byBzd2l0Y2ggdGhvc2UgaW4g
b3JkZXIgdG8gc2F2ZSBzb21lDQpwZXItY3B1IGJpdHMuDQoNCk90aGVyIGNhbmRpZGF0ZXMg
bWlnaHQgYmUgdGhlIHg4Nl9sZWdhY3lfZmVhdHVyZXMuDQoNCg0KSnVlcmdlbg0K
--------------lFn82CY4z1MtnopLJeWnduYk
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------lFn82CY4z1MtnopLJeWnduYk--

--------------WqbtrtgMwxh4M25yqpBhfhy8--

--------------5RSoFKl9gkDkNvOmD7dR6fME
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJpOusFAwAAAAAACgkQsN6d1ii/Ey+J
OQf/eUrJzkec/zE1iDKcyCbxADGvHuoQyWnYHfvAB7VqIJ5P8IyobJW0GEt+L9K8PkJ+fgDqhl+Q
DLBculdTiZCP7wh6Q0zXUvrPHMyUQafp9NHctNSSJurMdndFqvSM+TKuNGZaVDTvsSZfgAGaBy63
VKKADB1mJo2S0fG9wvLrirCyn1rKvPYhfdErZuqS078u9Mj4V4YmE3uz6WqSFUfnqJwBlAGZXM4X
4cbBEgQ8WPfhkyNKi18UOMTQaWEnVkLBJjmeXJ4hGtbTcJFLpAbSKPIJTWv6jI+U9Ca5xjSIw6zt
PgaS84cJYWG2/xJoqqxt6EVIA4wCf66w6+bFTXyOCw==
=lXDm
-----END PGP SIGNATURE-----

--------------5RSoFKl9gkDkNvOmD7dR6fME--
