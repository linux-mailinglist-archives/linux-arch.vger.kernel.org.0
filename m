Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31200168194
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 16:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgBUP3A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 10:29:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgBUP3A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 10:29:00 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 928972073A;
        Fri, 21 Feb 2020 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582298938;
        bh=sovFRNSWr9oiXk1/2FyZ6Ia9xsa9PpAS7U371jfo0L4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TBPNo5akJ/ZZeY2M0r1tgB0W3Lk5xckDMpCnjXBYoQinyW97IllFPWYOQb1hLPc1P
         Z8vSy1+dMN9Ye0CfXAT+QrdjioQAYbm8CBiUDYZZ1sqxqwZMwfa3B7qjSrcGQ0VK7Q
         uFXb4rJMVsR1FJzIglLUgeT8v5kaUcuSgj0Onv0M=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j5AEa-0074Aq-Sa; Fri, 21 Feb 2020 15:28:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Feb 2020 15:28:56 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux@armlinux.org.uk, luto@kernel.org,
        tglx@linutronix.de, m.szyprowski@samsung.com, mark.rutland@arm.com
Subject: Re: [PATCH] clocksource: Fix arm_arch_timer clockmode when vDSO
 disabled
In-Reply-To: <c438aa7e-2c96-8c11-bb87-204929a01a20@arm.com>
References: <20200221130355.21373-1-vincenzo.frascino@arm.com>
 <a81251e813d54caddd56b9aac4b55e85@kernel.org>
 <c438aa7e-2c96-8c11-bb87-204929a01a20@arm.com>
Message-ID: <6df28d31cf6d4dd6109415fbd73a9c48@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: vincenzo.frascino@arm.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, linux@armlinux.org.uk, luto@kernel.org, tglx@linutronix.de, m.szyprowski@samsung.com, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-02-21 14:48, Vincenzo Frascino wrote:
> Hi Marc,
> 
> On 21/02/2020 13:34, Marc Zyngier wrote:
>> Vincenzo,
>> 
>> Please include Mark and myself for anything that touches the arch 
>> timers
>> (get_maintainer.pl will tell you who you need to cc).
>> 
> 
> Sorry about that, I posted it too quickly without the proper Cc on the 
> patch.
> 
>> On 2020-02-21 13:03, Vincenzo Frascino wrote:
> 
> [...]
> 
>> 
>> This feels pretty clunky.
>> 
>> I'd extect VDSO_ARCH_CLOCKMODES (or some similar architecture-specific
>> symbol) to be used for vdso_default, and that symbol to be defined as
>> VDSO_CLOCKMODE_NONE when CONFIG_GENERIC_GETTIMEOFDAY isn't selected.
>> 
> 
> My understanding is that currently VDSO_ARCH_CLOCKMODES depending on 
> the
> architecture can identify one or more clocks. In the case of arm and 
> the
> arm_arch_timer the arch specific symbol is VDSO_CLOCKMODE_ARCHTIMER 
> (used for
> vdso_default), which as you are correctly stating has to be defined as
> VDSO_CLOCKMODE_NONE when CONFIG_GENERIC_GETTIMEOFDAY isn't selected.

This isn't what I'm saying. What I'm suggesting here is that there is
possibly a missing indirection, which defaults to ARCH_TIMER when the
VDSO is selected, and NONE when it isn't.

Overloading a known symbol feels like papering over the issue.

Ideally, this default symbol would be provided by asm/clocksource.h, but
that may not even be the right thing to do.

>> Otherwise, you'll end-up replicating the same pattern in every
>> clock-source that gets used by the VDSO.
> 
> Based on my investigation this fix should be replicated for all the 
> clocksources
> used by architectures supported by Unified VDSO and of which VDSOs can 
> be
> disabled (otherwise the current solution works). After a quick grep on 
> the
> kernel tree:
> 
>  $ grep -nr "config VDSO" *
> 
> arch/arm/mm/Kconfig:895:config VDSO
> 
> Since the only clocksource that falls into these conditions seems to be
> arm_arch_timer I modified its driver.

Fair enough. But don't override the symbol locally. Create a new one:

diff --git a/drivers/clocksource/arm_arch_timer.c 
b/drivers/clocksource/arm_arch_timer.c
index ee2420d56f67..7eb3db75211d 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -69,7 +69,12 @@ static enum arch_timer_ppi_nr arch_timer_uses_ppi = 
ARCH_TIMER_VIRT_PPI;
  static bool arch_timer_c3stop;
  static bool arch_timer_mem_use_virtual;
  static bool arch_counter_suspend_stop;
-static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
+#define __VDSO_DEFAULT VDSO_CLOCKMODE_ARCHTIMER
+#else
+#define __VDSO_DEFAULT VDSO_CLOCKMODE_NONE
+#endif
+static enum vdso_clock_mode vdso_default = __VDSO_DEFAULT;

  static cpumask_t evtstrm_available = CPU_MASK_NONE;
  static bool evtstrm_enable = 
IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);

Or even this (no, I'm not suggesting this seriously):

diff --git a/drivers/clocksource/arm_arch_timer.c 
b/drivers/clocksource/arm_arch_timer.c
index ee2420d56f67..836b500d1bf1 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -69,7 +69,7 @@ static enum arch_timer_ppi_nr arch_timer_uses_ppi = 
ARCH_TIMER_VIRT_PPI;
  static bool arch_timer_c3stop;
  static bool arch_timer_mem_use_virtual;
  static bool arch_counter_suspend_stop;
-static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
+static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_MAX - 1;

  static cpumask_t evtstrm_available = CPU_MASK_NONE;
  static bool evtstrm_enable = 
IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);

         M.
-- 
Jazz is not dead. It just smells funny...
