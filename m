Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD12838D684
	for <lists+linux-arch@lfdr.de>; Sat, 22 May 2021 18:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhEVQsr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 May 2021 12:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhEVQsq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 22 May 2021 12:48:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 226D461155;
        Sat, 22 May 2021 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621702041;
        bh=1nkprgqgpCp0qvcV06t+ci22nMixdxCryXKm85/FJrk=;
        h=From:To:Cc:Subject:Date:From;
        b=rApdu2RZ/qrnjTTcP0RtTKCS8QNue+JJ1Td2bwWFgevP99PP/u26eowUvvXT/9fDo
         ZoJqBg3rnuWZEr7kEKXuN0CsDy8eMK5G1cZ4sVuMgajM6BDAsZHk0DdLzM84twu9AN
         uCfLLcKBr4V7gX0vMdwWYLRIrncR/Q7C1cimNMoK5truoW/KGkRjRRvrNQxl4GlemS
         DjUwN0ZuEbGijk+a7qpxS5fQ8AMTnMx6x2hg3SuvthWgjD1sDHV6LKkowOymda0+Ok
         /oA/vCxGsomXHV4Ne/KCVGdhkVw+GAdN0oLesr7bS6PP+iMUgF70qq6UFH3rxr88+E
         ff0JcUXm7HbTA==
From:   guoren@kernel.org
To:     guoren@kernel.org, monstr@monstr.eu, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] microblaze: Remove unused functions
Date:   Sat, 22 May 2021 16:46:34 +0000
Message-Id: <1621701994-27650-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

PAGE_UP/DOWN are never used in linux, then the patch remove them
in asm/page.h.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/include/asm/page.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index bf681f2..ce55097 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -35,9 +35,6 @@
 
 #define ARCH_SLAB_MINALIGN	L1_CACHE_BYTES
 
-#define PAGE_UP(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
-#define PAGE_DOWN(addr)	((addr)&(~((PAGE_SIZE)-1)))
-
 /*
  * PAGE_OFFSET -- the first address of the first page of memory. With MMU
  * it is set to the kernel start address (aligned on a page boundary).
-- 
2.7.4

