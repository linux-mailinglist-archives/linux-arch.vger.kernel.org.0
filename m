Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCB736870D
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 21:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbhDVTTJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 15:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbhDVTTI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 15:19:08 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E752EC061756
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 12:18:32 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id i25-20020a50fc190000b0290384fe0dab00so11707963edr.6
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MG1E5LmNjEnO9dOxTFKDeqsCA70+WVWf6tsEnOy3w2I=;
        b=CTGWG2bwSDUTBpl+CTY4eDft9pkPUnqmV8/Ue14lePjuizSL+3Ykhz3ZJlkal+QnAA
         KmhvZ7sfSQNXPG6tqUXMs8QJkAPiJPn11KDWvRl9HUMBdP4ANxpCfZnSlkj6xsnD472v
         BbOp5SuiR2GC/IKu3JTpZy43oHxjGNpiGELZKh6mzx4KoVlWunsSAKsHPLskOooIXxGo
         zQHM3ZcE/+mxx2T/YFkCjogZKItkeGAmn3t3aCcQNEOTTE7IvVWQt0WrhXHJK4bQwt8T
         FO7B31ZxDPW/4ymStBxmI5Bo3x+rjI4B8VsX1j43ZDMKKKj6I27utYMk8vrpQVvIULKk
         aQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MG1E5LmNjEnO9dOxTFKDeqsCA70+WVWf6tsEnOy3w2I=;
        b=Dz6pDXzY2MfEDW2gtkGc6JgYh3XnEPNZ47HzeqX6Ic4SYNmVPtn2pPS9F3gxszWdPr
         IsM0LYhMNBUpqgvS+oeqgE6YZWNhmynq4hns4ipTnlsY6kEnb6mQRiVTHxTT4v2nLRIn
         YMNAl8HneX4QAuiHgtY+Pw7r8WyfX9aOdpNx90QwQiiHtJqPTq0+k42L/oJ5eC26Aw92
         u4ZuRHk72Es8Y93/TO0O9HA/ellTXG2yJ/xle4eZa9ly5x2UUU0C1CAo6qiSuAfrIjYW
         oZ32T3vuEEVMaAbNkctHBanuTWD4D/I0G8yJQHRk38TO6wEi6T6cfQotzS1+sRDuDmsA
         xuxQ==
X-Gm-Message-State: AOAM531vsnzWbPEgU08849EzknvgTQ55lOVgrH1vsjCqddZwIUVn4sHi
        SjugRv96QvhPmkUfpCv36DTlCr5Fog==
X-Google-Smtp-Source: ABdhPJw0dS7tM+mkrOgUOXVjg379+Sp3vzFIHd9nGv05RWaB/g7pGx/VbIxJ1BfFq+uBYqyy4wtpUM3+0g==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:145c:dc52:6539:7ac5])
 (user=elver job=sendgmr) by 2002:a05:6402:1004:: with SMTP id
 c4mr17333edu.364.1619119110010; Thu, 22 Apr 2021 12:18:30 -0700 (PDT)
Date:   Thu, 22 Apr 2021 21:18:22 +0200
Message-Id: <20210422191823.79012-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH tip v2 1/2] signal, perf: Fix siginfo_t by avoiding u64 on
 32-bit architectures
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

The alignment of a structure is that of its largest member. On
architectures like 32-bit Arm (but not e.g. 32-bit x86) 64-bit integers
will require 64-bit alignment and not its natural word size.

This means that there is no portable way to add 64-bit integers to
siginfo_t on 32-bit architectures without breaking the ABI, because
siginfo_t does not yet (and therefore likely never will) contain 64-bit
fields on 32-bit architectures. Adding a 64-bit integer could change the
alignment of the union after the 3 initial int si_signo, si_errno,
si_code, thus introducing 4 bytes of padding shifting the entire union,
which would break the ABI.

One alternative would be to use the __packed attribute, however, it is
non-standard C. Given siginfo_t has definitions outside the Linux kernel
in various standard libraries that can be compiled with any number of
different compilers (not just those we rely on), using non-standard
attributes on siginfo_t should be avoided to ensure portability.

In the case of the si_perf field, word size is sufficient since there is
no exact requirement on size, given the data it contains is user-defined
via perf_event_attr::sig_data. On 32-bit architectures, any excess bits
of perf_event_attr::sig_data will therefore be truncated when copying
into si_perf.

Since si_perf is intended to disambiguate events (e.g. encoding relevant
information if there are more events of the same type), 32 bits should
provide enough entropy to do so on 32-bit architectures.

For 64-bit architectures, no change is intended.

Fixes: fb6cc127e0b6 ("signal: Introduce TRAP_PERF si_code and si_perf to siginfo")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Update commit message wording to be clearer and mentioned __packed, as
  pointed out by David Laight. I'm sure some time in the future somebody
  will wonder and perhaps run into the same issue, so let's try to give
  as much background as we can...

v1: https://lkml.kernel.org/r/20210422064437.3577327-1-elver@google.com

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

