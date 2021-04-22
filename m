Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E354536857C
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 19:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbhDVRHl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 13:07:41 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:8606 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbhDVRHf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 13:07:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1619111198; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=th4lh6hwjfD7YppPPMf+uOrTMTqW4GV7g/q6MkXuTBuzT2Ag2W3Blz5gLC6p4syMkN
    EfGCREYcYWlJ0SmQ+a15eHEsPJDdedE2R6mr4dU2sCcz/bGBgtMnmP1FjqVMCu847dC2
    pKJV2ccju9JKKGQ+Qncf6zLArqACuUt9bDvSGWLyoBEq0FxcG+0Ui1Yb0KMXidzEc8Qr
    p9NGBDKg24hbGCvvPAzHofhX8Npuq33qjuDyyfd/GKiye8UreN99E2ZILBbC1itQSuQm
    mriQWqVpQ0nDn47PJl5eUUAxJLDdliOPefkf5B2DGDdCDnrbZgxpE7+FnaSetg6jtwIn
    bbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1619111198;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=RZEhjPMTimtcOAMcX8JWlzvK+WjQDhgXOxbfImygjNU=;
    b=n+DFXBaRckaQUdmzb3uQ08PlykCEMLb0ZALFV/3JMJZRoZEPRTJaE3yF/SFfj8IcVr
    Wek2q08FUZOncZDrQpsKNCDo4SpKDQcOO9R4Io9MTLmlqbiyYKim0XVrgpIPWA9Xz81P
    MFmme/ZdVZ+xFxkhC85OhzJWNuSIURS3I5oYG69tKCOOEKjAAA3748ffW7Oapk2wocSp
    m3bcAiIZtgVoquDB0iq415dNVgvwbsvtWX+sf90Kl7Dp41/vK4Y6IJOgJHSo8M+x/jjn
    rGFfCvHHTCaC8Huz0A2Ke25UTkQnEhA4YQhX0MYbycgNShsfb3/EjenqOXNO0sSg2V+D
    BPyg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1619111198;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=RZEhjPMTimtcOAMcX8JWlzvK+WjQDhgXOxbfImygjNU=;
    b=n0iAFzbgPDMjLR1aswEeJsNWnXIRPDy7g2B3x23bgPhNwVFWRCemigEJ05HIUONGqU
    J2vhu/v4qeFy1Ol1mRizPpo3O3zdyG4WKOau2E8GR9XsI6saj+m7VAwZyW1uXsRMerdk
    C+sMBB9ibnqPhtUZ3UBr8YSMOWtNCHgS//6e7OFFJ96uRiiFMPIEGMG5DNCOWp1aZCAK
    JrApMuHtuaK/iQdWVnk2ZIoCBQRsAls52W7orMXt43xkrQlW8RD6sln6fBbgUkOje41i
    SNYrr4+5Sk+QnzFdUDzEe4fuPuwuJ2Nb+pd/FbRU/XQvJi9VLVd2JfV6VYlYpjd0SJic
    vPew==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dCylX7xo8GB7++2Zda3a+jmqyM0co2qg7zyOUbI="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:2600:e600:a8e1:bb4:fe1c:cea8]
    by smtp.strato.de (RZmta 47.24.3 AUTH)
    with ESMTPSA id Q01a92x3MH6bYOb
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 22 Apr 2021 19:06:37 +0200 (CEST)
Subject: Re: [PATCH 0/4] Reinstate and improve MIPS `do_div' implementation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <alpine.DEB.2.21.2104221828200.44318@angie.orcam.me.uk>
Date:   Thu, 22 Apr 2021 19:06:36 +0200
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-arch@vger.kernel.org,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Lubomir Rintel <lkundrak@v3.sk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8FCB8F58-7F0A-4A9E-8BEA-7CCF09A43B63@goldelico.com>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk> <51BC7C74-68BF-4A8E-8CFB-DB4EBBC89706@goldelico.com> <alpine.DEB.2.21.2104211904490.44318@angie.orcam.me.uk> <E6326E8A-50DA-4F81-9865-F29EE0E298A9@goldelico.com> <2d636696-35f0-4731-b1c3-5445a57964fb@www.fastmail.com> <895956F9-4EBC-4C8A-9BF2-7E457E96C1D7@goldelico.com> <alpine.DEB.2.21.2104221828200.44318@angie.orcam.me.uk>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> Am 22.04.2021 um 18:55 schrieb Maciej W. Rozycki <macro@orcam.me.uk>:
>=20
>=20
> Have you used it as a module or at bootstrap?

I did load it by insmod.

> I would expect your JZ4730 device to have the CP0 Count register as =
well,=20
> as it has been architectural ever since MIPS III really, or is your =
system=20
> SMP with CP0 Count registers out of sync across CPUs due to sleep =
modes or=20
> whatever?

It switches clocksource to some operating system timers on the SoC which
may have an influence on the resolution (or precision).

> Thanks for sharing your figures.

It was a pleasure towards better MIPS support...

>=20
>> [1] we are preparing full support for the JZ4730 based Skytone Alpha =
machine. Most features
>> are working except sound/I2S. I2C is a little unreliable and Ethernet =
has hickups. And scheduling
>> which indicates some fundamental IRQ or timer issue we could not yet =
identify.
>=20
> Good luck with that!

BR and thanks,
Niklaus

