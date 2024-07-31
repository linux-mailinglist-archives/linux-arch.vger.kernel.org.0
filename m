Return-Path: <linux-arch+bounces-5754-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876D094281E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 09:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432EB283A18
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 07:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B23C1A721A;
	Wed, 31 Jul 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e1rqvkV+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990FF1A7204
	for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 07:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411326; cv=none; b=Ll05GGn6Mb6uLvtH4S5dizxAFTT6LB1LZGphe+9g7318X+wLX90K3enRhrKe2D4Zo0fZLjFpzvzS/ByNFcraxvXQlEhaiMxjgO51biWnctblIDHicRdNl/uELQgyf0U4bPsgqzPD+U5i9TgAawC7LVPzhxyUY/9KUI4dtrN05uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411326; c=relaxed/simple;
	bh=+9/y9wvtaqMsdeXKfExQM5dsUcThBpV6bsD9FDAfAQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFBGcKSdyWPzW/ZxwhTBTC56UiZUGojufNtp3lcbVidpLVgcgFhNQXDzXuZCSCn0WyslTcn0rNbXWQCINSRxyT2YkV0T1xweNypBcQOI3SSLgrbJVGvvodGHvbwl/PdG8dUsC6AzRpiGbW8BXevX9pNeD6kH+uaVn7FEPLV38MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e1rqvkV+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428243f928fso17787565e9.0
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 00:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722411322; x=1723016122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z44ALrb7LNXYv1B0ZHkbMo5mYcvmK7MIKHKlm+pxL7E=;
        b=e1rqvkV+tHP6kZSLCllIO64WzIc0/UdYhnbG6DhpoEjTSrPE87RcjuLBo1P/taJA7q
         RDjlvYNE6m2tTeNNHtJosZjmwep5akV0lPeuxHSSoBKP7Lcjc/j/lmrmi+N3IaQO7lP4
         rn0GmOq9goq4w1XSPAxuAM8FtdJEvNRMT1PWKPEKDoUB2oy3aRj7H4t1y4fGUBfKl2UX
         3MI9FfOd9YZ3viJYyHhfIrtMMsdTWvSE35oCh8IfCRRZMjrawG1lqI433/GtDlXXfO1Z
         Q0d/5Hu6UMI0cKxWDKrzx5b32YYIB4mqChalEIBINSuc5be4EcXVlJkjoAIHtOheG0VE
         sRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411322; x=1723016122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z44ALrb7LNXYv1B0ZHkbMo5mYcvmK7MIKHKlm+pxL7E=;
        b=VML5VjhR/R5+wIvCA7YTPLNmZHoBXqGMsZA9Zm7yH7keRJx43CPueHJqRDM6777WMH
         rMbQ2xkVtHuntYBjBX6DPmi9DCMngzwhp39X76QZ/HAsIuMPHYkhiZ60ye8g5NAsMGiQ
         R4hup30KdgRH53QHU3m6JgM0j02h56KE9UUDsgdd8cFdOgt/MkAiuYH7kvUNfw5K/qn4
         b2vJ9XNSFf4yx55eQ3RE2qjGF6Rwp2oTEUPBWkKrfcHqONjFQURmak8cywN/gVEvYmcJ
         7ew7iFkOOBeWkmq1hLLR2aHyc4WV1T393FJwtGE5VrrCIP/czrRAFG6oPW0wx1c398dZ
         Vp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEdDP9N8toGzHNj6eIPqy6aVUmRoCKZm5yJRBBdfHPST4iOt7945nux6A1b4TAUCOwC2ikc+smmQ7XxkP1Z8pPU6ZySmFU8RYRIQ==
X-Gm-Message-State: AOJu0YyKLnCEuAlvjq9AD4V9YHRmiwJ9DQyywiaOha7pi8fK0S2qeVin
	07xOqLau0aeHsqz/X52T++t5DH41yxoaLGploAQltnzI3tkPm40t24WYIAGW2kU=
X-Google-Smtp-Source: AGHT+IG6U6uPzWRr6gyEB9gsCw8ZKy/LcXxiWXsEaCB8YLZ20e09CxhjZV72Tw4GvYFGKWtqsWRHog==
X-Received: by 2002:a5d:6d87:0:b0:368:31c7:19da with SMTP id ffacd0b85a97d-36b5cf2520fmr13078467f8f.13.1722411321847;
        Wed, 31 Jul 2024 00:35:21 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36862271sm16333146f8f.98.2024.07.31.00.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:35:21 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 11/13] riscv: Add ISA extension parsing for Ziccrse
Date: Wed, 31 Jul 2024 09:24:03 +0200
Message-Id: <20240731072405.197046-12-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731072405.197046-1-alexghiti@rivosinc.com>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to parse the Ziccrse string in the riscv,isa string.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index f5d53251c947..9e228b079a6d 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -93,6 +93,7 @@
 #define RISCV_ISA_EXT_ZCMOP		84
 #define RISCV_ISA_EXT_ZAWRS		85
 #define RISCV_ISA_EXT_ZABHA		86
+#define RISCV_ISA_EXT_ZICCRSE		87
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 2a608056c89c..097821df8642 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -314,6 +314,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 					  riscv_ext_zicbom_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
 					  riscv_ext_zicboz_validate),
+	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
-- 
2.39.2


