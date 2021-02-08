Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E8F31436D
	for <lists+linux-arch@lfdr.de>; Tue,  9 Feb 2021 00:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhBHXEf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 18:04:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:39580 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhBHXEc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Feb 2021 18:04:32 -0500
IronPort-SDR: uM2xztBP8WqeggSLNW9fPwP7L5HM9d0qFDFdPf0tKGf8TvcT+UYWUi4c3pBoYLAAqXqxVIgl/q
 hfYneGTf7k5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="178284707"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="178284707"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 15:03:50 -0800
IronPort-SDR: 6GEVXz/VgALvszVbd0TdqgdmvophOiP8mEI+0QbfRkrsOKkVyCH9sNyQbMCxLLxK5UlgBJvyVo
 O6/xZ0f0qpKg==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="358962658"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.11.33]) ([10.251.11.33])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 15:03:48 -0800
Subject: Re: [PATCH v19 08/25] x86/mm: Introduce _PAGE_COW
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>
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
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-9-yu-cheng.yu@intel.com>
 <202102041215.B54FCA552F@keescook>
 <2e43bf0b-e1a9-99f6-8d5d-d6e6886b4217@intel.com>
 <7381d8c1-5e1c-2667-7cb8-0a99f2c79b6d@intel.com>
Message-ID: <ce8e9493-4590-84dc-bc70-1105a53df3eb@intel.com>
Date:   Mon, 8 Feb 2021 15:03:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <7381d8c1-5e1c-2667-7cb8-0a99f2c79b6d@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/5/2021 10:41 AM, Yu, Yu-cheng wrote:
> On 2/4/2021 12:27 PM, Dave Hansen wrote:
>> On 2/4/21 12:19 PM, Kees Cook wrote:
>>>> (e) A page where the processor observed a Write=1 PTE, started a 
>>>> write, set
>>>>      Dirty=1, but then observed a Write=0 PTE.  That's possible 
>>>> today, but
>>>>      will not happen on processors that support shadow stack.
>>> What happens for "e" with/without CET? It sounds like direct writes to
>>> such pages will be (correctly) rejected by the MMU?
>>
>> A page fault would be generated regardless of CET support.
>>
>> If CET were not around, the fault would be reported as a present, write
>> fault.
>>
>> If this happened and CET were around (which shouldn't happen in
>> practice, it means we have a hardware issue) a page fault exception is
>> generated. 
> 
> Thanks for the clarification.  With or without CET, direct write to 
> Write=0, Dirty=1 PTE triggers page fault.
> 
>> Yu-cheng, I'm not sure there's enough debugging around to
>> tell us if this happens.  Would we even notice?
> 
> That potential hardware issue is, on a CET-capable system, a processor 
> writes to a Write=1, Dirty=0 page, and then observes the PTE is Write=0, 
> Dirty=1.  Let me think about it...
> 

One way to detect the potential issue is adding a check when a 
non-shadow stack page's PTE goes from RW=0 to RW=1, like the following...

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 29aa6f07e3c9..241b94a0fa77 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -405,6 +405,8 @@ static inline pte_t pte_mkyoung(pte_t pte)
  static inline pte_t pte_mkwrite(pte_t pte)
  {
  	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		WARN_ONCE((pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY)) ==
+			  _PAGE_DIRTY, "Found transient shadow stack PTE\n");
  		if (pte_flags(pte) & _PAGE_COW) {
  			pte = pte_clear_flags(pte, _PAGE_COW);
  			pte = pte_set_flags(pte, _PAGE_DIRTY);

I run all my routine stress tests with the changes, and do not see any 
warning triggered.  If this change is desirable, we can probably add 
#ifdef CONFIG_DEBUG_VM around it and make it a separate patch.

--
Yu-cheng
