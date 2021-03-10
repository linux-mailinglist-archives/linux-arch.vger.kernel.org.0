Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04442334C0F
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 23:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhCJW4a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 17:56:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:13783 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhCJW4A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 17:56:00 -0500
IronPort-SDR: m0/E1qlyf/nrMRyOqGabwUgq+wv7VAEut8aIFd7kjO2PP7DHms6Qtmlw7t7/++Y2zDz8eOlgqH
 4Rmr5gLc3RNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="175683825"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="175683825"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:55:59 -0800
IronPort-SDR: vgwZzVqErYKUbnwXGaNZd9JIwqSzZBKODEvebckIrrOpn0/GLJKSjxkr67x9aoT/+38x2cDqv0
 ape7PH+LypIQ==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="403865286"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.23.206]) ([10.209.23.206])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:55:56 -0800
Subject: Re: [PATCH v22 8/8] x86/vdso: Add ENDBR64 to __vdso_sgx_enter_enclave
To:     Jarkko Sakkinen <jarkko@kernel.org>
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
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
References: <20210310220519.16811-1-yu-cheng.yu@intel.com>
 <20210310220519.16811-9-yu-cheng.yu@intel.com> <YElKjT2v628tidE/@kernel.org>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <8b8efe44-b79f-ce29-ee28-066f88c93840@intel.com>
Date:   Wed, 10 Mar 2021 14:55:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YElKjT2v628tidE/@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/10/2021 2:39 PM, Jarkko Sakkinen wrote:
> On Wed, Mar 10, 2021 at 02:05:19PM -0800, Yu-cheng Yu wrote:
>> When CET is enabled, __vdso_sgx_enter_enclave() needs an endbr64
>> in the beginning of the function.
> 
> OK.
> 
> What you should do is to explain what it does and why it's needed.
> 

The endbr marks a branch target.  Without the "no-track" prefix, if an 
indirect call/jmp reaches a non-endbr opcode, a control-protection fault 
is raised.  Usually endbr's are inserted by the compiler.  For assembly, 
these have to be put in manually.  I will add this in the commit log if 
there is another revision.  Thanks!

--
Yu-cheng

>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>>   arch/x86/entry/vdso/vsgx.S | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
>> index 86a0e94f68df..a70d4d09f713 100644
>> --- a/arch/x86/entry/vdso/vsgx.S
>> +++ b/arch/x86/entry/vdso/vsgx.S
>> @@ -27,6 +27,9 @@
>>   SYM_FUNC_START(__vdso_sgx_enter_enclave)
>>   	/* Prolog */
>>   	.cfi_startproc
>> +#ifdef CONFIG_X86_CET
>> +	endbr64
>> +#endif
>>   	push	%rbp
>>   	.cfi_adjust_cfa_offset	8
>>   	.cfi_rel_offset		%rbp, 0
>> -- 
>> 2.21.0
>>
>>
> 
> /Jarkko
> 

