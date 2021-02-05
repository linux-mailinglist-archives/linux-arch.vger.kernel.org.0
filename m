Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EA1310F6B
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 19:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhBEQVK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 11:21:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:57360 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbhBEQTC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Feb 2021 11:19:02 -0500
IronPort-SDR: xsyp4/dVN4iFhYQCwBJxmKGvLSM7JeNc4F3zqTsXFxy60X9OAfbwrkEbRVCq/ciaqyPZ2r0rcU
 HtA09LD2jY9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="169141569"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="169141569"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 10:00:31 -0800
IronPort-SDR: flCR177ho8xnj0bLEwOjvZcs9Zedun0/6v6kqhP8zw+5aFJY/km3RD+12kLLIkQ1hijsUSVCTq
 zK9mt3DZSzxA==
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="434549248"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.95.7]) ([10.212.95.7])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 10:00:24 -0800
Subject: Re: [PATCH v19 06/25] x86/cet: Add control-protection fault handler
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
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-7-yu-cheng.yu@intel.com>
 <20210205135927.GH17488@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <2d829cba-784e-635a-e0c5-a7b334fa9b40@intel.com>
Date:   Fri, 5 Feb 2021 10:00:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210205135927.GH17488@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/5/2021 5:59 AM, Borislav Petkov wrote:
> On Wed, Feb 03, 2021 at 02:55:28PM -0800, Yu-cheng Yu wrote:
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
> 
> I can't find it written down anywhere why the ratelimiting is needed at
> all?
> 

The ratelimit here is only for #CP, and its rate is not counted together 
with other types of faults.  If a task gets here, it will exit.  The 
only condition the ratelimit will trigger is when multiple tasks hit #CP 
at once, which is unlikely.  Are you suggesting that we do not need the 
ratelimit here?

Thanks!

--
Yu-cheng
