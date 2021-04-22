Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F15A367992
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 07:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhDVF5R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 01:57:17 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:27137 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhDVF5Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 01:57:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1619070821; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rPyMclrcyXjikgCizOTOKwmjWlDvJU8yNPd1WpjVxHE5FGC1ZZ9sRf8tREmuVOwOMQ
    5bO4oB+YqGGzTarvrJUtcmnz+ji7vaieRjQT3gbWWRaFL8mGca1/X0WL1RJTNukF3/BK
    5PzvHRYBCSsfLM80hTuJTWOM4wcrbgC9MU1UCcOiZnGvhcrH3RZN2ar4bH9B/+W+3gXC
    SbiZ1hAqHSEy7KQrApsMTTViYMsDKtkcDn4PKyHMatKplF2fedO2XshXSz//r35wp2gy
    HWESY1kGMKMukfxTby44T56ZwSTPgDjSGEgyQIfLIvQiwCUOcy4s5Yv2bs1Yyn3M+dJX
    C8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1619070821;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=FCcKJytuI9ww62Y/8WAyJgU7+PYDFqbFjjn+P8bSgEU=;
    b=R9QmisRz8IYq728FnS6Iy7pWC+rrDeukNtlTvD3jTVIvPm9WeNywRoe+XOWq+MBezj
    NYalcZ0ms3j/ntHwUFKPLOPFWE8+nZbhhqpGimxkt22MJ3p3Aw96KPt0oQIQpkPzc4Ht
    xVzrP9m5GoFvbu7VxLa/8r1tShk2fBraT0BGWij0cvUHLTNT6PBf3gHa4wxOI9bvCpJD
    3iiZst5hFqbaaCjmlTSnPlrm8HVBAYpDDsJctX88idurGwfxdRuGMcLlb2usXsBEgI72
    VAWyBaYi5GcnQPPrs+DxgsY9tjOOR9NfTKOLZbkXNWsLZMzO3TfGNi7n1R7qj43yQ8M2
    oWVA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1619070821;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=FCcKJytuI9ww62Y/8WAyJgU7+PYDFqbFjjn+P8bSgEU=;
    b=dY0oZNH9WAIYrJiNfv/n3aqOKW09h9Ne6kLERU5KWUrWRqMG+YbZpaOx+lwnh5U4TR
    wa+SC8pInV5twOSKOU1GWA8N/LFE4WaDI5dDrfeY4lyo7vVregH6r+wQksTQUa5Vn669
    VTM08GVT45AGXVOHQbuHS2vMHFYKwrgYCYqpYeZqK6JoB4mpj/HmvtmCslra/MF7zmm3
    vdOYdyOBMHFKTBUXKdx/KBcWdqJLZhThSr9Dghzrak7erD6H+XnVxTucO95eVTFc0KlA
    fVXoEXBEKLgo5WBziZ3iUytSCbJm0AOWcpLTKxYNA2LCXLPgkb1KfDCN9lQ9l9mFyEoM
    R5gw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMhw43rAaY="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.24.3 DYNA|AUTH)
    with ESMTPSA id Q01a92x3M5reUYg
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 22 Apr 2021 07:53:40 +0200 (CEST)
Subject: Re: [PATCH 0/4] Reinstate and improve MIPS `do_div' implementation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <alpine.DEB.2.21.2104211904490.44318@angie.orcam.me.uk>
Date:   Thu, 22 Apr 2021 07:53:39 +0200
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org,
        linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6326E8A-50DA-4F81-9865-F29EE0E298A9@goldelico.com>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk> <51BC7C74-68BF-4A8E-8CFB-DB4EBBC89706@goldelico.com> <alpine.DEB.2.21.2104211904490.44318@angie.orcam.me.uk>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

> Am 21.04.2021 um 21:04 schrieb Maciej W. Rozycki <macro@orcam.me.uk>:
>=20
> On Wed, 21 Apr 2021, H. Nikolaus Schaller wrote:
>=20
>>> In the end I have included four patches on this occasion: 1/4 is the =
test=20
>>> module, 2/4 is an inline documentation fix/clarification for the =
`do_div'=20
>>> wrapper, 3/4 enables the MIPS `__div64_32' backend and 4/4 adds a =
small=20
>>> performance improvement to it.
>>=20
>> How can I apply them to the kernel? There is something wrong which =
makes
>> git am fail.
>=20
> I don't know.  The changes were made against vanilla 5.12-rc7, but =
then=20
> the pieces affected have not changed for ages.  FWIW I can `git am' =
the=20
> series as received back just fine.

Please can you point me to some download/pull/gitweb? It seems as if the =
series
also did not appear at =
https://patchwork.kernel.org/project/linux-mips/list/

>=20
>>> These changes have been verified with a DECstation system with an =
R3400=20
>>> MIPS I processor @40MHz and a MTI Malta system with a 5Kc MIPS64 =
processor=20
>>> @160MHz.
>>=20
>> I'd like to test on ~320 MHz JZ4730.
>=20
> Sure, I'd love to hear how this code performs with other =
implementations. =20
>=20
>  Maciej

BR and thanks,
Nikolaus Schaller=
