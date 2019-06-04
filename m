Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B9D34648
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2019 14:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfFDMKg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jun 2019 08:10:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41634 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfFDMKg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jun 2019 08:10:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D48EF80D;
        Tue,  4 Jun 2019 05:10:35 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB3B43F690;
        Tue,  4 Jun 2019 05:10:32 -0700 (PDT)
Subject: Re: [PATCH v6 15/19] arm64: Add vDSO compat support
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-16-vincenzo.frascino@arm.com>
 <20190601093830.GA13589@arrakis.emea.arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <2027e092-2d76-9350-6c5b-7d3debc6a93f@arm.com>
Date:   Tue, 4 Jun 2019 13:10:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190601093830.GA13589@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Catalin,

thank you for testing my patches and providing the scripts you used to reproduce
the issue.

On 01/06/2019 10:38, Catalin Marinas wrote:
> On Thu, May 30, 2019 at 03:15:27PM +0100, Vincenzo Frascino wrote:
>> Add vDSO compat support to the arm64 building system.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/Kconfig         |  1 +
>>  arch/arm64/Makefile        | 23 +++++++++++++++++++++--
>>  arch/arm64/kernel/Makefile |  6 +++++-
>>  3 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 952c9f8cf3b8..3e1d4f8347f4 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -108,6 +108,7 @@ config ARM64
>>  	select GENERIC_STRNLEN_USER
>>  	select GENERIC_TIME_VSYSCALL
>>  	select GENERIC_GETTIMEOFDAY
>> +	select GENERIC_COMPAT_VDSO if !CPU_BIG_ENDIAN
> 
> This select needs to also depend on COMPAT (or rather be selected from
> the COMPAT menuconfig), otherwise, trying to build this series with 64K
> pages where COMPAT is disabled, I get:
> 

This is a very good catch, my bad, will definitely fix in v7.

...

-- 
Regards,
Vincenzo
