Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C441F64387
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2019 10:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGJI16 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jul 2019 04:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfGJI16 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jul 2019 04:27:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0AF220651;
        Wed, 10 Jul 2019 08:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562747277;
        bh=KtzVii5P4LP//T6JpRtFhPSLRcL9TdMNzIFDUtImHus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qR49111kqThrC5A5mX+wugORt3GbwDStFhBcJX2gaNEdewA1aeZQ1JHwfhfJRyEZK
         tP50l2WhV6CKmi0jDYoZDp03A/a2GGDPZ0TDqPIHnG8nKkh0cxtTkyqwBgSc5M6Stb
         HRi5PNHjkG0VLqCovtd7C3IHEy0mjXsQq4BaXhOU=
Date:   Wed, 10 Jul 2019 09:27:50 +0100
From:   Will Deacon <will@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huw Davies <huw@codeweavers.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Burton <paul.burton@mips.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shijith Thotton <sthotton@marvell.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v7 10/25] arm64: compat: Add vDSO
Message-ID: <20190710082750.mvm3e6myzpqsurga@willie-the-truck>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-11-vincenzo.frascino@arm.com>
 <CALAqxLXxE5B+vVLj7NcW8S05nhDQ+XSKVn=_MNDci667JDFEhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLXxE5B+vVLj7NcW8S05nhDQ+XSKVn=_MNDci667JDFEhA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi John,

On Tue, Jul 09, 2019 at 09:02:54PM -0700, John Stultz wrote:
> On Fri, Jun 21, 2019 at 3:18 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> >
> > Provide the arm64 compat (AArch32) vDSO in kernel/vdso32 in a similar
> > way to what happens in kernel/vdso.
> >
> > The compat vDSO leverages on an adaptation of the arm architecture code
> > with few changes:
> >  - Use of lib/vdso for gettimeofday
> >  - Implementation of syscall based fallback
> >  - Introduction of clock_getres for the compat library
> >  - Implementation of trampolines
> >  - Implementation of elf note
> >
> > To build the compat vDSO a 32 bit compiler is required and needs to be
> > specified via CONFIG_CROSS_COMPILE_COMPAT_VDSO.
> >
> 
> Hey Vincenzo!
>   Congrats on getting this work merged, I know its been a long effort
> over a number of years!
> 
> Though unfortunately, it seems the arm64 vdso code that just landed is
> breaking AOSP for me.
> 
> I see a lot of the following errors:
> 01-01 01:22:14.097   755   755 F libc    : Fatal signal 11 (SIGSEGV),
> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 755 (cameraserver),
> pid 755 (cameraserver)
> 01-01 01:22:14.112   759   759 F libc    : Fatal signal 11 (SIGSEGV),
> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 759
> (android.hardwar), pid 759 (android.hardwar)
> 01-01 01:22:14.120   756   756 F libc    : Fatal signal 11 (SIGSEGV),
> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 756 (drmserver),
> pid 756 (drmserver)
> 
> Which go away if I revert the vdso merge that went in via tip/timers.
> 
> I tried to bisect things down a bit, but as some later fixes are
> required (at one point, date was returning the start epoch and never
> increasing), this hasn't worked too well. But I'm guessing since I
> see: "CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will
> not be built", and the system is half working, I'm guessing this is an
> issue with just the 32bit code failing.  While I can try to sort out
> the proper CROSS_COMPILE_COMPAT in my build environment, I assume
> userland shouldn't be crashing if that value isn't set.
> 
> Any chance this issue has already been raised?

First I've seen of it, although Vincenzo is likely to know better than me.
In the meantime, please can you share your .config?

Thanks,

Will
