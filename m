Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2453421C9
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 17:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCSQYe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 12:24:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:1251 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhCSQYM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Mar 2021 12:24:12 -0400
IronPort-SDR: By9IQQ4GaUfFcSoTvRrzC60BVrkzdJGkOhTeFRFdYC/ezkXqaQVnKtdyYqXawwOadw4exin6CX
 Lvwj5WELPkYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="189302577"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="189302577"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 09:24:12 -0700
IronPort-SDR: o3DGciW8KGoQICX8T/gkyV99iraCaufszZ2fID2FohW8nHAIPwzfPXYALNpFGfDLzwX7vKhd+J
 eiKXa2vfuyug==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="603189058"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.100.40]) ([10.212.100.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 09:24:11 -0700
Subject: Re: [PATCH v23 00/28] Control-flow Enforcement: Shadow Stack
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316211552.GU4746@worktop.programming.kicks-ass.net>
 <90e453ee-377b-0342-55f9-9412940262f2@intel.com>
 <20210317091800.GA1461644@gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <a7c64629-16f4-69db-07f8-ad22d8602034@intel.com>
Date:   Fri, 19 Mar 2021 09:24:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317091800.GA1461644@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/17/2021 2:18 AM, Ingo Molnar wrote:
> 
> * Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
> 
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
>>
>> We used to have shadow stack and ibt under separate Kconfig options, but in
>> a few places they actually share same code path, such as the XSAVES
>> supervisor states and ELF header for example.  Anyways I will be happy to
>> make changes again if there is agreement.
> 
> I was look at:
> 
>    x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states
> 
> didn't see any IBT logic - it's essentially all shadow stack state.
> 
> Which is not surprising, forward call edge integrity protection (IBT)
> requires very little state, does it?
> 
> With IBT there's no nesting, no stack - the IBT state machine
> basically requires the next instruction to be and ENDBR instruction,
> and that's essentially it, right?
> 
> Thanks,
> 
> 	Ingo
> 

Yes, that is it.  The CET_WAIT_ENDBR bit is the status of IBT state 
machine.  There are a few bits in MSR_IA32_U_CET controlling how IBT 
works, but those are not status.

Yu-cheng
