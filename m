Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC98B4C2A
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2019 12:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfIQKpZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Sep 2019 06:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfIQKpY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Sep 2019 06:45:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9309521852;
        Tue, 17 Sep 2019 10:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568717124;
        bh=lRD33XVMU31YDKixMT8vCEatLaoLNEVQy4Wzf/bj7LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFxODCLVmBmUj01R26irYPN8YQuPyH1UaOrRml1WD7+1jCwimkkB1M6KsQFFUYhqi
         PRr2K9zMWyVz9E9koZIbr5XJPWVkIzDVPatCfKxXuyECrCN/Y2DUxWQvq1N6KBI1Zv
         /nWXbB5STf9OLjKm5R+/bGAn9MIO+UHk1+LmoYG8=
Date:   Tue, 17 Sep 2019 11:45:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Xogium <contact@xogium.me>
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, gregkh@linuxfoundation.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Subject: Re: [breakage] panic() does not halt arm64 systems under certain
 conditions
Message-ID: <20190917104518.ovg6ivadyst7h76o@willie-the-truck>
References: <BX1W47JXPMR8.58IYW53H6M5N@dragonstone>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BX1W47JXPMR8.58IYW53H6M5N@dragonstone>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

[Expanding CC list; original message is here:
 https://lore.kernel.org/linux-arm-kernel/BX1W47JXPMR8.58IYW53H6M5N@dragonstone/]

On Mon, Sep 16, 2019 at 09:35:36PM -0400, Xogium wrote:
> On arm64 in some situations userspace will continue running even after a
> panic. This means any userspace watchdog daemon will continue pinging,
> that service managers will keep running and displaying messages in certain
> cases, and that it is possible to enter via ssh in the now unstable system
> and to do almost anything except reboot/power off and etc. If
> CONFIG_PREEMPT=n is set in the kernel's configuration, the issue is fixed.
> I have reproduced the very same behavior with linux 4.19, 5.2 and 5.3. On
> x86/x86_64 the issue does not seem to be present at all.

I've managed to reproduce this under both 32-bit and 64-bit ARM kernels.
The issue is that the infinite loop at the end of panic() can run with
preemption enabled (particularly when invoking by echoing 'c' to
/proc/sysrq-trigger), so we end up rescheduling user tasks. On x86, this
doesn't happen because smp_send_stop() disables the local APIC in
native_stop_other_cpus() and so interrupts are effectively masked while
spinning.

A straightforward fix is to disable preemption explicitly on the panic()
path (diff below), but I've expanded the cc list to see both what others
think, but also in case smp_send_stop() is supposed to have the side-effect
of disabling interrupt delivery for the local CPU.

Will

--->8

diff --git a/kernel/panic.c b/kernel/panic.c
index 057540b6eee9..02d0de31c42d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -179,6 +179,7 @@ void panic(const char *fmt, ...)
	 * after setting panic_cpu) from invoking panic() again.
	 */
	local_irq_disable();
+	preempt_disable_notrace();
 
	/*
	 * It's possible to come here directly from a panic-assertion and
