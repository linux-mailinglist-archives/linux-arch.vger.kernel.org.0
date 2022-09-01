Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F4E5A9DA6
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 19:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiIARDL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 13:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiIARDK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 13:03:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2771C8C01D;
        Thu,  1 Sep 2022 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t0tbXnpw9PoNHokbrL2mN8UkdNxPcPnmI53yrOl5Xwk=; b=PMi26llEoWLExTDhFnJPkFHXlY
        5MdFVFSnLqtvcc/cePwW9IjH03dldOTbdGXeA7pP1jVjHo9TL5YFHbx3kmDCPoHp+/h8MnEDBXGQ4
        H+lmlJzhvfVjqZyxT+8SwnMbEJFHmE2sqLrsFtnf+RctOM1K2p2X4fGucPh82y4oX0P/5+/zx95x/
        N/AhKM9MHEWk4KdSYZwKijmrobfwbcXi1wj3WgoV+NHgS6OEq+lFypwu4qHvqvn7YIQvGRgeTQRcP
        ouKuLdwvK6Mo1+nAe/auyke0aX13BLO3ni9sfIDhApr26y/2KbEKrDkgVTkoSa6LCgyIIfK0gdgZh
        cflVhKrQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTnaq-00B2ig-Ta;
        Thu, 01 Sep 2022 17:03:05 +0000
Date:   Thu, 1 Sep 2022 18:03:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] termios: uninline conversion helpers
Message-ID: <YxDlyBneTC/zBx4S@ZenIV>
References: <YwF8vibZ2/Xz7a/g@ZenIV>
 <20220821010239.1554132-1-viro@zeniv.linux.org.uk>
 <20220821010239.1554132-3-viro@zeniv.linux.org.uk>
 <Yw4B6IU9WWKhN+1H@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw4B6IU9WWKhN+1H@kroah.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 30, 2022 at 02:26:16PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Aug 21, 2022 at 02:02:34AM +0100, Al Viro wrote:
> > default go into drivers/tty/tty_ioctl.c, unusual - into
> > arch/*/kernel/termios.c (only alpha and sparc have those).
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  arch/alpha/include/asm/termios.h   |  77 ++--------------
> >  arch/alpha/kernel/Makefile         |   2 +-
> >  arch/alpha/kernel/termios.c        |  57 ++++++++++++
> >  arch/ia64/include/asm/termios.h    |  41 ++-------
> >  arch/mips/include/asm/termios.h    |  84 ++----------------
> >  arch/parisc/include/asm/termios.h  |  41 ++-------
> >  arch/sparc/include/asm/termios.h   | 136 ++---------------------------
> >  arch/sparc/kernel/Makefile         |   4 +-
> >  arch/sparc/kernel/termios.c        | 115 ++++++++++++++++++++++++
> >  drivers/tty/tty_ioctl.c            |  74 ++++++++++++++++
> >  include/asm-generic/termios-base.h |  69 ++-------------
> >  include/asm-generic/termios.h      |  42 ++-------
> >  12 files changed, 294 insertions(+), 448 deletions(-)
> >  create mode 100644 arch/alpha/kernel/termios.c
> >  create mode 100644 arch/sparc/kernel/termios.c
> 
> The build blows up on me with this commit added to my tty-testing tree:

My apologies - reordering damage.  inlines in include/asm-generic/termios.h
should've been removed in this commit, not in the next one.

Anyway, fixed branch rebased on top of your #tty-next; see
vfs.git #work.termios2.  Individual patches in followups...
