Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AFF2400E1
	for <lists+linux-arch@lfdr.de>; Mon, 10 Aug 2020 04:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgHJC20 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Aug 2020 22:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHJC20 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Aug 2020 22:28:26 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0578C061756;
        Sun,  9 Aug 2020 19:28:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ep8so4163369pjb.3;
        Sun, 09 Aug 2020 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8C8wdRPXIlS04tUD/986mX054vDuu2PdIQ/xTcAZZAA=;
        b=fvgC0IgaVGBBCP46Zn2yjyIZBeVrRa8NWp7JGxI+yUxhgJTd3YVhaytoaDsU/lDFxs
         4iHYUOz1X6WPpfvjY4IF1lTRGWy4UjbYIjINrDDfjUjnH8Hv2o6be0jAQjOR4a4F7CLi
         2RVr+OFdQqc/sDLwlZ1kM/3YAAHJN7AadRjMtJsROlN1GaMxJ8U9SxHRPbwbs9d5PTiK
         Aq4OFkLg9VtrOcx/FpLXPv5ctO8m9w9rrlcTOmRnfvSDCUXu9gcTF/7W4PID3Hqf3Iwu
         eaRu+KC82AZk5/OL9BigF/IAiD7pXYIiFsHSf6z1CuFlumZsmCM6WM4iS6Z0hakBUkZ+
         //MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8C8wdRPXIlS04tUD/986mX054vDuu2PdIQ/xTcAZZAA=;
        b=Ne26h9iNaHTpXJMbF3kNgKg519049Ngx8cEEStGmD9qqH8b9S6mZm1/lDezHZLANJs
         QtZ7PWD6N2cp/22j4BthJBJx7/fG3DvQL6MiwJjyI4ThJvJQU4V1FA60Faty6iRa5AmP
         gGx2N5gnZF72PXJLZrnL+fWPP3zUdzd0rJxtuYvOTNhRwIWQbSap9q9KOoE4sOPVMi76
         iyDowI2Acim1ydH/KfTBrbU0mQDGiFIpBpz8uAgAp6ovjGm7+zX8UsBKGGC+50CldILf
         Ygswz25+56iSdFOZUTpmlGI2tUSGjQDIQNTEaSFWyOW/+X1KDWvse9XYVyYHX5QJUiER
         HDaQ==
X-Gm-Message-State: AOAM533b823ZpUpRYzKJcVCt7aiE020adYsDYdL8d1J9sd48TtFIivwF
        ROZhrouHMigsHtWeKmYHKT4=
X-Google-Smtp-Source: ABdhPJzqg/csRjQI/X8gAPnWHF45ru/8heKZxPOpRtPbcR9UPs4MpJo+AuvP7KubNHtfifF+p8MeWw==
X-Received: by 2002:a17:902:8685:: with SMTP id g5mr22059716plo.201.1597026505571;
        Sun, 09 Aug 2020 19:28:25 -0700 (PDT)
Received: from bobo.ibm.com (193-116-100-32.tpgi.com.au. [193.116.100.32])
        by smtp.gmail.com with ESMTPSA id l17sm21863475pff.126.2020.08.09.19.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 19:28:25 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH v3 7/8] mm/vmalloc: add vmap_range_noflush variant
Date:   Mon, 10 Aug 2020 12:27:31 +1000
Message-Id: <20200810022732.1150009-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200810022732.1150009-1-npiggin@gmail.com>
References: <20200810022732.1150009-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As a side-effect, the order of flush_cache_vmap() and
arch_sync_kernel_mappings() calls are switched, but that now matches
the other callers in this file.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 129f10545bb1..4e5cb7c7f780 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -234,8 +234,8 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	return 0;
 }
 
-int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift)
+static int vmap_range_noflush(unsigned long addr, unsigned long end, phys_addr_t phys_addr,
+			pgprot_t prot, unsigned int max_page_shift)
 {
 	pgd_t *pgd;
 	unsigned long start;
@@ -255,14 +255,23 @@ int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgp
 			break;
 	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
 
-	flush_cache_vmap(start, end);
-
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);
 
 	return err;
 }
 
+int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	int err;
+
+	err = vmap_range_noflush(addr, end, phys_addr, prot, max_page_shift);
+	flush_cache_vmap(addr, end);
+
+	return err;
+}
+
 static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			     pgtbl_mod_mask *mask)
 {
-- 
2.23.0

