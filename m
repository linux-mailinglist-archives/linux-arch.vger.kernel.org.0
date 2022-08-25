Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0CD5A0AAD
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 09:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiHYHsj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 03:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiHYHsi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 03:48:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8289EA00DA;
        Thu, 25 Aug 2022 00:48:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d5so9847259wms.5;
        Thu, 25 Aug 2022 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=wFHKNvRv5PBwAwuMo1YPzYcvo3soaxcTbTqwj/BjF6Q=;
        b=eNjRiFq4Xilg9VUGwqlaKUu2Gpqet0HoEaDzseTRKUMidMt19pUlMtFV+OjzZWRx3k
         h5295WZUln5RYUMpPhIFhLu/eqgCM25de6u/4XR4KtEVjABkT3DiCurxseYtvXOAXTZ7
         CCDoZP/Ecb/hV0xjVx1CYK5cxa33ntzI4qjHgiM/m/lf/XhyweLIyGisgXTCfc+7b6mh
         QRZg8vazwDBxbbj/t6O1ecEkW/1+qhSCP7s/+hJOrh/WodYaixnxPfpD1wA1OoshUeeP
         YDfv2VH6jsjWmL36LfhUX//0KhBcQCqCsLIwQfu/nkXKeP9v8yMz3Ad4XLXoqVIv4fpK
         JYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=wFHKNvRv5PBwAwuMo1YPzYcvo3soaxcTbTqwj/BjF6Q=;
        b=m0pGgDz4raHO0uci34TFoOcXactCpld9o0SSRw1D0AdFyiCFRDXEgGLQLev1QKyuMG
         322XNcTtGxzsz7YL6tPSiDeQekonn9SMTdKWl7zd9k8rV/8NEWRDTQFx2dXFy8EkW09c
         y3AO/gXoCRy5AIVtV20BF72eJywCUa1AxQwHBbT1ls6ym8yZsBQfgtsE0iYGuT148Pxg
         AiNL/V3X/HeKUcttfPNSufC9yE3rIYMX6I8eBHIPRifOLVX9n740OTIvU/lQLYywRZsB
         bIFXKXfyevlZDGDGeFwO5x//asIXi3IADiMcENQBFNUv/mgORllvt8L9ZqFK2iTBISrn
         EhYg==
X-Gm-Message-State: ACgBeo27AMkMmLaqvLkHnGbDEED04ih93vf2yS9VqW6ZKYvNPPsKcvUA
        NolG49bB8cFr2PXTaYFL3+OkkT4mydE=
X-Google-Smtp-Source: AA6agR6qz2wI4mvAT5RNQTo1r7ZQO1aq29t/HGAgCl55GcT+/3w5SW33w0b82w8zm/niEqs1mtbQAA==
X-Received: by 2002:a05:600c:4f92:b0:3a5:f545:a6ce with SMTP id n18-20020a05600c4f9200b003a5f545a6cemr7079190wmq.149.1661413716082;
        Thu, 25 Aug 2022 00:48:36 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b003a5537bb2besm4666408wms.25.2022.08.25.00.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 00:48:35 -0700 (PDT)
Message-ID: <017d77b8-8be3-a0a8-ce2e-17c7b6a16758@gmail.com>
Date:   Thu, 25 Aug 2022 09:48:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-man <linux-man@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joseph Myers <joseph@codesourcery.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Zack Weinberg <zackw@panix.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alex Colomar <alx@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Cyril Hrubis <chrubis@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        GCC <gcc-patches@gcc.gnu.org>, LTP List <ltp@lists.linux.it>,
        Florian Weimer <fweimer@redhat.com>,
        glibc <libc-alpha@sourceware.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Linux API <linux-api@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
 <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
 <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
 <5a3ce36a284fe988694d2e75117aca5f9af66194.camel@xry111.site>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <5a3ce36a284fe988694d2e75117aca5f9af66194.camel@xry111.site>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2tq1iQrZNr8SAH4XDeC6pnO1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2tq1iQrZNr8SAH4XDeC6pnO1
Content-Type: multipart/mixed; boundary="------------OsCfbhS1YqB1OqxDNlsqMg2N";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Xi Ruoyao <xry111@xry111.site>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-man <linux-man@vger.kernel.org>, Rich Felker <dalias@libc.org>,
 Alexei Starovoitov <ast@kernel.org>, David Howells <dhowells@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Joseph Myers <joseph@codesourcery.com>,
 linux-arch <linux-arch@vger.kernel.org>, Zack Weinberg <zackw@panix.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alex Colomar <alx@kernel.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Cyril Hrubis <chrubis@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, GCC <gcc-patches@gcc.gnu.org>,
 LTP List <ltp@lists.linux.it>, Florian Weimer <fweimer@redhat.com>,
 glibc <libc-alpha@sourceware.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, David Laight <David.Laight@aculab.com>,
 Linux API <linux-api@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Message-ID: <017d77b8-8be3-a0a8-ce2e-17c7b6a16758@gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
 <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
 <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
 <5a3ce36a284fe988694d2e75117aca5f9af66194.camel@xry111.site>
In-Reply-To: <5a3ce36a284fe988694d2e75117aca5f9af66194.camel@xry111.site>

--------------OsCfbhS1YqB1OqxDNlsqMg2N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgWGksDQoNCk9uIDgvMjUvMjIgMDk6MjgsIFhpIFJ1b3lhbyB3cm90ZToNCj4gT24gVGh1
LCAyMDIyLTA4LTI1IGF0IDA5OjIwICswMjAwLCBBbGVqYW5kcm8gQ29sb21hciB2aWEgR2Nj
LXBhdGNoZXMNCj4gd3JvdGU6DQo+PiBJIGRvbid0IGtub3cgZm9yIHN1cmUsIGFuZCBJIG5l
dmVyIHByZXRlbmRlZCB0byBzYXkgb3RoZXJ3aXNlLsKgIEJ1dCB3aGF0DQo+PiBJTUhPIHRo
ZSBrZXJuZWwgY291bGQgZG8gaXMgdG8gbWFrZSB0aGUgdHlwZXMgY29tcGF0aWJsZSwgYnkg
dHlwZWRlZmluZw0KPj4gdG8gdGhlIHNhbWUgZnVuZGFtZW50YWwgdHlwZXMgKGkuZS4sIGxv
bmcgb3IgbG9uZyBsb25nKSB0aGF0IHVzZXItc3BhY2UNCj4+IHR5cGVzIGRvLg0KPiANCj4g
SW4gdXNlci1zcGFjZSB0aGluZ3MgYXJlIGFscmVhZHkgaW5jb25zaXN0ZW50IGFzIHdlIGhh
dmUgbXVsdGlwbGUgbGliYw0KPiBpbXBsZW1lbnRhdGlvbnMuICBUZWxsaW5nIGV2ZXJ5IGxp
YmMgaW1wbGVtZW50YXRpb24gdG8gc3luYyB0aGVpcg0KPiB0eXBlZGVmIHcvbyBhIFdHMTQg
ZGVjaXNpb24gd2lsbCBvbmx5IGNhdXNlICJhZ2dyZXNzaXZlIGRpc2N1c3Npb24iIChmYXIN
Cj4gbW9yZSBhZ2dyZXNzaXZlIHRoYW4gdGhpcyB0aHJlYWQsIEknZCBzYXkpLg0KPiANCj4g
SWYgaW50NjRfdCBldGMuIHdlcmUgZGVmaW5lZCBhcyBidWlsdGluIHR5cGVzIHNpbmNlIGVw
b2NoLCB0aGluZ3Mgd291bGQNCj4gYmUgYSBsb3QgZWFzaWVyLiAgQnV0IHdlIGNhbid0IGNo
YW5nZSBoaXN0b3J5Lg0KDQpUaGlzIHdvdWxkIGJlIGdyZWF0LiAgSSBtZWFuLCB0aGUgZnVu
ZGFtZW50YWwgdHlwZXMgc2hvdWxkIGJlIHU4LCB1MTYsIA0KLi4uIGFuZCBpbnQsIGxvbmcs
IC4uLiB0eXBlZGVmcyBmb3IgdGhlc2UsIGFuZCBub3QgdGhlIG90aGVyIHdheSBhcm91bmQs
IA0KaWYgdGhlIGxhbmd1YWdlIHdhcyBkZXNpZ25lZCB0b2RheS4NCg0KTWF5YmUgR0NDIGNv
dWxkIGNvbnNpZGVyIHNvbWV0aGluZyBsaWtlIHRoYXQuDQoNCkNoZWVycywNCg0KQWxleA0K
DQotLSANCkFsZWphbmRybyBDb2xvbWFyDQo8aHR0cDovL3d3dy5hbGVqYW5kcm8tY29sb21h
ci5lcy8+DQo=

--------------OsCfbhS1YqB1OqxDNlsqMg2N--

--------------2tq1iQrZNr8SAH4XDeC6pnO1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMHKVEACgkQnowa+77/
2zLf/w//TGoaIMTn8K9jSsuXnyT12yLhySkI4g9lpuxSg5In1va2aYdE+FxmYy7j
aLYURQ69jURkCL4XLTvvVj3Adfter1t3/G7+EeiuJ6yF/J8nb8nzLVvvh2S5L5RK
79TESSnqgAqtZwFJqxeHfGBOLR7FSFjvVagRH+hALtUdowp5fQ+BsPGjvtBnyX5+
Jd36n7cN+tPCc6tfzVWWO8d4XTv9jOVqxhz9aiJjwULHqGFwea67x302daCMirQE
MxAauUo83+jCTwF0Sf7II4PWdfYukfsj2tUQLf7KSa3/3lWJptg2DEkaPzbLkvWA
4YlSNtr4mb87Q30UDCoK4W9QPK3bkROirz2hJC3snIMHanoBNWKqFkXhx3huM8HF
/UNidcqnYEd2SH7vWMIJNWQNQe1d8FSAJDEP7f7/0zamusLt2V66CTLgSwnfVOJM
l6gNR2Q6QBEnLqmXLuZ2UQrwVn9NUHqqYeL3CXs90GLVCXIRZ8qWkNFG+ZXKnwhO
lCPIxlQw+CrJo9As8kmkT/j8XKKNZ+0FmGtPsqlvby4Hj8+helZAGwLY3fFBj5iP
hwGLmg2pMSxt4zolCc0AoMO54yctNxJjxdoSrzlTf828lOHYlnVZxtai68yZkxK1
xXrF9toPzGkMRaTvDDrIO2kijs9gS2DV2q81CgOss1fPhAt5xe8=
=AeSD
-----END PGP SIGNATURE-----

--------------2tq1iQrZNr8SAH4XDeC6pnO1--
