Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BD138F370
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhEXTDW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 15:03:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:4112 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233038AbhEXTDV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 15:03:21 -0400
IronPort-SDR: KsOQ6iihWiaMWpg9u29Abp0csjTSJibjasA371d8RikI0JSHe51+n/qqRUFYaqIsFP4RRHF4m0
 EnSjrdlTyntA==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="181645940"
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="181645940"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 12:01:53 -0700
IronPort-SDR: f2NKSKkNtLAQOGKQ/SQox+/Jw6D0hjpN+6PBQLNr2y/OYvAvHpL4bWaeDXnqhLPHZf+7BxKWLA
 kBPtNJtDgMJQ==
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="435385683"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.255.72.237]) ([10.255.72.237])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 12:01:49 -0700
Subject: Re: [PATCH v27 10/10] x86/vdso: Add ENDBR to __vdso_sgx_enter_enclave
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
References: <20210521221531.30168-1-yu-cheng.yu@intel.com>
 <20210521221531.30168-11-yu-cheng.yu@intel.com> <YKmJ6goXX9rxKnJA@kernel.org>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <32352b93-8aeb-db26-6018-c103a4f36dd8@intel.com>
Date:   Mon, 24 May 2021 12:01:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKmJ6goXX9rxKnJA@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/22/2021 3:47 PM, Jarkko Sakkinen wrote:
> On Fri, May 21, 2021 at 03:15:31PM -0700, Yu-cheng Yu wrote:
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
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> 
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
>> ---
>>   arch/x86/entry/vdso/vsgx.S | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
>> index 99dafac992e2..c7cb85d57b3f 100644
>> --- a/arch/x86/entry/vdso/vsgx.S
>> +++ b/arch/x86/entry/vdso/vsgx.S
>> @@ -4,6 +4,7 @@
>>   #include <asm/export.h>
>>   #include <asm/errno.h>
>>   #include <asm/enclu.h>
>> +#include <asm/vdso.h>
>>   
>>   #include "extable.h"
>>   
>> @@ -27,6 +28,7 @@
>>   SYM_FUNC_START(__vdso_sgx_enter_enclave)
>>   	/* Prolog */
>>   	.cfi_startproc
>> +	ENDBR64
>>   	push	%rbp
>>   	.cfi_adjust_cfa_offset	8
>>   	.cfi_rel_offset		%rbp, 0
>> @@ -62,6 +64,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
>>   .Lasync_exit_pointer:
>>   .Lenclu_eenter_eresume:
>>   	enclu
>> +	ENDBR64
>>   
>>   	/* EEXIT jumps here unless the enclave is doing something fancy. */
>>   	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
>> @@ -91,6 +94,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
>>   	jmp	.Lout
>>   
>>   .Lhandle_exception:
>> +	ENDBR64
>>   	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
>>   
>>   	/* Set the exception info. */
>> -- 
>> 2.21.0
>>
>>
> 
> /Jarkko
> 

Thanks!
