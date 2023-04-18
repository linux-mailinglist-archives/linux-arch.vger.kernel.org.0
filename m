Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E06E5AAA
	for <lists+linux-arch@lfdr.de>; Tue, 18 Apr 2023 09:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjDRHpE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Apr 2023 03:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDRHpD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Apr 2023 03:45:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678AD10D0;
        Tue, 18 Apr 2023 00:45:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1CEA11F8D5;
        Tue, 18 Apr 2023 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681803900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k4kCGiDu7eZCY2kHWyBi9arEU5jU+OwaWl9LlmgBgTo=;
        b=01AbIdbC2ZN0fhxv/iYxLgj8ciDX6tD9uCd3cIhELGAw4YSRK9w6/GGAiuAaLtZg7KlYip
        UPvsdBcpWNtNJ71zbqUvLKTD1lA83nSqPPrphOIt3mJsfodK1zfwzqX4BEKAaXkUnOToit
        aPED/mfiOl6WMMIYqzVnNBr0VoJ5y+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681803900;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k4kCGiDu7eZCY2kHWyBi9arEU5jU+OwaWl9LlmgBgTo=;
        b=Rmm87b7uMzS061Xyb6C7LuYQh7WlZOBtlpx0lMkwJOlh/1UTUlnJfZxcIJZTcTRQYKl8ZJ
        E719xeledovycCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B324C139CC;
        Tue, 18 Apr 2023 07:44:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lXeyKntKPmTxagAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 18 Apr 2023 07:44:59 +0000
Message-ID: <5fa98536-a4b0-7b71-7342-9ba05158062f@suse.de>
Date:   Tue, 18 Apr 2023 09:44:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 00/19] arch: Consolidate <asm/fb.h>
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20230417125651.25126-1-tzimmermann@suse.de>
 <1641007d-7953-426a-a3de-ca9c90f6c5a9@app.fastmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <1641007d-7953-426a-a3de-ca9c90f6c5a9@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rFRj0NtGM3Zijx0xyHfeKvB1"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rFRj0NtGM3Zijx0xyHfeKvB1
Content-Type: multipart/mixed; boundary="------------18o4xqtdrHnA7yRGq0Gjgi9D";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-fbdev@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Message-ID: <5fa98536-a4b0-7b71-7342-9ba05158062f@suse.de>
Subject: Re: [PATCH v3 00/19] arch: Consolidate <asm/fb.h>
References: <20230417125651.25126-1-tzimmermann@suse.de>
 <1641007d-7953-426a-a3de-ca9c90f6c5a9@app.fastmail.com>
In-Reply-To: <1641007d-7953-426a-a3de-ca9c90f6c5a9@app.fastmail.com>

--------------18o4xqtdrHnA7yRGq0Gjgi9D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTcuMDQuMjMgdW0gMTY6MTIgc2NocmllYiBBcm5kIEJlcmdtYW5uOg0KPiBP
biBNb24sIEFwciAxNywgMjAyMywgYXQgMTQ6NTYsIFRob21hcyBaaW1tZXJtYW5uIHdyb3Rl
Og0KPj4gVmFyaW91cyBhcmNoaXRlY3R1cmVzIHByb3ZpZGUgPGFzbS9mYi5oPiB3aXRoIGhl
bHBlcnMgZm9yIGZiZGV2DQo+PiBmcmFtZWJ1ZmZlciBkZXZpY2VzLiBTaGFyZSB0aGUgY29u
dGFpbmVkIGNvZGUgd2hlcmUgcG9zc2libGUuIFRoZXJlDQo+PiBpcyBhbHJlYWR5IDxhc20t
Z2VuZXJpYy9mYi5oPiwgd2hpY2ggaW1wbGVtZW50cyBnZW5lcmljIChhcyBpbg0KPj4gJ2Vt
cHR5JykgZnVuY3Rpb25zIG9mIHRoZSBmYmRldiBoZWxwZXJzLiBUaGUgaGVhZGVyIHdhcyBh
ZGRlZCBpbg0KPj4gY29tbWl0IGFhZmU0ZGJlZDBiZiAoImFzbS1nZW5lcmljOiBhZGQgZ2Vu
ZXJpYyB2ZXJzaW9ucyBvZiBjb21tb24NCj4+IGhlYWRlcnMiKSwgYnV0IG5ldmVyIHVzZWQu
DQo+Pg0KPj4gRWFjaCBwZXItYXJjaGl0ZWN0dXJlIGhlYWRlciBmaWxlIGRlY2xhcmVzIGFu
ZC9vciBpbXBsZW1lbnRzIGZiZGV2DQo+PiBoZWxwZXJzIGFuZCBkZWZpbmVzIGEgcHJlcHJv
Y2Vzc29yIHRva2VuIGZvciBlYWNoLiBUaGUgZ2VuZXJpYw0KPj4gaGVhZGVyIHRoZW4gcHJv
dmlkZXMgdGhlIHJlbWFpbmluZyBoZWxwZXJzLiBJdCB3b3JrcyBsaWtlIHRoZSBJL08NCj4+
IGhlbHBlcnMgaW4gPGFzbS9pby5oPi4NCj4gDQo+IExvb2tzIGFsbCBnb29kIHRvIG1lLA0K
PiANCj4gQWNrZWQtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQoNClRoYW5r
cyBhIGxvdC4gSSBrbm93IHRoYXQgSGVsZ2Ugd2FudHMgdG8gdGVzdCB0aGUgUEFSSVNDIGNo
YW5nZXMsIHNvIA0KSSdsbCBrZWVwIHRoaXMgc2VyaWVzIHBlbmRpbmcgZm9yIGEgYml0IGxv
bmdlci4gSSdkIGxpa2UgdG8gbWVyZ2UgdGhlIA0KcGF0Y2hlcyB0aHJvdWdoIHRoZSBEUk0g
dHJlZSwgaWYgbm8gb25lIG9iamVjdHMuDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4g
DQo+ICAgICAgIEFybmQNCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJp
dmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCihIUkIgMzY4MDksIEFH
IE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90ZXYNCg==

--------------18o4xqtdrHnA7yRGq0Gjgi9D--

--------------rFRj0NtGM3Zijx0xyHfeKvB1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmQ+SnsFAwAAAAAACgkQlh/E3EQov+Dd
XQ//Zqe+Ke6gkghrBiUGQ20ACZc8VRAA3V1KtkJbElUAoQFaUum7w/yrlS81UEEJjoRMuX1FFcG+
Rgbn5SQ/UepB6HwWPDfLlwvC4oUfNthoc8c95PMqnBG4qC6ln8pmzQf0Kh3KqcP7JSLUCZQ5hk0S
UQ5o4XBTJvdwLDkcwaKIk8l4Up8BSKjx4CtpCLiplMu6raS6B2gHyKJ4Z5JRPPQBfR8XmfJKoBGA
cJaPYTFMY4Nds0+lkFOgVFZeXpMuhIEt+jScoLwoDxb/2Ee+uaacWl7kCE2BQ8Hdhtm5Z18SDIUv
oI7I2ASXRLCQbUMl+7R2paUr8KyYfV3f3FOq9KIfU0GiZP07CCLHEkojxcdp001KJV4Y8/u91nqe
XPAjD+qEVK/Dqfe8J1nSZESRHsy3f30yr4kUhVBpZpeqdt205SA3Aa3z8Wa+bbk8vJ+7hqoc1pXp
OAwdl1qf48I5AvxZiDdJ9d3lAJBhzEzStBvilwdb+hloJ1vlt/N7eG9d10qCSvEfHdMOma7ym+da
0cHlXkncuXTzhVUj4UWbF/qWakRRElf7lGym4/Ns7gdxWb5/sHGmamxH8cT7lu16UXcGO6JyKi8J
GT7X/bWqUKOYRFUujmWoafHadee1TGvLnPd3nI9GHLZ9WIH6fz8EopcK3bOx3WIBF3E/KBhrZYHH
Nvk=
=wq7p
-----END PGP SIGNATURE-----

--------------rFRj0NtGM3Zijx0xyHfeKvB1--
