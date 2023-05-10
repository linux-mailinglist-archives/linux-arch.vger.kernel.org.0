Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057C56FE145
	for <lists+linux-arch@lfdr.de>; Wed, 10 May 2023 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbjEJPLb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 May 2023 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbjEJPLa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 May 2023 11:11:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3E51FC2;
        Wed, 10 May 2023 08:11:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 510F0219B6;
        Wed, 10 May 2023 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683731488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7GsHyu8BvvIG88YAPiapZikCJddAHgbSm3iY5gZ+5dk=;
        b=V8nPnqE0W5b4eUiWzQWhjNJ+C5HSzklnAHRgDHMEMT2D/nAtfFUt4PJtvGYHXoqJAhHmjS
        f1Q/NSs731ZytgowSNTQojiyMv04CSHs5HN8CYKNKIDoE3H5mqDxaOk5gf0Cha/n23+cWg
        645svPiTSTK5o8Bpf0PfPqg3IxhsMWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683731488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7GsHyu8BvvIG88YAPiapZikCJddAHgbSm3iY5gZ+5dk=;
        b=ldSZ6sCgE7NATIvrxbps1bEgqObcnKzzD1pe2ZDCOsPoPZYQGRxO3Wg2orrUIG0RK882lm
        TyzJ1u0RNETmF8CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D359213519;
        Wed, 10 May 2023 15:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FLw9Mh+0W2TxSAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 10 May 2023 15:11:27 +0000
Message-ID: <238513df-4a39-75d4-9012-20d7d8526706@suse.de>
Date:   Wed, 10 May 2023 17:11:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 5/6] fbdev: Move framebuffer I/O helpers into
 <asm/fb.h>
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     deller@gmx.de, javierm@redhat.com, daniel@ffwll.ch,
        vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        davem@davemloft.net, James.Bottomley@hansenpartnership.com,
        arnd@arndb.de, sam@ravnborg.org, suijingfeng@loongson.cn,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
References: <20230510110557.14343-1-tzimmermann@suse.de>
 <20230510110557.14343-6-tzimmermann@suse.de>
 <CAMuHMdVV-MQV3C_o6JxPj23h3zo0kMmsn9ZEWJxsrzr6YpKmyg@mail.gmail.com>
 <487ff03b-d753-972f-7a06-a1d5efda917d@suse.de>
 <CAMuHMdWQLF6QZi4j5Yg3oiy8dMbuApk+r=5c2tSLvYxvAaudMA@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAMuHMdWQLF6QZi4j5Yg3oiy8dMbuApk+r=5c2tSLvYxvAaudMA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bePUrlBG7J50eUzAHryxDe2t"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bePUrlBG7J50eUzAHryxDe2t
Content-Type: multipart/mixed; boundary="------------nmuFXWNHp9OPw0gTQ9dL40wM";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: deller@gmx.de, javierm@redhat.com, daniel@ffwll.ch, vgupta@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, davem@davemloft.net,
 James.Bottomley@hansenpartnership.com, arnd@arndb.de, sam@ravnborg.org,
 suijingfeng@loongson.cn, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Message-ID: <238513df-4a39-75d4-9012-20d7d8526706@suse.de>
Subject: Re: [PATCH v6 5/6] fbdev: Move framebuffer I/O helpers into
 <asm/fb.h>
References: <20230510110557.14343-1-tzimmermann@suse.de>
 <20230510110557.14343-6-tzimmermann@suse.de>
 <CAMuHMdVV-MQV3C_o6JxPj23h3zo0kMmsn9ZEWJxsrzr6YpKmyg@mail.gmail.com>
 <487ff03b-d753-972f-7a06-a1d5efda917d@suse.de>
 <CAMuHMdWQLF6QZi4j5Yg3oiy8dMbuApk+r=5c2tSLvYxvAaudMA@mail.gmail.com>
In-Reply-To: <CAMuHMdWQLF6QZi4j5Yg3oiy8dMbuApk+r=5c2tSLvYxvAaudMA@mail.gmail.com>

--------------nmuFXWNHp9OPw0gTQ9dL40wM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgR2VlcnQNCg0KQW0gMTAuMDUuMjMgdW0gMTY6MzQgc2NocmllYiBHZWVydCBVeXR0ZXJo
b2V2ZW46DQo+IEhpIFRob21hcywNCj4gDQo+IE9uIFdlZCwgTWF5IDEwLCAyMDIzIGF0IDQ6
MjDigK9QTSBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4gd3JvdGU6
DQo+PiBBbSAxMC4wNS4yMyB1bSAxNDozNCBzY2hyaWViIEdlZXJ0IFV5dHRlcmhvZXZlbjoN
Cj4+PiBPbiBXZWQsIE1heSAxMCwgMjAyMyBhdCAxOjA24oCvUE0gVGhvbWFzIFppbW1lcm1h
bm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+IHdyb3RlOg0KPj4+PiBJbXBsZW1lbnQgZnJhbWVi
dWZmZXIgSS9PIGhlbHBlcnMsIHN1Y2ggYXMgZmJfcmVhZCooKSBhbmQgZmJfd3JpdGUqKCks
DQo+Pj4+IGluIHRoZSBhcmNoaXRlY3R1cmUncyA8YXNtL2ZiLmg+IGhlYWRlciBmaWxlIG9y
IHRoZSBnZW5lcmljIG9uZS4NCj4+Pj4NCj4+Pj4gVGhlIGNvbW1vbiBjYXNlIGhhcyBiZWVu
IHRoZSB1c2Ugb2YgcmVndWxhciBJL08gZnVuY3Rpb25zLCBzdWNoIGFzDQo+Pj4+IF9fcmF3
X3JlYWRiKCkgb3IgbWVtc2V0X2lvKCkuIEEgZmV3IGFyY2hpdGVjdHVyZXMgdXNlZCBwbGFp
biBzeXN0ZW0tDQo+Pj4+IG1lbW9yeSByZWFkcyBhbmQgd3JpdGVzLiBTcGFyYyB1c2VkIGhl
bHBlcnMgZm9yIGl0cyBTQnVzLg0KPj4+Pg0KPj4+PiBUaGUgYXJjaGl0ZWN0dXJlcyB0aGF0
IHVzZWQgc3BlY2lhbCBjYXNlcyBwcm92aWRlIHRoZSBzYW1lIGNvZGUgaW4NCj4+Pj4gdGhl
aXIgX19yYXdfKigpIEkvTyBoZWxwZXJzLiBTbyB0aGUgcGF0Y2ggcmVwbGFjZXMgdGhpcyBj
b2RlIHdpdGggdGhlDQo+Pj4+IF9fcmF3XyooKSBmdW5jdGlvbnMgYW5kIG1vdmVzIGl0IHRv
IDxhc20tZ2VuZXJpYy9mYi5oPiBmb3IgYWxsDQo+Pj4+IGFyY2hpdGVjdHVyZXMuDQo+Pj4+
DQo+Pj4+IHY2Og0KPj4+PiAgICAgICAgICAgKiBmaXggZmJfcmVhZHEoKS9mYl93cml0ZXEo
KSBvbiA2NC1iaXQgbWlwcyAoa2VybmVsIHRlc3Qgcm9ib3QpDQo+Pj4+IHY1Og0KPj4+PiAg
ICAgICAgICAgKiBpbmNsdWRlIDxsaW51eC9pby5oPiBpbiA8YXNtLWdlbmVyaWMvZmI+OyBm
aXggczM5MCBidWlsZA0KPj4+PiB2NDoNCj4+Pj4gICAgICAgICAgICogaWE2NCwgbG9vbmdh
cmNoLCBzcGFyYzY0OiBhZGQgZmJfbWVtKigpIHRvIGFyY2ggaGVhZGVycw0KPj4+PiAgICAg
ICAgICAgICB0byBrZWVwIGN1cnJlbnQgc2VtYW50aWNzIChBcm5kKQ0KPj4+PiB2MzoNCj4+
Pj4gICAgICAgICAgICogaW1wbGVtZW50IGFsbCBhcmNoaXRlY3R1cmVzIHdpdGggZ2VuZXJp
YyBoZWxwZXJzDQo+Pj4+ICAgICAgICAgICAqIHN1cHBvcnQgcmVvcmRlcmluZyBhbmQgbmF0
aXZlIGJ5dGUgb3JkZXIgKEdlZXJ0LCBBcm5kKQ0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4+Pj4gVGVzdGVk
LWJ5OiBTdWkgSmluZ2ZlbmcgPHN1aWppbmdmZW5nQGxvb25nc29uLmNuPg0KPj4+PiBSZXZp
ZXdlZC1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+Pj4+IC0tLSBh
L2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9mYi5oDQo+Pj4+ICsrKyBiL2FyY2gvbWlwcy9pbmNs
dWRlL2FzbS9mYi5oDQo+Pj4+IEBAIC0xMiw2ICsxMiwyOCBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgZmJfcGdwcm90ZWN0KHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKnZtYSwNCj4+Pj4gICAgfQ0KPj4+PiAgICAjZGVmaW5lIGZiX3BncHJvdGVjdCBmYl9w
Z3Byb3RlY3QNCj4+Pj4NCj4+Pj4gKy8qDQo+Pj4+ICsgKiBNSVBTIGRvZXNuJ3QgZGVmaW5l
IF9fcmF3XyBJL08gbWFjcm9zLCBzbyB0aGUgaGVscGVycw0KPj4+PiArICogaW4gPGFzbS1n
ZW5lcmljL2ZiLmg+IGRvbid0IGdlbmVyYXRlIGZiX3JlYWRxKCkgYW5kDQo+Pj4+ICsgKiBm
Yl93cml0ZSgpLiBXZSBoYXZlIHRvIHByb3ZpZGUgdGhlbSBoZXJlLg0KPj4+DQo+Pj4gTUlQ
UyBkb2VzIG5vdCBpbmNsdWRlIDxhc20tZ2VuZXJpYy9pby5oPiwgIG5vciBkZWZpbmUgaXRz
IG93bg0KPj4NCj4+IEkga25vdywgdGhhdCdzIHdoeSB0aGUgVE9ETyBzYXlzIHRvIGNvbnZl
cnQgaXQgdG8gZ2VuZXJpYyBJL08uDQo+Pg0KPj4+IF9fcmF3X3JlYWRxKCkgYW5kIF9fcmF3
X3dyaXRlcSgpLi4uDQo+Pg0KPj4gSXQgZG9lc24ndCBkZWZpbmUgdGhvc2UgbWFjcm9zLCBi
dXQgaXQgZ2VuZXJhdGVzIGZ1bmN0aW9uIGNhbGxzIG9mIHRoZQ0KPj4gc2FtZSBuYW1lcy4g
Rm9sbG93IHRoZSBtYWNyb3MgYXQNCj4+DQo+Pg0KPj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxp
bi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9hcmNoL21pcHMvaW5jbHVkZS9hc20vaW8uaCNM
MzU3DQo+Pg0KPj4gSXQgZXhwYW5kcyB0byBhIHZhcmlldHkgb2YgaGVscGVycywgaW5jbHVk
aW5nIF9fcmF3XyooKS4NCj4gDQo+IFRoYW5rcywgSSBmb3Jnb3QgTUlQUyBpcyB1c2luZyB0
aGVzZSBncmVwLXVuZnJpZW5kbHkgZmFjdG9yaWVzLi4uDQo+IA0KPj4+PiArICoNCj4+Pj4g
KyAqIFRPRE86IENvbnZlcnQgTUlQUyB0byBnZW5lcmljIEkvTy4gVGhlIGhlbHBlcnMgYmVs
b3cgY2FuDQo+Pj4+ICsgKiAgICAgICB0aGVuIGJlIHJlbW92ZWQuDQo+Pj4+ICsgKi8NCj4+
Pj4gKyNpZmRlZiBDT05GSUdfNjRCSVQNCj4+Pj4gK3N0YXRpYyBpbmxpbmUgdTY0IGZiX3Jl
YWRxKGNvbnN0IHZvbGF0aWxlIHZvaWQgX19pb21lbSAqYWRkcikNCj4+Pj4gK3sNCj4+Pj4g
KyAgICAgICByZXR1cm4gX19yYXdfcmVhZHEoYWRkcik7DQo+Pj4NCj4+PiAuLi4gc28gaG93
IGNhbiB0aGlzIGNhbGwgd29yaz8NCj4+DQo+PiBPbiA2NC1iaXQgYnVpbGRzLCB0aGVyZSdz
IF9fcmF3X3JlYWRxKCkgYW5kIF9fcmF3X3dyaXRlcSgpLg0KPj4NCj4+IEF0IGZpcnN0LCBJ
IHRyaWVkIHRvIGRvIHRoZSByaWdodCB0aGluZyBhbmQgY29udmVydCBNSVBTIHRvIHdvcmsg
d2l0aA0KPj4gPGFzbS1nZW5lcmljL2lvLmg+LiBCdXQgdGhhdCBjcmVhdGVkIGEgdG9uIG9m
IGZvbGxvdy11cCBlcnJvcnMgaW4gb3RoZXINCj4+IGhlYWRlcnMuIFNvIGZvciBub3csIGl0
J3MgYmV0dGVyIHRvIGhhbmRsZSB0aGlzIHByb2JsZW0gaW4gYXNtL2ZiLmguDQo+IA0KPiBT
byBpc24ndCBqdXN0IGFkZGluZw0KPiANCj4gICAgICAjZGVmaW5lIF9fcmF3X3JlYWRxIF9f
cmF3X3JlYWRxDQo+ICAgICAgI2RlZmluZSBfX3Jhd193cml0ZXEgX19yYXdfd3JpdGVxDQo+
IA0KPiB0byBhcmNoL21pcHMvaW5jbHVkZS9hc20vaW8uaCBzdWZmaWNpZW50IHRvIG1ha2Ug
PGFzbS1nZW5lcmljL2ZiLmg+DQo+IGRvIHRoZSByaWdodCB0aGluZz8NCg0KVGhhdCB3b3Jr
cy4gSSBoYWQgYSBwYXRjaCB0aGF0IGFkZHMgYWxsIG1pc3NpbmcgZGVmaW5lcyB0byBNSVBT
JyBpby5oLiANClRoZW4gSSB3ZW50IHdpdGggdGhlIGN1cnJlbnQgZml4LCB3aGljaCBpcyBz
ZWxmLWNvbnRhaW5lZCB3aXRoaW4gZmJkZXYuIA0KQnV0IEknZCBsZWF2ZSBpdCB0byBhcmNo
IG1haW50YWluZXJzLg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQoNCj4gDQo+IEdye29l
dGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+
IA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVy
DQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5rZW5zdHJhc3Nl
IDE0NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpHRjogSXZvIFRvdGV2LCBBbmRyZXcg
TXllcnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBNb2VybWFuDQpIUkIgMzY4MDkgKEFH
IE51ZXJuYmVyZykNCg==

--------------nmuFXWNHp9OPw0gTQ9dL40wM--

--------------bePUrlBG7J50eUzAHryxDe2t
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRbtB8FAwAAAAAACgkQlh/E3EQov+DI
OQ/7Bh2dGdIpUoZFmIzv8q/RW/ZRQu70vozaAGSwIj4W59gjrfbWhlRscy2ihp/+9MgdjDPByjMC
huW3PLu6r/dG820Z19YD7yaqfiZiXykzvUGNKaJMwUvZnHSPR2EOW5guvhK+wQaSRnAiuGUUly8C
Qc46ymt6o6SbZX4uFY9+ye3FY/ilEXY4ydngwypgcjsepbop9MVvMv1uyvn055gvbT37j2Cjwa2P
qDSZbiZEmweX4/rtaF2bYOj64NfVIBAvi1I63kTYPuafn/0meleXyGC1iVjk3cYoDBG9gQ5TMJiV
PUMNC20LIju+wZphH8Irh1yuqwsa797sIfiTz4cw0fXWzgEqvBTUC2reBS1aGEyj4sW2M+qyZGdG
+efx+P1jAs2j/sm+3fvWXjIqZmxFXAPx3asI/zFJ5GUldFSTFVmcck/+sRN1MDTpOFWu3n3x0fw3
SlIZP/R0mWQb5IRzn0eGeVs68mfhW2tb9IlRUmP1lZ97bn4faMPzGCHVsb3CLiURBjv9xU1khgtg
MMlQS5yqmT+cM9Cf6frXdBMFTAmd5TyKiUaXdsz8yJAAj7Q0tdEu0gFubYY1CKRwtswzxjLJC66W
cNc40si5mk77HnbK6MLfcTF/ZPG6EtbGNAZCODLobe3ivg+xFN3W+wKOxZwXM07dOkIus9vPbvx5
LQQ=
=sdVp
-----END PGP SIGNATURE-----

--------------bePUrlBG7J50eUzAHryxDe2t--
