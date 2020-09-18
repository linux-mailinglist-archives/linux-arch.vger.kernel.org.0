Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E3F27067F
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgIRUQH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgIRUPp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:15:45 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5309C0613D1
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:44 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id m203so5546215qke.16
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vY4wvL91lX+XoPJtjETBJ0Jod2fr7hSe9gEwviH1PQg=;
        b=qivt17C4c3k3DwY8yxkDax/XSYLbBnJNnBYPw2ZM9Gn/ZE0fIpcsHSVm+mQlhKjakH
         ACLHPBDSrN9QhIs+2oMundPSpouSZPRbj9HW414qGcxUL8RP/Qw81qBg3hFyQmOJVd70
         36vk+fW3SMvGQBxWNMXr5dCR/MCgbY301VpVmDNnr0VCgN2sZLUw+BrVWaduLhzw5SZv
         rv8S8puJ+RnceNDh0B4fMoiQfngBeVpOdbwRVQ/hhKlaWSqX5BsgHyNznIZZ8LnydZBh
         YrVXnwczP2gFi6vqoYxTjLvwOSb3+MWNcxlFSbiyja8iKC/0zZ8liDgrrBt8Hk4cr/64
         UQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vY4wvL91lX+XoPJtjETBJ0Jod2fr7hSe9gEwviH1PQg=;
        b=UnVk/49Z3UHkNWZ9sRs+4KiaAwWTin0NZhNDodQKCdtGcBtuLbG750LooHYd2wSjhY
         YiqwPmU0lBUyEosUWKC26ELS0FOMqADApeJFNszwW5uGhXx+un8p/9kL+SvnZjFc3UEQ
         +kjTz4feAVeI8Bruh36TXsdIRrONvmm5HGu8tt5pDJkm0n12gepdPyBOIxgfcENZ5OCv
         zvEAwdv/JAnpGOVUS7R0oyDlfX8tfV+A+aipEU3ivh+yfxNFRytvub8S/NGYluYMTH7x
         IxxY5ew8jDSCQXtJNj0rG2MEGigS9q2Zxz+T2SzLQ8t6MTy32Q8Ib+j5zuF3EOmXbP8z
         +NEQ==
X-Gm-Message-State: AOAM533+zSqnY6v60TzQhyIfV76kJ5hJnFFrP/p3WHzNrr/tBCyEaZsF
        kEFf6rsP3sWR6kJKInZRMFozZCy6Qr5wE/j+084=
X-Google-Smtp-Source: ABdhPJxx/ZB+iAIYYGWthfZ5MCRw4ljJiAxyhQbM9fSoZJcW8J3//Xuvzi/v3xFDYUKOn6kD1n3mDEB16b4Qbpmiyyg=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:55ec:: with SMTP id
 bu12mr35584454qvb.0.1600460143930; Fri, 18 Sep 2020 13:15:43 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:33 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-28-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 27/30] arm64: allow LTO_CLANG and THINLTO to be selected
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..2699fc5d332e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -72,6 +72,8 @@ config ARM64
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_THINLTO
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.28.0.681.g6f77f65b4e-goog

