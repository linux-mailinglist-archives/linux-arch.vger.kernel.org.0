Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE03C207D6D
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406646AbgFXUeG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406559AbgFXUd2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:33:28 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8000C0613ED
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:27 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r12so2516758qvk.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y5ofKWtW7b37fMwYLfPdHt3IGKVdbeQxX7e2DATRt0o=;
        b=MpnW9sRj+tNBN3TDOB0E4bCD73iqcMpQvhC/oM2fJsIoYTK0vvtDvbgVlrqJ4oIK0n
         hUkrO/tMTdR+N69BPrGONWoZVqr/PGTcGNGx7KoFKTb76Da/RvpOWxtl8VBxl/EZOrgt
         5F9d69yFBuUFcdmnwtkp0D0VXoRY0s2h1Yr7OuAvRe5TUtgm7VwUMLCUarJXBYi3YH1w
         ecgv9j79/kdCnb16j6h9hpiIIbrE81Rw7ot9VeyVU18a4/rQr8YcJy/lwnjNPlRdogMZ
         F7b/c1lcoIWNDz5L2rbw2gGQuBQXJi1K+B1Nnm4G09LoPyPmFpMaZH6DTHw/IetIWtiC
         Gcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y5ofKWtW7b37fMwYLfPdHt3IGKVdbeQxX7e2DATRt0o=;
        b=qE3WAbkDesPlj5enuVFdOxnx17XSBpzvgouXMWt0iMs9tCYUranUPMgJENbuHs8Az7
         TYCD/635QoZnxoGKqVKFd76kucWj6VRNVPwHggqJ2Epj1Qefx0cMr2bIdddPQ6Wbtgbn
         4RbsLVXoHi+7FnYG1ACHRa5yw+xcGfGY9D/9RVglJuUck9R2aPhVnYJFa56qXJ8iPEBs
         HtzTeW4EbNiT4qstmMfSPmNh8ROGuIklbkEyHZUQ8TuBo/kAtJqhj3bxGTo2Cqa2Q0nf
         DaLqN1gNyx0SCjBpsWfweyptLE4wfy2QvGGgbh5lheQeuOpaZ6c9QByPZUx2Lo+gsdTh
         +Szg==
X-Gm-Message-State: AOAM5309snbAJJVDyfaSWu35UfEW/zjCYWTHdRAErHZcdsdbpBa2A0jS
        6eufb8sHc94eZtWDMIsUENm56eEo3s02kKu4OII=
X-Google-Smtp-Source: ABdhPJyJOTQdckiniPybTRC01pO0CmjbQctgmf229uGzKfKGpm1EtRROJM8c/GsGd5lxXSpfxv2hqLta+vkNePH8WAU=
X-Received: by 2002:ad4:4ae1:: with SMTP id cp1mr752045qvb.91.1593030807024;
 Wed, 24 Jun 2020 13:33:27 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:54 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 16/22] arm64: export CC_USING_PATCHABLE_FUNCTION_ENTRY
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since arm64 does not use -pg in CC_FLAGS_FTRACE with
DYNAMIC_FTRACE_WITH_REGS, skip running recordmcount by
exporting CC_USING_PATCHABLE_FUNCTION_ENTRY.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index a0d94d063fa8..fc6c20a10291 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -115,6 +115,7 @@ endif
 ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
   KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
   CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+  export CC_USING_PATCHABLE_FUNCTION_ENTRY := 1
 endif
 
 # Default value
-- 
2.27.0.212.ge8ba1cc988-goog

