Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4813308CDA
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 19:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhA2S5e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 13:57:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:50695 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232208AbhA2S5U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 13:57:20 -0500
IronPort-SDR: Qz/r3HHrJjC+XEUFPgFRYZM/ph1q3Xx7uLCyvnUMS4s9sCdnVIQ13WpuuCV0eV0967L+q9NXvo
 OOx+Z6XjL6XQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="167566963"
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="167566963"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 10:56:38 -0800
IronPort-SDR: IePLN3+n6x54ZV3rR5cqQrlmHDw65ERcV9hZYs8RH26HoKoR6RfycUysg2w+lb7ho/V///10NM
 Glh/Qjd57hUA==
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="389415865"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.73.214]) ([10.212.73.214])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 10:56:36 -0800
Subject: Re: [PATCH v18 24/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Pengfei Xu <pengfei.xu@intel.com>
References: <20210127212524.10188-1-yu-cheng.yu@intel.com>
 <20210127212524.10188-25-yu-cheng.yu@intel.com>
 <ba39586d-25b6-6ea5-19c3-adf17b59f910@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <761ae8ce-0560-24cc-e6f7-684475cb3708@intel.com>
Date:   Fri, 29 Jan 2021 10:56:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <ba39586d-25b6-6ea5-19c3-adf17b59f910@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/29/2021 9:07 AM, Dave Hansen wrote:
> On 1/27/21 1:25 PM, Yu-cheng Yu wrote:
>> arch_prctl(ARCH_X86_CET_STATUS, u64 *args)
>>      Get CET feature status.
>>
>>      The parameter 'args' is a pointer to a user buffer.  The kernel returns
>>      the following information:
>>
>>      *args = shadow stack/IBT status
>>      *(args + 1) = shadow stack base address
>>      *(args + 2) = shadow stack size
> 
> What's the deal for 32-bit binaries?  The in-kernel code looks 64-bit
> only, but I don't see anything restricting the interface to 64-bit.

Items in args are 64-bit.  A 32-bit binary uses the same interface, but 
uses only lower bits.  I will add that in the comments.

>> +static int copy_status_to_user(struct cet_status *cet, u64 arg2)
> 
> This has static scope, but it's still awfully generically named.  A cet_
> prefix would be nice.

I will add that.

>> +{
>> +	u64 buf[3] = {0, 0, 0};
>> +
>> +	if (cet->shstk_size) {
>> +		buf[0] |= GNU_PROPERTY_X86_FEATURE_1_SHSTK;
>> +		buf[1] = (u64)cet->shstk_base;
>> +		buf[2] = (u64)cet->shstk_size;
> 
> What's the casting for?

cet->shstk_base and cet->shstk_size are both 'unsigned long', not u64, 
so the cast.

>> +	}
>> +
>> +	return copy_to_user((u64 __user *)arg2, buf, sizeof(buf));
>> +}
>> +
>> +int prctl_cet(int option, u64 arg2)
>> +{
>> +	struct cet_status *cet;
>> +	unsigned int features;
>> +
>> +	/*
>> +	 * GLIBC's ENOTSUPP == EOPNOTSUPP == 95, and it does not recognize
>> +	 * the kernel's ENOTSUPP (524).  So return EOPNOTSUPP here.
>> +	 */
>> +	if (!IS_ENABLED(CONFIG_X86_CET))
>> +		return -EOPNOTSUPP;
> 
> Let's ignore glibc for a moment.  What error code *should* the kernel be
> returning here?  errno(3) says:
> 
>         EOPNOTSUPP      Operation not supported on socket (POSIX.1)
> ...
>         ENOTSUP         Operation not supported (POSIX.1)
> 

Yeah, other places in kernel use ENOTSUPP.  This seems to be out of 
line.  And since the issue is long-existing, applications already know 
how to deal with it.  I should have made that argument.  Change it to 
ENOTSUPP.

>> +	cet = &current->thread.cet;
>> +
>> +	if (option == ARCH_X86_CET_STATUS)
>> +		return copy_status_to_user(cet, arg2);
> 
> What's the point of doing copy_status_to_user() if the processor doesn't
> support CET?  In other words, shouldn't this be below the CPU feature check?

The thought was to tell the difference between the kernel itself does 
not support CET and the system does not have CET.  And, if the kernel 
supports it, show CET status of the thread.

> Also, please cast arg2 *here*.  It becomes a user pointer here, not at
> the copy_to_user().

I will fix it.

>> +	if (!static_cpu_has(X86_FEATURE_CET))
>> +		return -EOPNOTSUPP;
> 
> So, you went to the trouble of adding a disabled-features.h entry for
> this.  Why not just do:
> 
> 	if (cpu_feature_enabled(X86_FEATURE_CET))
> 		...
> 
> instead of the IS_ENABLED() check above?  That should get rid of one of
> these if's.
> 

Explained above.

>> +	switch (option) {
>> +	case ARCH_X86_CET_DISABLE:
>> +		if (cet->locked)
>> +			return -EPERM;
>> +
>> +		features = (unsigned int)arg2;
> 
> What's the purpose of this cast?
> 
>> +		if (features & ~GNU_PROPERTY_X86_FEATURE_1_VALID)
>> +			return -EINVAL;
>> +		if (features & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
>> +			cet_disable_shstk();
>> +		return 0;
> 
> This doesn't enforce that the high bits of arg2 be 0.  Shouldn't we call
> them reserved and enforce that they be 0?

Yes, the code already checks invalid bits.  We don't need the cast.

>> +	case ARCH_X86_CET_LOCK:
>> +		cet->locked = 1;
>> +		return 0;
> 
> This needs to check for and enforce that arg2==0.

Yes.

> 
>> +	default:
>> +		return -ENOSYS;
>> +	}
>> +}

