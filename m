Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C7126F72F
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 09:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgIRHmI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 03:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgIRHmI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 03:42:08 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FEBC06174A;
        Fri, 18 Sep 2020 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ew17vDuZPSlSjcmFdTTXihsIsUVYPRVr+Bu5mG1RN78=; b=uBFyBBgcW0QETnetcGA9Xaumm
        zyiZ8lH8bD8O3vgyciGLv13LS44b3OsymTaEVIWdFXS8h7J5PvXfXjl2t3RzxH2y5KIozGqZml2bH
        8mAKHqn1xaeJVwDu3eXYzq2Q677i0HLH3hTTyPQed01mMqsLf/Db2g8gDJk7tTgDX+gwYk8xJAsm4
        Y08NKL8WPrFElyWXw4ZSHEA3lQsTU42hNKqYSHJRwm1FOOdqTPE/z+7BvhNeGHSDwqNwIBdnETle/
        MP+KOkGBdIVVxY3+7EbCZhqWxdAUZdgS6q73eKMfFVpcWJjGveyWCWvttH6V5AS4KR/gyEosEc1JD
        kasjReAPg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35122)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kJB1x-0006k0-FO; Fri, 18 Sep 2020 08:42:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kJB1v-0006a6-OE; Fri, 18 Sep 2020 08:42:03 +0100
Date:   Fri, 18 Sep 2020 08:42:03 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux- <kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/9] ARM: traps: use get_kernel_nofault instead of
 set_fs()
Message-ID: <20200918074203.GU1551@shell.armlinux.org.uk>
References: <20200907153701.2981205-1-arnd@arndb.de>
 <20200907153701.2981205-3-arnd@arndb.de>
 <20200908061528.GB13930@lst.de>
 <CAK8P3a22EiD-uMZQaBpHQYyy=MJ_7J-ih=6CtgH_9RXT6OOYvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a22EiD-uMZQaBpHQYyy=MJ_7J-ih=6CtgH_9RXT6OOYvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 17, 2020 at 07:29:37PM +0200, Arnd Bergmann wrote:
> On Tue, Sep 8, 2020 at 8:15 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > > +static void dump_mem(const char *, const char *, unsigned long, unsigned long, bool kernel_mode);
> >
> > This adds a pointlessly long line.
> 
> Fixed.
> 
> > And looking at the code I don't see why the argument is even needed.
> >
> > dump_mem() currently does an unconditional set_fs(KERNEL_DS), so it
> > should always use get_kernel_nofault.
> 
> I had looked at
> 
>         if (!user_mode(regs) || in_interrupt()) {
>                 dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
>                          THREAD_SIZE + (unsigned
> long)task_stack_page(tsk), kernel_mode);
> 
> which told me that there should be at least some code path ending up in
> __die() that has in_interrupt() set but comes from user mode.
> 
> In this case, the memory to print would be a user pointer and cannot be
> accessed by get_kernel_nofault() (but could be accessed with
> "set_fs(KERNEL_DS); __get_user()").
> 
> I looked through the history now and the only code path I could
> find that would arrive here this way is from bad_mode(), indicating
> that there is probably a hardware bug or the contents of *regs are
> corrupted.

Yes, that's correct.  It isn't something entirely theoretical, although
we never see it now, it used to happen in the distant past due to saved
regs corruption.  If bad_mode() ever gets called, all bets are off and
we're irrecoverably crashing.

Note that in that case, while user_mode(regs) may return true or false,
regs->ARM_sp and regs->ARM_lr are always the SVC mode stack and return
address after regs has been stacked, and not the expected values for
the parent context (which we have most likely long since destroyed.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
