Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEFC6F37E6
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjEATbZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbjEAT3r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:47 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792822D59;
        Mon,  1 May 2023 12:29:26 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52863157da6so1840689a12.0;
        Mon, 01 May 2023 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969355; x=1685561355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2PCFvKq9JWcIC4Exd9oDYO0v0PQOHyXRap+yEgbOb4=;
        b=pbOgq641Q1VbKkWYpSKEOBTaJbK7N+gn3tPQxAnQMHVxsbuYS7d6gCFZWWRyAoJPvd
         QWBoalX7ztTkXy1/S77S44wUsaYiw+c9l0pjoAvj83RwanS2FHVDTD9b5yLt3dvSiRkC
         Y6FbuRkXeTez8mU8JwqFdJ8q3udPbLVyCGPniHNdmE3Bvis2G1N5Cf54GBHK19m19dh2
         ECy1qDfhwNI4K2KlZeZKdUsb//pSuTNjtcr9BAZz+ZE7jjtZb0g8W7o+eLshkW2fWRhk
         rjbBHucvZ06kdc4e0Uijz1mCvV4V1RY1P7Hdmh8XbAUQYZvgzIuSpNmzClPaEZvw/eBL
         VKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969355; x=1685561355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2PCFvKq9JWcIC4Exd9oDYO0v0PQOHyXRap+yEgbOb4=;
        b=fyAAhXaOAe1gvMTWQpiwDnvLL8h6289iUK4tLshT1h8UB5HVgDYywEFzGTjv+0XDY4
         fEL3vfFlo4buD0dN6BcJ0zwmqw2AuSO5Ewsq8NybILfqKtND/DqlDgh53xBlvIGfuqPf
         cbujHb9fuR9RZKqI4IjygUXatGLWLTSNFIp5aaqPwcAEoi+8gR4s3IvZxtwbnHVna5JR
         XCjgaEgjM7q5BfoiKeHxBvhcKqIuwZHnDaV9X3C6ZS7CZG5rQhF3gEvn3s7e8Je6ULAK
         +JsoCFfTg8EgqkJQVWFLhujeoR7w9nUp8yc5c59rKxz8hwZzvEgpoNEBGOX8PfO2FwRX
         cqSA==
X-Gm-Message-State: AC+VfDzsQjpPoZQrQQrhsktbjRK/mRvkaJIZRYvIagcnzyIFZC4NFAvs
        7647XARGKyHqI2Oiz6w8xkQ=
X-Google-Smtp-Source: ACHHUZ5aUwQpmXFq62IOwkeTiJiFUSz6Wt9PaXTxNdRH/kylJwLUJvf08r71LifeGRMo3EYnyRIKBw==
X-Received: by 2002:a17:902:dacb:b0:1a8:d7a:9255 with SMTP id q11-20020a170902dacb00b001a80d7a9255mr17869996plx.54.1682969355424;
        Mon, 01 May 2023 12:29:15 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:15 -0700 (PDT)
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
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Jonas Bonn <jonas@southpole.se>
Subject: [PATCH v2 28/34] openrisc: Convert __pte_free_tlb() to use ptdescs
Date:   Mon,  1 May 2023 12:28:23 -0700
Message-Id: <20230501192829.17086-29-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
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
---
 arch/openrisc/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index b7b2b8d16fad..14e641686281 100644
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
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.39.2

