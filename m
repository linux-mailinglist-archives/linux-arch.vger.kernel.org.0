Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD726A7E4E
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 10:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjCBJpO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 04:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCBJpN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 04:45:13 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1958C3B67D
        for <linux-arch@vger.kernel.org>; Thu,  2 Mar 2023 01:44:59 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso1267707wmq.1
        for <linux-arch@vger.kernel.org>; Thu, 02 Mar 2023 01:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677750297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJ/facwMevNvMOFuT+io/wp4PUh7lnUX4apz0HoWhrA=;
        b=n3De52PlVt09SWQ0m3FQMKtFqpt7FsMRP7xSvMaq0Gq5vBCCeyjbMxOkI9oFnh/VWG
         R5A3awIwKgTRcFWMyZ4yGzpnqLCf6YUuwuTo5T6ARHvd7Dz9hRlsuwRyo6nzep0gJ5w9
         Yz2Y1JgBQvMiNvx/8dnKzUjQpLSfmpJKCYvRR/nQbO+rBkiu2F1wEifH/ny5IdJg3/FE
         ybp3fd8P4leNoNqxMpwBNJ5KNO/RDsEKr7DAn6IrL98jSlS97EGauoy0NGBmwSFFt6Jh
         LfrO7333YSqJnDuGcdN1lX7gaiUQSEvt0T2bIjHO8d9DcgB7EH0f+odjp6+nj1yKIYjY
         9lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJ/facwMevNvMOFuT+io/wp4PUh7lnUX4apz0HoWhrA=;
        b=xMr3DvHd6sLfmgwAqv2UrFTPB7ybLhdcmVSmTD9aXq4iktmHJ0h+13CQOwumDa35XG
         E9Zrso5OmIPgR8y7FrUPTfjhn7VX6WjrJVJvBRhpgATD2ljFLWHZovUwTbKnGhvzFHv7
         rgn1bL7UX9JnH1RtL1PzWkO8x53DOzPjPSKCkfcZO+x10nfcvi5HwXBQ5TVp7GRaNWqG
         lEj4492vRgyr4VKdrSShL00BNlhhOgKrdpgta1NPHyGjbyVs6lW3HyjoLGhbJnF2vC0s
         DUJeGLt/i8aruLIAqJfeWXyUYhKT88qSHrikUbOXAKvarME49M7WzEa0HKDMT6Eq6HQN
         K8BA==
X-Gm-Message-State: AO0yUKWssxiWRLVhwFibvjgySaMNzM1wI5RWf9TL5VHHmrv9Wdpuj5c/
        mbYihP2NGAOr5XiAjC8PUAFaLw==
X-Google-Smtp-Source: AK7set8ISsp0oQhHffCXBDFlhKwIgUaOaY/EplkRd/H/Un+QFgFiRBjWj17JBzOsjqnab0tlLB6s9Q==
X-Received: by 2002:a05:600c:181b:b0:3dc:4fd7:31f7 with SMTP id n27-20020a05600c181b00b003dc4fd731f7mr6911107wmp.41.1677750297555;
        Thu, 02 Mar 2023 01:44:57 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l3-20020a1c7903000000b003e7c89b3514sm2199619wme.23.2023.03.02.01.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:44:57 -0800 (PST)
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
Subject: [PATCH v4 09/24] powerpc: Remove COMMAND_LINE_SIZE from uapi
Date:   Thu,  2 Mar 2023 10:35:24 +0100
Message-Id: <20230302093539.372962-10-alexghiti@rivosinc.com>
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

