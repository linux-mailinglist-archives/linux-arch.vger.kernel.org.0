Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B649324259
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 17:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhBXQp3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 11:45:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:10250 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235028AbhBXQp0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Feb 2021 11:45:26 -0500
IronPort-SDR: QJ4mQOkCJcpgh+vq3l6xsJcmmQCRv1YzTibnBE+orJZeOLaBA3n0UWljO7J10T66B3Mx+E6Yau
 BL6nZ+eecfLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="204702379"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="204702379"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 08:44:47 -0800
IronPort-SDR: cO6tUP/okEbGeERP7ncSscGvWFoqHF2wSdnLMFWdPr4Y3w9ngVkS4ODpHA5fLWv9bzRuj4JBHJ
 y3psIq07rtLw==
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="515715838"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.35.50]) ([10.212.35.50])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 08:44:45 -0800
Subject: Re: [PATCH v21 06/26] x86/cet: Add control-protection fault handler
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
        Haitao Huang <haitao.huang@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
 <20210217222730.15819-7-yu-cheng.yu@intel.com>
 <20210224161343.GE20344@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <32ac05ef-b50b-c947-095d-bc31a42947a3@intel.com>
Date:   Wed, 24 Feb 2021 08:44:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224161343.GE20344@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/24/2021 8:13 AM, Borislav Petkov wrote:
> On Wed, Feb 17, 2021 at 02:27:10PM -0800, Yu-cheng Yu wrote:
>> +/*
>> + * When a control protection exception occurs, send a signal to the responsible
>> + * application.  Currently, control protection is only enabled for user mode.
>> + * This exception should not come from kernel mode.
>> + */
>> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
>> +{
>> +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>> +				      DEFAULT_RATELIMIT_BURST);

[...]

>> +
>> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
>> +		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",
>> +			 tsk->comm, task_pid_nr(tsk),
>> +			 regs->ip, regs->sp, ssp, error_code,
>> +			 control_protection_err[err]);
>> +		print_vma_addr(KERN_CONT " in ", regs->ip);
>> +		pr_cont("\n");
>> +	}
>> +
>> +	force_sig_fault(SIGSEGV, SEGV_CPERR,
>> +			(void __user *)uprobe_get_trap_addr(regs));
> 
> Why is this calling an uprobes function?
> 

I will change it to error_get_trap_addr().

> Also, do not break that line even if it is longer than 80.
> 
>> +	cond_local_irq_disable(regs);
>> +}
>> +#endif
>> +
>>   static bool do_int3(struct pt_regs *regs)
>>   {
>>   	int res;
>> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
>> index d2597000407a..1c2ea91284a0 100644
>> --- a/include/uapi/asm-generic/siginfo.h
>> +++ b/include/uapi/asm-generic/siginfo.h
>> @@ -231,7 +231,8 @@ typedef struct siginfo {
>>   #define SEGV_ADIPERR	7	/* Precise MCD exception */
>>   #define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
>>   #define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
>> -#define NSIGSEGV	9
>> +#define SEGV_CPERR	10	/* Control protection fault */
>> +#define NSIGSEGV	10
> 
> I still don't see the patch adding this to the manpage of sigaction(2).
> 
> There's a git repo there: https://www.kernel.org/doc/man-pages/
> 
> and I'm pretty sure Michael takes patches.
> 

I will send a patch.

--
Yu-cheng
