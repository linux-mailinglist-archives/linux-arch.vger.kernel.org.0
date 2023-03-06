Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881726ABB3E
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 11:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjCFKME (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 05:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjCFKLr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 05:11:47 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD59425BB2
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 02:11:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bw19so8155314wrb.13
        for <linux-arch@vger.kernel.org>; Mon, 06 Mar 2023 02:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678097453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weWfeZkDaALdlCN7T+PClJcshI29q8M+O1TZXldUmNQ=;
        b=f8AO3Plti5z+WQY9/XMgHo9coDoPSePct2arJdhJ/EIFxMcdcjn3AlsVdepMgBZPW+
         mWl7NyE3URpqAd0tkZFAqVFMzUTtpnBAV3zqYfSk6Ry3/DfyXz+43T7rgOoofTpVN2RX
         U3G2GrWw5XJgacQNy2x41kSTkqjB29r+yj6dOz5aPgQqIxYJRL5yf/Bs/saxp7U+A3wA
         IsC+RVcCMh74kmQv0hVGBHlWoFAdJbJOJxckQLPLFbirjBuzoRk0MD6WD9eOq5Dxxqrj
         npIxA5uRpz5H+mYlOS1F15SvnwiLC5qQiEQuK3YGV7s0Z8IPnDZPErJBGWxDfcMBdery
         lzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678097453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weWfeZkDaALdlCN7T+PClJcshI29q8M+O1TZXldUmNQ=;
        b=WuL3xqRDFbtEt98IDEznNMGjHI79IY1LzRSRfl/BKBvMKfJYDtYoWfDv2sxyuChKvC
         H//EpuyI6gP6F9BCFGFxcGcULFDSU2zuKj1NW0LHHj1Qi2FsZBhGf1NBiAfCWcKA5qOO
         CyLBU/oZlHIsguws6awYC1F3Il1+b6wQbSkQoQ0GJPa43n+YSY5wYTmvBczRmyvfoR0p
         q+oMdSl08N5MhecMPlxoh9yAmFxOrt/RWJC5wrb2HiKB84xH4YpS3S5iOSsMm0UCC7ZY
         HJqBBW78y4Bcp8cMEYT9uzTru3aVoX8Uvwr2tPumzG8HpnUNSgXHwbw/oQ+VRB9z3gun
         PitA==
X-Gm-Message-State: AO0yUKXTCv+V6/eV0cCuh0uDDl0MMsXwogmARq+YFmCG3sUb3R5NmrOR
        Vy2EZZbF+Owa30aCawm4cw4KVA==
X-Google-Smtp-Source: AK7set+wuauRaErxkLN6soFrHdhxDo377VFWASa6puBBFq9YcYRsyKwZIZbzNS1yvcClJNbCh5XgTA==
X-Received: by 2002:adf:dfc3:0:b0:2c5:5886:850d with SMTP id q3-20020adfdfc3000000b002c55886850dmr5929350wrn.5.1678097452867;
        Mon, 06 Mar 2023 02:10:52 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b002c5503a8d21sm9563973wrq.70.2023.03.06.02.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:10:52 -0800 (PST)
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
Subject: [PATCH v5 05/26] m68k: Remove COMMAND_LINE_SIZE from uapi
Date:   Mon,  6 Mar 2023 11:04:47 +0100
Message-Id: <20230306100508.1171812-6-alexghiti@rivosinc.com>
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
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/setup.h      | 3 +--
 arch/m68k/include/uapi/asm/setup.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/setup.h b/arch/m68k/include/asm/setup.h
index 2c99477aaf89..9a256cc3931d 100644
--- a/arch/m68k/include/asm/setup.h
+++ b/arch/m68k/include/asm/setup.h
@@ -23,9 +23,8 @@
 #define _M68K_SETUP_H
 
 #include <uapi/asm/bootinfo.h>
-#include <uapi/asm/setup.h>
-
 
+#define COMMAND_LINE_SIZE 256
 #define CL_SIZE COMMAND_LINE_SIZE
 
 #ifndef __ASSEMBLY__
diff --git a/arch/m68k/include/uapi/asm/setup.h b/arch/m68k/include/uapi/asm/setup.h
index 25fe26d5597c..005593acc7d8 100644
--- a/arch/m68k/include/uapi/asm/setup.h
+++ b/arch/m68k/include/uapi/asm/setup.h
@@ -12,6 +12,4 @@
 #ifndef _UAPI_M68K_SETUP_H
 #define _UAPI_M68K_SETUP_H
 
-#define COMMAND_LINE_SIZE 256
-
 #endif /* _UAPI_M68K_SETUP_H */
-- 
2.37.2

