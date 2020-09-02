Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1125A330
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 04:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBCx7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 22:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIBCxx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 22:53:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C386AC061247
        for <linux-arch@vger.kernel.org>; Tue,  1 Sep 2020 19:53:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so1588572plr.0
        for <linux-arch@vger.kernel.org>; Tue, 01 Sep 2020 19:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPZJbcEtwfQTjOb/c8yhPFEhILSdoB+KS72tNB8EcNI=;
        b=kCu8hyTcGoY7RYojj6lkArYLYWRPCSJax2BgpnkrA4p6KHwO/KDpfqBFFVqydUb61M
         KelRtaHdh8yEvhXTfGGBKZyqjY4QUC3HvxL/Mnd4l1/NUfthfp/+uqRjf7TZvXRoaXUv
         KtH2K7YG+GNs7sb3j+14YNKypSfg/mtqzN72k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPZJbcEtwfQTjOb/c8yhPFEhILSdoB+KS72tNB8EcNI=;
        b=amureTd9Ydb1C+EUfC1+kIMsbcL2rdytNx9tX+zb5rAEghY8NdyRxnh/a7QjlKmh0e
         rkfP31p6T3bgsEQrStbHyMNYX1iGhAhHdpCgE3LCyIb3K+aDHy/1c+xy8sfEUm8r5s+m
         4rIED8A2nVYPriwgKHAGYHqPtevXgKCmtAeAfJpil8mL+ggDwp1VcUh9Y7jPCtXTogxa
         S85bHxvoSSLtn72rUolFBqGOgFj0fID/WdFENxASRnJE9EuY08j2GZU31xx8OfrMK9io
         MQf4EUVYdCOq4G0WYoV+fYQMOV/X3527Oac40UhxwAxSF+cqxJx5q0Q9/hpbSfD5ttNm
         /y6A==
X-Gm-Message-State: AOAM531LfpQw+2WzBw2GvvfXxZEa2un+wkLz4xpwV1pLf05w1ywd5Tf4
        YMCdS2BPmMGEgyhJ3AeYOilH5g==
X-Google-Smtp-Source: ABdhPJxv9F6zTbZLG31keWGzI4N4ccr5wX8ALy3FKGq8wAk/IzXEKUXCP56QRYBrM4KTWBz2JqF6Qg==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr253940plr.58.1599015232244;
        Tue, 01 Sep 2020 19:53:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g5sm3575074pfh.168.2020.09.01.19.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 19:53:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/5] arm/boot: Warn on orphan section placement
Date:   Tue,  1 Sep 2020 19:53:45 -0700
Message-Id: <20200902025347.2504702-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902025347.2504702-1-keescook@chromium.org>
References: <20200902025347.2504702-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker script.

With all sections now handled, enable orphan section warning.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index b1147b7f2c8d..58028abd05d9 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -123,6 +123,8 @@ endif
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
 LDFLAGS_vmlinux += -X
+# Report orphan sections
+LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T
 
-- 
2.25.1

