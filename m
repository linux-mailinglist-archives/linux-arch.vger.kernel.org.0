Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B302CB03C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 23:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgLAWhV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 17:37:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:28888 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbgLAWhU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 17:37:20 -0500
IronPort-SDR: NmKS38+hxB13afkY7qpMGkYkb0vuiArue2OrNlKjpweFJ5vS8+YTeMxaKE9Hgvc/QJbQuPtSbv
 c9GTv7defVIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="191126641"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="191126641"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:23 -0800
IronPort-SDR: gGWS34BVjbVpM4Uca8QWpPqLLyH3hOV2FpuAteOqq+yvG+kmvBOlnGPfBBytF1SEuTL/OtAik5
 zNhntxWdRYwQ==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="537714613"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.4.202]) ([10.209.4.202])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:20 -0800
Subject: Re: [PATCH v15 03/26] x86/fpu/xstate: Introduce CET MSR XSAVES
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
        Pengfei Xu <pengfei.xu@intel.com>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-4-yu-cheng.yu@intel.com>
 <cfbd90a8-6996-fa7b-a41a-54ff540f419c@intel.com>
 <3b83517e-17d6-3b53-6dbf-8ad727707b16@intel.com>
 <705fdfec-25a4-60bc-868e-af515c731273@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <87f6309f-d5b4-a66f-99a1-d96a655290b6@intel.com>
Date:   Tue, 1 Dec 2020 14:35:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <705fdfec-25a4-60bc-868e-af515c731273@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/1/2020 2:26 PM, Dave Hansen wrote:
> On 11/30/20 3:16 PM, Yu, Yu-cheng wrote:
>>>
>>> Do we have any other spots in the kernel where we care about:
>>>
>>>      boot_cpu_has(X86_FEATURE_SHSTK) ||
>>>      boot_cpu_has(X86_FEATURE_IBT)
>>>
>>> ?  If so, we could also address this by declaring a software-defined
>>> X86_FEATURE_CET and then setting it if SHSTK||IBT is supported, then we
>>> just put that one feature in xsave_cpuid_features[].
>>>
>>
>> These features have different CPUIDs but are complementary parts.  I
>> don't know if someday there will be shadow-stack-only CPUs, but an
>> IBT-only CPU is weird.  What if the kernel checks that the CPU has both
>> features and presents only one feature flag (X86_FEATURE_CET), no
>> X86_FEATURE_SHSTK or X86_FEATURE_IBT?
> 
> Logically, that's probably fine.  But, X86_FEATURE_IBT/SHSTK are in a
> non-scattered leaf, so we'll kinda define them whether we like it or
> not.  We'd have to go out of our way to *not* define them.
> 

After more thoughts, I think it is better to just add X86_FEATURE_CET 
and not more.  We cannot predict what is going to happen later.
So, like what you suggested, X86_FEATURE_CET means (X86_FEATURE_SHSTK | 
X86_FEATURE_IBT).

Thanks,
Yu-cheng
