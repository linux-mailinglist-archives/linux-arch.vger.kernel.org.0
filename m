Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8C346A40
	for <lists+linux-arch@lfdr.de>; Tue, 23 Mar 2021 21:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhCWUkn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Mar 2021 16:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhCWUkW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Mar 2021 16:40:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558C1C061764
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:40:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g9so3795342ybc.19
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tNWRsiiEAfetheYG6qtDYdd6Zu2YM8DJGmENfE26Aac=;
        b=QwtFzkNZ0ArdJ22uiNb1llxuSobP5aVQNzwPksMPm+yXD4iJErHZlbeYgNVneIsCaV
         eWzSIifLKq9OeR/urLV+kBUy5t9Lj6BMjZqFICzYH6wVYLJimy4yOQuD7NgKMnmibW9S
         zG50zFIIhTS3dotn12D1Zy6qsSjg8WUhwZTAAq2J7W9gn7luxZShIQYCTr+CZA3deHb8
         U3jjpaLWT8ZiETFcnxTTPxy7Im1JnVTxQxGpi3yBHzfY2Dfw3S61ouZ35+FlKNnKAFPT
         AeZpguEmKCpHpboafyAslh+3UWQD/2MhlgpX4aQM7wK4y4d9OGGiM9NT5wh5PIZuoCtX
         4HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tNWRsiiEAfetheYG6qtDYdd6Zu2YM8DJGmENfE26Aac=;
        b=Le7UTASW6A/w2xHhFZY/lFcZHMcpq86yd0KsAdwaaVeeaFsm6fq6fVt37H1E52TlTJ
         JNJYVPgUrw5cklEbERgNPydfApEBJAvPBtU/NfuuvGzyGFkzdrWE4sOSI5W9h61DCmdW
         w33Ajdx97KmqOEOMMYrqYwZXqyXtRS4qME4r5nQSRidGls03asByUOytut5OylZgzJrs
         odM6r9qkUAmOd5SYyNxQMbffaNBirOTAzADD5hrLYVy08i9odrq1IBVNCmhLPnDVS6ze
         7x/RMjrik5IFhQeO8JC4lJ5v/TivJM2eno5LeZp8AeyXQo7zZfG7qtyGr/2A2J/mGAZU
         E/DQ==
X-Gm-Message-State: AOAM531tI0fmTvEX6sf0V+husZ55kyCfxSyEKqxZB40c3GhXbN9RnnYD
        UGw/NxXcXI7/VF89G2FTK2eDfvC2Ze5HkMjEFDM=
X-Google-Smtp-Source: ABdhPJxEi3pQM02XMd23fjMyS1SetL4sDZHHMo2+iWEzXbz9tuF1eS1XAan8eMOnDTZL5Cre89JVC9ou2IlB88zz+ZI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a25:686:: with SMTP id
 128mr110596ybg.258.1616532018575; Tue, 23 Mar 2021 13:40:18 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:45 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 16/17] KVM: arm64: Disable CFI for nVHE
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
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

