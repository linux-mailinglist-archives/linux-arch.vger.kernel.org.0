Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CBE36B876
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 20:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhDZSBr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 14:01:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:20514 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235357AbhDZSBr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Apr 2021 14:01:47 -0400
IronPort-SDR: DHMRGsqCkDzc30UCqVOFr+y9UtijMsne/6X/Xn1cjj6JN5H3t5byTc2K4XSYVMe4Q75NJAblIE
 LQ6Qlal7EAUg==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="257683199"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="257683199"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:01:00 -0700
IronPort-SDR: K8cA858LlMyW2WrbT3P+DmNpVokOFgZuLVKN6Qcgrul5wvhMk4IOD+I9+DUpFMPPSMiSf1xXUh
 +qUVw8CigAcQ==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="422745165"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.73.213]) ([10.212.73.213])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:00:58 -0700
Subject: Re: [PATCH v25 30/30] mm: Introduce PROT_SHSTK for shadow stack
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
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
 <20210415221419.31835-31-yu-cheng.yu@intel.com>
 <20210426065243.ozh6doz6q5xonrqe@box.shutemov.name>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <afd939a0-c49d-c0e2-7d10-d65e18ea02ba@intel.com>
Date:   Mon, 26 Apr 2021 11:00:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210426065243.ozh6doz6q5xonrqe@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/25/2021 11:52 PM, Kirill A. Shutemov wrote:
> On Thu, Apr 15, 2021 at 03:14:19PM -0700, Yu-cheng Yu wrote:
>> There are three possible options to create a shadow stack allocation API:
>> an arch_prctl, a new syscall, or adding PROT_SHSTK to mmap()/mprotect().
>> Each has its advantages and compromises.
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
>> The introduction of PROT_SHSTK to mmap()/mprotect() takes advantage of
> 
> Maybe PROT_SHADOW_STACK?
> 
>> existing APIs.  The x86-specific PROT_SHSTK is translated to
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
>> v24:
>> - Update arch_calc_vm_prot_bits(), leave PROT* checking to
>>    arch_validate_prot().
>> - Update arch_validate_prot(), leave vma flags checking to
>>    arch_validate_flags().
>> - Add arch_validate_flags().
>>
>>   arch/x86/include/asm/mman.h      | 59 +++++++++++++++++++++++++++++++-
>>   arch/x86/include/uapi/asm/mman.h |  1 +
>>   include/linux/mm.h               |  1 +
>>   3 files changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
>> index 629f6c81263a..1821c179f35d 100644
>> --- a/arch/x86/include/asm/mman.h
>> +++ b/arch/x86/include/asm/mman.h

[...]

>> +
>> +#define arch_validate_prot arch_validate_prot
>> +
>> +static inline bool arch_validate_flags(unsigned long vm_flags, bool is_anon)
>> +{
>> +	if (vm_flags & VM_SHADOW_STACK) {
>> +		if ((vm_flags & VM_SHARED) || !is_anon)
> 
> VM_SHARED check is redundant. vma_is_anonymous() should be enough.
> Anonymous shared mappings would fail vma_is_anonymous().
>

Thanks for looking into this.  I will update and send another version.

Yu-cheng
