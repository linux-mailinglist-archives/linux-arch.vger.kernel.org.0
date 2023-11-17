Return-Path: <linux-arch+bounces-238-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3417EFAEA
	for <lists+linux-arch@lfdr.de>; Fri, 17 Nov 2023 22:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB393B21277
	for <lists+linux-arch@lfdr.de>; Fri, 17 Nov 2023 21:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0884F888;
	Fri, 17 Nov 2023 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="f70WRS7y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBFB1FC3
	for <linux-arch@vger.kernel.org>; Fri, 17 Nov 2023 13:28:10 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1ef36a04931so1322340fac.2
        for <linux-arch@vger.kernel.org>; Fri, 17 Nov 2023 13:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700256490; x=1700861290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQdBfGrxgT0Dp0rMc/ALsHZTaxuvWcxH/0MUqWK8IuU=;
        b=f70WRS7yyv+xBIlfF9WkxxyBns6g68kJl5Zcq9FaMGwv3Nk0XF2LNc2GdRXTAZGF7d
         r8pQ/bwH57C5ZLNJV1pX5OkNzoFL8YP+5TTDLJVOfZe+hNxgNqoseP05l962ZI5IK2Iw
         j5WyQ8DXl+zVuzEPtA6uqDMmBrASNBe0IIAiY0lvr5TB93BCGN19V4cqAYpchLQ0Yx70
         bLH0rPqxKeMTm7I2SkgVcbXZWpPB12e0HR+moIalyE3QARMyFtfV92/Is82hO6EAl03H
         C7l76vhulPQv0fKWnG+87DDse1XBgl3JKUjbiXej8dOgLC1tvb53tKII8zxn1Fh9Wd5s
         HsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700256490; x=1700861290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQdBfGrxgT0Dp0rMc/ALsHZTaxuvWcxH/0MUqWK8IuU=;
        b=Zj0RAxiX7+IPSkY9/MswvGyqifLNfX13RfdpFzJqr1sDea1WFiEo0dF0vO1lpbMjoZ
         ArJ0OUFmHDNwfMiDOcdC6lvamKpIMksaADypbIlpfATBu2BQJa7HzruNjL1G03up6yYW
         o54OmbZazU1Dduf12rYNwnYFqEJ2wh78FlLZECUpXRB7CcaxP3uWpwb9ln9LrvjzaeOF
         Vwz4x3jGCkcGbXEHgMOcFe7oWIYzSZ58ed7eVYGdpRhkItbCF5lViGEjEL9NvVgVJC39
         rIFivWkXzddBr+GXK/lYqhnzqkzyDTunQBf52eSuAnjbeflhuCY/Myuo+zdEUSPFcHrD
         VeZg==
X-Gm-Message-State: AOJu0YwoJofclw1P+8GSnynm1xJk2YFmVonFLlx+K+jtpIuWJqOhRPdu
	JtHgMxkL61ZKQV0Lg15m8bWs3g==
X-Google-Smtp-Source: AGHT+IERQ0+DN8SQn6/wJ3vrUeFjmy9jXeWoMn+tLYoESOPbb2DXJmsV20QZd0x5Dm205tCkq4OFHA==
X-Received: by 2002:a05:6871:3788:b0:1f5:2b0c:706b with SMTP id nq8-20020a056871378800b001f52b0c706bmr394978oac.28.1700256489806;
        Fri, 17 Nov 2023 13:28:09 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e2-20020a05683013c200b006d3127234d7sm365677otq.8.2023.11.17.13.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:28:09 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 17 Nov 2023 13:27:59 -0800
Subject: [PATCH v11 1/5] asm-generic: Improve csum_fold
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231117-optimize_checksum-v11-1-7d9d954fe361@rivosinc.com>
References: <20231117-optimize_checksum-v11-0-7d9d954fe361@rivosinc.com>
In-Reply-To: <20231117-optimize_checksum-v11-0-7d9d954fe361@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 David Laight <David.Laight@aculab.com>, Xiao Wang <xiao.w.wang@intel.com>, 
 Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, 
 David Laight <david.laight@aculab.com>
X-Mailer: b4 0.12.3

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


