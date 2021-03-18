Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324D5340DD4
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 20:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhCRTGV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 15:06:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:40804 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231590AbhCRTGA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Mar 2021 15:06:00 -0400
IronPort-SDR: xKOc06sQKVp6/FUGF8fGeXIx5jd4M5nHvgocyvCnyt5yP/Hf/oIGqfRgh4M0Iy98GPknM62ctr
 dEJvILz/Iv2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="189128303"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="189128303"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 12:06:00 -0700
IronPort-SDR: hqYeyuc91+tiTRuC7ikztwLhEgKS2tALLRwJSbZ64YO5K2tylKZBX7tsRUFeWimmlOPHqcL6yO
 P5Jcq/OKHeVg==
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="389358155"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.36.121]) ([10.209.36.121])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 12:05:58 -0700
Subject: Re: [PATCH v23 22/28] x86/cet/shstk: User-mode shadow stack support
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-23-yu-cheng.yu@intel.com>
 <20210318123215.GE19570@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <b05ee7eb-1b5d-f84f-c8f3-bfe9426e8a7d@intel.com>
Date:   Thu, 18 Mar 2021 12:05:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318123215.GE19570@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/18/2021 5:32 AM, Borislav Petkov wrote:
>> Subject: Re: [PATCH v23 22/28] x86/cet/shstk:   User-mode shadow stack support
> 						^
> 						Add
> 
> On Tue, Mar 16, 2021 at 08:10:48AM -0700, Yu-cheng Yu wrote:
>> Introduce basic shadow stack enabling/disabling/allocation routines.
>> A task's shadow stack is allocated from memory with VM_SHSTK flag and has
>> a fixed size of min(RLIMIT_STACK, 4GB).
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> ---
>>   arch/x86/include/asm/cet.h       |  28 ++++++
>>   arch/x86/include/asm/processor.h |   5 ++
>>   arch/x86/kernel/Makefile         |   2 +
>>   arch/x86/kernel/cet.c            | 147 +++++++++++++++++++++++++++++++

[...]

>> +void cet_free_shstk(struct task_struct *tsk)
>> +{
>> +	struct cet_status *cet = &tsk->thread.cet;
>> +
>> +	if (!static_cpu_has(X86_FEATURE_SHSTK) ||
> 
> cpu_feature_enabled and as above.
> 
>> +	    !cet->shstk_size || !cet->shstk_base)
>> +		return;
>> +
>> +	if (!tsk->mm || tsk->mm != current->mm)
>> +		return;
> 
> You're operating on current here merrily but what's protecting all those
> paths operating on current from getting current changed underneath them
> due to scheduling? IOW, is preemption safely disabled in all those
> paths ending up here?

Good thought.  Indeed, this looks like scheduling would bring some 
trouble.  However, when this instance is running, the current task must 
be current, context switch or not.  The purpose of this check is 
described below.

When fork() fails, it calls exit_thread(), then cet_free_shstk(). 
Normally the child tsk->mm != current->mm (parent).  There is no need to 
free shadow stack.

For CLONE_VM, however, the kernel has already allocated a shadow stack 
for the child and needs to free it because fork() failed.

Maybe I would add comments here.

> 
>> +
>> +	while (1) {
> 
> Uuh, an endless loop. What guarantees we'll exit it relatively timely...
> 
>> +		int r;
>> +
>> +		r = vm_munmap(cet->shstk_base, cet->shstk_size);
>> +
>> +		/*
>> +		 * Retry if mmap_lock is not available.
>> +		 */
>> +		if (r == -EINTR) {
>> +			cond_resched();
> 
> ... that thing?

If vm_munmap() returns -EINTR, mmap_lock is held by something else. 
That lock should not be held forever.  For other types of error, the 
loop stops.

> 
>> +			continue;
>> +		}
>> +
>> +		WARN_ON_ONCE(r);
>> +		break;
>> +	}
>> +
>> +	cet->shstk_base = 0;
>> +	cet->shstk_size = 0;
>> +}
>> -- 
>> 2.21.0
>>
> 

