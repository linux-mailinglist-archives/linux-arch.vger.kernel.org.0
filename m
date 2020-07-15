Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B31221342
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 19:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgGORJF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 13:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGORJF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 13:09:05 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59BB62075B;
        Wed, 15 Jul 2020 17:09:03 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 07/29] mm: Preserve the PG_arch_2 flag in __split_huge_page_tail()
Date:   Wed, 15 Jul 2020 18:08:22 +0100
Message-Id: <20200715170844.30064-8-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200715170844.30064-1-catalin.marinas@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a huge page is split into normal pages, part of the head page flags
are transferred to the tail pages. However, the PG_arch_* flags are not
part of the preserved set.

PG_arch_2 is used by the arm64 MTE support to mark pages that have valid
tags. The absence of such flag would cause the arm64 set_pte_at() to
clear the tags in order to avoid stale tags exposed to user or the
swapping out hooks to ignore the tags. Not preserving PG_arch_2 on huge
page splitting leads to tag corruption in the tail pages.

Preserve the newly added PG_arch_2 flag in __split_huge_page_tail().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

Notes:
    v7:
    - Only preserve PG_arch_2 in __split_huge_page_tail(). The PG_arch_1
      flag will be discussed separately as it may potentially impact s390
      and x86.
    
    New in v6.

 mm/huge_memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 78c84bee7e29..21ca2fff6b19 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2364,6 +2364,9 @@ static void __split_huge_page_tail(struct page *head, int tail,
 			 (1L << PG_workingset) |
 			 (1L << PG_locked) |
 			 (1L << PG_unevictable) |
+#ifdef CONFIG_64BIT
+			 (1L << PG_arch_2) |
+#endif
 			 (1L << PG_dirty)));
 
 	/* ->mapping in first tail page is compound_mapcount */
