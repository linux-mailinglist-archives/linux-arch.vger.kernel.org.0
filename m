Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDFF6A7E19
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 10:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCBJmC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 04:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCBJl4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 04:41:56 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ED83B0EE
        for <linux-arch@vger.kernel.org>; Thu,  2 Mar 2023 01:41:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so1108475wmi.3
        for <linux-arch@vger.kernel.org>; Thu, 02 Mar 2023 01:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677750112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhdZ6IBARLttHQe1cf2NcgGY75q7JNAgsxtr1kT5kgY=;
        b=zI8HEZnvf4t5y6ebBKCBI5/ZX7tu9tPPsF8rlxpWJctKp1CthKb1p+zsGcYqVmI4Ee
         JZPx++vfl0vhO3nwFHLiqXfIq1OmzIvfmddlkB5Q/4pLwTqKCMsehNjPwy7tw0i7M9Yd
         4IrftyXih0VVkJxh3ytCi5zvZgTiexXQuyZgY/3waYweuMaQnpbhT3ziOjjvG27oKxK8
         Qg7emuvJYb2AGykjaaMCdBFj3FqtPMCtoCTr7Sn+Q/xFoSa06PIEZ2YFjDyPlWRggQ5Q
         RVW9j0/76qWvdW+F33OQkSt4Ly2u/y1n4pH6o/C2L5v7AWgbKtA1kTqiBhLc8UXXH2fT
         aqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhdZ6IBARLttHQe1cf2NcgGY75q7JNAgsxtr1kT5kgY=;
        b=NCMgRbRmXHsbtS9+LnOUzGb+epa/P5/LKqcX86WDN8n6zIKXopklrdEu3x12xTfE5x
         BSdJfeLByIQ1jAkM4AuOEI8ac+gxA4gbFE8CfcpDaybcN/PAhjTu58yjsVXx6yeM32Ws
         cmp1w4f23S/JYWo5F8UP0yXr7L3y3f6qFNqFKctEfpKLQ7k7BMeMEk+Mp62+o7zhGlkW
         PavNY0bUQayDTco20keUu8EyMFxPgR2K/DkzuTtBvpybyy8g/A9aARVbV6E9zL7U08U7
         DCmptwXuVnCX+oxCBPrEQEMFHrd2VMotMpV6SzKpHnlW0ab1xrM2CrOkPvrr2pybGaS+
         APuQ==
X-Gm-Message-State: AO0yUKV3/N+dUCZJvNHM/KYe696J/E5U/++LYaJoBls/em31ouYCRZks
        pVDQfs4F9JLc/8WC1sWg8ThSog==
X-Google-Smtp-Source: AK7set9wZDuL3IelqGpYKRcq86ytVsCUcrVzhAG7lidNphlzQ6gIqwSZz+dkDXJn0m3vH7kBzLtoEw==
X-Received: by 2002:a05:600c:310b:b0:3eb:323e:de79 with SMTP id g11-20020a05600c310b00b003eb323ede79mr7088363wmo.6.1677750112484;
        Thu, 02 Mar 2023 01:41:52 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6a45000000b002c5706f7c6dsm14774896wrw.94.2023.03.02.01.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:41:52 -0800 (PST)
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
Subject: [PATCH v4 06/24] microblaze: Remove COMMAND_LINE_SIZE from uapi
Date:   Thu,  2 Mar 2023 10:35:21 +0100
Message-Id: <20230302093539.372962-7-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230302093539.372962-1-alexghiti@rivosinc.com>
References: <20230302093539.372962-1-alexghiti@rivosinc.com>
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
 arch/microblaze/include/asm/setup.h      | 2 +-
 arch/microblaze/include/uapi/asm/setup.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
index a06cc1f97aa9..2becbf3b8baf 100644
--- a/arch/microblaze/include/asm/setup.h
+++ b/arch/microblaze/include/asm/setup.h
@@ -7,7 +7,7 @@
 #ifndef _ASM_MICROBLAZE_SETUP_H
 #define _ASM_MICROBLAZE_SETUP_H
 
-#include <uapi/asm/setup.h>
+#define COMMAND_LINE_SIZE	256
 
 # ifndef __ASSEMBLY__
 extern char cmd_line[COMMAND_LINE_SIZE];
diff --git a/arch/microblaze/include/uapi/asm/setup.h b/arch/microblaze/include/uapi/asm/setup.h
index 6831794e6f2c..51aed65880e7 100644
--- a/arch/microblaze/include/uapi/asm/setup.h
+++ b/arch/microblaze/include/uapi/asm/setup.h
@@ -12,8 +12,6 @@
 #ifndef _UAPI_ASM_MICROBLAZE_SETUP_H
 #define _UAPI_ASM_MICROBLAZE_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
-
 # ifndef __ASSEMBLY__
 
 # endif /* __ASSEMBLY__ */
-- 
2.37.2

