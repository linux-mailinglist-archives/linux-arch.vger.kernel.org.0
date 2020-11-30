Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EC22C8C30
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 19:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbgK3SHh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 13:07:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:18018 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387909AbgK3SHg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 13:07:36 -0500
IronPort-SDR: q4MabAbvuM0VMN+HgVfV/jdWQDUnTK6UpkpE8gQUOqLCZZEE85C1UQB+E4sSeEWEduNZfc/wXg
 0sBhgtYLNGLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="172840743"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="172840743"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 10:06:46 -0800
IronPort-SDR: T20GPPSwMpACGku0A3bOgvbDrmPBnW+ofNlM66gbp1FnJ2Upsugpg3aok/xDI9Wreu0Axpnhyy
 xK5NhOzAiVzQ==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="434372879"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.122.22]) ([10.212.122.22])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 10:06:44 -0800
Subject: Re: [NEEDS-REVIEW] [PATCH v15 03/26] x86/fpu/xstate: Introduce CET
 MSR XSAVES supervisor states
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
        Pengfei Xu <pengfei.xu@intel.com>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-4-yu-cheng.yu@intel.com>
 <cfbd90a8-6996-fa7b-a41a-54ff540f419c@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <f7033860-f322-fe13-fdc1-552e8777f003@intel.com>
Date:   Mon, 30 Nov 2020 10:06:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <cfbd90a8-6996-fa7b-a41a-54ff540f419c@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/30/2020 9:45 AM, Dave Hansen wrote:
> On 11/10/20 8:21 AM, Yu-cheng Yu wrote:
>> Control-flow Enforcement Technology (CET) adds five MSRs.  Introduce
>> them and their XSAVES supervisor states:
>>
>>      MSR_IA32_U_CET (user-mode CET settings),
>>      MSR_IA32_PL3_SSP (user-mode Shadow Stack pointer),
>>      MSR_IA32_PL0_SSP (kernel-mode Shadow Stack pointer),
>>      MSR_IA32_PL1_SSP (Privilege Level 1 Shadow Stack pointer),
>>      MSR_IA32_PL2_SSP (Privilege Level 2 Shadow Stack pointer).
> 
> This patch goes into a bunch of XSAVE work that this changelog only
> briefly touches on.  I think it needs to be beefed up a bit.

I will do that.

> 
>> @@ -835,8 +843,19 @@ void __init fpu__init_system_xstate(void)
>>   	 * Clear XSAVE features that are disabled in the normal CPUID.
>>   	 */
>>   	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
>> -		if (!boot_cpu_has(xsave_cpuid_features[i]))
>> -			xfeatures_mask_all &= ~BIT_ULL(i);
>> +		if (xsave_cpuid_features[i] == X86_FEATURE_SHSTK) {
>> +			/*
>> +			 * X86_FEATURE_SHSTK and X86_FEATURE_IBT share
>> +			 * same states, but can be enabled separately.
>> +			 */
>> +			if (!boot_cpu_has(X86_FEATURE_SHSTK) &&
>> +			    !boot_cpu_has(X86_FEATURE_IBT))
>> +				xfeatures_mask_all &= ~BIT_ULL(i);
>> +		} else {
>> +			if ((xsave_cpuid_features[i] == -1) ||
> 
> Where did the -1 come from?  Was that introduced earlier in this series?
>   I don't see any way a xsave_cpuid_features[] can be -1 in the current tree.
> 

Yes, we used to have a hole in xsave_cpuid_features[] and put -1 there. 
Do we want to keep this in case we again have holes in the future?

>> +			    !boot_cpu_has(xsave_cpuid_features[i]))
>> +				xfeatures_mask_all &= ~BIT_ULL(i);
>> +		}
>>   	}
> 
> Do we have any other spots in the kernel where we care about:
> 
> 	boot_cpu_has(X86_FEATURE_SHSTK) ||
> 	boot_cpu_has(X86_FEATURE_IBT)
> 
> ?  If so, we could also address this by declaring a software-defined
> X86_FEATURE_CET and then setting it if SHSTK||IBT is supported, then we
> just put that one feature in xsave_cpuid_features[].

That is a better solution.  I will look into that.

> 
> I'm also not crazy about the loop as it is.  I'd much rather see this in
> a helper like:
> 
> bool cpu_supports_xsave_deps(int xfeature)
> {
> 	bool ret;
> 
> 	ret = boot_cpu_has(xsave_cpuid_features[xfeature])
> 
> 	/*
> 	 * X86_FEATURE_SHSTK is checked in xsave_cpuid_features()
> 	 * but the CET states are needed if either SHSTK or IBT are
> 	 * available.
> 	 */
> 	if (xfeature == XFEATURE_CET_USER ||
> 	    xfeature == XFEATURE_CET_KERNEL)
> 		ret |= boot_cpu_has(X86_FEATURE_IBT)
> 		
> 	return ret;
> }
> 
> See how that's extensible?  You can add as many special cases as you want.
> 

Yes.

Thanks,
Yu-cheng
