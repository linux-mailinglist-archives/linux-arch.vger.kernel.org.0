Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A187C379A6D
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 00:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhEJW7N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 18:59:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:14343 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhEJW7M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 May 2021 18:59:12 -0400
IronPort-SDR: 5CCxM31DrQ8NpRCc57zhv8RqDO51fL6JXRIul4MJVkw5VTUsKQCY8WFY9rtcImWpqRy2Aq/LHQ
 EakplwnAGuvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186440128"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="186440128"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 15:58:06 -0700
IronPort-SDR: QsXO/4wRx+z3mdOQUqRrWo77zUAK8pyl2+PvaaF/SdE5zZB8LiimPlTFQZZ4cYaXz9oRpRzdWf
 iJ15TiTGHg8g==
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="434014879"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.144.113]) ([10.251.144.113])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 15:58:00 -0700
Subject: Re: [PATCH v26 23/30] x86/cet/shstk: Handle thread shadow stack
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
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-24-yu-cheng.yu@intel.com> <YJlADyc/9pn8Sjkn@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <89598d32-4bf8-b989-ee77-5b4b55a138a9@intel.com>
Date:   Mon, 10 May 2021 15:57:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJlADyc/9pn8Sjkn@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/10/2021 7:15 AM, Borislav Petkov wrote:
> On Tue, Apr 27, 2021 at 01:43:08PM -0700, Yu-cheng Yu wrote:

[...]

>> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
>> index c815c7507830..d387df84b7f1 100644
>> --- a/arch/x86/kernel/shstk.c
>> +++ b/arch/x86/kernel/shstk.c
>> @@ -70,6 +70,55 @@ int shstk_setup(void)
>>   	return 0;
>>   }
> 
>> +int shstk_setup_thread(struct task_struct *tsk, unsigned long clone_flags,
> 
> Judging by what this function does, its name wants to be
> 
> shstk_alloc_thread_stack()
> 
> or so?
> 
>> +		       unsigned long stack_size)
>> +{
>> +	unsigned long addr, size;
>> +	struct cet_user_state *state;
>> +	struct cet_status *cet = &tsk->thread.cet;
> 
> The tip-tree preferred ordering of variable declarations at the
> beginning of a function is reverse fir tree order::
> 
> 	struct long_struct_name *descriptive_name;
> 	unsigned long foo, bar;
> 	unsigned int tmp;
> 	int ret;
> 
> The above is faster to parse than the reverse ordering::
> 
> 	int ret;
> 	unsigned int tmp;
> 	unsigned long foo, bar;
> 	struct long_struct_name *descriptive_name;
> 
> And even more so than random ordering::
> 
> 	unsigned long foo, bar;
> 	int ret;
> 	struct long_struct_name *descriptive_name;
> 	unsigned int tmp;
> 
>> +
>> +	if (!cet->shstk_size)
>> +		return 0;
>> +
> 
> This check needs a comment.
> 
>> +	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
>> +		return 0;
>> +
>> +	state = get_xsave_addr(&tsk->thread.fpu.state.xsave,
>> +			       XFEATURE_CET_USER);
> 
> Let that line stick out.
> 
>> +
>> +	if (!state)
>> +		return -EINVAL;
>> +
>> +	if (stack_size == 0)
> 
> 	if (!stack_size)
> 
>> +		return -EINVAL;
> 
> and that test needs to be done first in the function.
> 
>> +
>> +	/* Cap shadow stack size to 4 GB */
> 
> Why?
> 

This is not necessary.  I will make it just stack_size, which is passed 
in from copy_thread().

>> +	size = min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G);
>> +	size = min(size, stack_size);
>> +
>> +	/*
>> +	 * Compat-mode pthreads share a limited address space.
>> +	 * If each function call takes an average of four slots
>> +	 * stack space, allocate 1/4 of stack size for shadow stack.
>> +	 */
>> +	if (in_compat_syscall())
>> +		size /= 4;
> 
> <---- newline here.
> 
>> +	size = round_up(size, PAGE_SIZE);
>> +	addr = alloc_shstk(size);
>> +
> 
> ^ Superfluous newline.
> 
>> +	if (IS_ERR_VALUE(addr)) {
>> +		cet->shstk_base = 0;
>> +		cet->shstk_size = 0;
>> +		return PTR_ERR((void *)addr);
>> +	}
>> +
>> +	fpu__prepare_write(&tsk->thread.fpu);
>> +	state->user_ssp = (u64)(addr + size);
> 
> cet_user_state has u64, cet_status has unsigned longs. Make them all u64.
> 
> And since cet_status is per thread, but I had suggested struct
> shstk_desc, I think now that that should be called
> 
> struct thread_shstk
> 
> or so to denote *exactly* what it is.
> 

So this struct will be:

struct thread_shstk {
	u64 shstk_base;
	u64 shstk_size;
	u64 locked:1;
	u64 ibt:1;
};

Ok?

Thanks,
Yu-cheng
