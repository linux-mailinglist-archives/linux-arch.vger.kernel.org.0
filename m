Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA437A9C8
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 16:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhEKOpO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 10:45:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:37055 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231154AbhEKOpO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 May 2021 10:45:14 -0400
IronPort-SDR: gMK/SnPUHjREfJMdcX7vd2KPn7jaQN86UdRUfMrOOsVDLJDh83csQYkxmQZ2DkOIPkE+qEf2rQ
 DZxZsJGV3YlA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="196362832"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="196362832"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:44:08 -0700
IronPort-SDR: 7V+9fvwXTKhUEpN2lvCIsHN2TqNwmLJvPUcOKEsw//yhaLuJGNRifnvWmU/hT2zoRsJ46EEfyI
 vzjaY6esLPCw==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="468935466"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.34.147]) ([10.212.34.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:44:07 -0700
Subject: Re: [PATCH v26 30/30] mm: Introduce PROT_SHADOW_STACK for shadow
 stack
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
        Haitao Huang <haitao.huang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-31-yu-cheng.yu@intel.com>
 <20210511114852.5wm6a5z72xjlqc4c@box>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <b395ae6c-dfbe-59c2-0f12-e65a111a532a@intel.com>
Date:   Tue, 11 May 2021 07:44:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511114852.5wm6a5z72xjlqc4c@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/11/2021 4:48 AM, Kirill A. Shutemov wrote:
> On Tue, Apr 27, 2021 at 01:43:15PM -0700, Yu-cheng Yu wrote:
>> There are three possible options to create a shadow stack allocation API:
>> an arch_prctl, a new syscall, or adding PROT_SHADOW_STACK to mmap() and
>> mprotect().  Each has its advantages and compromises.
>>
>> An arch_prctl() is the least intrusive.  However, the existing x86
>> arch_prctl() takes only two parameters.  Multiple parameters must be
>> passed in a memory buffer.  There is a proposal to pass more parameters in
>> registers [1], but no active discussion on that.
>>
>> A new syscall minimizes compatibility issues and offers an extensible frame
>> work to other architectures, but this will likely result in some overlap of
>> mmap()/mprotect().
>>
>> The introduction of PROT_SHADOW_STACK to mmap()/mprotect() takes advantage
>> of existing APIs.  The x86-specific PROT_SHADOW_STACK is translated to
>> VM_SHADOW_STACK and a shadow stack mapping is created without reinventing
>> the wheel.  There are potential pitfalls though.  The most obvious one
>> would be using this as a bypass to shadow stack protection.  However, the
>> attacker would have to get to the syscall first.
>>
>> [1] https://lore.kernel.org/lkml/20200828121624.108243-1-hjl.tools@gmail.com/
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> ---
>> v26:
>> - Change PROT_SHSTK to PROT_SHADOW_STACK.
>> - Remove (vm_flags & VM_SHARED) check, since it is covered by
>>    !vma_is_anonymous().
>>
>> v24:
>> - Update arch_calc_vm_prot_bits(), leave PROT* checking to
>>    arch_validate_prot().
>> - Update arch_validate_prot(), leave vma flags checking to
>>    arch_validate_flags().
>> - Add arch_validate_flags().
>>
>>   arch/x86/include/asm/mman.h      | 60 +++++++++++++++++++++++++++++++-
>>   arch/x86/include/uapi/asm/mman.h |  2 ++
>>   include/linux/mm.h               |  1 +
>>   3 files changed, 62 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
>> index 629f6c81263a..fbb90f1b02c0 100644
>> --- a/arch/x86/include/asm/mman.h
>> +++ b/arch/x86/include/asm/mman.h
>> @@ -20,11 +20,69 @@
>>   		((vm_flags) & VM_PKEY_BIT2 ? _PAGE_PKEY_BIT2 : 0) |	\
>>   		((vm_flags) & VM_PKEY_BIT3 ? _PAGE_PKEY_BIT3 : 0))
>>   
>> -#define arch_calc_vm_prot_bits(prot, key) (		\
>> +#define pkey_vm_prot_bits(prot, key) (			\
>>   		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
>>   		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
>>   		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
>>   		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
>> +#else
>> +#define pkey_vm_prot_bits(prot, key) (0)
>>   #endif
>>   
>> +static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>> +						   unsigned long pkey)
>> +{
>> +	unsigned long vm_prot_bits = pkey_vm_prot_bits(prot, pkey);
>> +
>> +	if (prot & PROT_SHADOW_STACK)
>> +		vm_prot_bits |= VM_SHADOW_STACK;
>> +
>> +	return vm_prot_bits;
>> +}
>> +
>> +#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
>> +
>> +#ifdef CONFIG_X86_SHADOW_STACK
>> +static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
>> +{
>> +	unsigned long valid = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM |
>> +			      PROT_SHADOW_STACK;
>> +
>> +	if (prot & ~valid)
>> +		return false;
>> +
>> +	if (prot & PROT_SHADOW_STACK) {
>> +		if (!current->thread.cet.shstk_size)
>> +			return false;
>> +
>> +		/*
>> +		 * A shadow stack mapping is indirectly writable by only
>> +		 * the CALL and WRUSS instructions, but not other write
>> +		 * instructions).  PROT_SHADOW_STACK and PROT_WRITE are
>> +		 * mutually exclusive.
>> +		 */
>> +		if (prot & PROT_WRITE)
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +#define arch_validate_prot arch_validate_prot
>> +
>> +static inline bool arch_validate_flags(struct vm_area_struct *vma, unsigned long vm_flags)
>> +{
>> +	/*
>> +	 * Shadow stack must be anonymous and not shared.
>> +	 */
>> +	if ((vm_flags & VM_SHADOW_STACK) && !vma_is_anonymous(vma))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +#define arch_validate_flags(vma, vm_flags) arch_validate_flags(vma, vm_flags)
>> +
>> +#endif /* CONFIG_X86_SHADOW_STACK */
>> +
>>   #endif /* _ASM_X86_MMAN_H */
>> diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
>> index f28fa4acaeaf..4c36b263cf0a 100644
>> --- a/arch/x86/include/uapi/asm/mman.h
>> +++ b/arch/x86/include/uapi/asm/mman.h
>> @@ -4,6 +4,8 @@
>>   
>>   #define MAP_32BIT	0x40		/* only give out 32bit addresses */
>>   
>> +#define PROT_SHADOW_STACK	0x10	/* shadow stack pages */
>> +
>>   #include <asm-generic/mman.h>
>>   
>>   #endif /* _UAPI_ASM_X86_MMAN_H */
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 1ccec5cc399b..9a7652eea207 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -342,6 +342,7 @@ extern unsigned int kobjsize(const void *objp);
>>   
>>   #if defined(CONFIG_X86)
>>   # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
>> +# define VM_ARCH_CLEAR	VM_SHADOW_STACK
> 
> Nit: you can put VM_SHADOW_STACK directly into VM_FLAGS_CLEAR. It's
> already conditinal on the feature enabled and VM_NONE otherwise.
> 
> Up to you.
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 

Thanks!
