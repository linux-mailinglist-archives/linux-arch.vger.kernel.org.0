Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B151A34F5
	for <lists+linux-arch@lfdr.de>; Thu,  9 Apr 2020 15:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDINgI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Apr 2020 09:36:08 -0400
Received: from foss.arm.com ([217.140.110.172]:50244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgDINgI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Apr 2020 09:36:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD66930E;
        Thu,  9 Apr 2020 06:36:07 -0700 (PDT)
Received: from [10.37.8.193] (unknown [10.37.8.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B1603F73D;
        Thu,  9 Apr 2020 06:36:03 -0700 (PDT)
Subject: Re: [PATCH v3 21/26] arm64: Introduce asm/vdso/arch_timer.h
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-22-vincenzo.frascino@arm.com>
 <20200315183151.GE32205@mbp> <4914ad9c-3eaf-b328-f31b-5d3077ef272f@arm.com>
 <20200409132633.GD13078@willie-the-truck>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <d578db85-7581-9bbb-2dab-25555e424ceb@arm.com>
Date:   Thu, 9 Apr 2020 14:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200409132633.GD13078@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Will,

On 4/9/20 2:26 PM, Will Deacon wrote:
> Hi Vincenzo,
> 
> Sorry, I was on holiday when you posted this and it slipped through the
> cracks.
> 

No issue at all. Thank you for getting back to me.

> On Mon, Mar 16, 2020 at 03:37:23PM +0000, Vincenzo Frascino wrote:
>>> On Fri, Mar 13, 2020 at 03:43:40PM +0000, Vincenzo Frascino wrote:
>>>> The vDSO library should only include the necessary headers required for
>>>> a userspace library (UAPI and a minimal set of kernel headers). To make
>>>> this possible it is necessary to isolate from the kernel headers the
>>>> common parts that are strictly necessary to build the library.
>>>>
>>>> Introduce asm/vdso/arch_timer.h to contain all the arm64 specific
>>>> code. This allows to replace the second isb() in __arch_get_hw_counter()
>>>> with a fake dependent stack read of the counter which improves the vdso
>>>> library peformances of ~4.5%. Below the results of vdsotest [1] ran for
>>>> 100 iterations.
>>>
>>> The subject seems to imply a non-functional change but as you read, it
>>> gets a lot more complicated. Could you keep the functional change
>>> separate from the header clean-up, maybe submit it as an independent
>>> patch? And it shouldn't go in without Will's ack ;).
>>>
>>
>> It is fine by me. I will repost the series with the required fixes and without
>> this patch. This will give to me enough time to address Mark's comments as well
>> and to Will to have a proper look.
> 
> Please can you post whatever is left at -rc1? I'll have a look then, but
> let's stick to just moving code around rather than randomly changing it
> at the same time, ok?
> 

Sure, I will try to re-post it by -rc1 and take on board your comments.

> Thanks,
> 
> Will
> 

-- 
Regards,
Vincenzo
