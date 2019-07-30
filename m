Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91C7A7F9
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2019 14:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfG3MPy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jul 2019 08:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfG3MPy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Jul 2019 08:15:54 -0400
Received: from guoren-Inspiron-7460.lan (unknown [60.186.223.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 880092087F;
        Tue, 30 Jul 2019 12:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564488952;
        bh=mM5RrFnCl4ACu3AYx0zr+lmIkY7fJjdY73Sg6NC1sTE=;
        h=From:To:Cc:Subject:Date:From;
        b=fu2v/bNYADBCraRK0loty2EzcoKoV4BclBBmd/IZYANyeCkLAUwgOe9nwvcPGN/DT
         q6g832rbzfLlCii0k/h7UuDxnU2H7XEp5PC7q9eB9oMuHdAFzWOezeY4ZVvdW/MO8O
         EcvtVnTt4TJOkWHs0LGRzxqjFEGcN5JajuquVSgk=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com,
        zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com,
        zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 1/4] csky: Fixup dma_rmb/wmb synchronization problem
Date:   Tue, 30 Jul 2019 20:15:42 +0800
Message-Id: <1564488945-20149-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

If arch didn't define dma_r/wmb(), linux will use w/rmb instead. Csky
use bar.xxx to implement mb() and that will cause problem when sync data
with dma device, becasue bar.xxx couldn't guarantee bus transactions
finished at outside bus level. We must use sync.s instead of bar.xxx for
dma data synchronization and it will guarantee retirement after getting
the bus bresponse.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/barrier.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
index 476eb78..061a633 100644
--- a/arch/csky/include/asm/barrier.h
+++ b/arch/csky/include/asm/barrier.h
@@ -9,7 +9,9 @@
 #define nop()	asm volatile ("nop\n":::"memory")
 
 /*
- * sync:        completion barrier
+ * sync:        completion barrier, all sync.xx instructions
+ *              guarantee the last response recieved by bus transaction
+ *              made by ld/st instructions before sync.s
  * sync.s:      completion barrier and shareable to other cores
  * sync.i:      completion barrier with flush cpu pipeline
  * sync.is:     completion barrier with flush cpu pipeline and shareable to
@@ -31,6 +33,9 @@
 #define rmb()		asm volatile ("bar.brar\n":::"memory")
 #define wmb()		asm volatile ("bar.bwaw\n":::"memory")
 
+#define dma_rmb()	asm volatile ("sync.s\n":::"memory")
+#define dma_wmb()	asm volatile ("sync.s\n":::"memory")
+
 #ifdef CONFIG_SMP
 #define __smp_mb()	asm volatile ("bar.brwarws\n":::"memory")
 #define __smp_rmb()	asm volatile ("bar.brars\n":::"memory")
-- 
2.7.4

