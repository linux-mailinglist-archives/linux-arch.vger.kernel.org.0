Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DA436854D
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 18:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhDVQzn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDVQzm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 12:55:42 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5F36C06174A;
        Thu, 22 Apr 2021 09:55:07 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8917892009C; Thu, 22 Apr 2021 18:55:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 82EC392009B;
        Thu, 22 Apr 2021 18:55:06 +0200 (CEST)
Date:   Thu, 22 Apr 2021 18:55:06 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-arch@vger.kernel.org,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 0/4] Reinstate and improve MIPS `do_div' implementation
In-Reply-To: <895956F9-4EBC-4C8A-9BF2-7E457E96C1D7@goldelico.com>
Message-ID: <alpine.DEB.2.21.2104221828200.44318@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk> <51BC7C74-68BF-4A8E-8CFB-DB4EBBC89706@goldelico.com> <alpine.DEB.2.21.2104211904490.44318@angie.orcam.me.uk> <E6326E8A-50DA-4F81-9865-F29EE0E298A9@goldelico.com>
 <2d636696-35f0-4731-b1c3-5445a57964fb@www.fastmail.com> <895956F9-4EBC-4C8A-9BF2-7E457E96C1D7@goldelico.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 22 Apr 2021, H. Nikolaus Schaller wrote:

> > This has passed correctness verification with test_div64 and reduced the
> > module's average execution time down to 1.0445s and 0.2619s from 1.0668s
> > and 0.2629s respectively for an R3400 CPU @40MHz and a 5Kc CPU @160MHz.
> 
> test only [PATCH 1/4 and 2/4]:
> 
> [  256.301140] test_div64: Completed 64bit/32bit division and modulo test, 0.291154944s elapsed
> 
> + [PATCH 3/4]
> 
> [ 1698.698920] test_div64: Completed 64bit/32bit division and modulo test, 0.132142865s elapsed
> 
> + [PATCH 4/4]
> 
> [  466.818349] test_div64: Completed 64bit/32bit division and modulo test, 0.134429075s elapsed
> 
> So the new code is indeed faster than the default implementation.
> [PATCH 4/4] has no significant influence (wouldn't say it is slower because timer resolution
> isn't very high on this machine and the kernel has some scheduling issue [1]).

 Have you used it as a module or at bootstrap?  I have noticed that at 
bootstrap the initialisation of the random number generator sometimes 
interferes with the benchmark, which happens when there's an intervening 
message produced, e.g.:

test_div64: Starting 64bit/32bit division and modulo test
random: fast init done
test_div64: Completed 64bit/32bit division and modulo test, 1.069906272s elapsed

I think it can be worked around by configuration changes so that more 
stuff is run between the RNG and the test module, but instead I have 
simply inserted:

	mdelay(5000);

at the beginning of `test_div64_init' instead, as for historical reasons I 
haven't got the systems involved set up for modules (beyond Linux 2.4) at 
this time.

 NB I have run the benchmark five times with each change and system and 
with the RNG taken out of the picture results were very stable as any 
fluctuation only started at the fifth decimal digit.  Both the DECstation 
(the model I used anyway) and the Malta have a high-resolution clock 
source though, the I/O ASIC free-running counter register at 25MHz (used 
by David L. Mills, the original author of the NTP suite, for his reference 
implementation) and the CP0 Count register at 80MHz respectively.

 I would expect your JZ4730 device to have the CP0 Count register as well, 
as it has been architectural ever since MIPS III really, or is your system 
SMP with CP0 Count registers out of sync across CPUs due to sleep modes or 
whatever?

 Thanks for sharing your figures.

> [1] we are preparing full support for the JZ4730 based Skytone Alpha machine. Most features
> are working except sound/I2S. I2C is a little unreliable and Ethernet has hickups. And scheduling
> which indicates some fundamental IRQ or timer issue we could not yet identify.

 Good luck with that!

  Maciej
