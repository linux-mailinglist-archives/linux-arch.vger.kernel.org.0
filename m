Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46803244C9
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 20:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhBXTxR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 14:53:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:56215 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232392AbhBXTxQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:16 -0500
IronPort-SDR: DT67NmJxOc44P4KRo695ALANGfG2/Bi+mPFp3Ienf2hc5iGT7zgL6V0kfqZDgABtxDoT5zYWrP
 +fBQKfoyMjaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="181865671"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="181865671"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 11:52:34 -0800
IronPort-SDR: yXEcVzW98djE749wmWJeznbw7y/eWDKIg2JFChUy2uVPACaW3lKFTSPh+w1NRB+Semm7HIGoQg
 1PmH0DR7BcFQ==
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="431800681"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.35.50]) ([10.212.35.50])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 11:52:33 -0800
Subject: Re: [PATCH v21 06/26] x86/cet: Add control-protection fault handler
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
 <20210217222730.15819-7-yu-cheng.yu@intel.com>
 <20210224161343.GE20344@zn.tnic>
 <32ac05ef-b50b-c947-095d-bc31a42947a3@intel.com>
 <20210224165332.GF20344@zn.tnic>
 <db493c76-2a67-5f53-29a0-8333facac0f5@intel.com>
 <20210224192044.GH20344@zn.tnic>
 <CALCETrXKteS9K=OOgsCvBU4in_3zcYccqF9hh2=OdCJPknvB8Q@mail.gmail.com>
 <20210224194204.GI20344@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <c8077be0-f61f-d84d-fcd1-13c5ba482a38@intel.com>
Date:   Wed, 24 Feb 2021 11:52:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210224194204.GI20344@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/24/2021 11:42 AM, Borislav Petkov wrote:
> On Wed, Feb 24, 2021 at 11:30:34AM -0800, Andy Lutomirski wrote:
>> On Wed, Feb 24, 2021 at 11:20 AM Borislav Petkov <bp@alien8.de> wrote:
>>>
>>> On Wed, Feb 24, 2021 at 09:56:13AM -0800, Yu, Yu-cheng wrote:
>>>> No.  Maybe I am doing too much.  The GP fault sets si_addr to zero, for
>>>> example.  So maybe do the same here?
>>>
>>> No, you're looking at this from the wrong angle. This is going to be
>>> user-visible and the moment it gets upstream, it is cast in stone.
>>>
>>> So the whole use case of what luserspace needs to do or is going to do
>>> or wants to do on a SEGV_CPERR, needs to be described, agreed upon by
>>> people etc before it goes out. And thus clarified whether the address
>>> gets copied out or not.
>>
>> I vote 0.  The address is in ucontext->gregs[REG_RIP] [0] regardless.
>> Why do we need to stick a copy somewhere else?
>>
>> [0] or however it's spelled.  i can never remember.
> 
> Fine with me. Let's have this documented in the manpage and then we can
> move forward with this.
> 
> Thx.
> 

The man page at https://man7.org/linux/man-pages/man2/sigaction.2.html says,

SIGILL, SIGFPE, SIGSEGV, SIGBUS, and SIGTRAP fill in si_addr with the 
address of the fault.

But it is not entirely true.

I will send a patch to update it, and another patch for the si_code.

--
Yu-cheng
