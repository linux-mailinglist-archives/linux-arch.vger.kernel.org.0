Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553A09ADA6
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 12:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390514AbfHWKvb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 06:51:31 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58378 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbfHWKvb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Aug 2019 06:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rV5X87m2aVqvDyTVi9a6HowY/GyHB5VKLCi2GkCc/3U=; b=tjNEkBlgX2N/B2l3X1g+NoyZu
        hkDt1Rsb7Keu46ouFXQi0jsTqHid4G7fyRp9JKvYVfF+aju3zu8YQaanWmYCiJhvsOfxd3sH7cC+h
        CvA5LXEj48rUIGz4//lebn/Vo+t+VkDgABlo8k3RhsQWMoLDOONu70LBIVdvfs1dYndKU/HAgUL2h
        gyiw8vJrzM379DK9x5bn4LBm4s8yLXVwN9UEiXnsJpnkW5IbXFsiURr1yLpIUUq3BsRMO+5zhce8z
        NLB8G1celxCrEH7vlQvrlpIL+11RcifC6WexTVKhYn9AzduRMeAAmYU/KcF2IlMVgdVTlAzUkT4Uz
        a1kQkmc3g==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:48402)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i17AD-0004Be-I5; Fri, 23 Aug 2019 11:51:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i17A9-0000BF-9q; Fri, 23 Aug 2019 11:51:21 +0100
Date:   Fri, 23 Aug 2019 11:51:21 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Chris Clayton <chris2553@googlemail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        shuah@kernel.org, sthotton@marvell.com, andre.przywara@arm.com,
        arnd@arndb.de, salyzyn@android.com, huw@codeweavers.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        will.deacon@arm.com, linux-mips@vger.kernel.org,
        ralf@linux-mips.org, 0x7f454c46@gmail.com, paul.burton@mips.com,
        linux-kselftest@vger.kernel.org, linux@rasmusvillemoes.dk,
        tglx@linutronix.de, pcc@google.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Regression in 5.3-rc1 and later
Message-ID: <20190823105121.GA13294@shell.armlinux.org.uk>
References: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com>
 <20190823103654.GX13294@shell.armlinux.org.uk>
 <8ab59d01-348e-9ac1-2944-5e98acd9b1f8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ab59d01-348e-9ac1-2944-5e98acd9b1f8@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 23, 2019 at 11:43:32AM +0100, Vincenzo Frascino wrote:
> Hi Russell,
> 
> On 8/23/19 11:36 AM, Russell King - ARM Linux admin wrote:
> > Hi,
> > 
> > To everyone on the long Cc list...
> > 
> > What's happening with this?  I was about to merge the patches for 32-bit
> > ARM, which I don't want to do if doing so will cause this regression on
> > 32-bit ARM as well.
> > 
> 
> The regression is sorted as of yesterday, a new patch is going through tip:
> timers/urgent and will be part of the next -rc.
> 
> If you want to merge them there should be nothing blocking.

I don't have access to the tip tree.

I'll wait a kernel release cycle instead.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
