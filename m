Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B7930902B
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 23:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhA2Wfp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 17:35:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:14537 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhA2Wfo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 17:35:44 -0500
IronPort-SDR: dHlICr/bBKjj/s6kKxzyPrmxQjDfeizy2EwZPRU2RWp7BtfsrcY6f4BI5H226Rcuxe9TwN/VY4
 yuLIUPGw77rg==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="242012800"
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="242012800"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 14:35:02 -0800
IronPort-SDR: 8bq6hIfAMNgX92hbK4qH5hwd3yObjl/bcMQWw41W0LvWjm/TbPqtXNvZDJ35ASTSZm5aUQZoW5
 0tDrkCEfMImg==
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="411753322"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.73.214]) ([10.212.73.214])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 14:35:01 -0800
Subject: Re: [NEEDS-REVIEW] [PATCH v18 05/25] x86/fpu/xstate: Introduce CET
 MSR and XSAVES supervisor states
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
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <43f264df-2f3a-ea4c-c737-85cdc6714bd8@intel.com>
Date:   Fri, 29 Jan 2021 14:35:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <7793b36e-6386-3f2e-36ca-b7ca988a88c9@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/29/2021 1:00 PM, Dave Hansen wrote:
> On 1/27/21 1:25 PM, Yu-cheng Yu wrote:
>> @@ -135,6 +135,8 @@ enum xfeature {
>>   #define XFEATURE_MASK_PT		(1 << XFEATURE_PT_UNIMPLEMENTED_SO_FAR)
>>   #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
>>   #define XFEATURE_MASK_PASID		(1 << XFEATURE_PASID)
>> +#define XFEATURE_MASK_CET_USER		(1 << XFEATURE_CET_USER)
>> +#define XFEATURE_MASK_CET_KERNEL	(1 << XFEATURE_CET_KERNEL)
>>   #define XFEATURE_MASK_LBR		(1 << XFEATURE_LBR)
>>   
>>   #define XFEATURE_MASK_FPSSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
>> @@ -237,6 +239,23 @@ struct pkru_state {
>>   	u32				pad;
>>   } __packed;
>>   
>> +/*
>> + * State component 11 is Control-flow Enforcement user states
>> + */
>> +struct cet_user_state {
>> +	u64 user_cet;			/* user control-flow settings */
>> +	u64 user_ssp;			/* user shadow stack pointer */
>> +};
> 
> Andy Cooper just mentioned on IRC about this nugget in the spec:
> 
> 	XRSTORS on CET state will do reserved bit and canonicality
> 	checks on the state in similar manner as done by the WRMSR to
> 	these state elements.
> 
> We're using copy_kernel_to_xregs_err(), so the #GP *should* be OK.
> Could we prove this out in practice, please?
> 

Do we want to verify that setting reserved bits in CET XSAVES states 
triggers GP?  Then, yes, I just verified it again.  Thanks for 
reminding.  Do we have any particular case relating to this?

--
Yu-cheng
