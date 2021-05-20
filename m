Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF2238B512
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 19:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhETRTf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 13:19:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:21876 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231730AbhETRTe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 13:19:34 -0400
IronPort-SDR: qrlswRfHOWb/ahG1ob9aj0ZqJAasiwKywXqw564NefupT5MYaVKxXYqhxT6+9YbAW6tfUJcio9
 E3oN2Q2J4WpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="262508282"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262508282"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 10:18:11 -0700
IronPort-SDR: +Ag2SsApIJEIlKZfue7i6g7Kg5zY9nUKyaziq+N5gU5DS0FMi1OlubULGDUNx+eIrh36+w89Ij
 4osxWTb2YRng==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="475283324"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.167.234]) ([10.209.167.234])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 10:18:10 -0700
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
 <c29348d8-caae-5226-d095-ae3992d88338@intel.com> <YKYrQQ6tKfifjNjW@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <d04259f1-a869-ec1c-aa74-93cd6c2c2d7b@intel.com>
Date:   Thu, 20 May 2021 10:18:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKYrQQ6tKfifjNjW@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/20/2021 2:26 AM, Borislav Petkov wrote:
> On Wed, May 19, 2021 at 03:14:58PM -0700, Yu, Yu-cheng wrote:
>> However, those parsing functions take (struct arch_elf_state *) as an input.
> 
> Exactly.
> 
>> It probably makes sense to have ARCH_USE_GNU_PROPERTY dependent on
>> ARCH_BINFMT_ELF_STATE.  It would be ok as-is too.  ARM people might have
>> other plans in mind.
> 
> Well, let's look at ARM, ARM64 in particular. They have defined struct
> arch_elf_state without the ifdeffery in
> 
> arch/arm64/include/asm/elf.h
> 
> and are using that struct in arch_parse_elf_property().
> 
> And they have selected ARCH_BINFMT_ELF_STATE just so that they disable
> those dummy accessors in fs/binfmt_elf.c
> 
> And you're practically glueing together ARCH_BINFMT_ELF_STATE and
> ARCH_USE_GNU_PROPERTY. However, all the functionality is for adding
> the gnu property note so I think you should select both but only use
> ARCH_USE_GNU_PROPERTY in all the ifdeffery in your patch to at least
> have this as simple as possible.
> 

ARM64 has ARCH_USE_GNU_PROPERTY and ARCH_BINFMT_ELF_STATE selected 
unconditionally.  We will do the same for X86_64 and remove the ifdeffery.

>> I just looked at the ABI document.
> 
> Which document is that? Link?
> 
>> ARM has GNU_PROPERTY_AARCH64_FEATURE_1_AND 0xc0000000
>>
>> X86 has:
>> 	GNU_PROPERTY_X86_ISA_1_USED	0xc0000000
>> 	GNU_PROPERTY_X86_ISA_1_NEEDED	0xc0000001
>> 	GNU_PROPERTY_X86_FEATURE_1_AND	0xc0000002
> 
> Our defines should at least have a comment pointing to that document.
> 
> Thx.
> 

The latest pdf's are posted here.

https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/x86-64-psABI

Thanks,
Yu-cheng
