Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A91254EA9
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 21:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgH0Td7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 15:33:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:43719 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgH0Td7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 15:33:59 -0400
IronPort-SDR: +r6fOacdljr8O+XW1cTad84jUIE7pZNHKkJaT1uSMWl6eHa21H0b0ytE/AM0IBxKmAXdvx7cBV
 bfUPu2xS99zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="174603365"
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="174603365"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 12:33:58 -0700
IronPort-SDR: OPISa7thH3ifFl2p+owBLIitIqmZbW/hl+EP5wSwNVukJNFhzMv4wB+31X5KIa136wfknEKV7P
 7teTxH4ipSsQ==
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="500229981"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.213.179.54]) ([10.213.179.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 12:33:57 -0700
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
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
References: <a770d45d-b147-a8c5-b7f8-30d668cbed84@intel.com>
 <4BDFD364-798C-4537-A88E-F94F101F524B@amacapital.net>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <a6de6b9d-d724-271d-72b2-8dd3418ccaed@intel.com>
Date:   Thu, 27 Aug 2020 12:33:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4BDFD364-798C-4537-A88E-F94F101F524B@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/27/2020 11:56 AM, Andy Lutomirski wrote:
> 
> 
>> On Aug 27, 2020, at 11:13 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>>
>> ﻿On 8/27/2020 6:36 AM, Florian Weimer wrote:
>>> * H. J. Lu:
>>>>> On Thu, Aug 27, 2020 at 6:19 AM Florian Weimer <fweimer@redhat.com> wrote:
>>>>>>
>>>>>> * Dave Martin:
>>>>>>
>>>>>>> You're right that this has implications: for i386, libc probably pulls
>>>>>>> more arguments off the stack than are really there in some situations.
>>>>>>> This isn't a new problem though.  There are already generic prctls with
>>>>>>> fewer than 4 args that are used on x86.
>>>>>>
>>>>>> As originally posted, glibc prctl would have to know that it has to pull
>>>>>> an u64 argument off the argument list for ARCH_X86_CET_DISABLE.  But
>>>>>> then the u64 argument is a problem for arch_prctl as well.
>>>>>>
>>>>
>>>> Argument of ARCH_X86_CET_DISABLE is int and passed in register.
>>> The commit message and the C source say otherwise, I think (not sure
>>> about the C source, not a kernel hacker).
>>
>> H.J. Lu suggested that we fix x86 arch_prctl() to take four arguments, and then keep MMAP_SHSTK as an arch_prctl().  Because now the map flags and size are all in registers, this also solves problems being pointed out earlier.  Without a wrapper, the shadow stack mmap call (from user space) will be:
>>
>> syscall(_NR_arch_prctl, ARCH_X86_CET_MMAP_SHSTK, size, MAP_32BIT).
> 
> I admit I don’t see a show stopping technical reason we can’t add arguments to an existing syscall, but I’m pretty sure it’s unprecedented, and it doesn’t seem like a good idea.
> 

There are nine existing arch_prctl calls now.  If the concern is the 
extra new arguments getting misused, we can mask them out for the 
existing calls.  Otherwise, I have not seen anything that can break.

Yu-cheng
