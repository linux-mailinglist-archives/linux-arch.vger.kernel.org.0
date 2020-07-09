Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229E221A8A1
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgGIUIQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 16:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgGIUIQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 16:08:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD65AC08C5DC
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 13:08:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so1263332plo.7
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 13:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=n3uMLnloJ4eoHyrHmlqZET1T4BdruPnLDoTh0ErPA48=;
        b=fc4JFaNMdyj0dPO/QlxHDnNGYF06MrbAFpp8sghfIUTy9dRGb9sGKTljAM/dZfdB2J
         nju7OIrLaeY0xcFvtPbU14enOZWIPr+6Jp7iwm9BOsywiSS4GbXB5LGvfTSgS8MYJQfo
         wa/5mP4c22pL2wlOc0LmsEZ4Hyno4ztpOYJaIV60LjxDcw2YaB+jn5C7ETt4a7WeT4Jo
         GgVwqvFwY3RRSLDCxEOH3JoZcD0ps5TN9GS4uQbmuJUr5TmEvqOHSY4u5HtUexKZn2uE
         xe70ZY3UqKrjiPZd8mUbw8C88c51Lq4w+n/w+kuulNZw/j+fz/5hYb597azr5VWVxm2d
         1PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=n3uMLnloJ4eoHyrHmlqZET1T4BdruPnLDoTh0ErPA48=;
        b=ctH+dNfgLZrEkuu5dxfenOzKL5v/TJsl/fvVxQ3xT5UgEt7jLtysYubZcxr5iz0VH3
         J6TnjjcCcZP7V1fgNrNbaAuhqJ7PTUHMgyepcgS5FN0ObG1S3TAuM6kd4MCiC09NLmuf
         35JRlKurZQME2EQ2jAn8vlgJmfLJPtq2d6oDIp9p4dzrwKV23FS3D6MOwtjf1Qnn2Jw+
         AjxL7BL84dUQ7U9StnskdgXQojkCNV3HjnID1m//aZqxRtOMyHFx6nTaR2GaAV4TGCe6
         TMIiKTXIZqZHTZNcqSupu+7asgd/EqYQRB1FlLb9e8e0j/Awbsb53kMA9lCYx5cqL4fW
         3iSw==
X-Gm-Message-State: AOAM531QIZ/MxE5UNdxaSe4NwEJXSWVbBanZ7/MsBAhquOTKao+fRbSg
        ua7XyMsaFVnb3cquSz04o3mXUw==
X-Google-Smtp-Source: ABdhPJzPLSTzb969rohb6kFQ0eaLxRBJfCFE9pkdCodyKMGtAcVwwZo/EK1rcCJ/fOCGGMRDDpxRxQ==
X-Received: by 2002:a17:90a:f981:: with SMTP id cq1mr1890239pjb.173.1594325295201;
        Thu, 09 Jul 2020 13:08:15 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u26sm3619193pgo.71.2020.07.09.13.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:08:14 -0700 (PDT)
Subject: [PATCH 2/5] RISC-V: Use the new generic devmem_is_allowed()
Date:   Thu,  9 Jul 2020 13:05:49 -0700
Message-Id: <20200709200552.1910298-3-palmer@dabbelt.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200709200552.1910298-1-palmer@dabbelt.com>
References: <20200709200552.1910298-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rppt@linux.ibm.com, mchehab+samsung@kernel.org,
        gregory.0xf0@gmail.com, masahiroy@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com, tglx@linutronix.de, steve@sk2.org,
        keescook@chromium.org, mcgrof@kernel.org, alex@ghiti.fr,
        mark.rutland@arm.com, james.morse@arm.com,
        andriy.shevchenko@linux.intel.com, alex.shi@linux.alibaba.com,
        davem@davemloft.net, rdunlap@infradead.org, broonie@kernel.org,
        uwe@kleine-koenig.org, rostedt@goodmis.org,
        dan.j.williams@intel.com, mhiramat@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, zaslonko@linux.ibm.com,
        krzk@kernel.org, willy@infradead.org, paulmck@kernel.org,
        pmladek@suse.com, glider@google.com, elver@google.com,
        davidgow@google.com, ardb@kernel.org, takahiro.akashi@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org, zong.li@sifive.com
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

