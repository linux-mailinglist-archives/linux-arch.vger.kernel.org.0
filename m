Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4607E259D08
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 19:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgIARXV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 13:23:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:59156 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbgIARXP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 13:23:15 -0400
IronPort-SDR: 4B0tkcJC6JmsWNq3TyA+uqJaq/KHgRyf5UCkhB3Rk0oPDtDqP2jMsF8yLlDf3w96GsrMNe73XO
 we4wYTnQ1VCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="154729712"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="154729712"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 10:23:14 -0700
IronPort-SDR: wuavfJxSyAPpELTV8WPFMMAHFUIjYWk2p5fLGqafU8dChGcX+q9xPL+vQSSxs9yoHADPFY7gzF
 UEmYO/DPRnJg==
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="301519837"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.241.30]) ([10.212.241.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 10:23:12 -0700
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Dave Martin <Dave.Martin@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>,
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
References: <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com>
 <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com>
 <20200826164604.GW6642@arm.com> <87ft892vvf.fsf@oldenburg2.str.redhat.com>
 <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
 <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com>
 <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com>
 <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
 <20200901102758.GY6642@arm.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <c91bbad8-9e45-724b-4526-fe3674310c57@intel.com>
Date:   Tue, 1 Sep 2020 10:23:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901102758.GY6642@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/1/2020 3:28 AM, Dave Martin wrote:
> On Thu, Aug 27, 2020 at 06:26:11AM -0700, H.J. Lu wrote:
>> On Wed, Aug 26, 2020 at 12:57 PM Dave Hansen <dave.hansen@intel.com> wrote:
>>>
>>> On 8/26/20 11:49 AM, Yu, Yu-cheng wrote:
>>>>> I would expect things like Go and various JITs to call it directly.
>>>>>
>>>>> If we wanted to be fancy and add a potentially more widely useful
>>>>> syscall, how about:
>>>>>
>>>>> mmap_special(void *addr, size_t length, int prot, int flags, int type);
>>>>>
>>>>> Where type is something like MMAP_SPECIAL_X86_SHSTK.  Fundamentally,
>>>>> this is really just mmap() except that we want to map something a bit
>>>>> magical, and we don't want to require opening a device node to do it.
>>>>
>>>> One benefit of MMAP_SPECIAL_* is there are more free bits than MAP_*.
>>>> Does ARM have similar needs for memory mapping, Dave?
>>>
>>> No idea.
>>>
>>> But, mmap_special() is *basically* mmap2() with extra-big flags space.
>>> I suspect it will grow some more uses on top of shadow stacks.  It could
>>> have, for instance, been used to allocate MPX bounds tables.
>>
>> There is no reason we can't use
>>
>> long arch_prctl (int, unsigned long, unsigned long, unsigned long, ..);
>>
>> for ARCH_X86_CET_MMAP_SHSTK.   We just need to use
>>
>> syscall (SYS_arch_prctl, ARCH_X86_CET_MMAP_SHSTK, ...);
> 
> 
> For arm64 (and sparc etc.) we continue to use the regular mmap/mprotect
> family of calls.  One or two additional arch-specific mmap flags are
> sufficient for now.
> 
> Is x86 definitely not going to fit within those calls?

That can work for x86.  Andy, what if we create PROT_SHSTK, which can 
been seen only from the user.  Once in kernel, it is translated to 
VM_SHSTK.  One question for mremap/mprotect is, do we allow a normal 
data area to become shadow stack?

> 
> For now, I can't see what arg[2] is used for (and hence the type
> argument of mmap_special()), but I haven't dug through the whole series.

If we use the approach above, then we don't need arch_prctl changes.

Thanks,
Yu-cheng
