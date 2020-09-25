Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF95B278F01
	for <lists+linux-arch@lfdr.de>; Fri, 25 Sep 2020 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgIYQsE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Sep 2020 12:48:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:45354 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgIYQsD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Sep 2020 12:48:03 -0400
IronPort-SDR: IGBJdcdLHK/rkTvqrCAOZsnNpD0AbG+qAZydLzSFxtMZ3JRqv4O1cTSfoG4DkkgOPDOYtWQwZG
 PS+qlJ59cpAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="179657363"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="179657363"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 09:48:02 -0700
IronPort-SDR: XbYr2jPVpT1Wf6fIuRpAKebBnup6ZoThBmfiO9H5MEW0vAntBNX4+b0Tc3QLEpvPIPzUkLk/qB
 wcEFkVXs16qQ==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="336806828"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.213.161.229]) ([10.213.161.229])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 09:47:59 -0700
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
References: <20200925145804.5821-1-yu-cheng.yu@intel.com>
 <20200925145804.5821-9-yu-cheng.yu@intel.com>
 <CALCETrXs11c8ZcB2QdWUm5CeCXRm1wo706g5J9ajR8+6yYTgtQ@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <d0e4077e-129f-6823-dcea-a101ef626e8c@intel.com>
Date:   Fri, 25 Sep 2020 09:47:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXs11c8ZcB2QdWUm5CeCXRm1wo706g5J9ajR8+6yYTgtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/25/2020 9:31 AM, Andy Lutomirski wrote:
> On Fri, Sep 25, 2020 at 7:58 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>

[...]

>> @@ -286,6 +289,37 @@ bool emulate_vsyscall(unsigned long error_code,
>>          /* Emulate a ret instruction. */
>>          regs->ip = caller;
>>          regs->sp += 8;
>> +
>> +#ifdef CONFIG_X86_CET
>> +       if (tsk->thread.cet.shstk_size || tsk->thread.cet.ibt_enabled) {
>> +               struct cet_user_state *cet;
>> +               struct fpu *fpu;
>> +
>> +               fpu = &tsk->thread.fpu;
>> +               fpregs_lock();
>> +
>> +               if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
>> +                       copy_fpregs_to_fpstate(fpu);
>> +                       set_thread_flag(TIF_NEED_FPU_LOAD);
>> +               }
>> +
>> +               cet = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
>> +               if (!cet) {
>> +                       fpregs_unlock();
>> +                       goto sigsegv;
> 
> I *think* your patchset tries to keep cet.shstk_size and
> cet.ibt_enabled in sync with the MSR, in which case it should be
> impossible to get here, but a comment and a warning would be much
> better than a random sigsegv.

Yes, it should be impossible to get here.  I will add a comment and a 
warning, but still do sigsegv.  Should this happen, and the function 
return, the app gets a control-protection fault.  Why not let it fail early?

>
> Shouldn't we have a get_xsave_addr_or_allocate() that will never
> return NULL but instead will mark the state as in use and set up the
> init state if the feature was previously not in use?
> 

We already have a static __raw_xsave_addr(), which returns a pointer to 
the requested xstate.  Maybe we can export __raw_xsave_addr(), if that 
is needed.
