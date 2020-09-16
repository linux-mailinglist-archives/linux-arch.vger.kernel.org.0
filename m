Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511B326C9CE
	for <lists+linux-arch@lfdr.de>; Wed, 16 Sep 2020 21:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgIPTZ7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Sep 2020 15:25:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:27693 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbgIPTZO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Sep 2020 15:25:14 -0400
IronPort-SDR: Elx3oz4ZLtqSKa/D6RMCTUrl2Y2uaEvFDMMBDDa2k/6fptnJeOAa2FaMylOTv6dYpOUHOL++23
 ks/l5P6vV8+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="221106327"
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="221106327"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 12:25:13 -0700
IronPort-SDR: eg/Zchq5mOXDbpxpZFJ33RXMAD8TeVG7Z6YeVuuDo5eZiEwZNocXGb+rGVRDmIBihv4mUFVhg8
 Lk6TY0hQd4LA==
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="451983016"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.184.15]) ([10.212.184.15])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 12:25:12 -0700
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
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
 <c61c9bf3-4097-089c-4e6d-d0ae0e4480f3@intel.com>
 <CALCETrXGSXzqdAOK7tnDDYMJ5Uj4=u=AEvgdroS3BxRoyO3r+g@mail.gmail.com>
Message-ID: <35af3052-324f-06e3-5092-ac6d435f1725@intel.com>
Date:   Wed, 16 Sep 2020 12:25:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXGSXzqdAOK7tnDDYMJ5Uj4=u=AEvgdroS3BxRoyO3r+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/16/2020 6:52 AM, Andy Lutomirski wrote:
> On Mon, Sep 14, 2020 at 2:14 PM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 9/14/20 11:31 AM, Andy Lutomirski wrote:
>>> No matter what we do, the effects of calling vfork() are going to be a
>>> bit odd with SHSTK enabled.  I suppose we could disallow this, but
>>> that seems likely to cause its own issues.
>>
>> What's odd about it?  If you're a vfork()'d child, you can't touch the
>> stack at all, right?  If you do, you or your parent will probably die a
>> horrible death.
>>
> 
> An evil program could vfork(), have the child do a bunch of returns
> and a bunch of calls, and exit.  The net effect would be to change the
> parent's shadow stack contents.  In a sufficiently strict model, this
> is potentially problematic.

When a vfork child returns, its parent's shadow stack pointer is where 
it was before the child starts.  To move the shadow stack pointer and 
re-use the content left by the child, the parent needs to use CALL, RET, 
INCSSP, or RSTORSSP.  This seems to be difficult.

> 
> The question is: how much do we want to protect userspace from itself?
 >

If any issue comes up, people can always find ways to counter it.

> --Andy
> 
