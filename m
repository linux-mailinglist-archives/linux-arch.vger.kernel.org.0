Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC6C695C38
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 09:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBNIIf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 03:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjBNIIc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 03:08:32 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DBC4EEC
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 00:08:30 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso10873310wms.4
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 00:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyJad6DESnZ256fhxA8bHesaXxO8dG/mPAVgfV58f6Q=;
        b=KxydN/OER8BSTkZprK4GQuQ37SCzFfF8F7nYPrALwYIhNfjrm/iYvkH8VHUKuWljc+
         hJyGkg/DL90Xfd3/okg6L0KzhuITpBNfbia3+S/fAK125Ld0kZhDA7eIlQxw+Xw3dkT/
         aj7aiQvBLhS5B8flYpPrieoVs9sQYS/U/d/InNnelnlguIeFUUtfjunMESQtOkqWbUre
         0p2y8ksgJKMjHBB/D5NBl5ZQwQ2LKcpSbWYGBzuXkyZiix752T1VYYWIXRHDTinKb1tU
         GVrcW8XhUkirbV/nWwdIfLjqo49ekG/ObANDCnvi9dmdJjcnTcfFXFmPFIr6rbAyJRMV
         RbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyJad6DESnZ256fhxA8bHesaXxO8dG/mPAVgfV58f6Q=;
        b=PV89FEEjy6SLgLS10zhBKMUijueLh6slgYJig0uG7Z51tE7ME5kOGFVvVbdaVK97qH
         PF+cnv3hbLLjEbwXq+8pDSCoYQ3VJf5MV3YShCT4q3FJR8vCE50bAFGoV0TOHes7X9xq
         ZXMFu1KtxugPN5fcKJW7MQw+/UabO+MXYjvXNXS1bJxdF97v8e+hielmpz1NvExflYqd
         5EuYP/SCjpSpEJC4TFGihvxuZvV5mZB4dNssIDuPix09WbPIpPX4XRitYzor7mZb1RuD
         RVi5QxxDKeDiEAjL9X3NcnBIR1K0CGF4eCP2FbexERUZz+oqftbg3pN7tvo0mkRm+y9r
         cR1w==
X-Gm-Message-State: AO0yUKXnUsEOu1ODGTpDhiyhzhNruArQLj4wu+MuAsZnbYcsvghkX+b7
        W/AF9pHvGy9OQ2kbpYmXEFX/DA==
X-Google-Smtp-Source: AK7set/yO4PV5gq0EJbG+vnFnrIiAFQuyxqQz9U7rGQ0C4aBtVOu7GwxW5NGHi/BdSTlV9F3RxNsHg==
X-Received: by 2002:a05:600c:538c:b0:3df:f85a:4724 with SMTP id hg12-20020a05600c538c00b003dff85a4724mr1181315wmb.39.1676362109149;
        Tue, 14 Feb 2023 00:08:29 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003dfe57f6f61sm15477391wmi.33.2023.02.14.00.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 00:08:28 -0800 (PST)
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
Subject: [PATCH v3 18/24] sparc: Remove empty <uapi/asm/setup.h>
Date:   Tue, 14 Feb 2023 08:49:19 +0100
Message-Id: <20230214074925.228106-19-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230214074925.228106-1-alexghiti@rivosinc.com>
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
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

From: Palmer Dabbelt <palmer@rivosinc.com>

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/sparc/include/uapi/asm/setup.h | 9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 arch/sparc/include/uapi/asm/setup.h

diff --git a/arch/sparc/include/uapi/asm/setup.h b/arch/sparc/include/uapi/asm/setup.h
deleted file mode 100644
index c3cf1b0d30b3..000000000000
--- a/arch/sparc/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- *	Just a place holder. 
- */
-
-#ifndef _UAPI_SPARC_SETUP_H
-#define _UAPI_SPARC_SETUP_H
-
-#endif /* _UAPI_SPARC_SETUP_H */
-- 
2.37.2

