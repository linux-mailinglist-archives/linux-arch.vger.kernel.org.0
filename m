Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB117B4C7F
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2019 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfIQLFI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Sep 2019 07:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfIQLFH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Sep 2019 07:05:07 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57BEE21670;
        Tue, 17 Sep 2019 11:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568718307;
        bh=YBiYlpMCxYMuHq/R/A6MyZ56tJz7oTvUkA/g5FHifvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/t6x4MZVclF1qc13dvlETRk8rWsKca3PT9MWMby9Jn7u+15NTu1q9q7f/MwSIit7
         ouZnRgiVBK+hHYBBGj9VjQdec897yJQrj9naMmV4nVgelj2WzlrCjTTxfCk4n0uPiM
         iiMU9DqD4YBW0YoBU/9liW7c59tGV8wluGfPwnDo=
Date:   Tue, 17 Sep 2019 12:05:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Xogium <contact@xogium.me>, linux-arm-kernel@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        gregkh@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [breakage] panic() does not halt arm64 systems under certain
 conditions
Message-ID: <20190917110501.jquezxppeg35i7ce@willie-the-truck>
References: <BX1W47JXPMR8.58IYW53H6M5N@dragonstone>
 <20190917104518.ovg6ivadyst7h76o@willie-the-truck>
 <20190917105136.GK25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917105136.GK25745@shell.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 17, 2019 at 11:51:36AM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Sep 17, 2019 at 11:45:19AM +0100, Will Deacon wrote:
> > [Expanding CC list; original message is here:
> >  https://lore.kernel.org/linux-arm-kernel/BX1W47JXPMR8.58IYW53H6M5N@dragonstone/]
> > 
> > On Mon, Sep 16, 2019 at 09:35:36PM -0400, Xogium wrote:
> > > On arm64 in some situations userspace will continue running even after a
> > > panic. This means any userspace watchdog daemon will continue pinging,
> > > that service managers will keep running and displaying messages in certain
> > > cases, and that it is possible to enter via ssh in the now unstable system
> > > and to do almost anything except reboot/power off and etc. If
> > > CONFIG_PREEMPT=n is set in the kernel's configuration, the issue is fixed.
> > > I have reproduced the very same behavior with linux 4.19, 5.2 and 5.3. On
> > > x86/x86_64 the issue does not seem to be present at all.
> > 
> > I've managed to reproduce this under both 32-bit and 64-bit ARM kernels.
> > The issue is that the infinite loop at the end of panic() can run with
> > preemption enabled (particularly when invoking by echoing 'c' to
> > /proc/sysrq-trigger), so we end up rescheduling user tasks. On x86, this
> > doesn't happen because smp_send_stop() disables the local APIC in
> > native_stop_other_cpus() and so interrupts are effectively masked while
> > spinning.
> > 
> > A straightforward fix is to disable preemption explicitly on the panic()
> > path (diff below), but I've expanded the cc list to see both what others
> > think,
> 
> Yep, and it looks like this bug goes back into the dim and distant past.
> At least to the start of modern git history, 2.6.12-rc2.
> 
> > but also in case smp_send_stop() is supposed to have the side-effect
> > of disabling interrupt delivery for the local CPU.
> 
> That can't fix it.  Consider a preemptive non-SMP kernel.
> smp_send_stop() becomes a no-op there.
> 
> I'd suggest that a preemptive UP kernel on x86 hardware will suffer
> this same issue - it will be able to preempt out of this loop and
> continue running userspace.

You're right; I managed to reproduce this locally on my xeon box.

Will
