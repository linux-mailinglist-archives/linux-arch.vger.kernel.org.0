Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2A66ABC8D
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 11:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCFK20 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 05:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjCFK2J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 05:28:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B3E27985
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 02:27:21 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f11so8229302wrv.8
        for <linux-arch@vger.kernel.org>; Mon, 06 Mar 2023 02:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678098440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkOpojqO2OnrnjqWakJ/ssyTb7fIeaWwMcDQKKqwZNE=;
        b=2SGZsdegW2cBo8kqTvJjfFIjyiIe3RlAF3Yg2d3PkCw98QBaJe6s+BTqk6sAhk4Ru9
         x7fyYH3R/rrntqQj+20SwCyMBoNiJLiYg4WuOmQwPJL5b+DF3FDm/orSsIYy2QoXBVXd
         Cdzwovn8N6wE2qNxhoW3UDgdtmZP7Nh0XnCmz0czTNkoRdhMmQH5C5i4wPzm0FnSENL2
         yCQ8iTsDqS3+6TIBvW13lzxa8x1nucKgzziQ/y1owwV6sges+GmrnrvY9v4F/wR0jN9s
         dJNciHWJZZVZZq4DF3TZv9N2W4QxXz9fcom5MmwMFKt9Voj1e11JRoqNawBuW3HhlupR
         GlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkOpojqO2OnrnjqWakJ/ssyTb7fIeaWwMcDQKKqwZNE=;
        b=xeE8/DIaqb6J2uQLhRr+jMlsWG4lOjaczkaWJjFGgSrrkwBW3P4BvO4KCsf7IKc3Cq
         3h8j2Q34PGxB/GllTP6xrrrorxRKUdojxyfLojhNSKjJ/3uu5TYno9lklfkqojTpfJ4X
         D2/64PYwVYNNj9Ctdc1n6mNz3oAKkpmX7jXSRaYnyc92N+6XVR7gYaNWCnmYIc9GX+Dg
         kckOWyOLq1saGlZZHM+KDllfP4zsMydEPSDoYNSVhBfH9YA9Tgou9q/JZPiIwVtGursr
         h5G46hw1/4q7zdbrhiK4wzPlum0DKNAW6ge+e2si0zaRze7vEaB0pppAWj2a1Ct13DGt
         EdrQ==
X-Gm-Message-State: AO0yUKXMp6uZAQMS1qxDlvshCeuObvhbkXdHldlh63XsjHTmQ6D2fadJ
        NpFL1ZGBCnGZCTy6CMbuYIwVPg==
X-Google-Smtp-Source: AK7set8g+/98oO5ZP6uqzBMUSmWnh62L8fRNjgLpgkBPpDr7Mkg4SnpC/vtuHWPhO/s9VWytKbeQJQ==
X-Received: by 2002:adf:f483:0:b0:2c7:46f:c410 with SMTP id l3-20020adff483000000b002c7046fc410mr6736693wro.36.1678098439964;
        Mon, 06 Mar 2023 02:27:19 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d56c5000000b002be505ab59asm9431737wrw.97.2023.03.06.02.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:27:19 -0800 (PST)
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
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 21/26] x86: Remove empty <uapi/asm/setup.h>
Date:   Mon,  6 Mar 2023 11:05:03 +0100
Message-Id: <20230306100508.1171812-22-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230306100508.1171812-1-alexghiti@rivosinc.com>
References: <20230306100508.1171812-1-alexghiti@rivosinc.com>
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
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 arch/x86/include/asm/setup.h      | 2 --
 arch/x86/include/uapi/asm/setup.h | 1 -
 2 files changed, 3 deletions(-)
 delete mode 100644 arch/x86/include/uapi/asm/setup.h

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index f37cbff7354c..449b50a2f390 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_SETUP_H
 #define _ASM_X86_SETUP_H
 
-#include <uapi/asm/setup.h>
-
 #define COMMAND_LINE_SIZE 2048
 
 #include <linux/linkage.h>
diff --git a/arch/x86/include/uapi/asm/setup.h b/arch/x86/include/uapi/asm/setup.h
deleted file mode 100644
index 79a9626b5500..000000000000
--- a/arch/x86/include/uapi/asm/setup.h
+++ /dev/null
@@ -1 +0,0 @@
-/* */
-- 
2.37.2

