Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3565430B334
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 00:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhBAXPH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Feb 2021 18:15:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:3190 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhBAXPG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Feb 2021 18:15:06 -0500
IronPort-SDR: vvsdMPGtOstwkeFAigLeJ7e96AIiE57OEnec0WzMLYJwblskK6ZTyN+7J0Cijp1VKz6H9lCNmw
 DTJfPWhZwlWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="160532926"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="160532926"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 15:14:23 -0800
IronPort-SDR: mcN+Umk6rIyo2zAXvIJpEgfqd+QGtFe5nbhUxtGgLoSo83qgAZjbrRu1ShfsfVHBBnaY7wDomI
 5dYW9cgE5DKg==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="358783714"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.112.229]) ([10.212.112.229])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 15:14:21 -0800
Subject: Re: [PATCH v18 05/25] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <20210127212524.10188-1-yu-cheng.yu@intel.com>
 <20210127212524.10188-6-yu-cheng.yu@intel.com>
 <7793b36e-6386-3f2e-36ca-b7ca988a88c9@intel.com>
 <43f264df-2f3a-ea4c-c737-85cdc6714bd8@intel.com>
 <0a5a80c0-afc7-5f91-9e28-a300e30f1ab3@intel.com>
 <465836bd-9c80-fed9-d9af-89275ff810eb@intel.com>
 <cd8f4889-fbe4-fc0e-0686-9c9ecc4a125b@intel.com>
 <a6550292-cd99-a5e2-df7b-d43f6cc8fed0@intel.com>
 <834ac0ae-b03c-dfa0-3e91-72587226613f@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <ea573956-a739-aef6-6073-3216eb3158c6@intel.com>
Date:   Mon, 1 Feb 2021 15:14:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <834ac0ae-b03c-dfa0-3e91-72587226613f@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/1/2021 3:12 PM, Dave Hansen wrote:
> On 2/1/21 3:05 PM, Yu, Yu-cheng wrote:
>>>>
>>>
>>> Wait a sec...  What about *THIS* series?  Will *THIS* series give us
>>> oopses when userspace blasts a new XSAVE buffer in with NT_X86_XSTATE?
>>>
>>
>> Fortunately, CET states are supervisor states.  NT_x86_XSTATE has only
>> user states.
> 
> Ahhh, good point.  You did mention this in the changelog:
> 
>> Control-flow Enforcement Technology (CET) introduces these MSRs:
>>
>>      MSR_IA32_U_CET (user-mode CET settings),
>>      MSR_IA32_PL3_SSP (user-mode shadow stack pointer),
>>
>>      MSR_IA32_PL0_SSP (kernel-mode shadow stack pointer),
>>      MSR_IA32_PL1_SSP (Privilege Level 1 shadow stack pointer),
>>      MSR_IA32_PL2_SSP (Privilege Level 2 shadow stack pointer),
>>      MSR_IA32_S_CET (kernel-mode CET settings),
>>      MSR_IA32_INT_SSP_TAB (exception shadow stack table).
>>
>> The two user-mode MSRs belong to XFEATURE_CET_USER.  The first three of
>> kernel-mode MSRs belong to XFEATURE_CET_KERNEL.  Both XSAVES states are
>> supervisor states.
> 
> This is another great place to add some information about the feature.
> 
> "Both XSAVES states are supervisor states." ...  This means that there
> is no direct, unprivileged access to this state, making it harder for an
> attacker to subvert CET.
> 
> You could also allude to the future ptrace() support here.
> 

I will add that.
