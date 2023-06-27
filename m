Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6973F207
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjF0DT1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjF0DSO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:18:14 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608852972;
        Mon, 26 Jun 2023 20:15:53 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5769e6a6818so30021607b3.1;
        Mon, 26 Jun 2023 20:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835752; x=1690427752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CuYJ7liBLmFxtlpmCAIL/qtog0vkZLk1dVk72P32nA=;
        b=Z2y492L3/D8WlJ5Hq0dqKp0BKJYUW7Eb9G7qdf3vIGRQ+O8SF6z7cY8de1pnrMmDqQ
         +a96x8kX3opEhwfyHnlNFTWX5OwZauzWBj6C4ouPJiZfrfA0EmnR4gOkOWCXT0Tt5rk7
         XHfLS6CI7/qHcQlfDrYckrQudKqfd53TugdHSOAC54JEXTOgwU9ogsxc/TSIilUUybaL
         /EAuzpcVE6dEZDr0iMV3l0ZL5CrHH5SQ2tSWsVIXTRE6S7JRWuiJGvbxR8kbv1x+D3dj
         SKo4oZP9xKp5iaeAAmMvP/qF+1bKjojF2HvsjQLLw57QGCxHLxvjF/rVFYkYGLWd7pTO
         F1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835752; x=1690427752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CuYJ7liBLmFxtlpmCAIL/qtog0vkZLk1dVk72P32nA=;
        b=NVg8NzAuVeJn2DZVdMiKsEyLYUaXI6eW8+jXbaMcMZ6fhKIuNGuiYef6BB51xzZkxa
         EN9YrZpX4ouQQ6dKsMRUxVjo3YkV8ClRvwORqS6IgAhfJ/JNSdnkyoMm+UrfdWQYJyP4
         UvSp5In31g9NRVO1z4GESC31L1sqiUVQkAJrgwSGDFTZF4H/4Q+uN1NPFKPx76LH2KE2
         TR0kA5X6HTUSvml+OGpxauhvhzxCrMwY96Gdt/KUl0RBRYEIZC2JwAJKaP6L4axd33Jj
         9D7Px/8jUnyTuyyAdcfSnoKDycuDV0qqD0mlHz3qYu/87KV0/Eho/DKxEQ87Qptj4np0
         4CwQ==
X-Gm-Message-State: AC+VfDwZTHNyxOQx5t4c02W5GgCUyfWT3q5nCrnewnyfrcnxnTm0pX1p
        BDPs0A9z7dXz77NoA7qw3pM=
X-Google-Smtp-Source: ACHHUZ5CQK8kRHJUPJM2uDCPFRj7p03JLp7keUZBkce6O+8d/iMl0gg4/oyJxvTRdTEHePf390CKKQ==
X-Received: by 2002:a81:4689:0:b0:573:9751:ad15 with SMTP id t131-20020a814689000000b005739751ad15mr18645821ywa.17.1687835752283;
        Mon, 26 Jun 2023 20:15:52 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:52 -0700 (PDT)
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
        Guo Ren <guoren@kernel.org>, Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 21/33] csky: Convert __pte_free_tlb() to use ptdescs
Date:   Mon, 26 Jun 2023 20:14:19 -0700
Message-Id: <20230627031431.29653-22-vishal.moola@gmail.com>
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
Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/csky/include/asm/pgalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index 7d57e5da0914..9c84c9012e53 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -63,8 +63,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #define __pte_free_tlb(tlb, pte, address)		\
 do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page(tlb, pte);			\
+	pagetable_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
 } while (0)
 
 extern void pagetable_init(void);
-- 
2.40.1

