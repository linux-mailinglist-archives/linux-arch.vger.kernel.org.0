Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E93344D42
	for <lists+linux-arch@lfdr.de>; Mon, 22 Mar 2021 18:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhCVR2U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 13:28:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:1524 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhCVR16 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Mar 2021 13:27:58 -0400
IronPort-SDR: R+Gt2MP1QDYzA+6cmHEi9+vAxD8pRIvB5qjY/zf29gX0gv/aF4NRCXL4LgyaI71A8JtQr2Xj4m
 2hveqgt0hI0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="177447416"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="177447416"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 10:27:57 -0700
IronPort-SDR: /poCiz3iH8zbav4AUTruoJT/OU8lWJG21RxkY8P29L4ZNarEgYiS0oFCvkNqX2jXjm9t5M9f99
 CAkt3Y15cttQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="592694134"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.39.64]) ([10.209.39.64])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 10:27:53 -0700
Subject: Re: [PATCH v23 14/28] x86/mm: Shadow Stack page fault error checking
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
 <20210316151054.5405-15-yu-cheng.yu@intel.com>
 <20210322103858.evxun5bhw2i5sio6@box>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <b88b5324-e595-be3a-3005-e016e3adc791@intel.com>
Date:   Mon, 22 Mar 2021 10:27:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322103858.evxun5bhw2i5sio6@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/22/2021 3:38 AM, Kirill A. Shutemov wrote:
> On Tue, Mar 16, 2021 at 08:10:40AM -0700, Yu-cheng Yu wrote:
[...]
>>   
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index a73347e2cdfc..4316732a18c6 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -1100,6 +1100,17 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
>>   				       (error_code & X86_PF_INSTR), foreign))
>>   		return 1;
>>   
>> +	/*
>> +	 * Verify a shadow stack access is within a shadow stack VMA.
>> +	 * It is always an error otherwise.  Normal data access to a
>> +	 * shadow stack area is checked in the case followed.
>> +	 */
>> +	if (error_code & X86_PF_SHSTK) {
>> +		if (!(vma->vm_flags & VM_SHSTK))
>> +			return 1;
>> +		return 0;
> 
> Any reason to return 0 here? I would rather keep the single return 0 in
> the function, after all checks are done.
> 

For shadow stack fault, X86_PF_SHSTK and X86_PF_WRITE both can be set. 
So for shadow stack fault, return from here and don't go into the normal 
write fault case.

Thanks,
Yu-cheng

>> +	}
>> +
>>   	if (error_code & X86_PF_WRITE) {
>>   		/* write, present and write, not present: */
>>   		if (unlikely(!(vma->vm_flags & VM_WRITE)))
>> @@ -1293,6 +1304,14 @@ void do_user_addr_fault(struct pt_regs *regs,
>>   
>>   	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>>   
>> +	/*
>> +	 * Clearing _PAGE_DIRTY is used to detect shadow stack access.
>> +	 * This method cannot distinguish shadow stack read vs. write.
>> +	 * For valid shadow stack accesses, set FAULT_FLAG_WRITE to effect
>> +	 * copy-on-write.
>> +	 */
>> +	if (error_code & X86_PF_SHSTK)
>> +		flags |= FAULT_FLAG_WRITE;
>>   	if (error_code & X86_PF_WRITE)
>>   		flags |= FAULT_FLAG_WRITE;
>>   	if (error_code & X86_PF_INSTR)
>> -- 
>> 2.21.0
>>
> 
