Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7463035A954
	for <lists+linux-arch@lfdr.de>; Sat, 10 Apr 2021 01:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhDIXrk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 19:47:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:14587 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235163AbhDIXri (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Apr 2021 19:47:38 -0400
IronPort-SDR: 4oTMDTbu7ghJ1nVn9+6esl52exZ5ABLXB5jtEzUzErDqkWILSfvJN+EykT59fT/hvgMMspsEND
 ugC34gjrjVgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="255190796"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="255190796"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 16:47:23 -0700
IronPort-SDR: 7kkS8Wxc9BTdMnvBz67vi/4ovTt7qmo8Sx/XhHsJNzLbHt5HqfH+DEzabiA6I67db98dmOCI/G
 QyDmN3Xu1ijQ==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="416470774"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.27.140]) ([10.212.27.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 16:47:22 -0700
Subject: Re: [PATCH v24 22/30] x86/cet/shstk: Add user-mode shadow stack
 support
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-23-yu-cheng.yu@intel.com>
 <20210409155711.kxf3fjc7csvqpl33@box.shutemov.name>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <d1fc2f06-b6ad-f780-72c0-cf7ec6633a30@intel.com>
Date:   Fri, 9 Apr 2021 16:47:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210409155711.kxf3fjc7csvqpl33@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/9/2021 8:57 AM, Kirill A. Shutemov wrote:
> On Thu, Apr 01, 2021 at 03:10:56PM -0700, Yu-cheng Yu wrote:
>> Introduce basic shadow stack enabling/disabling/allocation routines.
>> A task's shadow stack is allocated from memory with VM_SHADOW_STACK flag
>> and has a fixed size of min(RLIMIT_STACK, 4GB).
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Cc: Kees Cook <keescook@chromium.org>

[...]

>> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
>> new file mode 100644
>> index 000000000000..5406fdf6df3c
>> --- /dev/null
>> +++ b/arch/x86/kernel/shstk.c
>> @@ -0,0 +1,128 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * shstk.c - Intel shadow stack support
>> + *
>> + * Copyright (c) 2021, Intel Corporation.
>> + * Yu-cheng Yu <yu-cheng.yu@intel.com>
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/mm.h>
>> +#include <linux/mman.h>
>> +#include <linux/slab.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/sched/signal.h>
>> +#include <linux/compat.h>
>> +#include <linux/sizes.h>
>> +#include <linux/user.h>
>> +#include <asm/msr.h>
>> +#include <asm/fpu/internal.h>
>> +#include <asm/fpu/xstate.h>
>> +#include <asm/fpu/types.h>
>> +#include <asm/cet.h>
>> +
>> +static void start_update_msrs(void)
>> +{
>> +	fpregs_lock();
>> +	if (test_thread_flag(TIF_NEED_FPU_LOAD))
>> +		__fpregs_load_activate();
>> +}
>> +
>> +static void end_update_msrs(void)
>> +{
>> +	fpregs_unlock();
>> +}
>> +
>> +static unsigned long alloc_shstk(unsigned long size, int flags)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	unsigned long addr, populate;
>> +
>> +	/* VM_SHADOW_STACK requires MAP_ANONYMOUS, MAP_PRIVATE */
>> +	flags |= MAP_ANONYMOUS | MAP_PRIVATE;
> 
> Looks like all callers has flags == 0. Do I miss something.

My earlier versions use this flag.  I should have removed it.

>> +
>> +	mmap_write_lock(mm);
>> +	addr = do_mmap(NULL, 0, size, PROT_READ, flags, VM_SHADOW_STACK, 0,
>> +		       &populate, NULL);
>> +	mmap_write_unlock(mm);
>> +
>> +	if (populate)
>> +		mm_populate(addr, populate);
> 
> If all callers pass down flags==0, populate will never happen.

I will fix it.

>> +
>> +	return addr;
>> +}
>> +
>> +int shstk_setup(void)
>> +{
>> +	unsigned long addr, size;
>> +	struct cet_status *cet = &current->thread.cet;
>> +
>> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
>> +		return -EOPNOTSUPP;
>> +
>> +	size = round_up(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G), PAGE_SIZE);
>> +	addr = alloc_shstk(size, 0);
>> +	if (IS_ERR_VALUE(addr))
>> +		return PTR_ERR((void *)addr);
>> +
>> +	cet->shstk_base = addr;
>> +	cet->shstk_size = size;
>> +
>> +	start_update_msrs();
>> +	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
>> +	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);
>> +	end_update_msrs();
>> +	return 0;
>> +}
>> +
>> +void shstk_free(struct task_struct *tsk)
>> +{
>> +	struct cet_status *cet = &tsk->thread.cet;
>> +
>> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
>> +	    !cet->shstk_size ||
>> +	    !cet->shstk_base)
>> +		return;
>> +
>> +	if (!tsk->mm)
>> +		return;
>> +
>> +	while (1) {
>> +		int r;
>> +
>> +		r = vm_munmap(cet->shstk_base, cet->shstk_size);
>> +
>> +		/*
>> +		 * vm_munmap() returns -EINTR when mmap_lock is held by
>> +		 * something else, and that lock should not be held for a
>> +		 * long time.  Retry it for the case.
>> +		 */
> 
> Hm, no. -EINTR is not about the lock being held by somebody else. The task
> got a signal and need to return to userspace.

 From tracing the code itself, it looks like it cannot acquire the lock. 
  Let me dig into it.

> I have not looked at the rest of the patches yet, but why do you need a
> special free path for shadow stack? Why the normal unmap route doesn't
> work for you?

The thread's shadow stack is allocated by the kernel, so it needs to be 
freed when the thread exits.

>> +		if (r == -EINTR) {
>> +			cond_resched();
>> +			continue;
>> +		}
>> +		break;
>> +	}
>> +
>> +	cet->shstk_base = 0;
>> +	cet->shstk_size = 0;
>> +}
>> +

[...]

Thanks,
Yu-cheng
