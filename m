Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969A43523FD
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 01:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhDAXeJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 19:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbhDAXdy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 19:33:54 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1B4C0613AF
        for <linux-arch@vger.kernel.org>; Thu,  1 Apr 2021 16:32:57 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b21so4244026pfo.0
        for <linux-arch@vger.kernel.org>; Thu, 01 Apr 2021 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z8NWn4jVbToJav0h5JmVWRAqRYl6h2XMv8WXZ63o+ic=;
        b=sWQZYrnybic/Guuvi4FLa32pcaoh1lAqAMERMtk/3AuG1Snas/3tmCJ9HTS8KD0KZ2
         DIyS6n2azDelH2lWTJyz9wybfQaWqBpe11BGARLCpeQggnLYl/XP3Uj2cZa4+SKz8VAj
         p/n4GcFQfdHxAybtZn/J3po7/veQAWAlQ2mjHxxTyIclKOPD91Aizuo/JF+Ek1nZGDY9
         kP6kMCtYS0ikKI7mEz2VJvvBuMrXxK7XSAz05VZV8iRsy0FnY7iO/NYieB2Y9ImEF2Rs
         33dX8T00jNHrkpZ0goIKWVOkD5UvlkwqOmlx9stTgcls1OksOdYC6jX0eL53aBEnGzNo
         zx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z8NWn4jVbToJav0h5JmVWRAqRYl6h2XMv8WXZ63o+ic=;
        b=B0ban8kwK9m/AWti6cOgBqvGlTGE1Rths5/BIcRbp1+d9KD/2oqPjb9eW8S4Cd6YQp
         pe6HWHQM5S+1L/RcYr8UKUlUdT2XL9PdfPiEWc2ObgmzYcHwxw5+cNwxeZUug5dpR2q4
         77g3unzkEcWovyX9iK6Il5OricXvryr5FVU2FI7kcCsfzETny/NkzZwuNF4z0IRMgIPv
         2M2i3G/tf0DGCqXosD2McmsN4lfZa53QGVnAYQvrDqajN4Mm5A6c4h+at+YYwkcx8BdO
         FKG2XIXVRL8H9Qc4R1D/D46B+cUKYbuZTgLnWPt1MEZ9wdkYu4rcWXmjxsN1vmu2dzEl
         dkow==
X-Gm-Message-State: AOAM531ZoG8nSDOMRrJCDFXVaj0APoi7HXEyhsNE5zn+dZfXdSjNKUbl
        6fS/5Bgm3wdV5qEXSRWzwi6EaacCwxxdOahGR8Q=
X-Google-Smtp-Source: ABdhPJwiZbq9c4iXijVEYKsvmSZncty9LqawpPJhjxnXl2iNWMREeFwCFILyiiZ0pCK1rOKFlzrry48vXGoQ9XxlZv4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:c711:b029:e7:3d4e:8149 with
 SMTP id p17-20020a170902c711b02900e73d4e8149mr10140878plp.38.1617319977301;
 Thu, 01 Apr 2021 16:32:57 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:16 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-19-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 18/18] arm64: allow CONFIG_CFI_CLANG to be selected
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
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
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
2.31.0.208.g409f899ff0-goog

