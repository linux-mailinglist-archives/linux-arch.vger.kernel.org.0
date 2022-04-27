Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D209511A4F
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbiD0OR3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiD0OR3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 10:17:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ABA54194;
        Wed, 27 Apr 2022 07:14:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 371D521122;
        Wed, 27 Apr 2022 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651068856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CYg8gr5wdcRyNG4AdxCsOdtftu2BHg4O2FTCP/bxq/Q=;
        b=UXIU7N2CQQ5qRMc2FRXJprmzFwf/qo7e51hP46lpgE4FMqJqhD5OooyjrY2AWeEi1koB1Z
        ZGTys0DsW9TZY9F/6dFpFtEikB69Bp29GagoYcXl8I+NHhNJUW00ppcEnrtiNzjJU/KeGe
        in+uFjE4wRsHo3IbUhWG+MNPEONi5eQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60A9213A39;
        Wed, 27 Apr 2022 14:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +JM4FrdPaWLnbwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 27 Apr 2022 14:14:15 +0000
Message-ID: <f1fa517f-a59d-df48-b5c5-f38ce210d999@suse.com>
Date:   Wed, 27 Apr 2022 16:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
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
 <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com> <Ymk2/N/DdAyxQnV0@zn.tnic>
 <2a340424-29e6-8ad8-0181-f70450eecb80@suse.com>
 <c959d3ea-1187-3e88-287b-27e75f0225e8@amd.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <c959d3ea-1187-3e88-287b-27e75f0225e8@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qrX1Zw0otlm9chkAauIvtpiu"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qrX1Zw0otlm9chkAauIvtpiu
Content-Type: multipart/mixed; boundary="------------SjQ8Clt6NV07sBwPPOSV6wCG";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
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
Message-ID: <f1fa517f-a59d-df48-b5c5-f38ce210d999@suse.com>
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com> <Ymgtb2dSNYz7DBqx@zn.tnic>
 <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com> <Ymk2/N/DdAyxQnV0@zn.tnic>
 <2a340424-29e6-8ad8-0181-f70450eecb80@suse.com>
 <c959d3ea-1187-3e88-287b-27e75f0225e8@amd.com>
In-Reply-To: <c959d3ea-1187-3e88-287b-27e75f0225e8@amd.com>

--------------SjQ8Clt6NV07sBwPPOSV6wCG
Content-Type: multipart/mixed; boundary="------------cGEVlD8i867vhmcCg7GQujS6"

--------------cGEVlD8i867vhmcCg7GQujS6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDQuMjIgMTY6MDksIFRvbSBMZW5kYWNreSB3cm90ZToNCj4gT24gNC8yNy8yMiAw
NzozNywgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IE9uIDI3LjA0LjIyIDE0OjI4LCBCb3Jp
c2xhdiBQZXRrb3Ygd3JvdGU6DQo+Pj4gT24gV2VkLCBBcHIgMjcsIDIwMjIgYXQgMDg6Mzc6
MzFBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+Pj4gT24gMjYuMDQuMjIgMTk6
MzUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4+Pj4+IE9uIFR1ZSwgQXByIDI2LCAyMDIy
IGF0IDAzOjQwOjIxUE0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4+Pj4gwqDC
oCAvKiBwcm90ZWN0ZWQgdmlydHVhbGl6YXRpb24gKi8NCj4+Pj4+PiDCoMKgIHN0YXRpYyB2
b2lkIHB2X2luaXQodm9pZCkNCj4+Pj4+PiDCoMKgIHsNCj4+Pj4+PiDCoMKgwqDCoMKgwqAg
aWYgKCFpc19wcm90X3ZpcnRfZ3Vlc3QoKSkNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm47DQo+Pj4+Pj4gK8KgwqDCoCBwbGF0Zm9ybV9zZXRfZmVhdHVyZShQTEFURk9S
TV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUNDRVNTKTsNCj4+Pj4+DQo+Pj4+PiBLaW5kYSBs
b25nLWlzaCBmb3IgbXkgdGFzdGUuIEknbGwgcHJvYmFibHkgY2FsbCBpdDoNCj4+Pj4+DQo+
Pj4+PiDCoMKgwqDCoHBsYXRmb3JtX3NldCgpDQo+Pj4+Pg0KPj4+Pj4gYXMgaXQgaXMgaW1w
bGljaXQgdGhhdCBpdCBzZXRzIGEgZmVhdHVyZSBiaXQuDQo+Pj4+DQo+Pj4+IE9rYXksIGZp
bmUgd2l0aCBtZS4NCj4+Pj4NCj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L21tL21lbV9lbmNyeXB0X2lkZW50aXR5LmMgDQo+Pj4+Pj4gYi9hcmNoL3g4Ni9tbS9tZW1f
ZW5jcnlwdF9pZGVudGl0eS5jDQo+Pj4+Pj4gaW5kZXggYjQzYmMyNGQyYmI2Li42MDQzYmE2
Y2QxN2QgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfaWRl
bnRpdHkuYw0KPj4+Pj4+ICsrKyBiL2FyY2gveDg2L21tL21lbV9lbmNyeXB0X2lkZW50aXR5
LmMNCj4+Pj4+PiBAQCAtNDAsNiArNDAsNyBAQA0KPj4+Pj4+IMKgwqAgI2luY2x1ZGUgPGxp
bnV4L21tLmg+DQo+Pj4+Pj4gwqDCoCAjaW5jbHVkZSA8bGludXgvbWVtX2VuY3J5cHQuaD4N
Cj4+Pj4+PiDCoMKgICNpbmNsdWRlIDxsaW51eC9jY19wbGF0Zm9ybS5oPg0KPj4+Pj4+ICsj
aW5jbHVkZSA8bGludXgvcGxhdGZvcm0tZmVhdHVyZS5oPg0KPj4+Pj4+IMKgwqAgI2luY2x1
ZGUgPGFzbS9zZXR1cC5oPg0KPj4+Pj4+IMKgwqAgI2luY2x1ZGUgPGFzbS9zZWN0aW9ucy5o
Pg0KPj4+Pj4+IEBAIC01NjYsNiArNTY3LDEwIEBAIHZvaWQgX19pbml0IHNtZV9lbmFibGUo
c3RydWN0IGJvb3RfcGFyYW1zICpicCkNCj4+Pj4+PiDCoMKgwqDCoMKgwqAgfSBlbHNlIHsN
Cj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBTRVYgc3RhdGUgY2Fubm90IGJlIGNv
bnRyb2xsZWQgYnkgYSBjb21tYW5kIGxpbmUgb3B0aW9uICovDQo+Pj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc21lX21lX21hc2sgPSBtZV9tYXNrOw0KPj4+Pj4+ICsNCj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgLyogU2V0IHJlc3RyaWN0ZWQgbWVtb3J5IGFjY2VzcyBmb3Igdmly
dGlvLiAqLw0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBwbGF0Zm9ybV9zZXRfZmVhdHVyZShQ
TEFURk9STV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUNDRVNTKTsNCj4gDQo+IFRoaXMgaXMg
d2F5IGVhcmx5IGluIHRoZSBib290LCBidXQgaXQgYXBwZWFycyB0aGF0IG1hcmtpbmcgdGhl
IHBsYXRmb3JtIGZlYXR1cmUgDQo+IGJpdG1hcCBhcyBfX3JlYWRfbW9zdGx5IHB1dHMgdGhp
cyBpbiB0aGUgLmRhdGEgc2VjdGlvbiwgc28gYXZvaWRzIHRoZSBpc3N1ZSBvZiANCj4gYnNz
IGJlaW5nIGNsZWFyZWQuDQoNCkluIFYyIChub3QgeWV0IHBvc3RlZCkgSSBoYXZlIG1vdmVk
IHRoZSBjYWxsIHRvIHNldl9zZXR1cF9hcmNoKCkuDQoNCj4gDQo+IFREWCBzdXBwb3J0IGFs
c28gdXNlcyB0aGUgYXJjaF9oYXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2Vzcygp
IGZ1bmN0aW9uIA0KPiBhbmQgd2lsbCBuZWVkIHRvIGJlIHVwZGF0ZWQuDQoNClllcy4NCg0K
PiBTZWVtcyBsaWtlIGEgbG90IG9mIGNoYW5nZXMsIEkganVzdCB3b25kZXIgaWYgdGhlIHRo
ZSBhcmNoX2hhcy4uLigpIGZ1bmN0aW9uIA0KPiBjb3VsZG4ndCBiZSB1cGRhdGVkIHRvIGFs
c28gaW5jbHVkZSBhIFhlbiBjaGVjaz8NCg0KVGhpcyB3YXMgbm90IHNlZW4gdG8gYmUgYSBu
aWNlIHNvbHV0aW9uLg0KDQpBbmQgVEJILCBJIHRoaW5rIHRoaXMgc2VyaWVzIGlzIG1ha2lu
ZyB0aGUgY29kZSBtdWNoIGNsZWFuZXIuIExvb2sgYXQgdGhlDQpkaWZmc3RhdCBvZiB0aGlz
IHBhdGNoLg0KDQoNCkp1ZXJnZW4NCg==
--------------cGEVlD8i867vhmcCg7GQujS6
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------cGEVlD8i867vhmcCg7GQujS6--

--------------SjQ8Clt6NV07sBwPPOSV6wCG--

--------------qrX1Zw0otlm9chkAauIvtpiu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJpT7YFAwAAAAAACgkQsN6d1ii/Ey8N
uAf+Jas60ulcqZxW/5BLONH0Ysyzp+8tr8yRp44PyWuOsMeWy7WfcogAZD+WsimNGhr6i1KqA/F6
NWAfvn7HEAGBS99DMJgHBJzWUv7yzfo6t6PQBu41g2XGyDuJabILztdVj171jyyquK5CPvJDmRfb
yKIptT2SfLxnK03HwLES7EbIVCvnTCMVznBy5PaTfxx8PBjgK8Y4EWP0R/QQPCeokBVT5pQXPMuX
pt/33FiukREX57d4h6GSBxLimFu3IuHbyL6VefObUbd9H3Oiy1I6L334KqGkDf4LQ2uUVn4xVP71
LlF0czzuLhUn3IUqgUqUO9axHSU0UoWEPCbcofbJqA==
=K2x+
-----END PGP SIGNATURE-----

--------------qrX1Zw0otlm9chkAauIvtpiu--
