Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE5C372664
	for <lists+linux-arch@lfdr.de>; Tue,  4 May 2021 09:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhEDHQf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 May 2021 03:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhEDHQb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 May 2021 03:16:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A93D1611AC;
        Tue,  4 May 2021 07:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620112537;
        bh=4SEVfhe9YJjHKwFp0+1zh+kDJG9VneL2VrT++65GFoc=;
        h=From:To:Cc:Subject:Date:From;
        b=qbaNkHX2AuopviLcvDUprjolrLlxoNYuO69c6aIBI940/5L4+t23Duc+2Vf0hEtxH
         MXDWGBHTgtHspfm5KIbP1upRWxUd/KS9PSEuodpphx9taYTQoPhUiIGLccGhLcuSef
         gSKOtl/sT2bvMO4k8SbK/8Tc7t7xL+INBHjGI0ksaNRLGwL3xK93Fosb9wRmMdt7/X
         KyN1ds4p1IR+0BVoRwAAvKBQFAYGP9fcjKsXZY31tXoV1lCQRbcKkaJg6AevJZpHYA
         QKYXfYFyJzF/vJ5nFAy0VrG7i3V9hrkWvHG15O20z3EhfgwJZpCWyf1FSTO1QoN5k2
         +OHehJffuYcYg==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] csky: syscache: Fixup duplicate cache flush
Date:   Tue,  4 May 2021 07:14:48 +0000
Message-Id: <1620112488-18773-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The current csky logic of sys_cacheflush is wrong, it'll cause
icache flush call dcache flush again. Now fixup it with a
conditional "break & fallthrough".

Fixes: 997153b9a75c ("csky: Add flush_icache_mm to defer flush icache all")
Fixes: 0679d29d3e23 ("csky: fix syscache.c fallthrough warning")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/mm/syscache.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/csky/mm/syscache.c b/arch/csky/mm/syscache.c
index 4e51d63..a7b53b0 100644
--- a/arch/csky/mm/syscache.c
+++ b/arch/csky/mm/syscache.c
@@ -12,15 +12,18 @@ SYSCALL_DEFINE3(cacheflush,
 		int, cache)
 {
 	switch (cache) {
-	case ICACHE:
 	case BCACHE:
-		flush_icache_mm_range(current->mm,
-				(unsigned long)addr,
-				(unsigned long)addr + bytes);
-		fallthrough;
 	case DCACHE:
 		dcache_wb_range((unsigned long)addr,
 				(unsigned long)addr + bytes);
+		if (cache == BCACHE)
+			fallthrough;
+		else
+			break;
+	case ICACHE:
+		flush_icache_mm_range(current->mm,
+				(unsigned long)addr,
+				(unsigned long)addr + bytes);
 		break;
 	default:
 		return -EINVAL;
-- 
2.7.4

