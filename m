Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42B02706B5
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIRUPD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgIRUPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:15:03 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4308C0613E4
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:00 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o28so5534981qkm.23
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=I0YLtwhWjc07CuFqeB5q66ZrbEvcoZ20B6+f9QGQIyM=;
        b=jYUGHI1s8CrS/sSNFTlA7rmGo0aE0IxsOvco8+3mbGmxJ9XXGBu6oJrmFB8WRKT0qU
         zy//LwT+zYYBdAukM8OYIDIlT0g/nSfyiohg2buo5UUTX5oxMiibN0IAZdFZeUFX43do
         J75Ez99j+amuAzoOHQ0FFpTbHxdaoahEQ7mXskyDoQ20jhkMYFi95nSwiM3fgkSylPUu
         CgNcTGMuPTBF1DZs6+MnIXUHE0THEx4HxmF1Qc5rm1DW1zfnCq0VNXbuVkgxBrHhGtkl
         Jtq5TVNiA8w8V4hj/3o5nuATv73gM7CpTJhyuPWJPzpN9VmwWFkxnAAGfCAkUKsGwXZb
         /0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I0YLtwhWjc07CuFqeB5q66ZrbEvcoZ20B6+f9QGQIyM=;
        b=fQoaNVK84hEMbr5ma/Vc3FRqQClxCwoR5lkFTSWyyJc4GD9Qokb/V+HuZR4cXR9SL7
         0WlDk0MdN2rEmBq9i64hdohfWr0IkojJWhETvZDWPTYnG+torg0RQNK3wA7pOCzHatD2
         /zJgYAXfm6jxiXVymfMpMU8JUze5LC53qm4ueJQY1lL2IlgECEBPC6LHeyU93DhYUDRx
         myBwWlEdaj392iYdNbr0ygkSG2/BzCzFRuDfOq/So/vAMRNOB/R3M5MqsLRE72KhKvB7
         BUVJ1QZ2Tgo+ZKPMPVAi38I7HbwRGkxF8ypQgHH2gkfwtoY6g9cFIph2eLcg5cR+t+s3
         jwmw==
X-Gm-Message-State: AOAM533V1MniPTYiaQdDBkO9Yg66JN4bHHVRRiPqfjVidrWrYTmjKqd3
        El1/hZdxU1BSHRPhnMcJfpdIrqaSoC0XiBGP8s0=
X-Google-Smtp-Source: ABdhPJz8YsEPOq657LzaNLkjWdjXppy9+ITNLo8GCqthbQa6sHwPiOQhQjOantZ7VXaLO7lFT1ulWYm9Ne5qkWpjkw4=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5a0e:: with SMTP id
 ei14mr20723233qvb.15.1600460099899; Fri, 18 Sep 2020 13:14:59 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:15 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 09/30] x86, build: use objtool mcount
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

Select HAVE_OBJTOOL_MCOUNT if STACK_VALIDATION is selected to use
objtool to generate __mcount_loc sections for dynamic ftrace with
Clang and gcc <5 (later versions of gcc use -mrecord-mcount).

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..6de2e5c0bdba 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -163,6 +163,7 @@ config X86
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING		if X86_64
 	select HAVE_C_RECORDMCOUNT
+	select HAVE_OBJTOOL_MCOUNT		if STACK_VALIDATION
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
-- 
2.28.0.681.g6f77f65b4e-goog

