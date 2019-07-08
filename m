Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E91261F50
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2019 15:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbfGHNJO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Jul 2019 09:09:14 -0400
Received: from foss.arm.com ([217.140.110.172]:47580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731110AbfGHNJN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Jul 2019 09:09:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA27B2B;
        Mon,  8 Jul 2019 06:09:12 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C89363F738;
        Mon,  8 Jul 2019 06:09:08 -0700 (PDT)
Subject: Re: [PATCH v7 04/25] arm64: Substitute gettimeofday with C
 implementation
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huw Davies <huw@codeweavers.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Burton <paul.burton@mips.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shijith Thotton <sthotton@marvell.com>,
        Peter Collingbourne <pcc@google.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-5-vincenzo.frascino@arm.com>
 <CGME20190628130921eucas1p239935b0771032c331911eacc1a69dd2e@eucas1p2.samsung.com>
 <1fd47b0d-f77f-8d07-c039-6ac9072834fc@samsung.com>
 <27386d82-2906-b541-f71d-3c61f5099bdf@arm.com>
 <530cd07e-0da7-1d83-be4e-b14813029424@samsung.com>
 <06c264a8-8778-18b1-1094-4281a4a2abc9@arm.com>
 <ed758c10-7260-bec3-caf1-08cae7e0968d@samsung.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b10b6723-6d5f-e667-b626-f13f5a5c3400@arm.com>
Date:   Mon, 8 Jul 2019 14:09:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ed758c10-7260-bec3-caf1-08cae7e0968d@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Sylwester,

On 08/07/2019 13:57, Sylwester Nawrocki wrote:
> Hi Vincenzo, 
> 
> On 6/29/19 08:58, Vincenzo Frascino wrote:
>> If I may, I would like to ask to you one favor, could you please keep an eye on
>> next and once those patches are merged repeat the test?
>>
>> I want just to make sure that the regression does not reappear.
> 
> My apologies, I forgot about this for a moment. I repeated the test with 
> next-20190705 tag and couldn't see any regressions.
> 

No problem and thank you for the confirmation.

-- 
Regards,
Vincenzo
