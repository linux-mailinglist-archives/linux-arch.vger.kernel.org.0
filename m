Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B6233DD77
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 20:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbhCPT1i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 15:27:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:14761 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240453AbhCPT12 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 15:27:28 -0400
IronPort-SDR: BPioQ3ofRZzr472243qqUpDI55zBo8dO9eroMkx45swn/9s/y1olKtsCqJO1clPem1txbROkak
 FgsajW/8BSrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="185960786"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="185960786"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 12:27:22 -0700
IronPort-SDR: uFgLa216tNsrzWIgcRCdtwQiM9p8zrA76JWNP1+VGm7SvOsa4P1fAsWowUhRqqtgPdRlhqiz7V
 CgKQgK3Q/nHA==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="372079895"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.191.248]) ([10.212.191.248])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 12:27:18 -0700
Subject: Re: [PATCH v23 9/9] x86/vdso: Add ENDBR to __vdso_sgx_enter_enclave
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
References: <20210316151320.6123-1-yu-cheng.yu@intel.com>
 <20210316151320.6123-10-yu-cheng.yu@intel.com> <YFEFhoi/SB12HUrg@kernel.org>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <b523b794-3553-f7bb-3a69-24d936f0fefa@intel.com>
Date:   Tue, 16 Mar 2021 12:27:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFEFhoi/SB12HUrg@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/16/2021 12:22 PM, Jarkko Sakkinen wrote:
> On Tue, Mar 16, 2021 at 08:13:19AM -0700, Yu-cheng Yu wrote:
>> ENDBR is a special new instruction for the Indirect Branch Tracking (IBT)
>> component of CET.  IBT prevents attacks by ensuring that (most) indirect
>> branches and function calls may only land at ENDBR instructions.  Branches
>> that don't follow the rules will result in control flow (#CF) exceptions.
>>
>> ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
>> instructions are inserted automatically by the compiler, but branch
>> targets written in assembly must have ENDBR added manually.
>>
>> Add ENDBR to __vdso_sgx_enter_enclave() branch targets.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> ---
>>   arch/x86/entry/vdso/vsgx.S | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
>> index 86a0e94f68df..1baa9b49053e 100644
>> --- a/arch/x86/entry/vdso/vsgx.S
>> +++ b/arch/x86/entry/vdso/vsgx.S
>> @@ -6,6 +6,7 @@
>>   #include <asm/enclu.h>
>>   
>>   #include "extable.h"
>> +#include "../calling.h"
>>   
>>   /* Relative to %rbp. */
>>   #define SGX_ENCLAVE_OFFSET_OF_RUN		16
>> @@ -27,6 +28,7 @@
>>   SYM_FUNC_START(__vdso_sgx_enter_enclave)
>>   	/* Prolog */
>>   	.cfi_startproc
>> +	ENDBR
>>   	push	%rbp
>>   	.cfi_adjust_cfa_offset	8
>>   	.cfi_rel_offset		%rbp, 0
>> @@ -62,6 +64,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
>>   .Lasync_exit_pointer:
>>   .Lenclu_eenter_eresume:
>>   	enclu
>> +	ENDBR
>>   
>>   	/* EEXIT jumps here unless the enclave is doing something fancy. */
>>   	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
>> @@ -91,6 +94,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
>>   	jmp	.Lout
>>   
>>   .Lhandle_exception:
>> +	ENDBR
>>   	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
>>   
>>   	/* Set the exception info. */
>> -- 
>> 2.21.0
>>
>>
> 
> Looks good to me.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks for reviewing.  In response to Dave's and Boris' comments, I will 
replace ENDBR macro with _CET_ENDBR that comes from the compiler.  Can I 
still keep the Reviewed-by?

> 
> /Jarkko
>
