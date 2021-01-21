Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171112FF63A
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 21:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbhAUUpa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 15:45:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:37512 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbhAUUp2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 15:45:28 -0500
IronPort-SDR: PQwBvX+2Yrz1KbyVxZcgFh51rJ9AAnsY23wGCPsYrm4C5zb/BCGemrBVLySJV/sgKLJYZWaKoR
 EZS9syFibIbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="264158504"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="264158504"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 12:44:42 -0800
IronPort-SDR: iWrkowc9lTVPGtp0BdOaORGEGvpEGVXhbQ55YISgflUo4A/le6q/fC8so1C94c4aKOjD+IHlFj
 60JH6Cj0qe7w==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="385456191"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.46.254]) ([10.209.46.254])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 12:44:40 -0800
Subject: Re: [PATCH v17 08/26] x86/mm: Introduce _PAGE_COW
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-9-yu-cheng.yu@intel.com>
 <20210121184405.GE32060@zn.tnic>
 <b4d4bec7-504e-2443-4cf3-0801b179000f@intel.com>
 <ecb5eb93-5dac-5c05-a72b-aa4719e1351f@intel.com>
 <28f56a51-b8e5-4f1f-1cda-036670c80a22@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <6d696e26-4a08-b5bb-8ddf-6800ab98c49c@intel.com>
Date:   Thu, 21 Jan 2021 12:44:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <28f56a51-b8e5-4f1f-1cda-036670c80a22@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/21/2021 12:26 PM, Dave Hansen wrote:
>> Usually, the compiler is better at making code efficient than humans.  I
>> find that coding it in the most human-readable way is best unless I
>> *know* the compiler is unable to generate god code.
> 
> "good code", even.
> 
> I really want a "god code" compiler, though. :)
> 
With my version of GCC, the shifting implementation creates five 
instructions, all operate on registers only.  The other implementation 
also creates five instructions, but introduces one jump and one memory 
access.  But, you are right, being readable is also important.  Maybe we 
can tweak it a little or create something similar to those in bitops.

--
Yu-cheng
