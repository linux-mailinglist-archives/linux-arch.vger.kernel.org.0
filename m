Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A64188ADC
	for <lists+linux-arch@lfdr.de>; Tue, 17 Mar 2020 17:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQQnJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 12:43:09 -0400
Received: from foss.arm.com ([217.140.110.172]:40394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgCQQnJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 12:43:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2465E30E;
        Tue, 17 Mar 2020 09:43:08 -0700 (PDT)
Received: from [10.37.12.228] (unknown [10.37.12.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEF153F52E;
        Tue, 17 Mar 2020 09:43:03 -0700 (PDT)
Subject: Re: [PATCH v4 18/26] arm64: vdso32: Replace TASK_SIZE_32 check in
 vgettimeofday
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-mips@vger.kernel.org, x86@kernel.org,
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
References: <20200317122220.30393-1-vincenzo.frascino@arm.com>
 <20200317122220.30393-19-vincenzo.frascino@arm.com>
 <20200317143834.GC632169@arrakis.emea.arm.com>
 <f03a9493-c8c2-e981-f560-b2f437a208e4@arm.com>
 <20200317155031.GD632169@arrakis.emea.arm.com>
 <83aaf9e1-0a8f-4908-577a-23766541b2ba@arm.com>
Message-ID: <4eaa8717-78b4-0f28-6e14-9a0765e179c5@arm.com>
Date:   Tue, 17 Mar 2020 16:43:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <83aaf9e1-0a8f-4908-577a-23766541b2ba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/17/20 4:40 PM, Vincenzo Frascino wrote:
> Hi Catalin,
> 
> On 3/17/20 3:50 PM, Catalin Marinas wrote:
>> On Tue, Mar 17, 2020 at 03:04:01PM +0000, Vincenzo Frascino wrote:
>>> On 3/17/20 2:38 PM, Catalin Marinas wrote:
>>>> On Tue, Mar 17, 2020 at 12:22:12PM +0000, Vincenzo Frascino wrote:
> 
> [...]
> 
>>>
>>> Can TASK_SIZE > UINTPTR_MAX on an arm64 system?
>>
>> TASK_SIZE yes on arm64 but not TASK_SIZE_32. I was asking about the
>> arm32 check where TASK_SIZE < UINTPTR_MAX. How does the vdsotest return
>> -EFAULT on arm32? Which code path causes this in the user vdso code?
>>
> 
> Sorry I got confused because you referred to arch/arm/vdso/vgettimeofday.c which
> is the arm64 implementation, not the compat one :)
> 

I stand corrected arch/*arm*/vdso/vgettimeofday.c is definitely the arm32
implemetation... I got completely confused here :)

-- 
Regards,
Vincenzo
