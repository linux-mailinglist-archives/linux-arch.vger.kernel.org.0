Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD90B2D321A
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 19:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbgLHS0K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 13:26:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:29455 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730894AbgLHS0K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Dec 2020 13:26:10 -0500
IronPort-SDR: /yg7CeF3YvlmAQnd/x01t6+NXRWrpogDAn9HQAxozVRZT4CkfnTv3k2FaxfHf7o4iwsfhbAMex
 r18DfVZEjBDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="160995662"
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="160995662"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 10:25:29 -0800
IronPort-SDR: MVXY+ufzzjWpRkO/fcrw7djp1AEmJjNq9PnlBlwIbD8V1ZktkEzklCAxWd0oBRp2C8pAxGfKhi
 xQw8ZyCXIxMA==
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="317917122"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.139.184]) ([10.209.139.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 10:25:27 -0800
Subject: Re: [PATCH v15 08/26] x86/mm: Introduce _PAGE_COW
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
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-9-yu-cheng.yu@intel.com>
 <20201208175014.GD27920@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <218503f6-eec1-94b0-8404-6f92c55799e3@intel.com>
Date:   Tue, 8 Dec 2020 10:25:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201208175014.GD27920@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/8/2020 9:50 AM, Borislav Petkov wrote:
> On Tue, Nov 10, 2020 at 08:21:53AM -0800, Yu-cheng Yu wrote:
>> There is essentially no room left in the x86 hardware PTEs on some OSes
>> (not Linux).  That left the hardware architects looking for a way to
>> represent a new memory type (shadow stack) within the existing bits.
>> They chose to repurpose a lightly-used state: Write=0,Dirty=1.
> 
> It is not clear to me what the definition and semantics of that bit is.
> 
> +#define _PAGE_BIT_COW          _PAGE_BIT_SOFTW5 /* copy-on-write */
> 
> Is it set by hw or by sw and hw uses it to know it is a shadow stack
> page, and so on.
> 
> I think you should lead with its definition.

Ok.

...

>> Write=0,Dirty=1 PTEs.  In places where we do create them, we need to find
>> an alternative way to represent them _without_ using the same hardware bit
>> combination.  Thus, enter _PAGE_COW.  This results in the following:
>>
>> (a) A modified, copy-on-write (COW) page: (R/O + _PAGE_COW)
>> (b) A R/O page that has been COW'ed: (R/O + _PAGE_COW)
> 
> Both are "R/O + _PAGE_COW". Where's the difference? The dirty bit?

The PTEs are the same for both (a) and (b), but come from different routes.

>>      The user page is in a R/O VMA, and get_user_pages() needs a writable
>>      copy.  The page fault handler creates a copy of the page and sets
>>      the new copy's PTE as R/O and _PAGE_COW.
>> (c) A shadow stack PTE: (R/O + _PAGE_DIRTY_HW)
> 
> So W=0, D=1 ?

Yes.

>> (d) A shared shadow stack PTE: (R/O + _PAGE_COW)
>>      When a shadow stack page is being shared among processes (this happens
>>      at fork()), its PTE is cleared of _PAGE_DIRTY_HW, so the next shadow
>>      stack access causes a fault, and the page is duplicated and
>>      _PAGE_DIRTY_HW is set again.  This is the COW equivalent for shadow
>>      stack pages, even though it's copy-on-access rather than copy-on-write.
>> (e) A page where the processor observed a Write=1 PTE, started a write, set
>>      Dirty=1, but then observed a Write=0 PTE.
> 
> How does that happen? Something changed the PTE's W bit to 0 in-between?

Yes.

...

>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index b23697658b28..c88c7ccf0318 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -121,9 +121,9 @@ extern pmdval_t early_pmd_flags;
>>    * The following only work if pte_present() is true.
>>    * Undefined behaviour if not..
>>    */
>> -static inline int pte_dirty(pte_t pte)
>> +static inline bool pte_dirty(pte_t pte)
>>   {
>> -	return pte_flags(pte) & _PAGE_DIRTY_HW;
>> +	return pte_flags(pte) & _PAGE_DIRTY_BITS;
> 
> Why?
> 
> Does _PAGE_COW mean dirty too?

Yes.  Basically [read-only & dirty] is created by software.  Now the 
software uses a different bit.

>> @@ -343,6 +349,17 @@ static inline pte_t pte_mkold(pte_t pte)
>>   
>>   static inline pte_t pte_wrprotect(pte_t pte)
>>   {
>> +	/*
>> +	 * Blindly clearing _PAGE_RW might accidentally create
>> +	 * a shadow stack PTE (RW=0,Dirty=1).  Move the hardware
>> +	 * dirty value to the software bit.
>> +	 */
>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
>> +		pte.pte |= (pte.pte & _PAGE_DIRTY_HW) >>
>> +			   _PAGE_BIT_DIRTY_HW << _PAGE_BIT_COW;
> 
> Let that line stick out. And that shifting is not grokkable at a quick
> glance, at least not to me. Simplify?

Ok.

>>   static inline pmd_t pmd_wrprotect(pmd_t pmd)
>>   {
>> +	/*
>> +	 * Blindly clearing _PAGE_RW might accidentally create
>> +	 * a shadow stack PMD (RW=0,Dirty=1).  Move the hardware
>> +	 * dirty value to the software bit.
> 
> This whole carefully sidestepping the possiblity of creating a shadow
> stack pXd is kinda sucky...
> 
>> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
>> index 7462a574fc93..5f764d8d9bae 100644
>> --- a/arch/x86/include/asm/pgtable_types.h
>> +++ b/arch/x86/include/asm/pgtable_types.h
>> @@ -23,7 +23,8 @@
>>   #define _PAGE_BIT_SOFTW2	10	/* " */
>>   #define _PAGE_BIT_SOFTW3	11	/* " */
>>   #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
>> -#define _PAGE_BIT_SOFTW4	58	/* available for programmer */
>> +#define _PAGE_BIT_SOFTW4	57	/* available for programmer */
>> +#define _PAGE_BIT_SOFTW5	58	/* available for programmer */
>>   #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
>>   #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
>>   #define _PAGE_BIT_PKEY_BIT2	61	/* Protection Keys, bit 3/4 */
>> @@ -36,6 +37,16 @@
>>   #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
>>   #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
>>   
>> +/*
>> + * This bit indicates a copy-on-write page, and is different from
>> + * _PAGE_BIT_SOFT_DIRTY, which tracks which pages a task writes to.
>> + */
>> +#ifdef CONFIG_X86_64
> 
> CONFIG_X86_64 ? Do all x86 machines out there support CET?
> 
> If anything, CONFIG_X86_CET...

Ok.

--
Yu-cheng
