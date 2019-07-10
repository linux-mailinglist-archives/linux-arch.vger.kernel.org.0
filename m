Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54ADE64A23
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2019 17:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfGJPyB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jul 2019 11:54:01 -0400
Received: from foss.arm.com ([217.140.110.172]:35812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfGJPyA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jul 2019 11:54:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB7602B;
        Wed, 10 Jul 2019 08:53:59 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 220293F246;
        Wed, 10 Jul 2019 08:53:57 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: vdso: Fix ABI regression in compat vdso
To:     John Stultz <john.stultz@linaro.org>
Cc:     linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Lutomirski <luto@kernel.org>
References: <20190621095252.32307-11-vincenzo.frascino@arm.com>
 <20190710140119.23417-1-vincenzo.frascino@arm.com>
 <CALAqxLVnf_hyxxmx72F360PbJUTZowuD3wJx0nJ=dCTyW+w-Tw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <7fc94d97-3cff-c983-ad63-e61f118e2936@arm.com>
Date:   Wed, 10 Jul 2019 16:53:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CALAqxLVnf_hyxxmx72F360PbJUTZowuD3wJx0nJ=dCTyW+w-Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi John,

On 10/07/2019 16:44, John Stultz wrote:
> On Wed, Jul 10, 2019 at 7:01 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> Prior to the introduction of Unified vDSO support and compat layer for
>> vDSO on arm64, AT_SYSINFO_EHDR was not defined for compat tasks.
>> In the current implementation, AT_SYSINFO_EHDR is defined even if the
>> compat vdso layer is not built and this causes a regression in the
>> expected behavior of the ABI.
>>
>> Restore the ABI behavior making sure that AT_SYSINFO_EHDR for compat
>> tasks is defined only when CONFIG_COMPAT_VDSO is enabled.
>>
>> Reported-by: John Stultz <john.stultz@linaro.org>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> This seems to solve it for me!
> Thanks so much for the quick turnaround on a fix. I really appreciate it!
> 
> Tested-by: John Stultz <john.stultz@linaro.org>
> 

Thank you for the quick reply, it means I can go home early today ;-)

> thanks
> -john
> 

-- 
Regards,
Vincenzo
