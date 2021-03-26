Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E94034ABC0
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 16:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhCZPqr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 11:46:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:36224 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhCZPqc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 11:46:32 -0400
IronPort-SDR: tjLCPTysDovHN6DDZ7lTA8gswryivK3tZFil2gHhskdY+plTSqIt1651uA1yFpdzm1/p1sLKmj
 SsvAlW/uNaMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="171162278"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="171162278"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 08:46:32 -0700
IronPort-SDR: 4LVgfPVpdmkD7cfo8pmJomTC9ws0nhuVEuHkPVnvQyKK3SXozc7p1edP3lq/iDypY7mT73MZ8q
 FiFTPZ8L5a1A==
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="443390230"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.171.114]) ([10.209.171.114])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 08:46:31 -0700
Subject: Re: [PATCH v23 18/28] mm/mmap: Add shadow stack pages to memory
 accounting
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
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-19-yu-cheng.yu@intel.com>
 <20210322105729.24rt4nwc3blipxsr@box>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <4b926140-66ac-f538-df94-8213b8a2ab86@intel.com>
Date:   Fri, 26 Mar 2021 08:46:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322105729.24rt4nwc3blipxsr@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/22/2021 3:57 AM, Kirill A. Shutemov wrote:
> On Tue, Mar 16, 2021 at 08:10:44AM -0700, Yu-cheng Yu wrote:
>> Account shadow stack pages to stack memory.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> ---
>>   arch/x86/mm/pgtable.c   |  7 +++++++
>>   include/linux/pgtable.h | 11 +++++++++++
>>   mm/mmap.c               |  5 +++++
>>   3 files changed, 23 insertions(+)
>>
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index 0f4fbf51a9fc..948d28c29964 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -895,3 +895,10 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>>   
>>   #endif /* CONFIG_X86_64 */
>>   #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
>> +
>> +#ifdef CONFIG_ARCH_HAS_SHADOW_STACK
>> +bool arch_shadow_stack_mapping(vm_flags_t vm_flags)
>> +{
>> +	return (vm_flags & VM_SHSTK);
>> +}
>> +#endif
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index cbd98484c4f1..487c08df4365 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -1470,6 +1470,17 @@ static inline pmd_t arch_maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma
>>   #endif /* CONFIG_ARCH_MAYBE_MKWRITE */
>>   #endif /* CONFIG_MMU */
>>   
>> +#ifdef CONFIG_MMU
>> +#ifdef CONFIG_ARCH_HAS_SHADOW_STACK
>> +bool arch_shadow_stack_mapping(vm_flags_t vm_flags);
>> +#else
>> +static inline bool arch_shadow_stack_mapping(vm_flags_t vm_flags)
>> +{
>> +	return false;
>> +}
>> +#endif /* CONFIG_ARCH_HAS_SHADOW_STACK */
>> +#endif /* CONFIG_MMU */
>> +
>>   /*
>>    * Architecture PAGE_KERNEL_* fallbacks
>>    *
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 3f287599a7a3..2ac67882ace2 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -1718,6 +1718,9 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
>>   	if (file && is_file_hugepages(file))
>>   		return 0;
>>   
>> +	if (arch_shadow_stack_mapping(vm_flags))
>> +		return 1;
>> +
> 
> What's wrong with testing (vm_flags & VM_SHSTK) here? VM_SHSTK is 0 on
> non-x86.
> 
>>   	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
>>   }
>>   
>> @@ -3387,6 +3390,8 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
>>   		mm->stack_vm += npages;
>>   	else if (is_data_mapping(flags))
>>   		mm->data_vm += npages;
>> +	else if (arch_shadow_stack_mapping(flags))
>> +		mm->stack_vm += npages;
> 
> Ditto.
> 

The thought was, here all testings are done with helpers, e.g. 
is_data_mapping(), so creating a helper for shadow stack is more inline 
with the existing code.  Or, maybe we can call it 
is_shadow_stack_mapping()?  And, since we have a helper, use it in 
accountable_mapping() as well.  Or do you have other suggestions?

Thanks,
Yu-cheng
