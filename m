Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31536F5075
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 08:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjECG7G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 May 2023 02:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECG7F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 02:59:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D94C2684;
        Tue,  2 May 2023 23:58:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1DFCD20014;
        Wed,  3 May 2023 06:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683097131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SDkDQ0H4x2vY2WbWItoTPoQwTbRYly8kay1++EV5PPw=;
        b=c8vFGsLxEEKQIkTWs9AQHjqWQ9gsc5Ml1bqJhe+nH2by02o3jByzLOusJQK3w8uAaYuFvu
        mqj1QjROkyso+37VLhF4QF4IHJ81WUDUrUoY88Csh9pZji7FJOOahyajPzaOGlrQ1xoLuI
        P1PgBANvBPu/UXqbPYF8r6Z1cezIpac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683097131;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SDkDQ0H4x2vY2WbWItoTPoQwTbRYly8kay1++EV5PPw=;
        b=w1J2fR1IuDhWIWF1iA3LujC9H/zlly0tvktPaF5nGO2r1Fv5P9/DcBvllFAHj5hog10rTX
        C1tOVxFVbDkUatDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEBE913584;
        Wed,  3 May 2023 06:58:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZzeQKSoGUmQjPwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 03 May 2023 06:58:50 +0000
Message-ID: <df767237-2bae-f299-9cbb-1543f76c9c3a@suse.de>
Date:   Wed, 3 May 2023 08:58:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 5/6] fbdev: Move framebuffer I/O helpers into
 <asm/fb.h>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        arnd@arndb.de, deller@gmx.de, chenhuacai@kernel.org,
        javierm@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        James.Bottomley@hansenpartnership.com,
        linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org,
        linux-parisc@vger.kernel.org, vgupta@kernel.org,
        sparclinux@vger.kernel.org, kernel@xen0n.name,
        linux-snps-arc@lists.infradead.org, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-6-tzimmermann@suse.de>
 <20230502200300.GB319489@ravnborg.org>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230502200300.GB319489@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jQs64Jy6GElwzzZZ39a0RUOn"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jQs64Jy6GElwzzZZ39a0RUOn
Content-Type: multipart/mixed; boundary="------------6tQ2AHuGFxKZaLti4bsSA0S0";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, arnd@arndb.de,
 deller@gmx.de, chenhuacai@kernel.org, javierm@redhat.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 James.Bottomley@hansenpartnership.com, linux-m68k@lists.linux-m68k.org,
 geert@linux-m68k.org, linux-parisc@vger.kernel.org, vgupta@kernel.org,
 sparclinux@vger.kernel.org, kernel@xen0n.name,
 linux-snps-arc@lists.infradead.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Message-ID: <df767237-2bae-f299-9cbb-1543f76c9c3a@suse.de>
Subject: Re: [PATCH v3 5/6] fbdev: Move framebuffer I/O helpers into
 <asm/fb.h>
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-6-tzimmermann@suse.de>
 <20230502200300.GB319489@ravnborg.org>
In-Reply-To: <20230502200300.GB319489@ravnborg.org>

--------------6tQ2AHuGFxKZaLti4bsSA0S0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgU2FtDQoNCkFtIDAyLjA1LjIzIHVtIDIyOjAzIHNjaHJpZWIgU2FtIFJhdm5ib3JnOg0K
PiBIaSBUaG9tYXMsDQo+IA0KPiBPbiBUdWUsIE1heSAwMiwgMjAyMyBhdCAwMzowMjoyMlBN
ICswMjAwLCBUaG9tYXMgWmltbWVybWFubiB3cm90ZToNCj4+IEltcGxlbWVudCBmcmFtZWJ1
ZmZlciBJL08gaGVscGVycywgc3VjaCBhcyBmYl9yZWFkKigpIGFuZCBmYl93cml0ZSooKSwN
Cj4+IGluIHRoZSBhcmNoaXRlY3R1cmUncyA8YXNtL2ZiLmg+IGhlYWRlciBmaWxlIG9yIHRo
ZSBnZW5lcmljIG9uZS4NCj4gDQo+IEluIHJlYWxpdHkgdGhleSBhcmUgbm93IGFsbCBpbXBs
ZW1lbnRlZCBpbiB0aGUgZ2VuZXJpYyBvbmUuDQo+IA0KPj4NCj4+IFRoZSBjb21tb24gY2Fz
ZSBoYXMgYmVlbiB0aGUgdXNlIG9mIHJlZ3VsYXIgSS9PIGZ1bmN0aW9ucywgc3VjaCBhcw0K
Pj4gX19yYXdfcmVhZGIoKSBvciBtZW1zZXRfaW8oKS4gQSBmZXcgYXJjaGl0ZWN0dXJlcyB1
c2VkIHBsYWluIHN5c3RlbS0NCj4+IG1lbW9yeSByZWFkcyBhbmQgd3JpdGVzLiBTcGFyYyB1
c2VkIGhlbHBlcnMgZm9yIGl0cyBTQnVzLg0KPj4NCj4+IFRoZSBhcmNoaXRlY3R1cmVzIHRo
YXQgdXNlZCBzcGVjaWFsIGNhc2VzIHByb3ZpZGUgdGhlIHNhbWUgY29kZSBpbg0KPj4gdGhl
aXIgX19yYXdfKigpIEkvTyBoZWxwZXJzLiBTbyB0aGUgcGF0Y2ggcmVwbGFjZXMgdGhpcyBj
b2RlIHdpdGggdGhlDQo+PiBfX3Jhd18qKCkgZnVuY3Rpb25zIGFuZCBtb3ZlcyBpdCB0byA8
YXNtLWdlbmVyaWMvZmIuaD4gZm9yIGFsbA0KPj4gYXJjaGl0ZWN0dXJlcy4NCj4gV2hpY2gg
aXMgYWxzbyBkb2N1bWVudGVkIGhlcmUuDQoNClRoZSBmaXJzdCBwYXJhZ3JhcGggZG9jdW1l
bnRzIHRoZSBkZXNpZ24gaW50ZW50aW9uLCB0aGUgb3RoZXIgb25lIHRoZSANCmltcGxlbWVu
dGF0aW9uLiBCdXQgSSBhZ3JlZSB0aGF0IGl0J3Mgbm90IHdlbGwgcGhyYXNlZC4gSSdsbCBz
ZWUgaWYgSSANCmNhbiBpbXByb3ZlIHRoZSB0ZXh0Lg0KDQo+IA0KPj4NCj4+IHYzOg0KPj4g
CSogaW1wbGVtZW50IGFsbCBhcmNoaXRlY3R1cmVzIHdpdGggZ2VuZXJpYyBoZWxwZXJzDQo+
PiAJKiBzdXBwb3J0IHJlb3JkZXJpbmcgYW5kIG5hdGl2ZSBieXRlIG9yZGVyIChHZWVydCwg
QXJuZCkNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1l
cm1hbm5Ac3VzZS5kZT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL2FzbS1nZW5lcmljL2ZiLmgg
fCAxMDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGlu
Y2x1ZGUvbGludXgvZmIuaCAgICAgICB8ICA1MyAtLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDEwMSBpbnNlcnRpb25zKCspLCA1MyBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9mYi5oIGIvaW5jbHVk
ZS9hc20tZ2VuZXJpYy9mYi5oDQo+PiBpbmRleCA2OTIyZGQyNDhjNTEuLjA1NDBlY2NkYmVj
YSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvZmIuaA0KPj4gKysrIGIv
aW5jbHVkZS9hc20tZ2VuZXJpYy9mYi5oDQo+PiBAQCAtMzEsNCArMzEsMTA1IEBAIHN0YXRp
YyBpbmxpbmUgaW50IGZiX2lzX3ByaW1hcnlfZGV2aWNlKHN0cnVjdCBmYl9pbmZvICppbmZv
KQ0KPj4gICB9DQo+PiAgICNlbmRpZg0KPj4gICANCj4+ICsvKg0KPj4gKyAqIEkvTyBoZWxw
ZXJzIGZvciB0aGUgZnJhbWVidWZmZXIuIFByZWZlciB0aGVzZSBmdW5jdGlvbnMgb3ZlciB0
aGVpcg0KPj4gKyAqIHJlZ3VsYXIgY291bnRlcnBhcnRzLiBUaGUgcmVndWxhciBJL08gZnVu
Y3Rpb25zIHByb3ZpZGUgaW4tb3JkZXINCj4+ICsgKiBhY2Nlc3MgYW5kIHN3YXAgYnl0ZXMg
dG8vZnJvbSBsaXR0bGUtZW5kaWFuIG9yZGVyaW5nLiBOZWl0aGVyIGlzDQo+PiArICogcmVx
dWlyZWQgZm9yIGZyYW1lYnVmZmVycy4gSW5zdGVhZCwgdGhlIGhlbHBlcnMgcmVhZCBhbmQg
d3JpdGUNCj4+ICsgKiByYXcgZnJhbWVidWZmZXIgZGF0YS4gSW5kZXBlbmRlbnQgb3BlcmF0
aW9ucyBjYW4gYmUgcmVvcmRlcmVkIGZvcg0KPj4gKyAqIGltcHJvdmVkIHBlcmZvcm1hbmNl
Lg0KPj4gKyAqLw0KPj4gKw0KPj4gKyNpZm5kZWYgZmJfcmVhZGINCj4+ICtzdGF0aWMgaW5s
aW5lIHU4IGZiX3JlYWRiKGNvbnN0IHZvbGF0aWxlIHZvaWQgX19pb21lbSAqYWRkcikNCj4+
ICt7DQo+PiArCXJldHVybiBfX3Jhd19yZWFkYihhZGRyKTsNCj4+ICt9DQo+PiArI2RlZmlu
ZSBmYl9yZWFkYiBmYl9yZWFkYg0KPj4gKyNlbmRpZg0KPiANCj4gV2hlbiB3ZSBuZWVkIHRv
IHByb3ZpZGUgYW4gYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHZhcmlhbnQgdGhlDQo+ICNpZm5k
ZWYgZm9vDQo+IC4uLg0KPiAjZGVmaW5lIGZvbyBmb28NCj4gY2FuIGJlIGFkZGVkLiBSaWdo
dCBub3cgaXQgaXMganVzdCBub2lzZSBhcyBubyBhcmNoaXRlY3R1cmVzIHByb3ZpZGUNCj4g
dGhlaXIgb3duIHZhcmlhbnRzLg0KDQpHaXZlbiBBcm5kJ3MgY29tbWVudHMsIHRoaXMgbWln
aHQgY2hhbmdlLiBJdCBhbHNvIG1ha2VzIHNlbnNlIGZyb20gYSANCmRlc2lnbiBQT1YuDQoN
Cj4gDQo+IEJ1dCBJIGFtIG1pc3Npbmcgc29tZXRoaW5nIHNvbWV3aGVyZSBhcyBJIGNhbm5v
dCBzZWUgaG93IHRoaXMgYnVpbGRzLg0KPiBhc20tZ2VuZXJpYyBub3cgcHJvdmlkZSB0aGUg
ZmJfcmVhZC9mYl93cml0ZSBoZWxwZXJzLg0KPiBCdXQgZm9yIGV4YW1wbGUgc3BhcmMgaGFz
IGFuIGFyY2hpdGVjdHVyZSBzcGVjaWZjIGZiLmggc28gaXQgd2lsbCBub3QNCj4gdXNlIHRo
ZSBhc20tZ2VuZXJpYyB2YXJpYW50LiBTbyBJIHdvbmRlciBob3cgc3BhcmMgZ2V0IGhvbGQg
b2YgdGhlDQo+IGFzbS1nZW5lcmljIGZiLmggZmlsZT8NCg0KQWxsIGFyY2hpdGVjdHVyZSdz
IDxhc20vZmIuaD4gZmlsZXMgaW5jbHVkZSA8YXNtLWdlbmVyaWMvZmIuaD4sIHNvIHRoYXQg
DQp0aGV5IGFsbCBnZXQgdGhlIGludGVyZmFjZXMgd2hpY2ggdGhleSBkb24ndCBkZWZpbmUg
dGhlbXNlbHZlcy4gRm9yIA0KU3BhcmMsIHRoaXMgaXMgYXQgWzFdLg0KDQpCZXN0IHJlZ2Fy
ZHMNClRob21hcw0KDQoNClsxXSANCmh0dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcvZHJt
L2RybS10aXAvdHJlZS9hcmNoL3NwYXJjL2luY2x1ZGUvYXNtL2ZiLmgjbjE5DQoNCj4gDQo+
IE1heWJlIGl0IGlzIG9idmlvdXMsIGJ1dCBJIG1pc3MgaXQuDQo+IA0KPiAJU2FtDQoNCi0t
IA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0Ug
U29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2LCA5
MDQ2MSBOdWVybmJlcmcsIEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFuZHJldyBNeWVycywg
QW5kcmV3IE1jRG9uYWxkLCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgwOSAoQUcgTnVlcm5i
ZXJnKQ0K

--------------6tQ2AHuGFxKZaLti4bsSA0S0--

--------------jQs64Jy6GElwzzZZ39a0RUOn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRSBikFAwAAAAAACgkQlh/E3EQov+AB
AQ//Xy5yckNa6c2mse8zcM+Y9bB7wfXqbQhoEPFy2yWTqJHcmP2aJB3aVG2otT/HddHEI4vilkcR
Ne72cVsqADctlBeqMUM/BkO5IENzhY3OXthSn/um2HUi4S2O3PT9IscF51G2IKjA5HveoODrxmPK
g6hJvgM9CJyrJnoBRSfs6JEM8frbWMUxUB/EWqiN1+1oerGdp9M4K3ZCs1o47T5dXHpxeew+Z5dE
4eDSesMGgZt7F410j7PFE69+6mOKpIsnUa0eqybt+3srJtbMSB6hbKv9z0ExVC7C+UFOWTm3qBKr
1NlVz752xhh1+/RcFWRy+G1H/1tBG+bU4Eu7Mx4sWG8ZVU6drco4STfmZyXKAiQfqt3aiQHEOEX4
Uzf/wj97PEwKwTlj78s5zV6E3xTySna8kghEb4dAhBqbtDIbmh9MHeKJWi+Wt5jB3DyKBlcAPjlA
qmrAU3JIr4ZmN/9W7XJtA+MKfmpeY6T2XvAr9AW7p4qhzC7R69Qc2iq40pgswRa6stJYoFFAmF88
tzuAsfTnu0rW/9p8dwA3fxWFmJV1iw6uW71Sh8r4okDUpnjLmMT351MZB2/nd7de71CwMw07tFww
aiF2Gzvo9AVvoB6cY4hfZxN4nVGQS4APlMwUO7jHSMPj/l2L+XNcQKG3dxs/h8Bwi6vEVWkFhww3
0W8=
=Xb0b
-----END PGP SIGNATURE-----

--------------jQs64Jy6GElwzzZZ39a0RUOn--
