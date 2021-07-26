Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5463D5B1C
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhGZNb4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 09:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234469AbhGZNbi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 09:31:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4923E6008E;
        Mon, 26 Jul 2021 14:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627308727;
        bh=UTVA/I5GZpCUptag9FFZWsMgsUUuzpPL6332p4erEwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoxjGN6w3v5WOEatYJDRYdg3rnRAdqft0//FplgqJO0bx9AKwj3uGjQrZg7pmX1wZ
         b47xhtea55Pjrqn64z2Cbe8lDlBhKuotlchG7l41O59NQCxS+o1cjWlVbwp491ctDx
         7gZY48iw3jNzc3KrGSC1IVTUCCd0+8Hp9lOajd4ov40kDdM4dHUk3OwqG1VFmyMEne
         4Ay0j5sHrv+X9byQ/pktr6uvm0/iDWirlW496zwPO+d0Z+T3N4zv8/azamNVWrdWHO
         sDEFTcSvEQ8qr5Bn2qaHxjLYaAlniQ+8kJFqtkxxIvPZbZh5CRUTLby/lhyYj9ASol
         v+W8sjv6yFbEw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5 10/10] ARM: oabi-compat: fix oabi epoll sparse warning
Date:   Mon, 26 Jul 2021 16:11:41 +0200
Message-Id: <20210726141141.2839385-11-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210726141141.2839385-1-arnd@kernel.org>
References: <20210726141141.2839385-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

As my patches change the oabi epoll definition, I received a report
from the kernel test robot about a pre-existing issue with a mismatched
__poll_t type.

The OABI code was correct when it was initially added in linux-2.16,
but a later (also correct) change to the generic __poll_t triggered a
type mismatch warning from sparse.

As __poll_t is always 32-bit bits wide and otherwise compatible, using
this instead of __u32 in the oabi_epoll_event definition is a valid
workaround.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 8ced390c2b18 ("define __poll_t, annotate constants")
Fixes: ee219b946e4b ("uapi: turn __poll_t sparse checks on by default")
Fixes: 687ad0191488 ("[ARM] 3109/1: old ABI compat: syscall wrappers for ABI impedance matching")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/sys_oabi-compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index 223ee46b6e75..68112c172025 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -274,7 +274,7 @@ asmlinkage long sys_oabi_fcntl64(unsigned int fd, unsigned int cmd,
 }
 
 struct oabi_epoll_event {
-	__u32 events;
+	__poll_t events;
 	__u64 data;
 } __attribute__ ((packed,aligned(4)));
 
-- 
2.29.2

