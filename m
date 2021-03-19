Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A503427F2
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 22:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhCSVnn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 17:43:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:8668 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhCSVnH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Mar 2021 17:43:07 -0400
IronPort-SDR: RSiSITZep4KuY9xDwMvGo553udx8tKIJxQp1wf3YX+3AcAaiHQDfTUJY1d1wv7SNk1u5wvSoC+
 xP+qT3EzRbag==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="190066754"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="190066754"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 14:43:06 -0700
IronPort-SDR: iT/r8ByvMuU8XTKNeF3yq/D/QfUHXYpCYZjIvu/4fy4S0PaDOlSkasOytpgZFg7aZUrat2BnHp
 M2DQvWQ8JZmw==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="603266289"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.100.40]) ([10.212.100.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 14:43:05 -0700
Subject: Re: [PATCH v23 00/28] Control-flow Enforcement: Shadow Stack
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <adb72123-e8b3-c022-47da-b8c423952caf@intel.com>
Date:   Fri, 19 Mar 2021 14:43:04 -0700
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
> > In fact, I think all of this would improve is you remove the CET name
> from all of this entirely. Put this series under CONFIG_X86_SHSTK (or
> _SS) and use CONFIG_X86_IBT for the other one.
> 
> Similarly with the .c file.
> 
> All this CET business is just pure confusion.
> 

What about this, we bring back CONFIG_X86_SHSTK and CONFIG_X86_IBT.
For the CET name itself, can we change it to CFE (Control Flow 
Enforcement), or just CF?

In signal handling, ELF header parsing and arch_prctl(), shadow stack 
and IBT pretty much share the same code.  It is better not to split them 
into two sets of files.

Thanks,
Yu-cheng
