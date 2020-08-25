Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC0A252261
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 23:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgHYVEE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 17:04:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:21941 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYVED (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Aug 2020 17:04:03 -0400
IronPort-SDR: r/MA08np3fu6fS50FTj6C0nofkAHd5JqEwR3Du7vbNXPkdLENTy30e+J23ACPvNGSfE96CFRw5
 nE44u+/H1WtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="157238490"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="157238490"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 14:04:03 -0700
IronPort-SDR: WoRGvY0PoRGbOXpqpJzl8Xjzeiomd80lkvcS9rWmmRwQORlx7kbHU7liFPi0L8I1jnFtU4A5EK
 gSD7dSjmypQQ==
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="474507675"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.213.162.112]) ([10.213.162.112])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 14:04:01 -0700
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
        Weijiang Yang <weijiang.yang@intel.com>
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
 <20200825002540.3351-26-yu-cheng.yu@intel.com>
 <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
 <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com>
 <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com>
Date:   Tue, 25 Aug 2020 14:04:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/25/2020 12:19 PM, Dave Hansen wrote:
> On 8/25/20 11:43 AM, Yu, Yu-cheng wrote:
>>>> arch_prctl(ARCH_X86_CET_MMAP_SHSTK, u64 *args)
>>>>       Allocate a new shadow stack.
>>>>
>>>>       The parameter 'args' is a pointer to a user buffer.
>>>>
>>>>       *args = desired size
>>>>       *(args + 1) = MAP_32BIT or MAP_POPULATE
>>>>
>>>>       On returning, *args is the allocated shadow stack address.
>>>
>>> This is hideous.  Would this be better as a new syscall?
>>
>> Could you point out why this is hideous, so that I can modify the
>> arch_prctl?
> 
> Passing values in memory is hideous when we don't have to.  A syscall
> would let you have separate arguments for size and flags and would also
> let you have a nice return value instead of needing to do that in memory
> too.

That is a good justification.

> 
>> I think this is more arch-specific.  Even if it becomes a new syscall,
>> we still need to pass the same parameters.
> 
> Right, but without the copying in and out of memory.
> 
Linux-api is already on the Cc list.  Do we need to add more people to 
get some agreements for the syscall?
