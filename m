Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2248EB4C40
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2019 12:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbfIQKvy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Sep 2019 06:51:54 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39420 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIQKvy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Sep 2019 06:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YvBhNTx9acndDsH+SN+5uYkrouhq19vxVn9ISJJsZvE=; b=rmnd/YbRkfOrFxA1/PCntNm3m
        iG3wU4V0P4NNzEjO9Rj+C/Uoth/6B1fMJlKQB5ADmS/z9gCQ5dgRACubiuf/l10k+RXwwwh+O7k8p
        7Br4j7yQ+jYlDz9cGH4tJtfTqiQXcWRtb/lwtNF1tP7cRmJmxLJbaXCnHn9rJrMK3iMH7wsoen2HF
        zfZw5Xtsiis70nnxfVAE/f++KNt/684ccfSPHigxz6JF/VOB1u8t5SwfiVP/44hfgkWF18x0v4YB1
        /zZ1lUVD8eB39DLKjfD++TrzHTWRZmPBdlFjAtwbozewRIxO1/YoVCYVQS55ZKSp4fDVxkz9IZ/6E
        I7x7lGCIQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:40590)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iAB5A-0001DH-4U; Tue, 17 Sep 2019 11:51:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iAB56-0001Dc-Do; Tue, 17 Sep 2019 11:51:36 +0100
Date:   Tue, 17 Sep 2019 11:51:36 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Will Deacon <will@kernel.org>
Cc:     Xogium <contact@xogium.me>, linux-arm-kernel@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        gregkh@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [breakage] panic() does not halt arm64 systems under certain
 conditions
Message-ID: <20190917105136.GK25745@shell.armlinux.org.uk>
References: <BX1W47JXPMR8.58IYW53H6M5N@dragonstone>
 <20190917104518.ovg6ivadyst7h76o@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917104518.ovg6ivadyst7h76o@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 17, 2019 at 11:45:19AM +0100, Will Deacon wrote:
> Hi,
> 
> [Expanding CC list; original message is here:
>  https://lore.kernel.org/linux-arm-kernel/BX1W47JXPMR8.58IYW53H6M5N@dragonstone/]
> 
> On Mon, Sep 16, 2019 at 09:35:36PM -0400, Xogium wrote:
> > On arm64 in some situations userspace will continue running even after a
> > panic. This means any userspace watchdog daemon will continue pinging,
> > that service managers will keep running and displaying messages in certain
> > cases, and that it is possible to enter via ssh in the now unstable system
> > and to do almost anything except reboot/power off and etc. If
> > CONFIG_PREEMPT=n is set in the kernel's configuration, the issue is fixed.
> > I have reproduced the very same behavior with linux 4.19, 5.2 and 5.3. On
> > x86/x86_64 the issue does not seem to be present at all.
> 
> I've managed to reproduce this under both 32-bit and 64-bit ARM kernels.
> The issue is that the infinite loop at the end of panic() can run with
> preemption enabled (particularly when invoking by echoing 'c' to
> /proc/sysrq-trigger), so we end up rescheduling user tasks. On x86, this
> doesn't happen because smp_send_stop() disables the local APIC in
> native_stop_other_cpus() and so interrupts are effectively masked while
> spinning.
> 
> A straightforward fix is to disable preemption explicitly on the panic()
> path (diff below), but I've expanded the cc list to see both what others
> think,

Yep, and it looks like this bug goes back into the dim and distant past.
At least to the start of modern git history, 2.6.12-rc2.

> but also in case smp_send_stop() is supposed to have the side-effect
> of disabling interrupt delivery for the local CPU.

That can't fix it.  Consider a preemptive non-SMP kernel.
smp_send_stop() becomes a no-op there.

I'd suggest that a preemptive UP kernel on x86 hardware will suffer
this same issue - it will be able to preempt out of this loop and
continue running userspace.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
