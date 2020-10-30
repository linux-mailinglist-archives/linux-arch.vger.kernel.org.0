Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E7A2A0A22
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 16:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgJ3Ppt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 11:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgJ3Ppt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 11:45:49 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B6620936;
        Fri, 30 Oct 2020 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604072748;
        bh=nlOMXqka12e9yQIr/OhzGs4UNVMEOM0e+JUVN3RvNMk=;
        h=From:To:Cc:Subject:Date:From;
        b=TmRaUqarMiry5LSRwQ7CF1t9t2MeNM7kh8bk2DkIF7CQhWDT3xwEZAzbRrgeKFDnk
         Td2bCdvpBwwWoLmoa1EH3+nDChqbPqnxXUVD2CPpWk7dLaeaU32XXKn/cJOTz+PiM4
         7dj65fb+6Wrfaq4SWmJ0NQh2SIKHXTtrhIyMmYK0=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 0/9] ARM: remove set_fs callers and implementation
Date:   Fri, 30 Oct 2020 16:45:10 +0100
Message-Id: <20201030154519.1245983-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Hi Christoph, Russell,

This is the rebased version of my ARM set_fs patches on top of
v5.10-rc1, dropping the TASK_SIZE_MAX patch but leaving everything
else unchanged.

I have tested the oabi-compat changes using the LTP tests for the three
modified syscalls using an Armv7 kernel and a Debian 5 OABI user space.

I also tested the syscall_get_nr() in all combinations of OABI/EABI
kernel user space and fixed the bugs I found after Russell pointed
out one of those issues.

Russell, you can pull these from

 https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git arm-setfs_v4

or I can add them to the ARM patch tracker if you prefer.

     Arnd


Arnd Bergmann (9):
  mm/maccess: fix unaligned copy_{from,to}_kernel_nofault
  ARM: traps: use get_kernel_nofault instead of set_fs()
  ARM: oabi-compat: add epoll_pwait handler
  ARM: syscall: always store thread_info->syscall
  ARM: oabi-compat: rework epoll_wait/epoll_pwait emulation
  ARM: oabi-compat: rework sys_semtimedop emulation
  ARM: oabi-compat: rework fcntl64() emulation
  ARM: uaccess: add __{get,put}_kernel_nofault
  ARM: uaccess: remove set_fs() implementation

 arch/arm/Kconfig                   |   1 -
 arch/arm/include/asm/ptrace.h      |   1 -
 arch/arm/include/asm/syscall.h     |  16 ++-
 arch/arm/include/asm/thread_info.h |   4 -
 arch/arm/include/asm/uaccess-asm.h |   6 -
 arch/arm/include/asm/uaccess.h     | 169 ++++++++++++++-------------
 arch/arm/kernel/asm-offsets.c      |   3 +-
 arch/arm/kernel/entry-common.S     |  17 +--
 arch/arm/kernel/process.c          |   7 +-
 arch/arm/kernel/ptrace.c           |   9 +-
 arch/arm/kernel/signal.c           |   8 --
 arch/arm/kernel/sys_oabi-compat.c  | 181 ++++++++++++++++-------------
 arch/arm/kernel/traps.c            |  47 +++-----
 arch/arm/lib/copy_from_user.S      |   3 +-
 arch/arm/lib/copy_to_user.S        |   3 +-
 arch/arm/tools/syscall.tbl         |   2 +-
 fs/eventpoll.c                     |   5 +-
 include/linux/eventpoll.h          |  18 +++
 include/linux/syscalls.h           |   3 +
 ipc/sem.c                          |  84 ++++++++-----
 mm/maccess.c                       |  28 ++++-
 21 files changed, 332 insertions(+), 283 deletions(-)

Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
-- 
2.27.0

