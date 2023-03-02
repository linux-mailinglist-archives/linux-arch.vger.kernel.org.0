Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DCC6A7F69
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 11:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCBKBt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 05:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjCBKBV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 05:01:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5E54608F
        for <linux-arch@vger.kernel.org>; Thu,  2 Mar 2023 02:00:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g3so7046182wri.6
        for <linux-arch@vger.kernel.org>; Thu, 02 Mar 2023 02:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677751223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjatsIL5XK1QQSQeDPGE4hkKEq8N3SCj7VakQ0NSqR4=;
        b=Joyk5NhrHhXbmkVlsjdNjv7dcYw86m4IQXIHczn/d6XUPDtRe82TXjk6QIyr/nAcFn
         MX2FQnoHCLHYesMqTw42aFXg8FeamIT9bJtNWCT4XKrQMXs/jktz5/Nx+swnuYN1PRth
         GdeUYDHU8Rq2h+VUt3Z5AaXI0poDy3pXFui49SUz3kEebQhq8gsyZLkWdwQ6+seP70Nd
         CC4VM7zZtrGV37YSvEdV6WxtBpL6mc7M0o8rXEYbsdrz8Cp7qphJJB2Eo6BdJN1Hp8LY
         31w6Brsh9FbsVAudFSGz2JlUD2vPhmH7ibCYajgltR1FOyaPhYccx8K4QTf4rZalSKJ6
         MX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677751223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjatsIL5XK1QQSQeDPGE4hkKEq8N3SCj7VakQ0NSqR4=;
        b=AbgF7aCMQ+xtCoLKdKQWtfvwzyYgwnXZyGsEYhVNUz65C/3XZqP5JO6z8dX4MBYS+w
         sLtPDDjq2A7KpiQ1Op8CG0+1ozi3fpwm2ZQkNLQ8+iP31dlRS53Pl4vJuE68wU7lE8nl
         +ywP1MbgPzvxA76v/Cn9rtA9j6+JAincXvJ9dYpzdlOILHT5epc87ghRkf34+Ugc07YB
         WJP3fGbEINKdHqGUVAaVVCj4+PZ8cDf315FebWvH2M7nq3TFY+Z67a9QJvhiu3HFad+3
         7zbwoDZfHe5E6HLIY1cBqmQlTnq71biEY34CmQWdHo83Pi4Y+eWiIq2UvRRZ27zHp+f8
         fZ4A==
X-Gm-Message-State: AO0yUKUT34Yww8bbXahm46QhHtnNlD7M8Wk1hP2CEviq4CtemtZD2yTm
        ZXVZexxEwbEGuAsQHO4oZDMyHw==
X-Google-Smtp-Source: AK7set/CkJN9ffHE13FKP+VJpVHJ02VAHrAXz8N5LmAg/BmaZS6Y4p/fBx2ye/D55AcGQcIeL/RfNg==
X-Received: by 2002:adf:ce82:0:b0:2cb:85ba:24f9 with SMTP id r2-20020adfce82000000b002cb85ba24f9mr5152414wrn.66.1677751223633;
        Thu, 02 Mar 2023 02:00:23 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b002c794495f6fsm14428724wrx.117.2023.03.02.02.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:00:23 -0800 (PST)
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
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 24/24] s390: Remove empty <uapi/asm/setup.h>
Date:   Thu,  2 Mar 2023 10:35:39 +0100
Message-Id: <20230302093539.372962-25-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230302093539.372962-1-alexghiti@rivosinc.com>
References: <20230302093539.372962-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 arch/s390/include/asm/setup.h      | 1 -
 arch/s390/include/uapi/asm/setup.h | 1 -
 2 files changed, 2 deletions(-)
 delete mode 100644 arch/s390/include/uapi/asm/setup.h

diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 177bf6deaa27..99c1cc97350a 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -7,7 +7,6 @@
 #define _ASM_S390_SETUP_H
 
 #include <linux/bits.h>
-#include <uapi/asm/setup.h>
 #include <linux/build_bug.h>
 
 #define PARMAREA		0x10400
diff --git a/arch/s390/include/uapi/asm/setup.h b/arch/s390/include/uapi/asm/setup.h
deleted file mode 100644
index 598d769e76df..000000000000
--- a/arch/s390/include/uapi/asm/setup.h
+++ /dev/null
@@ -1 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-- 
2.37.2

