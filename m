Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBED6773442
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjHGXIj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjHGXHM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:07:12 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322802106;
        Mon,  7 Aug 2023 16:06:20 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a3efee1d44so3967808b6e.3;
        Mon, 07 Aug 2023 16:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449570; x=1692054370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XaHpTf3P/utbT17OPG/H5MolPsiYyRMVXSdV5AvoHU=;
        b=GmyaVrawFabDS7oM/FJ2wsqOTnvNiSZkWHllyllBSGtBhNSpEmhqjU2xmr+48gvMwO
         LUXnCk58UhmfTImv2R4R9LNF0+WlzxXIVQ4Y7ZC5fEeHoGrn0o/ogRSADB0Y+NluFrtN
         MrrlZ4Lz/gi5878wRIWP06wgFFKVx+8i+ghKFpBHekPx9T0p+3sqj2xh34rznNB4nw+U
         O7FH+uzt41O2vvO9FAauF/idvM9r4rw7Q35Wwsa8GbYTT2MLxcQcKcfZ8291m/c55wrV
         URc64VPnBpaXKs/Bni+oDqsCjGnYy/ppZbjbVbnispVrc0PlqosfX2g85SuErvT0W1h1
         o3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449570; x=1692054370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XaHpTf3P/utbT17OPG/H5MolPsiYyRMVXSdV5AvoHU=;
        b=jc9rf8b/akZq12I/xiR2SIzyWPySDNIp71f5Zv+iMrmipxizhqUbxjIAPBKtdixqc3
         dC3JaKvQQXQmS51aEKaat75KYVU9XPDBUxU4XXYnGnVJ6464mqNfZ/pJgWsBsca9g0B4
         fwUcNml5MppLzmYvpS21ScXr96b3lXZM33i15sf/0lwpYiTBXeF9Yu8fgPpGvItErBu8
         9D8uGtTReFRmItTeZfx2QhX6lqFrWbzd1gKZqCeUVHEpFv029B30ZQ/3UgDuR0qoasRU
         SOMor38GrJIhbxx97Aixl84EAo7hmAa3FxyFamqBQI3wTDKHEy513wxJsE8oi/Eg3SOb
         qgXw==
X-Gm-Message-State: AOJu0YwpckU4zAwiQAaKKSPsf73Wp3JL+HuawYitxa+BeK9pPF15caLr
        BsdY2xafKQaoxcjAioaamqM=
X-Google-Smtp-Source: AGHT+IFfR71b5uGC/N7nUJvkV7EEf+q4ZrD/2jbgt4p5+XAZUesJuHroaMR2T6Qu+08oLKK4OIq5Tg==
X-Received: by 2002:a05:6808:1997:b0:3a7:5314:e55e with SMTP id bj23-20020a056808199700b003a75314e55emr14747526oib.24.1691449569767;
        Mon, 07 Aug 2023 16:06:09 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:06:09 -0700 (PDT)
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
        Jonas Bonn <jonas@southpole.se>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v9 25/31] openrisc: Convert __pte_free_tlb() to use ptdescs
Date:   Mon,  7 Aug 2023 16:05:07 -0700
Message-Id: <20230807230513.102486-26-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/openrisc/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index b7b2b8d16fad..c6a73772a546 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -66,10 +66,10 @@ extern inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)	\
-do {					\
-	pgtable_pte_page_dtor(pte);	\
-	tlb_remove_page((tlb), (pte));	\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.40.1

