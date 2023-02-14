Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20851695C34
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 09:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjBNIHs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 03:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjBNIHb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 03:07:31 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEECBE3BC
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 00:07:28 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so14689645wrz.12
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 00:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZHaQjAFpi9TJWHqFM+95KfED/Q/8XVJn3AfBj+QDY8=;
        b=uZIt+yv3Rg0dRbYtDO4MuhueIjGb9TAYKqCyECWZ/pl6kxcq/ZScMcW17uh1gUaGLt
         hGAhN58F78Lif0nQk9GYnmDx6JH71+3XdZrEkBug2V0DL2r8JwhMszUTSoUtEy5uL4g1
         MZhmBB468Ai2JKrumBevQN+BKMFUchLI/sX3SYNDKBGJSigvT6owhO74tn5mcs0e62Hi
         5CKGwVDlVzcCqv7RBOx+1FJHSFG5dnETFIa/vgkhtiRl918Ndaz2UhLZ50OtWgHYQ5sc
         Mm8kKOB4GLKYExB5Z36oYFZFv2SKt/EzPmlelXOzJOpWGnGPt3qNyRJWHMdrETdBXG2y
         7CKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZHaQjAFpi9TJWHqFM+95KfED/Q/8XVJn3AfBj+QDY8=;
        b=oooFWKaOuQZqV2beIMoCQdMLzr/mxQdn4LOx/hoNiBos9VUayEgTwWdDTmflp1zXyL
         uQgKZz5Xqlhi9ylUFxY77W4QmgUOWZrgc+9QTdta3OZeNx1RYjvBRUVdGxqOLQTVbeVU
         /w1aadvfO9t3cIZtBtUoyNF65yUDlfTHumHDCUkO5bJFILxQXcDzmC+Q3n+On6tWxhcy
         5Njve1KUPmqGfrGoVlpKKkwhHrO+eDF/DjoWJWJ2g0iQSWoabJXF2pfVeKEmV2hvEaND
         6qL/jNSlF7MQFslFo5GARwc3EfVrlhLLOhqDlB/TyGhl9s2vn1W3EcuD7ruJDlD26W5R
         mzog==
X-Gm-Message-State: AO0yUKVLC9TGl/XHmVjaiczLwuViS6h0jhtSr6sO8n7Y1rH2xzZ7mvFb
        4KfC/lDd686/xnloD7NUjSIGLA==
X-Google-Smtp-Source: AK7set9WUVgu+/boPjRArE+Xd9tL/6RHHSSKqaOX0kxjfwjWsxLCB3J5swxsFqsjW07vMCivTOMoSw==
X-Received: by 2002:a5d:5943:0:b0:2c5:5ef8:fa3c with SMTP id e3-20020a5d5943000000b002c55ef8fa3cmr1266621wri.52.1676362047476;
        Tue, 14 Feb 2023 00:07:27 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id t9-20020adfeb89000000b002be0b1e556esm12246547wrn.59.2023.02.14.00.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 00:07:27 -0800 (PST)
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
Subject: [PATCH v3 17/24] microblaze: Remove empty <uapi/asm/setup.h>
Date:   Tue, 14 Feb 2023 08:49:18 +0100
Message-Id: <20230214074925.228106-18-alexghiti@rivosinc.com>
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

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/microblaze/include/uapi/asm/setup.h | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 arch/microblaze/include/uapi/asm/setup.h

diff --git a/arch/microblaze/include/uapi/asm/setup.h b/arch/microblaze/include/uapi/asm/setup.h
deleted file mode 100644
index 51aed65880e7..000000000000
--- a/arch/microblaze/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2007-2009 PetaLogix
- * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _UAPI_ASM_MICROBLAZE_SETUP_H
-#define _UAPI_ASM_MICROBLAZE_SETUP_H
-
-# ifndef __ASSEMBLY__
-
-# endif /* __ASSEMBLY__ */
-#endif /* _UAPI_ASM_MICROBLAZE_SETUP_H */
-- 
2.37.2

