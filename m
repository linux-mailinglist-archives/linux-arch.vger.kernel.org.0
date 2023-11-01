Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616477DE844
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 23:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346194AbjKAWsT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 18:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346547AbjKAWsS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 18:48:18 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D10137
        for <linux-arch@vger.kernel.org>; Wed,  1 Nov 2023 15:48:15 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b565722c0eso196808b6e.2
        for <linux-arch@vger.kernel.org>; Wed, 01 Nov 2023 15:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698878895; x=1699483695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQdBfGrxgT0Dp0rMc/ALsHZTaxuvWcxH/0MUqWK8IuU=;
        b=Q8NpzZsnzm+e7dGuWHEv3MoqJEjTrDteUl3eUVNlhKi8B3WmLYjcuEydrzmLJ/g8M/
         vT/4V4GrYph93j2U9ZklIP4fGvcJtroRnvqMiqPwtUIy7uKACxtWCroFXEHQUmnkB4Jp
         IfMPxIMZ7Gb5roBXLO9w/gUu/p3JCkExaZKLgVvXxVC8F2zf8/bX7/YlwLdSeGY1/sPY
         5WDsXdUwLX4xY0f3kiYecwpu/zpofU9QF4R8CrMnc54KWp9qAy1FFQUqgajIWY9WIRU9
         rB+O6M870utoRGvFjnL1VEXfM0fapnFzGJzKqwpT11Whb+1lT5J+MLl/GLDKWmo5XwdU
         FIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698878895; x=1699483695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQdBfGrxgT0Dp0rMc/ALsHZTaxuvWcxH/0MUqWK8IuU=;
        b=HBiSw/aAjhEO4a4zQk30nD1t1vChwc6rumC3qcyEcKL5OCYj6h6x/DTAWOvcVIzXbB
         nSE0hPaERVV2yo+7fB9bnk2aU1xbUqxs2B6/5VZ0PovK3Z8/bNcioaiRzCCk0zy8KVSj
         bQcNkcjRfWPeBzzhn+0x8euIhQS8hDA+z0Z0OESfiZS944r1KautYMW1lhh4BNKQedDK
         Sqd1OVv5DyCbCgqxYBh2xZoaEUsAN7K7eb26qyyvTTwacZFskRNThqWZHq/5AETdScsq
         dcynHv1EVi07FYbCEyvf7nBywbI7QhVkXRrTi4WMDf9tyXy1k02XQO1koFUrJTXy1evc
         qU6g==
X-Gm-Message-State: AOJu0YzaewSFn1qZxTmxNy8c0z0DNrrcsCJqOhfwP6geMneg0JYdOi+6
        X7zhzI6q6ksGf1kvluf09DhvRw==
X-Google-Smtp-Source: AGHT+IFzBCyL2t03Y1FiJ9LyIJnMA8zrXeS9r4tc6wfUloR8MlbKpjUOkT8jBL2SJ1RUlCdhsNdOCA==
X-Received: by 2002:a05:6808:1b20:b0:3a1:dfa0:7e18 with SMTP id bx32-20020a0568081b2000b003a1dfa07e18mr21827450oib.25.1698878895176;
        Wed, 01 Nov 2023 15:48:15 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id be24-20020a056808219800b003b274008e46sm376580oib.0.2023.11.01.15.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 15:48:14 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Wed, 01 Nov 2023 15:48:11 -0700
Subject: [PATCH v10 1/5] asm-generic: Improve csum_fold
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-optimize_checksum-v10-1-a498577bb969@rivosinc.com>
References: <20231101-optimize_checksum-v10-0-a498577bb969@rivosinc.com>
In-Reply-To: <20231101-optimize_checksum-v10-0-a498577bb969@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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

