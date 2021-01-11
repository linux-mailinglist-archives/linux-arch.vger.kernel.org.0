Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17932F20BC
	for <lists+linux-arch@lfdr.de>; Mon, 11 Jan 2021 21:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404169AbhAKUZx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jan 2021 15:25:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:35332 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403946AbhAKUZw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Jan 2021 15:25:52 -0500
IronPort-SDR: K0A3MjIdwgu+IJope8zHS713Rq6ZeVvK7AgVVC1IB7JsyTHWoGu0FzixOWIrQ+iaeTLNQLXAzM
 7/oFbLnXqWLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157709744"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157709744"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 12:25:11 -0800
IronPort-SDR: Dt8C4gv/BTd8wW9R3c0fF+bFblte/UVcjVFn9jevBPFF9vCHgBDoyYuJW9Fvs8g1H3zg3J60s1
 RQhA4mW+8QVA==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352739979"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.197.241]) ([10.212.197.241])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 12:25:08 -0800
Subject: Re: [PATCH v17 04/26] x86/cpufeatures: Introduce X86_FEATURE_CET and
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
        Pengfei Xu <pengfei.xu@intel.com>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-5-yu-cheng.yu@intel.com>
 <20210111175643.GD25645@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <7def977d-ce6b-e9b4-ea4a-467a9d652147@intel.com>
Date:   Mon, 11 Jan 2021 12:25:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111175643.GD25645@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/11/2021 9:56 AM, Borislav Petkov wrote:
> On Tue, Dec 29, 2020 at 01:30:31PM -0800, Yu-cheng Yu wrote:
>> @@ -895,6 +903,12 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
>>   	}
>>   }
>>   
>> +static void init_cet_features(struct cpuinfo_x86 *c)
>> +{
>> +	if (cpu_has(c, X86_FEATURE_SHSTK) || cpu_has(c, X86_FEATURE_IBT))
>> +		set_cpu_cap(c, X86_FEATURE_CET);
>> +}
> 
> No need for that function - just add this two-liner to bsp_init_intel()
> and not in get_cpu_cap().
> 

I will move these to bsp_init_intel(), and change to:

if (cpu_has(c, X86_FEATURE_SHSTK) || cpu_has(c, X86_FEATURE_IBT))
	setup_force_cpu_cap(X86_FEATURE_CET);

>> +static void adjust_combined_cpu_features(void)
>> +{
>> +#ifdef CONFIG_X86_CET_USER
>> +	if (test_bit(X86_FEATURE_SHSTK, (unsigned long *)cpu_caps_cleared) &&
>> +	    test_bit(X86_FEATURE_IBT, (unsigned long *)cpu_caps_cleared))
>> +		setup_clear_cpu_cap(X86_FEATURE_CET);
>> +#endif
> 
> There's no need for this function...
> 
>> +}
>> +
>>   /*
>>    * We parse cpu parameters early because fpu__init_system() is executed
>>    * before parse_early_param().
>> @@ -1252,9 +1276,19 @@ static void __init cpu_parse_early_param(void)
>>   	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
>>   		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
>>   
>> +	/*
>> +	 * CET states are XSAVES states and options must be parsed early.
>> +	 */
>> +#ifdef CONFIG_X86_CET_USER
>> +	if (cmdline_find_option_bool(boot_command_line, "no_user_shstk"))
>> +		setup_clear_cpu_cap(X86_FEATURE_SHSTK);
> 
> ... when you can do
> 
> 	setup_clear_cpu_cap(X86_FEATURE_CET);
> 
> here and...
> 
>> +	if (cmdline_find_option_bool(boot_command_line, "no_user_ibt"))
>> +		setup_clear_cpu_cap(X86_FEATURE_IBT);
> 
> ... here.
>

Two problems here.  X86_FEATURE_CET indicates either CET features is 
enabled, not both.  Also, "clearcpuid" can has CET features.  However, 
since X86_FEATURE_CET is now set in bsp_init_intel() (after 
cpu_parse_early_params()), I think, adjust_combined_cpu_features() can 
be removed.  I will test it.

--
Thanks,
Yu-cheng
