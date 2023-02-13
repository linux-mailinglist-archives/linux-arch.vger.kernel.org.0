Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13335693D92
	for <lists+linux-arch@lfdr.de>; Mon, 13 Feb 2023 05:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBMEy0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Feb 2023 23:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBMEyK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Feb 2023 23:54:10 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E7AAD36
        for <linux-arch@vger.kernel.org>; Sun, 12 Feb 2023 20:54:09 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e17so3444581plg.12
        for <linux-arch@vger.kernel.org>; Sun, 12 Feb 2023 20:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lt6u6bYwhuTYMTt/YfubY13MWrPuafF8Y1u+P5cWyE8=;
        b=vt+qlNRDi7mRznlVUmbqj3O98hmw8TzQhEaLZE107DASJjh3mP5YoOhuFoE/yDgncn
         OCvZHgb1zW/hH2iTg9NRv5Wvr+diw7rZF11dNmNK02h8Eanq2/2oPPW05Ri4S37QtvJL
         22/4YVAOYRBOGaZ1sF7hoskBSUqcx3veQeIhV7or5WE2e3hlEkKjqfifPGWWsd0kxu/j
         WAyBfRKGlvAkydGHT9alybIs4NM7Z4c5f3VlNPpGkMhJwjPyX420tB4sAm4543ChntNk
         KKPDv0GKHwLrhhldTsJrjzkPUijMNypauZOdcTMX5tonq3hrIgVD+1N6zaNBQE3PWR3U
         6B0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lt6u6bYwhuTYMTt/YfubY13MWrPuafF8Y1u+P5cWyE8=;
        b=lGXFIIw7DpZMSPOKDMpCGcBQL5Jc9llvUnpw/XoHH4MRdq97AQuQ1mBJdI8Z7a6JGU
         RtRWr6jsGSKk9aHCyc0sEzoMNhPgJfwVrnOsV145OjHBu4ETsUJCGaI2uXMi7NnFvLB+
         JIr03kHr6GvEx/KVdjvrYgzNBddqXXL7vVa0mAui+Jlw2JT78DdaVTE7FjjkyZIA82CQ
         q+bQUUFHUsPt2d2uqhUJjO+W8I6XDZzhqvDG/7PmK9sAI5oH3cT1KcfUdndji4+NBQuN
         tw+/IkNEWFwv0aG5Oow2XJLsFmLRn9ASQ6Ob+Opr/awpwsbqqtRz0Kkh4qlnh8G+rQxv
         hv4w==
X-Gm-Message-State: AO0yUKWx24/g0pYAKEmGs4hbva7VtSAin1mjkNRkSvGy+otAvDkBxlox
        oEugVpujuR3A0DoeYzXkzzJM2A==
X-Google-Smtp-Source: AK7set/M2hXnLP/wI4jka3ngVh/rpW9tQNim5nRuWweSNonl8MMrLnl7Zea2Dyx/IgKeNWfXUHLJEQ==
X-Received: by 2002:a17:902:dcc5:b0:199:482f:d4c4 with SMTP id t5-20020a170902dcc500b00199482fd4c4mr13241724pll.44.1676264049102;
        Sun, 12 Feb 2023 20:54:09 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:08 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 RFC Zisslpcfi 05/20] mmap : Introducing new protection "PROT_SHADOWSTACK" for mmap
Date:   Sun, 12 Feb 2023 20:53:34 -0800
Message-Id: <20230213045351.3945824-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Major architectures (x86, arm, riscv) have introduced shadow
stack support in their architecture for return control flow integrity

ISA extensions have some special encodings to make sure this shadow stack
page has special property in page table i.e a readonly page but still
writeable under special scenarios. As an example x86 has `call` (or new
shadow stack instructions) which can perform store on shadow stack but
regular stores are disallowed. Similarly riscv has sspush & ssamoswap
instruction which can perform stores but regular stores are not allowed.

As evident a page which can only be writeable by certain special
instructions but otherwise appear readonly to regular stores need a new
protection flag.

This patch introduces a new mmap protection flag to indicate such
protection in generic manner. Architectures can implement such protection
using arch specific encodings in page tables.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/uapi/asm-generic/mman-common.h | 6 ++++++
 mm/mmap.c                              | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..c8e549b29a24 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -11,6 +11,12 @@
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
 #define PROT_SEM	0x8		/* page may be used for atomic ops */
+/*
+ * Major architectures (x86, aarch64, riscv) have shadow stack now. Each architecture can
+ * choose to implement different PTE encodings. x86 encodings are PTE.R=0, PTE.W=1, PTE.D=1
+ * riscv encodings are PTE.R=0, PTE.W=1. Aarch64 encodings are not published yet
+ */
+#define PROT_SHADOWSTACK  0x40
 /*			0x10		   reserved for arch-specific use */
 /*			0x20		   reserved for arch-specific use */
 #define PROT_NONE	0x0		/* page can not be accessed */
diff --git a/mm/mmap.c b/mm/mmap.c
index 425a9349e610..7e877c93d711 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -46,6 +46,7 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#include <linux/processor.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1251,6 +1252,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (!len)
 		return -EINVAL;
 
+       /* If PROT_SHADOWSTACK is specified and arch doesn't support it, return -EINVAL */
+	if ((prot & PROT_SHADOWSTACK) && !arch_supports_shadow_stack())
+		return -EINVAL;
 	/*
 	 * Does the application expect PROT_READ to imply PROT_EXEC?
 	 *
-- 
2.25.1

