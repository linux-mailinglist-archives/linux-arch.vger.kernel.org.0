Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D332F27B4F7
	for <lists+linux-arch@lfdr.de>; Mon, 28 Sep 2020 21:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgI1TEc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Sep 2020 15:04:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:27306 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgI1TEc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Sep 2020 15:04:32 -0400
IronPort-SDR: Db4LpqT5s5y8ANUINDsZFMGI8JsRKk2jHRGBHJHMD7qgLQeXcX/LgJ3Kv6VTmwxi8FKAS30X+B
 wmKEtlMnT87g==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="162104913"
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="162104913"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 12:04:27 -0700
IronPort-SDR: XmEAeOL/Im4mDpKC+6Gmdg8kzbb4nmZMIW/ZRA58CEKjr+/4kaCzRdQbwBHUEtZbZVXRnSYZiQ
 S9D+NDksRl4Q==
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="338299546"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.43.157]) ([10.212.43.157])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 12:04:25 -0700
Subject: Re: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and Indirect
 Branch Tracking for vsyscall emulation
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
References: <d0e4077e-129f-6823-dcea-a101ef626e8c@intel.com>
 <99B32E59-CFF2-4756-89BD-AEA0021F355F@amacapital.net>
 <d9099183dadde8fe675e1b10e589d13b0d46831f.camel@intel.com>
 <CALCETrWuhPE3A7eWC=ERJa7i7jLtsXnfu04PKUFJ-Gybro+p=Q@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <054bd574-1566-2be4-b542-884500b7319d@intel.com>
Date:   Mon, 28 Sep 2020 12:04:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWuhPE3A7eWC=ERJa7i7jLtsXnfu04PKUFJ-Gybro+p=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/28/2020 10:37 AM, Andy Lutomirski wrote:
> On Mon, Sep 28, 2020 at 9:59 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> On Fri, 2020-09-25 at 09:51 -0700, Andy Lutomirski wrote:
>>>> On Sep 25, 2020, at 9:48 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>> +
>> +               cet = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
>> +               if (!cet) {
>> +                       /*
>> +                        * This is an unlikely case where the task is
>> +                        * CET-enabled, but CET xstate is in INIT.
>> +                        */
>> +                       WARN_ONCE(1, "CET is enabled, but no xstates");
> 
> "unlikely" doesn't really cover this.
> 
>> +                       fpregs_unlock();
>> +                       goto sigsegv;
>> +               }
>> +
>> +               if (cet->user_ssp && ((cet->user_ssp + 8) < TASK_SIZE_MAX))
>> +                       cet->user_ssp += 8;
> 
> This looks buggy.  The condition should be "if SHSTK is on, then add 8
> to user_ssp".  If the result is noncanonical, then some appropriate
> exception should be generated, probably by the FPU restore code -- see
> below.  You should be checking the SHSTK_EN bit, not SSP.

The code now checks if shadow stack is on (yes, it should check SHSTK_EN 
bit, I will fix it.), then adds 8 to user_ssp.  If the result is 
canonical, then it sets the corresponding xstate.

If the resulting address is not canonical, the kernel does not know what 
the address should be either.  I think the best action to take is doing 
nothing about the shadow stack pointer, and let the application return 
and get a control protection fault.  The application should have not got 
into such situation in the first place; if it does, it should fault.

> 
> Also, can you point me to where any of these canonicality rules are
> documented in the SDM?  I looked and I can't find them.

The SDM is not very explicit.  It should have been.

> 
> This reminds me: this code in extable.c needs to change.
> 
> __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
>                                      struct pt_regs *regs, int trapnr,
>                                      unsigned long error_code,
>                                      unsigned long fault_addr)
> {
>          regs->ip = ex_fixup_addr(fixup);
> 
>          WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing
> FPU registers.",
>                    (void *)instruction_pointer(regs));
> 
>          __copy_kernel_to_fpregs(&init_fpstate, -1);
> 
> Now that we have supervisor states like CET, this is buggy.  This
> should do something intelligent like initializing all the *user* state
> and trying again.  If that succeeds, a signal should be sent rather
> than just corrupting the task.  And if it fails, then perhaps some
> actual intelligence is needed.  We certainly should not just disable
> CET because something is wrong with the CET MSRs.
> 

Yes, but it needs more thought.  Maybe a separate patch and more discussion?

Yu-cheng
