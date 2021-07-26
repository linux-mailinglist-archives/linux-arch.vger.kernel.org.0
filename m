Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE13D5AFE
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 16:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhGZNbS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 09:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233498AbhGZNbS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 09:31:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30DC76008E;
        Mon, 26 Jul 2021 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627308706;
        bh=XfV/GHrwokP79W0KwDE3X79qzGy2NGs86bgPl36XUXg=;
        h=From:To:Cc:Subject:Date:From;
        b=Hvfa4W0FR4f3NPAe0E/XOJdf9ePvCppwjT+Tg9rNH7gwS5wQIlbpZ3u6E5P2zTYC9
         lsL9gdZax+59HvqS3gBAaOYGGp4AumNBR1lp5eHAM6FzjnFCCFHEpzq8SwX/sMNRVg
         NA+dxRC6NPYfWQR0hJXnf0/JpmB/inD8rj3+znoUukwiQQQhEkPLCG7dk2YlJv+wsL
         jRirdCM/iW35av+6N6MfCzsPOR8yg/Jt/CYLvcl2UKFrOIaehzM61IzWBzEpDUyZAP
         8IjyfwGHKLFVwEdb41afxqhxGYYr31epdBLlLw3ncQpAeuYCuk9BOT/Lyl9KI4INUk
         uh8QTqNXeCb6g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 00/10] ARM: remove set_fs callers and implementation
Date:   Mon, 26 Jul 2021 16:11:31 +0200
Message-Id: <20210726141141.2839385-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Hi Christoph, Russell,

This is the rebased version of my ARM set_fs patches on top of
v5.14-rc2. There were a couple of minor conflicts that I resolved,
but otherwise this is still identical to the version I tested earlier.

The one notable change this time is that I rename thread_info->syscall
to thread_info->abi_syscall, to clarify that this field now contains
both the ABI bits (0x900000 for OABI, 0x000000 for EABI) in kernels
that support both, and every access to this has to mask out the bits
it needs. As Russell mentioned before, having a 'syscall' field that
not just contains the syscall number is confusing and error-prone, so
I hope this change is good enough.

I have tested the oabi-compat changes using the LTP tests for the three
modified syscalls using an Armv7 kernel and a Debian 5 OABI user space.

I also tested the syscall_get_nr() in all combinations of OABI/EABI
kernel user space and fixed the bugs I found after Russell pointed out
those issues in the early versions.

Linus Walleij did additional testing of v4 on Footbridge with OABI
user space.

With this and the m68k changes getting merged, we are very close
to eliminating set_fs completely.

Russell, you can pull these from

 https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git arm-setfs_v5

or I can add them to the ARM patch tracker if you prefer.

     Arnd

v4: https://lore.kernel.org/linux-arm-kernel/20201030154519.1245983-1-arnd@kernel.org/
v3: https://lore.kernel.org/linux-arm-kernel/20201001141233.119343-1-arnd@arndb.de/
v2: https://lore.kernel.org/linux-arm-kernel/20200918124624.1469673-1-arnd@arndb.de/
v1: https://lore.kernel.org/linux-arm-kernel/20200907153701.2981205-1-arnd@arndb.de/

Arnd Bergmann (9):
  mm/maccess: fix unaligned copy_{from,to}_kernel_nofault
  ARM: traps: use get_kernel_nofault instead of set_fs()
  ARM: oabi-compat: add epoll_pwait handler
  ARM: syscall: always store thread_info->abi_syscall
  ARM: oabi-compat: rework epoll_wait/epoll_pwait emulation
  ARM: oabi-compat: rework sys_semtimedop emulation
  ARM: oabi-compat: rework fcntl64() emulation
  ARM: uaccess: add __{get,put}_kernel_nofault
  ARM: uaccess: remove set_fs() implementation
  ARM: oabi-compat: fix oabi epoll sparse warning

 arch/arm/Kconfig                   |   1 -
 arch/arm/include/asm/ptrace.h      |   1 -
 arch/arm/include/asm/syscall.h     |  16 ++-
 arch/arm/include/asm/thread_info.h |   6 +-
 arch/arm/include/asm/uaccess-asm.h |   6 -
 arch/arm/include/asm/uaccess.h     | 169 ++++++++++++-----------
 arch/arm/include/uapi/asm/unistd.h |   1 +
 arch/arm/kernel/asm-offsets.c      |   3 +-
 arch/arm/kernel/entry-common.S     |  20 +--
 arch/arm/kernel/process.c          |   7 +-
 arch/arm/kernel/ptrace.c           |  14 +-
 arch/arm/kernel/signal.c           |   8 --
 arch/arm/kernel/sys_oabi-compat.c  | 214 +++++++++++++++++------------
 arch/arm/kernel/traps.c            |  47 +++----
 arch/arm/lib/copy_from_user.S      |   3 +-
 arch/arm/lib/copy_to_user.S        |   3 +-
 arch/arm/tools/syscall.tbl         |   2 +-
 fs/eventpoll.c                     |   5 +-
 include/linux/eventpoll.h          |  18 +++
 include/linux/syscalls.h           |   3 +
 ipc/sem.c                          |  84 ++++++-----
 mm/maccess.c                       |  28 +++-
 22 files changed, 361 insertions(+), 298 deletions(-)

Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>

-- 
2.29.2

