Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9563A2C9259
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 00:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgK3XRX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 18:17:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:14641 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgK3XRX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 18:17:23 -0500
IronPort-SDR: 2M66a1CBDUX2xv1RrxEuV7pYVhO0OMukquy7cf1L3M9fl4zADSbLKV8BAfGdBFGNlBwNUm43EX
 MNPXFz8x/nOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="172827551"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="172827551"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:16:42 -0800
IronPort-SDR: 8zNcFY7NhPl0VCOSeKl8PZxj5MKCbmm2A/J0IdXrJVCPnhKSv9Tcuho0ZMivcKfzjSj1RDIlJG
 /oGpjHi+WO/g==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480848257"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.122.22]) ([10.212.122.22])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:16:40 -0800
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
Message-ID: <3b83517e-17d6-3b53-6dbf-8ad727707b16@intel.com>
Date:   Mon, 30 Nov 2020 15:16:39 -0800
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
> 
[...]
> 
> Do we have any other spots in the kernel where we care about:
> 
> 	boot_cpu_has(X86_FEATURE_SHSTK) ||
> 	boot_cpu_has(X86_FEATURE_IBT)
> 
> ?  If so, we could also address this by declaring a software-defined
> X86_FEATURE_CET and then setting it if SHSTK||IBT is supported, then we
> just put that one feature in xsave_cpuid_features[].
> 

These features have different CPUIDs but are complementary parts.  I 
don't know if someday there will be shadow-stack-only CPUs, but an 
IBT-only CPU is weird.  What if the kernel checks that the CPU has both 
features and presents only one feature flag (X86_FEATURE_CET), no 
X86_FEATURE_SHSTK or X86_FEATURE_IBT?
