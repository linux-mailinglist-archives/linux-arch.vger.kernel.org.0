Return-Path: <linux-arch+bounces-14941-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C42CC6FC73
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3BEE12F2A1
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E6036C0CE;
	Wed, 19 Nov 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="topb2Bvh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7A3A1D0B
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567164; cv=none; b=O26CDIIeqsorqOg78gY0BFp50k9qYQ5MpWWgPv0MYaQwYEKwYevLpeP1xR88q+U4i1r1LY08Uhj1Fg1Dn9fiGJF1O5NjJ5nJ/RJtPz/lJT2SgJolsNC0rP5f5thyK6bHKRpL1LBtwa00kRZIhuN8TEKV6q34k8+9x11y8boVcZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567164; c=relaxed/simple;
	bh=UTLUC0zYLNIpIU6hlTY4UtGB00tOu5axyPBTWNkQRLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ej2HkhWmv43f+o1n1o9BZZVM4C7CnvCyMnD8DL3fvy+RF9y5a6Y+KEl1bWjIPuvZ2Zdm7Y9yL5g3L2v7j9nJRxdlmnI+lUGMMsvNuqMCssh0o3eP7tozsndindeHygdTD1arH4ZzqZvzyXo25ZJ/OTvSnS9ax6dTBgl2qHe9wes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=topb2Bvh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b31507ed8so5577092f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567152; x=1764171952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uk1lFWru0IGdhKwRKbnhtV9p6FImm0O6RRZYNI9uc9w=;
        b=topb2Bvhry0CkWkwgvz5KAsjSApRvdGEL1pk4gMYp+l4C8pvgogsHSnOylyQYtNqmK
         xj7iQtzRUmAd9OItTRZYSMc/IzfCoVaVreqgx/0YEF3wJeXogmRbE18mBN+eLD00CRbY
         iQ7DeBReF3MEWzqmOejNVnppa85e7BV6FTKJYdyxTgm96vEEgfbr1/sNC+CpwzR4u3Br
         fChbO4MWB2+bwmXjYximwr6WjjZcWE4JLslUhK2xGsDrBD7MCbXDaWd71K9ivllolQQp
         zIEgSm+Da5qdhnUixIs7MzqvUebI3nSqy6Lw2+6JzsNBgyLN8jGP+XjoNUVRUMGhXAlZ
         mtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567152; x=1764171952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uk1lFWru0IGdhKwRKbnhtV9p6FImm0O6RRZYNI9uc9w=;
        b=aKk/1mQWFmmP0NK5gs2rRf2eoZ2oEJT9eidmeL8eT6knVrBWUn1QU0iOtEk7620Tgn
         G5kYB0vmnse7mpsxYQTvQL6h++DmV5kM0aEI+rNmNDxPvQO5qtksXzCYXOrQXrwBaMnj
         l5mS0mwUEpRwk8ceNnAzc84UFVrXlsY/wODkm97ZdEwBI5ACKB3SG7d8QJCGjCPZc4K6
         JOyWcq2mEnRIlYuFbZngq3gtQgKWLff8i7lMGufqe3i/35VpuhrXQb2YaFH0ifhG+8IM
         Kdv7sBjUaaRYMxJZ06NAV3kY7VrV5AUl529mfawI153xrzPshEWGLc1YvT93hCHCdJio
         QybQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHvTsPjMiDU/LUQLB2Yb1YiJ2gCQS+CWHvEGdi8sYHvO8/NwBb7TFQsjecXBZBHvMJqFwa4SCutlc8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc3fKBUcyStxBI/mcRoyOMyXCCf1IX8IAbdkCyi2x7Ic18tp35
	937deb2tq61hV4iPOEk/DTJzVZgq3MRyLtyu5pm5eHURXDqVdgxTxFKUACH97QkFFHo=
X-Gm-Gg: ASbGncu11UJSa7uAlCXgEyLcbPrYphh232leLLiSii0p//MJV48ML9GX8llpo/Wx7BP
	poiBuhLF7YTwGKlWpeBzcRYDjd+T/Xb6XouspwdCpA3gzCZHqPhbcNlDs88nneL2Ad1oxBHjHgJ
	JEGkhWGNYLFIwK1qe/4DC9FSwoX+9YzcEMVNaH761JxQOlixg+nUxHIy8FWXkWu97ozxLiwGM9Q
	+RpN44zlR1V5+I4Ky/rEVXm6LGQ3VxtqVek86/PYZMUcSSq2OxIG4ABKo6fbwvUeC/qG9qJqE9A
	lx2WLVljDg+9epQaHjrZaZadsIz46cGeXfLhK2DtMDzPo/lhKeHZq+SI0HVt2Lx49IKLB2MajmV
	OVg4ad2n0fzxTJbL3RoTf8E3kIjj0DHv1q1U2u2XrG5FrigwJWoQBWhutoJgS2XiWsPH+zbeql+
	WEM+LdAHsih+Inxw0MKrX1h5460+kF6Q==
X-Google-Smtp-Source: AGHT+IGiIxmeqrKKXMpyNCEgyddWcck0X4KYjA7E97PFt6A4ulW3WkSU04Vt6omGLvNuAQXzgiycDA==
X-Received: by 2002:a05:6000:2888:b0:42b:3ab7:b8b9 with SMTP id ffacd0b85a97d-42b5934db2cmr19180692f8f.20.1763567151698;
        Wed, 19 Nov 2025 07:45:51 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:51 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 20/26] mm/sparse: Register information into meminspect
Date: Wed, 19 Nov 2025 17:44:21 +0200
Message-ID: <20251119154427.1033475-21-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into meminspect:
 - mem_section

Information on these variables is stored into inspection table.

Register dynamic information into meminspect:
 - section
 - mem_section_usage

This information is being allocated for each node, so call
memblock_mark_inspect to mark the block accordingly.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/sparse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index 17c50a6415c2..80530e39c8b2 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -15,6 +15,7 @@
 #include <linux/swapops.h>
 #include <linux/bootmem_info.h>
 #include <linux/vmstat.h>
+#include <linux/meminspect.h>
 #include "internal.h"
 #include <asm/dma.h>
 
@@ -30,6 +31,7 @@ struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
 	____cacheline_internodealigned_in_smp;
 #endif
 EXPORT_SYMBOL(mem_section);
+MEMINSPECT_SIMPLE_ENTRY(mem_section);
 
 #ifdef NODE_NOT_IN_PAGE_FLAGS
 /*
@@ -253,6 +255,7 @@ static void __init memblocks_present(void)
 		size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
 		align = 1 << (INTERNODE_CACHE_SHIFT);
 		mem_section = memblock_alloc_or_panic(size, align);
+		memblock_mark_inspect(virt_to_phys(mem_section), size);
 	}
 #endif
 
@@ -343,6 +346,7 @@ sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
 		limit = MEMBLOCK_ALLOC_ACCESSIBLE;
 		goto again;
 	}
+	memblock_mark_inspect(virt_to_phys(usage), size);
 	return usage;
 }
 
-- 
2.43.0


