Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B8B760807
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jul 2023 06:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjGYEZG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jul 2023 00:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGYEXy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 00:23:54 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C646C2D71;
        Mon, 24 Jul 2023 21:21:52 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d066d72eb12so4536320276.1;
        Mon, 24 Jul 2023 21:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258910; x=1690863710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=f6oxEdexqW7t8O18O1zlBzEMy1/ySz1lSWwZIgvC+6ZdC+AQVNOOjrUGsL3n8z9yLs
         jC/oIvWOegKfTXKYCqEjhGYC8DO1R1+qqiiOoaRmFe+GV40qDgP7vCBrkhQ8/QoelGjZ
         6zYUNV4SeVX24QIWi1/OsGEJx1KydkZGoq9ape10nJTNyMWr+pQqOvmxVzCb+3U9sgmC
         ze1LeRMHMeTo2LxUzcGxr55PmnWGKX2eITQpSi6L0WDbS9ycLs9Jos/2PAo+dLuVd9aS
         LiJCpXRUIDud7YKdN1pv+EIwqPuZ42v47LQ3yS2kQDdlx8gJ3/GU5UxByOmc+boocCVB
         ZyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258910; x=1690863710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=gA8eOfxwhnCsQB085B9TWSxBBQArZMoXI8c6F90hIa1MwkUxc5XcZjyn8S7vBTm8Ws
         QgKf5z5Csr6N8BFZ4FD/l9ZXGdwVSiU6us3ONAczfFkP6knsRHIUD25B+dJbs0BegQDx
         ub7fAJBYcallVHmN+pM9N9rmG+W0nIw6ZiEvj2dXnu9rnDUbSV7o91g28qJy1FCrEjsd
         gBYyKXKpdtfxb2GaSwCG7hPCOPFItZfuXX4XHdYOokXVomO/IhWdIMFZaT6PC3qPuJrs
         t4XXo0UTxx6x6svwzWX65Ze9yFmRoVmKaR9Mc7nNfR4HKyOcc1xU7hhiRO44/i49ElHV
         TGcQ==
X-Gm-Message-State: ABy/qLYAd176upI/3DPVh+v383ra+5wF7IerPJujY+wlQzvBECKcHASQ
        9YC28RA0U13Cqkf1BEHxvYegR1GANTtwJg==
X-Google-Smtp-Source: APBJJlE5+Qlh5eptk2IDiumLzwzdgKuW8E4L+dGkDhCtXpTjXCpZJt13f1YzsO4C3URc73BGKhlHpg==
X-Received: by 2002:a25:6814:0:b0:d0a:3876:a22a with SMTP id d20-20020a256814000000b00d0a3876a22amr1377987ybc.4.1690258909714;
        Mon, 24 Jul 2023 21:21:49 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:49 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 20/31] hexagon: Convert __pte_free_tlb() to use ptdescs
Date:   Mon, 24 Jul 2023 21:20:40 -0700
Message-Id: <20230725042051.36691-21-vishal.moola@gmail.com>
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

