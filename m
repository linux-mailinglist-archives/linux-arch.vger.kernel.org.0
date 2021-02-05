Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E99B310161
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 01:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhBEALA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 19:11:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:33647 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231567AbhBEAK6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 19:10:58 -0500
IronPort-SDR: dcLHhzwVxGlhA6eizk0mzgYgWHL+jGH4p6IPB6bUnlIVtrBr4+bx13YGCPN5JE42rVzSM8BOWL
 J7JQ2BqAmDkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="245422593"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="245422593"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 16:10:16 -0800
IronPort-SDR: FyGhBUUZHeP4fcvvfhWFvX9OftF/q5PlQTD0LPuXDJkP8OJ1TrRk/5I7SgFZh+TPiGSD+cMsTm
 9ZdEZg3R6jTw==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="434168522"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.100.6]) ([10.209.100.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 16:10:14 -0800
Subject: Re: [PATCH v19 06/25] x86/cet: Add control-protection fault handler
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-7-yu-cheng.yu@intel.com>
 <202102041201.C2B93F8D8A@keescook>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <518c6ce4-1e6e-ef8d-ba55-fb35a828b874@intel.com>
Date:   Thu, 4 Feb 2021 16:10:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102041201.C2B93F8D8A@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/4/2021 12:09 PM, Kees Cook wrote:
> On Wed, Feb 03, 2021 at 02:55:28PM -0800, Yu-cheng Yu wrote:

[...]

>> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
>> index 7f5aec758f0e..f5354c35df32 100644
>> --- a/arch/x86/kernel/traps.c
>> +++ b/arch/x86/kernel/traps.c
>> @@ -606,6 +606,66 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>>   	cond_local_irq_disable(regs);
>>   }
>>   
>> +#ifdef CONFIG_X86_CET
>> +static const char * const control_protection_err[] = {
>> +	"unknown",
>> +	"near-ret",
>> +	"far-ret/iret",
>> +	"endbranch",
>> +	"rstorssp",
>> +	"setssbsy",
>> +};
>> +
>> +/*
>> + * When a control protection exception occurs, send a signal to the responsible
>> + * application.  Currently, control protection is only enabled for user mode.
>> + * This exception should not come from kernel mode.
>> + */
>> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
>> +{
>> +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>> +				      DEFAULT_RATELIMIT_BURST);
>> +	struct task_struct *tsk;
>> +
>> +	if (!user_mode(regs)) {
>> +		pr_emerg("PANIC: unexpected kernel control protection fault\n");
>> +		die("kernel control protection fault", regs, error_code);
>> +		panic("Machine halted.");
>> +	}
>> +
>> +	cond_local_irq_enable(regs);
>> +
>> +	if (!boot_cpu_has(X86_FEATURE_CET))
>> +		WARN_ONCE(1, "Control protection fault with CET support disabled\n");
>> +
>> +	tsk = current;
>> +	tsk->thread.error_code = error_code;
>> +	tsk->thread.trap_nr = X86_TRAP_CP;
>> +
>> +	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
>> +	    __ratelimit(&rs)) {
>> +		unsigned int max_err;
>> +		unsigned long ssp;
>> +
>> +		max_err = ARRAY_SIZE(control_protection_err) - 1;
>> +		if (error_code < 0 || error_code > max_err)
>> +			error_code = 0;
> 
> Do you want to mask the error_code here before printing its value?
> 
>> +
>> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
>> +		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",
>> +			 tsk->comm, task_pid_nr(tsk),
>> +			 regs->ip, regs->sp, ssp, error_code,
>> +			 control_protection_err[error_code]);
> 
> Instead, you could clamp error_code to ARRAY_SIZE(control_protection_err),
> and add another "unknown" to the end of the strings:
> 
> 	control_protection_err[
> 		array_index_nospec(error_code,
> 				   ARRAY_SIZE(control_protection_err))]
> 
> Everything else looks good.
> 

I will update it.  Thanks!

[...]
