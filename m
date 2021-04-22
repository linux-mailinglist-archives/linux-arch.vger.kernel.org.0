Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DC936870E
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 21:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbhDVTTJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 15:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbhDVTTJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 15:19:09 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13DFC06174A
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 12:18:33 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id f134-20020a1c1f8c0000b029012e03286b7bso1995413wmf.0
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sugwskr8rXy42pZ1xDG6/Yn9grQzLU2kaW/tniDjvCM=;
        b=N0/i2Z5Ah+iH6G2EkCovNrk2mBQPzeAFd1m1GTNwITesl1LuHaJiptjsZe5b00INE0
         ryeY0Z6v39pUAKaMEgkBjhW9/H/F8x/EC1yO/tKfGc8ZaoNHTpOR9kAM3kK/NKb9i4Pi
         FlpKg43hd6FHxaowCZWxZ85B0Wp9kl8rUBQYQCuPGlvNV3qeM451H99iVqhHIVlfUK9m
         lepgeHJbEFEyQ7zPZRBJfT+zBUJiByw7ElIIWWkDTdmMULFDO6JX+UcPAAyUlDsTmZvS
         /4YCAC5rfJyuBzED+h/5nhWMGtXI7GGykXofz5B7Eq49UNx9nLFJt6fGKSXmdCAZS3la
         Aamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sugwskr8rXy42pZ1xDG6/Yn9grQzLU2kaW/tniDjvCM=;
        b=SJ/1/XWfFbn38djp7eFxxMUWX6jX7LoTU7XZ0u0Hq/KNKV7G4PyyqwwGN1PxTmLiVu
         cVEQBvtFDln7plqxj+C3KuGB2tbmWgyGPDC1uHGfAfX9uLIIVy9TV7dgVUXTVOLnSoMi
         YpwlGg7ioZGzuqL0CjXJkbAktG9pZAy5s0ymo+LPjIbnVDV5aAIe5QncN1+RhZiPe0BS
         tbXwAu6KD+ZV7bsJZCDlvxlT3tApbCOKIR4iTUO91N1f2NmOidxiNSFXKk0LF3r8nueM
         RHTDnglgXKbWnZbBwdpIpTyoIED4yHa2boPhQ1WP14Ny+VmGBoQBbRyWMot1NPYBlSmD
         M3jQ==
X-Gm-Message-State: AOAM533lWe700scKH/2sa1/YmQhiNWsAEEpyRplEocQPUYQ3ysZ09n3V
        6n5xBcQH1bOLfCpIHp8w0eDJLIUdOA==
X-Google-Smtp-Source: ABdhPJwl+q5WjR5zsegf/9T50JzWO1+p0hZUP1HC7HBRkSIEzansnudeZv6f3dYlA7JH8yzgTt1aNJBYgQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:145c:dc52:6539:7ac5])
 (user=elver job=sendgmr) by 2002:a1c:c246:: with SMTP id s67mr312123wmf.86.1619119112369;
 Thu, 22 Apr 2021 12:18:32 -0700 (PDT)
Date:   Thu, 22 Apr 2021 21:18:23 +0200
In-Reply-To: <20210422191823.79012-1-elver@google.com>
Message-Id: <20210422191823.79012-2-elver@google.com>
Mime-Version: 1.0
References: <20210422191823.79012-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH tip v2 2/2] signal, perf: Add missing TRAP_PERF case in siginfo_layout()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de
Cc:     m.szyprowski@samsung.com, jonathanh@nvidia.com, dvyukov@google.com,
        glider@google.com, arnd@arndb.de, christian@brauner.io,
        axboe@kernel.dk, pcc@google.com, oleg@redhat.com,
        David.Laight@aculab.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add the missing TRAP_PERF case in siginfo_layout() for interpreting the
layout correctly as SIL_PERF_EVENT instead of just SIL_FAULT. This
ensures the si_perf field is copied and not just the si_addr field.

This was caught and tested by running the perf_events/sigtrap_threads
kselftest as a 32-bit binary with a 64-bit kernel.

Fixes: fb6cc127e0b6 ("signal: Introduce TRAP_PERF si_code and si_perf to siginfo")
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/signal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9ed81ee4ff17..b354655a0e57 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3251,6 +3251,8 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
 			else if ((sig == SIGSEGV) && (si_code == SEGV_PKUERR))
 				layout = SIL_FAULT_PKUERR;
 #endif
+			else if ((sig == SIGTRAP) && (si_code == TRAP_PERF))
+				layout = SIL_PERF_EVENT;
 		}
 		else if (si_code <= NSIGPOLL)
 			layout = SIL_POLL;
-- 
2.31.1.498.g6c1eba8ee3d-goog

