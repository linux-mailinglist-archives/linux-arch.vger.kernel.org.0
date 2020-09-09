Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB23D263A8D
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 04:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgIJCeB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 22:34:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:15314 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730760AbgIJCWt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Sep 2020 22:22:49 -0400
IronPort-SDR: FHvfqVu/9grH6dsuyuNpnE7maoL6zq4Sn9ajX95JR47dKJZ7vN1tLWCh1qcwf0ijDJdSRkoj7N
 ud6mbMAe8B4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="219997824"
X-IronPort-AV: E=Sophos;i="5.76,411,1592895600"; 
   d="scan'208";a="219997824"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 16:46:02 -0700
IronPort-SDR: mn+6z1txUnM20cyC1uC/43VSqPtFs7oZN20YoAzttVEqZ0/5B8qxGmJol8TF5pH4EnxDuguv/u
 qhB2+FKWVvbA==
X-IronPort-AV: E=Sophos;i="5.76,411,1592895600"; 
   d="scan'208";a="304681357"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.243.130]) ([10.212.243.130])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 16:46:00 -0700
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
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
 <87ft892vvf.fsf@oldenburg2.str.redhat.com>
 <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
 <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com>
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
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <fe6774f4-2554-9c0c-f1b8-110bb9398324@intel.com>
Date:   Wed, 9 Sep 2020 16:45:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b3379d26-d8a7-deb7-59f1-c994bb297dcb@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/9/2020 4:29 PM, Dave Hansen wrote:
> On 9/9/20 4:25 PM, Yu, Yu-cheng wrote:
>> On 9/9/2020 4:11 PM, Dave Hansen wrote:
>>> On 9/9/20 4:07 PM, Yu, Yu-cheng wrote:
>>>> What if a writable mapping is passed to madvise(MADV_SHSTK)?  Should
>>>> that be rejected?
>>>
>>> It doesn't matter to me.  Even if it's readable, it _stops_ being even
>>> directly readable after it's a shadow stack, right?  I don't think
>>> writes are special in any way.  If anything, we *want* it to be writable
>>> because that indicates that it can be written to, and we will want to
>>> write to it soon.
>>>
>> But in a PROT_WRITE mapping, all the pte's have _PAGE_BIT_RW set.  To
>> change them to shadow stack, we need to clear that bit from the pte's.
>> That will be like mprotect_fixup()/change_protection_range().
> 
> The page table hardware bits don't matter.  The user-visible protection
> effects matter.
> 
> For instance, we have PROT_EXEC, which *CLEARS* a hardware NX PTE bit.
> The PROT_ permissions are independent of the hardware.

Same for shadow stack here.  We consider shadow stack "writable", but we 
want to clear _PAGE_BIT_RW, which is set for the PTEs of the other type 
of "writable" mapping.  To change a writable data mapping to a writable 
shadow stack mapping, we need to call change_protection_range().

> 
> I don't think the interface should be influenced at *all* by what whacko
> PTE bit combinations we have to set to get the behavior.
> 
