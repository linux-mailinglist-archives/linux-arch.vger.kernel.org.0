Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823E72FF7E2
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 23:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbhAUWXE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 17:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbhAUWUs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jan 2021 17:20:48 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3ADC06174A;
        Thu, 21 Jan 2021 14:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=POte/V20qtU3wIuQT3uNCJADUsZhh5FbVb9IWDUrrs4=; b=uyVCjfYfVTODCwxqk/A+E0IzDf
        uTCGX1kPCj0FSi4X0iiI3s1XaFSpaHk1pmrnJF55fdLum7tmdzkChJVzRzu2d/m4d1tUGB9bSJ7ip
        WJGc1tiKWTbsDvIDdYiZiHi5CDoSxDUsOX6epa8G41U9vRXnwHxErti7FH0q3QqirdDKhMgbOqu8F
        /+uMp9dXC7mR3lOu2iLAQctykCnmZFoI+asaBc52ukmyCwYCeS13Lbm0x9ORRI35UbCOtZQx7g8FE
        OzcwW3w+E5YuQX8WfBC66vEYuEEH8jx45XX66lsbKh2ZGA2QfojjjlFh/D8SCnmW0tTOfgFVIFowE
        6WwQ+5MQ==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2iIn-0006iw-1d; Thu, 21 Jan 2021 22:19:41 +0000
Subject: Re: [PATCH v17 08/26] x86/mm: Introduce _PAGE_COW
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Yu, Yu-cheng'" <yu-cheng.yu@intel.com>,
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9344cd90-1818-a716-91d2-2b85df01347b@infradead.org>
Date:   Thu, 21 Jan 2021 14:19:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <cd9d04ab66d144b7942b5030d9813115@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/21/21 2:16 PM, David Laight wrote:
> From: Yu, Yu-cheng 
>>
>> On 1/21/2021 10:44 AM, Borislav Petkov wrote:
>>> On Tue, Dec 29, 2020 at 01:30:35PM -0800, Yu-cheng Yu wrote:
>> [...]
>>>> @@ -343,6 +349,16 @@ static inline pte_t pte_mkold(pte_t pte)
>>>>
>>>>   static inline pte_t pte_wrprotect(pte_t pte)
>>>>   {
>>>> +	/*
>>>> +	 * Blindly clearing _PAGE_RW might accidentally create
>>>> +	 * a shadow stack PTE (RW=0, Dirty=1).  Move the hardware
>>>> +	 * dirty value to the software bit.
>>>> +	 */
>>>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
>>>> +		pte.pte |= (pte.pte & _PAGE_DIRTY) >> _PAGE_BIT_DIRTY << _PAGE_BIT_COW;
>>>
>>> Why the unreadable shifting when you can simply do:
>>>
>>>                  if (pte.pte & _PAGE_DIRTY)
>>>                          pte.pte |= _PAGE_COW;
>>>
> 
>>> ?
>>
>> It clears _PAGE_DIRTY and sets _PAGE_COW.  That is,
>>
>> if (pte.pte & _PAGE_DIRTY) {
>> 	pte.pte &= ~_PAGE_DIRTY;
>> 	pte.pte |= _PAGE_COW;
>> }
>>
>> So, shifting makes resulting code more efficient.
> 
> Does the compiler manage to do one shift?
> 
> How can it clear anything?

It could shift it off either end since there are both
<< and >>.

> There is only an |= against the target.
> 
> Something horrid with ^= might set and clear.


-- 
~Randy
"He closes his eyes and drops the goggles.  You can't get hurt
by looking at a bitmap.  Or can you?"
(Neal Stephenson: Snow Crash)
