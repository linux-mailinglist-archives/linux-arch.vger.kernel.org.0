Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40398186EAE
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 16:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbgCPPhC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 11:37:02 -0400
Received: from foss.arm.com ([217.140.110.172]:50756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731505AbgCPPhC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Mar 2020 11:37:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 400A51FB;
        Mon, 16 Mar 2020 08:37:01 -0700 (PDT)
Received: from [10.37.9.38] (unknown [10.37.9.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03C833F534;
        Mon, 16 Mar 2020 08:36:55 -0700 (PDT)
Subject: Re: [PATCH v3 21/26] arm64: Introduce asm/vdso/arch_timer.h
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-22-vincenzo.frascino@arm.com>
 <20200315183151.GE32205@mbp>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <4914ad9c-3eaf-b328-f31b-5d3077ef272f@arm.com>
Date:   Mon, 16 Mar 2020 15:37:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200315183151.GE32205@mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Catalin,

On 3/15/20 6:32 PM, Catalin Marinas wrote:
> On Fri, Mar 13, 2020 at 03:43:40PM +0000, Vincenzo Frascino wrote:
>> The vDSO library should only include the necessary headers required for
>> a userspace library (UAPI and a minimal set of kernel headers). To make
>> this possible it is necessary to isolate from the kernel headers the
>> common parts that are strictly necessary to build the library.
>>
>> Introduce asm/vdso/arch_timer.h to contain all the arm64 specific
>> code. This allows to replace the second isb() in __arch_get_hw_counter()
>> with a fake dependent stack read of the counter which improves the vdso
>> library peformances of ~4.5%. Below the results of vdsotest [1] ran for
>> 100 iterations.
> 
> The subject seems to imply a non-functional change but as you read, it
> gets a lot more complicated. Could you keep the functional change
> separate from the header clean-up, maybe submit it as an independent
> patch? And it shouldn't go in without Will's ack ;).
> 

It is fine by me. I will repost the series with the required fixes and without
this patch. This will give to me enough time to address Mark's comments as well
and to Will to have a proper look.

-- 
Regards,
Vincenzo
