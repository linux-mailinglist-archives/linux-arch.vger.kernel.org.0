Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990EE1961EA
	for <lists+linux-arch@lfdr.de>; Sat, 28 Mar 2020 00:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgC0XaL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 19:30:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35876 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgC0XaK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:30:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHyQQ-004KFl-9L; Fri, 27 Mar 2020 23:30:06 +0000
Date:   Fri, 27 Mar 2020 23:30:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCHSET] uaccess: getting csum_and_copy_..._user() into saner
 shape
Message-ID: <20200327233006.GW23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

        In that area uaccess primitives actually used by the rest of the kernel
are csum_and_copy_{to,from}_user().  Currently we have a strange mix;
        * some architectures supply csum_and_copy_from_user().  That's
indicated by defining _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
        * the rest end up using the wrapper from net/checksum.h instead;
that (fairly thin) wrapper expects to find csum_partial_copy_from_user().
Some among those have csum_partial_copy_from_user() that tries to be smart,
some end up picking a dumb one from lib/checksum.c, some have a literal
copy of that dumb version...
        * some architectures supply csum_and_copy_to_user().  Those define
HAVE_CSUM_COPY_USER.
        * the rest pick the dumb (inlined) implementation from net/checksum.h
        * to confuse the situation even more, there's a couple of architectures
that call their csum_and_copy_to_user() "csum_partial_copy_to_user" instead...
and have a macro defining csum_and_copy_to_user as csum_partial_copy_to_user.
        The rules for access_ok() location are also messy - in principle,
csum_partial_copy_from_user() expects to have access_ok() done in the wrapper,
but e.g. i386 one does that on its own.

        A saner approach would be to turn the csum_partial_copy_from_user()
instances into csum_and_copy_from_user() ones, getting rid of the wrapper
for those, then move the dumb one (also converted) into net/checksum.h.
The series below does that; it lives in
	git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #next.uaccess-4
based at #next.uaccess-3.  Individual patches in followups; please review.
Not sure which tree would that best go through, TBH...

Diffstat:
 arch/alpha/include/asm/checksum.h    |  3 ++-
 arch/alpha/lib/csum_partial_copy.c   |  6 +++---
 arch/arm/include/asm/checksum.h      | 14 ++++++++++++++
 arch/c6x/lib/checksum.c              | 22 ----------------------
 arch/ia64/include/asm/checksum.h     | 10 ----------
 arch/ia64/lib/csum_partial_copy.c    | 32 ++------------------------------
 arch/m68k/include/asm/checksum.h     |  3 ++-
 arch/m68k/lib/checksum.c             |  4 ++--
 arch/nios2/include/asm/checksum.h    |  2 --
 arch/parisc/include/asm/checksum.h   |  7 -------
 arch/parisc/lib/checksum.c           | 20 --------------------
 arch/s390/include/asm/checksum.h     | 19 -------------------
 arch/sh/include/asm/checksum_32.h    |  9 +++++++--
 arch/sparc/include/asm/checksum.h    |  1 +
 arch/sparc/include/asm/checksum_32.h | 15 ++++++++++-----
 arch/sparc/include/asm/checksum_64.h |  2 +-
 arch/x86/include/asm/checksum.h      |  2 ++
 arch/x86/include/asm/checksum_32.h   | 21 +++++++++++----------
 arch/x86/include/asm/checksum_64.h   | 12 ++----------
 arch/x86/lib/csum-wrappers_64.c      | 35 ++++++++++++++++++-----------------
 arch/x86/um/asm/checksum.h           | 20 --------------------
 arch/xtensa/include/asm/checksum.h   | 11 +++++++----
 include/asm-generic/checksum.h       |  9 ---------
 include/net/checksum.h               |  8 ++------
 lib/checksum.c                       | 20 --------------------
 25 files changed, 86 insertions(+), 221 deletions(-)

Shortlog:
      get rid of csum_partial_copy_to_user()
      x86_64: csum_..._copy_..._user(): switch to unsafe_..._user()
      x86: switch both 32bit and 64bit to providing csum_and_copy_from_user()
      x86: switch 32bit csum_and_copy_to_user() to user_access_{begin,end}()
      ia64: csum_partial_copy_nocheck(): don't abuse csum_partial_copy_from_user()
      ia64: turn csum_partial_copy_from_user() into csum_and_copy_from_user()
      alpha: turn csum_partial_copy_from_user() into csum_and_copy_from_user()
      parisc: turn csum_partial_copy_from_user() into csum_and_copy_from_user()
      sparc: switch to providing csum_and_copy_from_user()
      xtensa: switch to providing csum_and_copy_from_user()
      m68k: convert to csum_and_copy_from_user()
      sh32: convert to csum_and_copy_from_user()
      arm: switch to csum_and_copy_from_user()
      take the dummy csum_and_copy_from_user() into net/checksum.h
