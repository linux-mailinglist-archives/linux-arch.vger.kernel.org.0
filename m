Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD62276311
	for <lists+linux-arch@lfdr.de>; Wed, 23 Sep 2020 23:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIWV31 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Sep 2020 17:29:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:57381 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgIWV31 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Sep 2020 17:29:27 -0400
IronPort-SDR: zpmA06NSuWrFEJULGCjs7v0U4tY3fZfH7sQsQQ+s5mlrUWvSLqOl+0y/ZKYeAORmytpmISww3w
 5fJ36uuRdcHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="158375537"
X-IronPort-AV: E=Sophos;i="5.77,295,1596524400"; 
   d="scan'208";a="158375537"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 14:29:27 -0700
IronPort-SDR: oG/dfcX9c8XEBHsFy+RgMu7uZo6ZO+S0IAC+V6fq3JjdHtLd9yuY9OIQq98sXgJkkBW5Ee18W0
 mA5hSNUsfgUg==
X-IronPort-AV: E=Sophos;i="5.77,295,1596524400"; 
   d="scan'208";a="511797445"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 14:29:26 -0700
Date:   Wed, 23 Sep 2020 14:29:25 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH v12 8/8] x86: Disallow vsyscall emulation when CET is
 enabled
Message-ID: <20200923212925.GC15101@linux.intel.com>
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
 <20200918192312.25978-9-yu-cheng.yu@intel.com>
 <CALCETrXfixDGJhf0yPw-OckjEdeF2SbYjWFm8VbLriiP0Krhrg@mail.gmail.com>
 <c96c98ec-d72a-81a3-06e2-2040f3ece33a@intel.com>
 <24718de58ab7bc6d7288c58d3567ad802eeb6542.camel@intel.com>
 <CALCETrWssUxxfhPPJZgPOmpaQcf4o9qCe1j-P7yiPyZVV+O8ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWssUxxfhPPJZgPOmpaQcf4o9qCe1j-P7yiPyZVV+O8ZQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 21, 2020 at 04:48:25PM -0700, Andy Lutomirski wrote:
> On Mon, Sep 21, 2020 at 3:37 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c
> > b/arch/x86/entry/vsyscall/vsyscall_64.c
> > index 44c33103a955..0131c9f7f9c5 100644
> > --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> > +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> > @@ -38,6 +38,9 @@
> >  #include <asm/fixmap.h>
> >  #include <asm/traps.h>
> >  #include <asm/paravirt.h>
> > +#include <asm/fpu/xstate.h>
> > +#include <asm/fpu/types.h>
> > +#include <asm/fpu/internal.h>
> >
> >  #define CREATE_TRACE_POINTS
> >  #include "vsyscall_trace.h"
> > @@ -286,6 +289,32 @@ bool emulate_vsyscall(unsigned long error_code,
> >         /* Emulate a ret instruction. */
> >         regs->ip = caller;
> >         regs->sp += 8;
> > +
> > +       if (current->thread.cet.shstk_size ||
> > +           current->thread.cet.ibt_enabled) {
> > +               u64 r;
> > +
> > +               fpregs_lock();
> > +               if (test_thread_flag(TIF_NEED_FPU_LOAD))
> > +                       __fpregs_load_activate();
> 
> Wouldn't this be nicer if you operated on the memory image, not the registers?
> 
> > +
> > +#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
> > +               /* Fixup branch tracking */
> > +               if (current->thread.cet.ibt_enabled) {
> > +                       rdmsrl(MSR_IA32_U_CET, r);
> > +                       wrmsrl(MSR_IA32_U_CET, r & ~CET_WAIT_ENDBR);
> > +               }
> > +#endif
> 
> Seems reasonable on first glance.
> 
> > +
> > +#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> > +               /* Unwind shadow stack. */
> > +               if (current->thread.cet.shstk_size) {
> > +                       rdmsrl(MSR_IA32_PL3_SSP, r);
> > +                       wrmsrl(MSR_IA32_PL3_SSP, r + 8);
> > +               }
> > +#endif
> 
> What happens if the result is noncanonical?  A quick skim of the SDM
> didn't find anything.  This latter issue goes away if you operate on
> the memory image, though -- writing a bogus value is just fine, since
> the FP restore will handle it.

#GP, the SSP MSRs do canonical checks.
