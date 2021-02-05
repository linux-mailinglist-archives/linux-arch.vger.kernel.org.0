Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE24310DBE
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 17:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhBEOkC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 09:40:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:4778 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232766AbhBEOhh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Feb 2021 09:37:37 -0500
IronPort-SDR: wjxYUgnMWqf1ArrZ4LZT/msnNwj0GLEIskhMXtJlEU+9MncFvbvnTvhDUSNtE3MLVR4xJT/tEy
 yQ/V2OoeDYCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="181600524"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="181600524"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 08:15:04 -0800
IronPort-SDR: akZdZKUTioYDCFVHHy7cAMfgbH73YlLAuL7TEXfol7Nx3sovkJgDAGcc/VFRw85sHwb0MKm2y6
 7ZcStecAUDNw==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="583829114"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.95.7]) ([10.212.95.7])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 08:15:03 -0800
Subject: Re: [PATCH v19 04/25] x86/cpufeatures: Introduce X86_FEATURE_CET and
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
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-5-yu-cheng.yu@intel.com>
 <20210205134305.GG17488@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <ed295475-9799-9bc2-b4a3-681ba5a86824@intel.com>
Date:   Fri, 5 Feb 2021 08:15:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210205134305.GG17488@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/5/2021 5:43 AM, Borislav Petkov wrote:
> On Wed, Feb 03, 2021 at 02:55:26PM -0800, Yu-cheng Yu wrote:
>> @@ -1252,6 +1260,13 @@ static void __init cpu_parse_early_param(void)
>>   	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
>>   		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
>>   
>> +#ifdef CONFIG_X86_CET
>> +	if (cmdline_find_option_bool(boot_command_line, "no_user_shstk"))
>> +		setup_clear_cpu_cap(X86_FEATURE_SHSTK);
>> +	if (cmdline_find_option_bool(boot_command_line, "no_user_ibt"))
>> +		setup_clear_cpu_cap(X86_FEATURE_IBT);
>> +#endif
> 
> Any particular need for the ifdeffery?
> 

Right.  There is no need for that.  I will remove it.

--
Yu-cheng
