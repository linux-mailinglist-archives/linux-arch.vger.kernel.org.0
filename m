Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3864725B8F1
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 04:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgICCyA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 22:54:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:36512 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgICCx6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Sep 2020 22:53:58 -0400
IronPort-SDR: XQWA3DQBk98GF3ACSAadTWXp96zAAP1DM3NGiJ+wP1rBH/UzP9MqlRCd3twdGLT0ljniCtJJJ3
 mE9qblWcfo1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="158496325"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="158496325"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 19:53:58 -0700
IronPort-SDR: kuo7JgczJbT83sHrpVfgqJG/Jqc0ewkrsV3LhjRM7Af8/qwMoGAWfgBC17ng+934Hve0sPN83A
 64xElWOhzhng==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="446740813"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.147.104]) ([10.209.147.104])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 19:53:56 -0700
Subject: Re: [PATCH v11 6/9] x86/cet: Add PTRACE interface for CET
To:     Jann Horn <jannh@google.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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
References: <20200825002645.3658-1-yu-cheng.yu@intel.com>
 <20200825002645.3658-7-yu-cheng.yu@intel.com>
 <CAG48ez21a_afHJrRQeweuHu8c+fxJ+VN1dezD18UOtZA5q-Shg@mail.gmail.com>
 <9be5356c-ec51-4541-89e5-05a1727a09a8@intel.com>
 <CAG48ez2_8BwG5xnwevniVODAM7oHWxGSY7zyg8gdKcWbzZ9YNQ@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <1d00a4ed-6f2e-bafd-3540-292e31f1685b@intel.com>
Date:   Wed, 2 Sep 2020 19:53:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2_8BwG5xnwevniVODAM7oHWxGSY7zyg8gdKcWbzZ9YNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/2/2020 5:33 PM, Jann Horn wrote:
> On Thu, Sep 3, 2020 at 12:13 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>> On 9/2/2020 1:03 PM, Jann Horn wrote:
>>> On Tue, Aug 25, 2020 at 2:30 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>>> Add REGSET_CET64/REGSET_CET32 to get/set CET MSRs:
>>>>
>>>>       IA32_U_CET (user-mode CET settings) and
>>>>       IA32_PL3_SSP (user-mode Shadow Stack)
>>> [...]
>>>> diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
>>> [...]
>>>> +int cetregs_get(struct task_struct *target, const struct user_regset *regset,
>>>> +               struct membuf to)
>>>> +{
>>>> +       struct fpu *fpu = &target->thread.fpu;
>>>> +       struct cet_user_state *cetregs;
>>>> +
>>>> +       if (!boot_cpu_has(X86_FEATURE_SHSTK))
>>>> +               return -ENODEV;
>>>> +
>>>> +       fpu__prepare_read(fpu);
>>>> +       cetregs = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
>>>> +       if (!cetregs)
>>>> +               return -EFAULT;
>>>
>>> Can this branch ever be hit without a kernel bug? If yes, I think
>>> -EFAULT is probably a weird error code to choose here. If no, this
>>> should probably use WARN_ON(). Same thing in cetregs_set().
>>>
>>
>> When a thread is not CET-enabled, its CET state does not exist.  I
>> looked at EFAULT, and it means "Bad address".  Maybe this can be ENODEV,
>> which means "No such device"?
> 
> Yeah, I guess ENODEV might fit reasonably well.
> 

I will update it.  Thanks!
