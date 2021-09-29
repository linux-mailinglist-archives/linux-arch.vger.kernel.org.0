Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C450041C78A
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbhI2O61 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 10:58:27 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54340
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344869AbhI2O6Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 10:58:25 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5509D40297
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632927402;
        bh=K1pTcCDambmk2cm1n6ZjEjTKGt45ssHjrCIqDxdL+pk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=T+FceZn8av7XDqmh9UCOqOCidPtAjfN27IYWesbTwDRYSKN7TsbChOkGVHA+HxVgr
         Z9hGQYdZETrJHCEizdyRRoihWgfn4bxiqZF+ZnR50DDM5NHV1CGK/v4h/Xbm1H5Nmy
         UYq0LQkwRDtQDGo3jICKuQ7bAaDjtYssw97vq22jEKybxKYIyfROcy2LpKXVZBxBwf
         U/VXs4WlBjeI4cQ1iuKp+bd8qAQWbafDkTiZBPgkhc0GPCI8SLb9O9Nz0qaGtUwF55
         bhP/f/1pv2pSHBnZaoG+suRw8sHUJ3y/Tx7Bl+Si2MHJ9o1gbjfat++EtO7pWMfs0a
         ZZak7AoX3GOEQ==
Received: by mail-wm1-f69.google.com with SMTP id m9-20020a05600c4f4900b003057c761567so2837667wmq.1
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 07:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K1pTcCDambmk2cm1n6ZjEjTKGt45ssHjrCIqDxdL+pk=;
        b=p1vK2ep2XqU8i+Y7CR/N9RIJn3SR8TQhfbqXiUl4U38nCPhlH0yMoHDYMzpOOxY7KY
         UuPyzqlgbMvCTtQ/SubBLl9XR56XxoLtP1vCikH2DzI9JT4sTXSct6pOWhfnhNR88anZ
         MaYkG62TPVRU0qKMDmy9frGupsEYn0kIAXNL8vDMTPygwz7guBewjiacXij3dAALmR5B
         TspvF6eE1STLEZD0Ns5PgkKZqnMiyEn1Rdlc3R2NJ/yVXnbR2JXlX/jNUrWCABXDTKR0
         Sx8lJaTAOw6EH8rqAS+uE/k1Vibb7FR11dbLDcIz4/UQ93o0EAWMLbM43o7lmv8CzZgd
         sL/w==
X-Gm-Message-State: AOAM530LuyJJRaHdRl2jF3K4znrwk0U/joDGtsfNBgz6GtNCky7Xg7hO
        suUvBAudId58ZSfiuXYzX97LueHguhneORSw44ItfPU+1I0HLm7oPkMOS1e6fu+vDZr7HQstkDn
        2RuPzHaqBfCgIWVowoCS9XVroqaNaMmlS4SHTeKA=
X-Received: by 2002:a5d:5986:: with SMTP id n6mr306744wri.75.1632927400956;
        Wed, 29 Sep 2021 07:56:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP/LmgIdcviRO3JwhxsGcRDtygVIO5lq23IuSLwVVC0VraVWuciMD1ucN9OSE7Hh6VQ+KEYw==
X-Received: by 2002:a5d:5986:: with SMTP id n6mr306729wri.75.1632927400839;
        Wed, 29 Sep 2021 07:56:40 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id 25sm2117713wmo.9.2021.09.29.07.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:56:40 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v2 05/10] riscv: Use pgtable_l4_enabled to output mmu_type in cpuinfo
Date:   Wed, 29 Sep 2021 16:51:08 +0200
Message-Id: <20210929145113.1935778-6-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that the mmu type is determined at runtime using SATP
characteristic, use the global variable pgtable_l4_enabled to output
mmu type of the processor through /proc/cpuinfo instead of relying on
device tree infos.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/kernel/cpu.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 6d59e6906fdd..dea9b1c31889 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -7,6 +7,7 @@
 #include <linux/seq_file.h>
 #include <linux/of.h>
 #include <asm/smp.h>
+#include <asm/pgtable.h>
 
 /*
  * Returns the hart ID of the given device tree node, or -ENODEV if the node
@@ -70,18 +71,19 @@ static void print_isa(struct seq_file *f, const char *isa)
 	seq_puts(f, "\n");
 }
 
-static void print_mmu(struct seq_file *f, const char *mmu_type)
+static void print_mmu(struct seq_file *f)
 {
+	char sv_type[16];
+
 #if defined(CONFIG_32BIT)
-	if (strcmp(mmu_type, "riscv,sv32") != 0)
-		return;
+	strncpy(sv_type, "sv32", 5);
 #elif defined(CONFIG_64BIT)
-	if (strcmp(mmu_type, "riscv,sv39") != 0 &&
-	    strcmp(mmu_type, "riscv,sv48") != 0)
-		return;
+	if (pgtable_l4_enabled)
+		strncpy(sv_type, "sv48", 5);
+	else
+		strncpy(sv_type, "sv39", 5);
 #endif
-
-	seq_printf(f, "mmu\t\t: %s\n", mmu_type+6);
+	seq_printf(f, "mmu\t\t: %s\n", sv_type);
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
@@ -106,14 +108,13 @@ static int c_show(struct seq_file *m, void *v)
 {
 	unsigned long cpu_id = (unsigned long)v - 1;
 	struct device_node *node = of_get_cpu_node(cpu_id, NULL);
-	const char *compat, *isa, *mmu;
+	const char *compat, *isa;
 
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
 	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
 	if (!of_property_read_string(node, "riscv,isa", &isa))
 		print_isa(m, isa);
-	if (!of_property_read_string(node, "mmu-type", &mmu))
-		print_mmu(m, mmu);
+	print_mmu(m);
 	if (!of_property_read_string(node, "compatible", &compat)
 	    && strcmp(compat, "riscv"))
 		seq_printf(m, "uarch\t\t: %s\n", compat);
-- 
2.30.2

