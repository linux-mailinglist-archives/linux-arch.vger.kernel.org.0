Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039EB272BB6
	for <lists+linux-arch@lfdr.de>; Mon, 21 Sep 2020 18:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgIUQWa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 12:22:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:36798 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIUQW3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Sep 2020 12:22:29 -0400
IronPort-SDR: WAODNz+AWg2Fv1qgtS+4SfBx2nYuI6MWYQRyP3bsZ7tj77dLTudoIB7CoTTrUlXTS1nvPJoRVC
 b8iThqVFPTkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="148077072"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="148077072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 09:22:27 -0700
IronPort-SDR: DzeCj1CYXt5zm0Njvv2xtnUdYaZZmhzsBjJGNA1e7sXxqTd/uptwCH02FfBaxY46EttPZoUWgv
 pQwlJ5MOClew==
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="348153605"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.102.78]) ([10.212.102.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 09:22:26 -0700
Subject: Re: [PATCH v12 8/8] x86: Disallow vsyscall emulation when CET is
 enabled
To:     Andy Lutomirski <luto@kernel.org>
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
 <20200918192312.25978-9-yu-cheng.yu@intel.com>
 <CALCETrXfixDGJhf0yPw-OckjEdeF2SbYjWFm8VbLriiP0Krhrg@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <c96c98ec-d72a-81a3-06e2-2040f3ece33a@intel.com>
Date:   Mon, 21 Sep 2020 09:22:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXfixDGJhf0yPw-OckjEdeF2SbYjWFm8VbLriiP0Krhrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/18/2020 5:11 PM, Andy Lutomirski wrote:
> On Fri, Sep 18, 2020 at 12:23 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> Emulation of the legacy vsyscall page is required by some programs
>> built before 2013.  Newer programs after 2013 don't use it.
>> Disable vsyscall emulation when Control-flow Enforcement (CET) is
>> enabled to enhance security.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> ---
>> v12:
>> - Disable vsyscall emulation only when it is attempted (vs. at compile time).
>>
>>   arch/x86/entry/vsyscall/vsyscall_64.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
>> index 44c33103a955..3196e963e365 100644
>> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
>> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
>> @@ -150,6 +150,15 @@ bool emulate_vsyscall(unsigned long error_code,
>>
>>          WARN_ON_ONCE(address != regs->ip);
>>
>> +#ifdef CONFIG_X86_INTEL_CET
>> +       if (current->thread.cet.shstk_size ||
>> +           current->thread.cet.ibt_enabled) {
>> +               warn_bad_vsyscall(KERN_INFO, regs,
>> +                                 "vsyscall attempted with cet enabled");
>> +               return false;
>> +       }
> 
> Nope, try again.  Having IBT on does *not* mean that every library in
> the process knows that we have indirect branch tracking.  The legacy
> bitmap exists for a reason.  Also, I want a way to flag programs as
> not using the vsyscall page, but that flag should not be called CET.
> And a process with vsyscalls off should not be able to read the
> vsyscall page, and /proc/self/maps should be correct.
> 
> So you have some choices:
> 
> 1. Drop this patch and make it work.
> 
> 2. Add a real per-process vsyscall control.  Either make it depend on
> vsyscall=xonly and wire it up correctly or actually make it work
> correctly with vsyscall=emulate.
> 
> NAK to any hacks in this space.  Do it right or don't do it at all.
> 

We can drop this patch, and bring back the previous patch that fixes up 
shadow stack and ibt.  That makes vsyscall emulation work correctly, and 
does not force the application to do anything different from what is 
working now.  I will post the previous patch as a reply to this thread 
so that people can make comments on it.

Yu-cheng
