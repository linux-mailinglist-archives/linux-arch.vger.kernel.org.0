Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA89835A922
	for <lists+linux-arch@lfdr.de>; Sat, 10 Apr 2021 01:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhDIXOZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 19:14:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:31333 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234880AbhDIXOZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Apr 2021 19:14:25 -0400
IronPort-SDR: 8FOQqofsNKjTpM0K517Jcfxc3KzuY1CThC/x+Z2quemPgcz9nj0ZV64O7HC7YFRWp9ffysRaHs
 cC8kQ2Cfc6tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="191708954"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="191708954"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 16:14:11 -0700
IronPort-SDR: Rs7zQ8aB0ZMvUycmEhQuydYbL7lqQgBkA3wFN0NTzubAov5AhJqpP0n+EbiE6x11UCLPnEfnO5
 PvrqU4zxc37A==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="416460352"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.27.140]) ([10.212.27.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 16:14:10 -0700
Subject: Re: [PATCH v24 04/30] x86/cpufeatures: Introduce X86_FEATURE_CET and
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-5-yu-cheng.yu@intel.com>
 <20210409101214.GC15567@zn.tnic>
 <c7cb0ed6-2725-ba0d-093e-393eab9918b2@intel.com>
 <20210409171408.GG15567@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <f7a1299a-916f-70fe-6881-0951fe4fe38a@intel.com>
Date:   Fri, 9 Apr 2021 16:14:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210409171408.GG15567@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/9/2021 10:14 AM, Borislav Petkov wrote:
> On Fri, Apr 09, 2021 at 08:52:52AM -0700, Yu, Yu-cheng wrote:
>> Recall we had complicated code for the XSAVES features detection in
>> xstate.c.  Dave Hansen proposed the solution and then the whole thing
>> becomes simple.  Because of this flag, even when only the shadow stack is
>> available, the code handles it nicely.
> 
> Is that what you mean?
> 
> @@ -53,6 +55,8 @@ static short xsave_cpuid_features[] __initdata = {
>   	X86_FEATURE_INTEL_PT,
>   	X86_FEATURE_PKU,
>   	X86_FEATURE_ENQCMD,
> +	X86_FEATURE_CET, /* XFEATURE_CET_USER */
> +	X86_FEATURE_CET, /* XFEATURE_CET_KERNEL */
> 
> or what is the piece which becomes simpler?

Yes, this is it.

>> Would this equal to only CONFIG_X86_CET (one Kconfig option)?  In fact, when
>> you proposed only CONFIG_X86_CET, things became much simpler.
> 
> When you use CONFIG_X86_SHADOW_STACK instead, it should remain same
> simple no?
> 

Signals, arch_prctl, and ELF header are three places that need to depend 
on either shadow stack or IBT is configured.  To remain simple, we can 
make all three depend on CONFIG_X86_SHADOW_STACK, and in Kconfig, make 
CONFIG_X86_IBT depend on CONFIG_X86_SHADOW_STACK.  Without shadow stack, 
IBT itself is not as useful anyway.

>> Practically, IBT is not much in terms of code size.  Since we have already
>> separated the two, why don't we leave it as-is.  When people start using it
>> more, there will be more feedback, and we can decide if one Kconfig is
>> better?
> 
> Because when we add stuff to the kernel, we add the simplest and
> cleanest version possible and later, when we determine that additional
> functionality is needed, *then* we add it. Not the other way around.
> 
> Our Kconfig symbol space is already an abomination so we can't just add
> some more and decide later.
> 
> What happens in such situations usually is stuff gets added, it bitrots
> and some poor soul - very likely a maintainer who has to mop up after
> everybody - comes and cleans it up. I'd like to save myself that
> cleaning up.
> 
> Thx.
>
