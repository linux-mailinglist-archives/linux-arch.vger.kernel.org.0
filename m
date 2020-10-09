Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD783288E6A
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbgJIQPq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389829AbgJIQOw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:14:52 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAD1C0613E6
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:14:27 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id a16so6838763qtj.7
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Et6zTjz3rLwF/ItBI285hLUQ1f4GO0wd9iXT0eGoats=;
        b=hLqKbNF2l/HYOLCmWO8LMR1Uka12gSYz+AhlYm3DhRPL1fLs1dqzgWcxHxLzH/tZup
         gPnuymUDkXuAc3XIouGPBl/8T1D9Bq3u8jG17jrp2vSb0X7xbVT7014aW5js5Evi+PN3
         kKq8Au1B/gTOGttR3rccDlmrr+eH/zq2d6aYrZsLtb2MQbJ36nj/aUKfg72cXmKRuCd1
         7W0h22twgcbXNdk0LlNmNDt5u3BwGoQ5OGeQI2TU/FzlveqBrl5YUYIEveqDRG1UMD5e
         GdFmF67K9M+DZq777bIKNPeg4Db6qpIFUOK6o+EmyYf4xc69CphrXuFUAoqVvoIG7cn6
         VIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Et6zTjz3rLwF/ItBI285hLUQ1f4GO0wd9iXT0eGoats=;
        b=pcOby0r+//+jEDz2QC07BLqQVNw6xYNTQxWFdWYNQV7OZ+WjNKh+CTpjr72sZ5JV0U
         Z/Wm3Tl122NmFSGXWwNUQSyXy+PYWQp+FV7RL2btVastAQQPql8F4cgpUUXxJReftJBc
         kGamngRv+/xFDMXiN8xfDx1jHj05bpSrKm/KCCJMfWStI+6fUPERSPaBwA10cjTHNmxX
         u+iIXlI61wYBqJxWQZJIRAdCtWQpycE3MFoGnShAjsGZDS2pSRAIQYYykc7c7vDjN21R
         trKTyyn/x+JtHl9BYQRZDeDVLFh2QCklEKb8t7hR7FAzlI/yv/v1eCjt7tzjZsPhjXaR
         C+Bw==
X-Gm-Message-State: AOAM5315+CkpfRWyded62E0KbmTklfUx/PvnjpxP3mFNfpcrFQ/xJjqB
        oUJA1hVkbL3URtqzJmpan3vMofEmtKQa87NqcT4=
X-Google-Smtp-Source: ABdhPJx3xuV21n1yE2Lye3nQEPP50bMJ0EgQCylMeDfKaqKItuqqn+slZ4N1DGo94IMuiaWaihoXxmQJwU6XAlrqwU0=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:544a:: with SMTP id
 h10mr13840738qvt.35.1602260066836; Fri, 09 Oct 2020 09:14:26 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:32 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-24-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 23/29] KVM: arm64: disable LTO for the nVHE directory
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

We use objcopy to manipulate ELF binaries for the nVHE code,
which fails with LTO as the compiler produces LLVM bitcode
instead. Disable LTO for this code to allow objcopy to be used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index aef76487edc2..c903c8f31280 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -45,9 +45,9 @@ quiet_cmd_hypcopy = HYPCOPY $@
 		   --rename-section=.text=.hyp.text			\
 		   $< $@
 
-# Remove ftrace and Shadow Call Stack CFLAGS.
+# Remove ftrace, LTO, and Shadow Call Stack CFLAGS.
 # This is equivalent to the 'notrace' and '__noscs' annotations.
-KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_LTO) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
 
 # KVM nVHE code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
-- 
2.28.0.1011.ga647a8990f-goog

