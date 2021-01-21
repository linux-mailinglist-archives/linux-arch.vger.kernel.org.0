Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7852FF5B8
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 21:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbhAUUUg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 15:20:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:49885 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbhAUUTN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 15:19:13 -0500
IronPort-SDR: EdP40jXPw+KKSV3cqCCoVhFR0wuD/kbzmYahGjOhdWGHqM0tcOXfR6ncx1qqB99ytQSnFcD+QI
 v2h7TbUiuFdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="176764782"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="176764782"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 12:16:26 -0800
IronPort-SDR: Xeb6GP6QHS5E+NUN4IsRGZ97r6GOsWNpHXOAkde9SaUDTqrCmzanAvvZHRo2+bsJULzAS4gGR+
 RVNS7GFSD8vw==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="385443835"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.46.254]) ([10.209.46.254])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 12:16:24 -0800
Subject: Re: [PATCH v17 08/26] x86/mm: Introduce _PAGE_COW
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
        Pengfei Xu <pengfei.xu@intel.com>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-9-yu-cheng.yu@intel.com>
 <20210121184405.GE32060@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <b4d4bec7-504e-2443-4cf3-0801b179000f@intel.com>
Date:   Thu, 21 Jan 2021 12:16:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121184405.GE32060@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/21/2021 10:44 AM, Borislav Petkov wrote:
> On Tue, Dec 29, 2020 at 01:30:35PM -0800, Yu-cheng Yu wrote:
[...]
>> @@ -343,6 +349,16 @@ static inline pte_t pte_mkold(pte_t pte)
>>   
>>   static inline pte_t pte_wrprotect(pte_t pte)
>>   {
>> +	/*
>> +	 * Blindly clearing _PAGE_RW might accidentally create
>> +	 * a shadow stack PTE (RW=0, Dirty=1).  Move the hardware
>> +	 * dirty value to the software bit.
>> +	 */
>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
>> +		pte.pte |= (pte.pte & _PAGE_DIRTY) >> _PAGE_BIT_DIRTY << _PAGE_BIT_COW;
> 
> Why the unreadable shifting when you can simply do:
> 
>                  if (pte.pte & _PAGE_DIRTY)
>                          pte.pte |= _PAGE_COW;
> 
> ?

It clears _PAGE_DIRTY and sets _PAGE_COW.  That is,

if (pte.pte & _PAGE_DIRTY) {
	pte.pte &= ~_PAGE_DIRTY;
	pte.pte |= _PAGE_COW;
}

So, shifting makes resulting code more efficient.

>> @@ -434,16 +469,40 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
>>   
>>   static inline pmd_t pmd_mkclean(pmd_t pmd)
>>   {
>> -	return pmd_clear_flags(pmd, _PAGE_DIRTY);
>> +	return pmd_clear_flags(pmd, _PAGE_DIRTY_BITS);
>>   }
>>   
>>   static inline pmd_t pmd_wrprotect(pmd_t pmd)
>>   {
>> +	/*
>> +	 * Blindly clearing _PAGE_RW might accidentally create
>> +	 * a shadow stack PMD (RW=0, Dirty=1).  Move the hardware
>> +	 * dirty value to the software bit.
>> +	 */
>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
>> +		pmdval_t v = native_pmd_val(pmd);
>> +
>> +		v |= (v & _PAGE_DIRTY) >> _PAGE_BIT_DIRTY << _PAGE_BIT_COW;
> 
> As above.
> 
>> @@ -488,17 +554,35 @@ static inline pud_t pud_mkold(pud_t pud)
>>   
>>   static inline pud_t pud_mkclean(pud_t pud)
>>   {
>> -	return pud_clear_flags(pud, _PAGE_DIRTY);
>> +	return pud_clear_flags(pud, _PAGE_DIRTY_BITS);
>>   }
>>   
>>   static inline pud_t pud_wrprotect(pud_t pud)
>>   {
>> +	/*
>> +	 * Blindly clearing _PAGE_RW might accidentally create
>> +	 * a shadow stack PUD (RW=0, Dirty=1).  Move the hardware
>> +	 * dirty value to the software bit.
>> +	 */
>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
>> +		pudval_t v = native_pud_val(pud);
>> +
>> +		v |= (v & _PAGE_DIRTY) >> _PAGE_BIT_DIRTY << _PAGE_BIT_COW;
> 
> Ditto.
> 
>> @@ -1131,6 +1222,12 @@ extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
>>   #define pmd_write pmd_write
>>   static inline int pmd_write(pmd_t pmd)
>>   {
>> +	/*
>> +	 * If _PAGE_DIRTY is set, then the PMD must either have _PAGE_RW or
>> +	 * be a shadow stack PMD, which is logically writable.
>> +	 */
>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK))
>> +		return pmd_flags(pmd) & (_PAGE_RW | _PAGE_DIRTY);
> 
> 	else
> 
> 
>>   	return pmd_flags(pmd) & _PAGE_RW;
>>   }
>>  
