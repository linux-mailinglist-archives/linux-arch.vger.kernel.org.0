Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E506FED34
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 09:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjEKHzg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 03:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbjEKHzV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 03:55:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA50F93C1;
        Thu, 11 May 2023 00:55:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB9051F85D;
        Thu, 11 May 2023 07:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683791705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AM4W6jJZ/DRI5gVfTermbLti5sn9zWX//g7jXz1jDPk=;
        b=Jebl1yEmrQniCo3BzBBis1gTCEAysxs90jLGiBBWTOPX8x0YJYrBbsSWMgclkZpVYE/S0T
        Wa7tTCfg1rrhPVgSDOSfEALqS3XB0e1VspyS9n0dl0qlM5vglgCSkiIQ+0IjcdR6bniSyD
        VGVg4/WK/ngqitSQnYlpcOkK5moWadw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683791705;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AM4W6jJZ/DRI5gVfTermbLti5sn9zWX//g7jXz1jDPk=;
        b=sfoZd7Xwl2k7Bjxp8Q72VotHNfj1fGZvEVsTKpoQ3Y+ZNZ25WHCQih193RiZ94Xx8PRGs+
        8FxmWwEMkddp9gBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E226134B2;
        Thu, 11 May 2023 07:55:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Oo7oHVmfXGQxZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 11 May 2023 07:55:05 +0000
Message-ID: <a2315b9a-0747-1f0f-1f0a-1c6773931db4@suse.de>
Date:   Thu, 11 May 2023 09:55:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 1/6] fbdev/matrox: Remove trailing whitespaces
Content-Language: en-US
To:     Sui Jingfeng <15330273260@189.cn>, deller@gmx.de,
        geert@linux-m68k.org, javierm@redhat.com, daniel@ffwll.ch,
        vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        davem@davemloft.net, James.Bottomley@HansenPartnership.com,
        arnd@arndb.de, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
References: <20230510110557.14343-1-tzimmermann@suse.de>
 <20230510110557.14343-2-tzimmermann@suse.de>
 <0e13efbf-9a48-6e70-fdf3-8290f28c6dc7@189.cn>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <0e13efbf-9a48-6e70-fdf3-8290f28c6dc7@189.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bJhfL5TcgYF7U975xKghZg4q"
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_MED,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bJhfL5TcgYF7U975xKghZg4q
Content-Type: multipart/mixed; boundary="------------5i7j814v73FAY6o1aqJ1mx3I";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sui Jingfeng <15330273260@189.cn>, deller@gmx.de, geert@linux-m68k.org,
 javierm@redhat.com, daniel@ffwll.ch, vgupta@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, davem@davemloft.net,
 James.Bottomley@HansenPartnership.com, arnd@arndb.de, sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org
Message-ID: <a2315b9a-0747-1f0f-1f0a-1c6773931db4@suse.de>
Subject: Re: [PATCH v6 1/6] fbdev/matrox: Remove trailing whitespaces
References: <20230510110557.14343-1-tzimmermann@suse.de>
 <20230510110557.14343-2-tzimmermann@suse.de>
 <0e13efbf-9a48-6e70-fdf3-8290f28c6dc7@189.cn>
In-Reply-To: <0e13efbf-9a48-6e70-fdf3-8290f28c6dc7@189.cn>

--------------5i7j814v73FAY6o1aqJ1mx3I
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTAuMDUuMjMgdW0gMjA6MjAgc2NocmllYiBTdWkgSmluZ2Zlbmc6DQo+IEhp
LCBUaG9tYXMNCj4gDQo+IA0KPiBJIGxvdmUgeW91ciBwYXRjaCwgeWV0IHNvbWV0aGluZyB0
byBpbXByb3ZlOg0KPiANCj4gDQo+IE9uIDIwMjMvNS8xMCAxOTowNSwgVGhvbWFzIFppbW1l
cm1hbm4gd3JvdGU6DQo+PiBGaXggY29kaW5nIHN0eWxlLiBObyBmdW5jdGlvbmFsIGNoYW5n
ZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJt
YW5uQHN1c2UuZGU+DQo+PiBSZXZpZXdlZC1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5k
Yi5kZT4NCj4+IFJldmlld2VkLWJ5OiBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+
DQo+PiBSZXZpZXdlZC1ieTogU3VpIEppbmdmZW5nIDxzdWlqaW5nZmVuZ0Bsb29uZ3Nvbi5j
bj4NCj4+IFRlc3RlZC1ieTogU3VpIEppbmdmZW5nIDxzdWlqaW5nZmVuZ0Bsb29uZ3Nvbi5j
bj4NCj4+IC0tLQ0KPj4gwqAgZHJpdmVycy92aWRlby9mYmRldi9tYXRyb3gvbWF0cm94ZmJf
YWNjZWwuYyB8IDYgKysrLS0tDQo+PiDCoCBkcml2ZXJzL3ZpZGVvL2ZiZGV2L21hdHJveC9t
YXRyb3hmYl9iYXNlLmjCoCB8IDQgKystLQ0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlkZW8vZmJkZXYvbWF0cm94L21hdHJveGZiX2FjY2VsLmMgDQo+PiBiL2RyaXZlcnMv
dmlkZW8vZmJkZXYvbWF0cm94L21hdHJveGZiX2FjY2VsLmMNCj4+IGluZGV4IDljYjA2ODVm
ZWRkZC4uY2U1MTIyNzc5OGExIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy92aWRlby9mYmRl
di9tYXRyb3gvbWF0cm94ZmJfYWNjZWwuYw0KPj4gKysrIGIvZHJpdmVycy92aWRlby9mYmRl
di9tYXRyb3gvbWF0cm94ZmJfYWNjZWwuYw0KPj4gQEAgLTg4LDcgKzg4LDcgQEANCj4+IMKg
IHN0YXRpYyBpbmxpbmUgdm9pZCBtYXRyb3hfY2ZiNF9wYWwodV9pbnQzMl90KiBwYWwpIHsN
Cj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGk7DQo+PiAtDQo+PiArDQo+PiDCoMKgwqDC
oMKgIGZvciAoaSA9IDA7IGkgPCAxNjsgaSsrKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
cGFsW2ldID0gaSAqIDB4MTExMTExMTFVOw0KPj4gwqDCoMKgwqDCoCB9DQo+PiBAQCAtOTYs
NyArOTYsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbWF0cm94X2NmYjRfcGFsKHVfaW50MzJf
dCogcGFsKSB7DQo+PiDCoCBzdGF0aWMgaW5saW5lIHZvaWQgbWF0cm94X2NmYjhfcGFsKHVf
aW50MzJfdCogcGFsKSB7DQo+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBpOw0KPj4gLQ0K
Pj4gKw0KPj4gwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgMTY7IGkrKykgew0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIHBhbFtpXSA9IGkgKiAweDAxMDEwMTAxVTsNCj4+IMKgwqDCoMKg
wqAgfQ0KPj4gQEAgLTQ4Miw3ICs0ODIsNyBAQCBzdGF0aWMgdm9pZCBtYXRyb3hmYl8xYnBw
X2ltYWdlYmxpdChzdHJ1Y3QgDQo+PiBtYXRyb3hfZmJfaW5mbyAqbWluZm8sIHVfaW50MzJf
dCBmZ3gsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBUZWxsLi4uIHdlbGws
IHdoeSBib3RoZXIuLi4gKi8NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdoaWxl
IChoZWlnaHQtLSkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
aXplX3QgaTsNCj4+IC0NCj4+ICsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZm9yIChpID0gMDsgaSA8IHN0ZXA7IGkgKz0gNCkgew0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEhvcGUgdGhhdCB0aGVyZSBhcmUg
YXQgbGVhc3QgdGhyZWUgcmVhZGFibGUgDQo+PiBieXRlcyBiZXlvbmQgdGhlIGVuZCBvZiBi
aXRtYXAgKi8NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBmYl93cml0ZWwoZ2V0X3VuYWxpZ25lZCgodV9pbnQzMl90KikoY2hhcmRhdGEgKyANCj4+
IGkpKSxtbWlvLnZhZGRyKTsNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2
L21hdHJveC9tYXRyb3hmYl9iYXNlLmggDQo+PiBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvbWF0
cm94L21hdHJveGZiX2Jhc2UuaA0KPj4gaW5kZXggOTU4YmU2ODA1Zjg3Li5jOTNjNjliYmNk
NTcgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L21hdHJveC9tYXRyb3hm
Yl9iYXNlLmgNCj4+ICsrKyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvbWF0cm94L21hdHJveGZi
X2Jhc2UuaA0KPj4gQEAgLTMwMSw5ICszMDEsOSBAQCBzdHJ1Y3QgbWF0cm94X2FsdG91dCB7
DQo+PiDCoMKgwqDCoMKgIGludMKgwqDCoMKgwqDCoMKgICgqdmVyaWZ5bW9kZSkodm9pZCog
YWx0b3V0X2RldiwgdV9pbnQzMl90IG1vZGUpOw0KPj4gwqDCoMKgwqDCoCBpbnTCoMKgwqDC
oMKgwqDCoCAoKmdldHF1ZXJ5Y3RybCkodm9pZCogYWx0b3V0X2RldiwNCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdjRsMl9xdWVyeWN0
cmwqIGN0cmwpOw0KPiANCj4gTm90aWNlZCB0aGF0IHRoZXJlIGFyZSBwbGVudHkgb2YgY29k
aW5nIHN0eWxlIHByb2JsZW1zIGluIG1hdHJveGZiX2Jhc2UuaCwNCj4gDQo+IHdoeSB5b3Ug
b25seSBmaXggYSBmZXcgb2YgdGhlbT/CoMKgIFRha2UgdGhpcyB0d28gbGluZSBhcyBhbiBl
eGFtcGxlLCANCj4gc2hvdWxkbid0DQo+IA0KPiB0aGV5IGJlIGZpeGVkIGFsc28gYXMgZm9s
bG93aW5nPw0KDQpJIGNvbmZpZ3VyZWQgbXkgdGV4dCBlZGl0b3IgdG8gcmVtb3ZlIHRyYWls
aW5nIHdoaXRlc3BhY2VzIA0KYXV0b21hdGljYWxseS4gVGhhdCBrZWVwcyBteSBvd24gcGF0
Y2hlcyBmcmVlIG9mIHRoZW0uICBCdXQgdGhlIGVkaXRvciANCnJlbW92ZXMgYWxsIHRyYWls
aW5nIHdoaXRlc3BhY2VzLCBpbmNsdWRpbmcgdGhvc2UgdGhhdCBoYXZlIGJlZW4gdGhlcmUg
DQpiZWZvcmUuIElmIEkgZW5jb3VudGVyIHN1Y2ggYSBjYXNlLCBJIHNwbGl0IG91dCB0aGUg
d2hpdGVzcGFjZSBmaXggYW5kIA0Kc3VibWl0IGl0IHNlcGFyYXRlbHkuDQoNCkJ1dCB0aGUg
d29yayBJIGRvIHdpdGhpbiBmYmRldiBpcyBtb3N0bHkgZm9yIGltcHJvdmluZyBEUk0uIEZv
ciB0aGUgDQpvdGhlciBpc3N1ZXMgaW4gdGhpcyBmaWxlLCBJIGRvbid0IHRoaW5rIHRoYXQg
bWF0cm94ZmIgc2hvdWxkIGV2ZW4gYmUgDQphcm91bmQgYW55IGxvbmdlci4gRmJkZXYgaGFz
IGJlZW4gZGVwcmVjYXRlZCBmb3IgYSBsb25nIHRpbWUuIEJ1dCBhIA0Kc21hbGwgbnVtYmVy
IG9mIGRyaXZlcnMgYXJlIHN0aWxsIGluIHVzZSBhbmQgd2Ugc3RpbGwgbmVlZCBpdHMgDQpm
cmFtZWJ1ZmZlciBjb25zb2xlLiBTbyBzb21lb25lIHNob3VsZCBlaXRoZXIgcHV0IHNpZ25p
ZmljYW50IGVmZm9ydCANCmludG8gbWFpbnRhaW5pbmcgZmJkZXYsIG9yIGl0IHNob3VsZCBi
ZSBwaGFzZWQgb3V0LiBCdXQgbmVpdGhlciBpcyANCmhhcHBlbmluZy4NCg0KQmVzdCByZWdh
cmRzDQpUaG9tYXMNCg0KPiANCj4gDQo+ICDCoMKgwqDCoCBpbnTCoMKgwqDCoMKgwqDCoCAo
KnZlcmlmeW1vZGUpKHZvaWQgKmFsdG91dF9kZXYsIHVfaW50MzJfdCBtb2RlKTsNCj4gIMKg
wqDCoMKgIGludMKgwqDCoMKgwqDCoMKgICgqZ2V0cXVlcnljdHJsKSh2b2lkICphbHRvdXRf
ZGV2LA0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3QgdjRsMl9xdWVyeWN0cmwgKmN0cmwpOw0KPiANCj4gDQo+PiAtwqDCoMKgIGludMKgwqDC
oMKgwqDCoMKgICgqZ2V0Y3RybCkodm9pZCogYWx0b3V0X2RldiwNCj4+ICvCoMKgwqAgaW50
wqDCoMKgwqDCoMKgwqAgKCpnZXRjdHJsKSh2b2lkICphbHRvdXRfZGV2LA0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdjRsMl9jb250cm9s
KiBjdHJsKTsNCj4+IC3CoMKgwqAgaW50wqDCoMKgwqDCoMKgwqAgKCpzZXRjdHJsKSh2b2lk
KiBhbHRvdXRfZGV2LA0KPj4gK8KgwqDCoCBpbnTCoMKgwqDCoMKgwqDCoCAoKnNldGN0cmwp
KHZvaWQgKmFsdG91dF9kZXYsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCB2NGwyX2NvbnRyb2wqIGN0cmwpOw0KPj4gwqAgfTsNCg0KLS0g
DQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBT
b2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkw
NDYxIE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3IE15ZXJzLCBB
bmRyZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChBRyBOdWVybmJl
cmcpDQo=

--------------5i7j814v73FAY6o1aqJ1mx3I--

--------------bJhfL5TcgYF7U975xKghZg4q
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRcn1kFAwAAAAAACgkQlh/E3EQov+C9
OxAAqhBorNkTOz+Q460bIwbzDPC8060V7y9mfqMtxjM7xhcAL/jLLBs/y20OIbWrkMcEMKYE5ERq
/as0MgOKcM22gRk58GSoD2YxRy7TZapielYpCWK/GRwFIoTOqEaclN97aY556vbzyDS6OTdiGQE3
bsL9XbG6f06/BWzNX0johRW2bAp67olapLCEf2ClfUkSUl+PPgtYy6sjP2rJiFX5se3kJ1EPh6eK
8fAmkUB5KidgIiQ6Vb1zTCKtv4AicVGpFoEE/yhlNNBwmQwM7gArtSo4wmFnQV3EmcTgUDb0EHXe
dM0iz6K3C2RmtZ85SIP4Yyua77IAPXmarf3QPVjLrTfEaecfWCe2+N9W9IOOnEHHx6M86j1qYLqH
9lwrIhLWeCTSpjJYmwgyyYiMN8WwhYEu2PoAE62iTAN0v3r0y4F2fDnmsOGmCuRe0IkDFDZgbnU4
+soqxQK3NEcKeuKdjKC4oRyu6LDh1whWZ1H3G2NBx2NYcMRrPcltpAWqDCtH+f1eCFU3Q2l3b6Ro
ranVnVsxyYtqZrshXMbvt4hYUhG8a7Zunm8oIwTwcdYvZItbmSFs4z8ULkmxNiwBouwGnhECpMBn
b8khSwvi0O6KO4t2zn62L2lynSr8DUTHJM/yIUlOug0uDtAktQaWu9nkSjuY+lwKPLnL/024VuO2
m6Q=
=DLpe
-----END PGP SIGNATURE-----

--------------bJhfL5TcgYF7U975xKghZg4q--
