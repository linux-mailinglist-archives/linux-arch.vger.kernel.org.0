Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC25073AAD2
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 23:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjFVVCd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 17:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjFVVBk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 17:01:40 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296C626B9;
        Thu, 22 Jun 2023 13:59:35 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76246351f0cso664289785a.1;
        Thu, 22 Jun 2023 13:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467530; x=1690059530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSsj72OOim1moFehILf4IJ+e4eXIj/xtfG6kDsakLCY=;
        b=F65orfGp6lPWpCrD9sAMHQjbb/7dPkBeEZwnbqaqoaG+jHKHFKOpyv5U+mRswUePBl
         O+w6mgJQE0929R7HfQnempO9NwPEm6qT8tc34OERTuMiOZXiohUbt3LRN+VbVJEKUKkc
         tcmSj8t+FV4PGg1S/0RDnwUBY8C4sUVvlY/c/d4jqvMe/jl29yqPCuiM1limtTye3/Mt
         Xl+0XJrX90O7Fe0pzMoOa3o991eJyDuyXmsTPhqv2ERTFkUraPYZpwk4UgntXrYBzy7x
         tG0gCzAga9PV8hPLOnhqVRtX7sCVqxvHBH7A5BvtHK+faRxZPp8TVFIuHWDaefij0y+Q
         y3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467530; x=1690059530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSsj72OOim1moFehILf4IJ+e4eXIj/xtfG6kDsakLCY=;
        b=fQn2BQfRBWDwhK6bl3Yk5ZWl2KYF4vtO+6N2uO1CMB4vxA19Aq/RFpLX5ggv0uNd2+
         LlPJoU5LZF/OEYzkOLxvdbfmidcYT2hn5rni34bDjO69mr+DhRq7MLS9pA4tYRKGz64H
         xDXgXqXUxWZ8k/I43TmqjVy2anQ5wluYyY5bCs1lQovpDwijcJG/Tbx7LpnpqlTKhUpQ
         5lhLXBBlJnkdJWSsDBLEvAdIlEov2r9HJkaMB7C4yJP4LjAe64iSLxBXTjwjlSBisiJW
         w3FLkYOrGJmuR1gnuUVDJF9Qux19iu0gGh1a2bQ044OIpTvHr+cj1A6Jb/amy3jVBoJn
         vWYw==
X-Gm-Message-State: AC+VfDzatVY9ZL72Epa6h2DjLj3HGPCmL6wRVaEsqSjAprfBGHW8L/nC
        yfEK74bQ+gaF/zt3kRLldlM=
X-Google-Smtp-Source: ACHHUZ7lI8iuHKQsEsdck4SAEFHmt9QQs6haysqfy7wOJRfjq9Goxv7w27b3gm3WMVCksX2Z3AB04Q==
X-Received: by 2002:a05:620a:84c:b0:762:883a:f5a6 with SMTP id u12-20020a05620a084c00b00762883af5a6mr11201137qku.41.1687467529856;
        Thu, 22 Jun 2023 13:58:49 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:49 -0700 (PDT)
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
        Dinh Nguyen <dinguyen@kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Date:   Thu, 22 Jun 2023 13:57:38 -0700
Message-Id: <20230622205745.79707-27-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/nios2/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index ecd1657bb2ce..ce6bb8e74271 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-	do {							\
-		pgtable_pte_page_dtor(pte);			\
-		tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)					\
+	do {								\
+		pagetable_pte_dtor(page_ptdesc(pte));			\
+		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
-- 
2.40.1

