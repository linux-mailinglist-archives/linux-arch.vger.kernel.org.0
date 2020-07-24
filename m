Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436DD22BB57
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 03:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgGXBZP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 21:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgGXBZP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:15 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA7FC0619D3;
        Thu, 23 Jul 2020 18:25:15 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymSW-001GZr-SL; Fri, 24 Jul 2020 01:25:12 +0000
Date:   Fri, 24 Jul 2020 02:25:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][CFT][PATCHSET v2] saner calling conventions for csum-and-copy
 primitives
Message-ID: <20200724012512.GK2786714@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721202425.GA2786714@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Updated version pushed.  Changes since the first variant:

	* xtensa fix from Max Filippov (regression from last cycle, will
send to Linus tonight)
	* csum_partial_copy_nocheck() got its default variants consolidated
	* sparc64 idiotic typo fixed (along with the broken build script
I'd been using)
	* commit messages updated (mostly in "saner calling conventions for
csum_and_copy_..._user()")

The branch is still based at 5.8-rc1 and can be found in
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.csum_and_copy
Individual patches will go in followups.
 
Shortlog:
Al Viro (19):
      skb_copy_and_csum_bits(): don't bother with the last argument
      icmp_push_reply(): reorder adding the checksum up
      unify generic instances of csum_partial_copy_nocheck()
      csum_partial_copy_nocheck(): drop the last argument
      csum_and_copy_..._user(): pass 0xffffffff instead of 0 as initial sum
      saner calling conventions for csum_and_copy_..._user()
      alpha: propagate the calling convention changes down to csum_partial_copy.c helpers
      arm: propagate the calling convention changes down to csum_partial_copy_from_user()
      m68k: get rid of zeroing destination on error in csum_and_copy_from_user()
      sh: propage the calling conventions change down to csum_partial_copy_generic()
      i386: propagate the calling conventions change down to csum_partial_copy_generic()
      sparc32: propagate the calling conventions change down to __csum_partial_copy_sparc_generic()
      mips: csum_and_copy_{to,from}_user() are never called under KERNEL_DS
      mips: __csum_partial_copy_kernel() has no users left
      mips: propagate the calling convention change down into __csum_partial_copy_..._user()
      xtensa: propagate the calling conventions change down into csum_partial_copy_generic()
      sparc64: propagate the calling convention changes down to __csum_partial_copy_...()
      amd64: switch csum_partial_copy_generic() to new calling conventions
      ppc: propagate the calling conventions change down to csum_partial_copy_generic()

Max Filippov (1):
      xtensa: fix access check in csum_and_copy_from_user

Diffstat:
 arch/alpha/include/asm/checksum.h         |   5 +-
 arch/alpha/lib/csum_partial_copy.c        | 164 ++++++++-----------
 arch/arm/include/asm/checksum.h           |  17 +-
 arch/arm/lib/csumpartialcopy.S            |   4 +-
 arch/arm/lib/csumpartialcopygeneric.S     |   1 +
 arch/arm/lib/csumpartialcopyuser.S        |  26 +--
 arch/c6x/include/asm/checksum.h           |   6 +
 arch/hexagon/include/asm/checksum.h       |  11 --
 arch/hexagon/lib/checksum.c               |  11 --
 arch/ia64/include/asm/checksum.h          |   3 -
 arch/ia64/lib/csum_partial_copy.c         |  15 --
 arch/m68k/include/asm/checksum.h          |   7 +-
 arch/m68k/lib/checksum.c                  |  88 +++-------
 arch/mips/include/asm/checksum.h          |  68 ++------
 arch/mips/lib/csum_partial.S              | 261 ++++++++++--------------------
 arch/nios2/include/asm/checksum.h         |   5 -
 arch/parisc/include/asm/checksum.h        |  28 ----
 arch/parisc/lib/checksum.c                |  17 --
 arch/powerpc/include/asm/checksum.h       |  13 +-
 arch/powerpc/lib/checksum_32.S            |  74 ++++-----
 arch/powerpc/lib/checksum_64.S            |  37 ++---
 arch/powerpc/lib/checksum_wrappers.c      |  74 ++-------
 arch/s390/include/asm/checksum.h          |   7 -
 arch/sh/include/asm/checksum_32.h         |  36 ++---
 arch/sh/lib/checksum.S                    | 119 ++++----------
 arch/sparc/include/asm/checksum.h         |   2 +
 arch/sparc/include/asm/checksum_32.h      |  70 ++------
 arch/sparc/include/asm/checksum_64.h      |  39 +----
 arch/sparc/lib/checksum_32.S              | 202 +++++------------------
 arch/sparc/lib/csum_copy.S                |   3 +-
 arch/sparc/lib/csum_copy_from_user.S      |   4 +-
 arch/sparc/lib/csum_copy_to_user.S        |   4 +-
 arch/sparc/mm/fault_32.c                  |   6 +-
 arch/x86/include/asm/checksum.h           |   1 +
 arch/x86/include/asm/checksum_32.h        |  40 ++---
 arch/x86/include/asm/checksum_64.h        |  14 +-
 arch/x86/lib/checksum_32.S                | 117 +++++---------
 arch/x86/lib/csum-copy_64.S               | 140 +++++++++-------
 arch/x86/lib/csum-wrappers_64.c           |  86 ++--------
 arch/x86/um/asm/checksum.h                |  16 --
 arch/x86/um/asm/checksum_32.h             |  23 ---
 arch/xtensa/include/asm/checksum.h        |  34 ++--
 arch/xtensa/lib/checksum.S                |  67 ++------
 drivers/net/ethernet/3com/typhoon.c       |   3 +-
 drivers/net/ethernet/sun/sunvnet_common.c |   2 +-
 include/asm-generic/checksum.h            |  14 --
 include/linux/skbuff.h                    |   2 +-
 include/net/checksum.h                    |  22 ++-
 lib/checksum.c                            |  11 --
 lib/iov_iter.c                            |  21 ++-
 net/core/skbuff.c                         |  13 +-
 net/ipv4/icmp.c                           |  10 +-
 net/ipv4/ip_output.c                      |   6 +-
 net/ipv4/raw.c                            |   2 +-
 net/ipv6/icmp.c                           |   4 +-
 net/ipv6/ip6_output.c                     |   2 +-
 net/ipv6/raw.c                            |   2 +-
 net/sunrpc/socklib.c                      |   2 +-
 58 files changed, 615 insertions(+), 1466 deletions(-)
