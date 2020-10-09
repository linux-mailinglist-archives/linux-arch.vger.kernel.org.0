Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E06D288E3D
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbgJIQOz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389720AbgJIQOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:14:23 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2638C0613DB
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:14:21 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id p24so212714qkp.0
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IWlwO4V8zfIKj2VoQVJSOpIzEd6XIOwNzizfhzYsm+I=;
        b=icGF2o4BoUC5H7jDfDcqIeIDmztt1DX3EBV4AR9CIZel1UdghtV62q3fzjA81E5ME4
         x9g3yQfuIaLSgx21c6ABnIjUmaI4VqxjY4B5WnUXRoUb92nAtC/XbQPpxdBRAKJqH+qH
         jcvBMX8XEpz4rNBFWhnnnRs6RxEEg7NtFbXbUMhmEcBsm9ep+5oJx3BqoMUfqRJe9eh+
         HQV2rljyVTcunwoXwynW5GLctChORkFUDmM1/j1sk+6+WxF8Dg5/LcVdGd37dGhF+GtO
         M9aoDBKTtmJg2M/huHN2yYE2hfJUvsC+WO6y4SzBmnETs4aTNvX9A0N+1ApFOCsrkyFd
         VCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IWlwO4V8zfIKj2VoQVJSOpIzEd6XIOwNzizfhzYsm+I=;
        b=cspOD0sh3qsgHmYRr2oRTDwHfb43ephZfJ7bwbclPqeyY0/rBfm1fqUZwIfnJBVyAm
         3yASovdUBeGQIZLKM0v4dkh0HgvVm27gfkDRyxjeN+AqPF4eYuP9gCnpq1uo08Q6Q/SJ
         p9WCF34IINYgsbQu6VoW1lbtqgxe8R5rGZoa12pg1IURMmgb9K9FLiEg0SToNxEWAm4m
         TeEZcKs8HDdXkAv4yWNT5lpBPmpTGQe8FMia1ObLVECcdmW9VfJk4tHJzJVyFqPbqCEm
         fxo4vAHr980+pMmqhkbpt8ssmaUHRfM9wzaCKEjHFota8vmB5vTQqVLKy0P/ihGufAGL
         oLpw==
X-Gm-Message-State: AOAM533EAlZ212H6Si0/6XaCA2fJTHrUkJfpAZ7Lhr0fK5jnm8MUa0MO
        qSCjWZaTtO+81jM2xCvSxmTZzVOLZJNSXD2nAn8=
X-Google-Smtp-Source: ABdhPJxEWHAvyNkdIDlQRKJ2smQRYfbTU12bNHGd7NqYEmxH7inHJ1sIHSNvQnTIBhdfm/bIQe6W23Fz9FB7iOfrFU0=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:43e5:: with SMTP id
 f5mr13905635qvu.12.1602260060762; Fri, 09 Oct 2020 09:14:20 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:29 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 20/29] efi/libstub: disable LTO
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

With CONFIG_LTO_CLANG, we produce LLVM bitcode instead of ELF object
files. Since LTO is not really needed here and the Makefile assumes we
produce an object file, disable LTO for libstub.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 0c911e391d75..e927876f3a05 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -36,6 +36,8 @@ KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable LTO
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
 GCOV_PROFILE			:= n
 # Sanitizer runtimes are unavailable and cannot be linked here.
-- 
2.28.0.1011.ga647a8990f-goog

