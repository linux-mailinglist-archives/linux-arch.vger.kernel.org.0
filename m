Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7536DF05
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 20:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbhD1Sjs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 14:39:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:17775 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235613AbhD1Sjr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 14:39:47 -0400
IronPort-SDR: 1VMV8Mi3lof0WrrsPldix/Ja96EQtJUJ3T7/VLwsfD62M+NFGNx/BDKOOnQbWyi+vV6r5VDhbt
 4afjvueP7zWw==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="196876300"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="196876300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 11:39:01 -0700
IronPort-SDR: Eyij2/3/xueqhv26etxQzIXzQtPT5rX0f6zloVm+HZBYnABguCl1d9tC0mRZyqw7zQkgL6+fMb
 nfTvUehN8Wgg==
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="458322752"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.133.34]) ([10.209.133.34])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 11:39:00 -0700
Subject: Re: [PATCH v26 22/30] x86/cet/shstk: Add user-mode shadow stack
 support
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
 <20210427204315.24153-23-yu-cheng.yu@intel.com> <YImg5hmBnTZTkYIp@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <3a0ed2e3-b13d-0db6-87af-fecd394ddd2e@intel.com>
Date:   Wed, 28 Apr 2021 11:39:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YImg5hmBnTZTkYIp@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/28/2021 10:52 AM, Borislav Petkov wrote:
> On Tue, Apr 27, 2021 at 01:43:07PM -0700, Yu-cheng Yu wrote:
>> @@ -535,6 +536,10 @@ struct thread_struct {
>>   
>>   	unsigned int		sig_on_uaccess_err:1;
>>   
>> +#ifdef CONFIG_X86_SHADOW_STACK
>> +	struct cet_status	cet;
> 
> A couple of versions ago I said:
> 
> "	struct shstk_desc       shstk;
> 
> or so"
> 
> but no movement here. That thing is still called cet_status even though
> there's nothing status-related with it.
> 
> So what's up?
> 

Sorry about that.  After that email thread, we went ahead to separate 
shadow stack and ibt into different files.  I thought about the struct, 
the file names cet.h, etc.  The struct still needs to include ibt 
status, and if it is shstk_desc, the name is not entirely true.  One 
possible approach is, we don't make it a struct here, and put every item 
directly in thread_struct.  However, the benefit of putting all in a 
struct is understandable (you might argue the opposite :-)).  Please 
make the call, and I will do the change.

>> +static unsigned long alloc_shstk(unsigned long size)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	unsigned long addr, populate;
>> +	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
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
> Please fix it up everywhere.
> 

Ok!

>> +	mmap_write_lock(mm);
>> +	addr = do_mmap(NULL, 0, size, PROT_READ, flags, VM_SHADOW_STACK, 0,
>> +		       &populate, NULL);
>> +	mmap_write_unlock(mm);
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
>> +	addr = alloc_shstk(size);
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
> 
> <---- newline here.
> 
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
> 
> Where are the comments you said you wanna add:
> 
> https://lkml.kernel.org/r/b05ee7eb-1b5d-f84f-c8f3-bfe9426e8a7d@intel.com
> 
> ?
> 

Yes, the comments are in patch #23: Handle thread shadow stack.  I 
wanted to add that in the patch that takes the path.

>> +
>> +	while (1) {
>> +		int r;
>> +
>> +		r = vm_munmap(cet->shstk_base, cet->shstk_size);
> 
> 		int r = vm_munmap...
> 
>> +
>> +		/*
>> +		 * vm_munmap() returns -EINTR when mmap_lock is held by
>> +		 * something else, and that lock should not be held for a
>> +		 * long time.  Retry it for the case.
>> +		 */
>> +		if (r == -EINTR) {
>> +			cond_resched();
>> +			continue;
>> +		}
>> +		break;
>> +	}
> 
> vm_munmap() can return other negative error values, where are you
> handling those?
> 

For other error values, the loop stops.

>> +
>> +	cet->shstk_base = 0;
>> +	cet->shstk_size = 0;
>> +}
>> +
>> +void shstk_disable(void)
>> +{
>> +	struct cet_status *cet = &current->thread.cet;
> 
> Same question as before: what guarantees that current doesn't change
> from under you here?

The actual reading/writing MSRs are protected by fpregs_lock().

> 
> One of the worst thing to do is to ignore review comments. I'd strongly
> suggest you pay more attention and avoid that in the future.
> 
> Thx.
> 

