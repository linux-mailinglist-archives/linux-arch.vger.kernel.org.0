Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913EB2C72B1
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgK1VuP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:19858 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730015AbgK1Se6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 28 Nov 2020 13:34:58 -0500
IronPort-SDR: yZ5ypykwZaqAGwmfTPK4ggSzuCyzMIvoDmRZL7zSoZIZEOa9o+RVKR26mUKKrIeDxDvC6HhEuX
 GqfPTFIoLfBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9819"; a="159537387"
X-IronPort-AV: E=Sophos;i="5.78,377,1599548400"; 
   d="scan'208";a="159537387"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 08:31:04 -0800
IronPort-SDR: +n7zX3+y7NU8HyCqky6ikXcGlW5FSpcq0oLNmMMVjen8KqccfxO8hC+osTPgLafcCAfE1F3j1x
 QRE+JF0pkCEw==
X-IronPort-AV: E=Sophos;i="5.78,377,1599548400"; 
   d="scan'208";a="480007886"
Received: from jckaplan-mobl1.amr.corp.intel.com (HELO [10.212.23.254]) ([10.212.23.254])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 08:31:02 -0800
Subject: Re: [PATCH v15 00/26] Control-flow Enforcement: Shadow Stack
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201127092905.GB473773@balbir-desktop>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <60d3c72c-b85f-88ac-c79b-1340445bb228@intel.com>
Date:   Sat, 28 Nov 2020 08:31:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201127092905.GB473773@balbir-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/27/2020 1:29 AM, Balbir Singh wrote:
> On Tue, Nov 10, 2020 at 08:21:45AM -0800, Yu-cheng Yu wrote:
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
>>
>> I have run tests on these patches for quite some time, and they have been
>> very stable.  Linux distributions with CET are available now, and Intel
>> processors with CET are becoming available.  It would be nice if CET
>> support can be accepted into the kernel.  I will be working to address any
>> issues should they come up.
>>
> 
> Is there a way to run these patches for testing? Bochs emulation or anything
> else? I presume you've been testing against violations of CET in user space?
> Can you share your testing?
>   
> Balbir Singh.
> 

Machines with CET are already available on the market.  I tested these 
on real machines with Fedora.  There is a quick test in my earlier 
selftest patches:

https://lore.kernel.org/linux-api/20200521211720.20236-6-yu-cheng.yu@intel.com/

Thanks,
Yu-cheng
