Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277F7324172
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 17:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhBXP4W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 10:56:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:27974 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235975AbhBXPo2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Feb 2021 10:44:28 -0500
IronPort-SDR: sOFU6kPdQt0nSsVmWLGDBWh3/qo56297LB6UYhJCqx13LvbdoXJFHYANGyKAkCwGCgD0pwSC7I
 KWed7JweLg+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="270171594"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="270171594"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 07:42:08 -0800
IronPort-SDR: jVuiEXB3Ug+T7q0ChWO76c7J/zB516uphMzYjgWe5wHSF8FdwZb9pfX+9diNdIylxZgSfwptVM
 /+B2F5+DiIWg==
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="431718569"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.35.50]) ([10.212.35.50])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 07:42:05 -0800
Subject: Re: [PATCH v21 05/26] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
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
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
 <20210217222730.15819-6-yu-cheng.yu@intel.com>
 <20210224153457.GC20344@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <6e644e1d-7034-20f1-4850-336b143ba01c@intel.com>
Date:   Wed, 24 Feb 2021 07:42:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224153457.GC20344@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/24/2021 7:34 AM, Borislav Petkov wrote:
> On Wed, Feb 17, 2021 at 02:27:09PM -0800, Yu-cheng Yu wrote:
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 546d6ecf0a35..fae6b3ea1f6d 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -933,4 +933,23 @@
>>   #define MSR_VM_IGNNE                    0xc0010115
>>   #define MSR_VM_HSAVE_PA                 0xc0010117
>>   
>> +/* Control-flow Enforcement Technology MSRs */
>> +#define MSR_IA32_U_CET		0x6a0 /* user mode cet setting */
>> +#define MSR_IA32_S_CET		0x6a2 /* kernel mode cet setting */
>> +#define CET_SHSTK_EN		BIT_ULL(0)
>> +#define CET_WRSS_EN		BIT_ULL(1)
>> +#define CET_ENDBR_EN		BIT_ULL(2)
>> +#define CET_LEG_IW_EN		BIT_ULL(3)
>> +#define CET_NO_TRACK_EN		BIT_ULL(4)
>> +#define CET_SUPPRESS_DISABLE	BIT_ULL(5)
>> +#define CET_RESERVED		(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9))
>> +#define CET_SUPPRESS		BIT_ULL(10)
>> +#define CET_WAIT_ENDBR		BIT_ULL(11)
>> +
>> +#define MSR_IA32_PL0_SSP	0x6a4 /* kernel shadow stack pointer */
>> +#define MSR_IA32_PL1_SSP	0x6a5 /* ring-1 shadow stack pointer */
>> +#define MSR_IA32_PL2_SSP	0x6a6 /* ring-2 shadow stack pointer */
>> +#define MSR_IA32_PL3_SSP	0x6a7 /* user shadow stack pointer */
>> +#define MSR_IA32_INT_SSP_TAB	0x6a8 /* exception shadow stack table */
> 
> When you look at the formatting in that file and the MSR numbers in it, what
> stops you from formatting your addition the same way?
> 

Ah, got it.  I will add some leading zeros.  Thanks!

--
Yu-cheng
