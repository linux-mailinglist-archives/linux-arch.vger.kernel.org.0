Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B988C2A9E47
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 20:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgKFTs3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 14:48:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:40742 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbgKFTs3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 14:48:29 -0500
IronPort-SDR: YkNyJTzaYPE4fSSR2WvKBG+k+KPF5TEh78pAeb60ocRRZ96rTnTtmRLNpmP2fZR6eG3HwDvA3u
 NiA7XaCLqLzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="148873272"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="148873272"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 11:48:28 -0800
IronPort-SDR: XWY1DSzfUHCDzW3P1xd2NX+4BKRs485qsAY5cE1o0IwtUqu34NsGNsziKs71hNgBCw0cL1p+oT
 TPFe28PRTE8w==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="472182452"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.221.127]) ([10.212.221.127])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 11:48:27 -0800
Subject: Re: [PATCH v14 02/26] x86/cpufeatures: Add CET CPU feature flags for
 Control-flow Enforcement Technology (CET)
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
        Pengfei Xu <pengfei.xu@intel.com>, Borislav Petkov <bp@suse.de>
References: <20201012153850.26996-1-yu-cheng.yu@intel.com>
 <20201012153850.26996-3-yu-cheng.yu@intel.com>
 <20201106184953.GI14914@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <94e82db0-381b-a140-ab74-f23b7c35949e@intel.com>
Date:   Fri, 6 Nov 2020 11:48:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201106184953.GI14914@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/6/2020 10:49 AM, Borislav Petkov wrote:
> On Mon, Oct 12, 2020 at 08:38:26AM -0700, Yu-cheng Yu wrote:
>> Add CPU feature flags for Control-flow Enforcement Technology (CET).
>>
>> CPUID.(EAX=7,ECX=0):ECX[bit 7] Shadow stack
>> CPUID.(EAX=7,ECX=0):EDX[bit 20] Indirect Branch Tracking
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Reviewed-by: Borislav Petkov <bp@suse.de>
> 
> This is not the patch I reviewed, why do you keep my Reviewed-by tag?

I will drop it.  It has been re-based many times, and probably I 
accidentally introduced something else?

> 
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> ---
>>   arch/x86/include/asm/cpufeatures.h       | 2 ++
>>   arch/x86/kernel/cpu/cpuid-deps.c         | 2 ++
>>   tools/arch/x86/include/asm/cpufeatures.h | 2 ++
>>   3 files changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index 2901d5df4366..c794e18e8a14 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -341,6 +341,7 @@
>>   #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
>>   #define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
>>   #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
>> +#define X86_FEATURE_SHSTK		(16*32+ 7) /* Shadow Stack */
>>   #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
>>   #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
>>   #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
>> @@ -370,6 +371,7 @@
>>   #define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
>>   #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
>>   #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
>> +#define X86_FEATURE_IBT			(18*32+20) /* Indirect Branch Tracking */
>>   #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
>>   #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
>>   #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
>> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
>> index 3cbe24ca80ab..fec83cc74b9e 100644
>> --- a/arch/x86/kernel/cpu/cpuid-deps.c
>> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
>> @@ -69,6 +69,8 @@ static const struct cpuid_dep cpuid_deps[] = {
>>   	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },
>>   	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
>>   	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
>> +	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
>> +	{ X86_FEATURE_IBT,			X86_FEATURE_XSAVES    },
>>   	{}
>>   };
>>   
>> diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
>> index 2901d5df4366..c794e18e8a14 100644
>> --- a/tools/arch/x86/include/asm/cpufeatures.h
>> +++ b/tools/arch/x86/include/asm/cpufeatures.h
>> @@ -341,6 +341,7 @@
>>   #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
>>   #define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
>>   #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
>> +#define X86_FEATURE_SHSTK		(16*32+ 7) /* Shadow Stack */
>>   #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
>>   #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
>>   #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
>> @@ -370,6 +371,7 @@
>>   #define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
>>   #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
>>   #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
>> +#define X86_FEATURE_IBT			(18*32+20) /* Indirect Branch Tracking */
>>   #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
>>   #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
>>   #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
> 
> We don't sync the respective change in tools/ - Arnaldo doe
Got it.  I will remove this.

Yu-cheng
