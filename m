Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18785328D15
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 20:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbhCATFU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 14:05:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:49056 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240917AbhCATCw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 14:02:52 -0500
IronPort-SDR: axrsqrwfkdrYjsEv1idMQ0CmWiThvor90tKf8zDA4+WyhyFJPDtMdSyUUG9ym0iRo/9cQGxnu5
 qK327PXb+tdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="247977008"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="247977008"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 10:59:59 -0800
IronPort-SDR: 9AtqZ+/g/XE8E5dnue//mblk5Mu7epGgq4velIrovp2wXLot6ybGW9lDf86j8bdDia0L/yp4JC
 sAgAshYwQz/w==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="444403546"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.116.218]) ([10.212.116.218])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 10:59:56 -0800
Subject: Re: [PATCH v21 08/26] x86/mm: Introduce _PAGE_COW
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
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
 <20210217222730.15819-9-yu-cheng.yu@intel.com>
 <20210301155234.GF6699@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <5d98a4f7-5882-2e6e-7b76-295b73c17152@intel.com>
Date:   Mon, 1 Mar 2021 10:59:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210301155234.GF6699@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/1/2021 7:52 AM, Borislav Petkov wrote:
> On Wed, Feb 17, 2021 at 02:27:12PM -0800, Yu-cheng Yu wrote:
>> @@ -182,7 +206,7 @@ static inline int pud_young(pud_t pud)
>>   
>>   static inline int pte_write(pte_t pte)
>>   {
>> -	return pte_flags(pte) & _PAGE_RW;
> 
> Put here a comment along the lines of:
> 
> 	/*
> 	 * Shadow stack pages are always writable - but not by normal
> 	 * instructions but only by shadow stack operations. Therefore, the
> 	 * W=0, D=1 test.
> 	 */
> 
> to make it clear what this means.
> 
>> +	return (pte_flags(pte) & _PAGE_RW) || pte_shstk(pte);
>>   }
>>   
>>   static inline int pte_huge(pte_t pte)
>> @@ -314,6 +338,24 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
>>   	return native_make_pte(v & ~clear);
>>   }
>>   
>> +static inline pte_t pte_make_cow(pte_t pte)
> 
> pte_mkcow like the rest of the "pte_mkX" functions.
> 
> And below too, for the other newly added pXd_make_* helpers.
> 
> 
>>   static inline pmd_t pmd_mkdirty(pmd_t pmd)
>>   {
>> -	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
>> +	pmdval_t dirty = _PAGE_DIRTY;
>> +
>> +	/* Avoid creating (HW)Dirty=1, Write=0 PMDs */
>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !(pmd_flags(pmd) & _PAGE_RW))
> 
> 						      !(pmd_write(pmd))
> 
>> +		dirty = _PAGE_COW;
>> +
>> +	return pmd_set_flags(pmd, dirty | _PAGE_SOFT_DIRTY);
>> +}
> 
> ...
> 
>>   static inline pud_t pud_mkdirty(pud_t pud)
>>   {
>> -	return pud_set_flags(pud, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
>> +	pudval_t dirty = _PAGE_DIRTY;
>> +
>> +	/* Avoid creating (HW)Dirty=1, Write=0 PUDs */
>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !(pud_flags(pud) & _PAGE_RW))
> 
> 						      !(pud_write(pud))
> 
> 

I will update.  Thanks!

--
Yu-cheng
