Return-Path: <linux-arch+bounces-117-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215EB7E7CDB
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 15:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15BF28110E
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673C1B26F;
	Fri, 10 Nov 2023 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YY/K/GzR"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5A19BD7
	for <linux-arch@vger.kernel.org>; Fri, 10 Nov 2023 14:09:28 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E0E387AB
	for <linux-arch@vger.kernel.org>; Fri, 10 Nov 2023 06:09:27 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c54c8934abso28625031fa.0
        for <linux-arch@vger.kernel.org>; Fri, 10 Nov 2023 06:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699625365; x=1700230165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNncknImGYd0G7MADnDhbFKl7Y37Hs80keyCtMwuCbk=;
        b=YY/K/GzRK0tHFcdeDuuvXZLWIU8pvr4LiFxNwxVaycV8AyG0/dQ73OldQoy5UfNvc+
         PBzvKwKOLpDxF+kgbZPdFXBweB2Rne1tFx0oxa+SU7i8+N5RB8XJVijg+yVYlCnyMczp
         rYde4d2U8EXENC/VdFsV2G1w6RdDTcDlrlfIqyCThsDMj5DTfQBTwKkNxfMToXZQLapR
         dOtcYiJzmVXldzPsCcIHgJzIY1/SAswcUdbo5zynpwKYhNCEIbRcDdKbZxkNnTi8x5Mq
         zYfnNhyqPy9YzRSf8lJm31+LUg44huokCRrnagBXH6Ms0cXF7/tR4Sl6ldV5qX4TzWEv
         m7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699625365; x=1700230165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNncknImGYd0G7MADnDhbFKl7Y37Hs80keyCtMwuCbk=;
        b=JBQSn2+WExisrS7hFWOXs2p8xh/1YWyoL4NRVLMB5f13PqRCmq7NfmOIRkntLZxihk
         tfX0mbyiCPCvQWFhQCNjimwQe57a7o6m+dc8ojkus43Pdnp+bdXzk4032lEWquccO8Vo
         3UJaV4OWmiZnZ+BNqdgit5TH6F5DZhraiLHIbSM/rYwTDgeW2VoCRKhlI8aZlsI+nhYA
         V83t799D27xYXS+LKMN5frbt24j2Qqyo68oM7pbgQlTzNHos9k1jQrVQWXan4wKOVIGz
         BdnXKHmO5ey+5NoQgzL/Ao9NmTb+ft+B7t2hDqLfkIqi6usLF1V0/5B406zEKXV6rKL4
         9rHw==
X-Gm-Message-State: AOJu0YxSImac8R8EN1MIZtku9HlTzEvCusbqRiA816104scQdOEuvmNl
	OKFpHaxPAWPkzfTlG68kWHeQPg==
X-Google-Smtp-Source: AGHT+IFnc5DDn6eDvAmwHfvD11R9Doa6XtjEu4mYLiLBs82TOIbZPRsbYbDAWR9qLMG/ZVUIcvzhnw==
X-Received: by 2002:a2e:2c15:0:b0:2c6:f51f:c96d with SMTP id s21-20020a2e2c15000000b002c6f51fc96dmr6506404ljs.13.1699625365568;
        Fri, 10 Nov 2023 06:09:25 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600c150c00b004083a105f27sm5173099wmg.26.2023.11.10.06.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 06:09:25 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 2/2] riscv: Enable pcpu page first chunk allocator
Date: Fri, 10 Nov 2023 15:07:21 +0100
Message-Id: <20231110140721.114235-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231110140721.114235-1-alexghiti@rivosinc.com>
References: <20231110140721.114235-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As explained in commit 6ea529a2037c ("percpu: make embedding first chunk
allocator check vmalloc space size"), the embedding first chunk allocator
needs the vmalloc space to be larger than the maximum distance between
units which are grouped into NUMA nodes.

On a very sparse NUMA configurations and a small vmalloc area (for example,
it is 64GB in sv39), the allocation of dynamic percpu data in the vmalloc
area could fail.

So provide the pcpu page allocator as a fallback in case we fall into
such a sparse configuration (which happened in arm64 as shown by
commit 09cea6195073 ("arm64: support page mapping percpu first chunk
allocator")).

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig         | 2 ++
 arch/riscv/mm/kasan_init.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5b1e61aca6cf..7b82d8301e42 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -416,7 +416,9 @@ config NUMA
 	depends on SMP && MMU
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select GENERIC_ARCH_NUMA
+	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
+	select NEED_PER_CPU_PAGE_FIRST_CHUNK
 	select OF_NUMA
 	select USE_PERCPU_NUMA_NODE_ID
 	help
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 5e39dcf23fdb..4c9a2c527f08 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -438,6 +438,14 @@ static void __init kasan_shallow_populate(void *start, void *end)
 	kasan_shallow_populate_pgd(vaddr, vend);
 }
 
+#ifdef CONFIG_KASAN_VMALLOC
+void __init kasan_populate_early_vm_area_shadow(void *start, unsigned long size)
+{
+	kasan_populate(kasan_mem_to_shadow(start),
+		       kasan_mem_to_shadow(start + size));
+}
+#endif
+
 static void __init create_tmp_mapping(void)
 {
 	void *ptr;
-- 
2.39.2


