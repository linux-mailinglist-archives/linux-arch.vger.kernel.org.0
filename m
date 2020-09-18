Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04790270827
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 23:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIRVZP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 17:25:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:40168 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgIRVZP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Sep 2020 17:25:15 -0400
IronPort-SDR: yOilVnswrj4ux1IPD2errlg1fU9PLGNc+Ym7Zqg4NDtf/+THt4vHat+sgAxggV65Be1MMk0VBq
 UQXnyTk48WSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="147719056"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="147719056"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 14:25:15 -0700
IronPort-SDR: ZiAjpg9H+lTWiWwlbjyUOoATbibiuL2QEtEgXKwIohCa+6zltUvTvc3s1u8mlpNXGGhxxqAhG7
 J6PuvaHWSUyQ==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="381051638"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.0.248]) ([10.212.0.248])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 14:25:13 -0700
Subject: Re: [PATCH v12 1/8] x86/cet/ibt: Add Kconfig option for user-mode
 Indirect Branch Tracking
To:     Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
 <20200918192312.25978-2-yu-cheng.yu@intel.com>
 <ce2524cc-081b-aec9-177a-11c7431cb20d@infradead.org>
 <20200918205933.GB4304@duo.ucw.cz>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <019b5e45-b116-7f3d-f1f2-3680afbd676c@intel.com>
Date:   Fri, 18 Sep 2020 14:25:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918205933.GB4304@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/18/2020 1:59 PM, Pavel Machek wrote:
> On Fri 2020-09-18 13:24:13, Randy Dunlap wrote:
>> Hi,
>>
>> If you do another version of this:
>>
>> On 9/18/20 12:23 PM, Yu-cheng Yu wrote:
>>> Introduce Kconfig option X86_INTEL_BRANCH_TRACKING_USER.
>>>
>>> Indirect Branch Tracking (IBT) provides protection against CALL-/JMP-
>>> oriented programming attacks.  It is active when the kernel has this
>>> feature enabled, and the processor and the application support it.
>>> When this feature is enabled, legacy non-IBT applications continue to
>>> work, but without IBT protection.
>>>
>>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>> ---
>>> v10:
>>> - Change build-time CET check to config depends on.
>>>
>>>   arch/x86/Kconfig | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index 6b6dad011763..b047e0a8d1c2 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -1963,6 +1963,22 @@ config X86_INTEL_SHADOW_STACK_USER
>>>   
>>>   	  If unsure, say y.
>>>   
>>> +config X86_INTEL_BRANCH_TRACKING_USER
>>> +	prompt "Intel Indirect Branch Tracking for user-mode"
>>> +	def_bool n
>>> +	depends on CPU_SUP_INTEL && X86_64
>>> +	depends on $(cc-option,-fcf-protection)
>>> +	select X86_INTEL_CET
>>> +	help
>>> +	  Indirect Branch Tracking (IBT) provides protection against
>>> +	  CALL-/JMP-oriented programming attacks.  It is active when
>>> +	  the kernel has this feature enabled, and the processor and
>>> +	  the application support it.  When this feature is enabled,
>>> +	  legacy non-IBT applications continue to work, but without
>>> +	  IBT protection.
>>> +
>>> +	  If unsure, say y
>>
>> 	  If unsure, say y.
> 
> Actually, it would be "If unsure, say Y.", to be consistent with the
> rest of the Kconfig.
> 
> But I wonder if Yes by default is good idea. Only very new CPUs will
> support this, right? Are they even available at the market? Should the
> help text say "if your CPU is Whatever Lake or newer, ...." :-) ?

I will revise the wording if there is another version.  But a 
CET-capable kernel can run on legacy systems.  We have been testing that 
combination.

Yu-cheng
