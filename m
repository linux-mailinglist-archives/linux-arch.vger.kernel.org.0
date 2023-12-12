Return-Path: <linux-arch+bounces-940-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B0A80F988
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 22:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82B61C20D6A
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10306414E;
	Tue, 12 Dec 2023 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uhdWwKlb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB10CE
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 13:37:03 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c2a444311so60158425e9.2
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 13:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702417022; x=1703021822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCOh69caXbVfDD+nz3SkSSNJ4LOnzQLxIG6SJxHDatw=;
        b=uhdWwKlbKZEK1iYF0wfy2Op2eROU9BP1Qv0y8RHXUCe14DhEmzdcZ4qN41DBvnuyL0
         72tB9hPj1sv6iIvpldWFkM9V0fUBULIxWgG8/OuaDUlJz4dMPBnCrY5iFuXg5Dw+oLSB
         octEfWiI/gC9FnZz667jR0QFXeEtUZsT+jDC9QggoJUFR/kpTap6fpMjlIyoGutlBGHk
         6/LIV/vUU5BG2gdWi8iRQ/jFzt+8D+UE6xU3kCbs7ARXVxmRsgiBBPMkghlyrVnhZ3iW
         N3VVtYHl1P2klo5nmgVDfB7l2cgdPZLOvPB/ShTZlRjwwm0XIvWUPM8yL9f79LmNA+4j
         2s6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702417022; x=1703021822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCOh69caXbVfDD+nz3SkSSNJ4LOnzQLxIG6SJxHDatw=;
        b=PfiVNupG81gGEV840pLlx9csKhfqWUEO+LttZiKLDZcrwMoyr96UNVB78JzhIIYrBg
         pBcn+gLUZV5YA5LngozDMSA0E8A7Qe7g+8mHIF8HN8NZ47ayv195tSJrZJCh/7PvF6j1
         cjrdb4CX5CAAjOJ3CVesf3muALorI60RybjdhSLutnt66qzMUf9wfkM2D7hekevWsRwg
         0NLvNTgjwWR/GvYikwWwvzfbvXHIWlwkgM4ONg9EYKna+JoAPigc9pwovapNRjX+KShe
         fzeDH9F/c/tTfVqvA/lwG+U9LELFhe1duI6OEyKJ4VkRS1/Qb4D9VMRwJD8d+Y/MkKI0
         Mkcw==
X-Gm-Message-State: AOJu0YyUatPOmd5UfQUMA5b8U1QoKSEEjfHqzIsrkCfYE/32bf7RtQp8
	DVJ6bIOyONx+fMfIlvRvWks9Aw==
X-Google-Smtp-Source: AGHT+IFqqgEgVUuuLcp/jxl4AbRQVAxPSPDTSvhp/ckLGpwai+H0FWmy2ZTFwQBh1m466TRnZ7G6vg==
X-Received: by 2002:a05:600c:2814:b0:40b:5f03:b43f with SMTP id m20-20020a05600c281400b0040b5f03b43fmr1885174wmb.353.1702417021655;
        Tue, 12 Dec 2023 13:37:01 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b0040b2b38a1fasm17954734wmb.4.2023.12.12.13.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:37:01 -0800 (PST)
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
Subject: [PATCH v2 2/2] riscv: Enable pcpu page first chunk allocator
Date: Tue, 12 Dec 2023 22:34:57 +0100
Message-Id: <20231212213457.132605-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231212213457.132605-1-alexghiti@rivosinc.com>
References: <20231212213457.132605-1-alexghiti@rivosinc.com>
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
index 7603bd8ab333..8ba4a63e0ae5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -415,7 +415,9 @@ config NUMA
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


