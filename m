Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A59433DFB2
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 22:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhCPVBu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 17:01:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:4978 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232180AbhCPVBW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 17:01:22 -0400
IronPort-SDR: HDpvjgXKkWS2ZzziY6TCb4v/W+NVz5Xxrp6/pHqnIlA9UMDi5HDayJJzWQWEs4TmT0Hx6lE82C
 jfR2exyIR4yA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209280953"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209280953"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 14:01:10 -0700
IronPort-SDR: jl9j5Sr8LukusE8rFQ1CMdcCk1xcgInZq6zKKnBJVDNa5Qkmk5nKItZiqHnumNiZuOXqxc5gf8
 4v1qN7ImBUuQ==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="590805431"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.191.248]) ([10.212.191.248])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 14:01:08 -0700
Subject: Re: [PATCH v23 6/9] x86/entry: Introduce ENDBR macro
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
References: <20210316151320.6123-1-yu-cheng.yu@intel.com>
 <20210316151320.6123-7-yu-cheng.yu@intel.com>
 <f98c600a-80e4-62f0-9c97-eeed708d998d@intel.com>
 <15966857-9be7-3029-7e93-e40596b4649a@intel.com>
 <YFENvgrR8JSYq1ae@hirez.programming.kicks-ass.net>
 <65845773-6cf0-1bdc-1ecf-168de74cc283@intel.com>
 <YFER79kU+ukn3YZr@hirez.programming.kicks-ass.net>
 <aff84067-5b9e-1335-e540-ef90ee133ac9@intel.com>
Message-ID: <9da6397f-326b-7891-5810-a5ac9e0def5d@intel.com>
Date:   Tue, 16 Mar 2021 14:01:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <aff84067-5b9e-1335-e540-ef90ee133ac9@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/16/2021 1:26 PM, Yu, Yu-cheng wrote:
> On 3/16/2021 1:15 PM, Peter Zijlstra wrote:
>> On Tue, Mar 16, 2021 at 01:05:30PM -0700, Yu, Yu-cheng wrote:
>>> On 3/16/2021 12:57 PM, Peter Zijlstra wrote:
>>>> On Tue, Mar 16, 2021 at 10:12:39AM -0700, Yu, Yu-cheng wrote:
>>>>> Alternatively, there is another compiler-defined macro _CET_ENDBR 
>>>>> that can
>>>>> be used.  We can put the following in calling.h:
>>>>>
>>>>> #ifdef __CET__
>>>>> #include <cet.h>
>>>>> #else
>>>>> #define _CET_ENDBR
>>>>> #endif
>>>>>
>>>>> and then use _CET_ENDBR in other files.  How is that?
>>>>>
>>>>> In the future, in case we have kernel-mode IBT, ENDBR macros are 
>>>>> also needed
>>>>> for other assembly files.
>>>>
>>>> Can we please call it IBT_ENDBR or just ENDBR. CET is a horrible name,
>>>> seeing how it is not specific.
>>>>
>>>
>>> _CET_ENDBR is from the compiler and we cannot change it.  We can do:
>>>
>>> #define ENDBR _CET_ENDBR
>>>
>>> How is that?
>>
>> Do we really want to include compiler headers? AFAICT it's not a
>> built-in. Also what about clang?
>>
>> This thing seems trivial enough to build our own, it's a single damn
>> instruction. That also means we don't have to worry about changes to
>> header files we don't control.
>>
> 
> Then, what about moving what I had earlier to vdso.h?
> If we don't want __i386__ either, then make it two macros.
> 
> +.macro ENDBR
> +#ifdef CONFIG_X86_CET
> +#ifdef __i386__
> +    endbr32
> +#else
> +    endbr64
> +#endif
> +#endif
> +.endm

I will make it like the following:

diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 98aa103eb4ab..4c0262dcb93d 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -52,6 +52,15 @@ extern int map_vdso_once(const struct vdso_image 
*image, unsigned long addr);
  extern bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
  				 unsigned long error_code,
  				 unsigned long fault_addr);
-#endif /* __ASSEMBLER__ */
+#else /* __ASSEMBLER__ */
+
+#ifdef CONFIG_X86_CET
+#define ENDBR64 endbr64
+#define ENDBR32 endbr32
+#else /*!CONFIG_X86_CET */
+#define ENDBR64
+#define ENDBR32
+#endif

+#endif /* __ASSEMBLER__ */
  #endif /* _ASM_X86_VDSO_H */
