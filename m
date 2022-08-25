Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B435A09F2
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiHYHUV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 03:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiHYHUR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 03:20:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3194C65575;
        Thu, 25 Aug 2022 00:20:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso2151760wmh.5;
        Thu, 25 Aug 2022 00:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=KIHxt5nVijY/1SpzhvDTBoWdHMIpgSP8DcUseF72CE4=;
        b=HP66mFj9l67k/JHPYecCyXq+n3/83muw5zms7LtbAJCfKrLnNEa98VUMKzlHtHvOYZ
         FSVrgmX7YOxt27V5TJ5K+c5UIFaCKU7sAhOmD10AEGJGPp1YDJuSSTxiN175TerOVJ9r
         FjOplwHCpEH4hKNUNPx8mRl4uvVxc+CFSVhsfc35s1vbt0TAE/JLlByROvuEdMbeyD7s
         3suab3AwCsSAFeRbIHU/k0lhtVzvrmhYzHEg0jRhrzhQKtnqyhFDXKnDtTynqufmDEqU
         LwhQuxx71FlLzwzGBiI34280CbLoKuHTs+z4tFKD5awuoqrVmfrGEDXWqOVc7h5IoZ3s
         pNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=KIHxt5nVijY/1SpzhvDTBoWdHMIpgSP8DcUseF72CE4=;
        b=2sQ48AneOvaFzVvjglFppPNbgnMR13Z71xkKO8lmqvabURgLurRZJramU3/XLiL1NB
         aE3ToDLtDfP6ukAeKhAkbRvxkZq7ZtmXxagNNFUs7oLmdFHE6TanfiF673HUV/QPh1Hq
         ZGvIxVMid/kkMKOYJgmBDnRzyQKH1+ej9C2apFW7re9N9eYebu2i9RyCl3jodR7y3e41
         qyx46IsHszT0Fjo6xzCxJDmSWSWddtd3QUslZJnEq+V8bIoQX//CzZd8CcGY6FaFbaJu
         SUmZOhUit9pfr1Ul6fMHfYDsSqTmnErelew6sUHoGA1MPE1q5YqczXk4Mq0918VQk6oz
         sl8w==
X-Gm-Message-State: ACgBeo04uqie1SrQk3U1qpYecF8Wmp6PjzHvKcCbmOlczJtRc4o9Jidh
        WnY7hV6lBFroNO9edMoz7bM=
X-Google-Smtp-Source: AA6agR5+BsM//Bgc6fvPd4+/S9EWpj+VYQ+WYOROmakuFpqHjN0+qqVfbQmCZsp9tA9zbX3+6ZB1iA==
X-Received: by 2002:a05:600c:2e48:b0:3a5:b600:1a3b with SMTP id q8-20020a05600c2e4800b003a5b6001a3bmr1290062wmf.180.1661412014760;
        Thu, 25 Aug 2022 00:20:14 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id i14-20020a05600c354e00b003a4f08495b7sm4593628wmq.34.2022.08.25.00.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 00:20:14 -0700 (PDT)
Message-ID: <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
Date:   Thu, 25 Aug 2022 09:20:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alex Colomar <alx@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
 <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
Content-Language: en-US
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oanfeXgMU6o81bRhHPRltey6"
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
--------------oanfeXgMU6o81bRhHPRltey6
Content-Type: multipart/mixed; boundary="------------d0sCgY7JNiM9BzNqtiBt3hta";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alex Colomar <alx@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-man <linux-man@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Zack Weinberg <zackw@panix.com>,
 LKML <linux-kernel@vger.kernel.org>, glibc <libc-alpha@sourceware.org>,
 GCC <gcc-patches@gcc.gnu.org>, bpf <bpf@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>, Linux API <linux-api@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 David Laight <David.Laight@aculab.com>,
 Joseph Myers <joseph@codesourcery.com>, Florian Weimer <fweimer@redhat.com>,
 Cyril Hrubis <chrubis@suse.cz>, David Howells <dhowells@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
 <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
In-Reply-To: <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>

--------------d0sCgY7JNiM9BzNqtiBt3hta
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgTGludXgsDQoNCk9uIDgvMjUvMjIgMDI6NTIsIExpbnVzIFRvcnZhbGRzIHdyb3RlOg0K
PiBPbiBXZWQsIEF1ZyAyNCwgMjAyMiBhdCA0OjM2IFBNIEFsZWphbmRybyBDb2xvbWFyDQo+
IDxhbHgubWFucGFnZXNAZ21haWwuY29tPiB3cm90ZToNCj4+DQo+PiBJJ20gdHJ5aW5nIHRv
IGJlIG5pY2UsIGFuZCBhc2sgZm9yIHJldmlldyB0byBtYWtlIHN1cmUgSSdtIG5vdCBtYWtp
bmcNCj4+IHNvbWUgYmlnIG1pc3Rha2UgYnkgYWNjaWRlbnQsIGFuZCBJIGdldCBkaXNyZXNw
ZWN0PyAgTm8gdGhhbmtzLg0KPiANCj4gWW91J3ZlIGJlZW4gdG9sZCBtdWx0aXBsZSB0aW1l
cyB0aGF0IHRoZSBrZXJuZWwgZG9lc24ndCB1c2UgdGhlDQo+ICJzdGFuZGFyZCIgbmFtZXMs
IGFuZCAqY2Fubm90KiB1c2UgdGhlbSBmb3IgbmFtZXNwYWNlIHJlYXNvbnMsIGFuZCB5b3UN
Cj4gaWdub3JlIGFsbCB0aGUgZmVlZGJhY2ssIGFuZCB0aGVuIHlvdSBjbGFpbSB5b3UgYXJl
IGFza2luZyBmb3IgcmV2aWV3Pw0KDQpUaGlzIHBhdGNoIGlzIG5vdCBhYm91dCBrZXJuZWws
IGJ1dCBhYm91dCB0aGUgc2VjdGlvbiAyIGFuZCAzIG1hbnVhbCANCnBhZ2VzLCB3aGljaCBh
cmUgZGlyZWN0ZWQgdG93YXJkcyB1c2VyLXNwYWNlIHJlYWRlcnMgbW9zdCBvZiB0aGUgdGlt
ZS4gDQpBZG1pdHRlZGx5LCBzb21lIHN5c2NhbGxzIGFyZSBvbmx5IGNhbGxhYmxlIGZyb20g
d2l0aGluIHRoZSBrZXJuZWwgDQppdHNlbGYsIGJ1dCB0aGF0J3MgdmVyeSByYXJlLg0KDQpb
Li4uXQ0KDQo+IA0KPiBUaGUgZmFjdCBpcywga2VybmVsIFVBUEkgaGVhZGVyIGZpbGVzIE1V
U1QgTk9UIHVzZSB0aGUgc28tY2FsbGVkIHN0YW5kYXJkIG5hbWVzLg0KDQpJIGRvbid0IGtu
b3cgZm9yIHN1cmUsIGFuZCBJIG5ldmVyIHByZXRlbmRlZCB0byBzYXkgb3RoZXJ3aXNlLiAg
QnV0IHdoYXQgDQpJTUhPIHRoZSBrZXJuZWwgY291bGQgZG8gaXMgdG8gbWFrZSB0aGUgdHlw
ZXMgY29tcGF0aWJsZSwgYnkgdHlwZWRlZmluZyANCnRvIHRoZSBzYW1lIGZ1bmRhbWVudGFs
IHR5cGVzIChpLmUuLCBsb25nIG9yIGxvbmcgbG9uZykgdGhhdCB1c2VyLXNwYWNlIA0KdHlw
ZXMgZG8uDQoNCj4gDQo+IFdlIGNhbm5vdCBwcm92aWRlIHNhaWQgbmFtZXMsIGJlY2F1c2Ug
dGhleSBhcmUgb25seSBwcm92aWRlZCBieSB0aGUNCj4gc3RhbmRhcmQgaGVhZGVyIGZpbGVz
Lg0KPiANCj4gQW5kIHNpbmNlIGtlcm5lbCBoZWFkZXIgZmlsZXMgY2Fubm90IHByb3ZpZGUg
dGhlbSwgdGhlbiBrZXJuZWwgVUFQSQ0KPiBoZWFkZXIgZmlsZXMgY2Fubm90IF91c2VfIHRo
ZW0uDQo+IA0KPiBFbmQgcmVzdWx0OiBhbnkga2VybmVsIFVBUEkgaGVhZGVyIGZpbGUgd2ls
bCBjb250aW51ZSB0byB1c2UgX191MzIgZXRjDQo+IG5hbWluZyB0aGF0IGRvZXNuJ3QgaGF2
ZSBhbnkgbmFtZXNwYWNlIHBvbGx1dGlvbiBpc3N1ZXMuDQo+IA0KPiBOb3RoaW5nIGVsc2Ug
aXMgZXZlbiByZW1vdGVseSBhY2NlcHRhYmxlLg0KPiANCj4gU3RvcCB0cnlpbmcgdG8gbWFr
ZSB0aGlzIHNvbWV0aGluZyBvdGhlciB0aGFuIGl0IGlzLg0KPiANCj4gQW5kIGlmIHlvdSBj
YW5ub3QgYWNjZXB0IHRoZXNlIHNpbXBsZSB0ZWNobmljYWwgcmVhc29ucywgd2h5IGRvIHlv
dQ0KPiBleHBlY3QgcmVzcGVjdD8NCj4gDQo+IFdoeSBhcmUgeW91IHNvIHNwZWNpYWwgdGhh
dCB5b3UgdGhpbmsgeW91IGNhbiBjaGFuZ2UgdGhlIHJ1bGVzIGZvcg0KPiBrZXJuZWwgdWFw
aSBmaWxlcyBvdmVyIHRoZSAqcmVwZWF0ZWQqIG9iamVjdGlvbnMgZnJvbSBtYWludGFpbmVy
cyB3aG8NCj4ga25vdyBiZXR0ZXI/DQoNCk5vIHNvcnJ5LCBpZiBzb21lb25lIHVuZGVyc3Rv
b2QgdGhpcyBwYXRjaCBhcyBjaGFuZ2luZyBhbnl0aGluZyBpbiBVQVBJLCANCml0IGlzIG5v
dC4NCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCi0tIA0KQWxlamFuZHJvIENvbG9tYXINCjxodHRw
Oi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVzLz4NCg==

--------------d0sCgY7JNiM9BzNqtiBt3hta--

--------------oanfeXgMU6o81bRhHPRltey6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMHIqUACgkQnowa+77/
2zKowQ//T9Dw8P8iN8M+GICDP9viCaXqqy2OSiJyLSToX5TGQNJbzaudX5hxADM7
YSvG+OfCRURfwN234jhVoLRI8wYk6wuLQ/baysvCMMEtR5Q+pl5inY4L0t72wAAi
8IOtyKvhYPWbpcsKNwsrHCxpIyjG3G91W4DnzKJnp7va3Wa+NqzaTWmGUVbYmo41
2SP8oq6pu94TPCH+FCr4XLiWH38jwl64B4ZkziTsKnM/DzCQUfzA0flsxRtxtUW9
8k0XcZDn2QQuYMeCAf/mVEHnz+3KoFzrGPOMmjjgeDCzYf3kPh7RKEpHgwgIuJpa
N+00kpBybRAn0ubTDWSOx0Rupow1OTlzKibriSDvo2CV383JXpCwueHz1PTpkjEP
TckJiWIjiDFEMs5obOxkAIQDfSSLrQL3HLuCN1THsxWsjucSXMPYhjByjAgGLWXj
d5wNf/8HILprxEvRzyyWXnZRg42SveNR6UONM36aVquZ5YaBRY0iWb2SknIXLOhi
k8zoxsswO5bAdcTfCQzMGxlclnWFlyUfmiD4zzH8iN2HzGEDA4xCElsJPUtJTMtF
+cjG/eZRd1NGdKJfCpc3u7Igb4tA6Ofp8zercjhNDRPrCfYGbACukk2tygMEzJyf
d5vFv9iS2QTZUmnNc+6hur8oGUAqlP/O10ThPbd0/NeVf0vcDuY=
=Crgh
-----END PGP SIGNATURE-----

--------------oanfeXgMU6o81bRhHPRltey6--
