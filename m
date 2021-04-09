Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B809135A25C
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 17:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhDIPxJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 11:53:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:55410 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233827AbhDIPxI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Apr 2021 11:53:08 -0400
IronPort-SDR: yS1abaxNnF0/+r+/CWsctDT5nvXqp4KZQt7jW6m2SsbzWgQ3KW6IVRcGpnRHFy08Dl4REqD38T
 JjzGWz3U/bNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="180917390"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="180917390"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 08:52:54 -0700
IronPort-SDR: ZexAgEz/BljwHFGPfWGCgKkgzwrs3QaaLNLbxrVoN9CoognrzT4tz/PFTlwdtm7Fo28lWJvetr
 HFhg+y9x11CA==
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="520325087"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.27.140]) ([10.212.27.140])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 08:52:53 -0700
Subject: Re: [PATCH v24 04/30] x86/cpufeatures: Introduce X86_FEATURE_CET and
 setup functions
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-5-yu-cheng.yu@intel.com>
 <20210409101214.GC15567@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <c7cb0ed6-2725-ba0d-093e-393eab9918b2@intel.com>
Date:   Fri, 9 Apr 2021 08:52:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210409101214.GC15567@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/9/2021 3:12 AM, Borislav Petkov wrote:
> On Thu, Apr 01, 2021 at 03:10:38PM -0700, Yu-cheng Yu wrote:
>> Introduce a software-defined X86_FEATURE_CET, which indicates either Shadow
>> Stack or Indirect Branch Tracking (or both) is present.  Also introduce
>> related cpu init/setup functions.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> ---
>> v24:
>> - Update #ifdef placement to reflect Kconfig changes of splitting shadow stack and ibt.
>>
>>   arch/x86/include/asm/cpufeatures.h          |  2 +-
>>   arch/x86/include/asm/disabled-features.h    |  9 ++++++++-
>>   arch/x86/include/uapi/asm/processor-flags.h |  2 ++
>>   arch/x86/kernel/cpu/common.c                | 14 ++++++++++++++
>>   arch/x86/kernel/cpu/intel.c                 |  3 +++
>>   5 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index bf861fc89fef..d771e62677de 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -108,7 +108,7 @@
>>   #define X86_FEATURE_EXTD_APICID		( 3*32+26) /* Extended APICID (8 bits) */
>>   #define X86_FEATURE_AMD_DCM		( 3*32+27) /* AMD multi-node processor */
>>   #define X86_FEATURE_APERFMPERF		( 3*32+28) /* P-State hardware coordination feedback capability (APERF/MPERF MSRs) */
>> -/* free					( 3*32+29) */
>> +#define X86_FEATURE_CET			( 3*32+29) /* Control-flow enforcement */
> 
> Right, I know we talked about having this synthetic flag but now that we
> are moving to CONFIG_X86_SHADOW_STACK and separate SHSTK and IBT feature
> bits, that synthetic flag is not needed anymore.
> 
> For the cases where you wanna test whether any of the two are present,
> we're probably better off adding a x86_cet_enabled() helper which tests
> SHSTK and IBT bits.
> 

Recall we had complicated code for the XSAVES features detection in 
xstate.c.  Dave Hansen proposed the solution and then the whole thing 
becomes simple.  Because of this flag, even when only the shadow stack 
is available, the code handles it nicely.

> I haven't gone through the whole thing yet but depending on the context
> and the fact that AMD doesn't support IBT, that helper might need some
> tweaking too. I'll see.
> 
>>   #define X86_FEATURE_NONSTOP_TSC_S3	( 3*32+30) /* TSC doesn't stop in S3 state */
>>   #define X86_FEATURE_TSC_KNOWN_FREQ	( 3*32+31) /* TSC has known frequency */
>>   
>> diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
>> index e5c6ed9373e8..018cd7acd3e9 100644
>> --- a/arch/x86/include/asm/disabled-features.h
>> +++ b/arch/x86/include/asm/disabled-features.h
>> @@ -74,13 +74,20 @@
>>   #define DISABLE_SHSTK	(1 << (X86_FEATURE_SHSTK & 31))
>>   #endif
>>   
>> +#ifdef CONFIG_X86_CET
> 
> And you don't need that config item either - AFAICT, you can use
> CONFIG_X86_SHADOW_STACK everywhere.
> 
> Which would simplify that config space.

Would this equal to only CONFIG_X86_CET (one Kconfig option)?  In fact, 
when you proposed only CONFIG_X86_CET, things became much simpler.
Practically, IBT is not much in terms of code size.  Since we have 
already separated the two, why don't we leave it as-is.  When people 
start using it more, there will be more feedback, and we can decide if 
one Kconfig is better?

Thanks,
Yu-cheng
