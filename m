Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA762FBEF0
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jan 2021 19:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbhASS1B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 13:27:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:18071 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390060AbhASSLh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Jan 2021 13:11:37 -0500
IronPort-SDR: JW+2Ghkgf597jUJ+dJyEJhmVkeKeuLReUZnhTiV7ZwtE0KWk1uj8IRLcJ1lp0KKT76zdzRU4bP
 b7W6pOXS4XCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="175469449"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="175469449"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 10:10:28 -0800
IronPort-SDR: MW+Y7Gj0C/LBuROhQHYbzeTL9GqKCSiDMootWJB1BDgmJJ+fW+k+A/nIJvJFMnk3f3BkFyB4T4
 CBQDqs25p7+g==
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="571089734"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.139.183]) ([10.209.139.183])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 10:10:25 -0800
Subject: Re: [PATCH v17 02/26] x86/cet/shstk: Add Kconfig option for user-mode
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
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-3-yu-cheng.yu@intel.com>
 <20210119110659.GG27433@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <e249dad7-1a33-964c-ffa6-c7921564c813@intel.com>
Date:   Tue, 19 Jan 2021 10:10:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119110659.GG27433@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/19/2021 3:06 AM, Borislav Petkov wrote:
> On Tue, Dec 29, 2020 at 01:30:29PM -0800, Yu-cheng Yu wrote:
>> Shadow Stack provides protection against function return address
>> corruption.  It is active when the processor supports it, the kernel has
>> CONFIG_X86_CET_USER enabled, and the application is built for the feature.
>> This is only implemented for the 64-bit kernel.  When it is enabled, legacy
>> non-Shadow Stack applications continue to work, but without protection.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> ---
>>   arch/x86/Kconfig           | 22 ++++++++++++++++++++++
>>   arch/x86/Kconfig.assembler |  5 +++++
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 7b6dd10b162a..72cff400b9ae 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1950,6 +1950,28 @@ config X86_SGX
>>   
>>   	  If unsure, say N.
>>   
>> +config ARCH_HAS_SHADOW_STACK
>> +	def_bool n
>> +
>> +config X86_CET_USER
> 
> That thing needs to be X86_CET. How many times do I need to type this
> before you do it?
> 

Yes, I totally understand that now.  I was still thinking about 
separately enabling user/kernel mode.  Perhaps I should have 
communicated that thought before the change.  Sorry about that.  I will 
update it.

--
Yu-cheng
