Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8655B3226
	for <lists+linux-arch@lfdr.de>; Fri,  9 Sep 2022 10:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiIIIq1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Sep 2022 04:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiIIIqI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2022 04:46:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79D121694;
        Fri,  9 Sep 2022 01:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA820B8241D;
        Fri,  9 Sep 2022 08:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C7DC433D6;
        Fri,  9 Sep 2022 08:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662713162;
        bh=KbMP+qa2EwCmpxUxVtfcj5/M7zpKyn2SuqKqVIFfMco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HmtudXBo0YLhVOccNOP//jjRL6APp1qiH75YNdON02xMrPm4EKIWeEJZhabhlC0q3
         thg1itbnTx5QM2pmFJsIZwnA0JoygRT5J3qmQl0e980J+uq8Q8INcZpeHBE7+/9RP/
         /AX71eTOBwbPB9hDrx9i9GkOVI6n+zQ1zfnZI8y0=
Date:   Fri, 9 Sep 2022 10:45:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] termios: uninline conversion helpers
Message-ID: <Yxr9RSEfh4NCZk13@kroah.com>
References: <YwF8vibZ2/Xz7a/g@ZenIV>
 <20220821010239.1554132-1-viro@zeniv.linux.org.uk>
 <20220821010239.1554132-3-viro@zeniv.linux.org.uk>
 <Yw4B6IU9WWKhN+1H@kroah.com>
 <YxDlyBneTC/zBx4S@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxDlyBneTC/zBx4S@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 01, 2022 at 06:03:04PM +0100, Al Viro wrote:
> On Tue, Aug 30, 2022 at 02:26:16PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Aug 21, 2022 at 02:02:34AM +0100, Al Viro wrote:
> > > default go into drivers/tty/tty_ioctl.c, unusual - into
> > > arch/*/kernel/termios.c (only alpha and sparc have those).
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  arch/alpha/include/asm/termios.h   |  77 ++--------------
> > >  arch/alpha/kernel/Makefile         |   2 +-
> > >  arch/alpha/kernel/termios.c        |  57 ++++++++++++
> > >  arch/ia64/include/asm/termios.h    |  41 ++-------
> > >  arch/mips/include/asm/termios.h    |  84 ++----------------
> > >  arch/parisc/include/asm/termios.h  |  41 ++-------
> > >  arch/sparc/include/asm/termios.h   | 136 ++---------------------------
> > >  arch/sparc/kernel/Makefile         |   4 +-
> > >  arch/sparc/kernel/termios.c        | 115 ++++++++++++++++++++++++
> > >  drivers/tty/tty_ioctl.c            |  74 ++++++++++++++++
> > >  include/asm-generic/termios-base.h |  69 ++-------------
> > >  include/asm-generic/termios.h      |  42 ++-------
> > >  12 files changed, 294 insertions(+), 448 deletions(-)
> > >  create mode 100644 arch/alpha/kernel/termios.c
> > >  create mode 100644 arch/sparc/kernel/termios.c
> > 
> > The build blows up on me with this commit added to my tty-testing tree:
> 
> My apologies - reordering damage.  inlines in include/asm-generic/termios.h
> should've been removed in this commit, not in the next one.
> 
> Anyway, fixed branch rebased on top of your #tty-next; see
> vfs.git #work.termios2.  Individual patches in followups...

Thanks, much better, I've applied these and let's see if 0-day has any
problems with them...

greg k-h
