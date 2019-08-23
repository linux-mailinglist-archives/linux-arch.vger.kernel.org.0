Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D193A9ADF4
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 13:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfHWLRY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 07:17:24 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58722 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfHWLRX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Aug 2019 07:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OSDjpRTuHovlIRScundJCWb6Oc+rd5ATE/Sxj9nPY/A=; b=Sf8X+LUWARix65xSRp4AVeykq
        hNuDbygxF+vUXOq+jc9C4kGTTsFToNveFnUx/iTHPshoyOGuOu/XH5gbL1HdzHRS5khqixXf/Spef
        uteSv3g2Qgn+FBCFrciYZByOrHH0WVtb4zV8rurR4n11NHvWff/+DgHKNIWhvQRifwQOhNesdVC+y
        CMeljOOhn7gTUttTboOcKrexXwlSaXLvj12LlNAldwDsURJHPQ6UZUzURGYai49Utjykgeu8PvlGk
        4u17ecHuZQfZhRlmwuWbWNNpx8pbAInQZLfoiLTGpEJKA88t6t5h1XnvteZPPup2+ldFchVQk5J0T
        STfvOBUFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60066)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i17ZF-0004Jh-0B; Fri, 23 Aug 2019 12:17:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i17ZB-0000CY-33; Fri, 23 Aug 2019 12:17:13 +0100
Date:   Fri, 23 Aug 2019 12:17:13 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Will Deacon <will@kernel.org>, tglx@linutronix.de
Cc:     Chris Clayton <chris2553@googlemail.com>,
        linux-arch@vger.kernel.org, vincenzo.frascino@arm.com,
        linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org,
        arnd@arndb.de, huw@codeweavers.com, andre.przywara@arm.com,
        daniel.lezcano@linaro.org, will.deacon@arm.com,
        LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org,
        salyzyn@android.com, paul.burton@mips.com,
        linux@rasmusvillemoes.dk, 0x7f454c46@gmail.com,
        catalin.marinas@arm.com, pcc@google.com, sthotton@marvell.com,
        shuah@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: Regression in 5.3-rc1 and later
Message-ID: <20190823111712.GB13294@shell.armlinux.org.uk>
References: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com>
 <20190823103654.GX13294@shell.armlinux.org.uk>
 <20190823104050.o6golaa4fmdd7np5@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823104050.o6golaa4fmdd7np5@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 23, 2019 at 11:40:50AM +0100, Will Deacon wrote:
> On Fri, Aug 23, 2019 at 11:36:54AM +0100, Russell King - ARM Linux admin wrote:
> > To everyone on the long Cc list...
> > 
> > What's happening with this?  I was about to merge the patches for 32-bit
> > ARM, which I don't want to do if doing so will cause this regression on
> > 32-bit ARM as well.
> 
> tglx fixed it:
> 
> https://lkml.kernel.org/r/alpine.DEB.2.21.1908221257580.1983@nanos.tec.linutronix.de
> 
> which I assume is getting routed as a fix via -tip.

Right, so Chris reported the issue to everyone involved.  Tglx's
reply severely trimmed the Cc list so folk like me had no idea what
was going on, removing even the mailing lists.  On the face of it,
it looks like an intentional attempt to cut people out of the loop
who really should've been kept in the loop.  Yea, that's just great.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
