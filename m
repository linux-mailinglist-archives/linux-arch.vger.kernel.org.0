Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4885390490
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 17:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhEYPGs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 11:06:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:59785 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230328AbhEYPGn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 11:06:43 -0400
IronPort-SDR: hXHyP6KyFe3U7pgnfUaGTF74m/1IeJiG6ZJ4A3ZszbBTdDEcPmOuhvZvWrtzFA1GUkFly8and+
 KXuioAXVeI5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="199159594"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="199159594"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 08:04:47 -0700
IronPort-SDR: RuF2zL360uQQpbZacdqVD52FfknkoSoqg8+GcER8bysyyUM4dXtqcD7vEBnH5wl0vntn3KjQw8
 RjJ6I1ynDyYg==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="414061811"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.133.101]) ([10.209.133.101])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 08:04:44 -0700
Subject: Re: [PATCH v27 24/31] x86/cet/shstk: Handle thread shadow stack
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
 <20210521221211.29077-25-yu-cheng.yu@intel.com>
 <CALCETrVQ70VvZPf_tH5KOspYx6KwDg07dodzobBSABxMyc1xJw@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <bae19cd9-e1ff-3ce4-f2e5-a12f34beb090@intel.com>
Date:   Tue, 25 May 2021 08:04:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CALCETrVQ70VvZPf_tH5KOspYx6KwDg07dodzobBSABxMyc1xJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/22/2021 4:39 PM, Andy Lutomirski wrote:
> On Fri, May 21, 2021 at 3:14 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
>> index 5ea2b494e9f9..8e5f772181b9 100644
>> --- a/arch/x86/kernel/shstk.c
>> +++ b/arch/x86/kernel/shstk.c
>> @@ -71,6 +71,53 @@ int shstk_setup(void)
>>          return 0;
>>   }
>>
>> +int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
>> +                            unsigned long stack_size)
>> +{
> 
> ...
> 
>> +       state = get_xsave_addr(&tsk->thread.fpu.state.xsave, XFEATURE_CET_USER);
>> +       if (!state)
>> +               return -EINVAL;
>> +
> 
> The get_xsave_addr() API is horrible, and we already have one
> egregiously buggy instance in the kernel.  Let's not add another
> dubious use case.
> 
> If state == NULL, this means that CET_USER is in its init state.
> CET_USER in the init state should behave identically regardless of
> whether XINUSE[CET_USER] is set.  Can you please adjust this code
> accordingly?
> 

I will work on that.

Thanks,
Yu-cheng
