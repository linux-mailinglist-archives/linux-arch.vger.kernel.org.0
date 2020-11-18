Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE962B876C
	for <lists+linux-arch@lfdr.de>; Wed, 18 Nov 2020 23:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgKRWIV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 17:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbgKRWIN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 17:08:13 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F1EC061A52
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:08:11 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id y8so2489952qvu.22
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C9kRHDqVxMS9meVJm6Hst0wtaqe3NZ38y9krJFbUxhM=;
        b=Hl0/5xWucUPJ643/PIYI+sdYOG9Js6rvOiCoWjAxZvuk5n0EKu2IQNyuMBh6yuGcq9
         GKmyN/Fjv1jDACb/r2eyKCWMiRaP+4jFOJ6W4iVlTT1s5IuE0w5eW1wzTr9z3qGyZB+c
         1+Ac3lgon9jRiCkfkxGCRfVfPCkQ6vCnGvL8X0mU+VnbyrvK/6C28dCzTrjfsSmgp5BY
         2Jbefx7UjiqpuevCvMPBNA4WlnqB56ySe/GRWbZuQ3g+Xtr0BahoHUIbgF6ovQ/Jl0Ng
         P8wwQ6WGRG+ElcWU389UI3hoPAsl5dsytrkZXsVBF/3XKPHdZFVmlJ7BHjNcimLrN72n
         o+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C9kRHDqVxMS9meVJm6Hst0wtaqe3NZ38y9krJFbUxhM=;
        b=OAGbBsF5PLRctDX8X4s9UonHelcoX7yvC5x9TmjjRp0E9qhKMcSacYv/LvqHg3UMbm
         /H+ahFC7AK+J328rqBPqnlxgJtxgbhmGeRz753Os2MXqKd3V1+AHmQCVknQHjyAqFL+b
         xUuQFQMkImpc4f8oye/dbSPmx2lF4y0K1D3MFBc3wEMSFB4Cea4PkVX/iGKl3hE803zY
         PkOfji2opvNI030ncce8Dy9GrnWY+RscoY+WxQCMhDvyXeJ1vGtZAj4ZfTjIwSRYbeVd
         OKXLBUdO43dcSVpxOwPDMD/N4f8SUUZRQs6ybkDZcsUmu0Ez1NkiMPOZJVUSKzJa5NJk
         ST5g==
X-Gm-Message-State: AOAM533a7/0AgkKxUT95SZpmJ2edRumtxlC7231U14d/yZx8fPO+tee+
        tH1QzHCkhqVzOXNretRE24HU+iFixSOm/NCUMsg=
X-Google-Smtp-Source: ABdhPJypKLtF22I9S60T1xcjNfuT4VKu9ADZC5Cc5ECnuUgqSEfk7aa/seslzQLD9zO17pZOKSThOIghv6j82Kh+Quo=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4e0d:: with SMTP id
 dl13mr7176727qvb.54.1605737290528; Wed, 18 Nov 2020 14:08:10 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:30 -0800
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
Message-Id: <20201118220731.925424-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 16/17] arm64: disable recordmcount with DYNAMIC_FTRACE_WITH_REGS
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DYNAMIC_FTRACE_WITH_REGS uses -fpatchable-function-entry, which makes
running recordmcount unnecessary as there are no mcount calls in object
files, and __mcount_loc doesn't need to be generated.

While there's normally no harm in running recordmcount even when it's
not strictly needed, this won't work with LTO as we have LLVM bitcode
instead of ELF objects.

This change selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY, which
disables recordmcount when patchable function entries are used instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..c7f07978f5b6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -158,6 +158,8 @@ config ARM64
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
 		if $(cc-option,-fpatchable-function-entry=2)
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
+		if DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
-- 
2.29.2.299.gdc1121823c-goog

