Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147CD9D70E
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2019 21:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbfHZT6H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 15:58:07 -0400
Received: from foss.arm.com ([217.140.110.172]:34736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733174AbfHZT6G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Aug 2019 15:58:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A042337;
        Mon, 26 Aug 2019 12:58:05 -0700 (PDT)
Received: from [10.37.9.91] (unknown [10.37.9.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38E2D3F246;
        Mon, 26 Aug 2019 12:58:03 -0700 (PDT)
Subject: Re: [RFC PATCH 5/7] arm64: smp: use generic SMP stop common code
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        catalin.marinas@arm.com, takahiro.akashi@linaro.org,
        james.morse@arm.com, hidehiro.kawai.ez@hitachi.com,
        tglx@linutronix.de, will@kernel.org, dave.martin@arm.com,
        linux-arm-kernel@lists.infradead.org
References: <20190823115720.605-1-cristian.marussi@arm.com>
 <20190823115720.605-6-cristian.marussi@arm.com>
 <20190826153236.GA9591@infradead.org>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <c6a86709-6faf-bf84-08aa-c41dab61c58f@arm.com>
Date:   Mon, 26 Aug 2019 20:58:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826153236.GA9591@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi

On 8/26/19 4:32 PM, Christoph Hellwig wrote:
>> +config ARCH_USE_COMMON_SMP_STOP
>> +	def_bool y if SMP
> 
> The option belongs into common code and the arch code shoud only
> select it.
>

In fact that was my first approach, but then I noticed that in kernel/ topdir
there was no generic Kconfig but only subsystem specific ones:

Kconfig.freezer  Kconfig.hz       Kconfig.locks    Kconfig.preempt

while instead looking into archs top level Kconfig, beside the usual arch/Kconfig selects,
I could find this similar sort of "reversed" approach in which the arch defined and
selected a CONFIG which was indeed then used only in common code like in:

20:37 $ egrep -R ARCH_HAS_CACHE_LINE_SIZE .
./arch/arc/Kconfig:config ARCH_HAS_CACHE_LINE_SIZE
./arch/x86/Kconfig:config ARCH_HAS_CACHE_LINE_SIZE
./arch/arm64/Kconfig:config ARCH_HAS_CACHE_LINE_SIZE
./include/linux/cache.h:#ifndef CONFIG_ARCH_HAS_CACHE_LINE_SIZE

20:39 $ egrep -R ARCH_HAS_KEXEC_PURGATORY .
./arch/powerpc/Kconfig:config ARCH_HAS_KEXEC_PURGATORY
./arch/x86/Kconfig:config ARCH_HAS_KEXEC_PURGATORY
./arch/s390/Kconfig:config ARCH_HAS_KEXEC_PURGATORY
./arch/s390/purgatory/Makefile:obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += kexec-purgatory.o
./arch/s390/Kbuild:obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += purgatory/
./kernel/kexec_file.c:	if (!IS_ENABLED(CONFIG_ARCH_HAS_KEXEC_PURGATORY))

so I thought it was an acceptable option and I went for it, not to introduce a new kernel/Kconfig.smp
just for this new config option; but in fact I could have missed the real reason underlying these two
different choices.

Thanks

Cristian
