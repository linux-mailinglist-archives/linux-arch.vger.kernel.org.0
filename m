Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741F7718CE4
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjEaVem (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjEaVdw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:33:52 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A466CE4A;
        Wed, 31 May 2023 14:32:41 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-565ba6aee5fso826257b3.1;
        Wed, 31 May 2023 14:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568725; x=1688160725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1x1J4vur13K6ienQiLVxExje9aLbKUsjVFvIhcqO10=;
        b=R4JOyFF5oGis8NxGU8pSpePc9JPXMsijgUHIihoBFDMX7vxfyfSgK9gS7L9vsvgMnj
         MoFYSUO2hucvt6EXtvpP7cclM0FlcdhnlFMXLdspy+TrRtUW4byNtMBbPaBMOtheTLzo
         JyXpw6dclXVn5TBmIUwO4ll+Dwj2sxioBm1tcLfW7tR6/lFa3tmkjwZ+b2UxBU9kd/xU
         9674/17mKjyw9zKVkY7JTqJdm8j6Ukk6MApKOQVf0MMoClbBMESl6AhiCYUKK1tGclZh
         a/IF0OWr+we0YPVHDLrOdoGrQ5ob2G14WJkmdrRtqm2pP0cB8C0ATsRWLlC+f5L22Z3U
         c7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568725; x=1688160725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1x1J4vur13K6ienQiLVxExje9aLbKUsjVFvIhcqO10=;
        b=QZHWN0fi4WZraXmjC6+n7A9ya84dXcAaHJsMdCNPRj0YK2WrvqCjg5OJw51+xupYe1
         IvEYBTsrAHKR1+t47zXQph6VL+a/C6pXuf5sPa6K+6uErR5c9M3vNWYEAUUM57OsVAi5
         xM9eFu8GAO5P4nrhUjrUsa5qgkF9g9Q1b8DoeE2oszTvfmnzrwjm2vP/yXIKxFa3jhma
         DEzCnQdyUGD85yPGJKpGFGqHPXHtgmEPUK/baaDFJjHgppvNodnAxoDmlppGfNCG3Wxs
         fUdPJQLax1Axeaj2ROuvzumltn+H1kNjtY/MMbQLYJ+5aWUxOYhMwLrUX/dE9OhTkFNY
         TwdQ==
X-Gm-Message-State: AC+VfDyKWVjdvhJnZs36CYUFPmTWuc6GzsXZ8wRyyki+rHeyxJFjLVp5
        fCr5LPmkV9k9wl7Ob2XEg38=
X-Google-Smtp-Source: ACHHUZ7OmIDubddXjmsfBoe/XagN9Nq+I2v1lq5kjayLp/xLt6wDO/g4P/XIV7x6OHxU5ctdplxcBg==
X-Received: by 2002:a81:d246:0:b0:565:9d27:c5e0 with SMTP id m6-20020a81d246000000b005659d27c5e0mr8010590ywl.2.1685568724694;
        Wed, 31 May 2023 14:32:04 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:32:04 -0700 (PDT)
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
Subject: [PATCH v3 28/34] openrisc: Convert __pte_free_tlb() to use ptdescs
Date:   Wed, 31 May 2023 14:30:26 -0700
Message-Id: <20230531213032.25338-29-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
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

