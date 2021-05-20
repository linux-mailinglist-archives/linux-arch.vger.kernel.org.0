Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B7138B8BB
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 23:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhETVIA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 17:08:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:40169 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhETVIA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 17:08:00 -0400
IronPort-SDR: 0Xk6l6xI8sJdlbl0Zki2xb30mFugzrV6bzBMElrpGkJzG04nArOeqMyBn746trLzQ3LYDkos0l
 DAUV8LtdEHIQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="262560467"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262560467"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 14:06:37 -0700
IronPort-SDR: 1LaHlQbEIAaulARfd6pepuB9A1uuFmz3hYPtGsneBv9e13fT63+Y8VTImuWAG69kBQg6/JNBWa
 M/5pNrvRTOCw==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440623013"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.167.234]) ([10.209.167.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 14:06:34 -0700
Subject: Re: [PATCH v26 26/30] ELF: Introduce arch_setup_elf_property()
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
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
 <89be0683-e1b3-d843-c4b4-ba351ede7427@intel.com>
Message-ID: <3edd6ac7-4aa2-5f09-245a-3e5cf4bb06aa@intel.com>
Date:   Thu, 20 May 2021 14:06:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <89be0683-e1b3-d843-c4b4-ba351ede7427@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/20/2021 10:52 AM, Yu, Yu-cheng wrote:
> On 5/20/2021 10:38 AM, Matthew Wilcox wrote:
>> On Wed, May 19, 2021 at 03:14:58PM -0700, Yu, Yu-cheng wrote:
>>>>> +++ b/include/uapi/linux/elf.h
>>>>> @@ -455,4 +455,13 @@ typedef struct elf64_note {
>>>>>    /* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
>>>>>    #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI    (1U << 0)
>>>>> +/* .note.gnu.property types for x86: */
>>>>> +#define GNU_PROPERTY_X86_FEATURE_1_AND        0xc0000002
>>>>
>>>> Why not 0xc0000001? ARM64 is 0xc0000000...
>>>>
>>>
>>> I just looked at the ABI document.
>>>
>>> ARM has GNU_PROPERTY_AARCH64_FEATURE_1_AND 0xc0000000
>>>
>>> X86 has:
>>>     GNU_PROPERTY_X86_ISA_1_USED    0xc0000000
>>>     GNU_PROPERTY_X86_ISA_1_NEEDED    0xc0000001
>>>     GNU_PROPERTY_X86_FEATURE_1_AND    0xc0000002
>>
>> Please add all three, not just the last one.
>>
> 
> Ok!

Just found out, I have been reading an older version.  Now 0xc0000000 
and 0xc0000001 have become reserved/not-used.  Maybe I will just put a 
note about that along with the link to the ABI document.

Yu-cheng
