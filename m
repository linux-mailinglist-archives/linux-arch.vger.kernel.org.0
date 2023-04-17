Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCF76E52E9
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjDQUyA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjDQUx2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA3B3;
        Mon, 17 Apr 2023 13:53:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s23-20020a17090aba1700b00247a8f0dd50so3410938pjr.1;
        Mon, 17 Apr 2023 13:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764794; x=1684356794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WInZHFLF0E37CPvH/fyQuQmpONrFi7mPGahLu3Z9gNY=;
        b=Xg6P0UpaqLjmTr9GC8q8FEqPaWuvWAOVoK//8dKOM2wu82xE/PCXSYeAATRXUJ/HKh
         6EEKIr46u43LbmKVnfil2W4E6LUnTir89HhCdDllvASzF+yevHo7MjwPE9+XRv+3hhES
         OUUsnstcNrA0rLCFMYj7vWl5ZczSf3KPYpA7wTt20fxP/HKu0nYQRIzVhW6nrnGOA5jn
         ZX8zcSMK8Y+FlG/fX2gye51alnw5R0vQJIqmi3wnRTlMtqWonWHxJepWd7O0uYkErLAf
         nElaONPL6snfMupRjx7SgoPL0fo06TUuoxc3sYPVOppMWFUfAwgvDIOHO8Ugh+LFqXUj
         IYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764794; x=1684356794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WInZHFLF0E37CPvH/fyQuQmpONrFi7mPGahLu3Z9gNY=;
        b=J4otx3qQJMJ25H8RdsuvhMnLi470EYmeDdo4BA53KYqgAc/g1h4fuEgq57Pr7o9Mrs
         inPUKaudhYvcw93mZb7JjSa0NvLiSm9/aD6fPxWP/ChiElI3ilqADwISZj54tROEWYWF
         NZ7xp+1s3gthZdCaPKJxYQ4ocihqzgOMJzv/Iy2VreXUNKaY+ahdFH0iJWVEhrgTVfgI
         D1B6RICbwRoceF3jg7/vKpyqA7+IaHpbVR6VpHtRr4dHiXFHS4h469mlBejUiZpkA2XH
         pmFcueeEGMGt6lmmn2WiuEsJjQVH+suK//GHVDGLMV44NdWe2Jazh42OCGYmrLi7eHep
         Ts+w==
X-Gm-Message-State: AAQBX9dSSQH40Q0Q3S3h5PP+Srr7uFxV95TWXnhgs+jDE3029oEuskWL
        rFPxh0O5Xa6IszN095OKhYrSUxs62evLxw==
X-Google-Smtp-Source: AKy350Ym3GSROxWd30N3vnOcQ+scJJk4j2bn57g6f2y/wdjBz5ko3J6EyTomKSlBO1Xk2XiBoSAe7w==
X-Received: by 2002:a17:90a:5315:b0:23f:81c0:eadd with SMTP id x21-20020a17090a531500b0023f81c0eaddmr15717621pjh.47.1681764794292;
        Mon, 17 Apr 2023 13:53:14 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:14 -0700 (PDT)
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
        kvm@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 21/33] csky: Convert __pte_free_tlb() to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:36 -0700
Message-Id: <20230417205048.15870-22-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
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
---
 arch/csky/include/asm/pgalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index 7d57e5da0914..af26f1191b43 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -63,8 +63,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #define __pte_free_tlb(tlb, pte, address)		\
 do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page(tlb, pte);			\
+	ptdesc_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
 } while (0)
 
 extern void pagetable_init(void);
-- 
2.39.2

