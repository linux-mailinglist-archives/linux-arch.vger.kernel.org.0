Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CE95A6347
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 14:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiH3M00 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiH3M0Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 08:26:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7179E7279;
        Tue, 30 Aug 2022 05:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5636EB81ACC;
        Tue, 30 Aug 2022 12:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CA5C433C1;
        Tue, 30 Aug 2022 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661862379;
        bh=Yqx4cNpU4JDoKl2EaHASrDJ5MjpYQ9YO7skQEyrSdCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IuvdhkqBsgM2S9A5SIEN2F/OOp9Cf7wTSUc4tjyCMLV3Lfzv69/9fDVmYvbM5bJJX
         JVChjVPre9zE9XBV7kJ+dKxenfN1/fXRpz25wNFEFThdR4Hvy7zJQ7tfv75hXstoa3
         vZMSCNUsojrUQTjk0txI9rsOkss+WO/UIW7jdKrQ=
Date:   Tue, 30 Aug 2022 14:26:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] termios: uninline conversion helpers
Message-ID: <Yw4B6IU9WWKhN+1H@kroah.com>
References: <YwF8vibZ2/Xz7a/g@ZenIV>
 <20220821010239.1554132-1-viro@zeniv.linux.org.uk>
 <20220821010239.1554132-3-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220821010239.1554132-3-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 21, 2022 at 02:02:34AM +0100, Al Viro wrote:
> default go into drivers/tty/tty_ioctl.c, unusual - into
> arch/*/kernel/termios.c (only alpha and sparc have those).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/alpha/include/asm/termios.h   |  77 ++--------------
>  arch/alpha/kernel/Makefile         |   2 +-
>  arch/alpha/kernel/termios.c        |  57 ++++++++++++
>  arch/ia64/include/asm/termios.h    |  41 ++-------
>  arch/mips/include/asm/termios.h    |  84 ++----------------
>  arch/parisc/include/asm/termios.h  |  41 ++-------
>  arch/sparc/include/asm/termios.h   | 136 ++---------------------------
>  arch/sparc/kernel/Makefile         |   4 +-
>  arch/sparc/kernel/termios.c        | 115 ++++++++++++++++++++++++
>  drivers/tty/tty_ioctl.c            |  74 ++++++++++++++++
>  include/asm-generic/termios-base.h |  69 ++-------------
>  include/asm-generic/termios.h      |  42 ++-------
>  12 files changed, 294 insertions(+), 448 deletions(-)
>  create mode 100644 arch/alpha/kernel/termios.c
>  create mode 100644 arch/sparc/kernel/termios.c

The build blows up on me with this commit added to my tty-testing tree:

In file included from ./arch/x86/include/generated/uapi/asm/termios.h:1,
                 from ./include/uapi/linux/termios.h:6,
                 from ./include/linux/tty.h:7,
                 from ./include/linux/vt_kern.h:12,
                 from drivers/gpu/drm/vboxvideo/vbox_drv.c:12:
./include/asm-generic/termios.h:70:5: error: conflicting types for ‘user_termio_to_kernel_termios’; have ‘int(struct ktermios *, struct termio *)’
   70 | int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/termios.h:20:19: note: previous definition of ‘user_termio_to_kernel_termios’ with type ‘int(struct ktermios *, const struct termio *)’
   20 | static inline int user_termio_to_kernel_termios(struct ktermios *termios,
      |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Lots of stuff like that.

I'll take the first 2 in my tree, but stop here.

thanks,

greg k-h
