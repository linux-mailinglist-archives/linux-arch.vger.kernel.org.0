Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A90F21A9A4
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 23:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgGIVUa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 17:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgGIVUZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 17:20:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB73C08C5DC
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 14:20:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a14so1560904pfi.2
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=n3uMLnloJ4eoHyrHmlqZET1T4BdruPnLDoTh0ErPA48=;
        b=Ti4pfq5hVT7B54E4TaVMVrAeYHki2ArpgjGeSYrfCb/iDXle+vyTyvA31jiZOyXBgH
         lmiJDL4QhUKORseAo9uCFC/RcRTq82RhEBkOgw9HsNYg/iY5PfxwXLnbbitN9Lo5KUsv
         jQ9IwmWEyi7fpghdnLVek5+NXVFPmumgd0ODHdxhTr01UfTuHtHNvwO+dc9ZgNDonQl0
         HnnjedGHGBDZOylRUIXE7Mz0VZ8i/azvN0xXdnAQ/oNHMowrSHWERiG/zIRTcVCRijMZ
         y6PonQUen8yRH6LrlgjRpn7SMjeQxjsFeCDvNqHhm9pnLKmGNeT/EEdGPxO5tev+ny6W
         gdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=n3uMLnloJ4eoHyrHmlqZET1T4BdruPnLDoTh0ErPA48=;
        b=UrFgLSGNmU47nDTtQajrGTwP8FMwdkOot0EiWBib2TfCy6EQEaxoJd/mIlida5ac6G
         TLIPkPvEi+3DyCi0nKr32zeTXi86IXKJ10Wd9xsPCqx+6mamsedIp3Y4fydfUI/1x88c
         21bbxz9SOSO6aISa7NXzn3BDD3h3hzoJ/U70IR3su2+CDdU7UfM3FkmQwWak6CFC5N6x
         C73AXNKJULh2s9sUexABwvTLR74GLAMRGINnHlyzIbrkoYvvod5KhJGfNjXFFAbKJR0a
         HnjLjrnIPEDN6tPdPARxoaBhruHKVS7CfkCBxgxAAzfHoNBtsSAcXSzKzsrtCAbo6DxL
         C9gQ==
X-Gm-Message-State: AOAM533HGaZzAw4BXtfBQSRS5hqaYBCtLztzjekBby4a1Vp48VshSwIE
        yvMDg0WXUt9yhZZhRkMU4wMO7g==
X-Google-Smtp-Source: ABdhPJwAFW4C6tY74gfZvPffqn4h7O2BREWMy0oRJqf5W76z8L2GT69ClyF9O+6eRuT8V2YNIFJhZw==
X-Received: by 2002:a62:7505:: with SMTP id q5mr56034672pfc.262.1594329625096;
        Thu, 09 Jul 2020 14:20:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d65sm3660443pfc.97.2020.07.09.14.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:20:24 -0700 (PDT)
Subject: [PATCH v2 2/5] RISC-V: Use the new generic devmem_is_allowed()
Date:   Thu,  9 Jul 2020 14:19:22 -0700
Message-Id: <20200709211925.1926557-3-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200709211925.1926557-1-palmer@dabbelt.com>
References: <20200709211925.1926557-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        mchehab+samsung@kernel.org, gregory.0xf0@gmail.com,
        masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com, steve@sk2.org, tglx@linutronix.de,
        keescook@chromium.org, alex@ghiti.fr, mcgrof@kernel.org,
        mark.rutland@arm.com, james.morse@arm.com,
        alex.shi@linux.alibaba.com, andriy.shevchenko@linux.intel.com,
        broonie@kernel.org, rdunlap@infradead.org, davem@davemloft.net,
        rostedt@goodmis.org, dan.j.williams@intel.com, mhiramat@kernel.org,
        krzk@kernel.org, zaslonko@linux.ibm.com,
        matti.vaittinen@fi.rohmeurope.com, uwe@kleine-koenig.org,
        clabbe@baylibre.com, changbin.du@intel.com,
        Greg KH <gregkh@linuxfoundation.org>, paulmck@kernel.org,
        pmladek@suse.com, brendanhiggins@google.com, glider@google.com,
        elver@google.com, davidgow@google.com, ardb@kernel.org,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com, linux-riscv@lists.infradead.org,
        rppt@linux.ibm.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

This allows us to enable STRICT_DEVMEM.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 089293e4ad46..8ff368a65a07 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -37,6 +37,7 @@ config RISCV
 	select GENERIC_IOREMAP
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select GENERIC_PCI_IOMAP
 	select GENERIC_PTDUMP if MMU
 	select GENERIC_SCHED_CLOCK
-- 
2.27.0.383.g050319c2ae-goog

