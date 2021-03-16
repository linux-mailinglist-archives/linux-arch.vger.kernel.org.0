Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B60633DA5D
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 18:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbhCPRMz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 13:12:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:50270 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239171AbhCPRMm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 13:12:42 -0400
IronPort-SDR: kupFXEQzqOy4Ngh47OGo92WpruiIVhmacxnCEOG1MjyDormoq4u0xhDWADEvSJZtVmuLTBiWND
 lEzyeKzwkFIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209242689"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209242689"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 10:12:41 -0700
IronPort-SDR: WAufUYiv2hINDLV1Fsm7MR1NscNe9fmWhCNAMYlonQgBJzkCN1Jk6hMv0wjROGIZvRym4QvWLT
 XQwO7GxNWjGg==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="412295708"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.191.248]) ([10.212.191.248])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 10:12:40 -0700
Subject: Re: [PATCH v23 6/9] x86/entry: Introduce ENDBR macro
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
Cc:     Jarkko Sakkinen <jarkko@kernel.org>
References: <20210316151320.6123-1-yu-cheng.yu@intel.com>
 <20210316151320.6123-7-yu-cheng.yu@intel.com>
 <f98c600a-80e4-62f0-9c97-eeed708d998d@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <15966857-9be7-3029-7e93-e40596b4649a@intel.com>
Date:   Tue, 16 Mar 2021 10:12:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <f98c600a-80e4-62f0-9c97-eeed708d998d@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/16/2021 8:49 AM, Dave Hansen wrote:
> On 3/16/21 8:13 AM, Yu-cheng Yu wrote:
>> --- a/arch/x86/entry/calling.h
>> +++ b/arch/x86/entry/calling.h
>> @@ -392,3 +392,21 @@ For 32-bit we have the following conventions - kernel is built with
>>   .endm
>>   
>>   #endif /* CONFIG_SMP */
>> +/*
>> + * ENDBR is an instruction for the Indirect Branch Tracking (IBT) component
>> + * of CET.  IBT prevents attacks by ensuring that (most) indirect branches
>> + * function calls may only land at ENDBR instructions.  Branches that don't
>> + * follow the rules will result in control flow (#CF) exceptions.
>> + * ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
>> + * instructions are inserted automatically by the compiler, but branch
>> + * targets written in assembly must have ENDBR added manually.
>> + */
>> +.macro ENDBR
>> +#ifdef CONFIG_X86_CET
>> +#ifdef __i386__
>> +	endbr32
>> +#else
>> +	endbr64
>> +#endif
>> +#endif
>> +.endm
> 
> Is "#ifdef __i386__" the right thing to use here?  I guess ENDBR only
> ends up getting used in the VDSO, but there's a lot of
> non-userspace-exposed stuff in calling.h.  It seems a bit weird to have
> the normally userspace-only __i386__ in there.
> 
> I don't see any existing direct use of __i386__ in arch/x86/entry/vdso.
> 

Good point.  My thought was, __i386__ comes from the compiler having the 
-m32 command-line option, and it is not dependent on anything else.

Alternatively, there is another compiler-defined macro _CET_ENDBR that 
can be used.  We can put the following in calling.h:

#ifdef __CET__
#include <cet.h>
#else
#define _CET_ENDBR
#endif

and then use _CET_ENDBR in other files.  How is that?

In the future, in case we have kernel-mode IBT, ENDBR macros are also 
needed for other assembly files.

Thanks,
Yu-cheng
