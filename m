Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641B659AAED
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 05:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiHTDeG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 23:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiHTDeE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 23:34:04 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2162CE27;
        Fri, 19 Aug 2022 20:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BPcBuYpUDDOXFJYHag51KAe7xl89hz8YVVJHaI7TbgA=; b=i/V569CgPrAeP3dIXaa1LQauMZ
        D4XtfuSvN/VaD+x3wREy0aeNvXRgOar+1EkkjaFCwu2IcikwRD+0gSZKsqcO1NQyi06Ojy3pITO5o
        jlWW4nMJZCXie6mtVvudR+ZEJTx0rvZmXYOuNuqqYZjmcuvwfDAe6NPiUHvct+X7qzUoFsabdIK0s
        hh8C6BJjVIBkLz5ik9SQw5dBIBHLXCYPkBGmjfmc65eLIus/78y3aJg8OZvGG8cGZdNFBZ/zDtGJb
        kfo+MoXQuKdRzTkmriYRIJALdW/s+VfF7TQCeO+aEZJMm8pfCeoTXEcvMYTa/RQGEnUKylbZ/wENq
        FoOJZMVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPFFF-006Hi8-Hv;
        Sat, 20 Aug 2022 03:33:57 +0000
Date:   Sat, 20 Aug 2022 04:33:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC][PATCHES] termios.h cleanups
Message-ID: <YwBWJYU9BjnGBy2c@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[resurrecting a patchset from back in 2018]

        asm/termios.h has tons of duplication and rather convoluted
logics re includes.

	asm/termios.h has both UAPI and internal variants.  On seven
architectures (alpha, ia64, mips, parisc, powerpc, s390, sparc)
both variants exist and internal one pulls the UAPI one by #include
<uapi/asm/termios.h>.  That is done very early in the internal header.
Everything else has neither UAPI nor internal termios.h.  Due to
mandatory-y += termios.h
in include/uapi/asm-generic/Kbuild they get generated/uapi/asm/termios.h
that consists of #include <asm-generic/termios.h>, which resolves to
include/asm-generic/termios.h.  That header serves as default internal
asm/termios.h and it contains
#include <uapi/asm-generic/termios.h>, resolving to
include/uapi/asm-generic/termios.h - default UAPI asm/termios.h.  As with
other internal asm/termios.h instances, that include happens very early
in the file.

On loongarch there's a generated/asm/termios.h with the contents identical
to what's in generated/uapi/asm/termios.h.  Completely pointless, but it's
hard to blame the loongarch folks here - the situation's much too confusing...

	Besides the include of UAPI asm/termios.h, non-UAPI ones contain
the following:
        * definition of INIT_C_CC
        * definitions of conversion helpers:
                user_termio_to_kernel_termios(),
                kernel_termios_to_user_termio(),
                user_termios_to_kernel_termios(),
                kernel_termios_to_user_termios()
        * (possibly) definitions of more conversion helpers:
                user_termios_to_kernel_termios_1(),
                kernel_termios_to_user_termios_1()
        * (possibly) include of linux/uaccess.h [generic, mips, powerpc, s390]
        * (possibly) include of linux/string.h [mips only]

        The thing is, conversion headers are used only in one file -
drivers/tty/tty_ioctl.c.  INIT_C_CC has more users - all three of them:
drivers/tty/hvc/hvcs.c, drivers/tty/tty_io.c and drivers/tty/vcc.c.
All other users of termios.h (and there's quite a few of them, in
particular due include in linux/tty.h) actually want the UAPI variant and,
perhaps, indirect include of uaccess.h and/or string.h.

        Helpers in question are heavily shared; there is an attempt
to put them into a common header (termios-base.h), but not all
instances use it.  Another unpleasant thing is that said helpers
tend to be macros, with very little typechecking.

	Patchset attempts to untangle that mess.

It takes the helpers and INIT_C_CC into new header (termios-internal.h),
with defaults being in linux/termios-internal.h, unless an arch-specific
variant is provided in asm/termios-internal.h (only alpha and sparc end
up needing that).  Files that need that stuff (all 4 of them) include
linux/termios-internal.h.

asm/termios.h and linux/termios.h become UAPI-only after that.

This stuff lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.termios

Individual patches in followups.  Please, review; if nobody yells,
this will go into -next.

Shortlog:
Al Viro (7):
      loongarch: remove generic-y += termios.h
      termios: get rid of stray asm/termios.h include in n_hdlc.c
      start unifying INIT_C_CC and termios convertors
      termios: consolidate values for VDISCARD in INIT_C_CC
      make generic INIT_C_CC a bit more generic
      termios: convert the last (sparc) INIT_C_CC to array
      termios: get rid of non-UAPI asm/termios.h

Diffstat:
 arch/Kconfig                              |   3 +
 arch/alpha/Kconfig                        |   1 +
 arch/alpha/include/asm/termios-internal.h |  70 ++++++++++++++
 arch/alpha/include/asm/termios.h          |  87 ------------------
 arch/arm/mach-ep93xx/core.c               |   1 +
 arch/arm/mach-versatile/integrator_ap.c   |   1 +
 arch/ia64/include/asm/termios.h           |  58 ------------
 arch/loongarch/include/asm/Kbuild         |   1 -
 arch/mips/include/asm/termios.h           | 105 ---------------------
 arch/parisc/include/asm/termios.h         |  52 -----------
 arch/powerpc/include/asm/termios.h        |  18 ----
 arch/s390/include/asm/termios.h           |  26 ------
 arch/sparc/Kconfig                        |   1 +
 arch/sparc/include/asm/termios-internal.h | 132 +++++++++++++++++++++++++++
 arch/sparc/include/asm/termios.h          | 147 ------------------------------
 drivers/net/wwan/wwan_core.c              |   1 +
 drivers/tty/hvc/hvcs.c                    |   1 +
 drivers/tty/n_hdlc.c                      |   1 -
 drivers/tty/tty_io.c                      |   2 +-
 drivers/tty/tty_ioctl.c                   |   1 +
 drivers/tty/vcc.c                         |   1 +
 include/asm-generic/termios-base.h        |  78 ----------------
 include/asm-generic/termios.h             | 108 ----------------------
 include/linux/serdev.h                    |   1 +
 include/linux/termios_internal.h          | 131 ++++++++++++++++++++++++++
 include/linux/tty_driver.h                |   1 +
 26 files changed, 347 insertions(+), 682 deletions(-)

