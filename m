Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23B61265E
	for <lists+linux-arch@lfdr.de>; Sun, 30 Oct 2022 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJ2XQx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Oct 2022 19:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2XQx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Oct 2022 19:16:53 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21962EF24;
        Sat, 29 Oct 2022 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LImzIWyWeyV4UtuipZzTE0blZZG9s3NFxdeKryOx2nA=; b=XdawGtzhCWEuhGGAUzwVWInbBs
        UWiS8I1AK15Br0oB3cVIha5mscbudSbzZtKTm03EP4l3dfTTD5Sk+oVOuyJyUtsLa1YknihzNSYrZ
        GRIR86H1APz4fJvAP/plfHic5Za1cfihUGDe2jL3ofAkvQrbq4ifKjmP8o3GhxmXwf7/sR1dczu5o
        L14CaCLwOkTXOqPPuU/YLEbBMJWD5HzbyFdGVkusKLpEdUQKOWr5spUEKJqk5d4ObHSHvK5FjPabU
        QQ7vB1bbu4rktOi6Q1oL+TRnu6PNYZH/mHdawqHkvP+9fbp55m+rwM2jmTqg4cJjo6r9H0zmyJjaf
        9Q+dq+TQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oov4J-00FOGN-2Y;
        Sat, 29 Oct 2022 23:16:47 +0000
Date:   Sun, 30 Oct 2022 00:16:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCHSET] coredump unification for regset and non-regset
 architectures
Message-ID: <Y120X8dWqe15FPPG@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

	Resurrecting an old work - elf coredumps mess reduction.
Back in 2008 some of the architectures have switched to use of
regsets for elf coredumps.  Unfortunately, back then the helpers
used by other architectures used to be shared with a.out coredump
support, which made their calling conventions, etc. hard to
modify.  As the result, Roland went for duplicating quite a bit
of coredump-generating logics, with ifdef selecting the right
variant.

	Since then the copies had drifted apart - changes made
to one of them and applicable to both had not been propagated,
etc.  Many (but not all) architectures have switched to regset
variant.  And a.out coredump support had been removed, which
made it easier to modify the primitives on non-regset architectures.

	Series below attempts to make use of that; it had been
started about 4 years ago, but got stalled several times.

	Review and testing would be very appreciated.  Individual
patches - in followups.  Alternatively, it can be found in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.gitd #work.elfcore.

Al Viro (10):
      kill signal_pt_regs()
      kill coredump_params->regs
      kill extern of vsyscall32_sysctl
      [elf][regset] clean fill_note_info() a bit
      [elf][regset] simplify thread list handling in fill_note_info()
      elf_core_copy_task_regs(): task_pt_regs is defined everywhere
      [elf][non-regset] uninline elf_core_copy_task_fpregs() (and lose pt_regs argument)
      [elf][non-regset] use elf_core_copy_task_regs() for dumper as well
      [elf] unify regset and non-regset cases
      [elf] get rid of get_note_info_size()

 arch/alpha/include/asm/elf.h     |   6 -
 arch/alpha/include/asm/ptrace.h  |   1 -
 arch/alpha/kernel/process.c      |   8 +-
 arch/csky/kernel/process.c       |   3 +-
 arch/m68k/kernel/process.c       |   3 +-
 arch/microblaze/kernel/process.c |   2 +-
 arch/um/kernel/process.c         |   2 +-
 arch/x86/include/asm/elf.h       |   1 -
 arch/x86/um/asm/elf.h            |   4 -
 fs/binfmt_elf.c                  | 271 ++++++++-------------------------------
 fs/coredump.c                    |   1 -
 include/linux/coredump.h         |   1 -
 include/linux/elfcore.h          |  13 +-
 include/linux/ptrace.h           |   9 --
 kernel/signal.c                  |   2 +-
 15 files changed, 61 insertions(+), 266 deletions(-)
