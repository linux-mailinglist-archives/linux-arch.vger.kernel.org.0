Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6864E769E6B
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 19:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGaRGt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 13:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGaRFi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 13:05:38 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E8930C4;
        Mon, 31 Jul 2023 10:04:23 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso3787280276.1;
        Mon, 31 Jul 2023 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823058; x=1691427858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=LZWvv3P5ObD312NoT3HCx6hT2mcipY2zu8mSMdCIx/PBIBw4fnj2ZRkQKvrh+bnMcb
         cAhsWuRoUJhfVjNPelqZekFAhbwYfyzvXSZQKgwb66CUaJSig1RixymjgB6EpjMZeG9i
         TPX/SETFM0d6TUT+vW8F9GlkDQXYjB62fk/7jUTcwacjm8I/TfM4mDRrCt1nWg7/91vP
         laynl0EMAor5eoXfG6EYJS8WyMBq5PEy+tqv6UFYxDYMRASimm9gjZvXzBE5l6AVAiGx
         CLfIZvVLYDlmtO9VH/rc+XPRyyAblWv0VbvnMMW+5OEC9ZkYXTzgntXD+ElukV+Op4w9
         X05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823058; x=1691427858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=HwY2hQbyor7Ze2pAqXt1sSOg4MeQBrN9K8obmgpNpKgj6+MZxY+vv9d4YCahX4KCJN
         9s7DzO1SQqYjCslT2l84w93LCzyZqVb11FJrysJkA5ITtbdTd27cZPbhHtFArT0wjlCt
         DN4cTHuuXPuqcwZFjbe9wptvnlj3ogS1gctT0ev0fQZaapM/nUpEdaIlNbEu0Xe80D+c
         fGsBGkwi5eg30QSOSy0Aac3p5OGH4z0mZD2uhClDoHx+xK53ca8U4kyzS/DSnniKD7GK
         ISSQbFOWQNQBB3aQvSCl8cJumvPZGQpqk/bnSCKw+ZHCcei61edJJ/yrMqEGhXxFlX8F
         j1KA==
X-Gm-Message-State: ABy/qLb0vSxe3FpXkf48wFdZ6dhKFqv+I8jHw5LEWzM9MRGAgZXNgrGG
        Mjzp5WxvgbSHyJ6/H1rzz98=
X-Google-Smtp-Source: APBJJlHweyU7H3TneHig7w5n/DLDjL/9e2cIxm5cNvwqW36o28cnjEbZQWmE0nZHXnpgzHbA2ayWvQ==
X-Received: by 2002:a25:acd2:0:b0:c6d:f875:520e with SMTP id x18-20020a25acd2000000b00c6df875520emr7715191ybd.49.1690823058269;
        Mon, 31 Jul 2023 10:04:18 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:17 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 20/31] hexagon: Convert __pte_free_tlb() to use ptdescs
Date:   Mon, 31 Jul 2023 10:03:21 -0700
Message-Id: <20230731170332.69404-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
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

