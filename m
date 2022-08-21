Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998E459B37A
	for <lists+linux-arch@lfdr.de>; Sun, 21 Aug 2022 13:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiHULgu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Aug 2022 07:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiHULgc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Aug 2022 07:36:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750C12655C
        for <linux-arch@vger.kernel.org>; Sun, 21 Aug 2022 04:36:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u14so10053332wrq.9
        for <linux-arch@vger.kernel.org>; Sun, 21 Aug 2022 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=iRydGNWOVxx1HqAigFxDEMCuXoX5Io4IU5ztqyzaPAs=;
        b=Y1WaN5EAlXdoOlvAydRCG82PKL3F1frMO2Gueklv8Hl+oRlW3+ER52FQNA65qlT4ar
         Z7WCuQ1OFzwV34ttvUMnnPCxnyOST7zPOvFzJnEfB+4j9LdkZRYIp6/YyrcDINihXi58
         Mi56g3YyTvh3AlocFbuYHF9KLeRtMj+gJZRl7xjIB1eNlD6/JSYjnAvfIJHSWd6ub0ac
         OCinSVK1v+4gLgh4cdvz9HZxI3kVUH04Zi9qadv4lPjNlRfWpHjmC5O0WECWQc0OFyyR
         pCJxCnow4Yga7OV0QJIHOuik6NTHAoDHxEufFMcUkn3qy31H1Se8nChjkuwao431/pXh
         hafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=iRydGNWOVxx1HqAigFxDEMCuXoX5Io4IU5ztqyzaPAs=;
        b=5EgG8RGHiBajeFrXPs4ProhGrjE0XcYwQYSwr/6+WTSTTMRjVI2CWZnp6DhGzD+ySe
         npmwEUdGJPWCvjyFVp1CzWj1rsbMjsUVZZZaHw/U1EHM+NCfUGOA3bBLun4LoYsnfK9v
         bb/D0p4wH94DW6B5FWNLcwq3WxMZ8teyxgpTytcGJ2KBKDnOA0YWsrt2/OKcGk5oqPMB
         8XxhJbbNdHx+2EA1Uv8pJq1bEQFHAJsBsP3eEK5xwBM72taZVEE4+uSfzJbW7fyh+CNC
         feVLmCH5qM7VayfJgToZAok67afoUfnE1JuL26oB4H5MJbGK+DK8EXxtED0FF4Dfj4sg
         LmQA==
X-Gm-Message-State: ACgBeo1rXNRzabDTWIC0N/DsDQaEQ/z/SHYNqqTmhk6RokEZyb0koYBH
        XcmTGRbAIfePXFNRSB4DXHG4/Q==
X-Google-Smtp-Source: AA6agR5T0RaXBxKPuBVBjPGUHGtJfc4tSWj3x0g4PlWZixJIT3RipsnS2LEVMZyj6NI4Nvr7MxTB/A==
X-Received: by 2002:a05:6000:1545:b0:220:61fa:64a with SMTP id 5-20020a056000154500b0022061fa064amr8748201wry.174.1661081783798;
        Sun, 21 Aug 2022 04:36:23 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003a3442f1229sm14071361wmc.29.2022.08.21.04.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:36:23 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Michal Simek <monstr@monstr.eu>,
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
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 4/6] sh: use the asm-generic version of cpuinfo_op
Date:   Sun, 21 Aug 2022 12:35:11 +0100
Message-Id: <20220821113512.2056409-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220821113512.2056409-1-mail@conchuod.ie>
References: <20220821113512.2056409-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

There's little point in duplicating the declaration of cpuinfo_op now
that there's a shared version of it, so drop it & include the generic
header.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/sh/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 85a6c1c3c16e..4125494515c9 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -4,6 +4,7 @@
 
 #include <asm/cpu-features.h>
 #include <asm/cache.h>
+#include <asm-generic/processor.h>
 
 #ifndef __ASSEMBLY__
 /*
@@ -123,7 +124,6 @@ extern unsigned int mem_init_done;
 
 /* arch/sh/kernel/setup.c */
 const char *get_cpu_subtype(struct sh_cpuinfo *c);
-extern const struct seq_operations cpuinfo_op;
 
 /* thread_struct flags */
 #define SH_THREAD_UAC_NOPRINT	(1 << 0)
-- 
2.37.1

