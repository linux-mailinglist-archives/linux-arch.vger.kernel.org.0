Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC93030B30C
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 00:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBAW7O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Feb 2021 17:59:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:27365 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhBAW7N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Feb 2021 17:59:13 -0500
IronPort-SDR: TGTUU0C3FenrfWZzVHFx1Kb7pHcLYodLaOqq+uxCfSfrk3hfn+V3awf0OaeAQKJ8cquqXbAySh
 gGvUpguaLKbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="244847966"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="244847966"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 14:58:20 -0800
IronPort-SDR: IqxOEgskYY60zTXTSLKF3fe22Kcgl7l+wrY0AwgxcVcrUsG5CnA0GwGkRgywoMJYKqKeJ1U2qR
 KdB7JM0lGQIQ==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="370146281"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.112.229]) ([10.212.112.229])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 14:58:19 -0800
Subject: Re: [PATCH v18 21/25] x86/cet/shstk: Handle signals for shadow stack
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
References: <20210127212524.10188-1-yu-cheng.yu@intel.com>
 <20210127212524.10188-22-yu-cheng.yu@intel.com>
 <09da02c5-c6fb-878e-ad34-222f3a152460@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <21462baa-8924-f005-33e1-f5fa36ed9942@intel.com>
Date:   Mon, 1 Feb 2021 14:58:19 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <09da02c5-c6fb-878e-ad34-222f3a152460@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/1/2021 2:53 PM, Dave Hansen wrote:
> On 1/27/21 1:25 PM, Yu-cheng Yu wrote:
>> To deliver a signal, create a shadow stack restore token and put a restore
>> token and the signal restorer address on the shadow stack.  For sigreturn,
>> verify the token and restore the shadow stack pointer.
>>
>> Introduce WRUSS, which is a kernel-mode instruction but writes directly to
>> user shadow stack.  It is used to construct the user signal stack as
>> described above.
>>
>> Introduce a signal context extension struct 'sc_ext', which is used to save
>> shadow stack restore token address and WAIT_ENDBR status.  WAIT_ENDBR will
>> be introduced later in the Indirect Branch Tracking (IBT) series, but add
>> that into sc_ext now to keep the struct stable in case the IBT series is
>> applied later.
> 
> This changelog needs some work.  It's got a lot of "what" and not enough
> "why".
> 
> Why do we need a token?
> What function does it serve?
> What does it protect against?
> Why do we need a signal context extension?
> 

I will update it.

--
Yu-cheng
