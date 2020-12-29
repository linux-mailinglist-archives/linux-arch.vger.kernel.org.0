Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26892E725A
	for <lists+linux-arch@lfdr.de>; Tue, 29 Dec 2020 17:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgL2Qff (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Dec 2020 11:35:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:16329 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgL2Qfe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Dec 2020 11:35:34 -0500
IronPort-SDR: VaVd5Ys1JKd0Ly9gmiVYspzMBb8YfggZlAMPWIGacHvV9ZvhDQcvGA83Wug6cgMgI2Q6gzSt0f
 1/52q6cxYKfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="176608615"
X-IronPort-AV: E=Sophos;i="5.78,458,1599548400"; 
   d="scan'208";a="176608615"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 08:34:53 -0800
IronPort-SDR: Wl5EDOps++Sos5Yh78VcJcwz2qfJFTwjnoTuS6PxulCuZ2H6XYQEqKjNjZ5w+VQZcz+Mv3rcID
 +GA8BBRxgBKA==
X-IronPort-AV: E=Sophos;i="5.78,458,1599548400"; 
   d="scan'208";a="347442009"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.0.43]) ([10.251.0.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 08:34:51 -0800
Subject: Re: [PATCH v16 02/26] x86/cet/shstk: Add Kconfig option for user-mode
 control-flow protection
To:     Borislav Petkov <bp@alien8.de>
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
References: <20201209222320.1724-1-yu-cheng.yu@intel.com>
 <20201209222320.1724-3-yu-cheng.yu@intel.com>
 <20201229123910.GB29947@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <c193c18e-6a3c-e079-67dc-bca35bceee71@intel.com>
Date:   Tue, 29 Dec 2020 08:34:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201229123910.GB29947@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/29/2020 4:39 AM, Borislav Petkov wrote:
> On Wed, Dec 09, 2020 at 02:22:56PM -0800, Yu-cheng Yu wrote:
>> Shadow Stack provides protection against function return address
>> corruption.  It is active when the processor supports it, the kernel has
>> CONFIG_X86_CET_USER, and the application is built for the feature.
> 		     ^
> 		   enabled.
> 
>> This is only implemented for the 64-bit kernel.  When it is enabled, legacy
>> non-Shadow Stack applications continue to work, but without protection.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> ---
>>   arch/x86/Kconfig           | 22 ++++++++++++++++++++++
>>   arch/x86/Kconfig.assembler |  5 +++++
>>   2 files changed, 27 insertions(+)
> 
> Rest looks good, thanks.
> 

Thanks!  I will re-base to v5.11-rc1 and send out a new version.

--
Yu-cheng
