Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918A86ABC81
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 11:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjCFK13 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 05:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjCFK0y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 05:26:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2D525BB1
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 02:26:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e13so8205245wro.10
        for <linux-arch@vger.kernel.org>; Mon, 06 Mar 2023 02:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678098378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Swqwg1ld/osn6FVGiU0tRhJoEIYHACqIeiNcFb5PLI=;
        b=uIfY1NRXzEv+Xx/IYayWVnpzA4exJklrAwIb3ziJrRorM1XluURLNe5sRP/ryqZYpH
         a/ROxZBG/PG3wqXEXFLgmc9IwQJMtJTeJVdZkx9HkTXi3YcloRvI0Ka60lGCZWzAqitd
         s8kb5y1Al5ulup5Y9WUbhZSCqL8VLLE28WkIRRztX5wElA5K0w4aOgqjDYTJquKniuWS
         8YlGMCdIBW0itW/lFwZO+SGXFLtcZlBF8ZuhVhvpM6nHQKyjbreMrzIlhd56H2CyYJX0
         OC/OHVVFh/+iUfAq4Ek70MGaipb61JQEk8RcMhvIfK2xVIBEtu1MYjED6cGdncSMd6/n
         946Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Swqwg1ld/osn6FVGiU0tRhJoEIYHACqIeiNcFb5PLI=;
        b=B0voIACZKNRaNqIrn6HSaT1+h3VQrkcKpWBq1vk4nxNL/pOxyltRwdqnNmFJ+AXX0c
         L6izXAP4n+CxIfSjYDlGepQAbsRmvKEC4YBYNM6OhD9Cij2nSoao7HcxdWt+gYt0PA31
         MPh5ZzFN+USwyTBwAL1OMDQ4zmclmc/2cwLJU+I+g4tGympaIJu6WDqfYoOkc04YqEvX
         JKw9ZYeMZ9W0x2Zk2Duo51AeHeK2CRXMC7V720Xl5WrsnmtTakPsa/9Uj1d7LqYsvyBa
         vJC6IFSGE+i5d8buZ4DbFazGfaA7imQMHuFjU2EnTHycId3avKh12Kflc3tfWOJ3yQVQ
         kpgw==
X-Gm-Message-State: AO0yUKU8hz3mMO6AxUM4L/Q8CfQuyGKhW18ChgnxtPvJEzwN0NdsvtCg
        aXIkYGiPx5f6/ev653fpR3wH+g==
X-Google-Smtp-Source: AK7set9U6fM9Xsgv6YkGBRqVzeGSi+gpLiQEhEz2I65vcVv3MM3OWhwJd6wPw1/siNKByhVwY2r8Wg==
X-Received: by 2002:a5d:6148:0:b0:2c5:5335:73f3 with SMTP id y8-20020a5d6148000000b002c5533573f3mr10413383wrt.34.1678098378256;
        Mon, 06 Mar 2023 02:26:18 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id z16-20020adfdf90000000b002c707785da4sm9415798wrl.107.2023.03.06.02.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:26:18 -0800 (PST)
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
Subject: [PATCH v5 20/26] parisc: Remove empty <uapi/asm/setup.h>
Date:   Mon,  6 Mar 2023 11:05:02 +0100
Message-Id: <20230306100508.1171812-21-alexghiti@rivosinc.com>
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
Acked-by: Helge Deller <deller@gmx.de>
---
 arch/parisc/include/uapi/asm/setup.h | 5 -----
 1 file changed, 5 deletions(-)
 delete mode 100644 arch/parisc/include/uapi/asm/setup.h

diff --git a/arch/parisc/include/uapi/asm/setup.h b/arch/parisc/include/uapi/asm/setup.h
deleted file mode 100644
index bfad89428e47..000000000000
--- a/arch/parisc/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _PARISC_SETUP_H
-#define _PARISC_SETUP_H
-
-#endif /* _PARISC_SETUP_H */
-- 
2.37.2

