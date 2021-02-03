Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B246530E612
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 23:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhBCW3d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 17:29:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:44941 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232201AbhBCW3c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 17:29:32 -0500
IronPort-SDR: qCnO0xfovv3BelUrCDlUnNmfqHusXdVcXEQsOE7kbiDRIjlXTDZ8+wNahfWg/PBR4Bm0s+gcgb
 ogZYZMEI+Rag==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168811528"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="168811528"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:28:48 -0800
IronPort-SDR: teAHso16AhsuO/DSh9wwnpQvwEfuXc8bhQHU+KbBseRyIWT4j15au9I7BKs1vITYb4rh6MgfvA
 BREiF+xDa61g==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="356920008"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.43.162]) ([10.212.43.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:28:46 -0800
Subject: Re: [PATCH v18 24/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
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
        Pengfei Xu <pengfei.xu@intel.com>
References: <20210127212524.10188-1-yu-cheng.yu@intel.com>
 <20210127212524.10188-25-yu-cheng.yu@intel.com>
 <ba39586d-25b6-6ea5-19c3-adf17b59f910@intel.com>
 <761ae8ce-0560-24cc-e6f7-684475cb3708@intel.com>
 <6720b1a9-f785-dbbd-1f0e-8c9090be2069@intel.com>
 <a7ef2df2-815f-9994-11b7-026afe45094f@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <c68f0f9b-2e56-6ca6-511d-58acd3d96ff2@intel.com>
Date:   Wed, 3 Feb 2021 14:28:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <a7ef2df2-815f-9994-11b7-026afe45094f@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/3/2021 2:11 PM, Dave Hansen wrote:
> On 2/3/21 1:54 PM, Yu, Yu-cheng wrote:
>> On 1/29/2021 10:56 AM, Yu, Yu-cheng wrote:
>>> On 1/29/2021 9:07 AM, Dave Hansen wrote:
>>>> On 1/27/21 1:25 PM, Yu-cheng Yu wrote:
>>>>> +    if (!IS_ENABLED(CONFIG_X86_CET))
>>>>> +        return -EOPNOTSUPP;
>>>>
>>>> Let's ignore glibc for a moment.  What error code *should* the kernel be
>>>> returning here?  errno(3) says:
>>>>
>>>>          EOPNOTSUPP      Operation not supported on socket (POSIX.1)
>>>> ...
>>>>          ENOTSUP         Operation not supported (POSIX.1)
>>>>
>>>
>>> Yeah, other places in kernel use ENOTSUPP.  This seems to be out of
>>> line.  And since the issue is long-existing, applications already know
>>> how to deal with it.  I should have made that argument.  Change it to
>>> ENOTSUPP.
>>
>> When I make the change, checkpatch says...
>>
>> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
>> #128: FILE: arch/x86/kernel/cet_prctl.c:33:
>> +        return -ENOTSUPP;
>>
>> Do we want to reconsider?
> 
> I'm not sure I trust checkpatch over manpages.  I had to google "SUSV4".
>   I'm not sure it matters at *all* for a 100% Linux-specific interface.
> 
> ENOTSUPP does seem less popular lately:
> 
>> $ git diff v5.0.. kernel/ arch/ drivers/ | grep ^+.*return.*E.*NO.*SUP.*\; | grep -o -- -E.*\; | sort | uniq -c | sort -n
>> ... noise
>>       61 -EOPNOTSUPP);
>>      260 -ENOTSUPP;
>>     1577 -EOPNOTSUPP;
> 
> but far from unused.  That might be due to checkpatch spew more than
> anything.
> 

Maybe I will keep it ENOTSUPP for now.  If any logical reason should 
come up, I will be happy to change it again.  Thanks!

--
Yu-cheng
