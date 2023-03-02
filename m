Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3A76A7DCD
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 10:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCBJg7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 04:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCBJg6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 04:36:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8B238E85
        for <linux-arch@vger.kernel.org>; Thu,  2 Mar 2023 01:36:45 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l25so15873644wrb.3
        for <linux-arch@vger.kernel.org>; Thu, 02 Mar 2023 01:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677749804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzM+xDlvnOMEGzjeXRPSkpQm3q8SwokJ4gg6O0qi4nk=;
        b=2pKwrvWIyRi1OpIA1AfAvL3QfUnAmkzXMVZnDdYszZoGfKVRU7Y7Cg00FyqlVMAfzR
         8KlQggPnGWQzsGSEwXZKdlUAPPE/CzI6mENSGPUNC7TJzGm4piwA2sFuDu6AZk3OrPZ5
         jUTsjMfkhZt2pEIwEO00Long7JrfP10J+5zHSxBm8gOp+WEHDzueNJcprrOdnrLd9geN
         /fMRarw42gqFzn7wEDXX9VYME2EGY62hMrCuB2dGWNTpfH+fHchkHWK7Xi84tVLWepzD
         ug8wKExaiT/HyV/tIIiv8zBp3497WkVWRWojXOWeIiWOgBYuevFlPmQ47yK7c/rvtU27
         cpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677749804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzM+xDlvnOMEGzjeXRPSkpQm3q8SwokJ4gg6O0qi4nk=;
        b=38+xfleOIMXzIQXak3X1xYqzBy+4GYYIesT2vxo3ZRVbJ084aJ+KQljM6b2qJi6KOC
         EedXCCIekDNP2R4Qtn6srEHO5A+IpfohVabRUi8/GwhchlBtfCEhJyXEwHeC2242wNlX
         ue/Bc1c6Jj1Q4pXerjniNpXA5TmJEcJXsnHXoncHKb/BTjL4eTk4ufVJwYvDj1Id5jbT
         uzfO6r3tee7CjGYQanLTjOGBV2evQLAmJlI/l3nH+fYwTAI5V/8Jr7ilDL8lYc+/obN5
         DYRx52qOGzPpQbnbyFyJR0zyiI+hucgxDMg+KW3kAAdLwD6mu0Kz/ixs4mhkw2lLm0M6
         Rlcg==
X-Gm-Message-State: AO0yUKVKZKXHt/jyr7EwEkwqsch6s4ylDgk49cGmJB8ZA43Fe+P0FhI0
        6lwi/HN5DSqHq65+pX1ZGL7kng==
X-Google-Smtp-Source: AK7set9S0WvRgB6m8Y5j9Er6rP20ohMkWZVlQ7kaeMx2hJnOK1ueaGS8lSOcB0Pgql0gAxTneTtghw==
X-Received: by 2002:a5d:4708:0:b0:2c7:658:f835 with SMTP id y8-20020a5d4708000000b002c70658f835mr8108283wrq.33.1677749803806;
        Thu, 02 Mar 2023 01:36:43 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p8-20020adfcc88000000b002c55b0e6ef1sm15340416wrj.4.2023.03.02.01.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:36:43 -0800 (PST)
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
Subject: [PATCH v4 01/24] alpha: Remove COMMAND_LINE_SIZE from uapi
Date:   Thu,  2 Mar 2023 10:35:16 +0100
Message-Id: <20230302093539.372962-2-alexghiti@rivosinc.com>
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
 arch/alpha/include/asm/setup.h      | 4 ++--
 arch/alpha/include/uapi/asm/setup.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/include/asm/setup.h b/arch/alpha/include/asm/setup.h
index 262aab99e391..ea08ca45efa8 100644
--- a/arch/alpha/include/asm/setup.h
+++ b/arch/alpha/include/asm/setup.h
@@ -2,8 +2,6 @@
 #ifndef __ALPHA_SETUP_H
 #define __ALPHA_SETUP_H
 
-#include <uapi/asm/setup.h>
-
 /*
  * We leave one page for the initial stack page, and one page for
  * the initial process structure. Also, the console eats 3 MB for
@@ -14,6 +12,8 @@
 /* Remove when official MILO sources have ELF support: */
 #define BOOT_SIZE	(16*1024)
 
+#define COMMAND_LINE_SIZE	256
+
 #ifdef CONFIG_ALPHA_LEGACY_START_ADDRESS
 #define KERNEL_START_PHYS	0x300000 /* Old bootloaders hardcoded this.  */
 #else
diff --git a/arch/alpha/include/uapi/asm/setup.h b/arch/alpha/include/uapi/asm/setup.h
index f881ea5947cb..9b3b5ba39b1d 100644
--- a/arch/alpha/include/uapi/asm/setup.h
+++ b/arch/alpha/include/uapi/asm/setup.h
@@ -2,6 +2,4 @@
 #ifndef _UAPI__ALPHA_SETUP_H
 #define _UAPI__ALPHA_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
-
 #endif /* _UAPI__ALPHA_SETUP_H */
-- 
2.37.2

