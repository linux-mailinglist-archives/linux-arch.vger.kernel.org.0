Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345066E4B2A
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 16:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjDQOQl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 10:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjDQOQk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 10:16:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA12CA5D7;
        Mon, 17 Apr 2023 07:16:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 281921F86C;
        Mon, 17 Apr 2023 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681740966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9FjKGooJn3lir0WMvbcOmP+8v9vNHx9fonOO/eGQRzE=;
        b=UueISTjhQ+q4JFg/UyjvmzxoxKSO1vQjyCaKu5z1YEprYuUJ1CDTkLXVMFCNYU1doB7f2B
        VRncFxCDSOQlMzPTnIA8K/N6aeFNkHgtlxXkkGsDOzzvplcAKEXEf/BL1/Ah8x9xE0W5sQ
        dU5kiHp9pH0evdxwJTCuU1ecq32ZPDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681740966;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9FjKGooJn3lir0WMvbcOmP+8v9vNHx9fonOO/eGQRzE=;
        b=+NUsXVOoXIxhKSKr919p9nprrZO/rsclOe9JA/Sh8LetYbc/OM9B1zIqCxgxOBly9bcu1w
        w/S8uqgQFerR+UDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A22ED13319;
        Mon, 17 Apr 2023 14:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7XEOJqVUPWRcDAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 17 Apr 2023 14:16:05 +0000
Message-ID: <b287fdf6-81ec-c25d-3f59-75cc8f63f844@suse.de>
Date:   Mon, 17 Apr 2023 16:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 16/19] arch/sh: Implement <asm/fb.h> with generic
 helpers
Content-Language: en-US
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
 <0b07fbadce4512e4696750cf69cf3fbbf38355a3.camel@physik.fu-berlin.de>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <0b07fbadce4512e4696750cf69cf3fbbf38355a3.camel@physik.fu-berlin.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------94ByKkIGSexm73INo0EWjmZz"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------94ByKkIGSexm73INo0EWjmZz
Content-Type: multipart/mixed; boundary="------------QXZ2BuEL3CAdRAw00ZDRM1Ri";
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
Message-ID: <b287fdf6-81ec-c25d-3f59-75cc8f63f844@suse.de>
Subject: Re: [PATCH v3 16/19] arch/sh: Implement <asm/fb.h> with generic
 helpers
References: <20230417125651.25126-1-tzimmermann@suse.de>
 <20230417125651.25126-17-tzimmermann@suse.de>
 <3c188e948506dc97112dcc070cf16e36209c6cc5.camel@physik.fu-berlin.de>
 <132f1185-d61f-b8c7-8d6e-4e4280a1a4ad@suse.de>
 <0b07fbadce4512e4696750cf69cf3fbbf38355a3.camel@physik.fu-berlin.de>
In-Reply-To: <0b07fbadce4512e4696750cf69cf3fbbf38355a3.camel@physik.fu-berlin.de>

--------------QXZ2BuEL3CAdRAw00ZDRM1Ri
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTcuMDQuMjMgdW0gMTY6MTMgc2NocmllYiBKb2huIFBhdWwgQWRyaWFuIEds
YXViaXR6Og0KPiBIaSBUaG9tYXMhDQo+IA0KPiBPbiBNb24sIDIwMjMtMDQtMTcgYXQgMTY6
MDYgKzAyMDAsIFRob21hcyBaaW1tZXJtYW5uIHdyb3RlOg0KPj4gSGkNCj4+DQo+PiBBbSAx
Ny4wNC4yMyB1bSAxNTowMiBzY2hyaWViIEpvaG4gUGF1bCBBZHJpYW4gR2xhdWJpdHo6DQo+
Pj4gSGkgVGhvbWFzIQ0KPj4+DQo+Pj4gT24gTW9uLCAyMDIzLTA0LTE3IGF0IDE0OjU2ICsw
MjAwLCBUaG9tYXMgWmltbWVybWFubiB3cm90ZToNCj4+Pj4gUmVwbGFjZSB0aGUgYXJjaGl0
ZWN0dXJlJ3MgZmJkZXYgaGVscGVycyB3aXRoIHRoZSBnZW5lcmljDQo+Pj4+IG9uZXMgZnJv
bSA8YXNtLWdlbmVyaWMvZmIuaD4uIE5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4+Pj4NCj4+
Pj4gdjI6DQo+Pj4+IAkqIHVzZSBkZWZhdWx0IGltcGxlbWVudGF0aW9uIGZvciBmYl9wZ3By
b3RlY3QoKSAoQXJuZCkNCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1l
cm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+DQo+Pj4+IENjOiBZb3NoaW5vcmkgU2F0byA8
eXNhdG9AdXNlcnMuc291cmNlZm9yZ2UuanA+DQo+Pj4+IENjOiBSaWNoIEZlbGtlciA8ZGFs
aWFzQGxpYmMub3JnPg0KPj4+PiBDYzogSm9obiBQYXVsIEFkcmlhbiBHbGF1Yml0eiA8Z2xh
dWJpdHpAcGh5c2lrLmZ1LWJlcmxpbi5kZT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGFyY2gvc2gv
aW5jbHVkZS9hc20vZmIuaCB8IDE1ICstLS0tLS0tLS0tLS0tLQ0KPj4+PiAgICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE0IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9zaC9pbmNsdWRlL2FzbS9mYi5oIGIvYXJjaC9zaC9pbmNsdWRl
L2FzbS9mYi5oDQo+Pj4+IGluZGV4IDlhMGJjYTI2ODZmZC4uMTlkZjEzZWU5Y2E3IDEwMDY0
NA0KPj4+PiAtLS0gYS9hcmNoL3NoL2luY2x1ZGUvYXNtL2ZiLmgNCj4+Pj4gKysrIGIvYXJj
aC9zaC9pbmNsdWRlL2FzbS9mYi5oDQo+Pj4+IEBAIC0yLDE5ICsyLDYgQEANCj4+Pj4gICAg
I2lmbmRlZiBfQVNNX0ZCX0hfDQo+Pj4+ICAgICNkZWZpbmUgX0FTTV9GQl9IXw0KPj4+PiAg
ICANCj4+Pj4gLSNpbmNsdWRlIDxsaW51eC9mYi5oPg0KPj4+PiAtI2luY2x1ZGUgPGxpbnV4
L2ZzLmg+DQo+Pj4+IC0jaW5jbHVkZSA8YXNtL3BhZ2UuaD4NCj4+Pj4gLQ0KPj4+PiAtc3Rh
dGljIGlubGluZSB2b2lkIGZiX3BncHJvdGVjdChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0
IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+Pj4+IC0JCQkJdW5zaWduZWQgbG9uZyBvZmYpDQo+
Pj4+IC17DQo+Pj4+IC0Jdm1hLT52bV9wYWdlX3Byb3QgPSBwZ3Byb3Rfd3JpdGVjb21iaW5l
KHZtYS0+dm1fcGFnZV9wcm90KTsNCj4+Pj4gLX0NCj4+Pg0KPj4+IExvb2tpbmcgYXQgdGhl
IG1hY3JvIGluIGFzbS1nZW5lcmljL2ZiLmgsIGZiX3BncHJvdGVjdCgpIGlzIGJlaW5nIHJl
cGxhY2VkIHdpdGgNCj4+PiBhIG5vLW9wIGZ1bmN0aW9uLiBJcyB0aGF0IGludGVudGlvbmFs
PyBDYW4geW91IGJyaWVmbHkgZXhwbGFpbiB0aGUgYmFja2dyb3VuZA0KPj4+IGZvciB0aGlz
IGNoYW5nZT8NCj4+DQo+PiBQYXRjaCAwMSBvZiB0aGlzIHBhdGNoc2V0IGNoYW5nZXMgdGhl
IGdlbmVyaWMgZmJfcGdwcm90ZWN0KCkgdG8gc2V0DQo+PiBwZ3Byb3Rfd3JpdGVjb21iaW5l
KCkuIFNvIG9uIFNILCB0aGVyZSBzaG91bGQgYmUgbm8gY2hhbmdlIGF0IGFsbC4NCj4+DQo+
IA0KPiBBaCwgSSBtaXNzZWQgdGhhdCwgdGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24uIExl
dCBtZSBjaGVjayBhbmQgQWNrIHlvdXIgcGF0Y2gNCg0KVGhhbmtzIQ0KDQo+IHRoZW4uIEkg
YXNzdW1lIHlvdSB3aWxsIGJlIHRha2luZyB0aGlzIHBhdGNoIGFzIHBhcnQgb2YgdGhlIHdo
b2xlIHNlcmllcyB0aHJvdWdoDQo+IHlvdXIgb3duIHRyZWU/DQoNClllcywgSSdkIG1lcmdl
IGl0IHRocm91Z2ggZHJtLW1pc2MtbmV4dCBpZGVhbGx5Lg0KDQpCZXN0IHJlZ2FyZHMNClRo
b21hcw0KDQo+IA0KPiBUaGFua3MsDQo+IEFkcmlhbg0KPiANCg0KLS0gDQpUaG9tYXMgWmlt
bWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1
dGlvbnMgR2VybWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdl
cm1hbnkNCihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xocmVyOiBJ
dm8gVG90ZXYNCg==

--------------QXZ2BuEL3CAdRAw00ZDRM1Ri--

--------------94ByKkIGSexm73INo0EWjmZz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmQ9VKUFAwAAAAAACgkQlh/E3EQov+Dw
Hw//TuN1hpDFybmdlm+Gzly6R8RqA/JO58uPl7V+zZ8/SdX9FcgbJLr07zjs6QGWIraTUb1teSjP
pldmO+zy7GEfChq3o+X96QwGmiyRSt/b2FbRhSvQvjtSIIBMSapXxjYVgmzfg84L4WA8jTY95dvP
p1MCxmosiaDcWlBchai72zcxcud3K/qp1xpyHwilOFblHXVO8FKoKmTP1iLEr2xxBA7m+lZfUaF+
fx9EyVgXwCLvFuaeGaOx7Ow0hSf5VvjizIMRwsqMt7VV1F8xK6Bz/eHPG7ptdkbUBv9uS4/YGVOR
Ue5tg91eEdRXmZV9qls6t0SwxBtArm/pr7KUBTVa+cLthtLtXI4RJTINnin6aA7GWsezQRpSR83u
DDWGlhPgHTsSkhAgHH3AjDZImtTkIjFR8HWtxyWMCFXmnoltujUU9SDlaXxx3MLIAWImo1S9V94i
ljyt+ETvSxvglKiS2PBJM2abRhdtGGWWFP/XQyqKAHQfIcilR4Y6HxMRK78dzvPvOQqwG0UkrwAK
v2ND/FRkgunPfWzsWpfgQNxlbIF8vOPsX3Rj52ur6KL0/MyC385HcSB0kP8+eA7fvWqYyv4jSE+l
2593WbYx64pvD+xtFgNDXAu0/4MVPyA7e/2e4ECI5KkgVwN5B6jNbkKk3tpPrJVLQfx9Y/Fsj3I3
kR8=
=u9yH
-----END PGP SIGNATURE-----

--------------94ByKkIGSexm73INo0EWjmZz--
