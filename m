Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB1F1EAD2F
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jun 2020 20:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgFASnQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jun 2020 14:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731408AbgFASmm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jun 2020 14:42:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F555C03E96F;
        Mon,  1 Jun 2020 11:22:48 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jfp5B-001X6g-S9; Mon, 01 Jun 2020 18:22:46 +0000
Date:   Mon, 1 Jun 2020 19:22:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [git pull] uaccess csum
Message-ID: <20200601182245.GA23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

	Regularize the sitation with uaccess checksum primitives, fold
csum_partial_... into csum_and_copy_..._user(), on x86 collapse several
access_ok()/stac()/clac() into user_access_begin()/user_access_end()

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.csum

for you to fetch changes up to 001c1a655f0a4e4ebe5d9beb47466dc5c6ab4871:

  default csum_and_copy_to_user(): don't bother with access_ok() (2020-05-29 16:11:50 -0400)

----------------------------------------------------------------
Al Viro (15):
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
      default csum_and_copy_to_user(): don't bother with access_ok()

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
 include/net/checksum.h               | 14 ++++----------
 lib/checksum.c                       | 20 --------------------
 25 files changed, 88 insertions(+), 225 deletions(-)
