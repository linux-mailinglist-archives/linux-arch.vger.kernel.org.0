Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62D08186983
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 11:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbgCPKyj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 06:54:39 -0400
Received: from foss.arm.com ([217.140.110.172]:46096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730529AbgCPKyj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Mar 2020 06:54:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5497431B;
        Mon, 16 Mar 2020 03:54:38 -0700 (PDT)
Received: from [10.37.9.38] (unknown [10.37.9.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 240FD3F52E;
        Mon, 16 Mar 2020 03:54:32 -0700 (PDT)
Subject: Re: [PATCH v3 18/26] arm64: Introduce asm/vdso/processor.h
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
 <20200313154345.56760-19-vincenzo.frascino@arm.com>
 <20200315182950.GB32205@mbp> <c2c0157a-107a-debf-100f-0d97781add7c@arm.com>
 <20200316103437.GD3005@mbp>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <77a2e91a-58f4-3ba3-9eef-42d6a8faf859@arm.com>
Date:   Mon, 16 Mar 2020 10:55:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200316103437.GD3005@mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Catalin,

On 3/16/20 10:34 AM, Catalin Marinas wrote:
[...]


>>
>> I tried to fine grain the headers as much as I could in order to avoid
>> unneeded/unwanted inclusions:
>>  * TASK_SIZE_32 is used to verify ABI consistency on vdso32 (please refer to
>>    arch/arm64/kernel/vdso32/vgettimeofday.c).
> 
> I see. But the test is probably useless. With 4K pages, TASK_SIZE_32 is
> 1UL << 32, so you can't have a u32 greater than this. So I'd argue that
> the ABI compatibility here doesn't matter.
> 
> With 16K or 64K pages, TASK_SIZE_32 is slightly smaller but arm32 never
> supported it.
> 
> What's the side-effect of dropping this check altogether?
> 

The main side-effect is that arm32 and arm64 compat have a different behavior,
that it is what we want to avoid.

The vdsotest [1] I am using, verifies all the side conditions with respect to
the ABI, which we are now compatible with. Removing those checks would break
this condition.

[1] https://github.com/nlynch-mentor/vdsotest

-- 
Regards,
Vincenzo
