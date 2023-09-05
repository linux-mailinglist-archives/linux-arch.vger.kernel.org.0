Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A547926EE
	for <lists+linux-arch@lfdr.de>; Tue,  5 Sep 2023 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344083AbjIEQU7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Sep 2023 12:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354574AbjIEMoO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Sep 2023 08:44:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FE01AD;
        Tue,  5 Sep 2023 05:44:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D1BC51FDB0;
        Tue,  5 Sep 2023 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693917849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FkN9fHLyAfRcHsilGUbRusJjN/has0O6CzUMKzXJasI=;
        b=keVYfmc48mpS4Nt09vnh12VZJSCRjao6bLq8+mD13pxU9x71zSHfdmFp8Kfx0sIOXsaSP1
        QLaKzvB23hHyKAMtuhTve0e7QYNrA8bdsPZW4JDoFRxpWeBAZBhQKf86/lYvhAs1FAC7Sa
        J4Fk+xaeTOI5b+kunmcl9yd9y6d2wU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693917849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FkN9fHLyAfRcHsilGUbRusJjN/has0O6CzUMKzXJasI=;
        b=vIhIJzxZZmb5DcNB3OjOlwl7lrOhkEIHzE4KHaujlzT60ABsQijnddOVu6k4DIbcF4Ojdb
        PcktSvBRfw9cC5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C3ED13911;
        Tue,  5 Sep 2023 12:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9K0AHZki92SuHQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 05 Sep 2023 12:44:09 +0000
Message-ID: <5265f1eb-e1a6-c91e-9bc2-75089d594a0e@suse.de>
Date:   Tue, 5 Sep 2023 14:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/4] ppc, fbdev: Clean up fbdev mmap helper
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, arnd@arndb.de, deller@gmx.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org
References: <20230901142659.31787-1-tzimmermann@suse.de>
 <874jk9ibf7.fsf@mail.lhotse>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <874jk9ibf7.fsf@mail.lhotse>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8cnkOZ3clMojcrflCUVqPiyi"
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8cnkOZ3clMojcrflCUVqPiyi
Content-Type: multipart/mixed; boundary="------------vggYL9Fu9Mr0081TqvPYGkw1";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, arnd@arndb.de, deller@gmx.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org
Message-ID: <5265f1eb-e1a6-c91e-9bc2-75089d594a0e@suse.de>
Subject: Re: [PATCH 0/4] ppc, fbdev: Clean up fbdev mmap helper
References: <20230901142659.31787-1-tzimmermann@suse.de>
 <874jk9ibf7.fsf@mail.lhotse>
In-Reply-To: <874jk9ibf7.fsf@mail.lhotse>

--------------vggYL9Fu9Mr0081TqvPYGkw1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDUuMDkuMjMgdW0gMDQ6NDcgc2NocmllYiBNaWNoYWVsIEVsbGVybWFuOg0K
PiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4gd3JpdGVzOg0KPj4g
UmVmYWN0b3IgZmJfcGdwcm90ZWN0KCkgaW4gUG93ZXJQQyB0byB3b3JrIHdpdGhvdXQgc3Ry
dWN0IGZpbGUuIFRoZW4NCj4+IGNsZWFuIHVwIGFuZCByZW5hbWUgZmJfcGdwcm90ZWN0KCku
IFRoaXMgY2hhbmdlIGhhcyBiZWVuIGRpc2N1c3NlZCBhdA0KPj4gWzFdIGluIHRoZSBjb250
ZXh0IG9mIHJlZmFjdG9yaW5nIGZiZGV2J3MgbW1hcCBjb2RlLg0KPj4NCj4+IFRoZSBmaXJz
dCB0aHJlZSBwYXRjaGVzIGFkYXB0IFBvd2VyUEMncyBpbnRlcm5hbCBpbnRlcmZhY2VzIHRv
DQo+PiBwcm92aWRlIGEgcGh5c19tZW1fYWNjZXNzX3Byb3QoKSB0aGF0IHdvcmtzIHdpdGhv
dXQgc3RydWN0IGZpbGUuIE5laXRoZXINCj4+IHRoZSBhcmNoaXRlY3R1cmUgY29kZSBvciBm
YmRldiBoZWxwZXJzIG5lZWQgdGhlIHBhcmFtZXRlci4NCj4+DQo+PiBQYXRjaCA0IHJlcGxh
Y2VzIGZiZGV2J3MgZmJfcGdwcm90ZWN0KCkgd2l0aCBmYl9wZ3Byb3RfZGV2aWNlKCkgb24N
Cj4+IGFsbCBhcmNoaXRlY3R1cmVzLiBUaGUgbmV3IGhlbHBlciB3aXRoIGl0cyBzdHJlYW0t
bGluZWQgaW50ZXJmYWNlDQo+PiBlbmFibGVzIG1vcmUgcmVmYWN0b3Jpbmcgd2l0aGluIGZi
ZGV2J3MgbW1hcCBpbXBsZW1lbnRhdGlvbi4NCj4gDQo+IFRoZSBjb250ZW50IG9mIHRoaXMg
c2VyaWVzIGlzIE9LLCBidXQgdGhlIHdheSBpdCdzIHN0cnVjdHVyZWQgbWFrZXMgaXQgYQ0K
PiByZWFsIGhlYWRhY2hlIHRvIG1lcmdlLCBiZWNhdXNlIGl0J3MgbW9zdGx5IHBvd2VycGMg
Y2hhbmdlcyBhbmQgdGhlbiBhDQo+IGRlcGVuZGFudCBjcm9zcyBhcmNoaXRlY3R1cmUgcGF0
Y2ggYXQgdGhlIGVuZC4NCj4gDQo+IEl0IHdvdWxkIGJlIHNpbXBsZXIgaWYgcGF0Y2ggNCB3
YXMgZmlyc3QgYW5kIGp1c3QgcGFzc2VkIGZpbGU9TlVMTCB0bw0KPiB0aGUgcG93ZXJwYyBo
ZWxwZXIsIHdpdGggYW4gZXhwbGFuYXRpb24gdGhhdCBpdCdzIHVudXNlZCBhbmQgd2lsbCBi
ZQ0KPiBkcm9wcGVkIGluIGEgZnV0dXJlIGNsZWFudXAuDQo+IA0KPiBXZSBjb3VsZCB0aGVu
IHB1dCB0aGUgZmlyc3QgcGF0Y2ggKHByZXZpb3VzbHkgcGF0Y2ggNCkgaW4gYSB0b3BpYyBi
cmFuY2gNCj4gdGhhdCBpcyBzaGFyZWQgYmV0d2VlbiB0aGUgcG93ZXJwYyB0cmVlIGFuZCB0
aGUgZmJkZXYgdHJlZSwgYW5kIHRoZW4gdGhlDQo+IHBvd2VycGMgY2hhbmdlcyBjb3VsZCBi
ZSBzdGFnZWQgb24gdG9wIG9mIHRoYXQgdGhyb3VnaCB0aGUgcG93ZXJwYyB0cmVlLg0KDQpP
aywgdGhhbmtzIGZvciByZXZpZXdpbmcuIFRoZSBmYmRldiBwYXRjaCB3b3VsZCBnbyB0aHJv
dWdoIHRoZSBkcm0tbWlzYyANCnRyZWUgYXMgYmFzZSBmb3IgZnVydGhlciByZWZhY3Rvcmlu
Zy4NCg0KSSdsbCB1cGRhdGUgdGhlIHBhdGNoc2V0IGFjY29yZGluZ2x5Lg0KDQpCZXN0IHJl
Z2FyZHMNClRob21hcw0KDQo+IA0KPiBjaGVlcnMNCg0KLS0gDQpUaG9tYXMgWmltbWVybWFu
bg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMg
R2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkwNDYxIE51ZXJuYmVyZywgR2Vy
bWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3IE15ZXJzLCBBbmRyZXcgTWNEb25hbGQsIEJv
dWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChBRyBOdWVybmJlcmcpDQo=

--------------vggYL9Fu9Mr0081TqvPYGkw1--

--------------8cnkOZ3clMojcrflCUVqPiyi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmT3IpgFAwAAAAAACgkQlh/E3EQov+Ar
2BAAx4GyhqkGBaJfv3puNbbvuB7PEZosJZ/vqe3G59Ue+8wRBHUTSKhDolnDRYRTbKQgZ1SQOrZG
s6+W76rPXD1Ut4CVvr8k7nTHykj6zZleDub7NrWbfct6eQCj162khf2dJa4gR75GQ2xD+SDj3i4W
1LGY55I1ufx+7SulJur+5EUbmRBHxru6iU5MYxADPt5aUUbwMNWCr6sobziieqr0IP/20SfispBk
dUdtMdCkU3Lw2ZK2n9UVUVxmO7XSgRU2UFJEGr3/0BIMhnHMuxkiXPYn/JJlddIgbC24PsKp/gAW
mcWBqdQnCLya6eb0TYII9VyeJGHISNWx01SprtAnuvp7yuKOwizJEVWC6XclHcSA89RgaRCm0Yx5
+WPhWrlzgI1Bw9ZwpEP/xRtDXUTFRYBipih65g7Aijb3FiSg3kNTAbE6A4m5agaj28L1ctOaUpz4
ntRjkcG3o7CyqSKp6sZh6+pvzf7HR1sdFiQuDgG8ySlNND/EJVdu4QS/17JYC0Eo8rdtduUTDhqv
13/YT17csTxF5EGvFMKS+FXFDansioQxoUsA+Dr+nhakhID6DXmmICnbQSa2f+/4rG1MKN2qxzKe
3dNq15p4ARLrfNQ6GJsXLOTw+OtJHK4TPzPcP3NaK9UK+HQC3YGExb3Fge10A1SQK1ZJAwfpWaae
D/g=
=iHVQ
-----END PGP SIGNATURE-----

--------------8cnkOZ3clMojcrflCUVqPiyi--
