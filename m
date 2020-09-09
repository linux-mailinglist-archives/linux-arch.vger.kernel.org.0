Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600CD263A23
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 04:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgIJCVI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 22:21:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:52209 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730729AbgIJCSf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Sep 2020 22:18:35 -0400
IronPort-SDR: IzZnHC92zX56tSI2JiAj352zGjlBYSii2icYTIWU6+U42tFtgHuCRMcIcjkEdLw/wlOBPU59GC
 FRgfqUtlQXKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="158468124"
X-IronPort-AV: E=Sophos;i="5.76,410,1592895600"; 
   d="scan'208";a="158468124"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 16:07:09 -0700
IronPort-SDR: qkfpSoKV1QeBLR8tjA8HAJxMsc61Q3klbLaexWsYoj4/2+poJ8zDHk1wXd4u6VEzMkKvkZoTVx
 KbyeR31mj0lQ==
X-IronPort-AV: E=Sophos;i="5.76,410,1592895600"; 
   d="scan'208";a="300309339"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.243.130]) ([10.212.243.130])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 16:07:08 -0700
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
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com>
 <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com>
 <20200826164604.GW6642@arm.com> <87ft892vvf.fsf@oldenburg2.str.redhat.com>
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
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <08c91835-8486-9da5-a7d1-75e716fc5d36@intel.com>
Date:   Wed, 9 Sep 2020 16:07:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ab1a3344-60f4-9b9d-81d4-e6538fdcafcf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/9/2020 3:59 PM, Dave Hansen wrote:
> On 9/9/20 3:08 PM, Yu, Yu-cheng wrote:
>> After looking at this more, I found the changes are more similar to
>> mprotect() than madvise().  We are going to change an anonymous mapping
>> to a read-only mapping, and add the VM_SHSTK flag to it.  Would an
>> x86-specific mprotect(PROT_SHSTK) make more sense?
>>
>> One alternative would be requiring a read-only mapping for
>> madvise(MADV_SHSTK).  But that is inconvenient for the application.
> 
> Why?  It's just:
> 
> 	mmap()/malloc();
> 	mprotect(PROT_READ);
> 	madvise(MADV_SHSTK);
> 
> vs.
> 
> 	mmap()/malloc();
> 	mprotect(PROT_SHSTK);
> 
> I'm not sure a single syscall counts as inconvenient.
> 
> I don't quite think we should use a PROT_ bit for this.  It seems like
> the kind of thing that could be fragile and break existing expectations.
>   I don't care _that_ strongly though.
> 
What if a writable mapping is passed to madvise(MADV_SHSTK)?  Should 
that be rejected?
