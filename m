Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24CB1C55D7
	for <lists+linux-arch@lfdr.de>; Tue,  5 May 2020 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgEEMoO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 May 2020 08:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgEEMoO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 May 2020 08:44:14 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBB4C061A0F;
        Tue,  5 May 2020 05:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dvJVZ8RaVIi9fnToKXnkX3dzcg5kxNHYNYxAapFHQiM=; b=Z6As9OSnXP7R1PgeHS8atsvEh
        hLe9hBYBd2mlauOWcHMD6Ppt8ksXA4zT5pCu95JLgHTv8BqWcvUTPf+TjKHPYgQCmjkeabNOKU5SA
        Mz+jtCDU+7y7l4RsKJXIfyrICMUKqEFvYf7ItoIH03J5B2csZqs22QZirlcPkitBGTiOtuK9/sLRT
        vESzIpaStT5/bEK99pjNTMPlrSioAbYfknpLuc16wzWinZ3enyzfKzBNgbtwKVlrlKu9qJl3qGNbx
        QuJRM5cacbxBkvYJFDFQKbDdUQvR8xHD/k2OeyTA6zr4wcoCu4UOnNHG+ZSKyH/gqloIv/vky1Ma8
        L2RxiadHA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:54024)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jVwvZ-0002Ps-7W; Tue, 05 May 2020 13:44:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jVwvP-0007A5-9U; Tue, 05 May 2020 13:43:51 +0100
Date:   Tue, 5 May 2020 13:43:51 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Will Deacon <will@kernel.org>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org,
        linux-man@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
Message-ID: <20200505124351.GF1551@shell.armlinux.org.uk>
References: <20200504153214.GH30377@arm.com>
 <20200505104454.GC19710@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505104454.GC19710@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 05, 2020 at 11:44:55AM +0100, Will Deacon wrote:
> Michael has been nagging me on and off about that for, what, 10 years now?
> I would therefore be very much in favour of having our ptrace extensions
> documented!
> 
> We could even put this stuff under Documentation/arm64/man/ if it's deemed
> too CPU-specific for the man-pages project, but my preference would still
> be for it to be hosted there alongside all the other man pages.

Stuffing random things into the kernel tree is painful for some people.

For example, if you cross-build your kernel, then the stuff in the
tools/ subdirectory is totally useless (I think everything except
perf) because you can't build it.

Let's stop making the mistake of constantly shoving stuff into the
kernel source tree.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
