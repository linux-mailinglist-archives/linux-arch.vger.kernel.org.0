Return-Path: <linux-arch+bounces-15392-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7386CBA70D
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 09:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2A0630BAFE1
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 08:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1531F12F8;
	Sat, 13 Dec 2025 08:01:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25F6481B1
	for <linux-arch@vger.kernel.org>; Sat, 13 Dec 2025 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765612884; cv=none; b=Y+iWARmHUWzEu91bWGH7VgCdy89g02tIyV4mW0WiHRFzzRxXNWd+o/D7D94BUwI9Gl34fYrVF3ywnOe++ZzhMjQENst5Zv3EagQNUEigNQM0t/qXx8rDHhs8t4BrpmCh+/NQpJmWaRINqFFux6dueenJ97pkYMf3Bdx9EtJbKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765612884; c=relaxed/simple;
	bh=pe/gvSlFR4wYZnv6+kYhhiB5IBjAo8oNhXAavMlFV78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fls7yoIOtRrTvnXnwkRql3SKBe3t0DkV0EfvQku9TBu0UGYpNdnlNoI54Gch4Ddh1ZHwHTLN7uzs+UPi4W8f09d3eetBkSCTFBmvYB12UeyorK68DbAE8Yk+sCtHIKDMuKNqJp1FQ35RfuydoXgBHyKrkO5t6w+akW1LsXYJ6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29f1bc40b35so24322475ad.2
        for <linux-arch@vger.kernel.org>; Sat, 13 Dec 2025 00:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765612882; x=1766217682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hO0mmOrLQtX2f+WnOsj3vCPvjsJC7haFxv/QfsLP6Js=;
        b=QtLYlDcuJN8K3TCJ8cOYTwb9rJ9uIgFVptQ3m8ha5zqi+hDFJk4HaTgQRmlP5OAuwn
         PKzLOgg23Z+CdDx/iAN8Wk1QpLLuAca4QUCbsmCcrq6OgOE6jVcVVTMpP6eVZeqeY47Y
         sqGDCOjhsavGF1b/yO36R/dAsN2r3t95IMAZBO6Ge1p9lI2YMF99L6jzKpyvHKRUP5JB
         vv5pKiRr/JWis8JVFo7Ds25YALnyXEjg+O4q1efbZthSnSRUAcXuC9fH9MFKLjhOS5iV
         0UJ53nQy1FsEuCrhS2KdMpmtO3RagDyLzhQ1mHa5Llfv4ntPKM3Wato2x/ntND25vvbj
         dAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJOuajXB+bhpiVUdCQZ1ClH1osdvqNHtnHv9XRZjzlTkuetG+Yi9UadyyRt6GGSEpjWmk6gRY8iuMD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc64QybLfJLw2yu/PQQripix7YEUYHjqux50kSXjpPy0oNM9UY
	32Zu0/618Ly3BzxQXLJX3yaaKE5PsNTQnvrwBxZwQy3TA5kf30R4E5bv
X-Gm-Gg: AY/fxX4eIZgbV4+RqwzKZSBBKB0t2V1nB4SnX+pRAeZQ9oGjSD5jgRyz8uCNfKqcHUq
	sWceTf3pbnlrlalLnMrYjylRbqlE8XGwfW+AxlP6hR/ne/1Zz7RX/LcRKefWYO7H15Co/gZqhy2
	GcDa3r1BBvzm202NtOqsg9YR+XvrbRYR4HRJPyGgP3r4izpqgibzU9XFSoBkuJ8u+2keBhd/YpY
	bsriTMsnFdtJ92UYXke0azToOyDUvk4J/0TTePvinv5zvoEtzkY4GSNetZ0lRRtwlxAnGZOuhW3
	z1Rg4qACD08Y3MFyVuqoEmY9SLY2Xhmaq/SaiwE9I+FCQTvM56hPMqGej0XVr9BPIQ+CP/hIoLN
	Z9xM4AQ9yn51DXckZlZeTgOyFQnIVhuSdUJR87vDUtcX8gJ/zEHoKdf/59yA3il60p/z01iqqur
	pVJbrDZQ0Lun6pPEX0yrH30wGXlg==
X-Google-Smtp-Source: AGHT+IHVDW7jzJQJmTW2QCX77VaaJ/gbOI8PVom/MrydMKNXuHfqI/AK6StmWZkRHj080xHzVr0NUw==
X-Received: by 2002:a17:903:11d0:b0:297:fc22:3ab2 with SMTP id d9443c01a7336-29f23c7336emr45692435ad.36.1765612882029;
        Sat, 13 Dec 2025 00:01:22 -0800 (PST)
Received: from localhost.localdomain ([45.142.165.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f05287fa3sm53149155ad.5.2025.12.13.00.01.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Dec 2025 00:01:21 -0800 (PST)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	shy828301@gmail.com,
	riel@surriel.com,
	jannh@google.com,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH RFC 2/3] x86/mm: implement redundant IPI elimination for PMD unsharing
Date: Sat, 13 Dec 2025 16:00:24 +0800
Message-ID: <20251213080038.10917-3-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251213080038.10917-1-lance.yang@linux.dev>
References: <20251213080038.10917-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

Pass both freed_tables and unshared_tables to flush_tlb_mm_range() to
ensure lazy-TLB CPUs receive IPIs and flush their paging-structure caches:

	flush_tlb_mm_range(..., freed_tables || unshared_tables);

Implement tlb_table_flush_implies_ipi_broadcast() for x86: on native x86
without paravirt or INVLPGB, the TLB flush IPI already provides necessary
synchronization, allowing the second IPI to be skipped. For paravirt with
non-native flush_tlb_multi and for INVLPGB, conservatively keep both IPIs.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 arch/x86/include/asm/tlb.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 866ea78ba156..96602b7b7210 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -5,10 +5,24 @@
 #define tlb_flush tlb_flush
 static inline void tlb_flush(struct mmu_gather *tlb);
 
+#define tlb_table_flush_implies_ipi_broadcast tlb_table_flush_implies_ipi_broadcast
+static inline bool tlb_table_flush_implies_ipi_broadcast(void);
+
 #include <asm-generic/tlb.h>
 #include <linux/kernel.h>
 #include <vdso/bits.h>
 #include <vdso/page.h>
+#include <asm/paravirt.h>
+
+static inline bool tlb_table_flush_implies_ipi_broadcast(void)
+{
+#ifdef CONFIG_PARAVIRT
+	/* Paravirt may use hypercalls that don't send real IPIs. */
+	if (pv_ops.mmu.flush_tlb_multi != native_flush_tlb_multi)
+		return false;
+#endif
+	return !cpu_feature_enabled(X86_FEATURE_INVLPGB);
+}
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
@@ -20,7 +34,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 		end = tlb->end;
 	}
 
-	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
+	flush_tlb_mm_range(tlb->mm, start, end, stride_shift,
+			   tlb->freed_tables || tlb->unshared_tables);
 }
 
 static inline void invlpg(unsigned long addr)
-- 
2.49.0


