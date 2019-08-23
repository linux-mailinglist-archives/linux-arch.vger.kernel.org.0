Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C369AD73
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 12:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbfHWKk6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 06:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387556AbfHWKk6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 06:40:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1728B2166E;
        Fri, 23 Aug 2019 10:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566556857;
        bh=51A+Don/bYB8YoXT4UiN6A2Rbpt3pPbplWI5smfQN3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NCnYvGzj19HNs01xz2iMxNe1fVsfJ/YHRn9zWmXXl924fGmUF21LyEa/DwYeKqnqt
         ax0TFL5ov+hd+kpTwjz8mhYKguieYjb4vch/zxzrzjDd7R5pNR7Row4R1Vl8zNKzT5
         NWSzWRYGSZ5aO7VqhnitIPYS/1IbP8HQyorq2LKw=
Date:   Fri, 23 Aug 2019 11:40:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Chris Clayton <chris2553@googlemail.com>,
        linux-arch@vger.kernel.org, vincenzo.frascino@arm.com,
        linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org,
        arnd@arndb.de, huw@codeweavers.com, andre.przywara@arm.com,
        daniel.lezcano@linaro.org, will.deacon@arm.com,
        LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org,
        salyzyn@android.com, paul.burton@mips.com,
        linux@rasmusvillemoes.dk, 0x7f454c46@gmail.com,
        catalin.marinas@arm.com, pcc@google.com, tglx@linutronix.de,
        sthotton@marvell.com, shuah@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Regression in 5.3-rc1 and later
Message-ID: <20190823104050.o6golaa4fmdd7np5@willie-the-truck>
References: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com>
 <20190823103654.GX13294@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823103654.GX13294@shell.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 23, 2019 at 11:36:54AM +0100, Russell King - ARM Linux admin wrote:
> To everyone on the long Cc list...
> 
> What's happening with this?  I was about to merge the patches for 32-bit
> ARM, which I don't want to do if doing so will cause this regression on
> 32-bit ARM as well.

tglx fixed it:

https://lkml.kernel.org/r/alpine.DEB.2.21.1908221257580.1983@nanos.tec.linutronix.de

which I assume is getting routed as a fix via -tip.

Will
