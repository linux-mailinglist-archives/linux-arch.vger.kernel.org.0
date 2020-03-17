Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26DE188973
	for <lists+linux-arch@lfdr.de>; Tue, 17 Mar 2020 16:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgCQPuh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 11:50:37 -0400
Received: from foss.arm.com ([217.140.110.172]:39878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgCQPuh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 11:50:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3B86FEC;
        Tue, 17 Mar 2020 08:50:36 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CECC83F7B4;
        Tue, 17 Mar 2020 08:50:33 -0700 (PDT)
Date:   Tue, 17 Mar 2020 15:50:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-mips@vger.kernel.org, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 18/26] arm64: vdso32: Replace TASK_SIZE_32 check in
 vgettimeofday
Message-ID: <20200317155031.GD632169@arrakis.emea.arm.com>
References: <20200317122220.30393-1-vincenzo.frascino@arm.com>
 <20200317122220.30393-19-vincenzo.frascino@arm.com>
 <20200317143834.GC632169@arrakis.emea.arm.com>
 <f03a9493-c8c2-e981-f560-b2f437a208e4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f03a9493-c8c2-e981-f560-b2f437a208e4@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 17, 2020 at 03:04:01PM +0000, Vincenzo Frascino wrote:
> On 3/17/20 2:38 PM, Catalin Marinas wrote:
> > On Tue, Mar 17, 2020 at 12:22:12PM +0000, Vincenzo Frascino wrote:
> >> diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
> >> index 54fc1c2ce93f..91138077b073 100644
> >> --- a/arch/arm64/kernel/vdso32/vgettimeofday.c
> >> +++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
> >> @@ -8,11 +8,14 @@
> >>  #include <linux/time.h>
> >>  #include <linux/types.h>
> >>  
> >> +#define VALID_CLOCK_ID(x) \
> >> +	((x >= 0) && (x < VDSO_BASES))
> >> +
> >>  int __vdso_clock_gettime(clockid_t clock,
> >>  			 struct old_timespec32 *ts)
> >>  {
> >>  	/* The checks below are required for ABI consistency with arm */
> >> -	if ((u32)ts >= TASK_SIZE_32)
> >> +	if ((u32)ts > UINTPTR_MAX - sizeof(*ts) + 1)
> >>  		return -EFAULT;
> >>  
> >>  	return __cvdso_clock_gettime32(clock, ts);
> > 
> > I probably miss something but I can't find the TASK_SIZE check in the
> > arch/arm/vdso/vgettimeofday.c code. Is this done elsewhere?
> 
> Can TASK_SIZE > UINTPTR_MAX on an arm64 system?

TASK_SIZE yes on arm64 but not TASK_SIZE_32. I was asking about the
arm32 check where TASK_SIZE < UINTPTR_MAX. How does the vdsotest return
-EFAULT on arm32? Which code path causes this in the user vdso code?

My guess is that on arm32 it only fails with -EFAULT in the syscall
fallback path since a copy_to_user() would fail the access_ok() check.
Does it always take the fallback path if ts > TASK_SIZE?

On arm64, while we have a similar access_ok() check, USER_DS is (1 <<
VA_BITS) even for compat tasks (52-bit maximum), so it doesn't detect
the end of the user address space for 32-bit tasks.

Is this an issue for other syscalls expecting EFAULT at UINTPTR_MAX and
instead getting a signal? The vdsotest seems to be the only one assuming
this. I don't have a simple solution here since USER_DS currently needs
to be a constant (used in entry.S).

I could as well argue that this is not a valid ABI test, no real-world
program relying on this behaviour ;).

> >> @@ -22,7 +25,7 @@ int __vdso_clock_gettime64(clockid_t clock,
> >>  			   struct __kernel_timespec *ts)
> >>  {
> >>  	/* The checks below are required for ABI consistency with arm */
> >> -	if ((u32)ts >= TASK_SIZE_32)
> >> +	if ((u32)ts > UINTPTR_MAX - sizeof(*ts) + 1)
> >>  		return -EFAULT;
> >>  
> >>  	return __cvdso_clock_gettime(clock, ts);
> >> @@ -38,9 +41,12 @@ int __vdso_clock_getres(clockid_t clock_id,
> >>  			struct old_timespec32 *res)
> >>  {
> >>  	/* The checks below are required for ABI consistency with arm */
> >> -	if ((u32)res >= TASK_SIZE_32)
> >> +	if ((u32)res > UINTPTR_MAX - sizeof(res) + 1)
> >>  		return -EFAULT;
> >>  
> >> +	if (!VALID_CLOCK_ID(clock_id) && res == NULL)
> >> +		return -EINVAL;
> > 
> > This last check needs an explanation. If the clock_id is invalid but res
> > is not NULL, we allow it. I don't see where the compatibility issue is,
> > arm32 doesn't have such check.
> 
> The case that you are describing has to return -EPERM per ABI spec. This case
> has to return -EINVAL.
> 
> The first case is taken care from the generic code. But if we don't do this
> check before on arm64 compat we end up returning the wrong error code.

I guess I have the same question as above. Where does the arm32 code
return -EINVAL for that case? Did it work correctly before you removed
the TASK_SIZE_32 check?

Sorry, just trying to figure out where the compatibility aspect is and
that we don't add some artificial checks only to satisfy a vdsotest case
that may or may not have relevance to any other user program.

-- 
Catalin
