Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618692F3FCE
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 01:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbhALXCb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jan 2021 18:02:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:32015 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbhALXCa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Jan 2021 18:02:30 -0500
IronPort-SDR: RMO7RHKhKv9vip0YRrOcKlfQwRyvynVK/ATTUSKiWao9mEzs9qo3o3K2UEj9SFapyh8qf84MB4
 sy+Drv0cPZYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="174611842"
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="174611842"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 15:02:07 -0800
IronPort-SDR: zBMMKHAiBobVrLDfrDcDdJSqGxiTSdD34PT5PSkJ0OlBLjoAwyPye77F//xOR069fHpa7ys6T0
 P6adA37XOpHQ==
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="571845814"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.89.212]) ([10.212.89.212])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 15:02:06 -0800
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
References: <20201229213053.16395-5-yu-cheng.yu@intel.com>
 <20210111230900.5916-1-yu-cheng.yu@intel.com>
 <20210112123854.GE13086@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <0b144668-a989-6bc7-0b0d-2195d2d73397@intel.com>
Date:   Tue, 12 Jan 2021 15:02:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112123854.GE13086@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/12/2021 4:38 AM, Borislav Petkov wrote:
> On Mon, Jan 11, 2021 at 03:09:00PM -0800, Yu-cheng Yu wrote:
>> @@ -1252,6 +1260,16 @@ static void __init cpu_parse_early_param(void)
>>   	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
>>   		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
>>   
>> +	/*
>> +	 * CET states are XSAVES states and options must be parsed early.
>> +	 */
> 
> That comment is redundant - look at the containing function's name.
> 
> Otherwise patch looks just as it should.
> 
> Thx.
> 

Should I send an updated patch?  Thanks!

--
Yu-cheng
