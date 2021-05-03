Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE300372143
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 22:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhECU0o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 16:26:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:1357 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhECU0n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 May 2021 16:26:43 -0400
IronPort-SDR: zmVTVZ7wQHoUYASfMcjgug3YRPRUOQoSaIHy1AbJSi5ngJvWfhmVQAMPPnchAyaf8l2lCJPqVF
 edkyx36mslIA==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="185300685"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="185300685"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 13:25:49 -0700
IronPort-SDR: j6W8Y+3CGbViGBD7u64rbmmAj2twhGDrTkWyR+4rqnaSG5yKCy1h1YedTyCLcYvHDTNJRSwYGH
 TRcfe9UbLFwQ==
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="468203041"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.140.183]) ([10.251.140.183])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 13:25:46 -0700
Subject: Re: extending ucontext (Re: [PATCH v26 25/30] x86/cet/shstk: Handle
 signals for shadow stack)
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
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
References: <782ffe96-b830-d13b-db80-5b60f41ccdbf@intel.com>
 <2D8926E4-F1B6-433A-96EA-995A66F3F42D@amacapital.net>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <c6abe0fd-3d2b-05bc-3835-848969b540c6@intel.com>
Date:   Mon, 3 May 2021 13:25:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <2D8926E4-F1B6-433A-96EA-995A66F3F42D@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/3/2021 8:29 AM, Andy Lutomirski wrote:
> 
>> On May 3, 2021, at 8:14 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>>
>> ﻿On 5/2/2021 4:23 PM, Andy Lutomirski wrote:
>>>> On Fri, Apr 30, 2021 at 10:47 AM Andy Lutomirski <luto@kernel.org> wrote:
>>>>
>>>> On Fri, Apr 30, 2021 at 10:00 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>>>>>
>>>>> On 4/28/2021 4:03 PM, Andy Lutomirski wrote:
>>>>>> On Tue, Apr 27, 2021 at 1:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>>>>>>
>>>>>>> When shadow stack is enabled, a task's shadow stack states must be saved
>>>>>>> along with the signal context and later restored in sigreturn.  However,
>>>>>>> currently there is no systematic facility for extending a signal context.
>>>>>>> There is some space left in the ucontext, but changing ucontext is likely
>>>>>>> to create compatibility issues and there is not enough space for further
>>>>>>> extensions.
>>>>>>>
>>>>>>> Introduce a signal context extension struct 'sc_ext', which is used to save
>>>>>>> shadow stack restore token address.  The extension is located above the fpu
>>>>>>> states, plus alignment.  The struct can be extended (such as the ibt's
>>>>>>> wait_endbr status to be introduced later), and sc_ext.total_size field
>>>>>>> keeps track of total size.
>>>>>>
>>>>>> I still don't like this.
>>>>>>
>>>>>> Here's how the signal layout works, for better or for worse:
>>>>>>
>>
>> [...]
>>
>>>>>>
>>>>>> That's where we are right now upstream.  The kernel has a parser for
>>>>>> the FPU state that is bugs piled upon bugs and is going to have to be
>>>>>> rewritten sometime soon.  On top of all this, we have two upcoming
>>>>>> features, both of which require different kinds of extensions:
>>>>>>
>>>>>> 1. AVX-512.  (Yeah, you thought this story was over a few years ago,
>>>>>> but no.  And AMX makes it worse.)  To make a long story short, we
>>>>>> promised user code many years ago that a signal frame fit in 2048
>>>>>> bytes with some room to spare.  With AVX-512 this is false.  With AMX
>>>>>> it's so wrong it's not even funny.  The only way out of the mess
>>>>>> anyone has come up with involves making the length of the FPU state
>>>>>> vary depending on which features are INIT, i.e. making it more compact
>>>>>> than "compact" mode is.  This has a side effect: it's no longer
>>>>>> possible to modify the state in place, because enabling a feature with
>>>>>> no space allocated will make the structure bigger, and the stack won't
>>>>>> have room.  Fortunately, one can relocate the entire FPU state, update
>>>>>> the pointer in mcontext, and the kernel will happily follow the
>>>>>> pointer.  So new code on a new kernel using a super-compact state
>>>>>> could expand the state by allocating new memory (on the heap? very
>>>>>> awkwardly on the stack?) and changing the pointer.  For all we know,
>>>>>> some code already fiddles with the pointer.  This is great, except
>>>>>> that your patch sticks more data at the end of the FPU block that no
>>>>>> one is expecting, and your sigreturn code follows that pointer, and
>>>>>> will read off into lala land.
>>>>>>
>>>>>
>>>>> Then, what about we don't do that at all.  Is it possible from now on we
>>>>> don't stick more data at the end, and take the relocating-fpu approach?
>>>>>
>>>>>> 2. CET.  CET wants us to find a few more bytes somewhere, and those
>>>>>> bytes logically belong in ucontext, and here we are.
>>>>>>
>>>>>
>>>>> Fortunately, we can spare CET the need of ucontext extension.  When the
>>>>> kernel handles sigreturn, the user-mode shadow stack pointer is right at
>>>>> the restore token.  There is no need to put that in ucontext.
>>>>
>>>> That seems entirely reasonable.  This might also avoid needing to
>>>> teach CRIU about CET at all.
>>> Wait, what's the actual shadow stack token format?  And is the token
>>> on the new stack or the old stack when sigaltstack is in use?  For
>>> that matter, is there any support for an alternate shadow stack for
>>> signals?
>>
>> The restore token is a pointer pointing directly above itself and bit[0] indicates 64-bit mode.
>>
>> Because the shadow stack stores only return addresses, there is no alternate shadow stack.  However, the application can allocate and switch to a new shadow stack.
> 
> I think we should make the ABI support an alternate shadow stack even if we don’t implement it initially. After all, some day someone might want to register a handler for shadow stack overflow.
> 

Agree.  We can probably add something in parallel of sigaltstack(), and 
let the user choose separately alternate normal/shadow stacks.

Thanks,
Yu-cheng
