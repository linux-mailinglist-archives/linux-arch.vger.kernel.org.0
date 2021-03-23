Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFB9346AB4
	for <lists+linux-arch@lfdr.de>; Tue, 23 Mar 2021 22:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhCWVEK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Mar 2021 17:04:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:56723 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233291AbhCWVDo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Mar 2021 17:03:44 -0400
IronPort-SDR: gDgamGXJIKeAKiF89M5W0H2dMt/LQyP+CLLI3kuWfjg9+ImzopS97DDdlgVOdyALtnpzR8rxDe
 aeIho+vRTNGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="177687203"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="177687203"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 14:03:43 -0700
IronPort-SDR: MeVn035X0DnNhkg1ktcTUNDoBtJVhhAZ7Cud4eLJ8Ee/Ta0TQIKBo35AS40MPkUMefwCl6pYBB
 Wtim3d7C3Cag==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="452304540"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.32.182]) ([10.209.32.182])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 14:03:41 -0700
Subject: Re: [PATCH v23 00/28] Control-flow Enforcement: Shadow Stack
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316211552.GU4746@worktop.programming.kicks-ass.net>
 <adb72123-e8b3-c022-47da-b8c423952caf@intel.com>
 <20210323204932.GC4746@worktop.programming.kicks-ass.net>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <80890046-f91f-f512-6c71-b6c963905636@intel.com>
Date:   Tue, 23 Mar 2021 14:03:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323204932.GC4746@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/23/2021 1:49 PM, Peter Zijlstra wrote:
> On Fri, Mar 19, 2021 at 02:43:04PM -0700, Yu, Yu-cheng wrote:
>> On 3/16/2021 2:15 PM, Peter Zijlstra wrote:
>>> On Tue, Mar 16, 2021 at 08:10:26AM -0700, Yu-cheng Yu wrote:
>>>> Control-flow Enforcement (CET) is a new Intel processor feature that blocks
>>>> return/jump-oriented programming attacks.  Details are in "Intel 64 and
>>>> IA-32 Architectures Software Developer's Manual" [1].
>>>>
>>>> CET can protect applications and the kernel.  This series enables only
>>>> application-level protection, and has three parts:
>>>>
>>>>     - Shadow stack [2],
>>>>     - Indirect branch tracking [3], and
>>>>     - Selftests [4].
>>>
>>> CET is marketing; afaict SS and IBT are 100% independent and there's no
>>> reason what so ever to have them share any code, let alone a Kconfig
>>> knob.
>>>> In fact, I think all of this would improve is you remove the CET name
>>> from all of this entirely. Put this series under CONFIG_X86_SHSTK (or
>>> _SS) and use CONFIG_X86_IBT for the other one.
>>>
>>> Similarly with the .c file.
>>>
>>> All this CET business is just pure confusion.
>>>
>>
>> What about this, we bring back CONFIG_X86_SHSTK and CONFIG_X86_IBT.
>> For the CET name itself, can we change it to CFE (Control Flow Enforcement),
>> or just CF?
> 
> Carry Flag :-)
> 
>> In signal handling, ELF header parsing and arch_prctl(), shadow stack and
>> IBT pretty much share the same code.  It is better not to split them into
>> two sets of files.
> 
> Aside from redoing the UAPI we're stuck with that I suppose :/ And since
> I think the CET name is all over the UAPI, you might as well keep it for
> the kernel part of it as well :-(
> 
> But if there's sufficient !UAPI bits it might still make sense to also
> have ibt.c and shstk.c
> 

I will move code around and separate it into shadow stack and ibt. 
Hopefully in the next iteration, things will be more organized.

Thanks,
Yu-cheng
