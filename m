Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981236FF443
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 16:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbjEKO2S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 10:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbjEKO2A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 10:28:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F7411B4C;
        Thu, 11 May 2023 07:27:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8AE131FF17;
        Thu, 11 May 2023 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683815233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgVMOzog0CbY5kAJjGieXuOcfsVfP8OP1lrWJlFGyqo=;
        b=0GisIYMdtqN2+kETF+1umedZznqDFEu6Bq1m9PgaXvaIzayPg2BLMDEwVJOrubA2AdIyyp
        kkCrk6xHT+djO0rZNjg4pMZObXIx2lXXe7Ng7TRtvcMzUgq3S5AJbEFINWkMmT7ss5cR1C
        Mx0yG8dfxMgx7J4ZuPX71cS4HCQ38MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683815233;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgVMOzog0CbY5kAJjGieXuOcfsVfP8OP1lrWJlFGyqo=;
        b=wLrtUwDBN1VzyHXOkRCKHtQqxV4KGA9pFjcoEcxdzOW7B/PsYo4XgPVw6tGQ/cKmGuyyUW
        L0Tmr27yMC5M0LBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22D33134B2;
        Thu, 11 May 2023 14:27:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vfePB0H7XGTlSQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 11 May 2023 14:27:13 +0000
Message-ID: <e7bd021c-1a6b-6e47-143a-36ae2fd2fe6b@suse.de>
Date:   Thu, 11 May 2023 16:27:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 1/6] fbdev/matrox: Remove trailing whitespaces
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, Sui Jingfeng <15330273260@189.cn>,
        geert@linux-m68k.org, javierm@redhat.com, daniel@ffwll.ch,
        vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        davem@davemloft.net, arnd@arndb.de, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
References: <20230510110557.14343-1-tzimmermann@suse.de>
 <20230510110557.14343-2-tzimmermann@suse.de>
 <0e13efbf-9a48-6e70-fdf3-8290f28c6dc7@189.cn>
 <a2315b9a-0747-1f0f-1f0a-1c6773931db4@suse.de>
 <15fe1489-f0fa-bbf6-ec08-a270bd4f1559@gmx.de>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <15fe1489-f0fa-bbf6-ec08-a270bd4f1559@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oqkBIdidQhXHM6LZbZ0g22gh"
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------oqkBIdidQhXHM6LZbZ0g22gh
Content-Type: multipart/mixed; boundary="------------cF7ELr8NEJdtB0AS8Jfn35yF";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Helge Deller <deller@gmx.de>, Sui Jingfeng <15330273260@189.cn>,
 geert@linux-m68k.org, javierm@redhat.com, daniel@ffwll.ch,
 vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 davem@davemloft.net, arnd@arndb.de, sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org
Message-ID: <e7bd021c-1a6b-6e47-143a-36ae2fd2fe6b@suse.de>
Subject: Re: [PATCH v6 1/6] fbdev/matrox: Remove trailing whitespaces
References: <20230510110557.14343-1-tzimmermann@suse.de>
 <20230510110557.14343-2-tzimmermann@suse.de>
 <0e13efbf-9a48-6e70-fdf3-8290f28c6dc7@189.cn>
 <a2315b9a-0747-1f0f-1f0a-1c6773931db4@suse.de>
 <15fe1489-f0fa-bbf6-ec08-a270bd4f1559@gmx.de>
In-Reply-To: <15fe1489-f0fa-bbf6-ec08-a270bd4f1559@gmx.de>

--------------cF7ELr8NEJdtB0AS8Jfn35yF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTEuMDUuMjMgdW0gMTU6MDUgc2NocmllYiBIZWxnZSBEZWxsZXI6DQo+IE9u
IDUvMTEvMjMgMDk6NTUsIFRob21hcyBaaW1tZXJtYW5uIHdyb3RlOg0KPj4gSGkNCj4+DQo+
PiBBbSAxMC4wNS4yMyB1bSAyMDoyMCBzY2hyaWViIFN1aSBKaW5nZmVuZzoNCj4+PiBIaSwg
VGhvbWFzDQo+Pj4NCj4+Pg0KPj4+IEkgbG92ZSB5b3VyIHBhdGNoLCB5ZXQgc29tZXRoaW5n
IHRvIGltcHJvdmU6DQo+Pj4NCj4+Pg0KPj4+IE9uIDIwMjMvNS8xMCAxOTowNSwgVGhvbWFz
IFppbW1lcm1hbm4gd3JvdGU6DQo+Pj4+IEZpeCBjb2Rpbmcgc3R5bGUuIE5vIGZ1bmN0aW9u
YWwgY2hhbmdlcy4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1lcm1h
bm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+DQo+Pj4+IFJldmlld2VkLWJ5OiBBcm5kIEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPg0KPj4+PiBSZXZpZXdlZC1ieTogU2FtIFJhdm5ib3JnIDxz
YW1AcmF2bmJvcmcub3JnPg0KPj4+PiBSZXZpZXdlZC1ieTogU3VpIEppbmdmZW5nIDxzdWlq
aW5nZmVuZ0Bsb29uZ3Nvbi5jbj4NCj4+Pj4gVGVzdGVkLWJ5OiBTdWkgSmluZ2ZlbmcgPHN1
aWppbmdmZW5nQGxvb25nc29uLmNuPg0KPj4+PiAtLS0NCj4+Pj4gwqAgZHJpdmVycy92aWRl
by9mYmRldi9tYXRyb3gvbWF0cm94ZmJfYWNjZWwuYyB8IDYgKysrLS0tDQo+Pj4+IMKgIGRy
aXZlcnMvdmlkZW8vZmJkZXYvbWF0cm94L21hdHJveGZiX2Jhc2UuaMKgIHwgNCArKy0tDQo+
Pj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9mYmRldi9tYXRyb3gv
bWF0cm94ZmJfYWNjZWwuYyANCj4+Pj4gYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L21hdHJveC9t
YXRyb3hmYl9hY2NlbC5jDQo+Pj4+IGluZGV4IDljYjA2ODVmZWRkZC4uY2U1MTIyNzc5OGEx
IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L21hdHJveC9tYXRyb3hm
Yl9hY2NlbC5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvbWF0cm94L21hdHJv
eGZiX2FjY2VsLmMNCj4+Pj4gQEAgLTg4LDcgKzg4LDcgQEANCj4+Pj4gwqAgc3RhdGljIGlu
bGluZSB2b2lkIG1hdHJveF9jZmI0X3BhbCh1X2ludDMyX3QqIHBhbCkgew0KPj4+PiDCoMKg
wqDCoMKgIHVuc2lnbmVkIGludCBpOw0KPj4+PiAtDQo+Pj4+ICsNCj4+Pj4gwqDCoMKgwqDC
oCBmb3IgKGkgPSAwOyBpIDwgMTY7IGkrKykgew0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
cGFsW2ldID0gaSAqIDB4MTExMTExMTFVOw0KPj4+PiDCoMKgwqDCoMKgIH0NCj4+Pj4gQEAg
LTk2LDcgKzk2LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIG1hdHJveF9jZmI0X3BhbCh1X2lu
dDMyX3QqIHBhbCkgew0KPj4+PiDCoCBzdGF0aWMgaW5saW5lIHZvaWQgbWF0cm94X2NmYjhf
cGFsKHVfaW50MzJfdCogcGFsKSB7DQo+Pj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGk7
DQo+Pj4+IC0NCj4+Pj4gKw0KPj4+PiDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCAxNjsg
aSsrKSB7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBwYWxbaV0gPSBpICogMHgwMTAxMDEw
MVU7DQo+Pj4+IMKgwqDCoMKgwqAgfQ0KPj4+PiBAQCAtNDgyLDcgKzQ4Miw3IEBAIHN0YXRp
YyB2b2lkIG1hdHJveGZiXzFicHBfaW1hZ2VibGl0KHN0cnVjdCANCj4+Pj4gbWF0cm94X2Zi
X2luZm8gKm1pbmZvLCB1X2ludDMyX3QgZmd4LA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAvKiBUZWxsLi4uIHdlbGwsIHdoeSBib3RoZXIuLi4gKi8NCj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgd2hpbGUgKGhlaWdodC0tKSB7DQo+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZV90IGk7DQo+Pj4+IC0NCj4+Pj4gKw0K
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkg
PCBzdGVwOyBpICs9IDQpIHsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC8qIEhvcGUgdGhhdCB0aGVyZSBhcmUgYXQgbGVhc3QgdGhyZWUgcmVh
ZGFibGUgDQo+Pj4+IGJ5dGVzIGJleW9uZCB0aGUgZW5kIG9mIGJpdG1hcCAqLw0KPj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmJfd3JpdGVsKGdl
dF91bmFsaWduZWQoKHVfaW50MzJfdCopKGNoYXJkYXRhIA0KPj4+PiArIGkpKSxtbWlvLnZh
ZGRyKTsNCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvbWF0cm94L21h
dHJveGZiX2Jhc2UuaCANCj4+Pj4gYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L21hdHJveC9tYXRy
b3hmYl9iYXNlLmgNCj4+Pj4gaW5kZXggOTU4YmU2ODA1Zjg3Li5jOTNjNjliYmNkNTcgMTAw
NjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvbWF0cm94L21hdHJveGZiX2Jh
c2UuaA0KPj4+PiArKysgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L21hdHJveC9tYXRyb3hmYl9i
YXNlLmgNCj4+Pj4gQEAgLTMwMSw5ICszMDEsOSBAQCBzdHJ1Y3QgbWF0cm94X2FsdG91dCB7
DQo+Pj4+IMKgwqDCoMKgwqAgaW50wqDCoMKgwqDCoMKgwqAgKCp2ZXJpZnltb2RlKSh2b2lk
KiBhbHRvdXRfZGV2LCB1X2ludDMyX3QgbW9kZSk7DQo+Pj4+IMKgwqDCoMKgwqAgaW50wqDC
oMKgwqDCoMKgwqAgKCpnZXRxdWVyeWN0cmwpKHZvaWQqIGFsdG91dF9kZXYsDQo+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdjRsMl9x
dWVyeWN0cmwqIGN0cmwpOw0KPj4+DQo+Pj4gTm90aWNlZCB0aGF0IHRoZXJlIGFyZSBwbGVu
dHkgb2YgY29kaW5nIHN0eWxlIHByb2JsZW1zIGluIA0KPj4+IG1hdHJveGZiX2Jhc2UuaCwN
Cj4+Pg0KPj4+IHdoeSB5b3Ugb25seSBmaXggYSBmZXcgb2YgdGhlbT/CoMKgIFRha2UgdGhp
cyB0d28gbGluZSBhcyBhbiBleGFtcGxlLCANCj4+PiBzaG91bGRuJ3QNCj4+Pg0KPj4+IHRo
ZXkgYmUgZml4ZWQgYWxzbyBhcyBmb2xsb3dpbmc/DQo+Pg0KPj4gSSBjb25maWd1cmVkIG15
IHRleHQgZWRpdG9yIHRvIHJlbW92ZSB0cmFpbGluZyB3aGl0ZXNwYWNlcw0KPj4gYXV0b21h
dGljYWxseS4gVGhhdCBrZWVwcyBteSBvd24gcGF0Y2hlcyBmcmVlIG9mIHRoZW0uwqAgQnV0
IHRoZQ0KPj4gZWRpdG9yIHJlbW92ZXMgYWxsIHRyYWlsaW5nIHdoaXRlc3BhY2VzLCBpbmNs
dWRpbmcgdGhvc2UgdGhhdCBoYXZlDQo+PiBiZWVuIHRoZXJlIGJlZm9yZS4gSWYgSSBlbmNv
dW50ZXIgc3VjaCBhIGNhc2UsIEkgc3BsaXQgb3V0IHRoZQ0KPj4gd2hpdGVzcGFjZSBmaXgg
YW5kIHN1Ym1pdCBpdCBzZXBhcmF0ZWx5Lg0KPj4NCj4+IEJ1dCB0aGUgd29yayBJIGRvIHdp
dGhpbiBmYmRldiBpcyBtb3N0bHkgZm9yIGltcHJvdmluZyBEUk0uDQo+IA0KPiBTdXJlLg0K
PiANCj4+IEZvciB0aGUNCj4+IG90aGVyIGlzc3VlcyBpbiB0aGlzIGZpbGUsIEkgZG9uJ3Qg
dGhpbmsgdGhhdCBtYXRyb3hmYiBzaG91bGQgZXZlbiBiZQ0KPj4gYXJvdW5kIGFueSBsb25n
ZXIuIEZiZGV2IGhhcyBiZWVuIGRlcHJlY2F0ZWQgZm9yIGEgbG9uZyB0aW1lLiBCdXQgYQ0K
Pj4gc21hbGwgbnVtYmVyIG9mIGRyaXZlcnMgYXJlIHN0aWxsIGluIHVzZSBhbmQgd2Ugc3Rp
bGwgbmVlZCBpdHMNCj4+IGZyYW1lYnVmZmVyIGNvbnNvbGUuIFNvIHNvbWVvbmUgc2hvdWxk
IGVpdGhlciBwdXQgc2lnbmlmaWNhbnQgZWZmb3J0DQo+PiBpbnRvIG1haW50YWluaW5nIGZi
ZGV2LCBvciBpdCBzaG91bGQgYmUgcGhhc2VkIG91dC4gQnV0IG5laXRoZXIgaXMNCj4+IGhh
cHBlbmluZy4NCj4gDQo+IFlvdSdyZSB3cm9uZy4NCg0KSSdtIG5vdC4gSSBkb24ndCBjbGFp
bSB0aGF0IHRoZXNlIGRyaXZlcnMgYXJlIGFsbCBicm9rZW4uIEJ1dCBmYmRldiBhcyBhIA0K
d2hvbGUgaXMgYml0LXJvdHRpbmcgYW5kIG5vIG9uZSBhdHRlbXB0cyB0byBhZGRyZXNzIHRo
aXMuIFRoZXJlIGFyZSANCnNldmVyYWwgcmVjZW50IGV4YW1wbGVzIG9mIHRoaXM6DQoNCiAg
KiBJIHJlY2VudGx5IHNlbmQgb3V0IGEgMTAwLXBhdGNoZXMgc2VyaWVzIHRvIGltcHJvdmUg
cGFyYW1ldGVyIA0KcGFyc2luZyBhbmQgYXZvaWQgbWVtb3J5IGxlYWtzLiBUaGF0IGdvdCBz
aG90IGRvd24uIEkgZGlkbid0IGF0dGVtcHQgdG8gDQpzdXBwb3J0IHBhcmFtZXRlciBwYXJz
aW5nIGZvciBtb2R1bGUgYnVpbGRzLg0KDQogICogVGhlcmUncyBiZWVuIGEgMTUteXJzIG9s
ZCBidWcgaW4gZmJkZXYncyByZWFkL3dyaXRlIHdoZXJlIHRoZXkgDQpyZXR1cm4gYW4gaW5j
b3JyZWN0IHZhbHVlLg0KDQoqIFNlZSB0aGUgb3RoZXIgZGlzY3Vzc2lvbiBvbiB0aGlzIHBh
dGNoc2V0IG9uIHRoZSBzdGF0ZSBvZiBoaXRmYi4NCg0KICAqIFRoZSBmYmRldiBjb2RlIEkg
cmVjZW50bHkgY2xlYW5lZCB1cCBoYWQgYnVncyBpbiBob3cgaXQgdXNlcyBzb21lIG9mIA0K
ZmJkZXYncyBiYXNpYyBidWlsZGluZyBibG9ja3MgKHNlZSB0aGUgc2NyZWVuX2Jhc2Uvc2Ny
ZWVuX2J1ZmZlciBjb25mdXNpb24pLg0KDQogICogPGFzbS1nZW5lcmljL2ZiLmg+IGhhcyBi
ZWVuIGluIHRoZSB0cmVlIHNpbmNlIDIwMDkgYW5kIG5vIG9uZSANCmF0dGVtcHRlZCB0byBp
bmNsdWRlIGl0IHVudGlsIG5vdy4NCg0KTm9uZSBvZiB0aGlzIGlzIGEgc2lnbiBvZiBnb29k
IG1haW50ZW5hbmNlLg0KDQpBcyBJJ3ZlIHdvcmtlZCBvbiBEUk0ncyBmYmRldiBlbXVsYXRp
b24gYSBsb3QsIEkgdHJ5IHRvIGJlIGEgZ29vZCBrZXJuZWwgDQpjaXRpemVuIGFuZCBjbGVh
biB1cCBpbiBmYmRldiBhcyB3ZWxsIHdoZW4gSSBzZWUgYSBwcm9ibGVtLiBCdXQgSSdkIA0K
cmVhbGx5IGxpa2UgdG8gc2VlIG1vc3Qgb2YgdGhlc2UgZHJpdmVycyBiZWluZyBtb3ZlZCBp
bnRvIHN0YWdpbmcgYW5kIA0KZGVsZXRlZCBzb29uIGFmdGVyd2FyZHMuIFVzZXJzIHdpbGwg
Y29tcGxhaW4gYWJvdXQgdGhvc2UgZHJpdmVycyB0aGF0IA0KYXJlIHJlYWxseSBzdGlsbCBy
ZXF1aXJlZC4gVGhvc2UgbWlnaHQgYmUgd29ydGggdG8gc3BlbmQgZWZmb3J0IG9uLg0KDQo+
IA0KPiBZb3UgZG9uJ3QgbWVudGlvbiB0aGF0IGZvciBtb3N0IG9sZGVyIG1hY2hpbmVzIERS
TSBpc24ndCBhbiBhY2NlcHRhYmxlDQo+IHdheSB0byBnbyBkdWUgdG8gaXQncyBsaW1pdGF0
aW9ucywgZS5nLiBpdCdzIGxvdy1zcGVlZCBkdWUgdG8gbWlzc2luZw0KPiAyRC1hY2NlbGVy
YXRpb24gZm9yIG9sZGVyIGNhcmRzIGFuZCBhbmQgaXQncyBpbmNhcGFiaWxpdHkgdG8gY2hh
bmdlIHNjcmVlbg0KPiByZXNvbHV0aW9uIGF0IHJ1bnRpbWUgKGp1c3QgdG8gbmFtZSB0d28g
b2YgdGhlIGJpZ2dlciBsaW1pdGF0aW9ucyBoZXJlKS4NCg0KWW91IGNhbiBjaGFuZ2UgcmVz
b2x1dGlvbiBhdCBydW50aW1lOyBqdXN0IG5vdCB0aHJvdWdoIGZiZGV2IGlvY3Rscy4gDQpU
aGVyZSdzIG5vIHRlY2huaWNhbCBsaW1pdGF0aW9uIGhlcmUuIE5vIG9uZSBmb3VuZCBhbnkg
dXNlIGZvciB0aGlzLCBzbyANCml0J3Mgbm90IHRoZXJlLg0KDQo+IFNvLCB1bmxlc3Mgd2Ug
c29tZWhvdyBmaW5kIGEgZ29vZCB3YXkgdG8gbW92ZSBzdWNoIGRyaXZlcnMgb3ZlciB0byBE
Uk0NCj4gKHdpdGggYSBzZXQgb2YgbWluaW1hbCAyRCBhY2NlbGVyYXRpb24pLCB0aGV5IGFy
ZSBzdGlsbCBpbXBvcnRhbnQuDQoNCjJkIGFjY2VsZXJhdGlvbiBpcyBtb3N0bHkgdXNlZnVs
IGZvciB0aGUgZnJhbWVidWZmZXIgY29uc29sZS4gWW91IGNhbiBkbyANCnRoYXQgd2l0aCBE
Uk0gYW5kIGRyaXZlcnMgaGF2ZSAobm91dmVhdSkuIEl0IGp1c3QgZGlkbid0IG1ha2UgYSAN
Cm1lYW5pbmdmdWwgZGlmZmVyZW5jZSBpbiBtb3N0IGNhc2VzLg0KDQpCZXN0IHJlZ2FyZHMN
ClRob21hcw0KDQo+IA0KPiBBY3R1YWxseSwgSSBqdXN0IGRpZCB0ZXN0IG1hdHJveGZiIGFu
ZCBwbTJmYiBzdWNjZXNzZnVsbHkgYSBmZXcgZGF5cyANCj4gYmFjaywgYW5kDQo+IHRoZXkg
d29ya2VkLiBGb3Igc29tZSBzbWFsbGVyIGlzc3VlcyBJJ3ZlIHByZXBhcmVkIHBhdGNoZXMs
IHdoaWNoIGFyZSBvbiANCj4gaG9sZA0KPiBkdWUgY29uZmxpY3RzIHdpdGggeW91ciBsYXRl
c3QgZmlsZS1tb3ZlLWFyb3VuZC0gYW5kIHdoaXRlc3BhY2UtY2hhbmdlcyANCj4gd2hpY2gg
YXJlIHBhcnRseQ0KPiBpbiBkcm0tbWlzYy4NCj4gQW5kIEkgZG8gaGF2ZSBzb21lIHVwY29t
aW5nIGFkZGl0aW9uYWwgcGF0Y2hlcyBmb3IgY29uc29sZSBzdXBwb3J0Lg0KPiANCj4gSGVs
Z2UNCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Bl
cg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNz
ZSAxNDYsIDkwNDYxIE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3
IE15ZXJzLCBBbmRyZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChB
RyBOdWVybmJlcmcpDQo=

--------------cF7ELr8NEJdtB0AS8Jfn35yF--

--------------oqkBIdidQhXHM6LZbZ0g22gh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRc+0AFAwAAAAAACgkQlh/E3EQov+Bi
iRAAtaCufj1wKBEDwcVW2hAm0FlOY6eQRBE0+/+DOMroBsoSkru4r/jRnu6tuY1DQCLVsyu1GTvA
MqQhdJdmhe3j7uCgQ3aOA73Df3X5ZUYKYUKvUZPybfuLrKTr5AyVHlmyiAXUeREigTVlCcsLUD5D
RWswEEuCsdCbwzxGOFohrHOTEBjjiv97mYRtjKpOhVXVHv//46FXQY75FBH71ZV4iJnW6iDO12i7
TgRempXREKbpq3fcfdrRZRVjz708GlRppeowU/QAdbwQF3S60msxp1QEX6OmDqNOmGq50Jjb1+x2
xOX1nQjIeSavFxi5ZJtSGCzc9YgexKwXVwIws1itGvZrYG6793n1o3i/9jn4y50Lnk2coTNXrRQV
pNFXbHSS4bA7WuPiSs//FeJPsmHDpywx7rOw3SKjFOikIK7h1JZe+eqdJZSWb5mZjAZ3nPtS1jlb
oubB4STRq9WJ3F4eHAP2l313OMut1Q9eVv4TSn7nhWNJAXvIOmu9QUhJMTd63gyyLy6g21wZXhWl
utoRg/Qdf1loG3hH8/kMh/HHuq/B1p+QyjftTDsgfnQBIbScD9SkV/jKyHh010KXY2sF6BPMV22J
ObeOe9GiboYfQwBNJj2bjAmhmo8nKYMwLGx4rkvGvsxheZBIkgnlVXrTrTg9cJNy6+lsXjJs/9eB
m1k=
=ZGtI
-----END PGP SIGNATURE-----

--------------oqkBIdidQhXHM6LZbZ0g22gh--
