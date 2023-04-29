Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBA26F24A5
	for <lists+linux-arch@lfdr.de>; Sat, 29 Apr 2023 14:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjD2M0R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Apr 2023 08:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjD2M0Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Apr 2023 08:26:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD7F199B;
        Sat, 29 Apr 2023 05:26:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 886AE21AD9;
        Sat, 29 Apr 2023 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682771173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ggHjBqSIfzeqcVtGsNuNiNCmozKORAe1+aPPd89K2Zo=;
        b=gTmI3qC52L6UapKnmdBrpTYkRo+blaTmZ+xqAtZthGf3NWsd77H1PPxPpBlGcazt6SKDe8
        vNhd49xkN0Rqx1ocjYvQqNFFBMsShzkqugczm+9ra9L6uYqGgC0TPNVZQLNcs+CFDu9Gn0
        pIaiu5WIocPIe9hlB/2hwQskx28q5gY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682771173;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ggHjBqSIfzeqcVtGsNuNiNCmozKORAe1+aPPd89K2Zo=;
        b=L4Zc58oyVTd4UKL+MonKy5CY8zkM6HMZb5L7fiOLMtNrFeMy78aWw46Qmn1G9n/fSO1DPL
        DgTKrJpyZ6IWA6Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F67A138E0;
        Sat, 29 Apr 2023 12:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MgW7BuUMTWRUSAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Sat, 29 Apr 2023 12:26:13 +0000
Message-ID: <df6fa134-3a62-0872-e008-393e4a29a5ab@suse.de>
Date:   Sat, 29 Apr 2023 14:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 5/5] fbdev: Define framebuffer I/O from Linux' I/O
 functions
To:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Vineet Gupta <vgupta@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "David S . Miller" <davem@davemloft.net>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-6-tzimmermann@suse.de>
 <430c73f0-45f4-f81e-6506-bc8cc955d936@arm.com>
 <CAMuHMdUGjtiAR37L4_e0_p8ee2=gxoUj7+e7rqMLTBK+vpV4yw@mail.gmail.com>
 <f612c682-5767-4a58-82f6-f4a4d1b592a1@app.fastmail.com>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <f612c682-5767-4a58-82f6-f4a4d1b592a1@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MelAIvX5Zq5p7fTWZnZe1KnI"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------MelAIvX5Zq5p7fTWZnZe1KnI
Content-Type: multipart/mixed; boundary="------------XHeCVpw7PiHVQpg0Jphmy7XG";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Helge Deller <deller@gmx.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Vineet Gupta <vgupta@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 "David S . Miller" <davem@davemloft.net>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Message-ID: <df6fa134-3a62-0872-e008-393e4a29a5ab@suse.de>
Subject: Re: [PATCH v2 5/5] fbdev: Define framebuffer I/O from Linux' I/O
 functions
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-6-tzimmermann@suse.de>
 <430c73f0-45f4-f81e-6506-bc8cc955d936@arm.com>
 <CAMuHMdUGjtiAR37L4_e0_p8ee2=gxoUj7+e7rqMLTBK+vpV4yw@mail.gmail.com>
 <f612c682-5767-4a58-82f6-f4a4d1b592a1@app.fastmail.com>
In-Reply-To: <f612c682-5767-4a58-82f6-f4a4d1b592a1@app.fastmail.com>

--------------XHeCVpw7PiHVQpg0Jphmy7XG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjguMDQuMjMgdW0gMTU6MTcgc2NocmllYiBBcm5kIEJlcmdtYW5uOg0KPiBP
biBGcmksIEFwciAyOCwgMjAyMywgYXQgMTM6MjcsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90
ZToNCj4+IE9uIEZyaSwgQXByIDI4LCAyMDIzIGF0IDI6MTjigK9QTSBSb2JpbiBNdXJwaHkg
PHJvYmluLm11cnBoeUBhcm0uY29tPiB3cm90ZToNCj4+PiBPbiAyMDIzLTA0LTI4IDEwOjI3
LCBUaG9tYXMgWmltbWVybWFubiB3cm90ZToNCj4gDQo+Pj4+IC0NCj4+Pj4gLSNlbGlmIGRl
ZmluZWQoX19pMzg2X18pIHx8IGRlZmluZWQoX19hbHBoYV9fKSB8fCBkZWZpbmVkKF9feDg2
XzY0X18pIHx8ICAgICAgXA0KPj4+PiAtICAgICBkZWZpbmVkKF9faHBwYV9fKSB8fCBkZWZp
bmVkKF9fc2hfXykgfHwgZGVmaW5lZChfX3Bvd2VycGNfXykgfHwgXA0KPj4+PiAtICAgICBk
ZWZpbmVkKF9fYXJtX18pIHx8IGRlZmluZWQoX19hYXJjaDY0X18pIHx8IGRlZmluZWQoX19t
aXBzX18pDQo+Pj4+IC0NCj4+Pj4gLSNkZWZpbmUgZmJfcmVhZGIgX19yYXdfcmVhZGINCj4+
Pj4gLSNkZWZpbmUgZmJfcmVhZHcgX19yYXdfcmVhZHcNCj4+Pj4gLSNkZWZpbmUgZmJfcmVh
ZGwgX19yYXdfcmVhZGwNCj4+Pj4gLSNkZWZpbmUgZmJfcmVhZHEgX19yYXdfcmVhZHENCj4+
Pj4gLSNkZWZpbmUgZmJfd3JpdGViIF9fcmF3X3dyaXRlYg0KPj4+PiAtI2RlZmluZSBmYl93
cml0ZXcgX19yYXdfd3JpdGV3DQo+Pj4+IC0jZGVmaW5lIGZiX3dyaXRlbCBfX3Jhd193cml0
ZWwNCj4+Pj4gLSNkZWZpbmUgZmJfd3JpdGVxIF9fcmF3X3dyaXRlcQ0KPj4+DQo+Pj4gTm90
ZSB0aGF0IG9uIGF0IGxlYXN0IHNvbWUgYXJjaGl0ZWN0dXJlcywgdGhlIF9fcmF3IHZhcmlh
bnRzIGFyZQ0KPj4+IG5hdGl2ZS1lbmRpYW4sIHdoZXJlYXMgdGhlIHJlZ3VsYXIgYWNjZXNz
b3JzIGFyZSBleHBsaWNpdGx5DQo+Pj4gbGl0dGxlLWVuZGlhbiwgc28gdGhlcmUgaXMgYSBz
bGlnaHQgcmlzayBvZiBpbmFkdmVydGVudGx5IGNoYW5naW5nDQo+Pj4gYmVoYXZpb3VyIG9u
IGJpZy1lbmRpYW4gc3lzdGVtcyAoTUlQUyBtb3N0IGxpa2VseSwgYnV0IGEgZmV3IG9sZCBB
Uk0NCj4+PiBwbGF0Zm9ybXMgcnVuIEJFIGFzIHdlbGwpLg0KPj4NCj4+IEFsc28gb24gbTY4
aywgd2hlbiBJU0Egb3IgUENJIGFyZSBlbmFibGVkLg0KPj4NCj4+IEluIGFkZGl0aW9uLCB0
aGUgbm9uLXJhdyB2YXJpYW50cyBtYXkgZG8gc29tZSBleHRyYXMgdG8gZ3VhcmFudGVlDQo+
PiBvcmRlcmluZywgd2hpY2ggeW91IGRvIG5vdCBuZWVkIG9uIGEgZnJhbWUgYnVmZmVyLg0K
Pj4NCj4+IFNvIEknZCBnbyBmb3IgdGhlIF9fcmF3XyooKSB2YXJpYW50cyBldmVyeXdoZXJl
Lg0KPiANCj4gVGhlIG9ubHkgaW1wbGVtZW50YXRpb25zIGluIGZiZGV2IGFyZQ0KPiANCj4g
ICAxKSBzcGFyYyBzYnVzDQo+ICAgMikgX19yYXdfd3JpdGVsDQo+ICAgMykgZGlyZWN0IHBv
aW50ZXIgZGVyZWZlcmVuY2UNCj4gDQo+IEJ1dCBub25lIHVzZSB0aGUgYnl0ZS1zd2FwcGlu
ZyB3cml0ZWwoKSBpbXBsZW1lbnRhdGlvbnMsIGFuZA0KPiB0aGUgb25seSBvbmVzIHRoYXQg
dXNlIHRoZSBkaXJlY3QgcG9pbnRlciBkZXJlZmVyZW5jZSBvciBzYnVzDQo+IGFyZSB0aGUg
b25lcyBvbiB3aGljaCB0aGVzZSBhcmUgZGVmaW5lZCB0aGUgc2FtZSBhcyBfX3Jhd193cml0
ZWwNCg0KQWZ0ZXIgdGhpbmtpbmcgYSBiaXQgbW9yZSBhYm91dCB0aGUgcmVxdWlyZW1lbnRz
LCBJJ2QgbGlrZSB0byBnb3QgYmFjayANCnRvIHYxLCBidXQgd2l0aCBhIGRpZmZlcmVudCBz
cGluLiBXZSB3YW50IHRvIGF2b2lkIG9yZGVyaW5nIGd1YXJhbnRlZXMsIA0Kc28gSSBsb29r
ZWQgYXQgdGhlIF9yZWxheGVkKCkgaGVscGVycywgYnV0IHRoZXkgc2VlbSB0byBzd2FwIGJ5
dGVzIHRvIA0KbGl0dGxlIGVuZGlhbi4NCg0KSSBndWVzcyB3ZSBjYW4gcmVtb3ZlIHRoZSBm
Yl9tZW0qKCkgZnVuY3Rpb25zIGVudGlyZWx5LiBUaGV5IGFyZSB0aGUgDQpzYW1lIGFzIHRo
ZSBub24tZmJfIGNvdW50ZXJwYXJ0cy4gRm9yIHRoZSBmYiByZWFkL3dyaXRlIGhlbHBlcnMs
IEknZCANCmxpa2UgdG8gYWRkIHRoZW0gdG8gPGFzbS1nZW5lcmljL2ZiLmg+IGluIGEgcGxh
dGZvcm0tbmV1dHJhbCB3YXkuIFRoZXknZCANCmJlIHdyYXBwZXJzIGFyb3VuZCBfX3Jhd18o
KSwgYXMgSSB3b3VsZG4ndCB3YW50IGludm9jYXRpb25zIG9mICBfX3Jhd18oKSANCmZ1bmN0
aW9ucyBpbiB0aGUgZmJkZXYgZHJpdmVycy4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0K
PiANCj4gICAgICAgIEFybmQNCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3Mg
RHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJI
DQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkwNDYxIE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2
byBUb3RldiwgQW5kcmV3IE15ZXJzLCBBbmRyZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1h
bg0KSFJCIDM2ODA5IChBRyBOdWVybmJlcmcpDQo=

--------------XHeCVpw7PiHVQpg0Jphmy7XG--

--------------MelAIvX5Zq5p7fTWZnZe1KnI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRNDOQFAwAAAAAACgkQlh/E3EQov+D3
Lg//UhCZBw81TYQDkk+UDr1YbkaGi4Jm2mT/EtMUo2aiopJRpbN8vontw/beFlngxSqtHGbuE+eV
/Nw3zAhT/0FwyIfz9cckarUnhgWjtozXXAzefE/fvRNS1IpfOd4Z+/HAFpf14aUFX58Ieonzrx0K
IAUrczjg9YkqH/rjBuQN6esPDuGO6UAnwoPcfsR0LJ8rYA8u21otEL8TJmc6YrLxV8vRDi8F4pfg
2psTsyd3crIGm2ldrDL7fc8SCJr7pBcrkEM9LJ8TU4iVcEWQ+VinDr6aiworLArjL7td/jSrX8yL
NgbWRrsLwsh50JtyFgO68P9ujhhD83DyZ6jRMLVCaUCWYH03srIBWqkf7jePnQ3ZnyRtPGuX13a1
+OchiuFDSLb7gUO4YmnIYiSvrNWi+xAbDZopxKynXrqqOyz9qCY1/pTSnVY4W1BZm1DmpYFa/LJ0
8ASU+1FXKvGU9rDjh9vdm4aK44qqavzduSEDltIQF5rSGjltfpBMnGXaBr7ZF5B+Q9ty5Bsw63Kh
ksU8M/nayR7toWgtbiAAuLnzz04kv5VRdLVsgY3AEw+H6wz1alVp0SBJNFGJ1CIwjxQ2tFpEcAp4
+tfWD38puBNHk3K2WeT0O152tqPrzhw+6qws+j8SPgTx/gUaxU0jY4JjSgMXSlnum9vnakiOPQFn
Jl4=
=PPwW
-----END PGP SIGNATURE-----

--------------MelAIvX5Zq5p7fTWZnZe1KnI--
