Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97917DD984
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 01:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345021AbjKAATN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Oct 2023 20:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjKAATM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Oct 2023 20:19:12 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA84F4
        for <linux-arch@vger.kernel.org>; Tue, 31 Oct 2023 17:19:10 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b4145e887bso3372461b6e.3
        for <linux-arch@vger.kernel.org>; Tue, 31 Oct 2023 17:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698797950; x=1699402750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQdBfGrxgT0Dp0rMc/ALsHZTaxuvWcxH/0MUqWK8IuU=;
        b=lHahO2sbfNBOA8ej35WphXmr1UmF+eEj5loUBcT0VNfxHWgJe3P5Yfkf+9H3U4A72U
         dXO+Q+ho5u0Ckul022CtSXnTqmOT2uZP6c4Nf/cGJXY+JBImtkvexciVRzPwesW0mFkT
         AYqqmpAUgDxqCBFk3cl+ltHghe2+v4C4Anbeof8maMkPnDQ/vDz2kwr3ef8KQeh6sp4f
         MjYotKiWTYASG4xGp3YJBSqWL78X6uOGMA+xgR/Pt3WCkb4Y4VLVA0ZqCgF8KDymnaUy
         J3Ng9xyA2t6U3ZksCwZqYyIukP7mClhMwkbwsI4icJYJBVWAVr2mclucBPpmhiyjh/ZS
         G12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698797950; x=1699402750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQdBfGrxgT0Dp0rMc/ALsHZTaxuvWcxH/0MUqWK8IuU=;
        b=Ye95YaIW3V7iEcjcs2r8pZw8YTFkISbEwuUbIJgyRSOvlp6xqOpcWdHLh5/mqIaLJd
         04KPszD6NRHsdjw385wZ6EK/IBaJfjNa51CvaVAK8e7D+VgdLeqq/23eagGesQc7gtdh
         dJyVc4JvqhbqQRmui8VTJEeWa7uf2a52g81UE8ac+gMxptzhF3sThaZFC3rnIf9Tuxk5
         s+5j4JvboN5qzH4XtUmW66EU7KqvhQmb7w/2TKXNq3bLUdnnxtG3GKQgjODfZqH7pXTc
         k6F8tMwzV0W1oikwNWu/OQ7l4Xjukl8+EIYczpbQjPDBafYG+NBhBa3z/wfZfJb/Kiyf
         MuVA==
X-Gm-Message-State: AOJu0YyGUqkUoyuY6+zNljZiHzSrP97KXIMGQRPayLFMrq0tSmqP3msH
        Vo2/d7oWDi33KOQTgc0vi8XiTQ==
X-Google-Smtp-Source: AGHT+IFAGiF6OUNLlCeNgyvY/i4c514KoOHClaYHS52YeQ3nA387majS+P1AJ+bMd1hGXTtmOTGzFg==
X-Received: by 2002:a05:6808:9b6:b0:3b2:ef9c:d1b1 with SMTP id e22-20020a05680809b600b003b2ef9cd1b1mr13418380oig.6.1698797949914;
        Tue, 31 Oct 2023 17:19:09 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n21-20020aca2415000000b003af638fd8e4sm65309oic.55.2023.10.31.17.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:19:09 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 31 Oct 2023 17:18:51 -0700
Subject: [PATCH v9 1/5] asm-generic: Improve csum_fold
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-optimize_checksum-v9-1-ea018e69b229@rivosinc.com>
References: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
In-Reply-To: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <david.laight@aculab.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This csum_fold implementation introduced into arch/arc by Vineet Gupta
is better than the default implementation on at least arc, x86, and
riscv. Using GCC trunk and compiling non-inlined version, this
implementation has 41.6667%, 25% fewer instructions on riscv64, x86-64
respectively with -O3 optimization. Most implmentations override this
default in asm, but this should be more performant than all of those
other implementations except for arm which has barrel shifting and
sparc32 which has a carry flag.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: David Laight <david.laight@aculab.com>
---
 include/asm-generic/checksum.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index 43e18db89c14..ad928cce268b 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_GENERIC_CHECKSUM_H
 #define __ASM_GENERIC_CHECKSUM_H
 
+#include <linux/bitops.h>
+
 /*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
@@ -31,9 +33,7 @@ extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
 static inline __sum16 csum_fold(__wsum csum)
 {
 	u32 sum = (__force u32)csum;
-	sum = (sum & 0xffff) + (sum >> 16);
-	sum = (sum & 0xffff) + (sum >> 16);
-	return (__force __sum16)~sum;
+	return (__force __sum16)((~sum - ror32(sum, 16)) >> 16);
 }
 #endif
 

-- 
2.34.1

