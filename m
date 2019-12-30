Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5312CD9D
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2019 09:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfL3IYW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Dec 2019 03:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfL3IYW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Dec 2019 03:24:22 -0500
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C41020748;
        Mon, 30 Dec 2019 08:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577694261;
        bh=dZYipzOSUcOEk9sfT5ToHwqu/RSsPyWAHSF4AdVtwWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pox84xeZtTNfsPPYNYWGefD5VzWKiC7mlqPOoqoc5PWxgyA8UDzH7o/CywB3Yno23
         CHqmI8voeuMo4w1nYvcaUePx2qHK/oMeDtrRndw+T3jffYKKIDD4kNdDgwyKEw4xYH
         4ZzuECbY/hd/gHo7UDLb7obbazTsP7ItNv0R12J0=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, Guo Ren <ren_guo@c-sky.com>,
        Mo Qihui <qihui.mo@verisilicon.com>,
        Zhange Jian <zhang_jian5@dahuatech.com>
Subject: [PATCH 5/5] csky/mm: Fixup export invalid_pte_table symbol
Date:   Mon, 30 Dec 2019 16:23:31 +0800
Message-Id: <20191230082331.30976-5-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191230082331.30976-1-guoren@kernel.org>
References: <20191230082331.30976-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

There is no present bit in csky pmd hardware, so we need to prepare invalid_pte_table
for empty pmd entry and the functions (pmd_none & pmd_present) in pgtable.h need
invalid_pte_talbe to get result. If a module use these functions, we need export the
symbol for it.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Mo Qihui <qihui.mo@verisilicon.com>
Cc: Zhange Jian <zhang_jian5@dahuatech.com>
---
 arch/csky/mm/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index 322eb7bd7962..dbb4b2dfe4b7 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -31,6 +31,7 @@
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
+EXPORT_SYMBOL(invalid_pte_table);
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 						__page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
-- 
2.17.0

