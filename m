Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF55520E1E8
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 23:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbgF2VAu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731221AbgF2TM7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:12:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2347CC08EB02
        for <linux-arch@vger.kernel.org>; Sun, 28 Jun 2020 23:18:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b92so7565286pjc.4
        for <linux-arch@vger.kernel.org>; Sun, 28 Jun 2020 23:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0P/zigfbEYVemiv+chkLi1sxk82Ehd4Rswu0BvpDuE=;
        b=G5louE6Uyd2kc+xV2J1VjkFKPj4o3+7iuP5vPYPCWk+r8gutkK73zgcof6KUBrCFWp
         NA/YHDMZXOj7EKNzEtTGayNRzAljV3w+YWfaERiAi1wGVtDGv2A1+AtbnH1n8Rlsjznr
         ZVcm+cqp/UVyef3E1570F2Ni4TsttMaQCB9Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0P/zigfbEYVemiv+chkLi1sxk82Ehd4Rswu0BvpDuE=;
        b=O+oAvdDDFGlY4Uln0ZF/pJJhGFkbWgE7G29xZkg5qp+UGCuOsIpU/92wPDBzqxWlnf
         utRAiPi2y3CzQbrljyiNJM0aY0sF/vr2sn1bwSn34eZiOkuNpB7YlE9coiwwcbJwlqUF
         qTwC0Ggr7GJsiQ1H8vjc5PQZ2mRpQctuy9z3fY4xNX0yZxPAvysgug6i0qlm8Y4DkM+5
         17hhKSVHvWZGS06ZCXek/ZCZ65XQTe+uVqKqg842Q4YKtK0WRa0hbsI1UO41gyFT5SZf
         tWsGUaB3OEnDgokiFARtlPD+ohzmXSHfI5p7ZXVEy6AoVVe6FJpL00/C+DSOOBVKrQyY
         MX2A==
X-Gm-Message-State: AOAM531xMulnsxZGeEKwxYyyPVqCwwvVmMGtU3wt2XkcbFgUWLXmIl9/
        FlKOw38YA6UsyEo8l/uNmYOXYg==
X-Google-Smtp-Source: ABdhPJxGErTr5qdj/h+EXAH5O68jFfE2tqj+62XVCx45BXGt9Nz2IQt9L7atafYyKCZkdIT/G4UB5A==
X-Received: by 2002:a17:90a:8a8b:: with SMTP id x11mr10404879pjn.127.1593411530770;
        Sun, 28 Jun 2020 23:18:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mp15sm17957978pjb.45.2020.06.28.23.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH v4 08/17] arm64/mm: Remove needless section quotes
Date:   Sun, 28 Jun 2020 23:18:31 -0700
Message-Id: <20200629061840.4065483-9-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix a case of needless quotes in __section(), which Clang doesn't like.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1df25f26571d..dce024ea6084 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -42,7 +42,7 @@
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
-u64 __section(".mmuoff.data.write") vabits_actual;
+u64 __section(.mmuoff.data.write) vabits_actual;
 EXPORT_SYMBOL(vabits_actual);
 
 u64 kimage_voffset __ro_after_init;
-- 
2.25.1

