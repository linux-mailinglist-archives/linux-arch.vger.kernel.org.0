Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27A63054E4
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 08:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317186AbhAZXgg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 18:36:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:20783 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389898AbhAZRHf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Jan 2021 12:07:35 -0500
IronPort-SDR: 9wuXSXAJ/fTnUCYvNVky7DM26HdRJlCUxFyLAx1+wFQwT0Ner8vwQY5NSzxsCcgR6uhcBZabko
 BSkpd4Ytrd7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="167603534"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="167603534"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 08:43:54 -0800
IronPort-SDR: eGwpQ92J/sX81sqArYH6+QIHP+J0S4EMZTaaYIKsSJxcLe0QKMCKSSF3yj0bW41zDIEqCl3g42
 x8Jj9aQHSdrg==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="504585840"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.153.84]) ([10.212.153.84])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 08:43:51 -0800
Subject: Re: [PATCH v17 11/26] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-12-yu-cheng.yu@intel.com>
 <20210125182709.GC23290@zn.tnic>
 <YA/W63sob0keoD+i@hirez.programming.kicks-ass.net>
 <YA/jlOuNpcPPNHA1@hirez.programming.kicks-ass.net>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <2f69ab09-57e8-6da0-07ab-5b885758fc27@intel.com>
Date:   Tue, 26 Jan 2021 08:43:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YA/jlOuNpcPPNHA1@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/26/2021 1:40 AM, Peter Zijlstra wrote:
> On Tue, Jan 26, 2021 at 09:46:36AM +0100, Peter Zijlstra wrote:
>> On Mon, Jan 25, 2021 at 07:27:09PM +0100, Borislav Petkov wrote:
>>
>>>> +		pte_t old_pte, new_pte;
>>>> +
>>>> +		do {
>>>> +			old_pte = READ_ONCE(*ptep);
>>>> +			new_pte = pte_wrprotect(old_pte);
>>>
>>> Maybe I'm missing something but those two can happen outside of the
>>> loop, no? Or is *ptep somehow changing concurrently while the loop is
>>> doing the CMPXCHG and you need to recreate it each time?
>>>
>>> IOW, you can generate upfront and do the empty loop...
>>>
>>>> +
>>>> +		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
>>>> +
>>>> +		return;
>>>> +	}
>>
>> Empty loop would be wrong, but that wants to be written like:
>>
>> 	old_pte = READ_ONCE(*ptep);
>> 	do {
>> 		new_pte = pte_wrprotect(old_pte);
>> 	} while (try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
> 
> ! went missing, too early, moar wake-up juice.
> 
>> Since try_cmpxchg() will update old_pte on failure.

Thanks Peter!  I will fix that.

--
Yu-cheng
