Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC36302DA8
	for <lists+linux-arch@lfdr.de>; Mon, 25 Jan 2021 22:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbhAYV2w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Jan 2021 16:28:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:40418 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732639AbhAYV2p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Jan 2021 16:28:45 -0500
IronPort-SDR: qQemToLgMMZ59OKFRg4BQvDBfckkexbBzBk4PpAiPH126Dz75Y5yMs9dDGYIjhq25IYiX8ftK7
 Dg3uPJDK+Kow==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="158982823"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="158982823"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 13:27:54 -0800
IronPort-SDR: Zpt6kh4eRCAa6nhreOyas/x36owT9wmvFrJuKFK1hHDfdutyCbNqyanAiEN4kb+/4ZGudwMisH
 PLl97Bf6SEEg==
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="429441203"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.60.232]) ([10.212.60.232])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 13:27:52 -0800
Subject: Re: [PATCH v17 11/26] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
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
 <20201229213053.16395-12-yu-cheng.yu@intel.com>
 <20210125182709.GC23290@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <8084836b-4990-90e8-5c9a-97a920f0239e@intel.com>
Date:   Mon, 25 Jan 2021 13:27:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125182709.GC23290@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/25/2021 10:27 AM, Borislav Petkov wrote:
> On Tue, Dec 29, 2020 at 01:30:38PM -0800, Yu-cheng Yu wrote:

[...]

>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index 666c25ab9564..1c84f1ba32b9 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -1226,6 +1226,32 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>>   static inline void ptep_set_wrprotect(struct mm_struct *mm,
>>   				      unsigned long addr, pte_t *ptep)
>>   {
>> +	/*
>> +	 * Some processors can start a write, but end up seeing a read-only
>> +	 * PTE by the time they get to the Dirty bit.  In this case, they
>> +	 * will set the Dirty bit, leaving a read-only, Dirty PTE which
>> +	 * looks like a shadow stack PTE.
>> +	 *
>> +	 * However, this behavior has been improved
> 
> Improved how?

Processors supporting Shadow Stack will not set a read-only PTE's dirty 
bit.  I will revise the comments.

>> and will not occur on
>> +	 * processors supporting Shadow Stack.  Without this guarantee, a
> 
> Which guarantee? That it won't happen on CPUs which support SHSTK?
> 

Yes.

>> +	 * transition to a non-present PTE and flush the TLB would be
> 
> s/flush the TLB/TLB flush/
> 
>> +	 * needed.
>> +	 *
>> +	 * When changing a writable PTE to read-only and if the PTE has
>> +	 * _PAGE_DIRTY set, move that bit to _PAGE_COW so that the PTE is
>> +	 * not a shadow stack PTE.
>> +	 */
> 
> This sentence doesn't belong here as it refers to what pte_wrprotect()
> does. You could expand the comment in pte_wrprotect() with this here as
> it is better.

I will move this paragraph to pte_wrprotect().

> 
>> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
>> +		pte_t old_pte, new_pte;
>> +
>> +		do {
>> +			old_pte = READ_ONCE(*ptep);
>> +			new_pte = pte_wrprotect(old_pte);
> 
> Maybe I'm missing something but those two can happen outside of the
> loop, no? Or is *ptep somehow changing concurrently while the loop is
> doing the CMPXCHG and you need to recreate it each time?
> 
> IOW, you can generate upfront and do the empty loop...

*ptep can change concurrently.

> 
>> +
>> +		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
>> +
>> +		return;
>> +	}
>>   	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
>>   }
>>   

[...]
