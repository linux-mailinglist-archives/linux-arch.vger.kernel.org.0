Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2464254CAC
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 20:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgH0SNy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 14:13:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:48462 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgH0SNy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 14:13:54 -0400
IronPort-SDR: WrnzObmuJOy57JjsYfD0y8fTXE8Bra6ttBhMYXfvLG78kKPXzT0MTLrU8vnsQtqx3j026zSFwR
 +TGDvmuuDc8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="136609330"
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="136609330"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 11:13:53 -0700
IronPort-SDR: kU95U/D1O7kHgHr1WXXPT1vdBAMIbglRTHBy0TxJgYsrsBJ105d5EwsufFz1dq2ONoiEaDdGpR
 SH4Z20+xAPUA==
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="339608214"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.213.179.54]) ([10.213.179.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 11:13:49 -0700
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
 <20200825002540.3351-26-yu-cheng.yu@intel.com>
 <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
 <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com>
 <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com>
 <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com>
 <20200826164604.GW6642@arm.com> <87ft892vvf.fsf@oldenburg2.str.redhat.com>
 <20200826170841.GX6642@arm.com> <87tuwow7kg.fsf@oldenburg2.str.redhat.com>
 <CAMe9rOrhjLSaMNABnzd=Kp5UeVot1Qkx0_PnMng=sT+wd9Xubw@mail.gmail.com>
 <873648w6qr.fsf@oldenburg2.str.redhat.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <a770d45d-b147-a8c5-b7f8-30d668cbed84@intel.com>
Date:   Thu, 27 Aug 2020 11:13:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <873648w6qr.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/27/2020 6:36 AM, Florian Weimer wrote:
> * H. J. Lu:
> 
>> On Thu, Aug 27, 2020 at 6:19 AM Florian Weimer <fweimer@redhat.com> wrote:
>>>
>>> * Dave Martin:
>>>
>>>> You're right that this has implications: for i386, libc probably pulls
>>>> more arguments off the stack than are really there in some situations.
>>>> This isn't a new problem though.  There are already generic prctls with
>>>> fewer than 4 args that are used on x86.
>>>
>>> As originally posted, glibc prctl would have to know that it has to pull
>>> an u64 argument off the argument list for ARCH_X86_CET_DISABLE.  But
>>> then the u64 argument is a problem for arch_prctl as well.
>>>
>>
>> Argument of ARCH_X86_CET_DISABLE is int and passed in register.
> 
> The commit message and the C source say otherwise, I think (not sure
> about the C source, not a kernel hacker).
> 

H.J. Lu suggested that we fix x86 arch_prctl() to take four arguments, 
and then keep MMAP_SHSTK as an arch_prctl().  Because now the map flags 
and size are all in registers, this also solves problems being pointed 
out earlier.  Without a wrapper, the shadow stack mmap call (from user 
space) will be:

syscall(_NR_arch_prctl, ARCH_X86_CET_MMAP_SHSTK, size, MAP_32BIT).

I think this would be a nice alternative to another new syscall.

If this looks good to everyone, I can send out new patches as response 
to my current version, and then after all issues fixed, send v12.

Thanks,
Yu-cheng
