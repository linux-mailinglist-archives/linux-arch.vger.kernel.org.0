Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A383231014C
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 01:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhBEAFw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 19:05:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:14579 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231489AbhBEAFv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 19:05:51 -0500
IronPort-SDR: 0UeHc/R3/uT49vGMWZ8rnrv7pbuQ8WtV4pCTDDHpcs2Cp6Jq0qOens5Pul97L/MmV9Y/W/HfpV
 o2rYvhH6bs1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="180574593"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="180574593"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 16:05:07 -0800
IronPort-SDR: 9A2nuYpdchNnFhxQ1CGsl6qyFnW7iy5YcAe2d5gQVNVNpooWZO9qu480lEdh9kTYpwCl6v+xI5
 XWocliCxxHWw==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="434165916"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.100.6]) ([10.209.100.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 16:05:05 -0800
Subject: Re: [PATCH v19 02/25] x86/cet/shstk: Add Kconfig option for user-mode
 control-flow protection
To:     Kees Cook <keescook@chromium.org>
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
 <20210203225547.32221-3-yu-cheng.yu@intel.com>
 <202102041154.F0264AC33@keescook>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <19793d76-6793-20a0-059c-cd153cf36a8b@intel.com>
Date:   Thu, 4 Feb 2021 16:05:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102041154.F0264AC33@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/4/2021 11:56 AM, Kees Cook wrote:
> On Wed, Feb 03, 2021 at 02:55:24PM -0800, Yu-cheng Yu wrote:
>> Shadow Stack provides protection against function return address
>> corruption.  It is active when the processor supports it, the kernel has
>> CONFIG_X86_CET enabled, and the application is built for the feature.
>> This is only implemented for the 64-bit kernel.  When it is enabled, legacy
>> non-Shadow Stack applications continue to work, but without protection.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> ---
>>   arch/x86/Kconfig           | 22 ++++++++++++++++++++++
>>   arch/x86/Kconfig.assembler |  5 +++++
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 21f851179ff0..074b3c0e6bf6 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1951,6 +1951,28 @@ config X86_SGX
>>   
>>   	  If unsure, say N.
>>   
>> +config ARCH_HAS_SHADOW_STACK
>> +	def_bool n
>> +
>> +config X86_CET
>> +	prompt "Intel Control-flow protection for user-mode"
>> +	def_bool n
>> +	depends on X86_64
>> +	depends on AS_WRUSS
>> +	select ARCH_USES_HIGH_VMA_FLAGS
>> +	select ARCH_HAS_SHADOW_STACK
> 
> This seems backwards to me? Shouldn't 'config X86_64' do the 'select
> ARCH_HAS_SHADOW_STACK' and 'config X86_CET' do a 'depends on
> ARCH_HAS_SHADOW_STACK' instead?

I will change it.  Thanks!

--
Yu-cheng
