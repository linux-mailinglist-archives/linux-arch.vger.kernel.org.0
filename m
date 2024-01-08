Return-Path: <linux-arch+bounces-1305-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3E0827BBA
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 00:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9721A1F2373D
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 23:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7015647C;
	Mon,  8 Jan 2024 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="p4TRuC9L"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF656476
	for <linux-arch@vger.kernel.org>; Mon,  8 Jan 2024 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dc759c8ddbso1574687a34.0
        for <linux-arch@vger.kernel.org>; Mon, 08 Jan 2024 15:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704758248; x=1705363048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjqGV1Kb/P5zbkrU4HZj42U242Y4ucdb6cKzFhJu16E=;
        b=p4TRuC9LkJ6tM1KYfE3Mbxxcvqxi2XY3/eGr7MiprhIIG+4z2Ty3UHB6EHk2/bWPta
         BzvKxIuMk8mVKbMTiQT51hlvDpA5XY3DqOWwp02fxSidGG71M71GwLPYq8WlsU7Ej6D0
         JvTqP+Q9iPY2aarhxUPyRrDn0uJjNPbiBEqBX/JCPxJvAoW7QtLDaqAw2JnvGkLbG5Xp
         qStTdyLk8EBHbspDliOSJYGwvTK0FkwEgze4RTijj+IX5KH8f7yaQU8KgNqnZ80aLWsK
         nOybFn3RuTlkUGeoFCQXMMI+kzhYc6owYq7QBwd17OIM9U1Sdcjy4sN1dhneuG/pNx2Z
         2urA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704758248; x=1705363048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjqGV1Kb/P5zbkrU4HZj42U242Y4ucdb6cKzFhJu16E=;
        b=MDzinn+XesE5Nz2RubRjJBLkE0hNIF98PRzGba+gaHSM+7oruq5VhP2Q6HY6qDHlOl
         R3DP85cYz6h1TA3T8QR1Nkp5W/CNUUnVno0xA0MfLyLbrWlYrESNaM0XxPVgIoBhBTqQ
         lbxlTULgvYqi8MI8IyNRWzOZj2f3jtA3KHe7i3zjmH+wnhgD9nwVvo8EpYm+4X+xzL3W
         WaqiBfncaT88kmFYKfeTLBv/BeKP48TwVfNg1Glx0CO3AnsrxWZITy7dYn4/bZQFZN+8
         yjsC1QgkuMB7jdjsWj/pEfCnxVE9ahJQEXxBOF/5ryhduhZHOARHtlu4RYVse8giKqv7
         zNZg==
X-Gm-Message-State: AOJu0Yy/kRVWSCWE7+5kOAZN+ZSPV+y5kRRbX+F2+Ze/bg1u1xkkVZq7
	47r86GlcVJuIVSrBQSavndzEgDJXHMDdcQ==
X-Google-Smtp-Source: AGHT+IGQry5FngBouHtCJlB73roFuMMiD2RmGNpHEaUJeqIk9NLJxd+uUJJ8u9/3lO4n4mix6w/Mtg==
X-Received: by 2002:a05:6870:a693:b0:203:f6d7:56ac with SMTP id i19-20020a056870a69300b00203f6d756acmr3820090oam.41.1704758248550;
        Mon, 08 Jan 2024 15:57:28 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ti5-20020a056871890500b002043b415eaasm206961oab.29.2024.01.08.15.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 15:57:28 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 08 Jan 2024 15:57:02 -0800
Subject: [PATCH v15 1/5] asm-generic: Improve csum_fold
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-optimize_checksum-v15-1-1c50de5f2167@rivosinc.com>
References: <20240108-optimize_checksum-v15-0-1c50de5f2167@rivosinc.com>
In-Reply-To: <20240108-optimize_checksum-v15-0-1c50de5f2167@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 David Laight <David.Laight@aculab.com>, Xiao Wang <xiao.w.wang@intel.com>, 
 Evan Green <evan@rivosinc.com>, Guo Ren <guoren@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, 
 David Laight <david.laight@aculab.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704758245; l=1517;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FtbING0Tg9V1myoJvDDTr8ph0mEbsa+4mbxe/ijBRBI=;
 b=7r6kXj0tvZ3nmSEETfM1OlN4zd7puktubukkDWBtnhShCRSbOxjwiowPmVGaKKYKRLlM376Yq
 ZqHkuglS4CMDfUYCDRQMLWt+N1kY6Y8vCWegUTOjouX59Y0U3WlA5rI
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

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
2.43.0


