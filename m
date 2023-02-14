Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28208695B0B
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 08:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjBNHvT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 02:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBNHvD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 02:51:03 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4357C1F5CE
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 23:51:01 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bk16so14660956wrb.11
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 23:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfhnFvdOBMaLaqHchQiBMEzcSlF2Fa7xiydpzk9bce4=;
        b=C2iakMWMXSP/c9K7z5Xrdh2FZ8isHrwxMldv7DFWh875IFzrwvaewsb7pv+pVa32tl
         uGCdv0Gz5Sla77Gz5skt6wbYUcHV0MvrDD91ZQ6pbR0FErzvIa+siHbNV83wcBxe5ArP
         aJt1rzTFYZAlJ16o/6rxYLUe5PNm3Cl+WBlup3rC4VDyDpLzh+6dKa0ocOU49K1pDDRG
         2DU7qDQ8it3t/pBnyu9Q2n/Gn2V8da6o1Pd0nCVDpMY7pf+5XFSyefWucX0xtqrzNgZK
         hOieCgCpkZJ2M+Y8BO8XCPqXTZ1/32v6n2w6GpPqHXYf4CRyUxX7PkOvD2S1cOWpGGyY
         hVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfhnFvdOBMaLaqHchQiBMEzcSlF2Fa7xiydpzk9bce4=;
        b=eo1TPOzBz/bf6QXefaVh3o51iUd+Wv8cA1Uf6So0J+0j7qSipokFVrrUksDRjgecSO
         3FVP5BpcL8RfmssAJ2nCWUGWI7J4h4Hdo92VFaB7QFFEu0MGsx90akeTd+97Rw9AOcEz
         Yo3dmaklrV0sxFcOAp3bCfI81b0Uw0L+EmLhYnEzuobYJzNgBywrBAkUP9KPn6P2kBt6
         JnYFcpmlaFhrGcJm0VSTqspth+SeqGgxRZP5qqRjFfOp4/n9sEYsxdBjVNY/3Fwc89kk
         64v4tzy4mLE0XqGf2/qkzdHQf90V2eMvKGY7/7G6Qad+jvugJSttpr0qlpjcGkvuwLOY
         otpQ==
X-Gm-Message-State: AO0yUKUQ0oDPZ54zSetEipkmN9M5SkM70NtSnqqaNHD72KizW455b748
        sVhJLY1AX+O8C9uojGAywNqziQ==
X-Google-Smtp-Source: AK7set+tz6eryASejtd5hVfxacJT6BORz8YwC4GVnZIt8q/N1OOFFLu4x7zoiximKp+ApGKLpAFEDQ==
X-Received: by 2002:adf:fd45:0:b0:2c3:e300:f5a2 with SMTP id h5-20020adffd45000000b002c3e300f5a2mr1090779wrs.50.1676361059827;
        Mon, 13 Feb 2023 23:50:59 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id f5-20020adff445000000b002c53f5b13f9sm12091737wrp.0.2023.02.13.23.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 23:50:59 -0800 (PST)
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
Subject: [PATCH v3 01/24] alpha: Remove COMMAND_LINE_SIZE from uapi
Date:   Tue, 14 Feb 2023 08:49:02 +0100
Message-Id: <20230214074925.228106-2-alexghiti@rivosinc.com>
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

