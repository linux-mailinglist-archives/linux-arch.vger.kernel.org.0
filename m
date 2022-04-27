Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D1C511157
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 08:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiD0GnY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 02:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbiD0GnX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 02:43:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786B61117F;
        Tue, 26 Apr 2022 23:40:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0AC381F388;
        Wed, 27 Apr 2022 06:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651041610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VMMhCTg9Mz44tbBAcPnS8dTXZRe/T0RsJs3CgplUBHw=;
        b=BGRU2O86KAhV+N0TXXa4Lzh5zasnW0BIvE0vflcAP9c1JUYO32qYZYHNH5dTYytFPDrMJ1
        Y7ySJZ94UG3/nmRYRlg8JSO0EoK8vT47ctmZ/+X1gBp167njPwojwdEneikLUusJ9S3NL5
        DWlc8ZgW9ExXInKOj9DK6zx847Qy0HE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46A641323E;
        Wed, 27 Apr 2022 06:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vsHyD0nlaGIoFAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 27 Apr 2022 06:40:09 +0000
Message-ID: <49e33b14-b439-340b-aa59-a6c77daa4929@suse.com>
Date:   Wed, 27 Apr 2022 08:40:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
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
 <YmhNNrLW+tM2gnZB@osiris>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <YmhNNrLW+tM2gnZB@osiris>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------S4HLpMY97WHW4YGrYFa7I3Pk"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------S4HLpMY97WHW4YGrYFa7I3Pk
Content-Type: multipart/mixed; boundary="------------w0zPX6ei5mincRTkBIeAwr5i";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
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
Message-ID: <49e33b14-b439-340b-aa59-a6c77daa4929@suse.com>
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com> <Ymgtb2dSNYz7DBqx@zn.tnic>
 <YmhNNrLW+tM2gnZB@osiris>
In-Reply-To: <YmhNNrLW+tM2gnZB@osiris>

--------------w0zPX6ei5mincRTkBIeAwr5i
Content-Type: multipart/mixed; boundary="------------e82U6XVXXlBrBuGa7pUvQIO7"

--------------e82U6XVXXlBrBuGa7pUvQIO7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDQuMjIgMjE6NTEsIEhlaWtvIENhcnN0ZW5zIHdyb3RlOg0KPiBPbiBUdWUsIEFw
ciAyNiwgMjAyMiBhdCAwNzozNTo0M1BNICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+PiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAwMzo0MDoyMVBNICswMjAwLCBKdWVyZ2Vu
IEdyb3NzIHdyb3RlOg0KPj4+ICAgLyogcHJvdGVjdGVkIHZpcnR1YWxpemF0aW9uICovDQo+
Pj4gICBzdGF0aWMgdm9pZCBwdl9pbml0KHZvaWQpDQo+Pj4gICB7DQo+Pj4gICAJaWYgKCFp
c19wcm90X3ZpcnRfZ3Vlc3QoKSkNCj4+PiAgIAkJcmV0dXJuOw0KPj4+ICAgDQo+Pj4gKwlw
bGF0Zm9ybV9zZXRfZmVhdHVyZShQTEFURk9STV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUND
RVNTKTsNCj4+DQo+PiBLaW5kYSBsb25nLWlzaCBmb3IgbXkgdGFzdGUuIEknbGwgcHJvYmFi
bHkgY2FsbCBpdDoNCj4+DQo+PiAJcGxhdGZvcm1fc2V0KCkNCj4+DQo+PiBhcyBpdCBpcyBp
bXBsaWNpdCB0aGF0IGl0IHNldHMgYSBmZWF0dXJlIGJpdC4NCj4gDQo+IC4uLmFuZCBwbGF0
Zm9ybV9jbGVhcigpLCBpbnN0ZWFkIG9mIHBsYXRmb3JtX3Jlc2V0X2ZlYXR1cmUoKSBwbGVh
c2UuDQoNCkZpbmUgd2l0aCBtZS4NCg0KPiANCj4+IEluIGFueSBjYXNlLCB5ZWFoLCBsb29r
cyBvayBhdCBhIHF1aWNrIGdsYW5jZS4gSXQgd291bGQgb2J2aW91c2x5IG5lZWQNCj4+IGZv
ciBtb3JlIHBlb3BsZSB0byBsb29rIGF0IGl0IGFuZCBzYXkgd2hldGhlciBpdCBtYWtlcyBz
ZW5zZSB0byB0aGVtIGFuZA0KPj4gd2hldGhlciB0aGF0J3MgZmluZSB0byBoYXZlIGluIGdl
bmVyaWMgY29kZSBidXQgc28gZmFyLCB0aGUgZXhwZXJpZW5jZQ0KPj4gd2l0aCBjY19wbGF0
Zm9ybV8qIHNheXMgdGhhdCBpdCBzZWVtcyB0byB3b3JrIG9rIGluIGdlbmVyaWMgY29kZS4N
Cj4gDQo+IFdlIF9jb3VsZF8gY29udmVydCBzMzkwJ3MgbWFjaGluZSBmbGFncyB0byB0aGlz
IG1lY2hhbmlzbS4gVGhvc2UgZmxhZ3MNCj4gYXJlIGhpc3RvcmljYWxseSBwZXItY3B1LCBi
dXQgaWYgSSdtIG5vdCBtaXN0YWtlbiBub25lIG9mIHRoZW0gaXMNCj4gcGVyZm9ybWFuY2Ug
Y3JpdGljYWwgYW55bW9yZSwgYW5kIHRob3NlIHdobyBhcmUgY291bGQvc2hvdWxkIHByb2Jh
Ymx5DQo+IHRyYW5zZm9ybWVkIHRvIGp1bXAgbGFiZWxzIG9yIGFsdGVybmF0aXZlcyBhbnl3
YXkuDQoNCkkgd2FzIHBsYW5uaW5nIHRvIGxvb2sgYXQgdGhlIHg4NiBjcHUgZmVhdHVyZXMg
dG8gc2VlIHdoZXRoZXIgc29tZSBvZg0KdGhvc2UgbWlnaHQgYmUgY2FuZGlkYXRlcyB0byBi
ZSBzd2l0Y2hlZCB0byBwbGF0Zm9ybSBmZWF0dXJlcyBpbnN0ZWFkLg0KDQoNCkp1ZXJnZW4N
Cg==
--------------e82U6XVXXlBrBuGa7pUvQIO7
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------e82U6XVXXlBrBuGa7pUvQIO7--

--------------w0zPX6ei5mincRTkBIeAwr5i--

--------------S4HLpMY97WHW4YGrYFa7I3Pk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJo5UgFAwAAAAAACgkQsN6d1ii/Ey+n
HAgAlI5tgqXfIHi9klo7ckJBdbCjT2EvYU2yTBe7BacJ6ocCDc+0WxtX4/ckT9AImG4krsTHVb0K
SQ6XTp1DtFKIsFbvK9T3z6eSwe1v+nSe3E+5Eym+GFcl8KdMCSvm06H+/rWGBa4eQasYftWopVLd
bzywDXij4CbKqhHiELGFQR1xO+iOQxJA3vjTFSXq+ZemjPXIEBCU2p/nTnspcpVh+sN4T3tAjVgi
rUUf4obOqAbi1fdTlgEZSBgyu108VYYWE2oBZZ2Al5QRmdK/PMIw081eOt20Vi315rvWCpAy/nIY
unnqv1osxafnDog4t4KjQi4QGmxMbZndp636gvQwyQ==
=vLJU
-----END PGP SIGNATURE-----

--------------S4HLpMY97WHW4YGrYFa7I3Pk--
