Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3494B7DA3B0
	for <lists+linux-arch@lfdr.de>; Sat, 28 Oct 2023 00:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346652AbjJ0WoE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Oct 2023 18:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjJ0WoD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 18:44:03 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4328A1B9
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2023 15:44:01 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1e9baf16a86so1513679fac.1
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2023 15:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698446640; x=1699051440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55gQAkGJdgEhOiqM5Y2FlQbtEmx2dMpuljRL7f6iQqU=;
        b=ZfYCxxiLDIHJP8Ta07zA+zY53qZvOfdU5StWtIID+eenTaPlylAzMWDVxfW8xftFup
         sYpRa8vL9iMW1YtRqHJc8WAr8et10TJ7tHrs2OzIEGkR3tnUUiGc3a2wdgm1qzO+BZXP
         Px8IifzLE1ODU8uSeHsbTnunBbMGfDgDRzGdTkIIcovQEfUCkFiUP6ldoWze+P1mqdZu
         3KW61SF2vR74FHVYawdQJchJqM86XSOq6wauEMvohCJz1Izza9KeavZVgvkRWzpCaGTS
         csAM9Y3x6Fwli3vHvUdIQCSlxcj8b4d6FNuhowdTisfFaNhFc4kPGikZLjxXFJhF/LAa
         altA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698446640; x=1699051440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55gQAkGJdgEhOiqM5Y2FlQbtEmx2dMpuljRL7f6iQqU=;
        b=MKu4xxU4D7UEHsnzTwph4MSEU60XUwfZixgprnsHgOrWhRy4iUgbzmUvjGdSMUZzzc
         5oZquZdwTyprwHStp53+GS05+Q5aJKyBOX2mV+7T1SgKDBTLnVwGDkWdXZERDODc19wN
         VXQGzhNDuquNsL+7ow+8Q1yaQVbIaHwxkhDXBh9FyEmY/s70ERp1pOWBKDNzglPDSOox
         cwstWEJF3NYXp3tXWt9AJXju1+hYy+zkb6PsrPfSwx/oNfLFFGljri7Gh8sO22iCGNfz
         A9H06Jl+Q7Ivgwxo6C9lY5mF5Xuz32kW46tUttqg4zxD5xk5I9QEVOJvCqlfQ2Cta6WL
         d/+g==
X-Gm-Message-State: AOJu0YxETJdspX49gCmQ3ZT0DcU9K55o0CKuO//mG878Di10C3kW2zNw
        WK6EDfVCaCN/7dOqwiiKK2gSMd32QMHlc42W1N4=
X-Google-Smtp-Source: AGHT+IG4k0gp0a3h540O4mCCfn992tcUqZ2t7vGEc6rgkeHNvjiAj4FfdD3krEwmZfIvyEKIXhhtJg==
X-Received: by 2002:a05:6870:ad0c:b0:1e9:c252:4853 with SMTP id nt12-20020a056870ad0c00b001e9c2524853mr5049857oab.5.1698446640404;
        Fri, 27 Oct 2023 15:44:00 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d748f000000b006c61c098d38sm448564otk.21.2023.10.27.15.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 15:43:59 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Fri, 27 Oct 2023 15:43:51 -0700
Subject: [PATCH v8 1/5] asm-generic: Improve csum_fold
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-optimize_checksum-v8-1-feb7101d128d@rivosinc.com>
References: <20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com>
In-Reply-To: <20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

