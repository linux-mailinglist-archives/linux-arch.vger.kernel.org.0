Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90BA300F70
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jan 2021 22:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbhAVV4N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jan 2021 16:56:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:50183 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730000AbhAVVzl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Jan 2021 16:55:41 -0500
IronPort-SDR: 9q3S4emmk4xclOw/YXm/yZII8Ovg/ah2F38SDUKp0EqM6nryCd3wUb4PA09QOpFP4aklCGwW0H
 duX7C1HTlQhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="198274442"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="198274442"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 13:54:55 -0800
IronPort-SDR: QgzfLeU+SScNpiuZ2ShHor3Mk1anNcKXZI/IncTCR7ogj4sTRd8kBKfwZPHV0PQyfLDml4sqvL
 fM8zo+rax78Q==
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="400976899"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.79.184]) ([10.212.79.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 13:54:54 -0800
Subject: Re: [PATCH v17 08/26] x86/mm: Introduce _PAGE_COW
To:     David Laight <David.Laight@ACULAB.COM>,
        'Randy Dunlap' <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
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
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-9-yu-cheng.yu@intel.com>
 <20210121184405.GE32060@zn.tnic>
 <b4d4bec7-504e-2443-4cf3-0801b179000f@intel.com>
 <cd9d04ab66d144b7942b5030d9813115@AcuMS.aculab.com>
 <9344cd90-1818-a716-91d2-2b85df01347b@infradead.org>
 <b6eda0f414f34634b4e1aca80c4b5d5d@AcuMS.aculab.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <1b9cd39a-fe66-d237-b847-2b62ff1477e7@intel.com>
Date:   Fri, 22 Jan 2021 13:54:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <b6eda0f414f34634b4e1aca80c4b5d5d@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/21/2021 2:32 PM, David Laight wrote:
> From: Randy Dunlap
>> Sent: 21 January 2021 22:19
>>
>> On 1/21/21 2:16 PM, David Laight wrote:
>>> From: Yu, Yu-cheng
>>>>
>>>> On 1/21/2021 10:44 AM, Borislav Petkov wrote:
>>>>> On Tue, Dec 29, 2020 at 01:30:35PM -0800, Yu-cheng Yu wrote:
>>>> [...]
>>>>>> @@ -343,6 +349,16 @@ static inline pte_t pte_mkold(pte_t pte)
>>>>>>
>>>>>>    static inline pte_t pte_wrprotect(pte_t pte)
>>>>>>    {
>>>>>> +	/*
>>>>>> +	 * Blindly clearing _PAGE_RW might accidentally create
>>>>>> +	 * a shadow stack PTE (RW=0, Dirty=1).  Move the hardware
>>>>>> +	 * dirty value to the software bit.
>>>>>> +	 */
>>>>>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
>>>>>> +		pte.pte |= (pte.pte & _PAGE_DIRTY) >> _PAGE_BIT_DIRTY << _PAGE_BIT_COW;
>>>>>
>>>>> Why the unreadable shifting when you can simply do:
>>>>>
>>>>>                   if (pte.pte & _PAGE_DIRTY)
>>>>>                           pte.pte |= _PAGE_COW;
>>>>>
>>>
>>>>> ?
>>>>
>>>> It clears _PAGE_DIRTY and sets _PAGE_COW.  That is,
>>>>
>>>> if (pte.pte & _PAGE_DIRTY) {
>>>> 	pte.pte &= ~_PAGE_DIRTY;
>>>> 	pte.pte |= _PAGE_COW;
>>>> }
>>>>
>>>> So, shifting makes resulting code more efficient.
>>>
>>> Does the compiler manage to do one shift?
>>>
>>> How can it clear anything?
>>
>> It could shift it off either end since there are both << and >>.
> 
> It is still:
> 	pte.pte |= xxxxxxx;
> 
>>> There is only an |= against the target.
>>>
>>> Something horrid with ^= might set and clear.
> 
> It could be 4 instructions:
> 	is_dirty = pte.pte & PAGE_DIRTY;
> 	pte.pte &= ~PAGE_DIRTY; // or pte.pte ^= is_dirty
> 	is_cow = is_dirty << (BIT_COW - BIT_DIRTY); // or equivalent >>
> 	pte.pte |= is_cow;
> provided you've a three operand form for one of the first two instructions.
> Something like ARM might manage to merge the last two as well.
> But the register dependency chain length may matter more than
> the number of instructions.
> The above is likely to be three long.

I see what you are saying.  The patch is like...

	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
		pte.pte |= (pte.pte & _PAGE_DIRTY) >> _PAGE_BIT_DIRTY << _PAGE_BIT_COW;
		pte = pte_clear_flags(pte, _PAGE_DIRTY);
	}

It is not necessary to do the shifting.  I will make it, simply,

if (pte.pte & _PAGE_DIRTY) {
	pte.pte &= ~PAGE_DIRTY;
	pte.pte |= _PAGE_COW;
}

Thanks for your comments.

--
Yu-cheng
