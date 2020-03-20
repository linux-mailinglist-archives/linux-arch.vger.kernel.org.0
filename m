Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B11A18CFE5
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 15:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCTOWP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 10:22:15 -0400
Received: from foss.arm.com ([217.140.110.172]:49536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgCTOWP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Mar 2020 10:22:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 644CD1FB;
        Fri, 20 Mar 2020 07:22:14 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38BB73F792;
        Fri, 20 Mar 2020 07:22:11 -0700 (PDT)
Date:   Fri, 20 Mar 2020 14:22:08 +0000
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
Message-ID: <20200320142208.GC29214@mbp>
References: <20200317143834.GC632169@arrakis.emea.arm.com>
 <f03a9493-c8c2-e981-f560-b2f437a208e4@arm.com>
 <20200317155031.GD632169@arrakis.emea.arm.com>
 <83aaf9e1-0a8f-4908-577a-23766541b2ba@arm.com>
 <20200317174806.GE632169@arrakis.emea.arm.com>
 <93cfe94a-c2a3-1025-bc9c-e7c3fd891100@arm.com>
 <20200318183603.GF94111@arrakis.emea.arm.com>
 <1bc25a53-7a59-0f60-ecf2-a3cace46b823@arm.com>
 <20200319181004.GA29214@mbp>
 <b937d1eb-c7fd-e903-fa36-b261662bf40b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b937d1eb-c7fd-e903-fa36-b261662bf40b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 20, 2020 at 01:05:14PM +0000, Vincenzo Frascino wrote:
> On 3/19/20 6:10 PM, Catalin Marinas wrote:
> > On Thu, Mar 19, 2020 at 12:38:42PM +0000, Vincenzo Frascino wrote:
> >> On 3/18/20 6:36 PM, Catalin Marinas wrote:
> >>> On Wed, Mar 18, 2020 at 04:14:26PM +0000, Vincenzo Frascino wrote:
> >>>> On 3/17/20 5:48 PM, Catalin Marinas wrote:
> >>>>> So clock_gettime() on arm32 always falls back to the syscall?
> >>>>
> >>>> This seems not what you asked, and I think I answered accordingly. Anyway, in
> >>>> the case of arm32 the error code path is handled via syscall fallback.
> >>>>
> >>>> Look at the code below as an example (I am using getres because I know this
> >>>> email will be already too long, and I do not want to add pointless code, but the
> >>>> concept is the same for gettime and the others):
> >>>>
> >>>> static __maybe_unused
> >>>> int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
> >>>> {
> >>>> 	int ret = __cvdso_clock_getres_common(clock, res);
> >>>>
> >>>> 	if (unlikely(ret))
> >>>> 		return clock_getres_fallback(clock, res);
> >>>> 	return 0;
> >>>> }
> >>>>
> >>>> When the return code of the "vdso" internal function returns an error the system
> >>>> call is triggered.
> >>>
> >>> But when __cvdso_clock_getres_common() does *not* return an error, it
> >>> means that it handled the clock_getres() call without a fallback to the
> >>> syscall. I assume this is possible on arm32. When the clock_getres() is
> >>> handled directly (not as a syscall), why doesn't arm32 need the same
> >>> (res >= TASK_SIZE) check?
> >>
> >> Ok, I see what you mean.
> > 
> > I'm not sure.
> 
> Thank you for the long chat this morning. As we agreed I am going to repost the
> patches removing the checks discussed in this thread

Great, thanks.

> and we will address the syscall ABI difference subsequently with a
> different series.

Now I'm even less convinced we need any additional patches. The arm64
compat syscall would still return -EFAULT for res >= TASK_SIZE_32
because copy_to_user() will fail. So it would be entirely consistent
with the arm32 syscall. In the vdso-only case, both arm32 and arm64
compat would generate a signal.

As Will said, arguably, the syscall semantics may not be applicable to
the vdso implementation. But if you do want to get down this route (tp =
UINTPTR_MAX - sizeof(*tp) returning -EFAULT), please do it for all
architectures, not just arm64 compat. However, I'm not sure anyone
relies on this functionality, other than the vdsotest, so no real
application broken.

-- 
Catalin
