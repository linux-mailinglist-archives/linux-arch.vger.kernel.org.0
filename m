Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9AB760848
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jul 2023 06:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjGYEZ6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jul 2023 00:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjGYEY4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 00:24:56 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAE83A81;
        Mon, 24 Jul 2023 21:22:07 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d0e55215aebso2221964276.1;
        Mon, 24 Jul 2023 21:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258926; x=1690863726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9EaWELDe99nUon5K3Z+iJo2yPeaFSzyCnD+eyoagSI=;
        b=qNSUsqiVKVB0ESH5eMh2318rltbeTzVNrLxONrPQx/nleyciLPoBJAEyvEQiA5s1Tn
         685R6sAh2RRkBOJ+dHhwwHaTsDfn1Dq0fhp7maY379FRtPvlZFAioZBWPPk7fa1Wkq01
         qN75vY9UJqWiLkOixY4L6XdTPAaqKlrcR9SWRLlUZxoXjG975sFhxm21WZutHmQKl3h2
         OQ9WcHoISTJ2OjIGWYQNx9W6xFSNLrPRAFCGXfmCK8TcPNzYvmKngSTkC45cBTIzIEjY
         73sY0YERl7Ohg+xplAh/xTNZowvdAeC+fipfIzPvDIC0nmap4j6fccJNDYEXWoxWM6gV
         WCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258926; x=1690863726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9EaWELDe99nUon5K3Z+iJo2yPeaFSzyCnD+eyoagSI=;
        b=BqqzuVlHCK5tPpA93gxnAT4SZ7QFYGP173xrctx8SzAhPa2EVpWqs2QY1Vo4W+Fxi0
         Vq40TTHzWUnbWdrej4zlYFhs4N3E5FHu7xf2pC2TBIuYqGlg7XqS9LoKSVNdYN2O4ci2
         awE8wPFVJ7vmFZZKQArdcKAiPt3Jx+XH0VjlfFimGURuqjj+6QLhKgmIeQ43oUGy3WB+
         WxwCph5VT4WwSrqbQWOHQf6dhIg93d7AuYM998zmGfoef8ccZACjCRNf4i97uXTiK2xL
         BEjPhs0l/KJCg7sV0s5DHxfADe4asVMy9OtKGUPNBMsiJp5auhPKNXAZjLSzVMcxVtu+
         B4fg==
X-Gm-Message-State: ABy/qLYmBBQ50GPmiTa3Sp1gLTr2Hn4GZIGdhx+Z0Jcng2Jl3w04fzyF
        upXOhD/DTDOHiJisBRKbKEI=
X-Google-Smtp-Source: APBJJlEYsYvwES4yIHo2kt7NPKD5Twgr2oGLJnzn9f7qzh6ZvPXJtQdH1+pOAmNJT4cd1ABpvr+wDQ==
X-Received: by 2002:a5b:88e:0:b0:d0e:3831:fa2b with SMTP id e14-20020a5b088e000000b00d0e3831fa2bmr4772882ybq.62.1690258926669;
        Mon, 24 Jul 2023 21:22:06 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:22:06 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v7 28/31] sparc64: Convert various functions to use ptdescs
Date:   Mon, 24 Jul 2023 21:20:48 -0700
Message-Id: <20230725042051.36691-29-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 0d7fd793924c..9a63a3e08e40 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2893,14 +2893,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-	if (!page)
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!pagetable_pte_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
-	return (pte_t *) page_address(page);
+	return ptdesc_address(ptdesc);
 }
 
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
@@ -2910,10 +2911,10 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
 static void __pte_free(pgtable_t pte)
 {
-	struct page *page = virt_to_page(pte);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
 
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 void pte_free(struct mm_struct *mm, pgtable_t pte)
-- 
2.40.1

