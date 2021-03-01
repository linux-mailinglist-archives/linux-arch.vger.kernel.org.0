Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B122A328BD3
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 19:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhCASjm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 13:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240156AbhCASg1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 13:36:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70A9964E83;
        Mon,  1 Mar 2021 17:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614620125;
        bh=21ajb7RL24sMUQlOTeS5tC0PZRuFySmPWuPvKCCEiqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrWMdDUaBd2/wZVxXY+25zmlBBaAGP5mlFmV5XFGa4qGXiBuhOSKkz3SBxkrER9q7
         JvEVgqrE2oFAbSNODVg7WU/CvXcR2ee2dl99HrYL4yfy5Dd/Ww+kK/A7s6QvCuwcot
         2+WZ8nrqj5HChHx6EERixfkhC6EZ3PSChb/4FRcVTJT7B/lJjnr7IQohsE22/CdB9X
         rkKkg25WJB57MMT83Ga2ctzwQXLej3ET1ODt+l9IfyjYDRiJ2rtg663RN9zVE1yjlF
         jFoPQk+1ZZ32uKfzCFQE4iw2n+cdxLeNXPB08LnnvDpUXs3jiMvJFvvpX/sJyb132d
         +eSdyDf2/0HDg==
Date:   Mon, 1 Mar 2021 09:35:25 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 12/11] pragma once: scripted treewide conversion
Message-ID: <20210301173525.GF7272@magnolia>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
 <YDvO2kmidKZaK26j@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDvO2kmidKZaK26j@localhost.localdomain>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 28, 2021 at 08:11:54PM +0300, Alexey Dobriyan wrote:
> [  Bcc a lot of lists so that people understand what's this is all         ]
> [  about without creating uber-cc-thread.                                  ]
> [  Apologies if I missed your subsystem                                    ]
> [  Please see [PATCH 11/11: pragma once: conversion script (in Python 2)]  ]
> 
> Hi, Linus.
> 
> Please run the script below from top-level directory, it will convert
> most kernel headers to #pragma once directive advancing them into
> 21-st century.
> 
> The advantages are:
> 
> * less LOC
> 
> 	18087 files changed, 18878 insertions(+), 99804 deletions(-)
> 	= -81 kLOC (give or take)
> 
> * less mental tax on developers forced to name things which aren't even
>   real code

I don't find include guards to be much of a mental tax, but it sure
would be nice to see exactly what the changes would look like...

> * less junk in preprocessor hashtables and editors/IDEs autocompletion
>   lists
> 
> There are two bit exceptions: UAPI headers and ACPICA.
> Given ubiquity of #pragma once, I personally think even these subsystems
> should be converted in the future.
> 
> Compile tested on alpha, arc, arm, arm64, h8300, ia64, m68k, microblaze,
> mips, nios2, parisc, powerpc, riscv, s390, sh, sparc, um-i386, um-x86_64,
> i386, x86_64, xtensa (allnoconfig, all defconfigs, allmodconfig with or
> without SMP/DEBUG_KERNEL + misc stuff).
> 
> Not compile tested on csky, hexagon, nds32, openrisc. 
> 
> Love,
> 	Alexey
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> 
> 
> #!/bin/sh -x
> find . -type f -name '*.h' -print	|\
> LC_ALL=C sort				|\
> sed -e 's#^./##g'			|\
> xargs ./scripts/pragma-once.py

...because I can't find this script in upstream git, so I can't really
tell for myself what the changes to xfs would look like.  The thing I
need to know is, what will changes to fs/xfs/libxfs/ look like when we
port that to userspace?

Does this introduce any minimum compiler version requirements?

--D

> 
> find . -type d -name 'uapi' | xargs git checkout -f
> git checkout -f arch/alpha/include/asm/cmpxchg.h
> git checkout -f arch/arm/mach-imx/hardware.h
> git checkout -f arch/arm/mach-ixp4xx/include/mach/hardware.h
> git checkout -f arch/arm/mach-sa1100/include/mach/hardware.h
> git checkout -f arch/mips/include/asm/mips-cps.h
> git checkout -f arch/x86/boot/boot.h
> git checkout -f arch/x86/boot/ctype.h
> git checkout -f arch/x86/include/asm/cpufeatures.h
> git checkout -f arch/x86/include/asm/disabled-features.h
> git checkout -f arch/x86/include/asm/required-features.h
> git checkout -f arch/x86/include/asm/vmxfeatures.h
> git checkout -f arch/x86/include/asm/vvar.h
> git checkout -f drivers/acpi/acpica/
> git checkout -f drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h
> git checkout -f drivers/gpu/drm/amd/pm/powerplay/ppsmc.h
> git checkout -f drivers/input/misc/yealink.h
> git checkout -f drivers/media/usb/dvb-usb-v2/mxl111sf-demod.h
> git checkout -f drivers/media/usb/dvb-usb-v2/mxl111sf-tuner.h
> git checkout -f drivers/pcmcia/yenta_socket.h
> git checkout -f drivers/staging/rtl8723bs/include/hal_com_h2c.h
> git checkout -f include/linux/acpi.h
> git checkout -f include/linux/bitops.h
> git checkout -f include/linux/compiler_types.h
> git checkout -f include/linux/device.h
> git checkout -f include/linux/kbuild.h
> git checkout -f include/linux/libfdt_env.h
> git checkout -f include/linux/local_lock.h
> git checkout -f include/linux/spinlock.h
> git checkout -f include/linux/spinlock_api_smp.h
> git checkout -f include/linux/spinlock_types.h
> git checkout -f include/linux/tracepoint.h
> git checkout -f mm/gup_test.h
> git checkout -f net/batman-adv/main.h
> git checkout -f scripts/dtc/
> git checkout -f tools/include/linux/bitops.h
> git checkout -f tools/include/linux/compiler.h
> git checkout -f tools/testing/selftests/clone3/clone3_selftests.h
> git checkout -f tools/testing/selftests/futex/include/atomic.h
> git checkout -f tools/testing/selftests/futex/include/futextest.h
> git checkout -f tools/testing/selftests/futex/include/logging.h
> git checkout -f tools/testing/selftests/kselftest.h
> git checkout -f tools/testing/selftests/kselftest_harness.h
> git checkout -f tools/testing/selftests/pidfd/pidfd.h
> git checkout -f tools/testing/selftests/x86/helpers.h
