Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA852C8C86
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 19:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbgK3SR4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 13:17:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:6957 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388071AbgK3SRw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 13:17:52 -0500
IronPort-SDR: wj5Dzt4t1e8jeh6eHiiSFfBl4zWQ1rUJUit/MrUwRmJ0ORHcy0BUGxMbDJANiHtZ+QI+DQ4HOl
 C9xh77ZZrfQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="160457112"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="160457112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 10:17:11 -0800
IronPort-SDR: Po7ha/fJ6IXwregsxpli6VTfXr+znPuolwEztJizbK2473bykZTG02oYFxl670BEDxM3PIUpwE
 f6imrB/W1kIA==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="434379152"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.122.22]) ([10.212.122.22])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 10:17:09 -0800
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
 <f7033860-f322-fe13-fdc1-552e8777f003@intel.com>
 <31c8dabc-185d-be7b-c800-30a7ff29b34e@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <0110eba0-09cd-ace8-57d3-859475610b42@intel.com>
Date:   Mon, 30 Nov 2020 10:17:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <31c8dabc-185d-be7b-c800-30a7ff29b34e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/30/2020 10:12 AM, Dave Hansen wrote:
> On 11/30/20 10:06 AM, Yu, Yu-cheng wrote:
>>>> +            if (!boot_cpu_has(X86_FEATURE_SHSTK) &&
>>>> +                !boot_cpu_has(X86_FEATURE_IBT))
>>>> +                xfeatures_mask_all &= ~BIT_ULL(i);
>>>> +        } else {
>>>> +            if ((xsave_cpuid_features[i] == -1) ||
>>>
>>> Where did the -1 come from?  Was that introduced earlier in this series?
>>>    I don't see any way a xsave_cpuid_features[] can be -1 in the
>>> current tree.
>>
>> Yes, we used to have a hole in xsave_cpuid_features[] and put -1 there.
>> Do we want to keep this in case we again have holes in the future?
> 
> So, it's dead code for the moment and it's impossible to tell what -1
> means without looking at git history?  That seems, um, suboptimal.
> 
> Shouldn't we have:
> 
> #define XFEATURE_NO_DEP -1
> 
> ?
> 
> And then this code becomes:
> 
> 	if ((xsave_cpuid_features[i] == XFEATURE_NO_DEP))
> 		// skip it...
> 
> We can even put a comment in xsave_cpuid_features[] to tell folks to use
> it.
> 

Yes, I will work on that.

Yu-cheng
