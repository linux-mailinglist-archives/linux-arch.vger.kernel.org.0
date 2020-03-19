Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E81F18BF18
	for <lists+linux-arch@lfdr.de>; Thu, 19 Mar 2020 19:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgCSSKM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Mar 2020 14:10:12 -0400
Received: from foss.arm.com ([217.140.110.172]:39886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSSKL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Mar 2020 14:10:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1FC730E;
        Thu, 19 Mar 2020 11:10:10 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5418C3F305;
        Thu, 19 Mar 2020 11:10:07 -0700 (PDT)
Date:   Thu, 19 Mar 2020 18:10:04 +0000
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
Message-ID: <20200319181004.GA29214@mbp>
References: <20200317122220.30393-1-vincenzo.frascino@arm.com>
 <20200317122220.30393-19-vincenzo.frascino@arm.com>
 <20200317143834.GC632169@arrakis.emea.arm.com>
 <f03a9493-c8c2-e981-f560-b2f437a208e4@arm.com>
 <20200317155031.GD632169@arrakis.emea.arm.com>
 <83aaf9e1-0a8f-4908-577a-23766541b2ba@arm.com>
 <20200317174806.GE632169@arrakis.emea.arm.com>
 <93cfe94a-c2a3-1025-bc9c-e7c3fd891100@arm.com>
 <20200318183603.GF94111@arrakis.emea.arm.com>
 <1bc25a53-7a59-0f60-ecf2-a3cace46b823@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bc25a53-7a59-0f60-ecf2-a3cace46b823@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vincenzo,

On Thu, Mar 19, 2020 at 12:38:42PM +0000, Vincenzo Frascino wrote:
> On 3/18/20 6:36 PM, Catalin Marinas wrote:
> > On Wed, Mar 18, 2020 at 04:14:26PM +0000, Vincenzo Frascino wrote:
> >> On 3/17/20 5:48 PM, Catalin Marinas wrote:
> >>> So clock_gettime() on arm32 always falls back to the syscall?
> >>
> >> This seems not what you asked, and I think I answered accordingly. Anyway, in
> >> the case of arm32 the error code path is handled via syscall fallback.
> >>
> >> Look at the code below as an example (I am using getres because I know this
> >> email will be already too long, and I do not want to add pointless code, but the
> >> concept is the same for gettime and the others):
> >>
> >> static __maybe_unused
> >> int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
> >> {
> >> 	int ret = __cvdso_clock_getres_common(clock, res);
> >>
> >> 	if (unlikely(ret))
> >> 		return clock_getres_fallback(clock, res);
> >> 	return 0;
> >> }
> >>
> >> When the return code of the "vdso" internal function returns an error the system
> >> call is triggered.
> > 
> > But when __cvdso_clock_getres_common() does *not* return an error, it
> > means that it handled the clock_getres() call without a fallback to the
> > syscall. I assume this is possible on arm32. When the clock_getres() is
> > handled directly (not as a syscall), why doesn't arm32 need the same
> > (res >= TASK_SIZE) check?
> 
> Ok, I see what you mean.

I'm not sure.

> It does not need to differ when __cvdso_clock_getres_common() does *not* return
> an error, we can move the checks in the fallback and leave the vdso code the
> same. The reason why I put the checks at the beginning of vdso code is because
> since I know such a condition it is going to fail I prefer to bailout
> immediately when it is detected instead of going through a bus error and a
> syscall before I can bailout.

I don't dispute your choice of choosing to bail out early, that's fine
by me. What I'm asking above, and you haven't answered, is why we don't
need exactly the same check on arm32. I.e.:

diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 1976c6f325a4..17ee5d211228 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -28,6 +28,9 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 int __vdso_clock_getres(clockid_t clock_id,
 			struct old_timespec32 *res)
 {
+	if ((u32)res >= TASK_SIZE)
+		return -EFAULT;
+
 	return __cvdso_clock_getres_time32(clock_id, res);
 }
 

(where arch/arm means arm32 ;)).

If the arm32 vdsotest passes, I'd like to know why.

> It is mainly a design choice based on what I explained above but I am open to
> suggestions if you have a better way to proceed.

I suggest just drop the TASK_SIZE_32 test altogether in this series to
get it merged for 5.7-rc1. We'll fix the ABI issues in -rc2/-rc3 once
you confirm that the test fully passes on arm32 when it doesn't fall
back to the syscall handling and we understood why.

> > Furthermore, my assumption is that __cvdso_clock_getres_common() should
> > handle this case already and we don't need it in the arch vdso code.
> > 
> 
> This is not the point I was trying to make, what I was trying to analyze here
> was the check compared to why the test verifies it, not the correctness of the
> check itself.

You should implement it based on what the man page defines, not some
specific test. Tests are rarely exhaustive (unless you do formal
modelling).

-- 
Catalin
