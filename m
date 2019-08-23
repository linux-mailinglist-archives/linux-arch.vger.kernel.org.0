Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206C89AD66
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 12:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbfHWKhG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 06:37:06 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58082 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbfHWKhG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Aug 2019 06:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B9eC/SwMJI5wiLehGZuNUOPWsE6j+AyjN0GvMo8gtyU=; b=T1iJyU/i9x2rnee8Nc30yXEbn
        b4M1dmKyjCguakhSrpU6MivpFpuJOVelgMwGVtVrc0kQk+Hujc/VPcjZXH6p6H4qK2UstUU/s5Ojl
        KG1E3U5ZmdRmtaKye78/jJ4qBiRNQDLbBEx8DjhZPZH1agfp9dS+ELhAKPkv2JRaMAs23qkMfDue2
        3oCcXrTBDHVlWrG03tpnxvSj6M0V5Y+Eejd6ESfr4xcfTqq4BFLnzOUQ+2zTshQjY8jsVJFTwEfFv
        JRvrFRvWPmpDWIxaZJ9scQddSdG65ZJXIUZXlj9/saC4dQaWXcDib7fX+7jWsuvq6PWLJF+E+x4Na
        gjBirzRPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60050)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i16wF-00045J-L4; Fri, 23 Aug 2019 11:36:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i16wA-00009v-LB; Fri, 23 Aug 2019 11:36:54 +0100
Date:   Fri, 23 Aug 2019 11:36:54 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        shuah@kernel.org, sthotton@marvell.com, andre.przywara@arm.com,
        arnd@arndb.de, salyzyn@android.com, huw@codeweavers.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        will.deacon@arm.com, linux-mips@vger.kernel.org,
        ralf@linux-mips.org, 0x7f454c46@gmail.com, paul.burton@mips.com,
        linux-kselftest@vger.kernel.org, linux@rasmusvillemoes.dk,
        tglx@linutronix.de, vincenzo.frascino@arm.com, pcc@google.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Regression in 5.3-rc1 and later
Message-ID: <20190823103654.GX13294@shell.armlinux.org.uk>
References: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

To everyone on the long Cc list...

What's happening with this?  I was about to merge the patches for 32-bit
ARM, which I don't want to do if doing so will cause this regression on
32-bit ARM as well.

Thanks.

On Thu, Aug 22, 2019 at 07:57:59AM +0100, Chris Clayton wrote:
> Hi everyone,
> 
> Firstly, apologies to anyone on the long cc list that turns out not to be particularly interested in the following, but
> you were all marked as cc'd in the commit message below.
> 
> I've found a problem that isn't present in 5.2 series or 4.19 series kernels, and seems to have arrived in 5.3-rc1. The
> problem is that if I suspend (to ram) my laptop, on resume 14 minutes or more after suspending, I have no networking
> functionality. If I resume the laptop after 13 minutes or less, networking works fine. I haven't tried to get finer
> grained timings between 13 and 14 minutes, but can do if it would help.
> 
> ifconfig shows that wlan0 is still up and still has its assigned ip address but, for instance, a ping of any other
> device on my network, fails as does pinging, say, kernel.org. I've tried "downing" the network with (/sbin/ifdown) and
> unloading the iwlmvm module and then reloading the module and "upping" (/sbin/ifup) the network, but my network is still
> unusable. I should add that the problem also manifests if I hibernate the laptop, although my testing of this has been
> minimal. I can do more if required.
> 
> As I say, the problem first appears in 5.3-rc1, so I've bisected between 5.2.0 and 5.3-rc1 and that concluded with:
> 
> [chris:~/kernel/linux]$ git bisect good
> 7ac8707479886c75f353bfb6a8273f423cfccb23 is the first bad commit
> commit 7ac8707479886c75f353bfb6a8273f423cfccb23
> Author: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Date:   Fri Jun 21 10:52:49 2019 +0100
> 
>     x86/vdso: Switch to generic vDSO implementation
> 
>     The x86 vDSO library requires some adaptations to take advantage of the
>     newly introduced generic vDSO library.
> 
>     Introduce the following changes:
>      - Modification of vdso.c to be compliant with the common vdso datapage
>      - Use of lib/vdso for gettimeofday
> 
>     [ tglx: Massaged changelog and cleaned up the function signature formatting ]
> 
>     Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Cc: linux-arch@vger.kernel.org
>     Cc: linux-arm-kernel@lists.infradead.org
>     Cc: linux-mips@vger.kernel.org
>     Cc: linux-kselftest@vger.kernel.org
>     Cc: Catalin Marinas <catalin.marinas@arm.com>
>     Cc: Will Deacon <will.deacon@arm.com>
>     Cc: Arnd Bergmann <arnd@arndb.de>
>     Cc: Russell King <linux@armlinux.org.uk>
>     Cc: Ralf Baechle <ralf@linux-mips.org>
>     Cc: Paul Burton <paul.burton@mips.com>
>     Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>     Cc: Mark Salyzyn <salyzyn@android.com>
>     Cc: Peter Collingbourne <pcc@google.com>
>     Cc: Shuah Khan <shuah@kernel.org>
>     Cc: Dmitry Safonov <0x7f454c46@gmail.com>
>     Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>     Cc: Huw Davies <huw@codeweavers.com>
>     Cc: Shijith Thotton <sthotton@marvell.com>
>     Cc: Andre Przywara <andre.przywara@arm.com>
>     Link: https://lkml.kernel.org/r/20190621095252.32307-23-vincenzo.frascino@arm.com
> 
>  arch/x86/Kconfig                         |   3 +
>  arch/x86/entry/vdso/Makefile             |   9 ++
>  arch/x86/entry/vdso/vclock_gettime.c     | 245 ++++---------------------------
>  arch/x86/entry/vdso/vdsox32.lds.S        |   1 +
>  arch/x86/entry/vsyscall/Makefile         |   2 -
>  arch/x86/entry/vsyscall/vsyscall_gtod.c  |  83 -----------
>  arch/x86/include/asm/pvclock.h           |   2 +-
>  arch/x86/include/asm/vdso/gettimeofday.h | 191 ++++++++++++++++++++++++
>  arch/x86/include/asm/vdso/vsyscall.h     |  44 ++++++
>  arch/x86/include/asm/vgtod.h             |  75 +---------
>  arch/x86/include/asm/vvar.h              |   7 +-
>  arch/x86/kernel/pvclock.c                |   1 +
>  12 files changed, 284 insertions(+), 379 deletions(-)
>  delete mode 100644 arch/x86/entry/vsyscall/vsyscall_gtod.c
>  create mode 100644 arch/x86/include/asm/vdso/gettimeofday.h
>  create mode 100644 arch/x86/include/asm/vdso/vsyscall.h
> 
> To confirm my bisection was correct, I did a git checkout of 7ac8707479886c75f353bfb6a8273f423cfccb2. As expected, the
> kernel exhibited the problem I've described. However, a kernel built at the immediately preceding (parent?) commit
> (bfe801ebe84f42b4666d3f0adde90f504d56e35b) has a working network after a (>= 14minute) suspend/resume cycle.
> 
> As the module name implies, I'm using wireless networking. The hardware is detected as "Intel(R) Wireless-AC 9260
> 160MHz, REV=0x324" by iwlwifi.
> 
> I'm more than happy to provide additional diagnostics (but may need a little hand-holding) and to apply diagnostic or
> fix patches, but please cc me on any reply as I'm not subscribed to any of the kernel-related mailing lists.
> 
> Chris
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
