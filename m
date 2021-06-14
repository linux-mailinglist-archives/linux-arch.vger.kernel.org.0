Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C019E3A6AB6
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhFNPpf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 11:45:35 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221]:44950 "EHLO
        muminek.juszkiewicz.com.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232776AbhFNPpf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Jun 2021 11:45:35 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jun 2021 11:45:34 EDT
Received: from localhost (localhost [127.0.0.1])
        by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id B76D5260657;
        Mon, 14 Jun 2021 17:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=juszkiewicz.com.pl;
        s=mail; t=1623685052;
        bh=3e9HH+VzgjsfX5+R84xh1L7i/6vHLNzstnqfbyxutG8=;
        h=From:To:Cc:Subject:Date:From;
        b=ZsTv0HczxkVdVyhfcUbF9K/tcM46nYLM5Y/iHgfaMbDdv5G6BWgebYRfRo3KQEicP
         kMctJHD1lDH2H36Gsal55obmZEreWmykNGJZNk4nHzfCdW4sN+pS53QtDizria3IjX
         gKBb4v6XQX+CG9b6JpFzR1u5YxIJbMxg6KUpoi4Y=
X-Virus-Scanned: Debian amavisd-new at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
        by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8vKLDKml5FLQ; Mon, 14 Jun 2021 17:37:29 +0200 (CEST)
Received: from puchatek.lan (83.11.32.185.ipv4.supernova.orange.pl [83.11.32.185])
        by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 248BB2600CD;
        Mon, 14 Jun 2021 17:37:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=juszkiewicz.com.pl;
        s=mail; t=1623685049;
        bh=3e9HH+VzgjsfX5+R84xh1L7i/6vHLNzstnqfbyxutG8=;
        h=From:To:Cc:Subject:Date:From;
        b=mhDVWvqlSGZ/palOhvR7qRv/tiJuVDJtMwuT6mpGata8+thKFWdwwgwkVh/ZLzeMU
         uIjk9mU7877pkM8+FxqF32aBHHi8V4TblMS+YUgIYlGSGkDRZhoEejO7kTixJsyGqo
         t7t7vNUaW+U5Y/2Zetzkg2phC2HQOh3fq/mHnfSQ=
From:   Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arch@vger.kernel.org,
        Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Subject: [PATCH] quota: finish disable quotactl_path syscall
Date:   Mon, 14 Jun 2021 17:37:12 +0200
Message-Id: <20210614153712.313707-1-marcin@juszkiewicz.com.pl>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In commit 5b9fedb31e47 ("quota: Disable quotactl_path syscall") Jan Kara
disabled quotactl_path syscall on several architectures.

This commit disables it on all architectures using unified list of
system calls:

- arm64
- arc
- csky
- h8300
- hexagon
- nds32
- nios2
- openrisc
- riscv (32/64)

CC: Jan Kara <jack@suse.cz>
CC: Christian Brauner <christian.brauner@ubuntu.com>
CC: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://lore.kernel.org/lkml/20210512153621.n5u43jsytbik4yze@wittgenstein

Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
---
 include/uapi/asm-generic/unistd.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 6de5a7fc066b..d2a942086fcb 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -863,8 +863,7 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
 __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
 #define __NR_mount_setattr 442
 __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
-#define __NR_quotactl_path 443
-__SYSCALL(__NR_quotactl_path, sys_quotactl_path)
+/* 443 is reserved for quotactl_path */
 
 #define __NR_landlock_create_ruleset 444
 __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
-- 
2.31.1

