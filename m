Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0749F26FD48
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 14:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgIRMrI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 08:47:08 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33785 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgIRMqt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 08:46:49 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M89XH-1kOUyv18jL-005LlK; Fri, 18 Sep 2020 14:46:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 0/9] ARM: remove set_fs callers and implementation
Date:   Fri, 18 Sep 2020 14:46:15 +0200
Message-Id: <20200918124624.1469673-1-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nmxKQc8+mlxCdbwLh20YUK4iPyhFqrbIVbvONGu23xOQJJLdRN2
 2+xyADSruG1O9wHrRftwYOLBHwRJfDyIXwaFTqnimdCPzKF1SKWmVOt6fCwk3KuiaCx2wXO
 nkXcOq0MrNeyJcp3/UixkWJ4gh/yKLCgR1IjVyFiiEnKoX5Q+84c27tN793aFzlv+w0JEdv
 Rpy7xvT/VMvSLKz4XqQaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yb7i0b89nVM=:P1939kZNz1oQxZjce03F3i
 n1Vv9IQaC8UxUrT/lhWAgqknz972LLDSVMGUl84nEnA2cKCDf0QNINGtTzmSlA9ler9NXWmgU
 6cj6c2JfKMzjygFjM7Z1qFWp95ujwd9Ki37gkY8+hGQgwg7/MDe4yfBlBJQ43uWaFuuGvmS8Y
 YFyRZgfQXcL8giaaOrOoxwmk6Zn6vxCjcKEekj8EZamFq3WSVENaul1aSB5FWp7/1ubxio+HF
 HysS+bKsKGfbnEqCu7Zbho9RRW+AYEMN7VLNqXF6HDM3zwKZoSFO3qUDMQlQwkwwWFqQl8VBC
 4MHyBPovfS7DpjrXuHEGrdiYYOj25Bkj6nFHk14cKY0VadkiGHybWWbGUw5JzrpCR/XUpO3EL
 eqjcYy0JywW2nOsraHUvvHuTRbA9bFEH6sHxP9oJ6WedJrBS7KtOhUx2pBDXmKp3t8jjtp5OM
 SJc28Lf4oBF8XifenM3gWPodnuJ/NTpdPQ+UUvKLUQnC7Riz71XGvZ0S6eWCwGEX/vVGx0/kP
 FaXCHrY6AGvcVfT9uNteygV3yCSfCoyH0hn5//euyx0hfryqcwgYqpL1lbxO5eb01jY6IqHn3
 pHxpIAeYjinrLpCUHGXCz6OrZ2feJB7FWs91rZkFsRpC8IjX7DOlFRKvHgMMsFKz5KhCmIf6N
 6uS+B0cVAFoL4+qOUN/Evcz0sqiEz7xvpLqp+g9QhgROLmIlRYMxRe4f5Oc9t6nCoMSne0bY0
 1Tumx1w2w1hwfzgot5teXWCUUVMrUajMHwJjFPhk8/mpznPZ2Ne6tNs+EKMh8nOtd2VtVywDE
 FlU3pubYMMb4M3ROJ+YHubbyBU1kIS0+bhY3JC16aC4l69RCvDouoB6B+ZiPT5iSEipC04w
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph, Russell,

Here is an updated series for removing set_fs() from arch/arm,
based on the previous feedback.

I have tested the oabi-compat changes using the LTP tests for the three
modified syscalls using an Armv7 kernel and a Debian 5 OABI user space,
and I have lightly tested the get_kernel_nofault infrastructure by
loading the test_lockup.ko module after setting CONFIG_DEBUG_SPINLOCK.

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
 arch/arm/kernel/entry-common.S     |  16 +--
 arch/arm/kernel/process.c          |   7 +-
 arch/arm/kernel/ptrace.c           |   4 +-
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
 21 files changed, 328 insertions(+), 281 deletions(-)

-- 
2.27.0

