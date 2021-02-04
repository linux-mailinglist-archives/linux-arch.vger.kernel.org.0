Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB14A30FFA2
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 22:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBDVtx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 16:49:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:4838 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhBDVti (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 16:49:38 -0500
IronPort-SDR: pY+Nr6jAgIxyBSpAvvvsgXOwo2hNItuw9siAkK7SOvOxAnkVR0xZ2PX5iO24yXStyRd4G6C3S7
 yUGldeJTw3/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="180557971"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="180557971"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 13:48:49 -0800
IronPort-SDR: myV1KE9j7kkbr5D5pXV2bGsPNu9vv8X5WxtJ9c2sz4znxzOvH794zrs0zwYjGwOu0gcq//xvG6
 PNYTZBCr3OEg==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="393459920"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.100.6]) ([10.209.100.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 13:48:34 -0800
Subject: Re: [PATCH v19 12/25] mm: Introduce VM_SHSTK for shadow stack memory
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Pengfei Xu <pengfei.xu@intel.com>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-13-yu-cheng.yu@intel.com> <20210204204636.GH2172@grain>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <44f18779-efdb-e3f9-55d4-b46fb35d60cd@intel.com>
Date:   Thu, 4 Feb 2021 13:48:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204204636.GH2172@grain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/4/2021 12:46 PM, Cyrill Gorcunov wrote:
> On Wed, Feb 03, 2021 at 02:55:34PM -0800, Yu-cheng Yu wrote:
>>   
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 602e3a52884d..59623dcd92bb 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -661,6 +661,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>>   		[ilog2(VM_PKEY_BIT4)]	= "",
>>   #endif
>>   #endif /* CONFIG_ARCH_HAS_PKEYS */
>> +#ifdef CONFIG_X86_CET
>> +		[ilog2(VM_SHSTK)]	= "ss",
>> +#endif
>>   	};
> 
> IIRC we've these abbreviations explained in documentaion
> (proc.rst file). Could you please update it once time
> permit? I think it can be done on top of the series.
> 

I will add that.  Thanks!
