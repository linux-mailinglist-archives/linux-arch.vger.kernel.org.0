Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3AE51218B
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 20:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiD0Sv2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 14:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiD0SvB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 14:51:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784617DE02;
        Wed, 27 Apr 2022 11:36:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8430D1F37B;
        Wed, 27 Apr 2022 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651084586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPGj7n/vA6ah11cM3Ov68FdS/0km35hEepQltyzPhB8=;
        b=u7XvmDwiqRHIocWGiLAYcscLlu02y9WmeQ1USlJ/XSK66O2hqcuH1uRea760zpnR4rh00j
        3GyKDD9HMLZD5nTnnOihWYk0kshZybRNljb/ntBP/bERvhcWLw7uEpOak5MRTm3u4T7Uz5
        E4o3/r0i9xxCMbEPqV+JO0KaNPcHmuE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA8DC13A39;
        Wed, 27 Apr 2022 18:36:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lD+1JymNaWJ0XQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 27 Apr 2022 18:36:25 +0000
Message-ID: <3d85dccb-7a22-1701-5717-8efd08b7a50c@suse.com>
Date:   Wed, 27 Apr 2022 20:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
References: <20220427153336.11091-1-jgross@suse.com>
 <20220427153336.11091-3-jgross@suse.com>
 <PH0PR21MB3025FAA99B4E2C8155A1AE12D7FA9@PH0PR21MB3025.namprd21.prod.outlook.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <PH0PR21MB3025FAA99B4E2C8155A1AE12D7FA9@PH0PR21MB3025.namprd21.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------j0b7KV03sm3SSS00lOqpuvd3"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------j0b7KV03sm3SSS00lOqpuvd3
Content-Type: multipart/mixed; boundary="------------u2CO02YVk1NKGgC5oPI9sJzg";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <olekstysh@gmail.com>
Message-ID: <3d85dccb-7a22-1701-5717-8efd08b7a50c@suse.com>
Subject: Re: [PATCH v2 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
References: <20220427153336.11091-1-jgross@suse.com>
 <20220427153336.11091-3-jgross@suse.com>
 <PH0PR21MB3025FAA99B4E2C8155A1AE12D7FA9@PH0PR21MB3025.namprd21.prod.outlook.com>
In-Reply-To: <PH0PR21MB3025FAA99B4E2C8155A1AE12D7FA9@PH0PR21MB3025.namprd21.prod.outlook.com>

--------------u2CO02YVk1NKGgC5oPI9sJzg
Content-Type: multipart/mixed; boundary="------------PVKJ8AyElnAXikkyiJoY2hwt"

--------------PVKJ8AyElnAXikkyiJoY2hwt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDQuMjIgMTg6MzAsIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+IEZy
b206IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4gU2VudDogV2VkbmVzZGF5LCBB
cHJpbCAyNywgMjAyMiA4OjM0IEFNDQo+Pg0KPj4gSW5zdGVhZCBvZiB1c2luZyBhcmNoX2hh
c19yZXN0cmljdGVkX3ZpcnRpb19tZW1vcnlfYWNjZXNzKCkgdG9nZXRoZXINCj4+IHdpdGgg
Q09ORklHX0FSQ0hfSEFTX1JFU1RSSUNURURfVklSVElPX01FTU9SWV9BQ0NFU1MsIHJlcGxh
Y2UgdGhvc2UNCj4+IHdpdGggcGxhdGZvcm1faGFzKCkgYW5kIGEgbmV3IHBsYXRmb3JtIGZl
YXR1cmUNCj4+IFBMQVRGT1JNX1ZJUlRJT19SRVNUUklDVEVEX01FTV9BQ0NFU1MuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4g
LS0tDQo+PiBWMjoNCj4+IC0gbW92ZSBzZXR0aW5nIG9mIFBMQVRGT1JNX1ZJUlRJT19SRVNU
UklDVEVEX01FTV9BQ0NFU1MgaW4gU0VWIGNhc2UNCj4+ICAgIHRvIHNldl9zZXR1cF9hcmNo
KCkuDQo+PiAtLS0NCj4+ICAgYXJjaC9zMzkwL0tjb25maWcgICAgICAgICAgICAgICAgfCAg
MSAtDQo+PiAgIGFyY2gvczM5MC9tbS9pbml0LmMgICAgICAgICAgICAgIHwgMTMgKysrLS0t
LS0tLS0tLQ0KPj4gICBhcmNoL3g4Ni9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAxIC0N
Cj4+ICAgYXJjaC94ODYva2VybmVsL2NwdS9tc2h5cGVydi5jICAgfCAgNSArKysrLQ0KPj4g
ICBhcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdC5jICAgICAgICB8ICA2IC0tLS0tLQ0KPj4gICBh
cmNoL3g4Ni9tbS9tZW1fZW5jcnlwdF9hbWQuYyAgICB8ICA0ICsrKysNCj4+ICAgZHJpdmVy
cy92aXJ0aW8vS2NvbmZpZyAgICAgICAgICAgfCAgNiAtLS0tLS0NCj4+ICAgZHJpdmVycy92
aXJ0aW8vdmlydGlvLmMgICAgICAgICAgfCAgNSArKy0tLQ0KPj4gICBpbmNsdWRlL2xpbnV4
L3BsYXRmb3JtLWZlYXR1cmUuaCB8ICAzICsrLQ0KPj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRp
b19jb25maWcuaCAgICB8ICA5IC0tLS0tLS0tLQ0KPj4gICAxMCBmaWxlcyBjaGFuZ2VkLCAx
NSBpbnNlcnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
YXJjaC9zMzkwL0tjb25maWcgYi9hcmNoL3MzOTAvS2NvbmZpZw0KPj4gaW5kZXggZTA4NGM3
MjEwNGY4Li5mOTdhMjJhZTY5YTggMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3MzOTAvS2NvbmZp
Zw0KPj4gKysrIGIvYXJjaC9zMzkwL0tjb25maWcNCj4+IEBAIC03NzIsNyArNzcyLDYgQEAg
bWVudSAiVmlydHVhbGl6YXRpb24iDQo+PiAgIGNvbmZpZyBQUk9URUNURURfVklSVFVBTEla
QVRJT05fR1VFU1QNCj4+ICAgCWRlZl9ib29sIG4NCj4+ICAgCXByb21wdCAiUHJvdGVjdGVk
IHZpcnR1YWxpemF0aW9uIGd1ZXN0IHN1cHBvcnQiDQo+PiAtCXNlbGVjdCBBUkNIX0hBU19S
RVNUUklDVEVEX1ZJUlRJT19NRU1PUllfQUNDRVNTDQo+PiAgIAloZWxwDQo+PiAgIAkgIFNl
bGVjdCB0aGlzIG9wdGlvbiwgaWYgeW91IHdhbnQgdG8gYmUgYWJsZSB0byBydW4gdGhpcw0K
Pj4gICAJICBrZXJuZWwgYXMgYSBwcm90ZWN0ZWQgdmlydHVhbGl6YXRpb24gS1ZNIGd1ZXN0
Lg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvczM5MC9tbS9pbml0LmMgYi9hcmNoL3MzOTAvbW0v
aW5pdC5jDQo+PiBpbmRleCA4NmZmZDBkNTFmZDUuLjJjM2I0NTE4MTNlZCAxMDA2NDQNCj4+
IC0tLSBhL2FyY2gvczM5MC9tbS9pbml0LmMNCj4+ICsrKyBiL2FyY2gvczM5MC9tbS9pbml0
LmMNCj4+IEBAIC0zMSw2ICszMSw3IEBADQo+PiAgICNpbmNsdWRlIDxsaW51eC9jbWEuaD4N
Cj4+ICAgI2luY2x1ZGUgPGxpbnV4L2dmcC5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvZG1h
LWRpcmVjdC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybS1mZWF0dXJlLmg+DQo+
PiAgICNpbmNsdWRlIDxhc20vcHJvY2Vzc29yLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC91
YWNjZXNzLmg+DQo+PiAgICNpbmNsdWRlIDxhc20vcGdhbGxvYy5oPg0KPj4gQEAgLTE2OCwy
MiArMTY5LDE0IEBAIGJvb2wgZm9yY2VfZG1hX3VuZW5jcnlwdGVkKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4+ICAgCXJldHVybiBpc19wcm90X3ZpcnRfZ3Vlc3QoKTsNCj4+ICAgfQ0KPj4N
Cj4+IC0jaWZkZWYgQ09ORklHX0FSQ0hfSEFTX1JFU1RSSUNURURfVklSVElPX01FTU9SWV9B
Q0NFU1MNCj4+IC0NCj4+IC1pbnQgYXJjaF9oYXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5
X2FjY2Vzcyh2b2lkKQ0KPj4gLXsNCj4+IC0JcmV0dXJuIGlzX3Byb3RfdmlydF9ndWVzdCgp
Ow0KPj4gLX0NCj4+IC1FWFBPUlRfU1lNQk9MKGFyY2hfaGFzX3Jlc3RyaWN0ZWRfdmlydGlv
X21lbW9yeV9hY2Nlc3MpOw0KPj4gLQ0KPj4gLSNlbmRpZg0KPj4gLQ0KPj4gICAvKiBwcm90
ZWN0ZWQgdmlydHVhbGl6YXRpb24gKi8NCj4+ICAgc3RhdGljIHZvaWQgcHZfaW5pdCh2b2lk
KQ0KPj4gICB7DQo+PiAgIAlpZiAoIWlzX3Byb3RfdmlydF9ndWVzdCgpKQ0KPj4gICAJCXJl
dHVybjsNCj4+DQo+PiArCXBsYXRmb3JtX3NldChQTEFURk9STV9WSVJUSU9fUkVTVFJJQ1RF
RF9NRU1fQUNDRVNTKTsNCj4+ICsNCj4+ICAgCS8qIG1ha2Ugc3VyZSBib3VuY2UgYnVmZmVy
cyBhcmUgc2hhcmVkICovDQo+PiAgIAlzd2lvdGxiX2ZvcmNlID0gU1dJT1RMQl9GT1JDRTsN
Cj4+ICAgCXN3aW90bGJfaW5pdCgxKTsNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9LY29u
ZmlnIGIvYXJjaC94ODYvS2NvbmZpZw0KPj4gaW5kZXggYjAxNDJlMDEwMDJlLi4yMGFjNzI1
NDZhZTQgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9LY29uZmlnDQo+PiArKysgYi9hcmNo
L3g4Ni9LY29uZmlnDQo+PiBAQCAtMTUxNSw3ICsxNTE1LDYgQEAgY29uZmlnIFg4Nl9DUEFf
U1RBVElTVElDUw0KPj4gICBjb25maWcgWDg2X01FTV9FTkNSWVBUDQo+PiAgIAlzZWxlY3Qg
QVJDSF9IQVNfRk9SQ0VfRE1BX1VORU5DUllQVEVEDQo+PiAgIAlzZWxlY3QgRFlOQU1JQ19Q
SFlTSUNBTF9NQVNLDQo+PiAtCXNlbGVjdCBBUkNIX0hBU19SRVNUUklDVEVEX1ZJUlRJT19N
RU1PUllfQUNDRVNTDQo+PiAgIAlkZWZfYm9vbCBuDQo+Pg0KPj4gICBjb25maWcgQU1EX01F
TV9FTkNSWVBUDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tc2h5cGVy
di5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9tc2h5cGVydi5jDQo+PiBpbmRleCA0YjY3MDk0
MjE1YmIuLjk2NTUxOGI5ZDE0YiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9j
cHUvbXNoeXBlcnYuYw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tc2h5cGVydi5j
DQo+PiBAQCAtMTksNiArMTksNyBAQA0KPj4gICAjaW5jbHVkZSA8bGludXgvaTgyNTMuaD4N
Cj4+ICAgI2luY2x1ZGUgPGxpbnV4L3JhbmRvbS5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgv
c3dpb3RsYi5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybS1mZWF0dXJlLmg+DQo+
PiAgICNpbmNsdWRlIDxhc20vcHJvY2Vzc29yLmg+DQo+PiAgICNpbmNsdWRlIDxhc20vaHlw
ZXJ2aXNvci5oPg0KPj4gICAjaW5jbHVkZSA8YXNtL2h5cGVydi10bGZzLmg+DQo+PiBAQCAt
MzQ3LDggKzM0OCwxMCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgbXNfaHlwZXJ2X2luaXRfcGxh
dGZvcm0odm9pZCkNCj4+ICAgI2VuZGlmDQo+PiAgIAkJLyogSXNvbGF0aW9uIFZNcyBhcmUg
dW5lbmxpZ2h0ZW5lZCBTRVYtYmFzZWQgVk1zLCB0aHVzIHRoaXMgY2hlY2s6ICovDQo+PiAg
IAkJaWYgKElTX0VOQUJMRUQoQ09ORklHX0FNRF9NRU1fRU5DUllQVCkpIHsNCj4+IC0JCQlp
ZiAoaHZfZ2V0X2lzb2xhdGlvbl90eXBlKCkgIT0gSFZfSVNPTEFUSU9OX1RZUEVfTk9ORSkN
Cj4+ICsJCQlpZiAoaHZfZ2V0X2lzb2xhdGlvbl90eXBlKCkgIT0gSFZfSVNPTEFUSU9OX1RZ
UEVfTk9ORSkgew0KPj4gICAJCQkJY2Nfc2V0X3ZlbmRvcihDQ19WRU5ET1JfSFlQRVJWKTsN
Cj4+ICsNCj4+IAlwbGF0Zm9ybV9zZXQoUExBVEZPUk1fVklSVElPX1JFU1RSSUNURURfTUVN
X0FDQ0VTUyk7DQo+PiArCQkJfQ0KPj4gICAJCX0NCj4+ICAgCX0NCj4+DQo+IA0KPiBVbmxl
c3MgSSdtIG1pc3VuZGVyc3RhbmRpbmcgc29tZXRoaW5nLCB0aGUgSHlwZXItViBzcGVjaWZp
YyBjaGFuZ2UgaXNuJ3QNCj4gbmVlZGVkLiAgIEh5cGVyLVYgZG9lc24ndCBzdXBwb3J0IHZp
cnRpbyBpbiB0aGUgZmlyc3QgcGxhY2UsIHNvIGl0J3MgYSBiaXQNCj4gdW5leHBlY3RlZCBi
ZSBzZXR0aW5nIGEgdmlydGlvLXJlbGF0ZWQgZmxhZyBpbiBIeXBlci1WIGNvZGUuICAgQWxz
bywgSHlwZXItVg0KPiBndWVzdHMgY2FsbCBzZXZfc2V0dXBfYXJjaCgpIHdpdGggQ0NfQVRU
Ul9HVUVTVF9NRU1fRU5DUllQVCBzZXQsDQo+IHNvIHRoaXMgdmlydGlvLXJlbGF0ZWQgZmxh
ZyB3aWxsIGdldCBzZXQgYW55d2F5IHZpYSB0aGF0IHBhdGguDQoNCk9rYXksIHRoYW5rcy4g
V2lsbCBkcm9wIHRoYXQgY2h1bmsgdGhlbi4NCg0KDQpKdWVyZ2VuDQo=
--------------PVKJ8AyElnAXikkyiJoY2hwt
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------PVKJ8AyElnAXikkyiJoY2hwt--

--------------u2CO02YVk1NKGgC5oPI9sJzg--

--------------j0b7KV03sm3SSS00lOqpuvd3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJpjSkFAwAAAAAACgkQsN6d1ii/Ey98
pgf/WiV67QRBats+u2omAOX4l0/3uBh9EBbHJyfewyl63ed6u5p3nv4ZgOe/R8vyv/YNM9g2Koaq
kHIg61F0LYIYEVPKnTsA8axpm2/9OiuxjSCt/mFu3UpvdIhmWxOZtZWE6vZ+6OvklaY40bYGPjE8
Xacv4RCgsNUvIFJ95zrpLEo5YlGTk/UZSRM+ua5OAT8aK5cvCTWM4tFXI5v60yWsDk4PEMUpUcJa
qo/A9WLQYIiBBaI3YFsua4tqvAxCVkLUy26t1s6sxpzulV+0NpXnr4mZp8JVk8Q6kMfIO//VTuUn
VUBsBn9UReq5Sn7Abux/iLuSKhvqF9423Mm7zchKjA==
=N89D
-----END PGP SIGNATURE-----

--------------j0b7KV03sm3SSS00lOqpuvd3--
