Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E0D73F212
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjF0DTc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjF0DSP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:18:15 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E11B2D4A;
        Mon, 26 Jun 2023 20:15:55 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5701e8f2b79so43163497b3.0;
        Mon, 26 Jun 2023 20:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835754; x=1690427754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=m20u0ufiAKGaCJ1eF+oXsWKBIRL5JTjyvtae8lqFZvtXfIrM7cJtjjAu/m4Uz73Z8l
         2OzyWyLCkpN3ueHXh3OYTXgBp8fMDOqyT852NuEeBcWkgEMJmVKnx3KmXsByRx3AKFHF
         Vg5wuji9LMQRgJRH1HqmX3jxPY497r0xZlE76FEouiAeDZpP9QjhFrAgiTXpIz8r0/Pn
         raAur9OcS2AWjvRxW5kW7BBQEK8M8XOe3JN2fYON+zb1b/iUEGPKmhswAXipr/RMjiJ1
         5Ou/YPdkNRNCdvvgrCiDyHNc6JnGXPl8TTudPcGz7r3XrC0of8M4idYi+6qLUVc137gj
         TxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835754; x=1690427754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=BqyTBxtu2b2xQhMX7w10GAFQodT22G1K1yb7N3X/SU2Ldn/tHRw/7APHY2sUcP6oFc
         szCgTkHjNaIkwlPJiUvW1lXbM3vYCmLb223XKs+YBEIAmzVtoI1yRlnl1jbATH1PbmJH
         GxdPavOM4oLBGnRcYCs3LQiTuOhh/CSgO0Us7DYwxRAanyWGAWq2UAyWj1Dfg4Hj+K48
         8XrikVvmO7PBBzvK73lDKGlPJ3CzDAcUGRyUyXkMNDMNX7XlPJHArsJem48m6hw/SZap
         qvALyBob/n+RI3B1wgKAXLT4rwb6XmOQI3wLUz+xiqW1xCrspmikxYrCkMEZOo0E85Yd
         quTg==
X-Gm-Message-State: AC+VfDwboR3spZ1lH1dh/wBpLg4vdfDUDhFChAy6Y6965Y64DcNvwuOa
        hSl6QqlhVIFd6KUBhpzGnrI=
X-Google-Smtp-Source: ACHHUZ5MOzNqvj1LDJTcnkC+L2S0i67qvPaFwWjlYeZ+6A+ljBIE978bk3O2AZxZRJ0D8kmPxN2z/Q==
X-Received: by 2002:a81:7189:0:b0:56f:ecdd:ded7 with SMTP id m131-20020a817189000000b0056fecddded7mr30983642ywc.10.1687835754377;
        Mon, 26 Jun 2023 20:15:54 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:54 -0700 (PDT)
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
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 22/33] hexagon: Convert __pte_free_tlb() to use ptdescs
Date:   Mon, 26 Jun 2023 20:14:20 -0700
Message-Id: <20230627031431.29653-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
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

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/hexagon/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index f0c47e6a7427..55988625e6fb 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -87,10 +87,10 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 		max_kernel_seg = pmdindex;
 }
 
-#define __pte_free_tlb(tlb, pte, addr)		\
-do {						\
-	pgtable_pte_page_dtor((pte));		\
-	tlb_remove_page((tlb), (pte));		\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor((page_ptdesc(pte)));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.40.1

