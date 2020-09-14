Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3362696E9
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 22:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgINUo4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 16:44:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:37837 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgINUoz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Sep 2020 16:44:55 -0400
IronPort-SDR: 6nrcm9dSy+DO/jvdZmLKmHnbZys6BAG4RBu3iA68hckXf0bv8JIsargF5GyFyh7NcAW2OqeA4U
 NbxM7z0VeD1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="146898430"
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="146898430"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 13:44:54 -0700
IronPort-SDR: AkVfmk+B+R2AS1BdaSnCKau8ZPqZEqz9QQUtghb9wnE8lfT5XErlNWR4JSyOEhO3efMA9qoWq9
 vHE3455/G5aw==
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="506491218"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.244.74]) ([10.212.244.74])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 13:44:51 -0700
Subject: Re: [NEEDS-REVIEW] Re: [PATCH v11 25/25] x86/cet/shstk: Add
 arch_prctl functions for shadow stack
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>,
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
 <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com>
 <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
 <20200901102758.GY6642@arm.com>
 <c91bbad8-9e45-724b-4526-fe3674310c57@intel.com>
 <CALCETrWJQgtO_tP1pEaDYYsFgkZ=fOxhyTRE50THcxYoHyTTwg@mail.gmail.com>
 <32005d57-e51a-7c7f-4e86-612c2ff067f3@intel.com>
 <46dffdfd-92f8-0f05-6164-945f217b0958@intel.com>
 <ed929729-4677-3d3b-6bfd-b379af9272b8@intel.com>
 <6e1e22a5-1b7f-2783-351e-c8ed2d4893b8@intel.com>
 <5979c58d-a6e3-d14d-df92-72cdeb97298d@intel.com>
 <ab1a3344-60f4-9b9d-81d4-e6538fdcafcf@intel.com>
 <08c91835-8486-9da5-a7d1-75e716fc5d36@intel.com>
 <a881837d-c844-30e8-a614-8b92be814ef6@intel.com>
 <cbec8861-8722-ec31-2c02-1cfed20255eb@intel.com>
 <b3379d26-d8a7-deb7-59f1-c994bb297dcb@intel.com>
 <a1efc4330a3beff10671949eddbba96f8cde96da.camel@intel.com>
 <41aa5e8f-ad88-2934-6d10-6a78fcbe019b@intel.com>
 <CALCETrX5qJAZBe9sHL6+HFvre-bbo+us1==q9KHNCyRrzaUsjw@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <2d86fa40-3676-62b1-1571-90074ca65971@intel.com>
Date:   Mon, 14 Sep 2020 13:44:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrX5qJAZBe9sHL6+HFvre-bbo+us1==q9KHNCyRrzaUsjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/14/2020 11:31 AM, Andy Lutomirski wrote:
>> On Sep 14, 2020, at 7:50 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> ﻿On 9/11/20 3:59 PM, Yu-cheng Yu wrote:
>> ...
>>> Here are the changes if we take the mprotect(PROT_SHSTK) approach.
>>> Any comments/suggestions?
>>
>> I still don't like it. :)
>>
>> I'll also be much happier when there's a proper changelog to accompany
>> this which also spells out the alternatives any why they suck so much.
>>
> 
> Let’s take a step back here. Ignoring the precise API, what exactly is
> a shadow stack from the perspective of a Linux user program?
> 
> The simplest answer is that it’s just memory that happens to have
> certain protections.  This enables all kinds of shenanigans.  A
> program could map a memfd twice, once as shadow stack and once as
> non-shadow-stack, and change its control flow.  Similarly, a program
> could mprotect its shadow stack, modify it, and mprotect it back.  In

What if we do the following:

- If the mapping has VM_SHARED, it cannot be turned to shadow stack. 
Shadow stack cannot be shared anyway.

- Only allow an anonymous mapping to be converted to shadow stack, but 
not the other way.

> some threat models, though could be seen as a WRSS bypass.  (Although
> if an attacker can coerce a process to call mprotect(), the game is
> likely mostly over anyway.)
> 
> But we could be more restrictive, or perhaps we could allow user code
> to opt into more restrictions.  For example, we could have shadow
> stacks be special memory that cannot be written from usermode by any
> means other than ptrace() and friends, WRSS, and actual shadow stack
> usage.
> 
> What is the goal?

There primary goal is to allocate/mmap a shadow stack from user space.

> 
> No matter what we do, the effects of calling vfork() are going to be a
> bit odd with SHSTK enabled.  I suppose we could disallow this, but
> that seems likely to cause its own issues.
> 

Do you mean vfork() has issues with call/return?  That is taken care of 
in GLIBC.  Or do you mean it has issues with mprotect(PROT_SHSTK)?
