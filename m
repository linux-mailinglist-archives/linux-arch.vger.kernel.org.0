Return-Path: <linux-arch+bounces-1175-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31A081F0F0
	for <lists+linux-arch@lfdr.de>; Wed, 27 Dec 2023 18:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C85D284143
	for <lists+linux-arch@lfdr.de>; Wed, 27 Dec 2023 17:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11DF4652A;
	Wed, 27 Dec 2023 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yhj7MLO9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C104645C
	for <linux-arch@vger.kernel.org>; Wed, 27 Dec 2023 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2044ecf7035so2198232fac.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Dec 2023 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703698696; x=1704303496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjqGV1Kb/P5zbkrU4HZj42U242Y4ucdb6cKzFhJu16E=;
        b=yhj7MLO9Z49Q5VMVFTNWdgbyvd3rwUksJZZS+bIxTx+cGTp0yLRURUCKYFG/7CpruH
         3oBBHIPkoDMFGuGKsjYBobcq4gwfEF/OTmC1368T5qQlccrCMch0hwhtCxPJpiQsKFh2
         blUIDGw1JUBw3CYLD5FZC6tU6HDyS/qp5l9KkgE5pTjEbpI2jXrMMVZrmE02Eh9lcT1g
         Z//aT0yacblpMw2q9o03E3TxP1GwMd/D54K4VxyEMgOkeNSEE+BeaUbXkChO4+uJrpHP
         t0dQECo9B9PqG5tcGObbbJ0sk/fKG7nuAOaUOUaHqXD7ecDUp7NrCsdjToOrT0tZh6hh
         LTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703698696; x=1704303496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjqGV1Kb/P5zbkrU4HZj42U242Y4ucdb6cKzFhJu16E=;
        b=OqIimg9/X+0zZ53XyLHLgol1yuSsiMw2xadZsDN7tX/ncl59fWO7xeWqVlVXjpEb0Z
         AyahPeJB6LEQ5kbhMtO+kwibwm2eyI7uyFmetlacABtBrZ1dLbo4XxWZtYLxZidxA0kT
         WObIaQpyN9qf1B+4A4AF130yWuvQa1zsd0/vphF/CIfTO1t4Tnix3BzmsTYikpwLJuJW
         7s35icyXLyly296RkEv+ueMFwtQpOQRBvYSjWpgJ7Bji87Vbe5TTho2WOtEhPlpjX3EG
         pwkVKY2qVLDZP5jc6MpzIwXTDPvidY+oNvH3XNYf/k+LOuqUYswY2LKg8oh+WLde7jkZ
         32Zw==
X-Gm-Message-State: AOJu0Yxj/j3k0DpR4yT7VJlQ1ecYG+CzQS0ldUqtWmaOrJlPbRuna8l6
	sL2yI0IN50nRvBWAtuNglER87ARwSHkNeA==
X-Google-Smtp-Source: AGHT+IEC0TCsueb9xj6CGGfHkV5Zq8ZY6MZ2NdEdjOM+tCPVn6udluAxHSt66BkStvL/ctF3obevSA==
X-Received: by 2002:a05:6870:5313:b0:203:985a:d559 with SMTP id j19-20020a056870531300b00203985ad559mr12222142oan.23.1703698696650;
        Wed, 27 Dec 2023 09:38:16 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id rl15-20020a056871650f00b002049c207104sm1337173oab.27.2023.12.27.09.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 09:38:15 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 27 Dec 2023 09:38:00 -0800
Subject: [PATCH v14 1/5] asm-generic: Improve csum_fold
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-optimize_checksum-v14-1-ddfd48016566@rivosinc.com>
References: <20231227-optimize_checksum-v14-0-ddfd48016566@rivosinc.com>
In-Reply-To: <20231227-optimize_checksum-v14-0-ddfd48016566@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703698692; l=1517;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FtbING0Tg9V1myoJvDDTr8ph0mEbsa+4mbxe/ijBRBI=;
 b=EVQ2R0oDdrjYUCtjGIG7LtR556zWizaK9KP7EpvcICoCvv2FlTnhqyqWoF3f+c6pInR/9M0b7
 MOvIb/8692VDNcd4u/I4PxPCe8+Rkmq1PqyHlRthW/n1TVwHLgqPb8o
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


