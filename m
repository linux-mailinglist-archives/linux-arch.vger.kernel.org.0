Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737E3760824
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jul 2023 06:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjGYEZX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jul 2023 00:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjGYEYP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 00:24:15 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2901BC2;
        Mon, 24 Jul 2023 21:21:59 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d0b597e7ac1so2718161276.1;
        Mon, 24 Jul 2023 21:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258918; x=1690863718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOzSOLTncjJXn0AvJQqE6PD7zrtBe8MIuyz5zw7TzDY=;
        b=dhPD8MhdzMmnO7UJpDnYU2UUndnCrctJzCVX4h8RxV/2AqAGAmNSSgBAimCgoOXbFI
         jwqB3InLHcwQnBW7LGy3zNpfxtaFx0sRNMrc2BW/oP9Y9sT30Imc49n106obHaMafKD9
         3iENsXyRilYTy2IVeIDj7UinpA3gJg4m95b/YmknsgUr223VL5cVJ4//6IC3DQ94xugG
         7BqjgjAuhv+rjaUhUgEIiEByqDs5npSuOOnKXGMd/lRwDVio+iIe4ROtQu1UVk7GVi+q
         O8m155eNSAMp9dX3vcmdIfcwnE6nUvi43OowEy4OezSv6ZkWZbIGQtYJYSHuCGDVV+u2
         iZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258918; x=1690863718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOzSOLTncjJXn0AvJQqE6PD7zrtBe8MIuyz5zw7TzDY=;
        b=EaJgQmVpXj/o2CYiHMkNoThLWxuihLFTZEO9WqZ5fGgHsQqMBpZM2LogIhWJ73NV+6
         3KLluBrVr/WJxDQhW/vf2jNJ0ZUuBsEPXZMtJl4RsSdH+rdcUdOJBHjCgci7PClxY056
         yNe/5iS656pBkx/9hEK+CSyDlHc2Gjd4lJ0cz1mH15AbJ+UPmWc7TQNTU6xz34Bv5vzW
         3br9Ob7wyNG2gQDFxD83eYz5mOQpcIkiWOuURO9VtoiQ24hYgSd1KNyLD5EslDSA01SF
         /CMK3y3HaCH2JG/cXgYHCretS1kbQlsNVH5sLsEGpJo7eX8QEm7Zt19uNIH/4ozR8Tkm
         uvyw==
X-Gm-Message-State: ABy/qLb3jBVUYnJu+/X1/BxeGxjRhenGncg01oaJ1MGqRPP0Pdw5g/Jg
        /MXz8H/wSo1tDekfsocVoG4=
X-Google-Smtp-Source: APBJJlGh3t71iGxZySWvCqAB9/DfGs5U66hmdz8Mr8qCsALi+Mic17AL5W5IK2UTO7itITs/+4o4Zw==
X-Received: by 2002:a25:ced0:0:b0:d13:e334:241b with SMTP id x199-20020a25ced0000000b00d13e334241bmr2805085ybe.21.1690258918114;
        Mon, 24 Jul 2023 21:21:58 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:57 -0700 (PDT)
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
        Mike Rapoport <rppt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH mm-unstable v7 24/31] nios2: Convert __pte_free_tlb() to use ptdescs
Date:   Mon, 24 Jul 2023 21:20:44 -0700
Message-Id: <20230725042051.36691-25-vishal.moola@gmail.com>
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

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
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

