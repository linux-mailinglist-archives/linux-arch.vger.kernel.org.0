Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A244525FD61
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 17:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgIGPij (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 11:38:39 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbgIGPh1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 11:37:27 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MQMmF-1jtUy03FLN-00MIv2; Mon, 07 Sep 2020 17:37:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/9] ARM: remove set_fs callers and implementation
Date:   Mon,  7 Sep 2020 17:36:41 +0200
Message-Id: <20200907153701.2981205-1-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VjRIHVKsrJ2cp1DZW/WWar2/93OzLGw+aSFBTMZna85P5K77sAZ
 Xch35nM3blzVomWJfJD7n6iXwAEm8E3HwandaTb2+6zBSlwd2VeBUH0fqENpQrUh0XtfTfD
 qfbOFRC61hirr7cOpMwF9FBayHhHu8B/OOTAIN6DrhaoGavRLobM+MTxqFg9mYvIyrsQcDq
 kSKFtTEpMK0s/MdO16Cww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ndcJ4md6HKs=:k8lJJzPq5Q6bCc/q2u0d/F
 gOihSTsr/6SWTxmx92Lqbx6XJ0C8SqnQaEKKMCdZipxiRx6pDNivu2OSYx4pMUqyXtyfPEyDv
 a3mZq77kVBEBmnxZgwt6qPIaangNt2U0H7WelIhHbvdOareFCKqc1y0Lrhob7/FwUwi6JimyP
 pYcHqzyZ0QE2ninttJEXc523JmcGvUiwJFSXUgW6uEBn7e+x+RqQjgyAFiRIgdXoe29Sgm0A1
 Vlu0qRlraIXFOzWYuqGdcoilXiJG8O6pAI6MflhHbVI57HHQ2+fdKhHJzx+Fy3BaMadwM5LmI
 c3YQFGJc9T0BGZWjrrOvZiBinPmrdcUaIpEpZJCWFPJi3y3KiPunrfCYK+zgGCqK31MUhaQ2o
 lrVVat8P5A/lycgKPZhAy9ah/ACyIJcrB4VjS9NPS7OrT76q6fsSfQtCsKWZ6Ez0I7MHy7oeL
 wh+ZAEig2auAChonuKGjg5n+a37AZWw8D3GzwUATHwXqgQHqiXdLRP480NT8okpx9RYMMSaiw
 zxXd5wJo6STcvilW/xQv17QEhfmdHeD5/bBVc/logNrrB6ELLkaJ+ExWid1aaSQIMZOy+A/4W
 h8hpT9uUZZ0+8AbEn3VqplebZDQuP/pjDN2n9aM5v1sbpO+FJnf8UkF9Aqq2hXvL0dsEiC/pq
 3xF7DWf8d20TCwjAxPeDcyMDDAXeno1JtEhRVaNEVBHqC43mTqtWIJHNFAAgle/Qt0mU8v52b
 LWAKqRWaF5awi9zIMgGvMN4Up0FNcRYj6KrkhnJ0Mp7mBcBbLOHmjkTCyC5lVRZ5NK/OsEQZ3
 +gkKrgZF+JQuGPT90Ylv+P3Px6XS7DQfYX527LIkEbErHEr4KwksdTq46L4E7UN/9R8XNB2
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph, Russell,

As promised, here is my series to remove set_fs() from arch/arm based
on the architecture-independent patches.

I have tested the oabi-compat changes using the LTP tests for the three
modified syscalls using an Armv7 kernel and a Debian 5 OABI user space,
and I have lightly tested the get_kernel_nofault infrastructure by
loading the test_lockup.ko module after setting CONFIG_DEBUG_SPINLOCK.

Let me know if there is a more thorough test I should try.

Overall there is a bit of ugliness getting introduced in the oabi compat
code and for adding another code path for TUSER(). If anyone has a better
idea, I can try out a different way.

I assume these patches can go through Al's tree along with the
corresponding changes for other architectures, once Russell is happy
with them.

Please review.

     Arnd

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=arm-kill-set_fs

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
 arch/arm/include/asm/syscall.h     |  14 +++
 arch/arm/include/asm/thread_info.h |   4 -
 arch/arm/include/asm/uaccess-asm.h |   6 -
 arch/arm/include/asm/uaccess.h     | 169 ++++++++++++++-------------
 arch/arm/kernel/asm-offsets.c      |   3 +-
 arch/arm/kernel/entry-common.S     |  16 +--
 arch/arm/kernel/process.c          |   7 +-
 arch/arm/kernel/ptrace.c           |   4 +-
 arch/arm/kernel/signal.c           |   8 --
 arch/arm/kernel/sys_oabi-compat.c  | 180 ++++++++++++++++-------------
 arch/arm/kernel/traps.c            |  69 +++++------
 arch/arm/lib/copy_from_user.S      |   3 +-
 arch/arm/lib/copy_to_user.S        |   3 +-
 arch/arm/tools/syscall.tbl         |   2 +-
 fs/eventpoll.c                     |   5 +-
 include/linux/eventpoll.h          |  16 +++
 include/linux/syscalls.h           |   2 +
 ipc/sem.c                          |  84 +++++++++-----
 mm/maccess.c                       |  28 ++++-
 21 files changed, 338 insertions(+), 287 deletions(-)

-- 
2.27.0

