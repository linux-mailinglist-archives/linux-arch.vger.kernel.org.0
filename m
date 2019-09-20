Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E1FB8A23
	for <lists+linux-arch@lfdr.de>; Fri, 20 Sep 2019 06:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390002AbfITEZ1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Sep 2019 00:25:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36946 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389114AbfITEZ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Sep 2019 00:25:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id r4so5118849edy.4;
        Thu, 19 Sep 2019 21:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c5bLQ44DHFFsF9a/l+fvIthJAUI4IpWyFZ6HUIWlQ5g=;
        b=PE6/GJMxGendc9vmFm2rfrsD1RIU1p4ZoNxCgjg1+1T2bds+bx+vnQeV2BV8bB1Ezj
         sS6yqD6MhOkuRGs9TDgbrddAf4b3al3NSj/cEL2PyepIUPXfU2b8rZWTIOc3I6UxG9k3
         sfD1NsHwjuMO87J1TnlP9dcEOSiE/yFZULAJh2FulfylSaBCBIqKJediE7SLng72ppBR
         CgMFKUmaXFG0CHp5WO0YxYk+xp5RKbuW/gO4GnVQc70zKkheyQLR9b+ChZQGjYdzNtOO
         949dxMk+a+BRPrezoJOCm0oIXUJSHsGzLrt167Bnd6sphlSkhJPBDkTiojgaujym+fD3
         slWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c5bLQ44DHFFsF9a/l+fvIthJAUI4IpWyFZ6HUIWlQ5g=;
        b=Z3NRrbPO7ragRuEM2Iie795mIhVLnBMyFdeonB44/vivWDBZ/CswjH8ChSsduB2Jw0
         /mUx5RvcnJyg7Mtt/oSJ47Ok2w+ZC4H15hcFGhdMTPRXiDunLdkIHxwGs1/15AndR/L0
         Q9b/CSiSSl0XS1RYKyXRtY3ioJPQGIz9B1ruNrpjBzwtQjyZC4du9bTmfSYXVdmbfjJy
         iOS2DC2WMB4myn+cg6wJ4AIb87eHZqsWk5AT+6muj9GV4VMpP7kD6suQR0W6muR3vESD
         UroJ+OxOwKtQ14JIUp1gQ1drdnaTQYWmkQDGvG9MbjOuT4iqPKlXFmWHNf029rWJpLAc
         n4SQ==
X-Gm-Message-State: APjAAAUhoZSS3J1n+61vL9Ag7D8XY1WvRZxa3aG5bhPDMtlYdV+29kZP
        /6Lgudv3YtQQ/Nqoz7VanQ==
X-Google-Smtp-Source: APXvYqyDgdtkl74lEOF8tJe9DMwo1fx58ulo7VOciTOb+B6z43KJN8vrWu6lIVkGCqCBGzLCSCGWEw==
X-Received: by 2002:a17:907:20c4:: with SMTP id qq4mr17587171ejb.161.1568953525081;
        Thu, 19 Sep 2019 21:25:25 -0700 (PDT)
Received: from localhost (tor2.anonymizer.ccc.de. [217.115.10.132])
        by smtp.gmail.com with ESMTPSA id qx25sm92713ejb.61.2019.09.19.21.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 21:25:24 -0700 (PDT)
Date:   Fri, 20 Sep 2019 14:25:01 +1000
From:   Jookia <166291@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     Xogium <contact@xogium.me>, linux-arch@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, bp@alien8.de,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [breakage] panic() does not halt arm64 systems under certain
 conditions
Message-ID: <20190920042501.GA5516@novena-choice-citizen-recovery.gateway>
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
> think, but also in case smp_send_stop() is supposed to have the side-effect
> of disabling interrupt delivery for the local CPU.
> 
> Will
> 
> --->8
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 057540b6eee9..02d0de31c42d 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -179,6 +179,7 @@ void panic(const char *fmt, ...)
> 	 * after setting panic_cpu) from invoking panic() again.
> 	 */
> 	local_irq_disable();
> +	preempt_disable_notrace();
>  
> 	/*
> 	 * It's possible to come here directly from a panic-assertion and
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

When you run with panic=... it will send you to a loop earlier in the
panic code before local_irq_disable() is hit, working around the bug.
A patch like this would make the behaviour the same:

diff --git a/kernel/panic.c b/kernel/panic.c
index 4d9f55bf7d38..92abbb5f8d38 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -331,7 +331,6 @@ void panic(const char *fmt, ...)

        /* Do not scroll important messages printed above */
        suppress_printk = 1;
-       local_irq_enable();
        for (i = 0; ; i += PANIC_TIMER_STEP) {
                touch_softlockup_watchdog();
                if (i >= i_next) {
