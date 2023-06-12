Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A2672D2D7
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 23:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbjFLVJN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 17:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbjFLVIX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 17:08:23 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B553420E;
        Mon, 12 Jun 2023 14:05:48 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-56d304ef801so13961047b3.0;
        Mon, 12 Jun 2023 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603947; x=1689195947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSn6cSkj4IeRf8/BsqHClLl3fDsZeC4rpAPYblqUB6Q=;
        b=ciZzI2nnG7zqntS0kYws3Bstzr3nXcXM7AVbRLfJcQTue8B9i+jyLvzKLDy2A9P30Z
         c8kXhocxLYHnQ/QqwZQBscO/Jnyd5DcosG/E4dwS3uAecJsY0Ja9Z3xqw7MsgC6nHjA4
         QA0ciLqLZYMqWOytaJmxjnukXuzthDnZTPicAtRgEtVTuV0GYf1zJiBPTow39XMnG090
         B3bVtajux9wQLuem4VZP38wdaF1Bx4OpAJ5RgPldzLuFMNXFpzdfCqZWClGqvnQMYt00
         /HHhjhqAxABJiO4Fj5XqD6Wx6l8ZOt09hebTgkaibUDXMgVCd7dGCAjsjguwOTWs8p4I
         GZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603947; x=1689195947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSn6cSkj4IeRf8/BsqHClLl3fDsZeC4rpAPYblqUB6Q=;
        b=OuUcCKmBJ7epHYe5GzP1Och8ZFCOmCqNstNJHZdpfAdQth7tIsrxNgtRvugOElC44k
         zyuZQm0vHZ8FwqdTtQyZqDbbqHoCRnKLxuRXa8azphslJi0f37mJWY8Zp4MYxiR7n7wx
         GMoS0xBD4HBo2CzwenHZbBZBOjquc33TZAH+Xc/+wh1l5jCTqIWJ0+0KiH3ed4VRmK6Y
         Kc0aQwNEuy0EY6MDb9lgRS77mZBaRt4S6MwQ5efioUzWfKiQyT1ZXfhwEBiHD/tM2C2y
         t0VSr0xxKg2wIHgc3SABXFJ7U9bLDLowi6lk3jsDcNQmKCy3MYwW44SvvccrUXxr3hMu
         7Wag==
X-Gm-Message-State: AC+VfDzA3YhGPOVce83TT0RzuWIJY4BBLpek9GExhKPXv7GREcNrWEDH
        2N61kWavWTOzP8d4LkSd10o=
X-Google-Smtp-Source: ACHHUZ51WXkZSpSQz/Euz4h9t2P7hzzB/r3I54c+WRfw9gtRQcMJQg//XHj3D4qG81G3nuV3fW1fKw==
X-Received: by 2002:a81:49c7:0:b0:56d:540b:ed07 with SMTP id w190-20020a8149c7000000b0056d540bed07mr513566ywa.48.1686603947200;
        Mon, 12 Jun 2023 14:05:47 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:46 -0700 (PDT)
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH v4 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date:   Mon, 12 Jun 2023 14:04:19 -0700
Message-Id: <20230612210423.18611-31-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
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
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sh/include/asm/pgalloc.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index a9e98233c4d4..5d8577ab1591 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_SH_PGALLOC_H
 #define __ASM_SH_PGALLOC_H
 
+#include <linux/mm.h>
 #include <asm/page.h>
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
@@ -31,10 +32,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
 
-#define __pte_free_tlb(tlb,pte,addr)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
-- 
2.40.1

