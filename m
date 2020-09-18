Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A172270675
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIRUP6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIRUP5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:15:57 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0011DC0613D3
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:46 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l5so6092972qtu.20
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EemRcLRZpf4yhUCeConvvCXzQf4ZIu8nUiUP+DipgvE=;
        b=OCV4Zse7oPgDcT96RPBXKapnnI9L/7OK6JFTGp6JDIVB8reBmtTJ8x+TgIHV1bQNT1
         yODGYby9kVyQ8p61SLU/yg6HA3AOyBDoEQN4GCtsWbyfUxYsi9LakuSQeiu8C00FOlZC
         nXQlthrKXhecqdBCG42wjEu4ZA8UwNU7ri1WD8DdF01m27taT1VRMqPpDB7d1xzavjQ8
         MAseVvLfwDnKz7Gcqkbl036OnUwQ4zBvKuexGNe7hy44z1WPbLj+0871OLhE9gceGoVn
         2klPRgv3y+JB0+4x23CmEway5+Cp0Bo479FvHgqkdJAIc2SvpuGCJORrGOpziKgZ24iA
         XC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EemRcLRZpf4yhUCeConvvCXzQf4ZIu8nUiUP+DipgvE=;
        b=s4jOkqeZKcc24rnKM/eRyTU2qz+dnlv2nCkfZhyNviiHqKDPuStbs589zt2sTmBxHm
         MfEI6DVF3W2OgtOnujUkRte3UVxBulOMavcjP9VLBVP5+vBu9XAjEk08sIVsL/9qzDSA
         CcSwzU5hdZGamS53vHBqZv+Mc31KoqxqzXSH7K4+FTjiU1TT+wOP+S7P07ypM4tsA6K+
         1pfaGVwGqWIHdbOwA5EB7eRFN9MV536dZe4tGrRT7YCvg3P3nfuOgpYDkI2j2S4i44D1
         1o9qu8ByPADiAcBzgaTwBilhqYAGsSP68IVHUX3To9exQtyb9DXkzX/gLet+1BLRGj47
         tyYg==
X-Gm-Message-State: AOAM531YGDtfQMINKKvVgXMhcsGD2/b5i7d7Bh+cHit4mWfOkm426+Co
        8XeAbChA7bcK91DS3lZZrhQW72YijRKs6EgXPns=
X-Google-Smtp-Source: ABdhPJy7xp/LOuFwPpGGCHEVYRylz0MppKOo/jERMBhhbHtsIbQOQ34wy2DpN2K3SkM1Tla+jQrOeY2Z0njz9hLTvIY=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4891:: with SMTP id
 bv17mr34873677qvb.20.1600460146163; Fri, 18 Sep 2020 13:15:46 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:34 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-29-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 28/30] x86, vdso: disable LTO only for vDSO
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

Disable LTO for the vDSO. Note that while we could use Clang's LTO
for the 64-bit vDSO, it won't add noticeable benefit for the small
amount of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index ecc27018ae13..9b742f21d2db 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -90,7 +90,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -148,6 +148,7 @@ KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
-- 
2.28.0.681.g6f77f65b4e-goog

