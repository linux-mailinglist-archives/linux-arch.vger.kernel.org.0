Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B548535095F
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 23:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhCaV2X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhCaV17 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 17:27:59 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373C5C061762
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:59 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p133so2349120qka.17
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lk8inZlzo7fNLcnXaQ1bMqH+Yl1xnIiMxwLQYqKIvN0=;
        b=Vn+IV2jTMQ3qfrTZI0BaCIvipMQjXnOyPVdlyPeO2A1ydhmBtiQ0/KPQbFLprUQsKz
         XEsE22KBNeTSVCxLa9BdhULZj1AuDO/PaWmw/EF9j8xlXX10FsmT0+B+8p/x/fbzZqXB
         ioPa4cOo0iYeLpwms5O94L4r44baMvUxEDLYiQ4o+KUu+SAM7a1CX7s/NWI/L7SfPxrM
         Ua/5ZcXDAjzY32eJHiQGKkogawbLWhdKE06AvSW60VNJY10icae6GpzRlVISoSMCZyJ1
         ZgYMtg4qfAmuFnaNGf+3dlT/SZspW5x0yX39FkVTOC7fQmzwrn8FU2ClEoHTyE8AdE0d
         Bd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lk8inZlzo7fNLcnXaQ1bMqH+Yl1xnIiMxwLQYqKIvN0=;
        b=BuP/ruGpUrBvf+XW7B7mcn94Eripf1iuTo9kaTiesaPYNi3TDr1u9ywLAJpbiAJTE9
         TcxUSwWfzsn0K0kGXocc724wC71BfUKCx8URFcJPjMdqypShJjIt4j4lZ+cYnMr9vPeP
         FCdUFUphhDFFMaQehBFQNKBSo08olGNy9vF5/Ljv3iMeFuE663j1DyRgaNwAi0Hr1Pqx
         +/gm14ycqj756JGCXzWvci+OMeFIGDvo2pPmTc5jYptmE58hBt4R7eK+/ALSW1fkOaOL
         HNzJ/Zv021rDTp2ZauLn9tQSQAWBHzVqKF4N03STvUmlbqOcWCZaLByswO+/DFZRwzQD
         5F2Q==
X-Gm-Message-State: AOAM5338WUpxiQlv5deP3bQOJNi1F5W8aHpN0jSthTOtngFXhByq6KCW
        sUjfgmOoHzlVJDEIyZtIeEJhKh2UUi304daii5A=
X-Google-Smtp-Source: ABdhPJxbLnYVkEE3SX2BDreH5/lfjqbV3qQJ9QM78vYg3uiCL7YeQbGCVkgbIG/Qv+7aSalIOwO+SwFDW3TO97SD7KU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e148:: with SMTP id
 c8mr5184451qvl.56.1617226078315; Wed, 31 Mar 2021 14:27:58 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:21 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 17/17] arm64: allow CONFIG_CFI_CLANG to be selected
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e4e1b6550115..d7395772b6b8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -75,6 +75,7 @@ config ARM64
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
 	select ARCH_SUPPORTS_LTO_CLANG if CPU_LITTLE_ENDIAN
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_SUPPORTS_CFI_CLANG
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.31.0.291.g576ba9dcdaf-goog

