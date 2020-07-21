Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DE82289C2
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 22:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgGUUY2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 16:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGUUY2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:24:28 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76703C061794;
        Tue, 21 Jul 2020 13:24:28 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxyoL-00HPjR-34; Tue, 21 Jul 2020 20:24:25 +0000
Date:   Tue, 21 Jul 2020 21:24:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][CFT][PATCHSET] saner calling conventions for csum-and-copy
 primitives
Message-ID: <20200721202425.GA2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

	We have 3 per-architecture primitives that copy data and return
the checksum.  One is csum_partial_copy_nocheck() (kernel-to-kernel),
other two - csum_and_copy_from_user() and csum_and_copy_to_user().

	There are default implementations, but for quite a few architectures
these are done in assembler of varying unpleasantness.  The calling conventions
are due to a large pile of historical accidents; right now they are

__wsum csum_partial_copy_nocheck(src, dst, len, initial_sum):
	copy len bytes of data from src to dst, return something that is
comparable mod 65535 with checksum of that data added to initial_sum.
As always, __wsum values are defined only modulo 65535 - different kernel
configs can yield different 32bit values on the same data, identical blocks
of data at different address can yield different 32bit values (on the same
kernel), etc.  Relatively few call sites.

__wsum csum_and_copy_from_user(src, dst, len, initial_sum, errp)
	copy len bytes of data from src (in userspace) to dst.  In case
we can't copy the entire thing, set *errp to -EFAULT.  Otherwise *errp
is left unmodified and we return something that is comparable mod 65535
with the checksum of that data added to initial_sum.  Only two call sites
(both in lib/iov_iter.c).  In case of an error, the copied data is
discarded, along with the return value.

__wsum csum_and_copy_to_user(src, dst, len, initial_sum, errp)
	copy len bytes of data from src to dst (in userspace).  In case
we can't copy the entire thing, set *errp to -EFAULT.  Otherwise *errp
is left unmodified and we return something that is comparable mod 65535
with the checksum of that data added to initial_sum.  Only one call site
(in lib/iov_iter.c).  In case of an error, the copied data is
discarded, along with the return value.

The guts of these primitives are at the very least similar to each other;
on architectures with common address space for kernel and userland all
three are often implemented via a single asm helper.  Unfortunately, the
exception handlers are overcomplicated; if nothing else, they need to
pass a pointer to store -EFAULT into and some instances are trying to
zero the rest of destination (or the entire destination) when we fail to
fetch some data.

Note, BTW, that "userspace" in the above is real userspace - we never have
csum_and_copy_..._user() called under KERNEL_DS.

It's far too convoluted and that code had been accumulated a lot of cruft
over the years - for example, I'm fairly certain that nobody has read amd64
instances through since about 2005.

It's not that hard to untangle, though.  First of all, initial_sum part is
pointless - there is only one caller that ever passes something other than
zero and that one is easy to massage so that it, too, would pass zero (it
sums and copies the fragments attached to skb, then does the same to the
main part; doing the main part first gets rid of the problem).

Furthermore, using 0xffffffff instead of 0 will yield a non-zero value
comparable mod 0xffff with the original one, due to the way csum_add() works;
the same goes for its open-coded asm equivalents, as well as various "folding"
primitives.

That allows to use a simpler method of reporting an error - simply return
zero.  I.e.
__wsum csum_partial_copy_nocheck(src, dst, len)
	copy len bytes of data from src to dst, return something that is
comparable mod 65535 with checksum of that data.

__wsum csum_and_copy_from_user(src, dst, len)
	copy len bytes of data from src (in userspace) to dst.  In case
we can't copy the entire thing, return 0.  Otherwise return something non-zero
that is comparable mod 65535 with the checksum of that data.

__wsum csum_and_copy_to_user(src, dst, len)
	copy len bytes of data from src to dst (in userspace).  In case
we can't copy the entire thing, return 0.  Otherwise return something non-zero
that is comparable mod 65535 with the checksum of that data.

Exception handlers become trivial that way, of course, and quite a few gross
hacks in them go away.

The branch is based at 5.8-rc1 and can be found in
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.csum_and_copy
Individual patches will go in followups.

First we get rid of passing the initial sum for csum_partial_copy_nocheck():
      skb_copy_and_csum_bits(): don't bother with the last argument
      icmp_push_reply(): reorder adding the checksum up
      csum_partial_copy_nocheck(): drop the last argument
Next comes the minimal conversion of csum_and_copy_..._user() to new calling
conventions.  Asm parts are left unchanged at that point, which makes for
a reasonably small patch.  We could split that into per-architecture parts,
but IMO it's better done that way - no need of temporary "has this architecture
already switched" config symbols, etc.
      csum_and_copy_..._user(): pass 0xffffffff instead of 0 as initial sum
      saner calling conventions for csum_and_copy_..._user()
Finally, we propagate the change of calling conventions down into the asm
helpers.  That's done on per-architecture basis (and only for the architectures
that are not using the default instances, of course).
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

Only lightly tested; a lot of asm shite is killed off, so I would really like the
architecture maintainers to look through that thing.  Please, review.

Diffstat:
 arch/alpha/include/asm/checksum.h         |   4 +-
 arch/alpha/lib/csum_partial_copy.c        | 164 ++++++++-----------
 arch/arm/include/asm/checksum.h           |  16 +-
 arch/arm/lib/csumpartialcopy.S            |   4 +-
 arch/arm/lib/csumpartialcopygeneric.S     |   1 +
 arch/arm/lib/csumpartialcopyuser.S        |  26 +--
 arch/hexagon/include/asm/checksum.h       |   3 +-
 arch/hexagon/lib/checksum.c               |   4 +-
 arch/ia64/include/asm/checksum.h          |   3 +-
 arch/ia64/lib/csum_partial_copy.c         |   4 +-
 arch/m68k/include/asm/checksum.h          |   6 +-
 arch/m68k/lib/checksum.c                  |  88 +++-------
 arch/mips/include/asm/checksum.h          |  66 ++------
 arch/mips/lib/csum_partial.S              | 261 ++++++++++--------------------
 arch/nios2/include/asm/checksum.h         |   4 +-
 arch/parisc/include/asm/checksum.h        |  22 +--
 arch/parisc/lib/checksum.c                |   7 +-
 arch/powerpc/include/asm/checksum.h       |  12 +-
 arch/powerpc/lib/checksum_32.S            |  74 ++++-----
 arch/powerpc/lib/checksum_64.S            |  37 ++---
 arch/powerpc/lib/checksum_wrappers.c      |  74 ++-------
 arch/s390/include/asm/checksum.h          |   4 +-
 arch/sh/include/asm/checksum_32.h         |  35 ++--
 arch/sh/lib/checksum.S                    | 119 ++++----------
 arch/sparc/include/asm/checksum.h         |   1 +
 arch/sparc/include/asm/checksum_32.h      |  70 ++------
 arch/sparc/include/asm/checksum_64.h      |  39 +----
 arch/sparc/lib/checksum_32.S              | 202 +++++------------------
 arch/sparc/lib/csum_copy.S                |   3 +-
 arch/sparc/lib/csum_copy_from_user.S      |   4 +-
 arch/sparc/lib/csum_copy_to_user.S        |   4 +-
 arch/sparc/mm/fault_32.c                  |   6 +-
 arch/x86/include/asm/checksum_32.h        |  40 ++---
 arch/x86/include/asm/checksum_64.h        |  14 +-
 arch/x86/lib/checksum_32.S                | 117 +++++---------
 arch/x86/lib/csum-copy_64.S               | 140 +++++++++-------
 arch/x86/lib/csum-wrappers_64.c           |  86 ++--------
 arch/x86/um/asm/checksum.h                |   5 +-
 arch/x86/um/asm/checksum_32.h             |  23 ---
 arch/xtensa/include/asm/checksum.h        |  33 ++--
 arch/xtensa/lib/checksum.S                |  67 ++------
 drivers/net/ethernet/3com/typhoon.c       |   3 +-
 drivers/net/ethernet/sun/sunvnet_common.c |   2 +-
 include/asm-generic/checksum.h            |   4 +-
 include/linux/skbuff.h                    |   2 +-
 include/net/checksum.h                    |  15 +-
 lib/iov_iter.c                            |  21 ++-
 net/core/skbuff.c                         |  13 +-
 net/ipv4/icmp.c                           |  10 +-
 net/ipv4/ip_output.c                      |   6 +-
 net/ipv4/raw.c                            |   2 +-
 net/ipv6/icmp.c                           |   4 +-
 net/ipv6/ip6_output.c                     |   2 +-
 net/ipv6/raw.c                            |   2 +-
 net/sunrpc/socklib.c                      |   2 +-
 55 files changed, 609 insertions(+), 1371 deletions(-)
