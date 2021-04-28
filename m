Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A02136E084
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 22:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhD1Utz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 16:49:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:44235 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhD1Utz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 16:49:55 -0400
IronPort-SDR: oQslHqnxWIgintvtE7RYF1lX4vyqNHwVIRBySiHaDWo/pNx7jMxmRt1Mk+KLOoYXKf9T0ImSEs
 OjHlDktm57hQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="282185508"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="282185508"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 13:49:10 -0700
IronPort-SDR: vGWnJwbrgfpkN2beMuwcFAXncWISz0cuUun5JLR7YTtvYQETrR84ByQZ5LM6c2xCSLqPBh62Yf
 yPkIg66jONag==
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="423708019"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.133.34]) ([10.209.133.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 13:49:09 -0700
Subject: Re: [PATCH v26 6/9] x86/vdso: Insert endbr32/endbr64 to vDSO
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
        Haitao Huang <haitao.huang@intel.com>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <20210427204720.25007-7-yu-cheng.yu@intel.com>
 <202104281332.94A153C@keescook>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <88dc2e45-5fd4-9a1a-c493-3ff868a627f4@intel.com>
Date:   Wed, 28 Apr 2021 13:49:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <202104281332.94A153C@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/28/2021 1:33 PM, Kees Cook wrote:
> On Tue, Apr 27, 2021 at 01:47:17PM -0700, Yu-cheng Yu wrote:
>> From: "H.J. Lu" <hjl.tools@gmail.com>
>>
>> When Indirect Branch Tracking (IBT) is enabled, vDSO functions may be
>> called indirectly, and must have ENDBR32 or ENDBR64 as the first
>> instruction.  The compiler must support -fcf-protection=branch so that it
>> can be used to compile vDSO.
> 
> If you respin this, you can maybe rephrase this since CONFIG_X86_IBT
> has already tested for the compiler support.
> 

Yes, I will fix this.  Thanks for reviewing!

Yu-cheng

>>
>> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 
>> ---
>> v24:
>> - Replace CONFIG_X86_CET with CONFIG_X86_IBT to reflect splitting of shadow
>>    stack and ibt.
>>
>>   arch/x86/entry/vdso/Makefile | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
>> index 05c4abc2fdfd..a773a5f03b63 100644
>> --- a/arch/x86/entry/vdso/Makefile
>> +++ b/arch/x86/entry/vdso/Makefile
>> @@ -93,6 +93,10 @@ endif
>>   
>>   $(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
>>   
>> +ifdef CONFIG_X86_IBT
>> +$(vobjs) $(vobjs32): KBUILD_CFLAGS += -fcf-protection=branch
>> +endif
>> +
>>   #
>>   # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
>>   #
>> -- 
>> 2.21.0
>>
> 

