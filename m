Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999A86ABBDD
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 11:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCFKWT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 05:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjCFKWR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 05:22:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6D52004B
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 02:22:12 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l25so8236481wrb.3
        for <linux-arch@vger.kernel.org>; Mon, 06 Mar 2023 02:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678098131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llD45vs7BruCqN5Y6LuJ+UdeA+HWMt5VLzqATcaeE3k=;
        b=biuy33Bk2mI4ZMPBuWVd+4iS4s3Hh5qbYt3PjTBlB6xKI3sqAN5/opSaH9Oq2FmLAj
         /Bo+b8SV5ooGWiS/kzLE0AatJKaQQSoDImYsefz7b5oTictITyDKaFbdGHBUaody+kOH
         Ho+ScOf9SGVsXyGS2CWJ2O+ezbS15TOBFh0MVgeTIcv93OFa65f4TG47OPXCTq07neAH
         pPqPantWl3phD1rMQq2bMLpZlFMj7b6XLHIEPyAtb+PjzcONbalR8XfGBJufSVux/cwv
         g/BzVUJlLgeJU7a7nSXyp6X1Dt0ohhIr8wGSwVkMa3b1H78/mrfIdl7RcOsLKEIpuH99
         9WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llD45vs7BruCqN5Y6LuJ+UdeA+HWMt5VLzqATcaeE3k=;
        b=voiegg22x9IgNqK35CNIzpCJuhxpt+e0+j7LUEIUBuXwVIn3Br9Z1KKK9gNtDfm0+i
         ALkB0ybdv2Y772ZjJSc2NxYAwu18BfPSLG7SwPO8Cgu5GBD7zc2X5zV4MBviowZwJ09n
         u/mxUfLJwI2XtsfKYbflqldzR45hM+B7uS7kYuSNKGQLYliZA7VAh8/6/DzHJEbZ0ujL
         wak/VQKUfeDJR63TOxu+qDq8IIU+FbjxKLD+mK1bdQEtZCMQscPjMoJC596LLHnupSly
         GjVSwtDUDA53eBeya2M3orXTLjySizzvAjupJiFvT0OuRHN4dVGomNkfTCgfgVoeOBCD
         QkHw==
X-Gm-Message-State: AO0yUKV34fkHraSZwhBGHKUIYL8OtTF5gfWEFD60hI0AHCCpbvOuvOSt
        t147yh0RHbfy9ZbWN3Po7Pt1iw==
X-Google-Smtp-Source: AK7set9CKdAXw9zT5b2S7XFTgcEiN4kPjtcCTBiE006KHZWMAQkWVtXBrm+fHU347RB7cSb9V0evYw==
X-Received: by 2002:a5d:46c8:0:b0:2c7:df1:a09d with SMTP id g8-20020a5d46c8000000b002c70df1a09dmr6147537wrs.4.1678098131430;
        Mon, 06 Mar 2023 02:22:11 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b002c7107ce17fsm9587322wrq.3.2023.03.06.02.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:22:11 -0800 (PST)
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
Subject: [PATCH v5 16/26] m68k: Remove empty <uapi/asm/setup.h>
Date:   Mon,  6 Mar 2023 11:04:58 +0100
Message-Id: <20230306100508.1171812-17-alexghiti@rivosinc.com>
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

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/uapi/asm/setup.h | 15 ---------------
 1 file changed, 15 deletions(-)
 delete mode 100644 arch/m68k/include/uapi/asm/setup.h

diff --git a/arch/m68k/include/uapi/asm/setup.h b/arch/m68k/include/uapi/asm/setup.h
deleted file mode 100644
index 005593acc7d8..000000000000
--- a/arch/m68k/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
-** asm/setup.h -- Definition of the Linux/m68k setup information
-**
-** Copyright 1992 by Greg Harp
-**
-** This file is subject to the terms and conditions of the GNU General Public
-** License.  See the file COPYING in the main directory of this archive
-** for more details.
-*/
-
-#ifndef _UAPI_M68K_SETUP_H
-#define _UAPI_M68K_SETUP_H
-
-#endif /* _UAPI_M68K_SETUP_H */
-- 
2.37.2

