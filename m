Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E7F251BDE
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHYPIt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 11:08:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:37665 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgHYPIs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Aug 2020 11:08:48 -0400
IronPort-SDR: guzVyx3idWPZHQ5VBZqRCfFTGV/WD2RCbcdrkUFbBahs9vWSyxsXP2agiKOpdascBntNeOd7b6
 zSFQNeTnnzEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143902232"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="143902232"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 08:08:47 -0700
IronPort-SDR: KSfTDtD6zIFJ3yrXC9mxYXKt6FSoJ4/pJ7BjhBsF4uQzI1x1YuiipAjh3Izwl0Vjlot+R7UVxg
 keo6AcrqrJ7g==
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="322791026"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.213.162.112]) ([10.213.162.112])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 08:08:46 -0700
Subject: Re: [PATCH v11 9/9] x86: Disallow vsyscall emulation when CET is
 enabled
To:     Florian Weimer <fweimer@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
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
References: <20200825002645.3658-1-yu-cheng.yu@intel.com>
 <20200825002645.3658-10-yu-cheng.yu@intel.com>
 <CALCETrVXwUDu2m-XEd-_J03L=sricM4cMxQYVkdGRWZDjmMB2g@mail.gmail.com>
 <87pn7f9jeq.fsf@oldenburg2.str.redhat.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <0e378792-7ac0-6c52-5607-e73de856d820@intel.com>
Date:   Tue, 25 Aug 2020 08:08:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87pn7f9jeq.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/25/2020 2:14 AM, Florian Weimer wrote:
> * Andy Lutomirski:
> 
>> On Mon, Aug 24, 2020 at 5:30 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>>
>>> From: "H.J. Lu" <hjl.tools@gmail.com>
>>>
>>> Emulation of the legacy vsyscall page is required by some programs built
>>> before 2013.  Newer programs after 2013 don't use it.  Disallow vsyscall
>>> emulation when Control-flow Enforcement (CET) is enabled to enhance
>>> security.
>>
>> NAK.
>>
>> By all means disable execute emulation if CET-IBT is enabled at the
>> time emulation is attempted, and maybe even disable the vsyscall page
>> entirely if you can magically tell that CET-IBT will be enabled when a
>> process starts, but you don't get to just disable it outright on a
>> CET-enabled kernel.
> 
> Yeah, we definitely would have to revert/avoid this downstream.  People
> definitely want to run glibc-2.12-era workloads on current kernels.
> Thanks for catching it.
> 

That makes sense.  I will update the patch.

Thanks,
Yu-cheng
