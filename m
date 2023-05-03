Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948BE6F50B1
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 09:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjECHJa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 May 2023 03:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjECHJ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 03:09:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B219272A;
        Wed,  3 May 2023 00:09:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D753322385;
        Wed,  3 May 2023 07:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683097764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=teAFqwFmUnax09TuiGG90Kj7kG6+48TX1tmrs49YNrk=;
        b=tUCwCKB0yD0DPwNpJBV0UjNNW8Pc2Tw1up+vtwWFbFULRjCUTM2r6XN97fpdpeDUsFrRLd
        piKtpzVfJdFFncRwHBH4A9GLbUn0kSC51ADu0zOJdn42pSMYJQLHSNfHItzb4FVIUckF2T
        ILfUkKY1mTGafy1tRkd67jr9sih0wIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683097764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=teAFqwFmUnax09TuiGG90Kj7kG6+48TX1tmrs49YNrk=;
        b=r2Odk1cw2e32jvI3AbMtbCk05d4jzD0gTvfM1aH+rVq9i59ptSJ85SasU9l54dvJrXnX1I
        ptaVbSF6VtrOoFBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 751D21331F;
        Wed,  3 May 2023 07:09:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FWCdG6QIUmSWRAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 03 May 2023 07:09:24 +0000
Message-ID: <563673c0-799d-e353-974c-91b1ab881a22@suse.de>
Date:   Wed, 3 May 2023 09:09:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/6] fbdev: Include <linux/io.h> via <asm/fb.h>
Content-Language: en-US
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
 <20230502130223.14719-5-tzimmermann@suse.de>
 <20230502195429.GA319489@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230502195429.GA319489@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pUWBDJ1Raj0NjYY4OLYhyeQp"
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pUWBDJ1Raj0NjYY4OLYhyeQp
Content-Type: multipart/mixed; boundary="------------bKIh6R9LGtMQp74D7VXZK0tl";
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
Message-ID: <563673c0-799d-e353-974c-91b1ab881a22@suse.de>
Subject: Re: [PATCH v3 4/6] fbdev: Include <linux/io.h> via <asm/fb.h>
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-5-tzimmermann@suse.de>
 <20230502195429.GA319489@ravnborg.org>
In-Reply-To: <20230502195429.GA319489@ravnborg.org>

--------------bKIh6R9LGtMQp74D7VXZK0tl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDIuMDUuMjMgdW0gMjE6NTQgc2NocmllYiBTYW0gUmF2bmJvcmc6DQo+IEhp
IFRob21hcywNCj4gDQo+IE9uIFR1ZSwgTWF5IDAyLCAyMDIzIGF0IDAzOjAyOjIxUE0gKzAy
MDAsIFRob21hcyBaaW1tZXJtYW5uIHdyb3RlOg0KPj4gRmJkZXYncyBtYWluIGhlYWRlciBm
aWxlLCA8bGludXgvZmIuaD4sIGluY2x1ZGVzIDxhc20vaW8uaD4gdG8gZ2V0DQo+PiBkZWNs
YXJhdGlvbnMgZm9yIEkvTyBoZWxwZXIgZnVuY3Rpb25zLiBGcm9tIHRoZXNlIGRlY2xhcmF0
aW9ucywgaXQNCj4+IGxhdGVyIGRlZmluZXMgZnJhbWVidWZmZXIgSS9PIGhlbHBlcnMsIHN1
Y2ggYXMgZmJfe3JlYWQsd3JpdGV9W2J3bHFdKCkNCj4+IG9yIGZiX21lbXNldCgpLg0KPj4N
Cj4+IFRoZSBmcmFtZWJ1ZmZlciBJL08gaGVscGVycyBkZXBlbmQgb24gdGhlIHN5c3RlbSBh
cmNoaXRlY3R1cmUgYW5kDQo+PiB3aWxsIHRoZXJlZm9yZSBiZSBtb3ZlZCBpbnRvIDxhc20v
ZmIuaD4uIFByZXBhcmUgdGhpcyBjaGFuZ2UgYnkgZmlyc3QNCj4+IGFkZGluZyBhbiBpbmNs
dWRlIHN0YXRlbWVudCBmb3IgPGxpbnV4L2lvLmg+IHRvIDxhc20tZ2VuZXJpYy9mYi5oPi4N
Cj4+IEluY2x1ZGUgPGFzbS9mYi5oPiBpbiBhbGwgc291cmNlIGZpbGVzIHRoYXQgdXNlIHRo
ZSBmcmFtZWJ1ZmZlciBJL08NCj4+IGhlbHBlcnMsIHNvIHRoYXQgdGhleSBzdGlsbCBnZXQg
dGhlIG5lY2Vzc2FyeSBJL08gZnVuY3Rpb25zLg0KPj4NCj4gLi4uDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvYXJrZmIuYyBiL2RyaXZlcnMvdmlkZW8vZmJk
ZXYvYXJrZmIuYw0KPj4gaW5kZXggNjBhOTZmZGI1ZGQ4Li5mZDM4ZThhMDczYjggMTAwNjQ0
DQo+PiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2Fya2ZiLmMNCj4+ICsrKyBiL2RyaXZl
cnMvdmlkZW8vZmJkZXYvYXJrZmIuYw0KPj4gQEAgLTI3LDYgKzI3LDggQEANCj4+ICAgI2lu
Y2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4gLyogV2h5IHNob3VsZCBmYiBkcml2ZXIgY2FsbCBj
b25zb2xlIGZ1bmN0aW9ucz8gYmVjYXVzZSBjb25zb2xlX2xvY2soKSAqLw0KPj4gICAjaW5j
bHVkZSA8dmlkZW8vdmdhLmg+DQo+PiAgIA0KPj4gKyNpbmNsdWRlIDxhc20vZmIuaD4NCj4g
DQo+IFdoZW4gd2UgaGF2ZSBhIGhlYWRlciBsaWtlIGxpbnV4L2ZiLmggLSBpdCBpcyBteSB1
bmRlcnN0YW5kaW5nIHRoYXQgaXQgaXMNCj4gcHJlZmVycmVkIHRvIGluY2x1ZGUgdGhhdCBm
aWxlLCBhbmQgbm90IHRoZSBhc20vZmIuaCB2YXJpYW50Lg0KPiANCj4gVGhpcyBpcyBhc3N1
bWluZyB0aGUgbGludXgvZmIuaCBjb250YWlucyB0aGUgZ2VuZXJpYyBzdHVmZiwgYW5kIGlu
Y2x1ZGVzDQo+IGFzbS9mYi5oIGZvciB0aGUgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHBhcnRz
Lg0KPiANCj4gU28gZHJpdmVycyB3aWxsIGluY2x1ZGUgbGludXgvZmIuaCBhbmQgdGhlbiB0
aGV5IGF1dG9tYXRpY2FsbHkgZ2V0IHRoZQ0KPiBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgcGFy
dHMgZnJvbSBhc20vZmIuaC4NCj4gDQo+IEluIG90aGVyIHdvcmRzLCBkcml2ZXJzIGFyZSBu
b3Qgc3VwcG9zZWQgdG8gaW5jbHVkZSBhc20vZmIuaCwgaWYNCj4gbGludXguZmIuaCBleGlz
dHMgLSBhbmQgbGludXgvZmIuaCBzaGFsbCBpbmNsdWRlIHRoZSBhc20vZmIuaC4NCj4gDQo+
IElmIHRoZSBhYm92ZSBob2xkcyB0cnVlLCB0aGVuIGl0IGlzIHdyb25nIGFuZCBub3QgbmVl
ZGVkIHRvIGFkZCBhc20vZmIuaA0KPiBhcyBzZWVuIGFib3ZlLg0KPiANCj4gDQo+IFRoZXJl
IGFyZSBjb3VudGxlc3MgZXhhbXBsZXMgd2hlcmUgdGhlIGFib3ZlIGFyZSBub3QgZm9sbG93
ZWQsDQo+IGJ1dCB0byBteSBiZXN0IHVuZGVyc3RhbmRpbmcgdGhlIGFib3ZlIGl0IHRoZSBw
cmVmZXJyZWQgd2F5IHRvIGRvIGl0Lg0KDQpXaGVyZSBkaWQgeW91aGVyIHRoaXM/IEkgb25s
eSBrbm93IGFib3V0IHRoaXMgaW4gdGhlIGNhc2Ugb2YgYXNtL2lvLmggDQp2cy4gbGludXgv
aW8uaC4NCg0KSWYgdGhhdCdzIHRoZSBjYXNlLCB3ZSBzaG91bGQgcHV0IHRob3NlIGhlbHBl
cnMgaW50byBhIG5ldyBoZWFkZXIgZmlsZSwgDQpiZWNhdXNlIG9uZSBvZiB0aGUgbW90aXZh
dGlvbnMgaGVyZSBpcyB0byByZW1vdmUgPGFzbS9pby5oPiBmcm9tIA0KPGxpbnV4L2ZiLmg+
Lg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KPiAJU2FtDQoNCi0tIA0KVGhvbWFz
IFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUg
U29sdXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2LCA5MDQ2MSBOdWVy
bmJlcmcsIEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFuZHJldyBNeWVycywgQW5kcmV3IE1j
RG9uYWxkLCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgwOSAoQUcgTnVlcm5iZXJnKQ0K

--------------bKIh6R9LGtMQp74D7VXZK0tl--

--------------pUWBDJ1Raj0NjYY4OLYhyeQp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRSCKQFAwAAAAAACgkQlh/E3EQov+CW
BQ//YDmcKk7ERaH80k2npCB1rdHjACWs3GOdia4iNkVhYtPfK/loYq5roG9jBM+wXyR2nOo+RLD7
0VtULvCiWgrJPT6BoA6hzeoOb+LGQ1gvDPJklhli0P+WaF13ibt8hnKPwJrCH19pjuRNtTzoSP1C
SYXmx0uSU+ffenGiJdDfCAikIruhy/8N1qSfhKFvOvzDbazitLCGPZwCr+jdbh3IwtnEXz1uaFjY
U+y7S/Z2CcvCqcGKsvyB/NnYg8zES/r0fwCzl5f4Y6jqr3jyU9Mi3wb2dbubLErIPkqiHsol7fmq
zC8SvTXJFqLe2zKke7yZc1L6phcFbWdpcf6DLRhaQDBmylbz8uzXHkOjxjHuI8pnAHLTvF/VkOtj
uZy/Reb7x0qboXTc2ivFUOwk2cKBJEwVab2hJFYdY4YAewUoINv+7vXs9XNoDjr8/LDmXLi+JYlu
h8A38vUXFD4pi5xeFG57n1XlXhIDv38IzjxeozkQZ/RyxGF/HAbLLL6aK7kNnEn6+nU1krrOtbEV
4w29Z2qCHW0LXsh1k0pGOEMx6K0w3gruoubOC4Wzr9sMom6tA31s11j21PHxYMLEtbhJMi0LzcNa
r0w/T9Co/W6rI+j5TAH0rZNyxAywrj8YZIDmg/E7wk1CElgMIsECcxlGW2k1+Opr928kYYM4L97M
50o=
=a/zq
-----END PGP SIGNATURE-----

--------------pUWBDJ1Raj0NjYY4OLYhyeQp--
