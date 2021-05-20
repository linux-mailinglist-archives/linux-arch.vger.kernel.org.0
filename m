Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26CE38B586
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 19:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhETRxj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 13:53:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:36801 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232971AbhETRxj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 13:53:39 -0400
IronPort-SDR: yIA/z2fNjGleDFa3+8xaiF7X8a7xDrnos3A0Pax3U+5BYi9qgC/SbPhGmp2QeXA9aKxcftUDJZ
 bMcRdOr1wK4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="201347985"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="201347985"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 10:52:17 -0700
IronPort-SDR: ubV1dR23fZlDz8Sl4x063SQ54XDoUp+GTBJetaZzXSZU0o/60mTcOtrSvgH0x1hH7/ek3qQ6NG
 boZITUeOglsA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="475295383"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.167.234]) ([10.209.167.234])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 10:52:15 -0700
Subject: Re: [PATCH v26 26/30] ELF: Introduce arch_setup_elf_property()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
 <c29348d8-caae-5226-d095-ae3992d88338@intel.com>
 <YKaesoXCSBmCwD+4@casper.infradead.org>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <89be0683-e1b3-d843-c4b4-ba351ede7427@intel.com>
Date:   Thu, 20 May 2021 10:52:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKaesoXCSBmCwD+4@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/20/2021 10:38 AM, Matthew Wilcox wrote:
> On Wed, May 19, 2021 at 03:14:58PM -0700, Yu, Yu-cheng wrote:
>>>> +++ b/include/uapi/linux/elf.h
>>>> @@ -455,4 +455,13 @@ typedef struct elf64_note {
>>>>    /* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
>>>>    #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
>>>> +/* .note.gnu.property types for x86: */
>>>> +#define GNU_PROPERTY_X86_FEATURE_1_AND		0xc0000002
>>>
>>> Why not 0xc0000001? ARM64 is 0xc0000000...
>>>
>>
>> I just looked at the ABI document.
>>
>> ARM has GNU_PROPERTY_AARCH64_FEATURE_1_AND 0xc0000000
>>
>> X86 has:
>> 	GNU_PROPERTY_X86_ISA_1_USED	0xc0000000
>> 	GNU_PROPERTY_X86_ISA_1_NEEDED	0xc0000001
>> 	GNU_PROPERTY_X86_FEATURE_1_AND	0xc0000002
> 
> Please add all three, not just the last one.
> 

Ok!
