Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79F05A0A9C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 09:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiHYHos (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 03:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbiHYHoq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 03:44:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90721B56;
        Thu, 25 Aug 2022 00:44:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h5so22681943wru.7;
        Thu, 25 Aug 2022 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=wC/4RLU+RSv1yOJdyK6gxSuOHheohaUMXWv7iLpvLTw=;
        b=J/EW2qUgE6EsfmDr37qTiiK/b09kuO4UaVm01/UGo8ApuKbjHBvnJOP5YDmAlz0xoV
         bNZFQ1f+K1gEeJeCATlbj88sgQLQ4XDj/rPo7nKlJYXQESn7L0z/kOHgcsKrGRk75tk0
         /q8J4hUXZvi8jmxOGfH9VLPV4V6VhXlUgIhm6v3jImhqLKZU0GABJnnX5gaps29mH1Jx
         +DTSbAQzlvv36oMz5XGPza/xreBb/rSF/sq9puv9iWyB2umpBMEhBGk2baKepJZjdomo
         S31LXLNPVbiHA491lpS2JFzPKpEFXOc/G/NxQfSExpzLPYCgEQcfi0PE/Nt+lrOwHr1i
         kIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=wC/4RLU+RSv1yOJdyK6gxSuOHheohaUMXWv7iLpvLTw=;
        b=j/G5JEr8RSypFZVPsauVK/ob0eTMmO2t6OlNvSO7dLhW2isiMamKhWbX1u4x0q/W45
         BCqE7nvisCsryLx3+oJ+S3wpB/dJyFMhloA3dpcHXevhj91YTrkpDqdI8ZkEXNXEeG9B
         HKRevSvmIsBareEFzso8yVKeNQ4hlgAzlapDtqQJ5OksbBbSYEj1weaARYyAnONTqWhD
         58+Nn19mlKFu/UcHHswIoUu2f8NGJnjFhJAFLIIgeICY8fUzKpOHAWBrUaVxjfAtjqc2
         VeTnO+f+MlbhYG3pYLU66gGdw2e47JuS5pg/nhXZztu02pL1EwwwrgdrRSOjnm2XoDBW
         z7bQ==
X-Gm-Message-State: ACgBeo3W183Iup7GDRMGh9Hx31yVOGFI8/XkyUa4gWbEQxXcm93ns1sk
        5zFWnXLPkLPU+nvbMRbNI0I=
X-Google-Smtp-Source: AA6agR4liPS4m0VwftnqI1zyp7dcDCnEDhCZBguka0OoLvzAcgzKK4g0L2W6cD+goCqPlqFFN/qBpw==
X-Received: by 2002:a05:6000:1863:b0:220:6d5f:deb5 with SMTP id d3-20020a056000186300b002206d5fdeb5mr1357239wri.470.1661413483045;
        Thu, 25 Aug 2022 00:44:43 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d624a000000b0021e6c52c921sm22323326wrv.54.2022.08.25.00.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 00:44:42 -0700 (PDT)
Message-ID: <609e1161-87ee-bb48-d14c-dc444ddff754@gmail.com>
Date:   Thu, 25 Aug 2022 09:44:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alex Colomar <alx@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <YwcPQ987poRYjfoL@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zJ1090FtbG0AYqeP3v4clyBt"
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
--------------zJ1090FtbG0AYqeP3v4clyBt
Content-Type: multipart/mixed; boundary="------------jA7pwEBe3xNF2bE9WQsw4Bye";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alex Colomar <alx@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-man <linux-man@vger.kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Zack Weinberg <zackw@panix.com>,
 LKML <linux-kernel@vger.kernel.org>, glibc <libc-alpha@sourceware.org>,
 GCC <gcc-patches@gcc.gnu.org>, bpf <bpf@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>, Linux API <linux-api@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 David Laight <David.Laight@aculab.com>,
 Joseph Myers <joseph@codesourcery.com>, Florian Weimer <fweimer@redhat.com>,
 Cyril Hrubis <chrubis@suse.cz>, David Howells <dhowells@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <609e1161-87ee-bb48-d14c-dc444ddff754@gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
In-Reply-To: <YwcPQ987poRYjfoL@kroah.com>

--------------jA7pwEBe3xNF2bE9WQsw4Bye
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgR3JlZywNCg0KT24gOC8yNS8yMiAwNzo1NywgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3Rl
Og0KPiBPbiBUaHUsIEF1ZyAyNSwgMjAyMiBhdCAwMTozNjoxMEFNICswMjAwLCBBbGVqYW5k
cm8gQ29sb21hciB3cm90ZToNCj4+IEJ1dCBmcm9tIHlvdXIgc2lkZSB3aGF0IGRvIHdlIGhh
dmU/ICBKdXN0IGRpcmVjdCBOQUtzIHdpdGhvdXQgbXVjaA0KPj4gZXhwbGFuYXRpb24uICBU
aGUgb25seSBvbmUgd2hvIGdhdmUgc29tZSBleHBsYW5hdGlvbiB3YXMgR3JlZywgYW5kIGhl
DQo+PiB2YWd1ZWx5IHBvaW50ZWQgdG8gTGludXMncyBjb21tZW50cyBhYm91dCBpdCBpbiB0
aGUgcGFzdCwgd2l0aCBubyBwcmVjaXNlDQo+PiBwb2ludGVyIHRvIGl0LiAgSSBpbnZlc3Rp
Z2F0ZWQgYSBsb3QgYmVmb3JlIHYyLCBhbmQgY291bGQgbm90IGZpbmQgYW55dGhpbmcNCj4+
IHN0cm9uZyBlbm91Z2ggdG8gcmVjb21tZW5kIHVzaW5nIGtlcm5lbCB0eXBlcyBpbiB1c2Vy
IHNwYWNlLCBzbyBJIHB1c2hlZCB2MiwNCj4+IGFuZCB0aGUgZGlzY3Vzc2lvbiB3YXMga2Vw
dC4NCj4gDQo+IFNvIGRlc3BpdGUgbWUgc2F5aW5nIHRoYXQgInRoaXMgaXMgbm90IG9rIiwg
YW5kIG1hbnkgb3RoZXIgbWFpbnRhaW5lcnMNCj4gc2F5aW5nICJ0aGlzIGlzIG5vdCBvayIs
IHlvdSBhcHBsaWVkIGEgcGF0Y2ggd2l0aCBvdXIgb2JqZWN0aW9ucyBvbiBpdD8NCj4gVGhh
dCBpcyB2ZXJ5IG9kZCBhbmQgYSBiaXQgcnVkZS4NCj4gDQo+PiBJIHdvdWxkIGxpa2UgdGhh
dCBpZiB5b3Ugc3RpbGwgb3Bwb3NlIHRvIHRoZSBwYXRjaCwgYXQgbGVhc3Qgd2VyZSBhYmxl
IHRvDQo+PiBwcm92aWRlIHNvbWUgZmFjdHMgdG8gdGhpcyBkaXNjdXNzaW9uLg0KPiANCj4g
VGhlIGZhY3QgaXMgdGhhdCB0aGUga2VybmVsIGNhbiBub3QgdXNlIHRoZSBuYW1lc3BhY2Ug
dGhhdCB1c2Vyc3BhY2UgaGFzDQo+IHdpdGggSVNPIEMgbmFtZXMuICBJdCdzIHRoYXQgc2lt
cGxlIGFzIHRoZSBJU08gc3RhbmRhcmQgZG9lcyBOT1QNCj4gZGVzY3JpYmUgdGhlIHZhcmlh
YmxlIHR5cGVzIGZvciBhbiBBQkkgdGhhdCBjYW4gY3Jvc3MgdGhlIHVzZXIva2VybmVsDQo+
IGJvdW5kcnkuDQoNCkkgdW5kZXJzdGFuZCB0aGF0LiAgQnV0IHVzZXItc3BhY2UgcHJvZ3Jh
bXMgYXJlIGFsbG93ZWQgdG8gdXNlIHRoZSANCnN0YW5kYXJkIHR5cGVzIHdoZW4gY2FsbGlu
ZyBhIHN5c2NhbGwgdGhhdCByZWFsbHkgdXNlcyBrZXJuZWwgdHlwZXMuDQoNCklNSE8sIGl0
IHNob3VsZCBiZSBpcnJlbGV2YW50IGZvciB0aGUgdXNlciBob3cgdGhlIGtlcm5lbCBkZWNp
ZGVzIHRvIA0KY2FsbCBhIDY0LWJpdCB1bnNpZ25lZCBpbnRlZ2VyLCByaWdodD8NCg0KT3Ig
ZG8geW91IG1lYW4gdGhhdCBzb21lIG9mIHRoZSBwYWdlcyBJIG1vZGlmaWVkDQoNCj4gDQo+
IFdvcmsgd2l0aCB0aGUgSVNPIEMgc3RhbmRhcmQgaWYgeW91IHdpc2ggdG8gZG9jdW1lbnQg
c3VjaCB0eXBlIHVzYWdlLA0KPiBhbmQgZ2V0IGl0IGFwcHJvdmVkIGFuZCB0aGVuIHdlIHdv
dWxkIGJlIHdpbGxpbmcgdG8gY29uc2lkZXIgc3VjaCBhDQo+IGNoYW5nZS4gIEJ1dCB1bnRp
bCB0aGVuLCB3ZSBoYXZlIHRvIHN0aWNrIHRvIG91ciB2YXJpYWJsZSBuYW1lIHR5cGVzLA0K
PiBqdXN0IGxpa2UgYWxsIG90aGVyIG9wZXJhdGluZyBzeXN0ZW1zIGhhdmUgdG8gKHdlIGFy
ZSBub3QgYWxvbmUgaGVyZS4pDQo+IA0KPiBQbGVhc2UgcmV2ZXJ0IHlvdXIgY2hhbmdlLg0K
DQpUaGFua3MgZm9yIGFza2luZyBuaWNlbHkuDQoNClNpbmNlIHRoZXJlJ3Mgb25nb2luZyBk
aXNjdXNzaW9uLCBhbmQgSSBkb24ndCB3YW50IHRvIG1ha2UgaXQgbG9vayBsaWtlIA0KaWdu
b3JpbmcgaXQsIEkndmUgcmV2ZXJ0ZWQgdGhlIHBhdGNoIGZvciBub3cuICBJZiBJIGFwcGx5
IGl0IGFnYWluLCBJIA0KaG9wZSB0aGF0IGl0IHdpbGwgYmUgd2l0aCBzb21lIG1vcmUgY29u
c2Vuc3VzLCBhcyBJJ3ZlIGFsd2F5cyB0cmllZCB0byANCmRvLiAgU29ycnkgaWYgSSB3YXMg
YSBiaXQgaXJhc2NpYmxlIHllc3RlcmRheS4gIFNoaXQgaGFwcGVucy4NCg0KVEw7RFI6ICBQ
YXRjaCByZXZlcnRlZDsgYXNraW5nIG5pY2VseSB3b3Jrcy4gPSkNCg0KPiANCj4gZ3JlZyBr
LWgNCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCi0tIA0KQWxlamFuZHJvIENvbG9tYXINCjxodHRw
Oi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVzLz4NCg==

--------------jA7pwEBe3xNF2bE9WQsw4Bye--

--------------zJ1090FtbG0AYqeP3v4clyBt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMHKGgACgkQnowa+77/
2zJEJQ/9FY6MaZmaY08xPFzcQI0lzOthVD+nM9owcPC1btI+64mBesCWxhU8fdLL
pcD/KerUrSxZclEs1T9vtm/2wuUU4aRWygJ3Z333VmuH16YKmzIizeSRlzzRaHs7
PfnhLxo6/PtoJyV93a4BDiehSXcWxNz87eEld9ld541mdnhL3Espz1QE6zNdf1vn
1mJ7ZDE3kqCaKFdQ4Kw2rREmCHsKJO/QH4U8jEg9oV/jRbuJltIWyC28oyFjSio3
XUQY0lHzuppxj0tXbmCyZPJFdm8qYNAxVZlWWBcnyFs+t2gPMqBVQCltcZPYxzGF
BdeUgusdSLVK6Hn67czyDjsm6s8wgEp6325xOX6ogcSvd6lO1E/anwS17p5NuqCD
OhjSma6wKi+1VDjFQ5iFD4TGu0KSqgHMcWlCvTq5V7RjbJwIgZrLfpy6Pe0LS88C
1GjrdFU5BjYtd1leXUOWzkORk/uw0nXOANiFsbWy06mFu9FCPKhWMry7ctiZX5yi
Ubk62LWLwu1GbrJb+AP22kli5+HdHODYHBElbwbr77wLOdlU9gJWR9qaw1F+1lDm
kQ2UsM4t9jTYjntl/iRSx07WHtLIgM/8vhKNLfmvhwX3dqvnPiOwCffjET9H12jE
XyNgUj3iCTND5dcSl6bK+nX/AIpOQlnCqxDewmdgHFtUC3NrX3M=
=GgGK
-----END PGP SIGNATURE-----

--------------zJ1090FtbG0AYqeP3v4clyBt--
