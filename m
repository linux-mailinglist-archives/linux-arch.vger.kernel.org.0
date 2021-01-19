Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7FF2FC024
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jan 2021 20:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbhASThq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 14:37:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:26308 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729697AbhASThP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Jan 2021 14:37:15 -0500
IronPort-SDR: 0+4H1OMbq+Z3k3dNpg8TMaQ1vi7Vf67YJi4WVAtnLlhUNA0oBllE1cqyLmxczgLDudxOuUD88t
 xPN7QhvFlcQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="240525703"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="240525703"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 11:36:34 -0800
IronPort-SDR: fm0aLemlT7MG5HKCe9xsp1Ifq+9Zp6/U4cGc0toMhg5UJPQKq6ePMCdEJXKxy7GxDh5YS8dhzE
 eRpoNdU525fw==
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="501042644"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.139.183]) ([10.209.139.183])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 11:36:32 -0800
Subject: Re: [PATCH v17 06/26] x86/cet: Add control-protection fault handler
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
        Pengfei Xu <pengfei.xu@intel.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-7-yu-cheng.yu@intel.com>
 <20210119120425.GI27433@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <a6b18663-a53d-60bc-57e8-8b327a169bc4@intel.com>
Date:   Tue, 19 Jan 2021 11:36:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119120425.GI27433@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/19/2021 4:04 AM, Borislav Petkov wrote:
> On Tue, Dec 29, 2020 at 01:30:33PM -0800, Yu-cheng Yu wrote:
[...]
>> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
>> +{
>> +	struct task_struct *tsk;
>> +
>> +	if (!user_mode(regs)) {
>> +		if (notify_die(DIE_TRAP, "control protection fault", regs,
>> +			       error_code, X86_TRAP_CP, SIGSEGV) == NOTIFY_STOP)
>> +			return;
>> +		die("Upexpected/unsupported kernel control protection fault", regs, error_code);
> 
> Isn't the machine supposed to panic() here and do no further progress?

Ok, make it panic().

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
>> +	    printk_ratelimit()) {
> 
> WARNING: Prefer printk_ratelimited or pr_<level>_ratelimited to printk_ratelimit
> #136: FILE: arch/x86/kernel/traps.c:645:
> +	    printk_ratelimit()) {
> 
> Still not using checkpatch?

Most places in arch/x86 still use printk_ratelimit().  I should have 
trusted checkpatch.  I will fix it.

>> +		unsigned int max_err;
>> +		unsigned long ssp;
>> +
>> +		max_err = ARRAY_SIZE(control_protection_err) - 1;
>> +		if ((error_code < 0) || (error_code > max_err))
>> +			error_code = 0;
>> +
>> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
>> +		pr_info("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",
> 
> If anything, all this stuff should be pr_emerg().

I will fix it.

--
Yu-cheng
