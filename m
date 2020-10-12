Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CA828C340
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 22:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgJLUsp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 16:48:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:32797 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgJLUsp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Oct 2020 16:48:45 -0400
IronPort-SDR: Ga9jL4XqRZoF/1D1vPbHZsHj3CpAhD1MgNQqMX+Mylk6bSQjbiKpXtgx504ddlcc0SLEVcLG2d
 aHJWxQBJQKZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="153633359"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="153633359"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:48:44 -0700
IronPort-SDR: H1g1CQHMtcwO1nWWiBZcdHpuTzPfruHJRRdh25uJeXaBoAYCtJIBhg3KVBUEXVaTG53rphSmVx
 fgUHljXAvRCA==
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="356745959"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.167.7]) ([10.209.167.7])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:48:43 -0700
Subject: Re: [PATCH v14 03/26] x86/fpu/xstate: Introduce CET MSR XSAVES
 supervisor states
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
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
References: <20201012153850.26996-1-yu-cheng.yu@intel.com>
 <20201012153850.26996-4-yu-cheng.yu@intel.com> <20201012195808.GD14048@grain>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <b98933fd-e424-1a14-6591-7ba598ab90c6@intel.com>
Date:   Mon, 12 Oct 2020 13:48:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201012195808.GD14048@grain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/12/2020 12:58 PM, Cyrill Gorcunov wrote:
> On Mon, Oct 12, 2020 at 08:38:27AM -0700, Yu-cheng Yu wrote:
> ...
>>   /*
>>    * x86-64 Task Priority Register, CR8
>> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>> index 038e19c0019e..705fd9b94e31 100644
>> --- a/arch/x86/kernel/fpu/xstate.c
>> +++ b/arch/x86/kernel/fpu/xstate.c
>> @@ -38,6 +38,9 @@ static const char *xfeature_names[] =
>>   	"Processor Trace (unused)"	,
>>   	"Protection Keys User registers",
>>   	"unknown xstate feature"	,
>> +	"Control-flow User registers"	,
>> +	"Control-flow Kernel registers"	,
>> +	"unknown xstate feature"	,
>>   };
>>   
>>   static short xsave_cpuid_features[] __initdata = {
>> @@ -51,6 +54,9 @@ static short xsave_cpuid_features[] __initdata = {
>>   	X86_FEATURE_AVX512F,
>>   	X86_FEATURE_INTEL_PT,
>>   	X86_FEATURE_PKU,
>> +	-1,		   /* Unused */
>> +	X86_FEATURE_SHSTK, /* XFEATURE_CET_USER */
>> +	X86_FEATURE_SHSTK, /* XFEATURE_CET_KERNEL */
>>   };
> 
> Why do you need "-1" here in the array? The only 1:1 mapping is between
> the names itselves and values, not indices of arrays so i don't understand
> why we need this unused value. Sorry if it is a dumb questions and
> been discussed already.
> 

The indices are used indirectly in fpu__init_system_xstate() to set bits 
in xfeatures_mask_all, i.e.

xfeatures_mask_all &= ~BIT_ULL(i).

So they need to match the xstate feature bits.

Yu-cheng
