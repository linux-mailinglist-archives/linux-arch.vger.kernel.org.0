Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E50692DFD
	for <lists+linux-arch@lfdr.de>; Sat, 11 Feb 2023 04:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBKDkP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Feb 2023 22:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBKDkM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2023 22:40:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97C73A082
        for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2023 19:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mGYnr+7F9YHS2rwmrBeTiiimw0fOz+T+mMJTaVQmdVY=; b=cwh9ReR5ImYsLhKU5tYL3oUTxH
        LtmtzoMAWJduyc8a4N1RMjhKaG1rF01iX8sBv372DO0gNtPwyCfnDffHw1Z5ptJANAnzVx//4NRxb
        IfdTd+QydQxTLFSgFENv/3qz1Ufn5vBdK+hmShglFsE8DKFq+rsxvHJA6ELgGk62+ajiwR4SlbdsV
        gelc238/EWRvBDKu7NPlQbNrBZhuiOQ472jujEGOIJvpKgMFeuBnOI14QZh1LEGh8jHE8mrqcc643
        A2A5KWSXNlU55Rm+oZAbs1kOYnBgntZ0b8nviiVGlI6exRBGDe4Mdl38bWIzdbqf1SgMYSbeDKhkG
        mlRHKISg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQgjv-003k2e-1V; Sat, 11 Feb 2023 03:39:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/7] New arch interfaces for manipulating multiple pages
Date:   Sat, 11 Feb 2023 03:39:41 +0000
Message-Id: <20230211033948.891959-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Here's my latest draft of a new set of page table manipulation APIs.  I've
only done alpha, arc and x86 (other than x86, I'm going alphabetically).
Before I go much further, some feedback might be a good idea.  Or if
someone wants to volunteer to do their architecture ;-)

Matthew Wilcox (Oracle) (7):
  mm: Convert page_table_check_pte_set() to page_table_check_ptes_set()
  mm: Add generic flush_icache_pages() and documentation
  mm: Add folio_flush_mapping()
  mm: Remove ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
  alpha: Implement the new page table range API
  arc: Implement the new page table range API
  x86: Implement the new page table range API

 Documentation/core-api/cachetlb.rst       | 35 ++++++-------
 arch/alpha/include/asm/cacheflush.h       | 10 ++++
 arch/alpha/include/asm/pgtable.h          | 18 ++++++-
 arch/arc/include/asm/cacheflush.h         |  7 ++-
 arch/arc/include/asm/pgtable-bits-arcv2.h | 20 ++++++--
 arch/arc/mm/cache.c                       | 61 ++++++++++++++---------
 arch/arc/mm/tlb.c                         | 18 ++++---
 arch/arm64/include/asm/pgtable.h          |  2 +-
 arch/riscv/include/asm/pgtable.h          |  2 +-
 arch/x86/include/asm/pgtable.h            | 21 ++++++--
 include/asm-generic/cacheflush.h          |  5 ++
 include/linux/cacheflush.h                |  4 +-
 include/linux/page_table_check.h          | 14 +++---
 include/linux/pagemap.h                   | 26 ++++++++--
 mm/page_table_check.c                     | 14 +++---
 mm/util.c                                 |  2 +-
 16 files changed, 176 insertions(+), 83 deletions(-)

-- 
2.39.1

