Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3777366FB5
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbhDUQGP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Apr 2021 12:06:15 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:23408 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbhDUQGO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Apr 2021 12:06:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1619021138; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gyXYaODNllryh1sTYaeqPeUj4GCOEReKQxRRpl9APqu3J4hJK98H4rEjfTg900FFMe
    fK+8w+IlODgMa1CplmdXcOjYCV0MZNvbbJYxQ7dk9vLEi3qO6N7ROVdViCYukwEBodYR
    K7xVPdpY+MyLyFg9/7Y+Cs8PouUYm4jT0bkS947PIvyXFcxYsA4SZrSRHx0qOcOpVaBW
    GtDP1ctdY2w6HF7oJrno+Br/hNXIwdsDwBLawsHHkSosLAQ7fgAnMeFdp0U8YrH9/Z6Z
    6pkxWeZGV7wGtprVxn/80n8yvKaBLgvRORkjXYPkBbYU54fQOdqCvIyGhQAqx1wmTkAA
    zFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1619021138;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ZnB6n91eJ/MByNOT4nJoMMoQqFjCem7iinD4teAGwlI=;
    b=ZcRlZ0FOOBlf6fsCS2iHOR9y2m26RTT2verI/LV8ZhtrWmAz2sdI7HwPbwyns1u7+k
    Xt5qumw2GuD148dVUUby636d4wXjaHJrPe5KBevlyBFYsviPAI9md8wRtXLlGvsjYuBO
    WItuHFKMEltZpdvRcHPFb7DPfQHkXpUPKTegCKjrVIwYTtm6HLCWz/OGkJYTvKuZIfPY
    Y0XvyhBevmAnFoQk65ZmyqcueLnXPSWji7Q25k7/Qqd77VserUUBbzlFxSdJqroNEebi
    U06O8AoMso4NMJCEOxc7VTR5TexiG8E0wn4jA3UgeMYOjNLGEwGEvx0qwGoIB4VzeFHU
    D+lQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1619021138;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ZnB6n91eJ/MByNOT4nJoMMoQqFjCem7iinD4teAGwlI=;
    b=l49M3Aq+zqbNQ6IBXHO+OLTh9JQLyx56mVzw0k2VnTdzmY6CHo2e4Vk9BBoYXlb8P/
    gNI/HP3bMsW1Dw04AktwK5gKZoKvIo8JYGlFYqh0NOMkLQlSYW7X2MlYxh2yaDQnSfeW
    HzA2lGVCRBAcfI8lT5SE+0j6Y8S78a8xWmHIndr2qr02eyPT5mNhUKwFQ+ePga3lCqID
    kcljnttl7lwOjEpwVjAcFMzBiSuRNCWGZqgmv/Hv6KqL3vyFViLZWUb/SikaVKuwkYIx
    trcj8UFATYl7ISSX1ezQOD4T5QZqOpE8KFuxV/HLjYB0G8l5steQIYna6mXt+RsA3x5b
    tegw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlSeXA9h"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.24.3 DYNA|AUTH)
    with ESMTPSA id Q01a92x3LG5cSwq
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 21 Apr 2021 18:05:38 +0200 (CEST)
Subject: Re: [PATCH 4/4] MIPS: Avoid DIVU in `__div64_32' is result would be zero
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <alpine.DEB.2.21.2104200331110.44318@angie.orcam.me.uk>
Date:   Wed, 21 Apr 2021 18:05:37 +0200
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <284CBC37-0F4F-4077-A172-7E47C90B8B43@goldelico.com>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk> <alpine.DEB.2.21.2104200331110.44318@angie.orcam.me.uk>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> Am 20.04.2021 um 04:50 schrieb Maciej W. Rozycki <macro@orcam.me.uk>:
>=20
> We already check the high part of the divident against zero to avoid =
the=20

nit-picking: s/divident/dividend/

(seems to come from from Latin "dividendum" =3D the number that is to be =
divided).

> costly DIVU instruction in that case, needed to reduce the high part =
of=20
> the divident, so we may well check against the divisor instead and set=20=

> the high part of the quotient to zero right away.  We need to treat =
the=20
> high part the divident in that case though as the remainder that would=20=

> be calculated by the DIVU instruction we avoided.
>=20
> This has passed correctness verification with test_div64 and reduced =
the
> module's average execution time down to 1.0445s and 0.2619s from =
1.0668s
> and 0.2629s respectively for an R3400 CPU @40MHz and a 5Kc CPU =
@160MHz.

Impressive.

>=20
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> I have made an experimental change on top of this to put `__div64_32' =
out=20
> of line, and that increases the averages respectively up to 1.0785s =
and=20
> 0.2705s.  Not a terrible loss, especially compared to generic times =
quoted=20
> with 3/4, but still, so I think it would best be made where optimising =
for=20
> size, as noted in the cover letter.
> ---
> arch/mips/include/asm/div64.h |    6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> Index: linux-3maxp-div64/arch/mips/include/asm/div64.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-3maxp-div64.orig/arch/mips/include/asm/div64.h
> +++ linux-3maxp-div64/arch/mips/include/asm/div64.h
> @@ -68,9 +68,11 @@
> 									=
\
> 	__high =3D __div >> 32;						=
\
> 	__low =3D __div;							=
\
> -	__upper =3D __high;						=
\
> 									=
\
> -	if (__high) {							=
\
> +	if (__high < __radix) {						=
\
> +		__upper =3D __high;					=
\
> +		__high =3D 0;						=
\
> +	} else {							=
\
> 		__asm__("divu	$0, %z1, %z2"				=
\
> 		: "=3Dx" (__modquot)					=
\
> 		: "Jr" (__high), "Jr" (__radix));			=
\

