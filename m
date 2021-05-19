Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9175C389925
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 00:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhESWQW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 18:16:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:24024 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhESWQV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 18:16:21 -0400
IronPort-SDR: pkuOXVHZbA1qShTff2ljYedicsWZkHXCAq8D8z5RZFbgxbSMuQltZIGwJkWGSsyCHGVmKnNGTp
 aQvIy+qzSAsA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="199134411"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="199134411"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 15:15:00 -0700
IronPort-SDR: 4htN2xJSznuZVhLFhhbfFRkZUb4nixiLBd8DZWgrRmw3SzyxERNbqQvWzA8B9KUhCVR5lyo/+I
 JW12+IiyJbFA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="467381111"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.169.18]) ([10.209.169.18])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 15:14:58 -0700
Subject: Re: [PATCH v26 26/30] ELF: Introduce arch_setup_elf_property()
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-27-yu-cheng.yu@intel.com> <YKVUgzJ0MVNBgjDd@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <c29348d8-caae-5226-d095-ae3992d88338@intel.com>
Date:   Wed, 19 May 2021 15:14:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKVUgzJ0MVNBgjDd@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/19/2021 11:10 AM, Borislav Petkov wrote:
> On Tue, Apr 27, 2021 at 01:43:11PM -0700, Yu-cheng Yu wrote:
>> @@ -1951,6 +1951,8 @@ config X86_SHADOW_STACK
>>   	depends on AS_WRUSS
>>   	depends on ARCH_HAS_SHADOW_STACK
>>   	select ARCH_USES_HIGH_VMA_FLAGS
>> +	select ARCH_USE_GNU_PROPERTY
>> +	select ARCH_BINFMT_ELF_STATE
> 		^^^^^^^^
> 
> What's that for? Isn't ARCH_USE_GNU_PROPERTY enough?
> 

ARCH_USE_GNU_PROPERTY is for defining parsing functions, e.g.
	arch_parse_elf_property(),
	arch_setup_property().

ARCH_BINFMT_ELF_STATE is for defining "struct arch_elf_state".

However, those parsing functions take (struct arch_elf_state *) as an 
input.  It probably makes sense to have ARCH_USE_GNU_PROPERTY dependent 
on ARCH_BINFMT_ELF_STATE.  It would be ok as-is too.  ARM people might 
have other plans in mind.

[...]

> 
>> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
>> index 30f68b42eeb5..24ba55ba8278 100644
>> --- a/include/uapi/linux/elf.h
>> +++ b/include/uapi/linux/elf.h
>> @@ -455,4 +455,13 @@ typedef struct elf64_note {
>>   /* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
>>   #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
>>   
>> +/* .note.gnu.property types for x86: */
>> +#define GNU_PROPERTY_X86_FEATURE_1_AND		0xc0000002
> 
> Why not 0xc0000001? ARM64 is 0xc0000000...
> 

I just looked at the ABI document.

ARM has GNU_PROPERTY_AARCH64_FEATURE_1_AND 0xc0000000

X86 has:
	GNU_PROPERTY_X86_ISA_1_USED	0xc0000000
	GNU_PROPERTY_X86_ISA_1_NEEDED	0xc0000001
	GNU_PROPERTY_X86_FEATURE_1_AND	0xc0000002

Yu-cheng
