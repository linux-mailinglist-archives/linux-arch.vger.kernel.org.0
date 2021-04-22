Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0A1367A18
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 08:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhDVGpe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 02:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbhDVGpd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 02:45:33 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AD1C06138B
        for <linux-arch@vger.kernel.org>; Wed, 21 Apr 2021 23:44:57 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id x13-20020ac84d4d0000b02901a95d7c4bb5so14663383qtv.14
        for <linux-arch@vger.kernel.org>; Wed, 21 Apr 2021 23:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=l+qKKt5CthNo7gsKeiDmyb/kZ1TcAtPvmD2Gk6Cbjnk=;
        b=b1iMBV9GjdZUYj2yI91PEybzTlsso3VQDe8xFMroa8ouR/ttvj3knfM95AcNp1o84N
         g3TViOskADOkMIRz01ZVq4DUjQZyZYMngikbAuJ1Osp/zLsc28t3HSQ2FpA3Ga3BsWKu
         rb2XTXvhd8z9TEDkexQdPsGGr/zaZNAV6mlSti35luArLtEty+Y9rHswJOSwg9ygNTBn
         9XompmxpjhsB013aKMMkXTACZtH8PEBV7p+ZV1Z6tknsyI8DvVaQ5ujGbpl8USHDp0AC
         rCRYL7yckdt0n+qQPGJ5E8F2K6ndnfTtbd1GP0VFWMkO0OHeIaswtKYYuDFLF5XwBoce
         3B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=l+qKKt5CthNo7gsKeiDmyb/kZ1TcAtPvmD2Gk6Cbjnk=;
        b=B/Ebt/+T36rItbajaLXAz6XfcpTAX1+mHZnGdXFiBxFJDge9EbnSwu9tK3Z+0L+aJr
         lZdWbKJTIrbhKjG8ZKEwZLxrH98VN6v8XQN8B1ctaSr9jWGtMZquE37psFdELKigvpyk
         TeSHmtDPr/XUW8Y/AJ9aZeMUy5aStCO1unIvSbFscsc+FpYdoS+9lcnCjJuW1KaoVj0C
         ejRiDgVWtn2lgnkfL+mYMqABQ0RX1m6HSHSRB84mxgCwrPqC5hYk2KpHT+zSIBcjANOs
         nKBKNZ01oYfeSUFh++0BKRInhOcR+rUW8a/vXwZku4drcxyNNeNilOzD8gAFKlc561Ij
         qVzA==
X-Gm-Message-State: AOAM530Xidukbv9VYLunL1MD+1TLMfhS6AeiuyWtnkrWXbqd9/xYfFyc
        2VlIcuDIj1ADqrICCFrbcVp1Vp2Stw==
X-Google-Smtp-Source: ABdhPJxKnTjrg7o9jl1LZdW4wy1+iae01OymOtOg+SLBRFzgbEQoqfWU08/k6ULzAeLc86G4rUyFprUPpg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6273:c89a:6562:e1ba])
 (user=elver job=sendgmr) by 2002:a0c:f454:: with SMTP id h20mr1734578qvm.40.1619073896837;
 Wed, 21 Apr 2021 23:44:56 -0700 (PDT)
Date:   Thu, 22 Apr 2021 08:44:36 +0200
Message-Id: <20210422064437.3577327-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH tip 1/2] signal, perf: Fix siginfo_t by avoiding u64 on 32-bit architectures
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de
Cc:     m.szyprowski@samsung.com, jonathanh@nvidia.com, dvyukov@google.com,
        glider@google.com, arnd@arndb.de, christian@brauner.io,
        axboe@kernel.dk, pcc@google.com, oleg@redhat.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On some architectures, like Arm, the alignment of a structure is that of
its largest member.

This means that there is no portable way to add 64-bit integers to
siginfo_t on 32-bit architectures, because siginfo_t does not contain
any 64-bit integers on 32-bit architectures.

In the case of the si_perf field, word size is sufficient since there is
no exact requirement on size, given the data it contains is user-defined
via perf_event_attr::sig_data. On 32-bit architectures, any excess bits
of perf_event_attr::sig_data will therefore be truncated when copying
into si_perf.

Since this field is intended to disambiguate events (e.g. encoding
relevant information if there are more events of the same type), 32 bits
should provide enough entropy to do so on 32-bit architectures.

For 64-bit architectures, no change is intended.

Fixes: fb6cc127e0b6 ("signal: Introduce TRAP_PERF si_code and si_perf to siginfo")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Marco Elver <elver@google.com>
---

Note: I added static_assert()s to verify the siginfo_t layout to
arch/arm and arch/arm64, which caught the problem. I'll send them
separately to arm&arm64 maintainers respectively.
---
 include/linux/compat.h                                | 2 +-
 include/uapi/asm-generic/siginfo.h                    | 2 +-
 tools/testing/selftests/perf_events/sigtrap_threads.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index c8821d966812..f0d2dd35d408 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -237,7 +237,7 @@ typedef struct compat_siginfo {
 					u32 _pkey;
 				} _addr_pkey;
 				/* used when si_code=TRAP_PERF */
-				compat_u64 _perf;
+				compat_ulong_t _perf;
 			};
 		} _sigfault;
 
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index d0bb9125c853..03d6f6d2c1fe 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -92,7 +92,7 @@ union __sifields {
 				__u32 _pkey;
 			} _addr_pkey;
 			/* used when si_code=TRAP_PERF */
-			__u64 _perf;
+			unsigned long _perf;
 		};
 	} _sigfault;
 
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index 9c0fd442da60..78ddf5e11625 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -44,7 +44,7 @@ static struct {
 } ctx;
 
 /* Unique value to check si_perf is correctly set from perf_event_attr::sig_data. */
-#define TEST_SIG_DATA(addr) (~(uint64_t)(addr))
+#define TEST_SIG_DATA(addr) (~(unsigned long)(addr))
 
 static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
 {
-- 
2.31.1.498.g6c1eba8ee3d-goog

