Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F297F52D6FD
	for <lists+linux-arch@lfdr.de>; Thu, 19 May 2022 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbiESPIZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 May 2022 11:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240583AbiESPHW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 May 2022 11:07:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602285AA5A;
        Thu, 19 May 2022 08:07:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A7871FD38;
        Thu, 19 May 2022 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652972837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IWH8FsPC8/ygpHOHonzeBfxn5Hz3dIsT3esa4BuohSw=;
        b=L1wnzQCN98EtULwo7rWgMsVWrGpIqw1OEFykq7S4VaSrHUN417Nvy+MuyV0bJroSRmzy3M
        5xSbrtjNYJSnHWF9siwjJsICkEhIPlFD71CmIA3krAFrlir2Ib9wQP1D9MNLN+WE8+GBNw
        z1SnCL+8POea8sqpsg/MK603z03iuNU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D534113AF8;
        Thu, 19 May 2022 15:07:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XYt5MSRdhmJpWAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 19 May 2022 15:07:16 +0000
Message-ID: <bda2d3cb-7472-28ff-eb4e-a30458460c84@suse.com>
Date:   Thu, 19 May 2022 17:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Content-Language: en-US
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
References: <20220504155703.13336-1-jgross@suse.com>
 <20220504155703.13336-3-jgross@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220504155703.13336-3-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------X2JEafOWLT00pgbXX5l1hgWW"
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------X2JEafOWLT00pgbXX5l1hgWW
Content-Type: multipart/mixed; boundary="------------1I1ZTSyF7lu6th38xRuLvtF5";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <olekstysh@gmail.com>
Message-ID: <bda2d3cb-7472-28ff-eb4e-a30458460c84@suse.com>
Subject: Re: [PATCH v3 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
References: <20220504155703.13336-1-jgross@suse.com>
 <20220504155703.13336-3-jgross@suse.com>
In-Reply-To: <20220504155703.13336-3-jgross@suse.com>

--------------1I1ZTSyF7lu6th38xRuLvtF5
Content-Type: multipart/mixed; boundary="------------q0Ma1pV467Hqz8bFVYRGEh6g"

--------------q0Ma1pV467Hqz8bFVYRGEh6g
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMDUuMjIgMTc6NTcsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IEluc3RlYWQgb2Yg
dXNpbmcgYXJjaF9oYXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2VzcygpIHRvZ2V0
aGVyDQo+IHdpdGggQ09ORklHX0FSQ0hfSEFTX1JFU1RSSUNURURfVklSVElPX01FTU9SWV9B
Q0NFU1MsIHJlcGxhY2UgdGhvc2UNCj4gd2l0aCBwbGF0Zm9ybV9oYXMoKSBhbmQgYSBuZXcg
cGxhdGZvcm0gZmVhdHVyZQ0KPiBQTEFURk9STV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUND
RVNTLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2Uu
Y29tPg0KDQpDb3VsZCBJIGdldCBzb21lIGZlZWRiYWNrIGZyb20gdGhlIHMzOTAgc2lkZSwg
cGxlYXNlPw0KDQoNCkp1ZXJnZW4NCg0KPiAtLS0NCj4gVjI6DQo+IC0gbW92ZSBzZXR0aW5n
IG9mIFBMQVRGT1JNX1ZJUlRJT19SRVNUUklDVEVEX01FTV9BQ0NFU1MgaW4gU0VWIGNhc2UN
Cj4gICAgdG8gc2V2X3NldHVwX2FyY2goKS4NCj4gVjM6DQo+IC0gcmVtb3ZlIEh5cGVyLVYg
Y2h1bmsgKE1pY2hhZWwgS2VsbGV5KQ0KPiAtIHJlbW92ZSBpbmNsdWRlIHZpcnRpb19jb25m
aWcuaCBmcm9tIG1lbV9lbmNyeXB0LmMgKE9sZWtzYW5kciBUeXNoY2hlbmtvKQ0KPiAtIGFk
ZCBjb21tZW50IGZvciBQTEFURk9STV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUNDRVNTIChP
bGVrc2FuZHIgVHlzaGNoZW5rbykNCj4gLS0tDQo+ICAgYXJjaC9zMzkwL0tjb25maWcgICAg
ICAgICAgICAgICAgfCAgMSAtDQo+ICAgYXJjaC9zMzkwL21tL2luaXQuYyAgICAgICAgICAg
ICAgfCAxMyArKystLS0tLS0tLS0tDQo+ICAgYXJjaC94ODYvS2NvbmZpZyAgICAgICAgICAg
ICAgICAgfCAgMSAtDQo+ICAgYXJjaC94ODYvbW0vbWVtX2VuY3J5cHQuYyAgICAgICAgfCAg
NyAtLS0tLS0tDQo+ICAgYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfYW1kLmMgICAgfCAgNCAr
KysrDQo+ICAgZHJpdmVycy92aXJ0aW8vS2NvbmZpZyAgICAgICAgICAgfCAgNiAtLS0tLS0N
Cj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW8uYyAgICAgICAgICB8ICA1ICsrLS0tDQo+ICAg
aW5jbHVkZS9saW51eC9wbGF0Zm9ybS1mZWF0dXJlLmggfCAgNiArKysrKy0NCj4gICBpbmNs
dWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaCAgICB8ICA5IC0tLS0tLS0tLQ0KPiAgIDkgZmls
ZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC9zMzkwL0tjb25maWcgYi9hcmNoL3MzOTAvS2NvbmZpZw0KPiBp
bmRleCBlMDg0YzcyMTA0ZjguLmY5N2EyMmFlNjlhOCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9z
MzkwL0tjb25maWcNCj4gKysrIGIvYXJjaC9zMzkwL0tjb25maWcNCj4gQEAgLTc3Miw3ICs3
NzIsNiBAQCBtZW51ICJWaXJ0dWFsaXphdGlvbiINCj4gICBjb25maWcgUFJPVEVDVEVEX1ZJ
UlRVQUxJWkFUSU9OX0dVRVNUDQo+ICAgCWRlZl9ib29sIG4NCj4gICAJcHJvbXB0ICJQcm90
ZWN0ZWQgdmlydHVhbGl6YXRpb24gZ3Vlc3Qgc3VwcG9ydCINCj4gLQlzZWxlY3QgQVJDSF9I
QVNfUkVTVFJJQ1RFRF9WSVJUSU9fTUVNT1JZX0FDQ0VTUw0KPiAgIAloZWxwDQo+ICAgCSAg
U2VsZWN0IHRoaXMgb3B0aW9uLCBpZiB5b3Ugd2FudCB0byBiZSBhYmxlIHRvIHJ1biB0aGlz
DQo+ICAgCSAga2VybmVsIGFzIGEgcHJvdGVjdGVkIHZpcnR1YWxpemF0aW9uIEtWTSBndWVz
dC4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvczM5MC9tbS9pbml0LmMgYi9hcmNoL3MzOTAvbW0v
aW5pdC5jDQo+IGluZGV4IDg2ZmZkMGQ1MWZkNS4uMmMzYjQ1MTgxM2VkIDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3MzOTAvbW0vaW5pdC5jDQo+ICsrKyBiL2FyY2gvczM5MC9tbS9pbml0LmMN
Cj4gQEAgLTMxLDYgKzMxLDcgQEANCj4gICAjaW5jbHVkZSA8bGludXgvY21hLmg+DQo+ICAg
I2luY2x1ZGUgPGxpbnV4L2dmcC5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9kbWEtZGlyZWN0
Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm0tZmVhdHVyZS5oPg0KPiAgICNpbmNs
dWRlIDxhc20vcHJvY2Vzc29yLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4N
Cj4gICAjaW5jbHVkZSA8YXNtL3BnYWxsb2MuaD4NCj4gQEAgLTE2OCwyMiArMTY5LDE0IEBA
IGJvb2wgZm9yY2VfZG1hX3VuZW5jcnlwdGVkKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICAJ
cmV0dXJuIGlzX3Byb3RfdmlydF9ndWVzdCgpOw0KPiAgIH0NCj4gICANCj4gLSNpZmRlZiBD
T05GSUdfQVJDSF9IQVNfUkVTVFJJQ1RFRF9WSVJUSU9fTUVNT1JZX0FDQ0VTUw0KPiAtDQo+
IC1pbnQgYXJjaF9oYXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2Vzcyh2b2lkKQ0K
PiAtew0KPiAtCXJldHVybiBpc19wcm90X3ZpcnRfZ3Vlc3QoKTsNCj4gLX0NCj4gLUVYUE9S
VF9TWU1CT0woYXJjaF9oYXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2Vzcyk7DQo+
IC0NCj4gLSNlbmRpZg0KPiAtDQo+ICAgLyogcHJvdGVjdGVkIHZpcnR1YWxpemF0aW9uICov
DQo+ICAgc3RhdGljIHZvaWQgcHZfaW5pdCh2b2lkKQ0KPiAgIHsNCj4gICAJaWYgKCFpc19w
cm90X3ZpcnRfZ3Vlc3QoKSkNCj4gICAJCXJldHVybjsNCj4gICANCj4gKwlwbGF0Zm9ybV9z
ZXQoUExBVEZPUk1fVklSVElPX1JFU1RSSUNURURfTUVNX0FDQ0VTUyk7DQo+ICsNCj4gICAJ
LyogbWFrZSBzdXJlIGJvdW5jZSBidWZmZXJzIGFyZSBzaGFyZWQgKi8NCj4gICAJc3dpb3Rs
Yl9mb3JjZSA9IFNXSU9UTEJfRk9SQ0U7DQo+ICAgCXN3aW90bGJfaW5pdCgxKTsNCj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L0tjb25maWcgYi9hcmNoL3g4Ni9LY29uZmlnDQo+IGluZGV4
IDRiZWQzYWJmNDQ0ZC4uZWViN2M2YzhlZWM1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9L
Y29uZmlnDQo+ICsrKyBiL2FyY2gveDg2L0tjb25maWcNCj4gQEAgLTE1MTUsNyArMTUxNSw2
IEBAIGNvbmZpZyBYODZfQ1BBX1NUQVRJU1RJQ1MNCj4gICBjb25maWcgWDg2X01FTV9FTkNS
WVBUDQo+ICAgCXNlbGVjdCBBUkNIX0hBU19GT1JDRV9ETUFfVU5FTkNSWVBURUQNCj4gICAJ
c2VsZWN0IERZTkFNSUNfUEhZU0lDQUxfTUFTSw0KPiAtCXNlbGVjdCBBUkNIX0hBU19SRVNU
UklDVEVEX1ZJUlRJT19NRU1PUllfQUNDRVNTDQo+ICAgCWRlZl9ib29sIG4NCj4gICANCj4g
ICBjb25maWcgQU1EX01FTV9FTkNSWVBUDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9t
ZW1fZW5jcnlwdC5jIGIvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHQuYw0KPiBpbmRleCA1MGQy
MDk5MzljNjYuLjE4YTU1YTBmMWNhMiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvbW0vbWVt
X2VuY3J5cHQuYw0KPiArKysgYi9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdC5jDQo+IEBAIC0x
Miw3ICsxMiw2IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L3N3aW90bGIuaD4NCj4gICAjaW5j
bHVkZSA8bGludXgvY2NfcGxhdGZvcm0uaD4NCj4gICAjaW5jbHVkZSA8bGludXgvbWVtX2Vu
Y3J5cHQuaD4NCj4gLSNpbmNsdWRlIDxsaW51eC92aXJ0aW9fY29uZmlnLmg+DQo+ICAgDQo+
ICAgLyogT3ZlcnJpZGUgZm9yIERNQSBkaXJlY3QgYWxsb2NhdGlvbiBjaGVjayAtIEFSQ0hf
SEFTX0ZPUkNFX0RNQV9VTkVOQ1JZUFRFRCAqLw0KPiAgIGJvb2wgZm9yY2VfZG1hX3VuZW5j
cnlwdGVkKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gQEAgLTc2LDkgKzc1LDMgQEAgdm9pZCBf
X2luaXQgbWVtX2VuY3J5cHRfaW5pdCh2b2lkKQ0KPiAgIA0KPiAgIAlwcmludF9tZW1fZW5j
cnlwdF9mZWF0dXJlX2luZm8oKTsNCj4gICB9DQo+IC0NCj4gLWludCBhcmNoX2hhc19yZXN0
cmljdGVkX3ZpcnRpb19tZW1vcnlfYWNjZXNzKHZvaWQpDQo+IC17DQo+IC0JcmV0dXJuIGNj
X3BsYXRmb3JtX2hhcyhDQ19BVFRSX0dVRVNUX01FTV9FTkNSWVBUKTsNCj4gLX0NCj4gLUVY
UE9SVF9TWU1CT0xfR1BMKGFyY2hfaGFzX3Jlc3RyaWN0ZWRfdmlydGlvX21lbW9yeV9hY2Nl
c3MpOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfYW1kLmMgYi9h
cmNoL3g4Ni9tbS9tZW1fZW5jcnlwdF9hbWQuYw0KPiBpbmRleCA2MTY5MDUzYzI4NTQuLjM5
YjcxMDg0ZDM2YiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfYW1k
LmMNCj4gKysrIGIvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfYW1kLmMNCj4gQEAgLTIxLDYg
KzIxLDcgQEANCj4gICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4NCj4gICAjaW5j
bHVkZSA8bGludXgvdmlydGlvX2NvbmZpZy5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9jY19w
bGF0Zm9ybS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtLWZlYXR1cmUuaD4NCj4g
ICANCj4gICAjaW5jbHVkZSA8YXNtL3RsYmZsdXNoLmg+DQo+ICAgI2luY2x1ZGUgPGFzbS9m
aXhtYXAuaD4NCj4gQEAgLTIwNiw2ICsyMDcsOSBAQCB2b2lkIF9faW5pdCBzZXZfc2V0dXBf
YXJjaCh2b2lkKQ0KPiAgIAlzaXplID0gdG90YWxfbWVtICogNiAvIDEwMDsNCj4gICAJc2l6
ZSA9IGNsYW1wX3ZhbChzaXplLCBJT19UTEJfREVGQVVMVF9TSVpFLCBTWl8xRyk7DQo+ICAg
CXN3aW90bGJfYWRqdXN0X3NpemUoc2l6ZSk7DQo+ICsNCj4gKwkvKiBTZXQgcmVzdHJpY3Rl
ZCBtZW1vcnkgYWNjZXNzIGZvciB2aXJ0aW8uICovDQo+ICsJcGxhdGZvcm1fc2V0KFBMQVRG
T1JNX1ZJUlRJT19SRVNUUklDVEVEX01FTV9BQ0NFU1MpOw0KPiAgIH0NCj4gICANCj4gICBz
dGF0aWMgdW5zaWduZWQgbG9uZyBwZ19sZXZlbF90b19wZm4oaW50IGxldmVsLCBwdGVfdCAq
a3B0ZSwgcGdwcm90X3QgKnJldF9wcm90KQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0
aW8vS2NvbmZpZyBiL2RyaXZlcnMvdmlydGlvL0tjb25maWcNCj4gaW5kZXggYjVhZGY2YWJk
MjQxLi5hNmRjOGI1ODQ2ZmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL0tjb25m
aWcNCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vS2NvbmZpZw0KPiBAQCAtNiwxMiArNiw2IEBA
IGNvbmZpZyBWSVJUSU8NCj4gICAJICBidXMsIHN1Y2ggYXMgQ09ORklHX1ZJUlRJT19QQ0ks
IENPTkZJR19WSVJUSU9fTU1JTywgQ09ORklHX1JQTVNHDQo+ICAgCSAgb3IgQ09ORklHX1Mz
OTBfR1VFU1QuDQo+ICAgDQo+IC1jb25maWcgQVJDSF9IQVNfUkVTVFJJQ1RFRF9WSVJUSU9f
TUVNT1JZX0FDQ0VTUw0KPiAtCWJvb2wNCj4gLQloZWxwDQo+IC0JICBUaGlzIG9wdGlvbiBp
cyBzZWxlY3RlZCBpZiB0aGUgYXJjaGl0ZWN0dXJlIG1heSBuZWVkIHRvIGVuZm9yY2UNCj4g
LQkgIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STQ0KPiAtDQo+ICAgY29uZmlnIFZJUlRJT19Q
Q0lfTElCDQo+ICAgCXRyaXN0YXRlDQo+ICAgCWhlbHANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpby5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvLmMNCj4gaW5kZXgg
MjJmMTVmNDQ0Zjc1Li4zNzFlMTZiMTgzODEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmly
dGlvL3ZpcnRpby5jDQo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpby5jDQo+IEBAIC01
LDYgKzUsNyBAQA0KPiAgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gICAjaW5jbHVk
ZSA8bGludXgvaWRyLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ICsjaW5jbHVk
ZSA8bGludXgvcGxhdGZvcm0tZmVhdHVyZS5oPg0KPiAgICNpbmNsdWRlIDx1YXBpL2xpbnV4
L3ZpcnRpb19pZHMuaD4NCj4gICANCj4gICAvKiBVbmlxdWUgbnVtYmVyaW5nIGZvciB2aXJ0
aW8gZGV2aWNlcy4gKi8NCj4gQEAgLTE3MCwxMiArMTcxLDEwIEBAIEVYUE9SVF9TWU1CT0xf
R1BMKHZpcnRpb19hZGRfc3RhdHVzKTsNCj4gICBzdGF0aWMgaW50IHZpcnRpb19mZWF0dXJl
c19vayhzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KQ0KPiAgIHsNCj4gICAJdW5zaWduZWQg
c3RhdHVzOw0KPiAtCWludCByZXQ7DQo+ICAgDQo+ICAgCW1pZ2h0X3NsZWVwKCk7DQo+ICAg
DQo+IC0JcmV0ID0gYXJjaF9oYXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2Vzcygp
Ow0KPiAtCWlmIChyZXQpIHsNCj4gKwlpZiAocGxhdGZvcm1faGFzKFBMQVRGT1JNX1ZJUlRJ
T19SRVNUUklDVEVEX01FTV9BQ0NFU1MpKSB7DQo+ICAgCQlpZiAoIXZpcnRpb19oYXNfZmVh
dHVyZShkZXYsIFZJUlRJT19GX1ZFUlNJT05fMSkpIHsNCj4gICAJCQlkZXZfd2FybigmZGV2
LT5kZXYsDQo+ICAgCQkJCSAiZGV2aWNlIG11c3QgcHJvdmlkZSBWSVJUSU9fRl9WRVJTSU9O
XzFcbiIpOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wbGF0Zm9ybS1mZWF0dXJl
LmggYi9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtLWZlYXR1cmUuaA0KPiBpbmRleCA2ZWQ4NTk5
MjhiOTcuLmIyZjQ4YmU5OTlmYSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9wbGF0
Zm9ybS1mZWF0dXJlLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9wbGF0Zm9ybS1mZWF0dXJl
LmgNCj4gQEAgLTYsNyArNiwxMSBAQA0KPiAgICNpbmNsdWRlIDxhc20vcGxhdGZvcm0tZmVh
dHVyZS5oPg0KPiAgIA0KPiAgIC8qIFRoZSBwbGF0Zm9ybSBmZWF0dXJlcyBhcmUgc3RhcnRp
bmcgd2l0aCB0aGUgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIG9uZXMuICovDQo+IC0jZGVmaW5l
IFBMQVRGT1JNX0ZFQVRfTgkJCQkoMCArIFBMQVRGT1JNX0FSQ0hfRkVBVF9OKQ0KPiArDQo+
ICsvKiBVc2VkIHRvIGVuYWJsZSBwbGF0Zm9ybSBzcGVjaWZpYyBETUEgaGFuZGxpbmcgZm9y
IHZpcnRpbyBkZXZpY2VzLiAqLw0KPiArI2RlZmluZSBQTEFURk9STV9WSVJUSU9fUkVTVFJJ
Q1RFRF9NRU1fQUNDRVNTCSgwICsgUExBVEZPUk1fQVJDSF9GRUFUX04pDQo+ICsNCj4gKyNk
ZWZpbmUgUExBVEZPUk1fRkVBVF9OCQkJCSgxICsgUExBVEZPUk1fQVJDSF9GRUFUX04pDQo+
ICAgDQo+ICAgdm9pZCBwbGF0Zm9ybV9zZXQodW5zaWduZWQgaW50IGZlYXR1cmUpOw0KPiAg
IHZvaWQgcGxhdGZvcm1fY2xlYXIodW5zaWduZWQgaW50IGZlYXR1cmUpOw0KPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmggYi9pbmNsdWRlL2xpbnV4L3Zp
cnRpb19jb25maWcuaA0KPiBpbmRleCBiMzQxZGQ2MmFhNGQuLjc5NDk4Mjk4NTE5ZCAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgNCj4gKysrIGIvaW5j
bHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgNCj4gQEAgLTU1OSwxMyArNTU5LDQgQEAgc3Rh
dGljIGlubGluZSB2b2lkIHZpcnRpb19jd3JpdGU2NChzdHJ1Y3QgdmlydGlvX2RldmljZSAq
dmRldiwNCj4gICAJCV9yOwkJCQkJCQlcDQo+ICAgCX0pDQo+ICAgDQo+IC0jaWZkZWYgQ09O
RklHX0FSQ0hfSEFTX1JFU1RSSUNURURfVklSVElPX01FTU9SWV9BQ0NFU1MNCj4gLWludCBh
cmNoX2hhc19yZXN0cmljdGVkX3ZpcnRpb19tZW1vcnlfYWNjZXNzKHZvaWQpOw0KPiAtI2Vs
c2UNCj4gLXN0YXRpYyBpbmxpbmUgaW50IGFyY2hfaGFzX3Jlc3RyaWN0ZWRfdmlydGlvX21l
bW9yeV9hY2Nlc3Modm9pZCkNCj4gLXsNCj4gLQlyZXR1cm4gMDsNCj4gLX0NCj4gLSNlbmRp
ZiAvKiBDT05GSUdfQVJDSF9IQVNfUkVTVFJJQ1RFRF9WSVJUSU9fTUVNT1JZX0FDQ0VTUyAq
Lw0KPiAtDQo+ICAgI2VuZGlmIC8qIF9MSU5VWF9WSVJUSU9fQ09ORklHX0ggKi8NCg0K
--------------q0Ma1pV467Hqz8bFVYRGEh6g
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------q0Ma1pV467Hqz8bFVYRGEh6g--

--------------1I1ZTSyF7lu6th38xRuLvtF5--

--------------X2JEafOWLT00pgbXX5l1hgWW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKGXSQFAwAAAAAACgkQsN6d1ii/Ey/L
egf+PtIFC+UL1k00i5cGXLAvvs8VuzFwHOSoHas4lsathJJpwXrhkABtwPx7118RhEE5UodV/pOg
tOMhBAiqg9sPi1tySOLdX/C642vn09hQfE37CWd9rL2Pzp48T8bsCjBeWm0FnXRGUrWWxqceswmH
m0Ko5/OFTom3atSI8NfET94COzEq9Jy/QAb1fMap7tmeaUXvtXyYJckYl/ZLtzzUYq42OZG9Ths0
XXlNqa1wSRBzf82jZl2lGMQpXLW3617IIbZ1ERkrSubU7VeDnp1PMKBrj5cqwwdVDk8dv80dHz5i
wUPBNaxyygC20eqhpF27w+qmz+P96j7cvBSPeOucqA==
=zzt7
-----END PGP SIGNATURE-----

--------------X2JEafOWLT00pgbXX5l1hgWW--
