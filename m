Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD68C31727A
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 22:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhBJVi4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 16:38:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:53404 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232192AbhBJViz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Feb 2021 16:38:55 -0500
IronPort-SDR: tVPB0cyoz6KeKg1N2AMNEUj9ePcaKVssctrpTBBMttjm3MEzHZTvB5pAMQkUWH1/umhrw02i/T
 1JR0gGzG46FQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="161301778"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="161301778"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 13:38:14 -0800
IronPort-SDR: lfBvtJxzP7eM7rxhNTEkSJQFKW6pSPQwDWDjL0xrSvc0rO529nfDOd01DxdtVXlVhrVpvVqI9D
 WUnuOVuiu4FQ==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="375624618"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.188.167]) ([10.212.188.167])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 13:38:12 -0800
Subject: Re: [PATCH v20 21/25] x86/cet/shstk: Handle signals for shadow stack
To:     Kees Cook <keescook@chromium.org>
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>, haitao.huang@intel.com
References: <20210210175703.12492-1-yu-cheng.yu@intel.com>
 <20210210175703.12492-22-yu-cheng.yu@intel.com>
 <202102101154.CEF2606E@keescook>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <57dcc827-052a-94cd-31d4-286675f9d506@intel.com>
Date:   Wed, 10 Feb 2021 13:38:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <202102101154.CEF2606E@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/10/2021 11:58 AM, Kees Cook wrote:
> On Wed, Feb 10, 2021 at 09:56:59AM -0800, Yu-cheng Yu wrote:
>> To deliver a signal, create a shadow stack restore token and put the token
>> and the signal restorer address on the shadow stack.  For sigreturn, verify
>> the token and restore from it the shadow stack pointer.
>>
>> A shadow stack restore token marks a restore point of the shadow stack.
>> The token is distinctively different from any shadow stack address.
> 
> How is it different? It seems like it just has the last 2 bits
> masked/set?
> 

For example, for 64-bit apps,

A shadow stack pointer value (*ssp) has to be in some code area, but for 
a token, (*ptr_of_token) = (ptr_of_token + 8), which has to be within 
the same shadow stack area.  In cet_verify_rstor_token(), this is checked.

>> In sigreturn, restoring from a token ensures the target address is the
>> location pointed by the token.
> 
> As in, a token (real stack address with 2-bit mask) is checked against
> the real stack address? I don't see a comparison -- it only checks that
> it is < TASK_SIZE.
> 
> How does cet_restore_signal() figure into this? (As in, the MSR writes?)
> 

The kernel takes the restore address from the token.  It will not 
mistakenly take a wrong address from the shadow stack.  I will put this 
in my commit logs.

[...]

>> Introduce WRUSS, which is a kernel-mode instruction but writes directly to
>> user shadow stack.  It is used to construct the user signal stack as
>> described above.
>>
>> Currently there is no systematic facility for extending a signal context.
>> Introduce a signal context extension 'struct sc_ext', which is used to save
>> shadow stack restore token address and WAIT_ENDBR status.  WAIT_ENDBR will
>> be introduced later in the Indirect Branch Tracking (IBT) series, but add
>> that into sc_ext now to keep the struct stable in case the IBT series is
>> applied later.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

[...]

>> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
>> index d25a03215984..08e43d9b5176 100644
>> --- a/arch/x86/kernel/cet.c
>> +++ b/arch/x86/kernel/cet.c
>> @@ -19,6 +19,8 @@
>>   #include <asm/fpu/xstate.h>
>>   #include <asm/fpu/types.h>
>>   #include <asm/cet.h>
>> +#include <asm/special_insns.h>
>> +#include <uapi/asm/sigcontext.h>
>>   
>>   static void start_update_msrs(void)
>>   {
>> @@ -72,6 +74,80 @@ static unsigned long alloc_shstk(unsigned long size, int flags)
>>   	return addr;
>>   }
>>   
>> +#define TOKEN_MODE_MASK	3UL
>> +#define TOKEN_MODE_64	1UL
>> +#define IS_TOKEN_64(token) (((token) & TOKEN_MODE_MASK) == TOKEN_MODE_64)
>> +#define IS_TOKEN_32(token) (((token) & TOKEN_MODE_MASK) == 0)
>> +
>> +/*
>> + * Verify the restore token at the address of 'ssp' is
>> + * valid and then set shadow stack pointer according to the
>> + * token.
>> + */
>> +int cet_verify_rstor_token(bool ia32, unsigned long ssp,
>> +			   unsigned long *new_ssp)
>> +{
>> +	unsigned long token;
>> +
>> +	*new_ssp = 0;
>> +
>> +	if (!IS_ALIGNED(ssp, 8))
>> +		return -EINVAL;
>> +
>> +	if (get_user(token, (unsigned long __user *)ssp))
>> +		return -EFAULT;
>> +
>> +	/* Is 64-bit mode flag correct? */
>> +	if (!ia32 && !IS_TOKEN_64(token))
>> +		return -EINVAL;
>> +	else if (ia32 && !IS_TOKEN_32(token))
>> +		return -EINVAL;
>> +
>> +	token &= ~TOKEN_MODE_MASK;
>> +
>> +	/*
>> +	 * Restore address properly aligned?
>> +	 */
>> +	if ((!ia32 && !IS_ALIGNED(token, 8)) || !IS_ALIGNED(token, 4))
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Token was placed properly?
>> +	 */
>> +	if (((ALIGN_DOWN(token, 8) - 8) != ssp) || token >= TASK_SIZE_MAX)
>> +		return -EINVAL;
>> +
>> +	*new_ssp = token;
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Create a restore token on the shadow stack.
>> + * A token is always 8-byte and aligned to 8.
>> + */
>> +static int create_rstor_token(bool ia32, unsigned long ssp,
>> +			      unsigned long *new_ssp)
>> +{
>> +	unsigned long addr;
>> +
>> +	*new_ssp = 0;
>> +
>> +	if ((!ia32 && !IS_ALIGNED(ssp, 8)) || !IS_ALIGNED(ssp, 4))
>> +		return -EINVAL;
>> +
>> +	addr = ALIGN_DOWN(ssp, 8) - 8;
>> +
>> +	/* Is the token for 64-bit? */
>> +	if (!ia32)
>> +		ssp |= TOKEN_MODE_64;
>> +
>> +	if (write_user_shstk_64(addr, ssp))
>> +		return -EFAULT;
>> +
>> +	*new_ssp = addr;
>> +	return 0;
>> +}
>> +

[...]
