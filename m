Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAA126B062
	for <lists+linux-arch@lfdr.de>; Wed, 16 Sep 2020 00:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgIOWJe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 18:09:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:23273 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbgIOUSl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 16:18:41 -0400
IronPort-SDR: +rDzzhe/010fi/TR/LXEWHPuGLskjGLU7DF1MixvvBD3J2PSvMINWSvp+/vuSlp4D6ftU85u7s
 mDBMzWHDcupg==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="160274392"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="160274392"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 13:16:44 -0700
IronPort-SDR: C21JFcp5L3IyVaR6VNoNRpn9g5UUxFHa0FtfPv5gaDUxRuFfz+O+12WK+kTXZovTK9h1xkn+TF
 gyWGw97/7pKA==
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="302292684"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.27.25]) ([10.209.27.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 13:16:42 -0700
Subject: Re: [NEEDS-REVIEW] Re: [PATCH v11 25/25] x86/cet/shstk: Add
 arch_prctl functions for shadow stack
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>
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
 <bf2ab309-f8c4-83da-1c0a-5684e5bc5c82@intel.com>
 <2f137667122486a0cea3b0dbfa99d02f74870673.camel@intel.com>
 <6a04252c-da02-0217-270b-650bd3d852c7@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <439e1e08-58c0-ac91-b073-a471111ad8e2@intel.com>
Date:   Tue, 15 Sep 2020 13:16:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6a04252c-da02-0217-270b-650bd3d852c7@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/15/2020 12:24 PM, Dave Hansen wrote:
> On 9/15/20 12:08 PM, Yu-cheng Yu wrote:
>> On Mon, 2020-09-14 at 17:12 -0700, Yu, Yu-cheng wrote:
>>> On 9/14/2020 7:50 AM, Dave Hansen wrote:
>>>> On 9/11/20 3:59 PM, Yu-cheng Yu wrote:
>>>> ...
>>>>> Here are the changes if we take the mprotect(PROT_SHSTK) approach.
>>>>> Any comments/suggestions?
>>>> I still don't like it. :)
>>>>
>>>> I'll also be much happier when there's a proper changelog to accompany
>>>> this which also spells out the alternatives any why they suck so much.
>> [...]
>>
>> I revised it.  If this turns out needing more work/discussion, we can split it
>> out from the shadow stack series.
> 
> Where does that leave things?  You only get shadow stacks for
> single-threaded apps which have the ELF bits set?
> 

As long as the system supports shadow stack, any application can 
mmap()/mprotect() a shadow stack.  A pthread can allocate a shadow stack 
too.  However, only shadow stack-enabled programs can activate/use the 
shadow stack.
