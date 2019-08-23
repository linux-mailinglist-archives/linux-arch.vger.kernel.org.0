Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07DF9AF68
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 14:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbfHWM1f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 08:27:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35317 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfHWM1f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Aug 2019 08:27:35 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i18f9-00020a-7l; Fri, 23 Aug 2019 14:27:27 +0200
Date:   Fri, 23 Aug 2019 14:27:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chris Clayton <chris2553@googlemail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        shuah@kernel.org, sthotton@marvell.com, andre.przywara@arm.com,
        arnd@arndb.de, salyzyn@android.com, huw@codeweavers.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        will.deacon@arm.com, linux-mips@vger.kernel.org,
        ralf@linux-mips.org, 0x7f454c46@gmail.com, paul.burton@mips.com,
        linux-kselftest@vger.kernel.org, linux@rasmusvillemoes.dk,
        pcc@google.com, linux-arm-kernel@lists.infradead.org
Subject: Re: Regression in 5.3-rc1 and later
In-Reply-To: <20190823105121.GA13294@shell.armlinux.org.uk>
Message-ID: <alpine.DEB.2.21.1908231426080.1896@nanos.tec.linutronix.de>
References: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com> <20190823103654.GX13294@shell.armlinux.org.uk> <8ab59d01-348e-9ac1-2944-5e98acd9b1f8@arm.com> <20190823105121.GA13294@shell.armlinux.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 23 Aug 2019, Russell King - ARM Linux admin wrote:

> On Fri, Aug 23, 2019 at 11:43:32AM +0100, Vincenzo Frascino wrote:
> > Hi Russell,
> > 
> > On 8/23/19 11:36 AM, Russell King - ARM Linux admin wrote:
> > > Hi,
> > > 
> > > To everyone on the long Cc list...
> > > 
> > > What's happening with this?  I was about to merge the patches for 32-bit
> > > ARM, which I don't want to do if doing so will cause this regression on
> > > 32-bit ARM as well.
> > > 
> > 
> > The regression is sorted as of yesterday, a new patch is going through tip:
> > timers/urgent and will be part of the next -rc.
> > 
> > If you want to merge them there should be nothing blocking.
> 
> I don't have access to the tip tree.

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
 
> I'll wait a kernel release cycle instead.

It's going to be part of -rc6. I'll send the pull request to Linus tomorrow.

Thanks,

	tglx
