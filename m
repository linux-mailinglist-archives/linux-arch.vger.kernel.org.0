Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AC66A7E2C
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 10:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCBJnE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 04:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCBJnC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 04:43:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B656A7A
        for <linux-arch@vger.kernel.org>; Thu,  2 Mar 2023 01:42:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id f11so3968666wrv.8
        for <linux-arch@vger.kernel.org>; Thu, 02 Mar 2023 01:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677750174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEfUyHhSZ3oYgL6bFnxkvE0TCBKNcLgB/+iPRr5Nmfo=;
        b=THlbw0f7YBDWzcp/D7jU91zoK7h+sLtdoKT4dkUxCfNC7PHuf6+xLX1U8YBxxphqv7
         SLKjiOegBsh3QW5ueV3X6lOfAmYpWoOP683+Wd3yzsKexXlrzQWdfzKTHW8pqqspMFWd
         wyysgVMQuZqSpGcd7XWqJBaI/X9IEjsYMQiF7DJjchBM+PeDCPRXaOMvhS73l+o9b+pk
         PByonJmlUdc2j9xadwPPHavP5X6OM0XAlddx7GeWel0hgjNx+cXSk4XiLYDXt0gQv25g
         blcIBuzunKMOcfdHuG4/AZbEI+cqqiGwwt5wcUbhD0LHAezoTL50NxN1le9xQZUVW4vT
         21oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEfUyHhSZ3oYgL6bFnxkvE0TCBKNcLgB/+iPRr5Nmfo=;
        b=f2QomDhFcbdwdV8/dNOG8Btr8k01sV7ZrwO8h+P8/on+PZ+QTVkrqJevC3FyvPYKCu
         gCzdBCZv+k3XNk6GwxiWwjQ4whI2IG6P4mQwnhNR0qpnyh+KY2L9Uf55q/4uaOnFrOlV
         RKMKFohoD9JgBksvv3q3F5DuPa96Bu2fsrvjuLBPY2wNSp64Ej/ITMSpIM3Mo+iGw93d
         tiQ/F+LVxtZnO6tbezlj3+tilAUSSwH8OvJzhRwFk9EcJi+ccOcUQdfa+ZssYHEPHGow
         2kzr6uJTLOBXxVAHX/PovAc7z+mzZ8maHtEAj8Cwbmigub5Gz1zwPr0DrUpQ05UYm8r8
         fdNA==
X-Gm-Message-State: AO0yUKVdqg7tI+xaDfPr05ox9w/N/PXiw2fNbtaBpWmnoxndbt3Ulbmf
        wkzACV9oN7IpQPqnOHvZf2WO/g==
X-Google-Smtp-Source: AK7set/F94zZ8y7FiH0XLMUcsTDHA/cQVmeboRfi75ZoQWq75QeIoOfllfRsQw/U31Sx77gqBykQyw==
X-Received: by 2002:a5d:604b:0:b0:2c7:faf:af32 with SMTP id j11-20020a5d604b000000b002c70fafaf32mr6686722wrt.14.1677750174151;
        Thu, 02 Mar 2023 01:42:54 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id s4-20020a5d6a84000000b002c551f7d452sm15080709wru.98.2023.03.02.01.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:42:53 -0800 (PST)
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
Subject: [PATCH v4 07/24] mips: Remove COMMAND_LINE_SIZE from uapi
Date:   Thu,  2 Mar 2023 10:35:22 +0100
Message-Id: <20230302093539.372962-8-alexghiti@rivosinc.com>
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

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 arch/mips/include/asm/setup.h      | 3 ++-
 arch/mips/include/uapi/asm/setup.h | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
index 8c56b862fd9c..a13b9259b476 100644
--- a/arch/mips/include/asm/setup.h
+++ b/arch/mips/include/asm/setup.h
@@ -3,7 +3,8 @@
 #define _MIPS_SETUP_H
 
 #include <linux/types.h>
-#include <uapi/asm/setup.h>
+
+#define COMMAND_LINE_SIZE	4096
 
 extern void prom_putchar(char);
 extern void setup_early_printk(void);
diff --git a/arch/mips/include/uapi/asm/setup.h b/arch/mips/include/uapi/asm/setup.h
index 7d48c433b0c2..157c3c392fb4 100644
--- a/arch/mips/include/uapi/asm/setup.h
+++ b/arch/mips/include/uapi/asm/setup.h
@@ -2,7 +2,4 @@
 #ifndef _UAPI_MIPS_SETUP_H
 #define _UAPI_MIPS_SETUP_H
 
-#define COMMAND_LINE_SIZE	4096
-
-
 #endif /* _UAPI_MIPS_SETUP_H */
-- 
2.37.2

