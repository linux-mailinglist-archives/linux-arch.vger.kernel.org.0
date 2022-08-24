Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A665D5A04C3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 01:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiHXXg2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Aug 2022 19:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiHXXg1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2022 19:36:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43561FCE5;
        Wed, 24 Aug 2022 16:36:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u5so14757793wrt.11;
        Wed, 24 Aug 2022 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=JDeYv2WXOiLJKmMdjP6ILbJipXTwRf3CannrG9/vOgE=;
        b=kh1gz3Jyn0H1kHpK3imtmCo88AOlALpLy98QbGXEfYMW91cxd70GGPBt5AMlDZXNgX
         TcMPqKpHU1friWpSZ80N71knz7CEQfLbkWgAySYgb+dx0T8/7onhA+viPyv0BMd0BAKH
         h26BbX4VgdUG4+5In6s/L7A8hjp8oTJmKM3+prS4tLqO9q5Izun1e+pUI+pCLjMQqIGr
         ChduB2bJnZN2g7/PNnd8brd/z2tMY/kbY/lNNSJ3NRonl4gGiOs62dwjtoIvQiNkeM+A
         GaqBM85+p+Qle5ILOAi/ZpVUrBxdIkMd2EK4Watc85qCxTQCIz825DY0ue+PvFfSZRdI
         SV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=JDeYv2WXOiLJKmMdjP6ILbJipXTwRf3CannrG9/vOgE=;
        b=LqanQ+yP9ND8+wIUaVPW1C12k3stqqvSuc9kyjjLInrD14Z4TNYdvq9/KKSH6+QgnY
         kKAEwSHTVfTqDlqbcreTjAwZe0yrjk5V07suHr9BOzhravN/UcPbDlXlEQKU1Moj9x8D
         prLax+H2SLA8GJlRvK0fBtYWyw4Msm93mwMsQEucCKAXukvn5JTO0m9bzALEUlLgIZjM
         1rW6kg6x2qWvYf/4QQv9OYDAd0Kn34/tZGfOpg+uPX7HYymlt6we+HoZ6KDrcli5JMu/
         i4g4yUrnIj/o3tJ5DriSU0SDzInMO38ltpPOhw1C3fkGsR1FJrQ32vT7Bx8eEe2ngszC
         GYsQ==
X-Gm-Message-State: ACgBeo3HuvePTV+5wItZSBtstPLTpJ+yi6JVO0uIPDa0jCWY8UwFwhrW
        ZEPA/9i9dK41XJf/Ognnd/P/FeZwLMM=
X-Google-Smtp-Source: AA6agR6G0kkvYb3EYXApTcCyUhO22dQR6fpy2XprTyalQ43LpjE0878PLAZp48Xly0TA88ZNaczHSw==
X-Received: by 2002:a5d:4fcb:0:b0:225:6361:bafe with SMTP id h11-20020a5d4fcb000000b002256361bafemr618944wrw.585.1661384183339;
        Wed, 24 Aug 2022 16:36:23 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id w13-20020a5d680d000000b002254b912727sm12691197wru.26.2022.08.24.16.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 16:36:22 -0700 (PDT)
Message-ID: <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
Date:   Thu, 25 Aug 2022 01:36:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alex Colomar <alx@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-man <linux-man@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yTDpHcRCcmu0tTMubih6kyJ0"
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
--------------yTDpHcRCcmu0tTMubih6kyJ0
Content-Type: multipart/mixed; boundary="------------NjoQWjwmTaAr99QHFa7L0eJM";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alex Colomar <alx@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-man <linux-man@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 Michael Kerrisk <mtk.manpages@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
In-Reply-To: <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>

--------------NjoQWjwmTaAr99QHFa7L0eJM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QWxleGVpLA0KDQoNCk9uIDgvMjQvMjIgMjA6NTUsIEFsZWphbmRybyBDb2xvbWFyIHdyb3Rl
Og0KID4gTGluazogDQo8aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbWFuLzIwMjEw
NDIzMjMwNjA5LjEzNTE5LTEtYWx4Lm1hbnBhZ2VzQGdtYWlsLmNvbS9ULz4NCiA+IExpbms6
IDxodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL1ladklsejdKNnZPRVkrWHVAeXVraS9U
Lz4NCiA+IFNpZ25lZC1vZmYtYnk6IEFsZWphbmRybyBDb2xvbWFyIDxhbHgubWFucGFnZXNA
Z21haWwuY29tPg0KID4gTmFja2VkLWJ5OiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJu
ZWwub3JnPg0KID4gTmFja2VkLWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPg0KID4gTmFja2VkLWJ5OiBEYW5pZWwgQm9ya21hbm4gPGRhbmll
bEBpb2dlYXJib3gubmV0Pg0KID4gQWNrZWQtYnk6IFphY2sgV2VpbmJlcmcgPHphY2t3QHBh
bml4LmNvbT4NCg0KDQoNCk9uIDgvMjUvMjIgMDA6NDAsIEFsZXhlaSBTdGFyb3ZvaXRvdiB3
cm90ZToNCj4gT24gV2VkLCBBdWcgMjQsIDIwMjIgYXQgMTI6MDQgUE0gQWxlamFuZHJvIENv
bG9tYXINCj4gPGFseC5tYW5wYWdlc0BnbWFpbC5jb20+IHdyb3RlOg0KPj4NCj4+IGRpZmYg
LS1naXQgYS9tYW4yL2JwZi4yIGIvbWFuMi9icGYuMg0KPj4gaW5kZXggZDA1YjczZWMyLi44
NGQxYjYyZTUgMTAwNjQ0DQo+PiAtLS0gYS9tYW4yL2JwZi4yDQo+PiArKysgYi9tYW4yL2Jw
Zi4yDQoNClsuLi5dDQoNCj4+DQo+PiAgICAgICBzdHJ1Y3QgeyAgICAvKiBVc2VkIGJ5IEJQ
Rl9QUk9HX0xPQUQgKi8NCj4+IC0gICAgICAgIF9fdTMyICAgICAgICAgcHJvZ190eXBlOw0K
Pj4gLSAgICAgICAgX191MzIgICAgICAgICBpbnNuX2NudDsNCj4+ICsgICAgICAgIHVpbnQz
Ml90ICAgICAgcHJvZ190eXBlOw0KPj4gKyAgICAgICAgdWludDMyX3QgICAgICBpbnNuX2Nu
dDsNCj4gDQo+IEZvciB0aGUgTi10aCB0aW1lOg0KPiBOYWNrZWQtYnk6IEFsZXhlaSBTdGFy
b3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+DQo+IA0KPiBQbGVhc2Ugc3RvcCBzZW5kaW5nIHRo
aXMgcGF0Y2guDQoNClNvcnJ5LCBidXQgbm8uDQoNCkZpcnN0LCB0aGlzIGhhcyBvbmx5IGJl
ZW4gdjMsIGFuZCB2MSB3YXMgYSB5ZWFyIGFuZCBhIGhhbGYgYWdvLCBkb24ndCANCm1ha2Ug
aXQgbGlrZSBJJ20gY29uc3RhbnRseSBtYWtpbmcgeW91IGxvc2UgeW91ciBwcmVjaW91cyB0
aW1lLCBiZWNhdXNlIA0KSSdtIGFjdGl2ZWx5IHRyeWluZyBub3QgdG8uDQoNClNlY29uZCwg
SSBhbHJlYWR5IG1hZGUgYSBiaWcgbm90aWNlIHRoYXQgeW91IGFuZCBhIGZldyBtb3JlIGhh
dmUgDQpzdHJvbmdseSBvcHBvc2VkIHRvIHRoZSBwYXRjaCwgcmVzcGVjdGZ1bGx5IGtlZXBp
bmcgYWxsIG9mIHlvdXIgTkFLcyBpbiANCm15IHBhdGNoLCBhcyB5b3UgY2FuIHNlZSBhYm92
ZS4NCg0KSSBnYXZlIHZlcnkgZGV0YWlsZWQgcmVhc29ucyBvZiB3aHkgdGhpcyBwYXRjaCBp
cyByZWFzb25hYmxlIGFuZCwgYmFjayANCmluIHRoZSBkYXlzIG9mIHYxLCBaYWNrIChmcm9t
IGdsaWJjKSBnYXZlIGV2ZW4gYmV0dGVyIHJlYXNvbnMgb2Ygd2h5IHRoZSANCm1hbnVhbCBw
YWdlcyBzaG91bGQgZG9jdW1lbnQgSVNPIEMgKGxpYmMpIHR5cGVzLCBhbmQgbm90IGtlcm5l
bCBvbmVzLCANCmFuZCB3aHkgaXQgc2hvdWxkbid0IG1hdHRlciB0byB1c2VyLXNwYWNlIHBy
b2dyYW1tZXJzLg0KDQpCdXQgZnJvbSB5b3VyIHNpZGUgd2hhdCBkbyB3ZSBoYXZlPyAgSnVz
dCBkaXJlY3QgTkFLcyB3aXRob3V0IG11Y2ggDQpleHBsYW5hdGlvbi4gIFRoZSBvbmx5IG9u
ZSB3aG8gZ2F2ZSBzb21lIGV4cGxhbmF0aW9uIHdhcyBHcmVnLCBhbmQgaGUgDQp2YWd1ZWx5
IHBvaW50ZWQgdG8gTGludXMncyBjb21tZW50cyBhYm91dCBpdCBpbiB0aGUgcGFzdCwgd2l0
aCBubyANCnByZWNpc2UgcG9pbnRlciB0byBpdC4gIEkgaW52ZXN0aWdhdGVkIGEgbG90IGJl
Zm9yZSB2MiwgYW5kIGNvdWxkIG5vdCANCmZpbmQgYW55dGhpbmcgc3Ryb25nIGVub3VnaCB0
byByZWNvbW1lbmQgdXNpbmcga2VybmVsIHR5cGVzIGluIHVzZXIgDQpzcGFjZSwgc28gSSBw
dXNoZWQgdjIsIGFuZCB0aGUgZGlzY3Vzc2lvbiB3YXMga2VwdC4NCg0KSSB3b3VsZCBsaWtl
IHRoYXQgaWYgeW91IHN0aWxsIG9wcG9zZSB0byB0aGUgcGF0Y2gsIGF0IGxlYXN0IHdlcmUg
YWJsZSANCnRvIHByb3ZpZGUgc29tZSBmYWN0cyB0byB0aGlzIGRpc2N1c3Npb24uDQoNCkJ1
dCB0aGUgbW9zdCBmdW5kYW1lbnRhbCB0aGluZyB0aGF0IEkgYXNrIGlzIHRoYXQgeW91IHJl
c3BlY3QgbWUuDQoNCldpdGggdGhpcyBhdHRpdHVkZSwgdGhlIG9ubHkgdGhpbmcgeW91J3Jl
IGdvaW5nIHRvIGdldCBpcyB0aGF0IEkgYXBwbHkgDQp0aGUgcGF0Y2ggcmlnaHQgYWZ0ZXIs
IGJlY2F1c2U6DQoNCjEpIFRoZSBwYXRjaCBpcyByaWdodC4gIEdvIHRhbGsgdG8gZ2xpYmMg
YW5kIGdjYyBtYWludGFpbmVycywgd2hvIGtub3cgDQpob3cgdHlwZXMgd29yayBieSBoZWFy
dCBpZiB5b3UgaGF2ZSBkb3VidHMuDQoNCjIpIEknbSB0aGUgbWFpbnRhaW5lciBvZiB0aGlz
IHByb2plY3QsIGFuZCB1bmRlciBkb3VidHMsIGl0J3MgbXkgZGVjaXNzaW9uLg0KDQpJJ20g
dHJ5aW5nIHRvIGJlIG5pY2UsIGFuZCBhc2sgZm9yIHJldmlldyB0byBtYWtlIHN1cmUgSSdt
IG5vdCBtYWtpbmcgDQpzb21lIGJpZyBtaXN0YWtlIGJ5IGFjY2lkZW50LCBhbmQgSSBnZXQg
ZGlzcmVzcGVjdD8gIE5vIHRoYW5rcy4NCg0KDQpQYXRjaCBhcHBsaWVkLg0KDQoNCk5vdywg
aWYgc29tZW9uZSB3aXRoIGEgYml0IG1vcmUgcmVzcGVjdCBzdGlsbCB0aGlua3MgdGhpcyBj
aGFuZ2UgaXMgDQppbmNvcnJlY3QsIGFuZCBpcyB3YW50aW5nIHRvIHNoYXJlIHNvbWUgZmFj
dHMgdG8gc2hvdyBtZSBteSBtaXN0YWtlLCANCkknbGwgaGFwcGlseSByZXZpZXcgaXQgYW5k
IHJldmVydCB0aGUgcGF0Y2ggaWYgbmVjZXNzYXJ5LiAgRm9yIG5vdywgdGhlIA0KcGF0Y2gg
aXMgYXBwbGllZC4NCg0KDQpBbGV4DQoNCg0KLS0gDQpBbGVqYW5kcm8gQ29sb21hcg0KTGlu
dXggbWFuLXBhZ2VzIG1haW50YWluZXINCjxodHRwOi8vd3d3LmFsZWphbmRyby1jb2xvbWFy
LmVzLz4NCg==

--------------NjoQWjwmTaAr99QHFa7L0eJM--

--------------yTDpHcRCcmu0tTMubih6kyJ0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMGtesACgkQnowa+77/
2zKQjg/+Jy+et5jXc3VUkPr640EEjB12mTl2UWzGh4BVQSPdLPuQInxHhhX4qCti
zmGolM1fJmfKZdgSjQFdOQN+e+L/FxJKmJOPWRKzP/iL+7NfOn1K2m5xma2kPnNX
rGHvOSxY10ByTGuTDaKTCO3s2dj3knhxaY8qk1Je1xGEzMfJcbENYyBa03Xgk3zk
cwTbRBRMctOO0GuxX7qBCKA8eV83BMTPZkasu2vy1AHAh59SYcnri/SlOto9vMYA
dLxKbfFg+y/e61Ri1A2EUV6Ff9udAIoVGVKWSm6nf3P+eFfFu0V7feVbDqvupggO
cGFsrcQsFnsvnNu7RtIfIDW7fLxrkF3mSB3e/4gp1HzUOBD7I7ZQb/Doxf4nt5qk
pBJSMk6ByN0AOpFE+jyw9KK5AKnnwgTUoTDzDncYsO0dQCVEBa0OJQulq4pzt6xt
TioYjZjvNcZ8jn27WKkV+ieAu9bR9fONsfbeir3wmzWrOP0pZBpARyir22rWrGRo
6jDnt5YNczfEkFbKFfHDj+29zgtmHTnQh4+vwWmQJJSA2epu0mVxqzfAEs+Id6vM
IhlMNFk9wbM8j0GXGaSc2oszcYQlXlo9LCfhEYt6/5SVYCKxLDc2dWe2ubUXivV1
RT7QWnolwKyAbWGbR5lpzzQ5tB+k7GSl/8O7yli4GJfSH2d+bfg=
=cOY9
-----END PGP SIGNATURE-----

--------------yTDpHcRCcmu0tTMubih6kyJ0--
