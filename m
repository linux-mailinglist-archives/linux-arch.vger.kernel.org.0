Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9756386BC5
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 22:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbhEQU4d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 16:56:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:11856 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233271AbhEQU4c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 May 2021 16:56:32 -0400
IronPort-SDR: JtVE8OpCLu8+RxtHKZDwD5TToUFcPMNT/N7/2zot4uaTP31iMfSRwVA5zrUYTb8/fiNOoX6Gn+
 wBBxzVZwi9Qg==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="286093933"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="286093933"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 13:55:15 -0700
IronPort-SDR: TZcXoTiIbYniVOmf1LN1Ev8wIo3ZErYhJYjAMAmVqWeQUZ6eIC8Vwm+cxtyTHYjB5Jkzk7NDh5
 UipVJ/gBm2sA==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="541464404"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.147.139]) ([10.251.147.139])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 13:55:13 -0700
Subject: Re: [PATCH v26 24/30] x86/cet/shstk: Introduce shadow stack token
 setup/verify routines
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
 <20210427204315.24153-25-yu-cheng.yu@intel.com> <YKIfIEyW+sR+bDCk@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <e225e357-a1d5-9596-8900-79e6b94cf924@intel.com>
Date:   Mon, 17 May 2021 13:55:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKIfIEyW+sR+bDCk@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/17/2021 12:45 AM, Borislav Petkov wrote:
> On Tue, Apr 27, 2021 at 01:43:09PM -0700, Yu-cheng Yu wrote:
>> +static inline int write_user_shstk_32(u32 __user *addr, u32 val)
>> +{
>> +	WARN_ONCE(1, "%s used but not supported.\n", __func__);
>> +	return -EFAULT;
>> +}
>> +#endif
> 
> What is that supposed to catch? Any concrete (mis-)use cases?
> 

If 32-bit apps are not supported, there should be no need of 32-bit 
shadow stack write, otherwise there is a bug.

[...]

>> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
>> index d387df84b7f1..48a0c87414ef 100644
>> --- a/arch/x86/kernel/shstk.c
>> +++ b/arch/x86/kernel/shstk.c
>> @@ -20,6 +20,7 @@
>>   #include <asm/fpu/xstate.h>
>>   #include <asm/fpu/types.h>
>>   #include <asm/cet.h>
>> +#include <asm/special_insns.h>
>>   
>>   static void start_update_msrs(void)
>>   {
>> @@ -176,3 +177,128 @@ void shstk_disable(void)
>>   
>>   	shstk_free(current);
>>   }
>> +
>> +static unsigned long _get_user_shstk_addr(void)
> 
> What's the "_" prefix in the name supposed to denote?
> 
> Ditto for the other functions with "_" prefix you're adding.
> 

These are static functions.  I thought that would make the static scope 
clear.  I can remove "_".

>> +{
>> +	struct fpu *fpu = &current->thread.fpu;
>> +	unsigned long ssp = 0;
>> +
>> +	fpregs_lock();
>> +
>> +	if (fpregs_state_valid(fpu, smp_processor_id())) {
>> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
>> +	} else {
>> +		struct cet_user_state *p;
>> +
>> +		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
>> +		if (p)
>> +			ssp = p->user_ssp;
>> +	}
>> +
>> +	fpregs_unlock();
> 
> <---- newline here.
> 
>> +	return ssp;
>> +}
>> +
>> +#define TOKEN_MODE_MASK	3UL
>> +#define TOKEN_MODE_64	1UL
>> +#define IS_TOKEN_64(token) (((token) & TOKEN_MODE_MASK) == TOKEN_MODE_64)
>> +#define IS_TOKEN_32(token) (((token) & TOKEN_MODE_MASK) == 0)
> 
> Why do you have to look at the second, busy bit, too in order to
> determine the mode?
> 

If the busy bit is set, it is only for SAVEPREVSSP, and invalid as a 
normal restore token.

> Also, you don't need most of those defines - see below.
> 
>> +/*
>> + * Create a restore token on the shadow stack.  A token is always 8-byte
>> + * and aligned to 8.
>> + */
>> +static int _create_rstor_token(bool ia32, unsigned long ssp,
>> +			       unsigned long *token_addr)
>> +{
>> +	unsigned long addr;
>> +
>> +	*token_addr = 0;
> 
> What for? Callers should check this function's retval and then interpret
> the validity of token_addr and it should not unconditionally write into
> it.
> 

Ok.

>> +
>> +	if ((!ia32 && !IS_ALIGNED(ssp, 8)) || !IS_ALIGNED(ssp, 4))
> 
> Flip this logic:
> 
> 	if ((ia32 && !IS_ALIGNED(ssp, 4)) || !IS_ALIGNED(ssp, 8))
> 
>> +		return -EINVAL;
>> +
>> +	addr = ALIGN_DOWN(ssp, 8) - 8;
> 
> Yah, so this is weird. Why does the restore token need to be at -8
> instead on the shadow stack address itself?

With the lower two bits masked out, the restore token must point 
directly above itself.

> 
> Looking at
> 
> Figure 18-2. RSTORSSP to Switch to New Shadow Stack
> Figure 18-3. SAVEPREVSSP to Save a Restore Point
> 
> in the SDM, it looks like unnecessarily more complex than it should be.
> But maybe there's some magic I'm missing.
> 
>> +
>> +	/* Is the token for 64-bit? */
>> +	if (!ia32)
>> +		ssp |= TOKEN_MODE_64;
> 
> 		    |= BIT(0);
> 

Ok, then, we don't use #define's.  I will put in comments about what it 
is doing, and fix the rest.

Thanks,
Yu-cheng
