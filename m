Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC4188C73
	for <lists+linux-arch@lfdr.de>; Tue, 17 Mar 2020 18:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgCQRsM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 13:48:12 -0400
Received: from foss.arm.com ([217.140.110.172]:41012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgCQRsM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 13:48:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8A3A31B;
        Tue, 17 Mar 2020 10:48:11 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2EB63F67D;
        Tue, 17 Mar 2020 10:48:08 -0700 (PDT)
Date:   Tue, 17 Mar 2020 17:48:06 +0000
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
Message-ID: <20200317174806.GE632169@arrakis.emea.arm.com>
References: <20200317122220.30393-1-vincenzo.frascino@arm.com>
 <20200317122220.30393-19-vincenzo.frascino@arm.com>
 <20200317143834.GC632169@arrakis.emea.arm.com>
 <f03a9493-c8c2-e981-f560-b2f437a208e4@arm.com>
 <20200317155031.GD632169@arrakis.emea.arm.com>
 <83aaf9e1-0a8f-4908-577a-23766541b2ba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83aaf9e1-0a8f-4908-577a-23766541b2ba@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 17, 2020 at 04:40:48PM +0000, Vincenzo Frascino wrote:
> On 3/17/20 3:50 PM, Catalin Marinas wrote:
> > On Tue, Mar 17, 2020 at 03:04:01PM +0000, Vincenzo Frascino wrote:
> >> On 3/17/20 2:38 PM, Catalin Marinas wrote:
> >>> On Tue, Mar 17, 2020 at 12:22:12PM +0000, Vincenzo Frascino wrote:
> >>
> >> Can TASK_SIZE > UINTPTR_MAX on an arm64 system?
> > 
> > TASK_SIZE yes on arm64 but not TASK_SIZE_32. I was asking about the
> > arm32 check where TASK_SIZE < UINTPTR_MAX. How does the vdsotest return
> > -EFAULT on arm32? Which code path causes this in the user vdso code?
> 
> Sorry I got confused because you referred to arch/arm/vdso/vgettimeofday.c which
> is the arm64 implementation, not the compat one :)

You figured out (in your subsequent reply) that I was indeed talking
about arm32 ;).

> In the case of arm32 everything is handled via syscall fallback.

So clock_gettime() on arm32 always falls back to the syscall?

> > My guess is that on arm32 it only fails with -EFAULT in the syscall
> > fallback path since a copy_to_user() would fail the access_ok() check.
> > Does it always take the fallback path if ts > TASK_SIZE?
> 
> Correct, it goes via fallback. The return codes for these syscalls are specified
> by the ABI [1]. Then I agree with you the way on which arm32 achieves it should
> be via access_ok() check.

"it should be" or "it is" on arm32?

If, on arm32, clock_gettime() is (would be?) handled in the vdso
entirely, who checks for the pointer outside the accessible address
space (as per the clock_gettime man page)?

I'm fine with such check as long as it is consistent across arm32 and
arm64 compat. Or even on arm64 native between syscall fallback and vdso
execution. I haven't figured out yet whether this is the case.

> >>> This last check needs an explanation. If the clock_id is invalid but res
> >>> is not NULL, we allow it. I don't see where the compatibility issue is,
> >>> arm32 doesn't have such check.
> >>
> >> The case that you are describing has to return -EPERM per ABI spec. This case
> >> has to return -EINVAL.
> >>
> >> The first case is taken care from the generic code. But if we don't do this
> >> check before on arm64 compat we end up returning the wrong error code.
> > 
> > I guess I have the same question as above. Where does the arm32 code
> > return -EINVAL for that case? Did it work correctly before you removed
> > the TASK_SIZE_32 check?
> 
> I repeated the test and seems that it was failing even before I removed
> TASK_SIZE_32. For reasons I can't explain I did not catch it before.
> 
> The getres syscall should return -EINVAL in the cases specified in [1].

It states 'clk_id specified is not supported on this system'. Fair
enough but it doesn't say that it returns -EINVAL only if res == NULL.
You also don't explain why __cvdso_clock_getres_time32() doesn't already
detect an invalid clk_id on arm64 compat (but does it on arm32).

-- 
Catalin
