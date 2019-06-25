Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B06C555B3
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfFYRRY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 13:17:24 -0400
Received: from foss.arm.com ([217.140.110.172]:45974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfFYRRY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 13:17:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E48D360;
        Tue, 25 Jun 2019 10:17:23 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB6273F718;
        Tue, 25 Jun 2019 10:17:19 -0700 (PDT)
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
To:     Paul Burton <paul.burton@mips.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
 <20190624184157.mu6n74a7qqa4z5z5@pburton-laptop>
 <3ae7f595-0a15-0584-198e-b32fe3e3ea57@arm.com>
 <20190625171118.wznk5nva3h3jetky@pburton-laptop>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <28ad9bf4-d639-f77c-8ac0-980f4f4595cd@arm.com>
Date:   Tue, 25 Jun 2019 18:17:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190625171118.wznk5nva3h3jetky@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

On 25/06/2019 18:11, Paul Burton wrote:
> Hi Vincenzo,
> 
> On Tue, Jun 25, 2019 at 12:16:55AM +0100, Vincenzo Frascino wrote:
>> In the end I concluded that all the errors seen here depend on the fact that I
>> tested my vdso implementation on MIPS32el only (as stated in the cover letter)
>> and that when I tried to compile a 32BIT binary on a 64BIT configuration I did
>> it wrongly for two reasons, for N32 and O32 binaries:
>>  - we need to undefine CONFIG_64BIT and define CONFIG_32BIT
>>  - we need to define CONFIG_GENERIC_ATOMIC64
>>
>> I have a fix for this (patch in attachment), but I do not have the hardware to
>> test it. If you could provide some feedback would be appreciated (really want to
>> see MIPS merged with the other archs in 5.3 :) ).
> 
> Thanks for the quick turnaround on your patch!
> 
> I'm certainly willing to test it, but in a few hours I'll be spending
> the bulk of a day on airplanes[1] so it might take a few days until I
> get to it.
> 

Sounds like a plan. Let us know when you have an update.

> Thanks,
>     Paul
> 
> [1] ...and travel isn't the hackathon it used to be with my 9 month old
>     son around :)
> 

-- 
Regards,
Vincenzo
