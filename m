Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC7850DD3
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 16:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfFXOYB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 10:24:01 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35536 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfFXOYB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 10:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t1GdDqR3wzu6IU3N+1pA2QXIBdVreuMrAW41kvrOVKU=; b=m1LB7V6AcXMifsxW+zzSdfFLz
        KTyJtpZPdFWcZY9srh//kS/vI+ev1CokN6ZTc3z8RpR0sjJpMDhvhLYOL3JYgeqejAAXwNYSa2GYg
        DXohdbgewTD7fykXUUIwrfcG2LSJR3mWP9wd5KtNFfPcRlOQ1Oz41/rvIaxsqLKKTqMQiLO4Y3osN
        ypvmJ3KVYlUIyt1Kniowqgc3X/WJVQGky1WqO4SxyPnhINmWYxT02JlXMayVMXPbghes6xHq1Rq9t
        HW/5pyD6q2gqROzj/If6FiH2rII/ELe8D+6mPOmfDEatloIqSSi9aTzsE0Ff6uIUXNpcUFj/fG8Z6
        PftrVaNrw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:59042)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hfPsv-0000Ao-Bj; Mon, 24 Jun 2019 15:23:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hfPso-0006Mg-K2; Mon, 24 Jun 2019 15:23:46 +0100
Date:   Mon, 24 Jun 2019 15:23:46 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-arch@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andre Przywara <andre.przywara@arm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Collingbourne <pcc@google.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Andrei Vagin <avagin@openvz.org>,
        Huw Davies <huw@codeweavers.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Burton <paul.burton@mips.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
Message-ID: <20190624142346.pxljv3m4npatdiyk@shell.armlinux.org.uk>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906241613280.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906241613280.32342@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 24, 2019 at 04:18:28PM +0200, Thomas Gleixner wrote:
> Vincenzo,
> 
> On Mon, 24 Jun 2019, Thomas Gleixner wrote:
> 
> > I did not merge the ARM and MIPS parts as they lack any form of
> > acknowlegment from their maintainers. Please talk to those folks. If they
> > ack/review the changes then I can pick them up and they go into 5.3 or they
> > have to go in a later cycle. Nevertheless it was well worth the trouble to
> > have those conversions done to confirm that the new common library fits a
> > bunch of different architectures.
> 
> I talked to Russell King and he suggested to file the ARM parts into his
> patch system and he'll pick them up after 5.3-rc1.
> 
>    https://www.arm.linux.org.uk/developer/patches/
> 
> I paged out how to deal with it, but you'll surely manage :)

Easy way: ask git to add the "KernelVersion" tag as a header to the
email using --add-header to e.g. git format-patch, and just mail them
to patches@armlinux.org.uk

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
