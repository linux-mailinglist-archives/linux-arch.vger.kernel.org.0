Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E6449CB2D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jan 2022 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiAZNpf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jan 2022 08:45:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58226 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiAZNpe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jan 2022 08:45:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CE77B81E0F;
        Wed, 26 Jan 2022 13:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9195C340E3;
        Wed, 26 Jan 2022 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643204731;
        bh=aXQde9wq7cWvdCRLRrI1FIQr3++bEQ4exG2q/lhqD3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v+g8gUQjIt/c0ktBUQcit03sTj8G5mLw8FT+LXQqudlxh2iXfgafDrgsKIgJcd+6A
         KW7BP0Pf7wtiKC9gzDKJw1Q0VKMx5apmABXH/60JK3d2VK/Sw93FHWeCcfYpb1QPrC
         cxProUa3b1FFVLRT4j2tOajkb4EpxDNqSymszfjw=
Date:   Wed, 26 Jan 2022 14:45:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Walt Drummond <walt@drummond.us>
Cc:     agordeev@linux.ibm.com, arnd@arndb.de, benh@kernel.crashing.org,
        borntraeger@linux.ibm.com, chris@zankel.net, davem@davemloft.net,
        hca@linux.ibm.com, deller@gmx.de, ink@jurassic.park.msu.ru,
        James.Bottomley@hansenpartnership.com, jirislaby@kernel.org,
        mattst88@gmail.com, jcmvbkbc@gmail.com, mpe@ellerman.id.au,
        paulus@samba.org, rth@twiddle.net, dalias@libc.org,
        tsbogend@alpha.franken.de, gor@linux.ibm.com, ysato@users.osdn.me,
        linux-kernel@vger.kernel.org, ar@cs.msu.ru,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/3] status: TTY status message request
Message-ID: <YfFQeC1cUVFmISMK@kroah.com>
References: <20220118044259.764945-1-walt@drummond.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118044259.764945-1-walt@drummond.us>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 17, 2022 at 08:42:57PM -0800, Walt Drummond wrote:
> This patchset adds TTY status message request feature to the n_tty
> line dicipline.  This feature prints a brief message containing basic
> system and process group information to a user's TTY in response to a
> new control character in the line dicipline (default Ctrl-T) or the
> TIOCSTAT ioctl.  The message contains the current system load, the
> name and PID of an interesting process in the forground process group,
> it's run time, percent CPU usage and RSS.  An example of this message
> is:
> 
>   load: 0.31  cmd: sleep 3616843 [sleeping] 0.36r 0.00u 0.00s 0% 696k
> 
> User API visible changes are limited to:
>  - The addition of VSTATUS in termios.c_cc[]
>  - The addition of NOKERNINFO bit in termios.l_cflags
>  - The addition of the TIOCSTAT ioctl number
> 
> None of these changes break the existing kernel api as the termios
> structure on all architectures has enough space in the control
> character array (.c_cc) for the new character, and the other changes
> are space agnostic.
> 
> This feature is in many other Unix-like systems, both current and
> historical.  In other implementations, this feature would also send
> SIGINFO to the process group; this implementation does not.
> 
> Walt Drummond (3):
>   vstatus: Allow the n_tty line dicipline to write to a user tty
>   vstatus: Add user space API definitions for VSTATUS, NOKERNINFO and
>     TIOCSTAT
>   status: Display an informational message when the VSTATUS character is
>     pressed or TIOCSTAT ioctl is called.
> 
>  arch/alpha/include/asm/termios.h         |   4 +-
>  arch/alpha/include/uapi/asm/ioctls.h     |   1 +
>  arch/alpha/include/uapi/asm/termbits.h   |  34 ++---
>  arch/ia64/include/asm/termios.h          |   4 +-
>  arch/ia64/include/uapi/asm/termbits.h    |  34 ++---
>  arch/mips/include/asm/termios.h          |   4 +-
>  arch/mips/include/uapi/asm/ioctls.h      |   1 +
>  arch/mips/include/uapi/asm/termbits.h    |  36 ++---
>  arch/parisc/include/asm/termios.h        |   4 +-
>  arch/parisc/include/uapi/asm/ioctls.h    |   1 +
>  arch/parisc/include/uapi/asm/termbits.h  |  34 ++---
>  arch/powerpc/include/asm/termios.h       |   4 +-
>  arch/powerpc/include/uapi/asm/ioctls.h   |   2 +
>  arch/powerpc/include/uapi/asm/termbits.h |  34 ++---
>  arch/s390/include/asm/termios.h          |   4 +-
>  arch/sh/include/uapi/asm/ioctls.h        |   1 +
>  arch/sparc/include/uapi/asm/ioctls.h     |   1 +
>  arch/sparc/include/uapi/asm/termbits.h   |  38 +++---
>  arch/xtensa/include/uapi/asm/ioctls.h    |   1 +
>  drivers/tty/Makefile                     |   2 +-
>  drivers/tty/n_tty.c                      | 113 +++++++++++-----
>  drivers/tty/n_tty_status.c               | 162 +++++++++++++++++++++++
>  drivers/tty/tty_io.c                     |   2 +-
>  include/asm-generic/termios.h            |   4 +-
>  include/linux/tty.h                      | 123 ++++++++---------
>  include/uapi/asm-generic/ioctls.h        |   1 +
>  include/uapi/asm-generic/termbits.h      |  34 ++---
>  27 files changed, 461 insertions(+), 222 deletions(-)
>  create mode 100644 drivers/tty/n_tty_status.c
> 
> -- 
> 2.30.2
> 

You forgot to cc: me on patch 2/3, which would be needed if I was to
take them all.

Please fix up patch 2 and resend the whole series.

thanks,

greg k-h
