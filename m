Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B32C7296
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389906AbgK1VuL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:19349 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbgK1S16 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 28 Nov 2020 13:27:58 -0500
IronPort-SDR: OPOyZK1VZCtm/BBuZIpqX0JXtqLhMjp5uT/fRk3byxVsjAQ3AiAWZ2Su4mqrBuXDaudff1L3mF
 ASoqTe2vahHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9819"; a="159537056"
X-IronPort-AV: E=Sophos;i="5.78,377,1599548400"; 
   d="scan'208";a="159537056"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 08:24:00 -0800
IronPort-SDR: FDIYYBr2hlKPLMbEhzG7QTIT1dc8+Q0vPjFxJnrDDSbotYpzRlODAOgHg1F1ZOFB7gou8+8goX
 dGWqsJsDMvIw==
X-IronPort-AV: E=Sophos;i="5.78,377,1599548400"; 
   d="scan'208";a="480006706"
Received: from jckaplan-mobl1.amr.corp.intel.com (HELO [10.212.23.254]) ([10.212.23.254])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 08:23:59 -0800
Subject: Re: [PATCH v15 05/26] x86/cet/shstk: Add Kconfig option for user-mode
 Shadow Stack
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
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-6-yu-cheng.yu@intel.com>
 <20201127171012.GD13163@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <98e1b159-bf32-5c67-455b-f798023770ef@intel.com>
Date:   Sat, 28 Nov 2020 08:23:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201127171012.GD13163@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/27/2020 9:10 AM, Borislav Petkov wrote:
> On Tue, Nov 10, 2020 at 08:21:50AM -0800, Yu-cheng Yu wrote:
>> +config X86_CET
>> +	def_bool n
>> +
>> +config ARCH_HAS_SHADOW_STACK
>> +	def_bool n
>> +
>> +config X86_SHADOW_STACK_USER
> 
> Is X86_SHADOW_STACK_KERNEL coming too?
> 
> Regardless, you can add it when it comes and you can use only X86_CET
> for now and drop this one and simplify this pile of Kconfig symbols.

We have X86_BRANCH_TRACKING_USER too.  My thought was, X86_CET means any 
of kernel/user shadow stack/ibt.

> 
>> +	prompt "Intel Shadow Stacks for user-mode"
>> +	def_bool n
>> +	depends on CPU_SUP_INTEL && X86_64
>> +	depends on AS_HAS_SHADOW_STACK
>> +	select ARCH_USES_HIGH_VMA_FLAGS
>> +	select X86_CET
>> +	select ARCH_HAS_SHADOW_STACK
>> +	help
>> +	  Shadow Stacks provides protection against program stack
>> +	  corruption.  It's a hardware feature.  This only matters
>> +	  if you have the right hardware.  It's a security hardening
>> +	  feature and apps must be enabled to use it.  You get no
>> +	  protection "for free" on old userspace.  The hardware can
>> +	  support user and kernel, but this option is for user space
>> +	  only.
>> +	  Support for this feature is only known to be present on
>> +	  processors released in 2020 or later.  CET features are also
>> +	  known to increase kernel text size by 3.7 KB.
> 
> This help text needs some rewriting. You can find an inspiration about
> more adequate style in that same Kconfig file.
> 

I will work on it.

>> +
>> +	  If unsure, say N.
>> +
>>   config EFI
>>   	bool "EFI runtime service support"
>>   	depends on ACPI
>> diff --git a/scripts/as-x86_64-has-shadow-stack.sh b/scripts/as-x86_64-has-shadow-stack.sh
>> new file mode 100755
>> index 000000000000..fac1d363a1b8
>> --- /dev/null
>> +++ b/scripts/as-x86_64-has-shadow-stack.sh
>> @@ -0,0 +1,4 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +echo "wrussq %rax, (%rbx)" | $* -x assembler -c -
> 
> 						      2> /dev/null
> 
> otherwise you get
> 
> {standard input}: Assembler messages:
> {standard input}:1: Error: no such instruction: `wrussq %rax,(%rbx)
> 
> on non-enlightened toolchains during build.
> 

Yes, I will fix this in the next revision.

Yu-cheng

> Thx.
> 

