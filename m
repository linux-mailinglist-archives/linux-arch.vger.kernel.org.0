Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4572A33E0A2
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 22:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhCPVfC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 17:35:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:46280 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhCPVef (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 17:34:35 -0400
IronPort-SDR: UhgVABevxePUQSRak+i9224inMw64NyGY+DW8VHTEIHalto5JMWHcTA+F5+6+VDLrWuhIi7BV2
 PI48N65ao25w==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="189432430"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="189432430"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 14:34:34 -0700
IronPort-SDR: yid019H0JfrY9SPsars/7syt6hBDNJk9MEAMvFd3IpOQuQak+ncAssix5Mvfxezo1uk2VjtXSA
 doirZow/mTMg==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="522633820"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.191.248]) ([10.212.191.248])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 14:34:33 -0700
Subject: Re: [PATCH v23 00/28] Control-flow Enforcement: Shadow Stack
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <90e453ee-377b-0342-55f9-9412940262f2@intel.com>
Date:   Tue, 16 Mar 2021 14:34:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316211552.GU4746@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/16/2021 2:15 PM, Peter Zijlstra wrote:
> On Tue, Mar 16, 2021 at 08:10:26AM -0700, Yu-cheng Yu wrote:
>> Control-flow Enforcement (CET) is a new Intel processor feature that blocks
>> return/jump-oriented programming attacks.  Details are in "Intel 64 and
>> IA-32 Architectures Software Developer's Manual" [1].
>>
>> CET can protect applications and the kernel.  This series enables only
>> application-level protection, and has three parts:
>>
>>    - Shadow stack [2],
>>    - Indirect branch tracking [3], and
>>    - Selftests [4].
> 
> CET is marketing; afaict SS and IBT are 100% independent and there's no
> reason what so ever to have them share any code, let alone a Kconfig
> knob.

We used to have shadow stack and ibt under separate Kconfig options, but 
in a few places they actually share same code path, such as the XSAVES 
supervisor states and ELF header for example.  Anyways I will be happy 
to make changes again if there is agreement.

> 
> In fact, I think all of this would improve is you remove the CET name
> from all of this entirely. Put this series under CONFIG_X86_SHSTK (or
> _SS) and use CONFIG_X86_IBT for the other one.
> 
> Similarly with the .c file.
> 
> All this CET business is just pure confusion.
>
