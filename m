Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A11695B6C
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 08:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjBNH4r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 02:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjBNH4c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 02:56:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9119C21A15
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 23:56:10 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso4581528wms.2
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 23:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhdZ6IBARLttHQe1cf2NcgGY75q7JNAgsxtr1kT5kgY=;
        b=WUnQautY0C4VnR179UT3EoCgDMh692PX4JIH++p5EPvA1yrRO/fl+UiJJROeSG56Yd
         auQNeE8xqAyEf2IHwlM8Mj9jimF0w+QT0uVnsG4fXjaKwWGWrlEj1LzF57NiupT0LR6o
         bmTpD6Q5aa1n+5RVS1uxfUzvjrBt7j3ahNAKmewc/SJFd0wUI235VxB1hzncC1Zwofn4
         iTxWoEUEDV/EgpiqiXMLeqy9nMGNFgyZOQKozpWaPfsGJXr8kf9J4mLtVL7bqCZOI0Sa
         86d5rOYBfoFKhmFjCdMHzcpyZzXumz+WTxxqPTlVAK+W5T/30s7a7qUBT+LxpqB5vQJs
         GczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhdZ6IBARLttHQe1cf2NcgGY75q7JNAgsxtr1kT5kgY=;
        b=kEZySox2Gceztsv9A2Mx3XIjZsVVw27PjKOw+zX/GTI+llbBkZAdNrJsImDJvCwa8G
         O+KeC012eEyZZWspGQEVIOf2yEliUR3kxrth6fM5fWB0lNxh9HQGVx96MUZB4LVMBvzp
         gtimm19SqFizSaHemg9F8s+a6XFlLt0yYbV9/pHfBLsHaE5tIx3d2V85bhFkFy4nx3RV
         T/66pit0pk+foJK4p+6qTVeAJZCHK9bY/8xchEPX8qcZtwEYRbVx2IUKx25VPIVeJe/4
         T1Sy14EnKWwXNKhPoNHewX26jj2zjwhSgSIkEUFJ0OTV4TlilajgyyZa2dMiDko9tQAr
         k1VQ==
X-Gm-Message-State: AO0yUKXkEVDIUZ6VkSpzK9iAwF+jHTLLBhGyBbCpUskndH7zyOZKFRKE
        j2qM6JmMPfLJVB8Jq/+PoS+7BQ==
X-Google-Smtp-Source: AK7set+5svVjdMsSqau0ZmaI2FYzntenTemQL7K+vXqbwh34mh13dF3yJpt5o+d+QGqy0l0pY1qf1g==
X-Received: by 2002:a05:600c:a29e:b0:3da:1e35:dfec with SMTP id hu30-20020a05600ca29e00b003da1e35dfecmr1257049wmb.4.1676361368417;
        Mon, 13 Feb 2023 23:56:08 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003db12112fcfsm17947356wmo.4.2023.02.13.23.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 23:56:08 -0800 (PST)
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
Subject: [PATCH v3 06/24] microblaze: Remove COMMAND_LINE_SIZE from uapi
Date:   Tue, 14 Feb 2023 08:49:07 +0100
Message-Id: <20230214074925.228106-7-alexghiti@rivosinc.com>
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

