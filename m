Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA68C227A
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2019 15:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbfI3NxM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Sep 2019 09:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730378AbfI3NxM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Sep 2019 09:53:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FD282086A;
        Mon, 30 Sep 2019 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569851591;
        bh=Nhh2vGJB8S4qKF2pVJfJQWMF1IqgVIe1hzK5L13M6BI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayDenw/bCTAHtwhYp4fyI3E0oMsrHlnzfT9mfM6hSRzUHrL4BkakOVzMHBV97Knxc
         Zlaik0HKfae0TMciZIuhvL7AyGAZ7up6EAMKJ80pazwZceHlMJGjpsVBEOH5cNgU6f
         dC0uBOswbPP26FOOqAhJkQTYyOU5ppiTWyh0ZRX8=
Date:   Mon, 30 Sep 2019 14:53:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Jookia <166291@gmail.com>
Cc:     Xogium <contact@xogium.me>, linux-arch@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, bp@alien8.de,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [breakage] panic() does not halt arm64 systems under certain
 conditions
Message-ID: <20190930135306.p5r4sy2bbmq5zxgm@willie-the-truck>
References: <BX1W47JXPMR8.58IYW53H6M5N@dragonstone>
 <20190917104518.ovg6ivadyst7h76o@willie-the-truck>
 <20190920042501.GA5516@novena-choice-citizen-recovery.gateway>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920042501.GA5516@novena-choice-citizen-recovery.gateway>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 20, 2019 at 02:25:01PM +1000, Jookia wrote:
> On Tue, Sep 17, 2019 at 11:45:19AM +0100, Will Deacon wrote:
> > A straightforward fix is to disable preemption explicitly on the panic()
> > path (diff below), but I've expanded the cc list to see both what others
> > think, but also in case smp_send_stop() is supposed to have the side-effect
> > of disabling interrupt delivery for the local CPU.
> > 
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 057540b6eee9..02d0de31c42d 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -179,6 +179,7 @@ void panic(const char *fmt, ...)
> > 	 * after setting panic_cpu) from invoking panic() again.
> > 	 */
> > 	local_irq_disable();
> > +	preempt_disable_notrace();
> >  
> > 	/*
> > 	 * It's possible to come here directly from a panic-assertion and
> > 
> When you run with panic=... it will send you to a loop earlier in the
> panic code before local_irq_disable() is hit, working around the bug.
> A patch like this would make the behaviour the same:
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 4d9f55bf7d38..92abbb5f8d38 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -331,7 +331,6 @@ void panic(const char *fmt, ...)
> 
>         /* Do not scroll important messages printed above */
>         suppress_printk = 1;
> -       local_irq_enable();
>         for (i = 0; ; i += PANIC_TIMER_STEP) {
>                 touch_softlockup_watchdog();
>                 if (i >= i_next) {

The reason I kept irqs enabled is because I figured they might be useful
for magic sysrq keyboard interrupts (e.g. if you wanted to reboot the box).

With 'panic=', the reboot happens automatically, so there's no issue there
afaict.

Will
