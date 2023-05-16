Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86087054C6
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 19:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjEPROH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 13:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjEPROG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 13:14:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD4A7EDA;
        Tue, 16 May 2023 10:13:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D37C621F00;
        Tue, 16 May 2023 17:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684257236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZouM6U98x38wXW9MRAtu8fqxzfXzsAxCRP1ZwPobA+s=;
        b=Z/LgNkTGQIIdzsGT1Vk/3fXEzO95wk9CEWI0zjDaQMLknNwwhG5RNp0FXFoPJl2Z2pkP/S
        YI3WbUMyPL1U13sK6BPZ2FiSLXTCuE0rlRMm8EnmN6XQ+66nZkK5PyVR8aqeZfeJwds4+W
        XJ2b/hfS2w3bqUXlUdK25vNVaJ/D4UE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684257236;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZouM6U98x38wXW9MRAtu8fqxzfXzsAxCRP1ZwPobA+s=;
        b=bBlhoq+OSNGpvFmv+es7DgjFLnRufV9RJrC58hwLBaMC8yr8f+Hkh95D0uD7k6SVV/pS6I
        aOva+qziF3gzNBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 525CE138F9;
        Tue, 16 May 2023 17:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iDZVEtS5Y2QgNwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 16 May 2023 17:13:56 +0000
Message-ID: <f5c92eb1-83af-4f99-71f5-b7a3e8be1d13@suse.de>
Date:   Tue, 16 May 2023 19:13:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 07/41] drm: handle HAS_IOPORT dependencies
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
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-8-schnelle@linux.ibm.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230516110038.2413224-8-schnelle@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QLCjstKEr7xwMcJ2f9iBbsPo"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------QLCjstKEr7xwMcJ2f9iBbsPo
Content-Type: multipart/mixed; boundary="------------hmIwqHb0OrnDKh0jewsGeijn";
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
Message-ID: <f5c92eb1-83af-4f99-71f5-b7a3e8be1d13@suse.de>
Subject: Re: [PATCH v4 07/41] drm: handle HAS_IOPORT dependencies
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-8-schnelle@linux.ibm.com>
In-Reply-To: <20230516110038.2413224-8-schnelle@linux.ibm.com>

--------------hmIwqHb0OrnDKh0jewsGeijn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTYuMDUuMjMgdW0gMTM6MDAgc2NocmllYiBOaWtsYXMgU2NobmVsbGU6DQo+
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
dCBzdXNwZW5kL3Jlc3VtZS4NCj4gDQo+IENvLWRldmVsb3BlZC1ieTogQXJuZCBCZXJnbWFu
biA8YXJuZEBrZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxh
cm5kQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBTY2huZWxsZSA8c2No
bmVsbGVAbGludXguaWJtLmNvbT4NCj4gLS0tDQo+IE5vdGU6IFRoZSBIQVNfSU9QT1JUIEtj
b25maWcgb3B0aW9uIHdhcyBhZGRlZCBpbiB2Ni40LXJjMSBzbw0KPiAgICAgICAgcGVyLXN1
YnN5c3RlbSBwYXRjaGVzIG1heSBiZSBhcHBsaWVkIGluZGVwZW5kZW50bHkNCj4gDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL3F4bC9LY29uZmlnICAgfCAgMSArDQo+ICAgZHJpdmVycy9ncHUv
ZHJtL3RpbnkvYm9jaHMuYyAgfCAxNyArKysrKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMv
Z3B1L2RybS90aW55L2NpcnJ1cy5jIHwgIDIgKysNCg0KVGhlcmUgYXJlIG1vcmUgaW52b2Nh
dGlvbnMgaW4gZ21hNTAwLiBTZWVbMV0NCg0KWzFdIA0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxp
bi5jb20vbGludXgvdjYuMy9zb3VyY2UvZHJpdmVycy9ncHUvZHJtL2dtYTUwMC9jZHZfZGV2
aWNlLmMjTDMwDQoNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcXhsL0tjb25maWcgYi9kcml2ZXJz
L2dwdS9kcm0vcXhsL0tjb25maWcNCj4gaW5kZXggY2EzZjUxYzJhOGZlLi5kMGUwZDQ0MGM4
ZDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9xeGwvS2NvbmZpZw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vcXhsL0tjb25maWcNCj4gQEAgLTIsNiArMiw3IEBADQo+ICAg
Y29uZmlnIERSTV9RWEwNCj4gICAJdHJpc3RhdGUgIlFYTCB2aXJ0dWFsIEdQVSINCj4gICAJ
ZGVwZW5kcyBvbiBEUk0gJiYgUENJICYmIE1NVQ0KPiArCWRlcGVuZHMgb24gSEFTX0lPUE9S
VA0KPiAgIAlzZWxlY3QgRFJNX0tNU19IRUxQRVINCj4gICAJc2VsZWN0IERSTV9UVE0NCj4g
ICAJc2VsZWN0IERSTV9UVE1fSEVMUEVSDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vdGlueS9ib2Nocy5jIGIvZHJpdmVycy9ncHUvZHJtL3RpbnkvYm9jaHMuYw0KPiBpbmRl
eCBkMjU0Njc5YTEzNmUuLjM3MTAzMzk0MDdjYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3RpbnkvYm9jaHMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdGlueS9ib2No
cy5jDQo+IEBAIC0yLDYgKzIsNyBAQA0KPiAgIA0KPiAgICNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvcGNpLmg+DQo+ICsjaW5jbHVkZSA8YXNtL2J1
Zy5oPg0KDQo8bGludXgvYnVnLmg+IHBsZWFzZS4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMN
Cg0KPiAgIA0KPiAgICNpbmNsdWRlIDxkcm0vZHJtX2FwZXJ0dXJlLmg+DQo+ICAgI2luY2x1
ZGUgPGRybS9kcm1fYXRvbWljX2hlbHBlci5oPg0KPiBAQCAtMTA1LDcgKzEwNiw5IEBAIHN0
YXRpYyB2b2lkIGJvY2hzX3ZnYV93cml0ZWIoc3RydWN0IGJvY2hzX2RldmljZSAqYm9jaHMs
IHUxNiBpb3BvcnQsIHU4IHZhbCkNCj4gICANCj4gICAJCXdyaXRlYih2YWwsIGJvY2hzLT5t
bWlvICsgb2Zmc2V0KTsNCj4gICAJfSBlbHNlIHsNCj4gKyNpZmRlZiBDT05GSUdfSEFTX0lP
UE9SVA0KPiAgIAkJb3V0Yih2YWwsIGlvcG9ydCk7DQo+ICsjZW5kaWYNCj4gICAJfQ0KPiAg
IH0NCj4gICANCj4gQEAgLTExOSw3ICsxMjIsMTEgQEAgc3RhdGljIHU4IGJvY2hzX3ZnYV9y
ZWFkYihzdHJ1Y3QgYm9jaHNfZGV2aWNlICpib2NocywgdTE2IGlvcG9ydCkNCj4gICANCj4g
ICAJCXJldHVybiByZWFkYihib2Nocy0+bW1pbyArIG9mZnNldCk7DQo+ICAgCX0gZWxzZSB7
DQo+ICsjaWZkZWYgQ09ORklHX0hBU19JT1BPUlQNCj4gICAJCXJldHVybiBpbmIoaW9wb3J0
KTsNCj4gKyNlbHNlDQo+ICsJCXJldHVybiAweGZmOw0KPiArI2VuZGlmDQo+ICAgCX0NCj4g
ICB9DQo+ICAgDQo+IEBAIC0xMzIsOCArMTM5LDEyIEBAIHN0YXRpYyB1MTYgYm9jaHNfZGlz
cGlfcmVhZChzdHJ1Y3QgYm9jaHNfZGV2aWNlICpib2NocywgdTE2IHJlZykNCj4gICANCj4g
ICAJCXJldCA9IHJlYWR3KGJvY2hzLT5tbWlvICsgb2Zmc2V0KTsNCj4gICAJfSBlbHNlIHsN
Cj4gKyNpZmRlZiBDT05GSUdfSEFTX0lPUE9SVA0KPiAgIAkJb3V0dyhyZWcsIFZCRV9ESVNQ
SV9JT1BPUlRfSU5ERVgpOw0KPiAgIAkJcmV0ID0gaW53KFZCRV9ESVNQSV9JT1BPUlRfREFU
QSk7DQo+ICsjZWxzZQ0KPiArCQlyZXQgPSAweGZmZmY7DQo+ICsjZW5kaWYNCj4gICAJfQ0K
PiAgIAlyZXR1cm4gcmV0Ow0KPiAgIH0NCj4gQEAgLTE0NSw4ICsxNTYsMTAgQEAgc3RhdGlj
IHZvaWQgYm9jaHNfZGlzcGlfd3JpdGUoc3RydWN0IGJvY2hzX2RldmljZSAqYm9jaHMsIHUx
NiByZWcsIHUxNiB2YWwpDQo+ICAgDQo+ICAgCQl3cml0ZXcodmFsLCBib2Nocy0+bW1pbyAr
IG9mZnNldCk7DQo+ICAgCX0gZWxzZSB7DQo+ICsjaWZkZWYgQ09ORklHX0hBU19JT1BPUlQN
Cj4gICAJCW91dHcocmVnLCBWQkVfRElTUElfSU9QT1JUX0lOREVYKTsNCj4gICAJCW91dHco
dmFsLCBWQkVfRElTUElfSU9QT1JUX0RBVEEpOw0KPiArI2VuZGlmDQo+ICAgCX0NCj4gICB9
DQo+ICAgDQo+IEBAIC0yMjksNiArMjQyLDEwIEBAIHN0YXRpYyBpbnQgYm9jaHNfaHdfaW5p
dChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQ0KPiAgIAkJCXJldHVybiAtRU5PTUVNOw0KPiAg
IAkJfQ0KPiAgIAl9IGVsc2Ugew0KPiArCQlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX0hBU19J
T1BPUlQpKSB7DQo+ICsJCQlEUk1fRVJST1IoIkkvTyBwb3J0cyBhcmUgbm90IHN1cHBvcnRl
ZFxuIik7DQo+ICsJCQlyZXR1cm4gLUVJTzsNCj4gKwkJfQ0KPiAgIAkJaW9hZGRyID0gVkJF
X0RJU1BJX0lPUE9SVF9JTkRFWDsNCj4gICAJCWlvc2l6ZSA9IDI7DQo+ICAgCQlpZiAoIXJl
cXVlc3RfcmVnaW9uKGlvYWRkciwgaW9zaXplLCAiYm9jaHMtZHJtIikpIHsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90aW55L2NpcnJ1cy5jIGIvZHJpdmVycy9ncHUvZHJt
L3RpbnkvY2lycnVzLmMNCj4gaW5kZXggNTk0YmM0NzI4NjJmLi5jNjVmZWEwNDliYzcgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90aW55L2NpcnJ1cy5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS90aW55L2NpcnJ1cy5jDQo+IEBAIC01MDgsOCArNTA4LDEwIEBAIHN0
YXRpYyB2b2lkIGNpcnJ1c19jcnRjX2hlbHBlcl9hdG9taWNfZW5hYmxlKHN0cnVjdCBkcm1f
Y3J0YyAqY3J0YywNCj4gICANCj4gICAJY2lycnVzX21vZGVfc2V0KGNpcnJ1cywgJmNydGNf
c3RhdGUtPm1vZGUpOw0KPiAgIA0KPiArI2lmZGVmIENPTkZJR19IQVNfSU9QT1JUDQo+ICAg
CS8qIFVuYmxhbmsgKG5lZWRlZCBvbiBTMyByZXN1bWUsIHZnYWJpb3MgZG9lc24ndCBkbyBp
dCB0aGVuKSAqLw0KPiAgIAlvdXRiKFZHQV9BUl9FTkFCTEVfRElTUExBWSwgVkdBX0FUVF9X
KTsNCj4gKyNlbmRpZg0KPiAgIA0KPiAgIAlkcm1fZGV2X2V4aXQoaWR4KTsNCj4gICB9DQoN
Ci0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNV
U0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2
LCA5MDQ2MSBOdWVybmJlcmcsIEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFuZHJldyBNeWVy
cywgQW5kcmV3IE1jRG9uYWxkLCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgwOSAoQUcgTnVl
cm5iZXJnKQ0K

--------------hmIwqHb0OrnDKh0jewsGeijn--

--------------QLCjstKEr7xwMcJ2f9iBbsPo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRjudMFAwAAAAAACgkQlh/E3EQov+D4
ihAAnhzlqkL1KYuEQYrYyEGypHC7kvHol+IJuCFLdP8ve6fc2LUV1GzqXQRZSS8+1+6GYtKPI3nL
zOD7BVzIdFLsJom9FN6xldv8iYqoPIGl94dRBHrscmYCI1gR/ppXIayXZQt2pLt5jlnu1km9Asqf
rDousPBh8H2QWqb9ES9XbIi7O1b7GWJtnruheYZwRlXQMiHNEwU15NWUEjqGMAXs45cvFoOMVpLD
UGX6BC7OCq1tGGd5a3ileVY5Y1/lEksv2qZmiWqbExz7WcjkewbnKkfn6v5X0Qdu3L2N3b/59eBU
r4Peilj63EjwC5fhsQb6xNqeU+YRWepbW/6VH7J03RtB1LL2L6UIgVyErJ3Og8juMK2d3VA6/zBl
ciZlYTN7OWxCD4rlg/35rjSEV5nbRn4Foev2BfilRPIzt7t7lEMrGmtcyxF4mXT6jeFSw7r/Lwlk
K3wjb01bVhCq8JQnyCN17vrimbvwnhPBciLU1cL7NUGIIAKJ5QPZ3xmYDfPXzkVtrD1IQgiJuiH0
pJipxojSl+T0aWZEB9dyxyp2MaKN1rVgt2SiiRYsBW1w5vPGJxQmfSaZjLv8X8ZwhqkG/+u+ZDoT
WD3Anxjx5bFzwm9TOaZLcptGYzdCM9If2Ee8T/uNaYnuKPp3tupecYed9r8si9rCbCRlXoEIUc1/
QlU=
=yF6t
-----END PGP SIGNATURE-----

--------------QLCjstKEr7xwMcJ2f9iBbsPo--
