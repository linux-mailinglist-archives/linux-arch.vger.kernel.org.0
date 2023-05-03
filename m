Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DED6F5A71
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 16:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjECOzL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 May 2023 10:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjECOzJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 10:55:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC05420B;
        Wed,  3 May 2023 07:55:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DBC0222929;
        Wed,  3 May 2023 14:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683125706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HhvrVC97XBYmFSXZA3+Mafjkd40eBdeyxxUiArLGfFM=;
        b=pRFgvKCL7PFHtPhgQ9QNUrZk37Bp+UyZOrndeXiL99om1bhlr+MVlhHGkmY7CCAuGq7oTG
        KyYqS4NcIVXLqtpLaPALZhQQlDyYRwzp591EWsG56187vQIvayBTPHRxygG3ybWT6BJdjv
        oSgUS5RP1DLwyMkDmCLJFKj/ffJfXHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683125706;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HhvrVC97XBYmFSXZA3+Mafjkd40eBdeyxxUiArLGfFM=;
        b=8SWl2HwLTNqxEG13HZ5zDyZE9sStVDEaRpczQzdfBAmkT9pzgYsHRx1a4zB9vM9rgEL1N8
        DN00+Jk6pt6xD5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7495B1331F;
        Wed,  3 May 2023 14:55:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b8LcGsp1UmSHUwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 03 May 2023 14:55:06 +0000
Message-ID: <dd921bae-0145-09e2-24b1-f08d89a78eba@suse.de>
Date:   Wed, 3 May 2023 16:55:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 5/6] fbdev: Move framebuffer I/O helpers into
 <asm/fb.h>
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Vineet Gupta <vgupta@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "David S . Miller" <davem@davemloft.net>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-6-tzimmermann@suse.de>
 <67d6a188-041f-4604-99a3-548c41af0693@app.fastmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <67d6a188-041f-4604-99a3-548c41af0693@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UDwmwmIfL482P7WlMrqweUEs"
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UDwmwmIfL482P7WlMrqweUEs
Content-Type: multipart/mixed; boundary="------------WF70DbsrzaM72ML8O0Xlqhcn";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Vineet Gupta <vgupta@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 "David S . Miller" <davem@davemloft.net>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Sam Ravnborg <sam@ravnborg.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org
Message-ID: <dd921bae-0145-09e2-24b1-f08d89a78eba@suse.de>
Subject: Re: [PATCH v3 5/6] fbdev: Move framebuffer I/O helpers into
 <asm/fb.h>
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-6-tzimmermann@suse.de>
 <67d6a188-041f-4604-99a3-548c41af0693@app.fastmail.com>
In-Reply-To: <67d6a188-041f-4604-99a3-548c41af0693@app.fastmail.com>

--------------WF70DbsrzaM72ML8O0Xlqhcn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDIuMDUuMjMgdW0gMjI6MDYgc2NocmllYiBBcm5kIEJlcmdtYW5uOg0KPiBP
biBUdWUsIE1heSAyLCAyMDIzLCBhdCAxNTowMiwgVGhvbWFzIFppbW1lcm1hbm4gd3JvdGU6
DQo+PiBJbXBsZW1lbnQgZnJhbWVidWZmZXIgSS9PIGhlbHBlcnMsIHN1Y2ggYXMgZmJfcmVh
ZCooKSBhbmQgZmJfd3JpdGUqKCksDQo+PiBpbiB0aGUgYXJjaGl0ZWN0dXJlJ3MgPGFzbS9m
Yi5oPiBoZWFkZXIgZmlsZSBvciB0aGUgZ2VuZXJpYyBvbmUuDQo+Pg0KPj4gVGhlIGNvbW1v
biBjYXNlIGhhcyBiZWVuIHRoZSB1c2Ugb2YgcmVndWxhciBJL08gZnVuY3Rpb25zLCBzdWNo
IGFzDQo+PiBfX3Jhd19yZWFkYigpIG9yIG1lbXNldF9pbygpLiBBIGZldyBhcmNoaXRlY3R1
cmVzIHVzZWQgcGxhaW4gc3lzdGVtLQ0KPj4gbWVtb3J5IHJlYWRzIGFuZCB3cml0ZXMuIFNw
YXJjIHVzZWQgaGVscGVycyBmb3IgaXRzIFNCdXMuDQo+Pg0KPj4gVGhlIGFyY2hpdGVjdHVy
ZXMgdGhhdCB1c2VkIHNwZWNpYWwgY2FzZXMgcHJvdmlkZSB0aGUgc2FtZSBjb2RlIGluDQo+
PiB0aGVpciBfX3Jhd18qKCkgSS9PIGhlbHBlcnMuIFNvIHRoZSBwYXRjaCByZXBsYWNlcyB0
aGlzIGNvZGUgd2l0aCB0aGUNCj4+IF9fcmF3XyooKSBmdW5jdGlvbnMgYW5kIG1vdmVzIGl0
IHRvIDxhc20tZ2VuZXJpYy9mYi5oPiBmb3IgYWxsDQo+PiBhcmNoaXRlY3R1cmVzLg0KPj4N
Cj4+IHYzOg0KPj4gCSogaW1wbGVtZW50IGFsbCBhcmNoaXRlY3R1cmVzIHdpdGggZ2VuZXJp
YyBoZWxwZXJzDQo+PiAJKiBzdXBwb3J0IHJlb3JkZXJpbmcgYW5kIG5hdGl2ZSBieXRlIG9y
ZGVyIChHZWVydCwgQXJuZCkNCj4gDQo+IFRoaXMgbG9va3MgZ29vZCBmb3IgdGhlIHJlYWQv
d3JpdGUgaGVscGVycywgYnV0IEknbSBhIGxpdHRsZQ0KPiB3b3JyaWVkIGFib3V0IHRoZSBt
ZW1zZXQgYW5kIG1lbWNweSBmdW5jdGlvbnMsIHNpbmNlIHRoZXkgZG8NCj4gY2hhbmdlIGJl
aGF2aW9yIG9uIHNvbWUgYXJjaGl0ZWN0dXJlczoNCj4gDQo+IC0gb24gc3BhcmM2NCwgZmJf
bWVte3NldCxjcHl9IHVzZXMgQVNJX1BIWVNfQllQQVNTX0VDX0UgKGxpa2UgX19yYXdfcmVh
ZGIpDQo+ICAgIHdoaWxlIG1lbXtzZXRfLGNweV9mcm9tLGNweV90b30gdXNlcyBBU0lfUEhZ
U19CWVBBU1NfRUNfRV9MIChsaWtlIHJlYWRiKQ0KPiAgICBJIGRvbid0IGtub3cgdGhlIGVm
ZmVjdCBvZiB0aGF0LCBidXQgaXQgc2VlbXMgaW50ZW50aW9uYWwNCj4gDQo+IC0gb24gbG9v
bmdhcmNoIGFuZCBjc2t5LCB0aGUgX2lvIHZhcmlhbnRzIGF2b2lkIHVuYWxpZ25lZCBhY2Nl
c3MsDQo+ICAgIHdoaWxlIHRoZSBub3JtYWwgbWVtY3B5L21lbXNldCBpcyBwcm9iYWJseSBi
cm9rZW4sIHNvIHlvdXINCj4gICAgcGF0Y2ggaXMgYSBidWdmaXgNCj4gDQo+IC0gb24gaWE2
NCwgdGhlIF9pbyB2YXJpYW50cyB1c2UgYnl0ZXdpc2UgYWNjZXNzIGFuZCBhdm9pZCBhbnkg
bG9uZ2VyDQo+ICAgIGxvYWRzIGFuZCBzdG9yZXMsIHNvIHlvdXIgcGF0Y2ggcHJvYmFibHkg
bWFrZXMgdGhpbmdzIHNsb3dlci4NCj4gDQo+IEl0J3MgcHJvYmFibHkgc2FmZSB0byBkZWFs
IHdpdGggYWxsIHRoZSBhYm92ZSBieSBlaXRoZXIgYWRkaW5nDQo+IGFyY2hpdGVjdHVyZSBz
cGVjaWZpYyBvdmVycmlkZXMgdG8gdGhlIGN1cnJlbnQgdmVyc2lvbiwgb3INCj4gYnkgZG9p
bmcgdGhlIHNlbWFudGljIGNoYW5nZXMgYmVmb3JlIHRoZSBtb3ZlIHRvIGFzbS9mYi5oLCBi
dXQNCj4gb25lIHdheSBvciB0aGUgb3RoZXIgSSdkIHByZWZlciB0aGlzIHRvIGJlIHNlcGFy
YXRlIGZyb20gdGhlDQo+IGNvbnNvbGlkYXRpb24gcGF0Y2ggdGhhdCBzaG91bGQgbm90IGhh
dmUgYW55IGNoYW5nZXMgaW4gYmVoYXZpb3IuDQoNCkkgdGhpbmsgSSdsbCBhZGQgYXJjaGl0
ZWN0dXJlIG92ZXJyaWRlcyB0aGF0IGNvbnRhaW4gdGhlIGN1cnJlbnQgY29kZSwgDQpldmVu
IGlmIHRoZXkgY29udGFpbiBzb21lIGZvcmNlLWNhc3Rpbmcgd3J0IF9faW9tZW0uIElmIGFu
eW9uZSB3YW50cyB0byANCmZpeCB0aGUgaXNzdWVzLCB0aGV5IGNhbiB0aGVuIGFkZHJlc3Mg
dGhlbSBlYXNpbHkuDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gDQo+ICAgICAgIEFy
bmQNCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Bl
cg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNz
ZSAxNDYsIDkwNDYxIE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3
IE15ZXJzLCBBbmRyZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChB
RyBOdWVybmJlcmcpDQo=

--------------WF70DbsrzaM72ML8O0Xlqhcn--

--------------UDwmwmIfL482P7WlMrqweUEs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRSdcoFAwAAAAAACgkQlh/E3EQov+Cj
zg/9HFoysElKHNgvZ1o3nHmqKL2VPV2VUUDyIhkVoSgQOj/I9DBMYb1J8nrkwkB5rOWOm1TrLl82
RFsBF6W152p9NqSrOxHrGS2K6+8U6cC3foWbdtuhxOz+KseTK997YLSF/+t2KoMi+u9GHVSImntd
lYAbjFF9P8bbF6caCwfNtMolODw1qhMrcIFN3w3o+y4LhMIK6qF87PlsosJHvVl9VqQaMSzmNQkW
CH2Xc0s0rRaPU5acg8IjYM0IqCuiAWcK/V+Q2UvM2UAXLtdWGeUYcTABN4YMLUrHp/9yj2ojgCXe
BQK/gZ6xCYurVyDtHW3snwcZztsycF8egMnp3SKeQLKm98fx6+xMVamjdnJL9OFN0RF4uraKL7/2
86YhpfnjWeDDQHE01wWG5INLJhCteNbHJHtiqM6/K+m5jhkNhwcOo9n+1IdF73HCAnwarzDTutsU
DoEItP7vwqQwW1JFIm8U8gNTkkL/jqAlkbdqjfT8cj7O+sBW7yRB7jMdhQScNccg/1aBcSWQ+zDF
JfKZO8Ms651aEP6ZWJXLCNlOVxmP5desgjax2qx75v5QSdzzeQRgKoDfqCvy9oTwEqTMzK79c5gP
E2vhUaybCer9Q3ZkGoaWwt8HBEFCTkyh46TcbO1YiX6lq2rjgADep+w+1DxULkdBs8ZX0F9NFmGg
6Nk=
=cYZ4
-----END PGP SIGNATURE-----

--------------UDwmwmIfL482P7WlMrqweUEs--
