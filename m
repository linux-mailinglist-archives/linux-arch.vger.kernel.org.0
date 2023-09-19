Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D227A6AD0
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 20:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjISSpG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 14:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjISSpF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 14:45:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D457BBE
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 11:44:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c44c7dbaf9so34338765ad.1
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695149099; x=1695753899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55gQAkGJdgEhOiqM5Y2FlQbtEmx2dMpuljRL7f6iQqU=;
        b=XCbLVV0lEuRuMWmbkS2DAnRlA2m1WcgRUoze3SvalSCYLhRsJpB3SIVKJd3Be8maef
         87pcQzbBefQna6mgkoEluugcLYOTiOPfFU93WjbbJUP4sQehWK+uBhGmpXxT5p0aq1Ja
         8MVQIKK8kjlBFsENBOgN73LGoWz+kwQofngw6hOJ3c2bh1aWiYsI59K0tzMvbZbdNv6D
         dmIxVarXUwcQHQrzL5PpLdpkl5S1pU4HF4Ua54u3RRBOCKLzhVDjRvDs2G5jl+94NgX/
         PHaYITMxJZeWysocYekXcCYxL9d3aWFlryioRD7fuJokkOz951L8OGQDI7+lW+enMVqw
         5XLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695149099; x=1695753899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55gQAkGJdgEhOiqM5Y2FlQbtEmx2dMpuljRL7f6iQqU=;
        b=igtnhVEM99Qs5SDkCzBxm1IuSsSZxpwwT2M3bapLgx6xnq3jVoI2hbqQHhSCjoLZ4Z
         qdG8PIY7XRoOa+1vigOHdqvGf9B5R4zxCOnJn2/tXx+UcLwg112PhEVckekdB4HJcfXd
         +4KjbVC1hLVfSfOi8XPBcet+XHdLhuc0QBQBwyFnzpsp0xMbzB0PcYFXBL/Tc+H54hO3
         Jv4Ma5KngwLaIwFExy0C9zaoAARmAQZ0Z9Fp9+feMwYNWBfOU2gAPCrPDp7IYSDnoOVX
         Cu4BOpXiCcf+DSeiOT7I6C5pPr7oxOU+K/aVMtneSmBQ4u4IabSKZp/n25EdyOk4/QJn
         h5Lw==
X-Gm-Message-State: AOJu0YyXc8GYjMrx0oV/S95UBtCAwBxG/sGuLEYTyuhRxGVGZ4+VODL0
        IIvmL+j9WkixYYjOo4fpU1J9bQ==
X-Google-Smtp-Source: AGHT+IECeD0t3KVVjp83+SDRaC/7OrzIU81MVJ+7IrS4+dRmUhHoCcO+7uyA3Gf++yea4S5twdODgw==
X-Received: by 2002:a17:90b:23c1:b0:26c:f9a5:4493 with SMTP id md1-20020a17090b23c100b0026cf9a54493mr539248pjb.5.1695149099376;
        Tue, 19 Sep 2023 11:44:59 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090b068500b0026309d57724sm3876846pjz.39.2023.09.19.11.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 11:44:59 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 19 Sep 2023 11:44:30 -0700
Subject: [PATCH v7 1/4] asm-generic: Improve csum_fold
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-optimize_checksum-v7-1-06c7d0ddd5d6@rivosinc.com>
References: <20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com>
In-Reply-To: <20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <david.laight@aculab.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.42.0

