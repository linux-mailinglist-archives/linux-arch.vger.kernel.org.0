Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271FC31706E
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 20:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhBJTmE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 14:42:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:39635 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232932AbhBJTls (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Feb 2021 14:41:48 -0500
IronPort-SDR: EbWiv2hgZEXet/YSwr4LUv3JI0lliryTiXd/falh8ELSvNQ7+itc5nIVzfGMHC5BuCDelG2rsM
 Z6A+z9leWQ/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="178632073"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="178632073"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 11:41:04 -0800
IronPort-SDR: KGA2BB3jRS+CMMBEPJAqj9sVyfhxs6cTMlumHyeSJGpdLcay/qMDdk70do9WapdKIkrKdBcdUp
 tLcMgVMycIcw==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="396888205"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.188.167]) ([10.212.188.167])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 11:40:58 -0800
Subject: Re: [PATCH v20 02/25] x86/cet/shstk: Add Kconfig option for user-mode
 control-flow protection
To:     Kees Cook <keescook@chromium.org>
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>, haitao.huang@intel.com
References: <20210210175703.12492-1-yu-cheng.yu@intel.com>
 <20210210175703.12492-3-yu-cheng.yu@intel.com>
 <202102101133.3C94A64@keescook>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <29b4b8ad-3bcd-8bc7-d6a1-6cea483eb2f6@intel.com>
Date:   Wed, 10 Feb 2021 11:40:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102101133.3C94A64@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/10/2021 11:33 AM, Kees Cook wrote:
> On Wed, Feb 10, 2021 at 09:56:40AM -0800, Yu-cheng Yu wrote:
>> Shadow Stack provides protection against function return address
>> corruption.  It is active when the processor supports it, the kernel has
>> CONFIG_X86_CET enabled, and the application is built for the feature.
>> This is only implemented for the 64-bit kernel.  When it is enabled, legacy
>> non-Shadow Stack applications continue to work, but without protection.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> ---
>>   arch/x86/Kconfig           | 23 +++++++++++++++++++++++
>>   arch/x86/Kconfig.assembler |  5 +++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 21f851179ff0..1138b5fa9b4f 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -28,6 +28,7 @@ config X86_64
>>   	select ARCH_HAS_GIGANTIC_PAGE
>>   	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>>   	select ARCH_USE_CMPXCHG_LOCKREF
>> +	select ARCH_HAS_SHADOW_STACK
>>   	select HAVE_ARCH_SOFT_DIRTY
>>   	select MODULES_USE_ELF_RELA
>>   	select NEED_DMA_MAP_STATE
>> @@ -1951,6 +1952,28 @@ config X86_SGX
>>   
>>   	  If unsure, say N.
>>   
>> +config ARCH_HAS_SHADOW_STACK
>> +	def_bool n
>> +
>> +config X86_CET
>> +	prompt "Intel Control-flow protection for user-mode"
>> +	def_bool n
>> +	depends on X86_64
> 
> This depends isn't needed any more. With that fixed:

Yes, that's right.  I will remove it.

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks!

--
Yu-cheng
