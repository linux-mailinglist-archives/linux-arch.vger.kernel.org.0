Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F5348CAA5
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 19:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356197AbiALSKW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 13:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356056AbiALSJG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jan 2022 13:09:06 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111A8C03400D;
        Wed, 12 Jan 2022 10:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6La9C4YyAg08OoV/358HZSqSghTNkDUXX2vxnwT4Wyc=; b=k5WVo9XBH6g8ABPj+Q9UPZDGFz
        0aExXTaFDhQJ94Za0elX1EdK7gjPU0vGnsHXpuN67EquXAOEiE2boxLVEedHcoqT/yv6pksM/g6p8
        sA1Nl8sXUQzZRUFNVZe3w1ZkNXQbnXv6AEJUhORMamQhK1b3t0jtoQwohGHFESDhSc5zPmlxJw5Rw
        jHJgoXAvDvsSHxbzYTB55w7skpfhJUIKdLW1tt1gZpK+szCVeEM+pWLtGRl0kYMEueGTSbP4S8Cy7
        lMDxCY+F5Qi/fX43i1puyxHJkQxt8bVlId4CYwLRBagnd2I8y5HsMC7UdF4hp+33Jf2y2+zXFlzdK
        guQt/TQA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56676)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1n7i2l-0006IJ-L2; Wed, 12 Jan 2022 18:08:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1n7i2j-000754-Oj; Wed, 12 Jan 2022 18:08:17 +0000
Date:   Wed, 12 Jan 2022 18:08:17 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 08/10] ARM: uaccess: add __{get,put}_kernel_nofault
Message-ID: <Yd8ZEbywqjXkAx9k@shell.armlinux.org.uk>
References: <20210726141141.2839385-1-arnd@kernel.org>
 <20210726141141.2839385-9-arnd@kernel.org>
 <Yd8P37V/N9EkwmYq@wychelm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd8P37V/N9EkwmYq@wychelm>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 12, 2022 at 05:29:03PM +0000, Daniel Thompson wrote:
> On Mon, Jul 26, 2021 at 04:11:39PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > These mimic the behavior of get_user and put_user, except
> > for domain switching, address limit checking and handling
> > of mismatched sizes, none of which are relevant here.
> > 
> > To work with pre-Armv6 kernels, this has to avoid TUSER()
> > inside of the new macros, the new approach passes the "t"
> > string along with the opcode, which is a bit uglier but
> > avoids duplicating more code.
> > 
> > As there is no __get_user_asm_dword(), I work around it
> > by copying 32 bit at a time, which is possible because
> > the output size is known.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I've just been bisecting some regressions running the kgdbts tests on
> arm and this patch came up.

So the software PAN code is working :)

The kernel attempted to access an address that is in the userspace
domain (NULL pointer) and took an exception.

I suppose we should handle a domain fault more gracefully - what are
the required semantics if the kernel attempts a userspace access
using one of the _nofault() accessors?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
