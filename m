Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216F06F37CC
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjEATbS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjEAT3p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:45 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF243AB6;
        Mon,  1 May 2023 12:29:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a6762fd23cso23592495ad.3;
        Mon, 01 May 2023 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969347; x=1685561347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apg836Gn0N7QExyyhUUGNgc2fd2r3iyoAghRwsUjc2o=;
        b=WbTJO1ayjn3HXL/iQMZCmT2+RnFSF2O5WG+VKbNfOxDU8NvbfSgz+Wjs4UVgNNQcMr
         uLj57ayYRa/f+rOhAVP0jHM/2f33b+TbcsUuT8OausfFIQuWjGI50HrH5E0KiKkIgQwa
         0uM85OALkALC3dGk5nJ/tYYANgKg4uu8cRvFIwQEiY4YzwHIJvVidPyhHtwxmNKQYA0W
         tAWz4vl42KgoRYKzs8w7tUocWedsU0Shw+kefBEmySvrYYB7bH8pThcvpYZ6Dpmw316z
         icjhKqrruYJxczjDCcNsGgrwDrViIcKW8h7/U3ESAg45ipYAB08luKD04Ylpo9b00Q6j
         cFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969347; x=1685561347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apg836Gn0N7QExyyhUUGNgc2fd2r3iyoAghRwsUjc2o=;
        b=EHwtXA3qFMO7SldeM0oFHlJr+HcFlfyWCLyy1WJbZJUQHDdAJnASQl68VFODqvDPiJ
         y8sWbbVUpMSagtuE+yQYodf2tusNiQyWWOU/s1SftiwAeZeLvMMYRZcLDqscynC6+r6S
         lL39orNtmi2uv4sLmMYr2DRsDr3KX8tSO4HbOtupLIVU3WPeH+otcSUwGu+iAA2QiAHu
         fxjlh8OBnpTcgKM3aiDNKe09nHP0gkXPHBT4l38L4qaJfhH0PalZFPrP02s31JFMPimc
         TWBMt4pWFBn6tU/YKA5WXvep+OiLIjlqZ83cYHCjIBldAag4eiCr7nc3kyGXPj0Gv+5U
         4T8Q==
X-Gm-Message-State: AC+VfDxscuNh0DhNnT+m9VsIozkNVPNJlThkTAr2m22iw8l4i0zYxujo
        yJOpi9nDLLlCPQLiwhIo/gBn2GIQkIsVeENZ
X-Google-Smtp-Source: ACHHUZ6JhHSCQpD21/kJ78iavglhPlPTqvuf+3JEce/L0R67tH5klQ2MwjR0kPXU/JMC0Y1BeGjoZA==
X-Received: by 2002:a17:902:c94b:b0:1a8:626:6d9d with SMTP id i11-20020a170902c94b00b001a806266d9dmr19271440pla.62.1682969347146;
        Mon, 01 May 2023 12:29:07 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:06 -0700 (PDT)
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
Subject: [PATCH v2 23/34] hexagon: Convert __pte_free_tlb() to use ptdescs
Date:   Mon,  1 May 2023 12:28:18 -0700
Message-Id: <20230501192829.17086-24-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
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
 arch/hexagon/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index f0c47e6a7427..0f8432430e68 100644
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
+	ptdesc_pte_dtor((page_ptdesc(pte)));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.39.2

