Return-Path: <linux-arch+bounces-9633-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F54A053B5
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 08:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54B1166153
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 07:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AE31AA1DA;
	Wed,  8 Jan 2025 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D36doFD2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46BE1AA7A9
	for <linux-arch@vger.kernel.org>; Wed,  8 Jan 2025 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319639; cv=none; b=sl3efsa/8G/ZOdHuwb2jLxJEii7CA5LoS+f49iY9Y38SUR2T6oOhONYe3DpDg+/1Cd/89TCCT8zS4+x6f9MofsTrK6DR9YE/clADBwQJda0+iVE9Oh6UAZkVoJQgadZoEUBMllnYx2eINTylROfmC6HEfnRcqqT5bpWaIQrijZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319639; c=relaxed/simple;
	bh=8PYWh2+orWwYf6986S1qPEzSyDMn0jEmjPeP/Gs1msM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EHhY/NjfO/iIuSxl/Opx5Ny/kWgQn6P2vrMD2iBFj8mHOX5BFSN8cCaAowKoQ7NL9tDctmmiIn6O53kQVRt0QJL6vt/ll1rC0GiE1chC6dQ/T0aHEiqFgPnT/pyO0MbU/Px5FPJFe5afQI4T06XC/5vNWO3lHNInpcuvt/VpYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D36doFD2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21654fdd5daso225077665ad.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Jan 2025 23:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319635; x=1736924435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3ajwCEJzuBWHLhfIS3uOIg9mbtSga1CIaOnP3nLDr0=;
        b=D36doFD2eeEmR2bn6CJX8f5wpGnEPnzm3By1w8nWkBeMfXzl3kPPwr4mbqOkXEZhov
         VrwoHhOaSlU+az/WyLPiDSwtFodV/d7k98qHBI47BBbBmYjGz7mLnhwnUKtd9lRrnBFi
         bhczabQP8GmoHfwUxnHtM0Vh0K7nIolVZ4keO6qU+QqCEJjqJ1t+1kgiuPAylWLj3lf7
         OYlKkbHZQNSSaIU8ju8jUadGcCbCbdPcu1WPO2WK/TdX0ptilPW+h759vInIarzE90sV
         78hM/2Eyh7svckrSCheuAzoM3IR2SdV33HEvReFeV1KYoQqUzwFE4/vjdTllVFU7wCtY
         0s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319635; x=1736924435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3ajwCEJzuBWHLhfIS3uOIg9mbtSga1CIaOnP3nLDr0=;
        b=kYQlSPhxklSWsxkNgF7XW1XrxT4ilVS8X50c1shYEvX7NjCsp7WdxU13snvEdQEZ/2
         WSIh+4yUVof6l8dbCw+GQp4KHwVU9YtMxM3ziWWuI/QCdrW3Eaf6NJj8O+do15T6zGGk
         o70tP7OaO8uFPsI1qPJ/ObUTW9E4JkZfvHkK0XeIN1jHR/cj6qh3f4V89pWOJpGcpeZR
         G9M8PJQSq+F1dgxN42L3uE3WVF5cRSqG8wWKGJKebjWsOsO81YvNwGROrDq/h+UpZp8r
         vBOhBvgHCTwfiPCWa2bPdDrwXN2iAuU/IUg6S2bNb2p0V0xhLFOric7TNe30pJz/k7vl
         +MzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwVGX0ibKnIorexYpB6KrgiTV0/nAEt3E01kYjmm32FbHILx0d5tCbkIICZqxCkL/SmAA3+VBjrIbP@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQ1XT9gboYdswkDoRcye5zxl+mmOFpJMqbtiPXsOKTiKIOxzM
	KdUwp57OvnK8xusFPBaoijU+MqACCUBAC3uEJP8XsiW+P8D3iv5bET5tYxabLe4=
X-Gm-Gg: ASbGnct9GFCFE2c4lH4/sJlxdjG9r7xLXmFFeKXG2acGo2q/XN1QeusKizr5a9xJv3U
	urdKKPeCqTiIkYVqQDe05MznjqwCWZdJAFRyPTO+xCe8ELHB51xgUeliVZyin34SFzchx9vZzOn
	hZzuw034ledH1f7WZ+TKQGLJwCDdmUebq6aucdW6LusXx5th0oIzeUdxiBS2ecd01eoKjGdcj0i
	wvohbltesMzhFB3jUgYWH2eM5VyOynnQv9fphs9Q7tqAuiTl9F0a3RPKZkh52zwraNhl45r+YHK
	kZqEcP5StKJPa7LrprJPTr8KSvw=
X-Google-Smtp-Source: AGHT+IFQatZJEh1vMaYN2M2lTtxd4TB3DgwS5fDlIHVUeP0cQjVCzCSP2sGAFE7qJT7hKS5hKn1bKA==
X-Received: by 2002:a17:902:d4d2:b0:215:9642:4d6d with SMTP id d9443c01a7336-21a83f55157mr23731385ad.17.1736319635015;
        Tue, 07 Jan 2025 23:00:35 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:00:34 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	alex@ghiti.fr,
	andreas@gaisler.com,
	palmer@dabbelt.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 05/17] arm64: pgtable: use mmu gather to free p4d level page table
Date: Wed,  8 Jan 2025 14:57:21 +0800
Message-Id: <3fd48525397b34a64f7c0eb76746da30814dc941.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other levels of page tables, also use mmu gather mechanism to free
p4d level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/pgalloc.h |  1 -
 arch/arm64/include/asm/tlb.h     | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2965f5a7e39e3..1b4509d3382c6 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -85,7 +85,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
 	__pgd_populate(pgdp, __pa(p4dp), pgdval);
 }
 
-#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
 #else
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
 {
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a947c6e784ed2..445282cde9afb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -111,4 +111,18 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 }
 #endif
 
+#if CONFIG_PGTABLE_LEVELS > 4
+static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
+				  unsigned long addr)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
+
+	if (!pgtable_l5_enabled())
+		return;
+
+	pagetable_p4d_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
+}
+#endif
+
 #endif
-- 
2.20.1


