Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB746253787
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 20:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHZStY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 14:49:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:11669 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgHZStX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Aug 2020 14:49:23 -0400
IronPort-SDR: KHu55cxrHrf0j8RUFm2jUI9+iDTzDovNZYYix61wcSZ7wRcRDpLzJFnaVK/egBpTSWbl0qn2GZ
 85s5Q4Nf/R3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="135915855"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="135915855"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 11:49:23 -0700
IronPort-SDR: kz1B6Bl9Evoh0DAuECATySIb6A0aSvHXJVx+ZQr3fJEHh3x2b1adDajhdyc7g2skce1j/DGDrQ
 EzPikqGDu3IQ==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="500347882"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.141.162]) ([10.251.141.162])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 11:49:22 -0700
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
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
 <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com>
Date:   Wed, 26 Aug 2020 11:49:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/26/2020 10:04 AM, Andy Lutomirski wrote:
> On Wed, Aug 26, 2020 at 9:52 AM Florian Weimer <fweimer@redhat.com> wrote:
>>
>> * Dave Martin:
>>
>>> On Tue, Aug 25, 2020 at 04:34:27PM -0700, Yu, Yu-cheng wrote:
>>>> On 8/25/2020 4:20 PM, Dave Hansen wrote:
>>>>> On 8/25/20 2:04 PM, Yu, Yu-cheng wrote:
>>>>>>>> I think this is more arch-specific.  Even if it becomes a new syscall,
>>>>>>>> we still need to pass the same parameters.
>>>>>>>
>>>>>>> Right, but without the copying in and out of memory.
>>>>>>>
>>>>>> Linux-api is already on the Cc list.  Do we need to add more people to
>>>>>> get some agreements for the syscall?
>>>>> What kind of agreement are you looking for?  I'd suggest just coding it
>>>>> up and posting the patches.  Adding syscalls really is really pretty
>>>>> straightforward and isn't much code at all.
>>>>>
>>>>
>>>> Sure, I will do that.
>>>
>>> Alternatively, would a regular prctl() work here?
>>
>> Is this something appliation code has to call, or just the dynamic
>> loader?
>>
>> prctl in glibc is a variadic function, so if there's a mismatch between
>> the kernel/userspace syscall convention and the userspace calling
>> convention (for variadic functions) for specific types, it can't be made
>> to work in a generic way.
>>
>> The loader can use inline assembly for system calls and does not have
>> this issue, but applications would be implcated by it.
>>
> 
> I would expect things like Go and various JITs to call it directly.
> 
> If we wanted to be fancy and add a potentially more widely useful
> syscall, how about:
> 
> mmap_special(void *addr, size_t length, int prot, int flags, int type);
> 
> Where type is something like MMAP_SPECIAL_X86_SHSTK.  Fundamentally,
> this is really just mmap() except that we want to map something a bit
> magical, and we don't want to require opening a device node to do it.
> 

One benefit of MMAP_SPECIAL_* is there are more free bits than MAP_*.
Does ARM have similar needs for memory mapping, Dave?

Yu-cheng
