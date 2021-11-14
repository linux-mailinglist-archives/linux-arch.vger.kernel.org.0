Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8886544F913
	for <lists+linux-arch@lfdr.de>; Sun, 14 Nov 2021 17:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhKNQif (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Nov 2021 11:38:35 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:64883 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhKNQid (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Nov 2021 11:38:33 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id mITgmJfNg3ptZmITgmae6T; Sun, 14 Nov 2021 17:35:36 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 14 Nov 2021 17:35:36 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] sched: Remove a useless #include
Date:   Sun, 14 Nov 2021 17:35:34 +0100
Message-Id: <20d09d5e3e540fda4108ec7358c598bf8d4dcb3c.1636907727.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

unlikely() is not used anymore since commit ff80a77f20f8 ("sched: simplify
sched_find_first_bit()") in 2007.

So this include can be removed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only on my x86_64 Ubuntu like environment.

It also looks to me that the only needed include is <linux/bitops.h> and
that <asm/types.h> is of no use.
---
 include/asm-generic/bitops/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/bitops/sched.h b/include/asm-generic/bitops/sched.h
index 86470cfcef60..c3b7d50d6711 100644
--- a/include/asm-generic/bitops/sched.h
+++ b/include/asm-generic/bitops/sched.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_GENERIC_BITOPS_SCHED_H_
 #define _ASM_GENERIC_BITOPS_SCHED_H_
 
-#include <linux/compiler.h>	/* unlikely() */
 #include <asm/types.h>
 
 /*
-- 
2.30.2

