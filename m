Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57409167EB1
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBUNeJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgBUNeJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 08:34:09 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C516222C4;
        Fri, 21 Feb 2020 13:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582292048;
        bh=ht0Kot+tQa78hnxsSn96tptAjd8/4mQfr9EaFTef3O8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oy+EN63iEddKvYOlWVbCEDGUr2gOmr1RRgvosDWa//pluv+N0vpSC2BeZ6Vr5vZNC
         AWfC9ciArKoDqC9TEsOOHkWceWCDvLl/zM2fEzhbZNucU+JGMgSN+oQv/SQz9cXmlE
         2zaGtXIAqR2TxCbNn8ILo7L8NUXKC5iNQAi95uFk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j58RS-0072qM-TP; Fri, 21 Feb 2020 13:34:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 21 Feb 2020 13:34:06 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux@armlinux.org.uk, luto@kernel.org,
        tglx@linutronix.de, m.szyprowski@samsung.com, mark.rutland@arm.com
Subject: Re: [PATCH] clocksource: Fix arm_arch_timer clockmode when vDSO
 disabled
In-Reply-To: <20200221130355.21373-1-vincenzo.frascino@arm.com>
References: <20200221130355.21373-1-vincenzo.frascino@arm.com>
Message-ID: <a81251e813d54caddd56b9aac4b55e85@kernel.org>
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

Vincenzo,

Please include Mark and myself for anything that touches the arch timers
(get_maintainer.pl will tell you who you need to cc).

On 2020-02-21 13:03, Vincenzo Frascino wrote:
> The arm_arch_timer requires that VDSO_CLOCKMODE_ARCHTIMER to be
> defined to compile correctly. On arm the vDSO can be disabled and when
> this is the case the compilation ends prematurely with an error:
> 
>  $ make ARCH=arm multi_v7_defconfig
>  $ ./scripts/config -d VDSO
>  $ make
> 
> drivers/clocksource/arm_arch_timer.c:73:44: error:
> ‘VDSO_CLOCKMODE_ARCHTIMER’ undeclared here (not in a function)
>   static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
>                                              ^
> scripts/Makefile.build:267: recipe for target
> 'drivers/clocksource/arm_arch_timer.o' failed
> make[2]: *** [drivers/clocksource/arm_arch_timer.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> scripts/Makefile.build:505: recipe for target 'drivers/clocksource' 
> failed
> make[1]: *** [drivers/clocksource] Error 2
> make[1]: *** Waiting for unfinished jobs....
> Makefile:1683: recipe for target 'drivers' failed
> make: *** [drivers] Error 2
> 
> Define VDSO_CLOCKMODE_ARCHTIMER as VDSO_CLOCKMODE_NONE when the vDSOs 
> are
> not enabled to address the issue.
> 
> Fixes: 5e3c6a312a09 ("ARM/arm64: vdso: Use common vdso clock mode 
> storage")
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  drivers/clocksource/arm_arch_timer.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c
> b/drivers/clocksource/arm_arch_timer.c
> index ee2420d56f67..619839221f94 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -49,6 +49,11 @@
>  #define CNTV_TVAL	0x38
>  #define CNTV_CTL	0x3c
> 
> +#ifndef CONFIG_GENERIC_GETTIMEOFDAY
> +/* The define below is required because on arm the VDSOs can be 
> disabled */
> +#define VDSO_CLOCKMODE_ARCHTIMER	VDSO_CLOCKMODE_NONE
> +#endif /* CONFIG_GENERIC_GETTIMEOFDAY */

This feels pretty clunky.

I'd extect VDSO_ARCH_CLOCKMODES (or some similar architecture-specific
symbol) to be used for vdso_default, and that symbol to be defined as
VDSO_CLOCKMODE_NONE when CONFIG_GENERIC_GETTIMEOFDAY isn't selected.

Otherwise, you'll end-up replicating the same pattern in every
clock-source that gets used by the VDSO.

         M.
-- 
Jazz is not dead. It just smells funny...
