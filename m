Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1438623F321
	for <lists+linux-arch@lfdr.de>; Fri,  7 Aug 2020 21:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgHGThB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Aug 2020 15:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHGThA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Aug 2020 15:37:00 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB51DC061756;
        Fri,  7 Aug 2020 12:36:59 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k48Aj-00BJrD-FE; Fri, 07 Aug 2020 19:36:57 +0000
Date:   Fri, 7 Aug 2020 20:36:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] fdpic coredump stuff
Message-ID: <20200807193657.GV1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

	Switches fdpic coredumps away from original aout dumping primitives
to the same kind of regset use as regular elf coredumps do.

The following changes since commit b4e9c9549f62329d2412f899635fddc5212b9cd4:

  introduction of regset ->get() wrappers, switching ELF coredumps to those (2020-07-27 14:24:50 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fdpic

for you to fetch changes up to 1697a322e28ba96d35953c5d824540d172546d36:

  [elf-fdpic] switch coredump to regsets (2020-07-27 14:29:24 -0400)

----------------------------------------------------------------
Al Viro (7):
      unexport linux/elfcore.h
      take fdpic-related parts of elf_prstatus out
      kill elf_fpxregs_t
      [elf-fdpic] coredump: don't bother with cyclic list for per-thread objects
      [elf-fdpic] move allocation of elf_thread_status into elf_dump_thread_status()
      [elf-fdpic] use elf_dump_thread_status() for the dumper thread as well
      [elf-fdpic] switch coredump to regsets

 arch/ia64/include/asm/elf.h    |   2 -
 arch/powerpc/include/asm/elf.h |   2 -
 arch/x86/include/asm/elf.h     |   2 -
 fs/binfmt_elf.c                |  30 ------
 fs/binfmt_elf_fdpic.c          | 205 ++++++++++++++++++-----------------------
 include/linux/elfcore-compat.h |   4 -
 include/linux/elfcore.h        |  66 +++++++++++--
 include/uapi/linux/elfcore.h   | 101 --------------------
 scripts/headers_install.sh     |   1 -
 usr/include/Makefile           |   1 -
 10 files changed, 146 insertions(+), 268 deletions(-)
 delete mode 100644 include/uapi/linux/elfcore.h
