Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E87695BBE
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 09:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjBNIBy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 03:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjBNIBb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 03:01:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B78A22DCF
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 00:01:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso5501211wmo.3
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 00:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qo6bbo2bRyWK11RZrfYsn5sMa7dXFL8PHrhyCBAfahw=;
        b=TMMbRSi/BCE/yErJFR+8mP4kHpzJPnjWYD1LaUx1BM/FJpNCkORSwWkRjLfPsMyQqo
         fulZsqvrZEVPcRzKF+1vKVnCe1gxjJdsKqL5a0Ur/QtPt0cEiklml/LFDMQInlcJXKbN
         3EuzLq3yK0iBVF7Bo1UPCHnmEyjscloEzV6naOlGZOYvtNSv3xVvG4cBi2FvaRmDbucP
         RwobnEOFQiJf2qRFuHMOB187Bn0enZcqtaErAMCGff/IE4dTHZhs8fIIzk3pmvmFm+JH
         xRTgMqgp/xyznDIWlGzaYoXKmkXepF79f9ku6U8W97rBDLEsTc2Cpy/RncixjD8957uR
         v7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qo6bbo2bRyWK11RZrfYsn5sMa7dXFL8PHrhyCBAfahw=;
        b=neELjNkfB0WYa4iKQSoh7PcS1CuAU3NKia4zGoRkHYmF6gdFoFX2qenx09BqduwFFw
         BG5mFovKwGa/+ciHn8y4CMjAHLHjB+26vTs0d/Hf0evkP3Fh92N4KQYzW5PYqmpWZPFN
         a35K7eFAtfi/NlqmlPMIlpj0YCdOWkn8G5K2mOpVHd7ReKs0T40TvgZVpHff8K3PgkHT
         spkNr+UsXWvQ0dybOiV4VkM+AwM10OP7T1tBw7Cll+8N4yv1ukk+HxDhQqw1f66Q5eHz
         qdfoDUQXtS7o9foz/BG+o21zDw7xo/mTRX5Yx/4U4OqwyXJFqZ58XryVTT599n7sCiVH
         wOLA==
X-Gm-Message-State: AO0yUKWskwY5f5/UK+Gvo9FL6VGXOpoHMWUzrpj9LjJNLjmMCBRmhK53
        mkzqBYsS7k2tp5XPkcIsgfXcbA==
X-Google-Smtp-Source: AK7set8IpWY8CpzAPCBWVzNURL5vk19ARmKC+w+wpmjRTy+p7eC6MNgebM0G0jyEe8mq9fD+Zj4AGQ==
X-Received: by 2002:a05:600c:13ca:b0:3df:50eb:7cd9 with SMTP id e10-20020a05600c13ca00b003df50eb7cd9mr1198904wmg.14.1676361677044;
        Tue, 14 Feb 2023 00:01:17 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c459200b003db03725e86sm18139496wmo.8.2023.02.14.00.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 00:01:16 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 11/24] xtensa: Remove COMMAND_LINE_SIZE from uapi
Date:   Tue, 14 Feb 2023 08:49:12 +0100
Message-Id: <20230214074925.228106-12-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230214074925.228106-1-alexghiti@rivosinc.com>
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/xtensa/include/asm/setup.h      | 17 +++++++++++++++++
 arch/xtensa/include/uapi/asm/setup.h |  2 --
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 arch/xtensa/include/asm/setup.h

diff --git a/arch/xtensa/include/asm/setup.h b/arch/xtensa/include/asm/setup.h
new file mode 100644
index 000000000000..5356a5fd4d17
--- /dev/null
+++ b/arch/xtensa/include/asm/setup.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * include/asm-xtensa/setup.h
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2001 - 2005 Tensilica Inc.
+ */
+
+#ifndef _XTENSA_SETUP_H
+#define _XTENSA_SETUP_H
+
+#define COMMAND_LINE_SIZE	256
+
+#endif
diff --git a/arch/xtensa/include/uapi/asm/setup.h b/arch/xtensa/include/uapi/asm/setup.h
index 5356a5fd4d17..6f982394684a 100644
--- a/arch/xtensa/include/uapi/asm/setup.h
+++ b/arch/xtensa/include/uapi/asm/setup.h
@@ -12,6 +12,4 @@
 #ifndef _XTENSA_SETUP_H
 #define _XTENSA_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
-
 #endif
-- 
2.37.2

