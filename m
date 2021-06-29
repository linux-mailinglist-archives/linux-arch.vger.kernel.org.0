Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A203B703B
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jun 2021 11:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhF2Jqc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Jun 2021 05:46:32 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58191 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhF2Jqc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Jun 2021 05:46:32 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C5816E0007;
        Tue, 29 Jun 2021 09:44:03 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] asm-generic: Fix a typo "regien" -> "region"
Date:   Tue, 29 Jun 2021 11:44:02 +0200
Message-Id: <20210629094402.3850590-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This fixes a typo where "region" was misspelled.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 include/asm-generic/sections.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d16302d3eb59..aedb3b365a8a 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -114,7 +114,7 @@ static inline bool memory_contains(void *begin, void *end, void *virt,
 /**
  * memory_intersects - checks if the region occupied by an object intersects
  *                     with another memory region
- * @begin: virtual address of the beginning of the memory regien
+ * @begin: virtual address of the beginning of the memory region
  * @end: virtual address of the end of the memory region
  * @virt: virtual address of the memory object
  * @size: size of the memory object
-- 
2.30.2

