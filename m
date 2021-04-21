Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA930366FA0
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 18:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbhDUQBW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Apr 2021 12:01:22 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:8178 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240399AbhDUQBV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Apr 2021 12:01:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1619020836; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GY31OMHAfxOgQ5MSqvtRPjan7JM7k9o/QCAWSPD/XzsFpM106CS3/FEtgNxP1tvVOs
    xOlahGr4AbYwgmpY/eIj8+0sRj6YGqdtuwJUUaO6WhEgWuRqBQYCmPtyEvIJrj1OAD90
    2++98YsqkMhfXkM/9ZqxGtsh49s+Uk4CWRe0E0QrNGzHCXTraZfBX/YtFIBqTzvFuUpX
    0FsSVWVsBrBzmRuj9I4mr0dT9srysUuC287SyIW+srxNL/ef0mYfrkoZAH4y45l9Copj
    rFQfIT4+o2ebB9cctbXPjxJe6gdAKwrRx/PX/DummtMAbgidYDOnrtL++vKVKTlCfYyy
    sFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1619020836;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=r4OO92Oeg3ScSSut97SNxzYQ47ACxnRLJOORI5ZDQ3A=;
    b=OsZoI+eliGLENqQTsEvidWaOtvkGbxkRjemUNYbhVD4k23KNV9tAh6fEmU31WHGGpi
    wpdWZeFWcoWA+/huNu6Ne7Uc/tuF2NYLWR3R6rZYFP7DaMnM1HvRyq+F/A/2ZuJB6p3i
    p7aNM57wsZQDWAhzfupDAQahhk6rKtikBIVH61GUYB6C4XnwBETBRErR+j+5YY6j/ehi
    8W8EusV9HZxmU5J9C7xZPan33Zrtjp0K5WTTFx7MsEZujXFw5qLLKoVHlSXgFNhKwhYM
    y1iktl+FDYdjD0nUDwTpBmzcl2H+cIFmyhALTsPOK3136fiVkJueJp/3kUJ2J4+vPMZH
    YJLQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1619020836;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=r4OO92Oeg3ScSSut97SNxzYQ47ACxnRLJOORI5ZDQ3A=;
    b=YN6CSLsj4H8OCV9Ziev9OIL5+k1qhc59WUdB2EPLftQT7HyU2uxL4i0NBd+bDniBUW
    snZwHIlQbgOVi/qTP1gXZKNIIB6AYUm4A2+RfeG6l3DzECxcXVuWAPqoH5QGksZcKKwI
    cmeVVw9iO+c0QwwzDMVMlT7WnJ9AGORTe9WsQYR7uNhbm3xWReeTf8wmPlO6EVlOdOdJ
    eC3e4P8vP52guDdk6J2MYPveGPdnERe9P2G1tUgEcX+B3ooVe40DYCeGp3XeU+vey6Gi
    vREA267U314Zz6UOtsz9RWXYbCwvIPSf1GUeCNKckB6wqYBA/krHjabWBx79LYagXeJX
    ACUw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlSeXA9h"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.24.3 DYNA|AUTH)
    with ESMTPSA id Q01a92x3LG0ZSuO
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 21 Apr 2021 18:00:35 +0200 (CEST)
Subject: Re: [PATCH 0/4] Reinstate and improve MIPS `do_div' implementation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk>
Date:   Wed, 21 Apr 2021 18:00:34 +0200
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <51BC7C74-68BF-4A8E-8CFB-DB4EBBC89706@goldelico.com>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

> Am 20.04.2021 um 04:50 schrieb Maciej W. Rozycki <macro@orcam.me.uk>:
> 
> Hi,
> 
> As Huacai has recently discovered the MIPS backend for `do_div' has been 
> broken and inadvertently disabled with commit c21004cd5b4c ("MIPS: Rewrite 
> <asm/div64.h> to work with gcc 4.4.0.").  As it is code I have originally 
> written myself and Huacai had issues bringing it back to life leading to a 
> request to discard it even I have decided to step in.
> 
> In the end I have fixed the code and measured its performance to be ~100% 
> better on average than our generic code.

That would be good.

>  I have decided it would be worth 
> having the test module I have prepared for correctness evaluation as well 
> as benchmarking, so I have included it with the series, also so that I can 
> refer to the results easily.
> 
> In the end I have included four patches on this occasion: 1/4 is the test 
> module, 2/4 is an inline documentation fix/clarification for the `do_div' 
> wrapper, 3/4 enables the MIPS `__div64_32' backend and 4/4 adds a small 
> performance improvement to it.

How can I apply them to the kernel? There is something wrong which makes
git am fail.

> 
> I have investigated a fifth change as a potential improvement where I 
> replaced the call to `do_div64_32' with a DIVU instruction for cases where 
> the high part of the intermediate divident is zero, but it has turned out 
> to regress performance a little, so I have discarded it.
> 
> Also a follow-up change might be worth having to reduce the code size and 
> place `__div64_32' out of line for CC_OPTIMIZE_FOR_SIZE configurations, 
> but I have not fully prepared such a change at this time.  I did use the 
> WIP form I have for performance evaluation however; see the figures quoted 
> with 4/4.
> 
> These changes have been verified with a DECstation system with an R3400 
> MIPS I processor @40MHz and a MTI Malta system with a 5Kc MIPS64 processor 
> @160MHz.

I'd like to test on ~320 MHz JZ4730.

> 
> See individual change descriptions and any additional discussions for
> further details.
> 
> Questions, comments or concerns?  Otherwise please apply.
> 
>  Maciej

BR and thanks,
Nikolaus Schaller
