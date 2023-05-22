Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F2370BE87
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjEVMjD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjEVMi7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:38:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30017E0;
        Mon, 22 May 2023 05:38:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D4001FDE2;
        Mon, 22 May 2023 12:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684759103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5MneQuFeddG2Xj764D+w3Ciyy+UZG/xny7oJL0WA34M=;
        b=ETlYj+naL05KLguB6PuGcO5Th9rx5gFAkuKb1Ggecrvk5SphhNjLGpgHCs7rNdddtQLdYk
        Je1T7DrR28/pf4H1P2nJJVgkkegNjHbs4oQUHMcqR5/xB5pYG/jvZCAPxtM3KinmAf87Tg
        4vs624fYpi/qiMk0jFWU98339UzR8L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684759103;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5MneQuFeddG2Xj764D+w3Ciyy+UZG/xny7oJL0WA34M=;
        b=Ai6R2dZtb3Am3DFxE3rbNK8aS7PodbV2PFRyWaGDi3ZVY5XnpAeyKlNFXL17NMcJzJUS2H
        7ogFnH9i9udVoyDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A93113776;
        Mon, 22 May 2023 12:38:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i11xAT9ia2T5XQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 22 May 2023 12:38:23 +0000
Message-ID: <2043cea3-7553-ee9d-4aaa-6f1d22ac4d87@suse.de>
Date:   Mon, 22 May 2023 14:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 09/44] drm: handle HAS_IOPORT dependencies
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Alan Stern <stern@rowland.harvard.edu>,
        spice-devel@lists.freedesktop.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-10-schnelle@linux.ibm.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230522105049.1467313-10-schnelle@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------omS0egi6Wc0vNZ4XIw6nTILI"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------omS0egi6Wc0vNZ4XIw6nTILI
Content-Type: multipart/mixed; boundary="------------9Azw0qm8fKudHTn0V0bmWTvi";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Niklas Schnelle <schnelle@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 Alan Stern <stern@rowland.harvard.edu>, spice-devel@lists.freedesktop.org,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <2043cea3-7553-ee9d-4aaa-6f1d22ac4d87@suse.de>
Subject: Re: [PATCH v5 09/44] drm: handle HAS_IOPORT dependencies
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-10-schnelle@linux.ibm.com>
In-Reply-To: <20230522105049.1467313-10-schnelle@linux.ibm.com>

--------------9Azw0qm8fKudHTn0V0bmWTvi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjIuMDUuMjMgdW0gMTI6NTAgc2NocmllYiBOaWtsYXMgU2NobmVsbGU6DQo+
IEluIGEgZnV0dXJlIHBhdGNoIEhBU19JT1BPUlQ9biB3aWxsIHJlc3VsdCBpbiBpbmIoKS9v
dXRiKCkgYW5kIGZyaWVuZHMNCj4gbm90IGJlaW5nIGRlY2xhcmVkLiBXZSB0aHVzIG5lZWQg
dG8gYWRkIEhBU19JT1BPUlQgYXMgZGVwZW5kZW5jeSBmb3INCj4gdGhvc2UgZHJpdmVycyB1
c2luZyB0aGVtLiBJbiB0aGUgYm9jaHMgZHJpdmVyIHRoZXJlIGlzIG9wdGlvbmFsIE1NSU8N
Cj4gc3VwcG9ydCBkZXRlY3RlZCBhdCBydW50aW1lLCB3YXJuIGlmIHRoaXMgaXNuJ3QgdGFr
ZW4gd2hlbg0KPiBIQVNfSU9QT1JUIGlzIG5vdCBkZWZpbmVkLg0KPiANCj4gVGhlcmUgaXMg
YWxzbyBhIGRpcmVjdCBhbmQgaGFyZCBjb2RlZCB1c2UgaW4gY2lycnVzLmMgd2hpY2ggYWNj
b3JkaW5nIHRvDQo+IHRoZSBjb21tZW50IGlzIG9ubHkgbmVjZXNzYXJ5IGR1cmluZyByZXN1
bWUuICBMZXQncyBqdXN0IHNraXAgdGhpcyBhcw0KPiBmb3IgZXhhbXBsZSBzMzkwIHdoaWNo
IGRvZXNuJ3QgaGF2ZSBJL08gcG9ydCBzdXBwb3J0IGFsc28gZG9lc2VuJ3QNCj4gc3VwcG9y
dCBzdXNwZW5kL3Jlc3VtZS4NCg0KSSB0aGluayB3ZSBzaG91bGQgY29uc2lkZXIgbWFraW5n
IGNpcnJ1cyBkZXBlbmQgb24gSEFTX0lPUE9SVC4gVGhlIA0KZHJpdmVyIGlzIG9ubHkgZm9y
IHFlbXUncyBjaXJydXMgZW11bGF0aW9uLCB3aGljaCBJSVJDIGNhbiBvbmx5IGJlIA0KZW5h
YmxlZCBmb3IgaTU4Ni4gQW5kIGl0IGhhcyBhbGwgYmVlbiBkZXByZWNhdGVkIGxvbmcgYWdv
Lg0KDQo+IA0KPiBDby1kZXZlbG9wZWQtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVs
Lm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBrZXJuZWwub3Jn
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBOaWtsYXMgU2NobmVsbGUgPHNjaG5lbGxlQGxpbnV4Lmli
bS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9xeGwvS2NvbmZpZyAgIHwgIDEg
Kw0KPiAgIGRyaXZlcnMvZ3B1L2RybS90aW55L2JvY2hzLmMgIHwgMTcgKysrKysrKysrKysr
KysrKysNCj4gICBkcml2ZXJzL2dwdS9kcm0vdGlueS9jaXJydXMuYyB8ICAyICsrDQo+ICAg
MyBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3F4bC9LY29uZmlnIGIvZHJpdmVycy9ncHUvZHJtL3F4bC9LY29u
ZmlnDQo+IGluZGV4IGNhM2Y1MWMyYThmZS4uZDBlMGQ0NDBjOGQ5IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vcXhsL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L3F4bC9LY29uZmlnDQo+IEBAIC0yLDYgKzIsNyBAQA0KPiAgIGNvbmZpZyBEUk1fUVhMDQo+
ICAgCXRyaXN0YXRlICJRWEwgdmlydHVhbCBHUFUiDQo+ICAgCWRlcGVuZHMgb24gRFJNICYm
IFBDSSAmJiBNTVUNCj4gKwlkZXBlbmRzIG9uIEhBU19JT1BPUlQNCj4gICAJc2VsZWN0IERS
TV9LTVNfSEVMUEVSDQo+ICAgCXNlbGVjdCBEUk1fVFRNDQo+ICAgCXNlbGVjdCBEUk1fVFRN
X0hFTFBFUg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3RpbnkvYm9jaHMuYyBi
L2RyaXZlcnMvZ3B1L2RybS90aW55L2JvY2hzLmMNCj4gaW5kZXggZDI1NDY3OWExMzZlLi4z
NzEwMzM5NDA3Y2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90aW55L2JvY2hz
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3RpbnkvYm9jaHMuYw0KPiBAQCAtMiw2ICsy
LDcgQEANCj4gICANCj4gICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ICAgI2luY2x1
ZGUgPGxpbnV4L3BjaS5oPg0KPiArI2luY2x1ZGUgPGFzbS9idWcuaD4NCg0KV2h5IG5vdCA8
bGludXgvYnVnLmg+ID8NCg0KPiAgIA0KPiAgICNpbmNsdWRlIDxkcm0vZHJtX2FwZXJ0dXJl
Lmg+DQo+ICAgI2luY2x1ZGUgPGRybS9kcm1fYXRvbWljX2hlbHBlci5oPg0KPiBAQCAtMTA1
LDcgKzEwNiw5IEBAIHN0YXRpYyB2b2lkIGJvY2hzX3ZnYV93cml0ZWIoc3RydWN0IGJvY2hz
X2RldmljZSAqYm9jaHMsIHUxNiBpb3BvcnQsIHU4IHZhbCkNCj4gICANCj4gICAJCXdyaXRl
Yih2YWwsIGJvY2hzLT5tbWlvICsgb2Zmc2V0KTsNCj4gICAJfSBlbHNlIHsNCj4gKyNpZmRl
ZiBDT05GSUdfSEFTX0lPUE9SVA0KPiAgIAkJb3V0Yih2YWwsIGlvcG9ydCk7DQo+ICsjZW5k
aWYNCg0KV291bGQgaXQgYmUgZmVhc2libGUgdG8gZGVmaW5lIGluYiwgaW53LCBvdXRiIGFu
ZCBvdXR3IGF0IHRoZSB0b3Agb2YgDQpib2Nocy5jIGlmIG5vIEhBU19JT1BPUlQgaGFzIGJl
ZW4gc2V0PyAgVGhhdCB3b3VsZCBhdm9pZCB0aGUgaWZkZWYgDQpicmFuY2hpbmcgd2l0aGlu
IHRoZSBjb2RlLg0KDQo+ICAgCX0NCj4gICB9DQo+ICAgDQo+IEBAIC0xMTksNyArMTIyLDEx
IEBAIHN0YXRpYyB1OCBib2Noc192Z2FfcmVhZGIoc3RydWN0IGJvY2hzX2RldmljZSAqYm9j
aHMsIHUxNiBpb3BvcnQpDQo+ICAgDQo+ICAgCQlyZXR1cm4gcmVhZGIoYm9jaHMtPm1taW8g
KyBvZmZzZXQpOw0KPiAgIAl9IGVsc2Ugew0KPiArI2lmZGVmIENPTkZJR19IQVNfSU9QT1JU
DQo+ICAgCQlyZXR1cm4gaW5iKGlvcG9ydCk7DQo+ICsjZWxzZQ0KPiArCQlyZXR1cm4gMHhm
ZjsNCj4gKyNlbmRpZg0KPiAgIAl9DQo+ICAgfQ0KPiAgIA0KPiBAQCAtMTMyLDggKzEzOSwx
MiBAQCBzdGF0aWMgdTE2IGJvY2hzX2Rpc3BpX3JlYWQoc3RydWN0IGJvY2hzX2RldmljZSAq
Ym9jaHMsIHUxNiByZWcpDQo+ICAgDQo+ICAgCQlyZXQgPSByZWFkdyhib2Nocy0+bW1pbyAr
IG9mZnNldCk7DQo+ICAgCX0gZWxzZSB7DQo+ICsjaWZkZWYgQ09ORklHX0hBU19JT1BPUlQN
Cj4gICAJCW91dHcocmVnLCBWQkVfRElTUElfSU9QT1JUX0lOREVYKTsNCj4gICAJCXJldCA9
IGludyhWQkVfRElTUElfSU9QT1JUX0RBVEEpOw0KPiArI2Vsc2UNCj4gKwkJcmV0ID0gMHhm
ZmZmOw0KPiArI2VuZGlmDQo+ICAgCX0NCj4gICAJcmV0dXJuIHJldDsNCj4gICB9DQo+IEBA
IC0xNDUsOCArMTU2LDEwIEBAIHN0YXRpYyB2b2lkIGJvY2hzX2Rpc3BpX3dyaXRlKHN0cnVj
dCBib2Noc19kZXZpY2UgKmJvY2hzLCB1MTYgcmVnLCB1MTYgdmFsKQ0KPiAgIA0KPiAgIAkJ
d3JpdGV3KHZhbCwgYm9jaHMtPm1taW8gKyBvZmZzZXQpOw0KPiAgIAl9IGVsc2Ugew0KPiAr
I2lmZGVmIENPTkZJR19IQVNfSU9QT1JUDQo+ICAgCQlvdXR3KHJlZywgVkJFX0RJU1BJX0lP
UE9SVF9JTkRFWCk7DQo+ICAgCQlvdXR3KHZhbCwgVkJFX0RJU1BJX0lPUE9SVF9EQVRBKTsN
Cj4gKyNlbmRpZg0KPiAgIAl9DQo+ICAgfQ0KPiAgIA0KPiBAQCAtMjI5LDYgKzI0MiwxMCBA
QCBzdGF0aWMgaW50IGJvY2hzX2h3X2luaXQoc3RydWN0IGRybV9kZXZpY2UgKmRldikNCj4g
ICAJCQlyZXR1cm4gLUVOT01FTTsNCj4gICAJCX0NCj4gICAJfSBlbHNlIHsNCj4gKwkJaWYg
KCFJU19FTkFCTEVEKENPTkZJR19IQVNfSU9QT1JUKSkgew0KPiArCQkJRFJNX0VSUk9SKCJJ
L08gcG9ydHMgYXJlIG5vdCBzdXBwb3J0ZWRcbiIpOw0KDQpVc2UgZHJtX2VycigpIGhlcmUu
DQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gKwkJCXJldHVybiAtRUlPOw0KPiArCQl9
DQo+ICAgCQlpb2FkZHIgPSBWQkVfRElTUElfSU9QT1JUX0lOREVYOw0KPiAgIAkJaW9zaXpl
ID0gMjsNCj4gICAJCWlmICghcmVxdWVzdF9yZWdpb24oaW9hZGRyLCBpb3NpemUsICJib2No
cy1kcm0iKSkgew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3RpbnkvY2lycnVz
LmMgYi9kcml2ZXJzL2dwdS9kcm0vdGlueS9jaXJydXMuYw0KPiBpbmRleCA1OTRiYzQ3Mjg2
MmYuLmM2NWZlYTA0OWJjNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Rpbnkv
Y2lycnVzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3RpbnkvY2lycnVzLmMNCj4gQEAg
LTUwOCw4ICs1MDgsMTAgQEAgc3RhdGljIHZvaWQgY2lycnVzX2NydGNfaGVscGVyX2F0b21p
Y19lbmFibGUoc3RydWN0IGRybV9jcnRjICpjcnRjLA0KPiAgIA0KPiAgIAljaXJydXNfbW9k
ZV9zZXQoY2lycnVzLCAmY3J0Y19zdGF0ZS0+bW9kZSk7DQo+ICAgDQo+ICsjaWZkZWYgQ09O
RklHX0hBU19JT1BPUlQNCj4gICAJLyogVW5ibGFuayAobmVlZGVkIG9uIFMzIHJlc3VtZSwg
dmdhYmlvcyBkb2Vzbid0IGRvIGl0IHRoZW4pICovDQo+ICAgCW91dGIoVkdBX0FSX0VOQUJM
RV9ESVNQTEFZLCBWR0FfQVRUX1cpOw0KPiArI2VuZGlmDQo+ICAgDQo+ICAgCWRybV9kZXZf
ZXhpdChpZHgpOw0KPiAgIH0NCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3Mg
RHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJI
DQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkwNDYxIE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2
byBUb3RldiwgQW5kcmV3IE15ZXJzLCBBbmRyZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1h
bg0KSFJCIDM2ODA5IChBRyBOdWVybmJlcmcpDQo=

--------------9Azw0qm8fKudHTn0V0bmWTvi--

--------------omS0egi6Wc0vNZ4XIw6nTILI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRrYj4FAwAAAAAACgkQlh/E3EQov+Bu
SQ//U1LJuOW9//Ph1lt4/wXKM7nkXq4Dc6WvO5lXBy3cHTCa72Qaq+cM5WgZMgBAWHgmS796tbpW
BIJHIBlfluSwFDmqvUflnNV7HC3q90JuCzlUga3nHxR0GDuwkqovtrbDASN9UvIWNvaza5RYqRY8
hkH4YU5vxqhc2vovin0N+RFFb6Vo8/i6a6KKdCzmX/CYfbffKnUK7J+GxXmg5501nu06c2nZA1VJ
pLPgbzmY48PllfvLNfH+nFBCNzE3uOJhbEGzzuglkRl41ZMkHjp9/FmDjwJa7A+XaLfcvS8vWEXa
uFlUqo+Qwz+KPMj9tTIBkW0N1NBF9XJduq3yqAroWzdok4UUWhli+aayh91KZu0xxQaWun3LuVO8
URQahi/SZ2llfUYlPMAO1AOQfWB4BRN1MRnRryfZSoVZ+Zi4mCzSfnJ9yYJZf3mG4BrE1ywic7Bf
m7oYrsYqTcPWZXLZzuE0YDDmdp8SN3Bx3v8LjvGFhfEZI0v0PpJmOJuoGzviriTtMtB+tGpsXK7p
PhxnJkf2BNxFJ0YjfRCD3+TJYACGbq/zHRAMWRN2jZ2sJc9CDNJXDq5vd04Oj+inh+15PnA2clh1
c0oK8J6ECksmbnODhfTaNEIu9CUOx6OyzGiUMJIqhTm7geUSuU3m0pL9GHiqD+ABXpEhOjc/aKKc
Eyg=
=JJMK
-----END PGP SIGNATURE-----

--------------omS0egi6Wc0vNZ4XIw6nTILI--
