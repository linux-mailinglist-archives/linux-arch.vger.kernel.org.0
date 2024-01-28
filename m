Return-Path: <linux-arch+bounces-1742-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B24AF83F550
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jan 2024 13:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6BC2826B7
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jan 2024 12:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDEE2033F;
	Sun, 28 Jan 2024 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vPPifL+Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92925200DE
	for <linux-arch@vger.kernel.org>; Sun, 28 Jan 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706443451; cv=none; b=MNcb0awyphx9zCIl+8gPav74dNnthHut051Q/icFW1jZ98LGeMDTDuy3Z2sR74peaqc/q/NeYKFLKLf9eN3w7cNsExG5HATkGHkwzBX7cigysNzhCAGeJJGQGlIiVCtO5Rw6pEOWAzKLXq5AdrqrF/By+fcqffPVC87DxwACe3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706443451; c=relaxed/simple;
	bh=VzbpvU0e9JzomL+t0EfKfndh1+wTmCO5Ucl/AxnJG3c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RLwQjWmTpX5UuqXEdfdr/ijHO1DPmOtZQxMpAWI42wmHaQ4DkDgfsp3QuCQBmTEzb2MLHUY5r22BSK9LDlExCyDatheXTeig+/Lw17e++mCogX3qBXFZ07p+GCgc4vpTrbLS5QBTau1q0XiyxX9dEVgvzjbV0dzKdePyoJ3EG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vPPifL+Z; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40ee9e21f89so19808275e9.0
        for <linux-arch@vger.kernel.org>; Sun, 28 Jan 2024 04:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706443448; x=1707048248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxcAjPK0N066N6P8kFzyYPkzX8zdfJo2IeOhtls9JxI=;
        b=vPPifL+ZE0VnjQmk0/32mFDkxFYKVKSSsiwVCkjTYKnHq1HKo7SZ5DrjSy2/4GAJmA
         z/vxC0TPfNyadqZlpWQCgbtO8UZzK1n4FJ5KGlKHOFLoj4OyuEULt614HiX880SlejW7
         mwP7gjQMesUhvMio0uovydAFOBv1U2/EAs5MEnKV/9yTVokBiApC36VrzIxNjB2T4VZE
         BhKBIJOVDdewpljAYXef9buWAffFPcO5XxndYon3+iFSsxboImOLNkRlcR6kWzaXD2iY
         YmMxwm2ZjAuhltu8YmVSmgwT+Sw1ijVrugZUCtJhOEu9XuBka+mLwrVsQcGr1W1zfPRC
         aQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706443448; x=1707048248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxcAjPK0N066N6P8kFzyYPkzX8zdfJo2IeOhtls9JxI=;
        b=T4GqWdBNZXiLUdutX6hqnKa+kmbOlAuR9qIZxc5vFKlgni1kgPJ1xnU7wRYfG5w/J8
         epYYDZB8azhm49CYWBb498IzI+B1JONKgzjVOpUIPBeqNMPlFrzCIYz0QZPgVaCcfK44
         hUM47W7Osp6Lj3VnxwGZ7xOZa4IjIlqJOnAraN1T3gqO2Q+jLC2XaJQHm8LUytk7n/+/
         F4df3L4/E0fOo9BYKNR9v69fbes087AoVyCtzPruCLJsOndonRS0D2VxH6z8E5l8CIT3
         urVJNyyiNE5nJefxE2cTTPVVlzR/W16d+xqRJnQptM1G7WlgL6MDiIQId+ngu6sjmpFm
         uK2Q==
X-Gm-Message-State: AOJu0Yx+/hGNm5gIa8ufMePMj9C0gt9t9ZdHf3N9uiLOM+NrGTfMRyJ3
	4GYC/N6BHJzjwUrqQVuiGUfNpyg5dCLHCPpKk5weQUcRNLexLwBsDdMw0c3fFwU=
X-Google-Smtp-Source: AGHT+IGp9QOplulvd/Y9t4bqyDTHP2SEbLG4SLRuZKPDPzRKkEqnxw5vDg9O8Y6f+J4FCQikbsMYxA==
X-Received: by 2002:a05:600c:34c4:b0:40e:ee82:18 with SMTP id d4-20020a05600c34c400b0040eee820018mr1937031wmq.14.1706443447739;
        Sun, 28 Jan 2024 04:04:07 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040eee561e4dsm3859911wmq.41.2024.01.28.04.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 04:04:07 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -fixes] riscv: Flush the tlb when a page directory is freed
Date: Sun, 28 Jan 2024 13:04:05 +0100
Message-Id: <20240128120405.25876-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The riscv privileged specification mandates to flush the TLB whenever a
page directory is modified, so add that to tlb_flush().

Fixes: c5e9b2c2ae82 ("riscv: Improve tlb_flush()")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/tlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index 1eb5682b2af6..50b63b5c15bd 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -16,7 +16,7 @@ static void tlb_flush(struct mmu_gather *tlb);
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 #ifdef CONFIG_MMU
-	if (tlb->fullmm || tlb->need_flush_all)
+	if (tlb->fullmm || tlb->need_flush_all || tlb->freed_tables)
 		flush_tlb_mm(tlb->mm);
 	else
 		flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end,
-- 
2.39.2


