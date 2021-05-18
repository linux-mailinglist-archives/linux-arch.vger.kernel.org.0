Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D7D387F3A
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 20:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351444AbhERSG4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 14:06:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:26931 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346758AbhERSGz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 14:06:55 -0400
IronPort-SDR: q+McRJhdftoHISkLhODa1E5JP+ke3SD4bEIeuLAwCAfubEZrATPlunM/k0+DtU5DNUZ+7KsKkI
 RRVnQKeSedzA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="221838914"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="221838914"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 11:05:30 -0700
IronPort-SDR: gAUNy8H1tWzyDtk3RjWGu7NYwEdtvHR844tMogSjaHv7ceZTTVu4XZLZKd+4fKBQaVCefCmmE4
 wSoG94ONbg3g==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="473078661"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.166.158]) ([10.209.166.158])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 11:05:28 -0700
Subject: Re: [PATCH v26 24/30] x86/cet/shstk: Introduce shadow stack token
 setup/verify routines
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-25-yu-cheng.yu@intel.com> <YKIfIEyW+sR+bDCk@zn.tnic>
 <e225e357-a1d5-9596-8900-79e6b94cf924@intel.com>
 <20210518001316.GR15897@asgard.redhat.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <ea096f7e-7761-081f-e855-3294f8d09471@intel.com>
Date:   Tue, 18 May 2021 11:05:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518001316.GR15897@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/17/2021 5:14 PM, Eugene Syromiatnikov wrote:
> On Mon, May 17, 2021 at 01:55:01PM -0700, Yu, Yu-cheng wrote:
>> On 5/17/2021 12:45 AM, Borislav Petkov wrote:
>>> On Tue, Apr 27, 2021 at 01:43:09PM -0700, Yu-cheng Yu wrote:
>>>> +static inline int write_user_shstk_32(u32 __user *addr, u32 val)
>>>> +{
>>>> +	WARN_ONCE(1, "%s used but not supported.\n", __func__);
>>>> +	return -EFAULT;
>>>> +}
>>>> +#endif
>>>
>>> What is that supposed to catch? Any concrete (mis-)use cases?
>>>
>>
>> If 32-bit apps are not supported, there should be no need of 32-bit shadow
>> stack write, otherwise there is a bug.
> 
> Speaking of which, I wonder what would happen if a 64-bit process makes
> a 32-bit system call (using int 0x80, for example), and gets a signal.
> 

Yes, that's right.  Thanks!  I should have said, if neither IA32 nor X32 
is supported.

Yu-cheng
