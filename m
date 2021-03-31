Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20660350963
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 23:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhCaV2W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 17:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhCaV16 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 17:27:58 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE0EC061761
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:57 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id g18so2361396qki.15
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tNWRsiiEAfetheYG6qtDYdd6Zu2YM8DJGmENfE26Aac=;
        b=ubXheP2brktumzheoRlwOGBaDAhJZCw5NjiWWseiWXm7uPGHPIEhQNkw1vclDXilyC
         T58HwhxWmupp1FHmmbm/one9xjzW1zyEIjkTSSxxlsem3MjSEZyOYyr2rhKeCFRUkd1c
         yGspf/krXoZV1aO23JrXpEBnl0Y82WLgsZPob752XnnEkvdLJpCAqDdeG+QPej4XPSZi
         CCDXPydG6+7wL9MGmLynGahaXHCtSa4TMIRQo0YgQK5KW48jFUEOkg9RmceaiJf2wbgY
         lIMNbUBaPlDMhK4s8fFJq1GcJptaYswx+mQ1VL7I/WglifRbnqfcOPmIuT0hvWr13KAr
         jjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tNWRsiiEAfetheYG6qtDYdd6Zu2YM8DJGmENfE26Aac=;
        b=GtkmSFS1M7mkl6NdyJK9QEp2iIbmAKziOIK5ojiJdpWkLaD4N4TYkJtc5ls3oO+Ds7
         CCPLRh2/dyFeJOdlN/NDKzTLa+H2PFNtwI7AkvDCg5AitFyy7lbuY/6durLfjDvXjis6
         9vqXRZ3iv5Vp3TLQkNh/qERbCOw/bo2r+zFHwzH5yvggZtxnhLEGKUcr3Ixpj9jCFrvp
         iU0bgVexUU0Bjw1dLoSr76bVPHbRyLvpz90gIPLE6X6+lyo3P46GjWidMEdxwATwKvPi
         9jfs+oyYdKsPHm9ei29KLos//W6RMUM7N6L5YVm4Bv73Lrct7zIdIzsTq5lIhLigm+zp
         nE2w==
X-Gm-Message-State: AOAM532uBjFOzBS2Ug4Vbimi0B8U8wBzRf1jw5vUvhYVJj6CP/rs++7j
        zdZKdmkrj5t5azWFi9yklYmuzIAOM6zvp50EiY0=
X-Google-Smtp-Source: ABdhPJzZWP60rNMcikFQnnnMLQ3nIFchg+3t6XyAeYS/TMwgF+id2xc8kKag8yrH4KJDKMnacT9UMf7IYNlFmwHArxk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a0c:f349:: with SMTP id
 e9mr4952920qvm.59.1617226076143; Wed, 31 Mar 2021 14:27:56 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:20 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 16/17] KVM: arm64: Disable CFI for nVHE
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

Disable CFI for the nVHE code to avoid address space confusion.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index a6707df4f6c0..fb24a0f022ad 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -75,9 +75,9 @@ quiet_cmd_hyprel = HYPREL  $@
 quiet_cmd_hypcopy = HYPCOPY $@
       cmd_hypcopy = $(OBJCOPY) --prefix-symbols=__kvm_nvhe_ $< $@
 
-# Remove ftrace and Shadow Call Stack CFLAGS.
-# This is equivalent to the 'notrace' and '__noscs' annotations.
-KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# Remove ftrace, Shadow Call Stack, and CFI CFLAGS.
+# This is equivalent to the 'notrace', '__noscs', and '__nocfi' annotations.
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
 
 # KVM nVHE code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
-- 
2.31.0.291.g576ba9dcdaf-goog

