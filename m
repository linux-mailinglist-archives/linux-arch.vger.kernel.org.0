Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F2051844
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 18:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbfFXQUa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 12:20:30 -0400
Received: from foss.arm.com ([217.140.110.172]:54258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfFXQUa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 12:20:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03E392B;
        Mon, 24 Jun 2019 09:20:29 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFDC83F71E;
        Mon, 24 Jun 2019 09:20:25 -0700 (PDT)
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Will Deacon <will.deacon@arm.com>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-arch@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andre Przywara <andre.przywara@arm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Collingbourne <pcc@google.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Andrei Vagin <avagin@openvz.org>,
        Huw Davies <huw@codeweavers.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Burton <paul.burton@mips.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906241613280.32342@nanos.tec.linutronix.de>
 <20190624142346.pxljv3m4npatdiyk@shell.armlinux.org.uk>
 <20190624144924.GE29120@arrakis.emea.arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <f631ecc1-662c-f652-324f-955ee3be23b0@arm.com>
Date:   Mon, 24 Jun 2019 17:20:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624144924.GE29120@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 24/06/2019 15:49, Catalin Marinas wrote:
> On Mon, Jun 24, 2019 at 03:23:46PM +0100, Russell King wrote:
>> On Mon, Jun 24, 2019 at 04:18:28PM +0200, Thomas Gleixner wrote:
>>> Vincenzo,
>>>
>>> On Mon, 24 Jun 2019, Thomas Gleixner wrote:
>>>
>>>> I did not merge the ARM and MIPS parts as they lack any form of
>>>> acknowlegment from their maintainers. Please talk to those folks. If they
>>>> ack/review the changes then I can pick them up and they go into 5.3 or they
>>>> have to go in a later cycle. Nevertheless it was well worth the trouble to
>>>> have those conversions done to confirm that the new common library fits a
>>>> bunch of different architectures.
>>>
>>> I talked to Russell King and he suggested to file the ARM parts into his
>>> patch system and he'll pick them up after 5.3-rc1.
>>>
>>>    https://www.arm.linux.org.uk/developer/patches/
>>>
>>> I paged out how to deal with it, but you'll surely manage :)
>>
>> Easy way: ask git to add the "KernelVersion" tag as a header to the
>> email using --add-header to e.g. git format-patch, and just mail them
>> to patches@armlinux.org.uk
> 
> Although I haven't send patches to Russell in a while, I still have a
> git alias in my .gitconfig (only works with one patch at a time IIRC,
> sending multiple patches may arrive in a different order):
> 
> [alias]
> 	send-rmk-email = !git send-email --add-header=\"KernelVersion: $(git describe --abbrev=0)\" --no-thread --suppress-cc=all --to="patches@arm.linux.org.uk"
> 

Thanks to all for the hints and the support. I will send the patches to Russel
as agreed.

-- 
Regards,
Vincenzo
