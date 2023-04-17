Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984596E4ADB
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 16:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjDQOIE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 10:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjDQOIC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 10:08:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D957D8B;
        Mon, 17 Apr 2023 07:07:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C91F21A28;
        Mon, 17 Apr 2023 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681740431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5T4MhxBCVh4Dwah+8fjZvCkTMdHGwawNBvVHKsG6tY=;
        b=jZVtWrXArwQcX2K1MTzB3D/NJnDVu4ZQRj7pZRA9fc97UqnGoLijIRKgTCb1ryCPsivtyu
        7SFWb628UK4xhGP405L+4fM/MSRu+DKg50UqrBpNmyZt8svnsD48cNiGH7vKVp5MB9ph/u
        NbY6LWOvcGYYmI3wyxTyDJohrOXr0zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681740431;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5T4MhxBCVh4Dwah+8fjZvCkTMdHGwawNBvVHKsG6tY=;
        b=ebqyi3yeY0j77TM5+A01rboJTzpU+qSTFd4CX1OkSIdwueUbP3Y3C1LUsB/xQ5Nq2LKR1i
        8Wpphz9D+gML5kDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBC7013319;
        Mon, 17 Apr 2023 14:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MZGQMI5SPWTmBgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 17 Apr 2023 14:07:10 +0000
Message-ID: <8e47f91e-709b-453f-55e5-a7abd2dfe1dd@suse.de>
Date:   Mon, 17 Apr 2023 16:07:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 16/19] arch/sh: Implement <asm/fb.h> with generic
 helpers
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        arnd@arndb.de, daniel.vetter@ffwll.ch, deller@gmx.de,
        javierm@redhat.com, gregkh@linuxfoundation.org
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20230417125651.25126-1-tzimmermann@suse.de>
 <20230417125651.25126-17-tzimmermann@suse.de>
 <3c188e948506dc97112dcc070cf16e36209c6cc5.camel@physik.fu-berlin.de>
 <132f1185-d61f-b8c7-8d6e-4e4280a1a4ad@suse.de>
In-Reply-To: <132f1185-d61f-b8c7-8d6e-4e4280a1a4ad@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LVOx1zhK1GiNc5gf0x0yrW6V"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------LVOx1zhK1GiNc5gf0x0yrW6V
Content-Type: multipart/mixed; boundary="------------Oij1eafi1qbbuLq7DujHcwp0";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, arnd@arndb.de,
 daniel.vetter@ffwll.ch, deller@gmx.de, javierm@redhat.com,
 gregkh@linuxfoundation.org
Cc: linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
 Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Message-ID: <8e47f91e-709b-453f-55e5-a7abd2dfe1dd@suse.de>
Subject: Re: [PATCH v3 16/19] arch/sh: Implement <asm/fb.h> with generic
 helpers
References: <20230417125651.25126-1-tzimmermann@suse.de>
 <20230417125651.25126-17-tzimmermann@suse.de>
 <3c188e948506dc97112dcc070cf16e36209c6cc5.camel@physik.fu-berlin.de>
 <132f1185-d61f-b8c7-8d6e-4e4280a1a4ad@suse.de>
In-Reply-To: <132f1185-d61f-b8c7-8d6e-4e4280a1a4ad@suse.de>

--------------Oij1eafi1qbbuLq7DujHcwp0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDE3LjA0LjIzIHVtIDE2OjA2IHNjaHJpZWIgVGhvbWFzIFppbW1lcm1hbm46DQo+
IEhpDQo+IA0KPiBBbSAxNy4wNC4yMyB1bSAxNTowMiBzY2hyaWViIEpvaG4gUGF1bCBBZHJp
YW4gR2xhdWJpdHo6DQo+PiBIaSBUaG9tYXMhDQo+Pg0KPj4gT24gTW9uLCAyMDIzLTA0LTE3
IGF0IDE0OjU2ICswMjAwLCBUaG9tYXMgWmltbWVybWFubiB3cm90ZToNCj4+PiBSZXBsYWNl
IHRoZSBhcmNoaXRlY3R1cmUncyBmYmRldiBoZWxwZXJzIHdpdGggdGhlIGdlbmVyaWMNCj4+
PiBvbmVzIGZyb20gPGFzbS1nZW5lcmljL2ZiLmg+LiBObyBmdW5jdGlvbmFsIGNoYW5nZXMu
DQo+Pj4NCj4+PiB2MjoNCj4+PiDCoMKgwqDCoCogdXNlIGRlZmF1bHQgaW1wbGVtZW50YXRp
b24gZm9yIGZiX3BncHJvdGVjdCgpIChBcm5kKQ0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
VGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+DQo+Pj4gQ2M6IFlvc2hp
bm9yaSBTYXRvIDx5c2F0b0B1c2Vycy5zb3VyY2Vmb3JnZS5qcD4NCj4+PiBDYzogUmljaCBG
ZWxrZXIgPGRhbGlhc0BsaWJjLm9yZz4NCj4+PiBDYzogSm9obiBQYXVsIEFkcmlhbiBHbGF1
Yml0eiA8Z2xhdWJpdHpAcGh5c2lrLmZ1LWJlcmxpbi5kZT4NCj4+PiAtLS0NCj4+PiDCoCBh
cmNoL3NoL2luY2x1ZGUvYXNtL2ZiLmggfCAxNSArLS0tLS0tLS0tLS0tLS0NCj4+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE0IGRlbGV0aW9ucygtKQ0KPj4+DQo+
Pj4gZGlmZiAtLWdpdCBhL2FyY2gvc2gvaW5jbHVkZS9hc20vZmIuaCBiL2FyY2gvc2gvaW5j
bHVkZS9hc20vZmIuaA0KPj4+IGluZGV4IDlhMGJjYTI2ODZmZC4uMTlkZjEzZWU5Y2E3IDEw
MDY0NA0KPj4+IC0tLSBhL2FyY2gvc2gvaW5jbHVkZS9hc20vZmIuaA0KPj4+ICsrKyBiL2Fy
Y2gvc2gvaW5jbHVkZS9hc20vZmIuaA0KPj4+IEBAIC0yLDE5ICsyLDYgQEANCj4+PiDCoCAj
aWZuZGVmIF9BU01fRkJfSF8NCj4+PiDCoCAjZGVmaW5lIF9BU01fRkJfSF8NCj4+PiAtI2lu
Y2x1ZGUgPGxpbnV4L2ZiLmg+DQo+Pj4gLSNpbmNsdWRlIDxsaW51eC9mcy5oPg0KPj4+IC0j
aW5jbHVkZSA8YXNtL3BhZ2UuaD4NCj4+PiAtDQo+Pj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBm
Yl9wZ3Byb3RlY3Qoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCANCj4+PiB2bV9hcmVhX3N0
cnVjdCAqdm1hLA0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWdu
ZWQgbG9uZyBvZmYpDQo+Pj4gLXsNCj4+PiAtwqDCoMKgIHZtYS0+dm1fcGFnZV9wcm90ID0g
cGdwcm90X3dyaXRlY29tYmluZSh2bWEtPnZtX3BhZ2VfcHJvdCk7DQo+Pj4gLX0NCj4+DQo+
PiBMb29raW5nIGF0IHRoZSBtYWNybyBpbiBhc20tZ2VuZXJpYy9mYi5oLCBmYl9wZ3Byb3Rl
Y3QoKSBpcyBiZWluZyANCj4+IHJlcGxhY2VkIHdpdGgNCj4+IGEgbm8tb3AgZnVuY3Rpb24u
IElzIHRoYXQgaW50ZW50aW9uYWw/IENhbiB5b3UgYnJpZWZseSBleHBsYWluIHRoZSANCj4+
IGJhY2tncm91bmQNCj4+IGZvciB0aGlzIGNoYW5nZT8NCj4gDQo+IFBhdGNoIDAxIG9mIHRo
aXMgcGF0Y2hzZXQgY2hhbmdlcyB0aGUgZ2VuZXJpYyBmYl9wZ3Byb3RlY3QoKSB0byBzZXQg
DQo+IHBncHJvdF93cml0ZWNvbWJpbmUoKS4gU28gb24gU0gsIHRoZXJlIHNob3VsZCBiZSBu
byBjaGFuZ2UgYXQgYWxsLg0KDQpJbiBjYXNlIHlvdSBkaWRuJ3QgcmVjZWl2ZSB0aGF0IHBh
dGNoOg0KDQogICBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvNTMy
NDkzLz9zZXJpZXM9MTE2MTU3JnJldj0zDQoNCj4gDQo+IEJlc3QgcmVnYXJkcw0KPiBUaG9t
YXMNCj4gDQo+Pg0KPj4+IC1zdGF0aWMgaW5saW5lIGludCBmYl9pc19wcmltYXJ5X2Rldmlj
ZShzdHJ1Y3QgZmJfaW5mbyAqaW5mbykNCj4+PiAtew0KPj4+IC3CoMKgwqAgcmV0dXJuIDA7
DQo+Pj4gLX0NCj4+PiArI2luY2x1ZGUgPGFzbS1nZW5lcmljL2ZiLmg+DQo+Pj4gwqAgI2Vu
ZGlmIC8qIF9BU01fRkJfSF8gKi8NCj4+DQo+PiBUaGFua3MsDQo+PiBBZHJpYW4NCj4+DQo+
IA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVy
DQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUs
IDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0K
R2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBUb3Rldg0K

--------------Oij1eafi1qbbuLq7DujHcwp0--

--------------LVOx1zhK1GiNc5gf0x0yrW6V
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmQ9Uo4FAwAAAAAACgkQlh/E3EQov+CS
pBAAo2JJR67w7LPURPKx/8t2f2Qliq6PmBA3TZLDGgPfIZYSxLaJEYpvuAVB/sJjcfltSVe6WJJa
5wfygJ67w0Y3B9/BSrbHtP+rYLxJzwXAf7oLD6u5Kn2PQjvqCrXvLPOb8Km0QSVSE8p3VfH5A+pg
/nP1aM7lmeoWpMtqMVd+kaN6NBjqCETVK7sbQy0CWSCaihiv03JzA8CN6YeB08JKH6j0KfPIAxwU
oUaZgSCw9kdfSyfDyJBQgUhLAHYeHWRNN4zfU6T8ceUwzE8l158xMGJ8jWwGPN/6McqbDshJQWaX
vvHKw31WF28f2iir/9s70D9UHiadwM2YHYe1nERe2elA/2fp8YKiOVSLl8BdKB8FTVZZksXW3VNQ
p/fAHtFv8eoZQj3tiU0//xgV7I7oVRT6UrGxkge8ciU3eotqxyoUTisMBQLac9ZUqDVBt62L8DNk
jR4pL144T9NEupYbsdHi9d+InNxwuRBDxG6rkecR08Wuu7ENKQiAF8Lscg1yvxM8Hjm6x11OrYhm
f5sw6dTYtZYPp5owz6rOk1+pr3YuumRM+ABYrleyzM/i3sh6FkWpx8XjjyPh0eUsz0zHQEJWUu4T
17U3h3J0h7tQdwuXbXcyjqFUmJJIDGJIi3vuY3AKT2IJfNsI/hgfzuuD5YRQsjLpAw1eLkpuB+Dp
Yjw=
=cBq6
-----END PGP SIGNATURE-----

--------------LVOx1zhK1GiNc5gf0x0yrW6V--
