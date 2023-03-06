Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013D06ABBEE
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 11:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCFKXT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 05:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCFKXS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 05:23:18 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB851BEE
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 02:23:14 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j3so5286293wms.2
        for <linux-arch@vger.kernel.org>; Mon, 06 Mar 2023 02:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678098193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZl2MGTEHXobHnZZhmOouSAyxqbSE7xaVKrZmF7qt7s=;
        b=NESzTJWLCuHvu2jDkZyWMECt8+ZgfQONb6h/TRsXr6VUD2HAeHDlqcM6Nthqqzkz7v
         /XzQ0rJtzBQq7CiTOze5MfNbbRu+4/8ZbEx65dW2nXha3bQrnvST4jywyqdEwtoF3G/Y
         tgxUawKTlFnYdfTlJSZeQ3PFy6wWBsoynk1CnOEchdF+Rq8alIT4bCVA2qc9gxo0zG4C
         Zp/r07Uybcy8dUydQmsV+MrCxCwVTedO01H+NQvIWOXLGvNi9DdOiMJuST85gbnwmuUI
         MRTr4SS8W1qczqXPJZwRcOGFC/gmtHrrzzzm45Bn5AIgdPSPCis/l7v34L/4UnIDvP1K
         YOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZl2MGTEHXobHnZZhmOouSAyxqbSE7xaVKrZmF7qt7s=;
        b=NLKASjnUwCqCxSUDAGh8F6zMkvVMk2Kz7HKEQ/xdzAZvYUPMNQd9pubsqIAJmtWRTO
         TFWsyNTvbRI1WmPM1xfUvj7x/hoD84j8g9v4X+G+ZobN6yTtSYYneWSS3arAwinggy1P
         HamDcq/TtsIOnAQvY4fuUthp9I+yoKPNFrH7QYzk/xyN0NQZJSf/9+gmD+UL6Go59fiw
         3vn5BwxjPo4WBMwftDcy/LTgTKvL5O2bbcRKTHoYMjz5gPNFFZhkhwad5AhkvIlxc3n5
         KxEnAZepXVgdV4UKfHm6aMfw7W97DM7FU3/rtbrFhqyBkRW7sN5bh7+z979i4QnBfXTH
         j5VQ==
X-Gm-Message-State: AO0yUKWPlVT1pJVK5KGoaSpMvVV7M5hlU03hg6vnyY8r2b5P24JgiiO5
        kauymUCJanEak1/wygrBs9iw0Q==
X-Google-Smtp-Source: AK7set9vWVaVCOOnIsSW+KUGTszYaZVeSK3EcYRFpJTaLv/dYXycsieLeu7NM1JRjz4B48GZSjlpmw==
X-Received: by 2002:a05:600c:4ecb:b0:3e7:b17f:9af1 with SMTP id g11-20020a05600c4ecb00b003e7b17f9af1mr8981864wmq.22.1678098193096;
        Mon, 06 Mar 2023 02:23:13 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id n18-20020adfe352000000b002c567881dbcsm9415027wrj.48.2023.03.06.02.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:23:12 -0800 (PST)
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
Subject: [PATCH v5 17/26] arm64: Remove empty <uapi/asm/setup.h>
Date:   Mon,  6 Mar 2023 11:04:59 +0100
Message-Id: <20230306100508.1171812-18-alexghiti@rivosinc.com>
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
---
 arch/arm64/include/uapi/asm/setup.h | 25 -------------------------
 1 file changed, 25 deletions(-)
 delete mode 100644 arch/arm64/include/uapi/asm/setup.h

diff --git a/arch/arm64/include/uapi/asm/setup.h b/arch/arm64/include/uapi/asm/setup.h
deleted file mode 100644
index f9f51e5925aa..000000000000
--- a/arch/arm64/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Based on arch/arm/include/asm/setup.h
- *
- * Copyright (C) 1997-1999 Russell King
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_SETUP_H
-#define __ASM_SETUP_H
-
-#include <linux/types.h>
-
-#endif
-- 
2.37.2

