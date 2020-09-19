Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF61270BC8
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 10:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgISITQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgISITQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 04:19:16 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A4AC0613CE;
        Sat, 19 Sep 2020 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IJuNd4Gv09RCWUtcMRiqY/ZG9/GwVj+dhX5p2aRdauU=; b=M3ACm5mAdf7GFn88uis+FydnL
        bEkrNBoGv79Y3vmqo9+VcsFQzoolHZEHKtd1fBbiM1R9sgRo5eub6AZ+Ap//OXgWSm9yi563pd3OC
        t2+lOQVlhelmGHK5xdoaRENeAZdHiHvPZIGo++k61VxtxBTOB/vRcYppcL0sUW+qjmkjRoZ2x0uL+
        2b4FiXSz+AaqUIw9UrV3gMoH00CaCqQFgQLumeWrIXm+BP06dOve4pEH9BaThoAs1KYYeGGMgnPut
        bn21/hSfFlhzcG9DJHQP8sPChJRdGuU/ROf5pu1iXpsx1WmCgPH9Y5+rM/B4e4WVLrxS/WSOMeoPG
        Hn6wtjFzw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35542)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kJY5N-0008EB-3k; Sat, 19 Sep 2020 09:19:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kJY5K-0007c5-E9; Sat, 19 Sep 2020 09:19:06 +0100
Date:   Sat, 19 Sep 2020 09:19:06 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/9] ARM: remove set_fs callers and implementation
Message-ID: <20200919081906.GV1551@shell.armlinux.org.uk>
References: <20200918124624.1469673-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918124624.1469673-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 02:46:15PM +0200, Arnd Bergmann wrote:
> Hi Christoph, Russell,
> 
> Here is an updated series for removing set_fs() from arch/arm,
> based on the previous feedback.
> 
> I have tested the oabi-compat changes using the LTP tests for the three
> modified syscalls using an Armv7 kernel and a Debian 5 OABI user space,
> and I have lightly tested the get_kernel_nofault infrastructure by
> loading the test_lockup.ko module after setting CONFIG_DEBUG_SPINLOCK.

I'm not too keen on always saving the syscall number, but for the gain
of getting rid of set_fs() I think it's worth it. However...

I think there are some things to check - what value do you end up
with as the first number in /proc/self/syscall when you do:

strace cat /proc/self/syscall

?

It should be 3, not 0x900003. I suspect you're getting the latter
with these changes.  IIRC, task_thread_info(task)->syscall needs to
be the value _without_ the offset, otherwise tracing will break.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
