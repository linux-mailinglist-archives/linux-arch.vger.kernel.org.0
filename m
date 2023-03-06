Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C260A6ABB6F
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 11:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjCFKP4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 05:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCFKP1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 05:15:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16478252BC
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 02:15:01 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h14so8206406wru.4
        for <linux-arch@vger.kernel.org>; Mon, 06 Mar 2023 02:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678097699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwBZgJx9HyrLwqA+EFd8z8zPLSYPP3iOweDmVQSMSI8=;
        b=XVTaQziFZWfnDAXt3X7ss243oaqBfQgxq+BWI8wvM/1C4Jd4ZzaN9gn/iZ6cq8OFgY
         wZ3QMWE0mW5K6zVtrJw+GuBOkKmivmkKNKt+HA4sY8SW+lVWK6t4Xdx7hHjeI2kulIu8
         DGk2zu3MgwM2pbh+ZG9wfkwP5y6mVUn+9mA39OoKqGsY7KsbMNSA2r4Z+RlHKij28HMZ
         XpALxRTmTUubTNBw1UPGnRpKtcibbj3CRft/KrGZsvz1bBBKISHl2eALdUyLAXcmz+Wl
         p/aT307puoZZw41SQvTwImFZlATzx5EOyNYFw5ZOH/h/qgSPFH0Vr8ZGsJgSweYFvNRT
         QOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678097699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwBZgJx9HyrLwqA+EFd8z8zPLSYPP3iOweDmVQSMSI8=;
        b=Yf3xF1YfwWbxn2/0c/6GbWp3WmkvelomzJnWnF9BYsTiUnIdLodMQx4hlbyg4ySo1m
         UjDjQsPuCzW9ViFwIwYcflif+afZUKNp1OfuRwnXNLRihFKtDjKHlm28/0jjE4bzmgAb
         mCvmxmicvu/+JnpPHQz96OKzrxFNI7nUJmr4yIz2kdWGbfjPw/7NmyrV/OJ+vLMMsX6x
         rVNyOr0xXhGd5+Wmavkp1yjKTt887Mr5E7b6Poeq05tLZnO3i9mNq2ilhzENYy4ZofIf
         aXnYv/Afujxz3IfgE1ZGkQNqyMqjNkT07JJRAIyjLCMlZ2wX9OqfcWx1nrPr3zaMIX1w
         gpkA==
X-Gm-Message-State: AO0yUKXKumd2UMf0/R9z3KKjo22whBny9Fj2sGCjz4pCUAphhldCZ3j5
        5hgasO7t345lcl/mB3e0eVZC6w==
X-Google-Smtp-Source: AK7set/uLH9lFfoz7JImjvfENjs0N7u07wbWcQReS3sy6jc924z7ZBRg6wmS7ex5s6IqMONld5PFMQ==
X-Received: by 2002:adf:faca:0:b0:2bf:cfb4:2e1 with SMTP id a10-20020adffaca000000b002bfcfb402e1mr6571965wrs.45.1678097699558;
        Mon, 06 Mar 2023 02:14:59 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id g11-20020adffc8b000000b002c7b229b1basm9443048wrr.15.2023.03.06.02.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:14:59 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 09/26] powerpc: Remove COMMAND_LINE_SIZE from uapi
Date:   Mon,  6 Mar 2023 11:04:51 +0100
Message-Id: <20230306100508.1171812-10-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230306100508.1171812-1-alexghiti@rivosinc.com>
References: <20230306100508.1171812-1-alexghiti@rivosinc.com>
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
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/setup.h      | 2 +-
 arch/powerpc/include/uapi/asm/setup.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index e29e83f8a89c..31786d1db2ef 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_SETUP_H
 #define _ASM_POWERPC_SETUP_H
 
-#include <uapi/asm/setup.h>
+#define COMMAND_LINE_SIZE	2048
 
 #ifndef __ASSEMBLY__
 extern void ppc_printk_progress(char *s, unsigned short hex);
diff --git a/arch/powerpc/include/uapi/asm/setup.h b/arch/powerpc/include/uapi/asm/setup.h
index c54940b09d06..f2ca747aa45b 100644
--- a/arch/powerpc/include/uapi/asm/setup.h
+++ b/arch/powerpc/include/uapi/asm/setup.h
@@ -2,6 +2,4 @@
 #ifndef _UAPI_ASM_POWERPC_SETUP_H
 #define _UAPI_ASM_POWERPC_SETUP_H
 
-#define COMMAND_LINE_SIZE	2048
-
 #endif /* _UAPI_ASM_POWERPC_SETUP_H */
-- 
2.37.2

