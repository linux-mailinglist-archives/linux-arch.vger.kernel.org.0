Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67F773F287
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjF0DUr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjF0DTZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:19:25 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C492D7B;
        Mon, 26 Jun 2023 20:16:14 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5704fce0f23so42038307b3.3;
        Mon, 26 Jun 2023 20:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835765; x=1690427765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AnRv7d38hHUVaoAGins0CaWMMRgzo0GwUb20Y9YoSw=;
        b=e60Y6sevaT4oQ/L5KuHLcNtraCcaqymJSw0Pta6sshcpf6ZZ6QManSmR0ZQpDOB1TG
         Zv6Fux3N6RAGTYaqlaV6L/vXV7y5TNrp+A8hP8/1TroaBlBjnjU2829v3J+cnc+AhOb5
         JN+Np+61YaCNuusYO6cIWgMGGdhyo7H5wD/egNG2vy+zzD2dD0OPETzsjKXbKfq9Y/2e
         UqWfUGJ07+JZFMPC47CCL6nCuIIVod63+MvhTRgj6G4ml0xqLiHcn4xnMK5EG5kSpCpR
         IaKEXBQ7G4bgWt8P3QrMWU+dPATv19IcGEhHsTfe2EI7sEKEiwRzexwBCQnzrxDWjBM/
         K5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835765; x=1690427765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AnRv7d38hHUVaoAGins0CaWMMRgzo0GwUb20Y9YoSw=;
        b=gQA1VN7r9S7oEEcSJxS7So1VfIgUtLtaMdjpaHbH4Q+WP9nrUO3sX9orpiYjcWOsXA
         0qqiq+rZ1BI2hDVVovxV8neXJLpHpMm5ZJc7/SSaOzEBYNEUZKxqWKfROuG32AZnbE1Z
         KXh2Rtqjjv+D9bdvFBU9K+iXLMrnbVLHI2JXro1sFZcWH5AbGX5ENaFTLgqnhXnzxHGu
         zf5KilI4taVbDZYLHqtFRqofjp3TY8o7AxMeNM+yvAZD71DpEM/AwiO64QVrznn03QcH
         ZBEkzy8RBR1XCBXLxfEtih4/SfWIp/4owAZea/PhQ9JSWYtH/U1t64zlzT8obaInePnE
         f5jA==
X-Gm-Message-State: AC+VfDytymZ5godIfpnX7ZadzkELU2HhjKSZfGRfTCoYCOXAaivmpLGz
        VQn15WwFgNjYJtGeSxSdUpg=
X-Google-Smtp-Source: ACHHUZ5DGQdkUnjmZtvUypsIHEbjelQEN0sIFmuzviWoifvHBxszYaVoeD06anXcP6T6X+bEflb+Ug==
X-Received: by 2002:a0d:fb86:0:b0:573:5071:2a12 with SMTP id l128-20020a0dfb86000000b0057350712a12mr24368068ywf.18.1687835764817;
        Mon, 26 Jun 2023 20:16:04 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:16:04 -0700 (PDT)
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
Subject: [PATCH v6 27/33] openrisc: Convert __pte_free_tlb() to use ptdescs
Date:   Mon, 26 Jun 2023 20:14:25 -0700
Message-Id: <20230627031431.29653-28-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
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

