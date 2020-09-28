Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD9B27B087
	for <lists+linux-arch@lfdr.de>; Mon, 28 Sep 2020 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgI1PI5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Sep 2020 11:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1PI4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Sep 2020 11:08:56 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D3C061755;
        Mon, 28 Sep 2020 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aXHFqZ/iIOl43JouJBSLzJCCTkwZFEF5WcEtiJ8pWb8=; b=X8DOi0UPNDcRsS5RSWaxdhuXP
        5gTeWi+Nlet8LvJngBT8VHH5pxraI92zDVEfZebt0AogrHsTLx1eSDJ4uOkpyz3cDGQv3BsN8h0f7
        AdIvPVXuccNLR7KD7rZOCEH1xhcomS0FKW1jLd20yVrFQbvLdP/weqaCDKxVrPvGqqoWETzUNMLBQ
        cpElFlfiAQXBkxGHvnbpN3jajz8aZjWLEqNs96OSflJa6/HoV4vs7Abvutx5nVNp6eOJ+rJQYW9uq
        3mEQg0ErWo0WndcTBOQblYxdsfNfl4GfAvS5OE0QJYcuzzvtRa5l5TUfwTuRgmuT5fnRV2TuByS0C
        uJ+jbMU6w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39410)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kMulh-00006I-UJ; Mon, 28 Sep 2020 16:08:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kMulf-0000Bj-BN; Mon, 28 Sep 2020 16:08:43 +0100
Date:   Mon, 28 Sep 2020 16:08:43 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] ARM: syscall: always store thread_info->syscall
Message-ID: <20200928150843.GB1551@shell.armlinux.org.uk>
References: <20200907153701.2981205-1-arnd@arndb.de>
 <20200907153701.2981205-5-arnd@arndb.de>
 <CACRpkdYkL2=gkBvbHO514rnppLdHgsXwi0==6Ovq43kSZqEvUQ@mail.gmail.com>
 <CAK8P3a0BZ-zdk+RB5ODcVs2z-Y6xmLCp57uzivUGWRcoeH2fQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0BZ-zdk+RB5ODcVs2z-Y6xmLCp57uzivUGWRcoeH2fQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 28, 2020 at 02:42:43PM +0200, Arnd Bergmann wrote:
> > I need some idea how this numberspace is managed in order to
> > understand the code so I can review it, I guess it all makes perfect
> > sense but I need some background here.
> 
> I also had never understood this part before, and I'm still not
> sure where the 0x900000 actually comes from, though my best
> guess is that this was intended as a an OS specific number space,
> with '9' being assigned to Linux (similar to the way Itanium and
> MIPS do with their respective offsets). By the time EABI got added,
> this was apparently no longer considered helpful.

It is an OS specific number space, originally designed to allow
RISC OS programs to be run under Linux.  There was indeed such a
project, but that died and the code ripped out. EABI, by using
SWI 0 - or more accurately, not reading the SWI opcode, trampled
over the ability for RISC OS programs to be run under Linux.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
