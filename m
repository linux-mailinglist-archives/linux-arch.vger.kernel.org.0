Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8695BAEC2
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiIPOBt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 10:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiIPOBq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 10:01:46 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F189AB07B
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 07:01:43 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v4so20425860pgi.10
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pZ5QW8+FbrHaACMXwsrZ3rO+2GQoZC7Xs+YDX+18qPg=;
        b=dApn8A/ndkN474hPDvEKuWQp/GaiW0SglUGPjtKldcidaNpFyn8EO43danXo3TnNvM
         HWDlvUcNWMyF7tJuGW/HNMy8NTScvTpl5ATgqNE2TvwiIAO0s0d92/JDB2xxTBCk0qVA
         Smp0x+7SeMPrySaeAjioon6OaEp1jI+D86fe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pZ5QW8+FbrHaACMXwsrZ3rO+2GQoZC7Xs+YDX+18qPg=;
        b=PTnp60kVNZY3o+r6MECrtKPQQDiL9vegdJ4A34oWXRg5zrPQVAi2SUVy1B7WBobexD
         EwSuQESV4DWDfND9fuECRfY8y+iySxxyOievF2P1Eb+JUWyToKfkXter7FWHjD2O5E73
         DOUrMoPkw3iDQFdw4K6QiMkoqQpBGsUa1o9tlTbTg4mbqI0BbH7lT2Typmm8qRP4AMs5
         a4QlCt935j/2o0X2nXXDXK25tZj9jXAzjarq5Gkc5whoy9Oqy3Hbk5d+cy4RY++hhczE
         mMte4Pm++cMxQIcxHwq6iYRrioo5Rx2ZfkSIOHpAoQCm0u0xPD3vXjgp5jOcudJHaD7R
         fhlA==
X-Gm-Message-State: ACrzQf1JYf1FSn/A7JlwvFnYYJQAyD/nbrpAUhUo85ytc0Lte3MJG9zh
        1W9DQynazSbyPZULITQoSoVL0Q==
X-Google-Smtp-Source: AMsMyM4ojRXwvb2FpFeNlR4/l+I5DQD0qvf8IIChM4yYleDmUiwgwT4v7QLKu/CTj7OS6YrllLZisg==
X-Received: by 2002:a65:6a05:0:b0:42c:87a0:ea77 with SMTP id m5-20020a656a05000000b0042c87a0ea77mr4674038pgu.75.1663336902698;
        Fri, 16 Sep 2022 07:01:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k5-20020aa79985000000b00535d3caa66fsm14281585pfh.197.2022.09.16.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 07:01:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Yu Zhao <yuzhao@google.com>, dev@der-flo.net,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 1/3] x86/uaccess: Move nmi_uaccess_okay() into uaccess.h
Date:   Fri, 16 Sep 2022 06:59:53 -0700
Message-Id: <20220916135953.1320601-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220916135953.1320601-1-keescook@chromium.org>
References: <20220916135953.1320601-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4246; h=from:subject; bh=lKu8W3jwyjlnI0U4MB0YhFyFdBPkVe2IDcNCcwDBY7I=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjJIFYUoqiqZEs8RDF39N7dCwCH6XhD4rW0rrrXDR8 VVu38x6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYySBWAAKCRCJcvTf3G3AJoeqEA CvoFJqlgQd4sdMO6jBx4c9P8V9cux0og6S3xgwGUvzsj157wrdM9YElT5S8N3/efD2N33UUrs3DdjN 7dUmfnZ49lXi9gZzj+QpU+5VLgn02RvTUR7qYBnuF3+sjGtmHzU67MDMmo9pTgYGv8dHS7j+dkpDn0 bXMp5/oFRA9YvcxEjxLh14V2cvE/WfUBfYCYNZYnDCtikveBJ6o9PnSnxasQwLmFRkQp0c1Bfpuef/ MpVlQJC35U1pA/t1fUHM+qyDr+rJtbRnZqjS/HKaRI5rCTJHhLCC/m6Ko62wVq3+xO9GGiocL+Ss2I 8zc1+4TtvcMTVn67UzQMUu86xwtYS0cFXYNElo7zTZD25B+2wa6Jgrn6YDD69pMkZ6IpuVOjEijoD8 O3mUEbHIj40t8jHYziOzUPH/uZD+2jfmGzOoeSzcOzNQr9yT0IEyXaiHnSmritmz2hvhzcDeu//T5H fvM8K3g0Lb7uudTadKfSu0Edo2vH1cjdSIRC4kiIbY0HlXNhNhJgHtNGBhv5KaEkp2aI+bsTubq8mk EOrZu4qxbg0BkTPhPnp4PF0nrzC8KyBssLQdoq+/RhExRImyWug4ZNfaF960FRjcIoZ8b2HNnSo+c7 3i29D20rhYAFmb6qszl6E8K71UcFR6j4wAEF4B3gJjPY5xAY6q6urTlDCRxQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for inlining copy_from_user_in_nmi(), move the
nmi_uaccess_okay() declaration into uaccess.h, which makes a bit more
sense anyway. Additionally update all callers to remove the no longer
needed tlbflush.h include, which was only for the declaration of
nmi_uaccess_okay().

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: dev@der-flo.net
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/events/core.c          | 1 -
 arch/x86/include/asm/tlbflush.h | 3 ---
 arch/x86/include/asm/uaccess.h  | 3 +++
 arch/x86/lib/usercopy.c         | 2 --
 include/asm-generic/tlb.h       | 9 ---------
 include/linux/uaccess.h         | 9 +++++++++
 kernel/trace/bpf_trace.c        | 2 --
 7 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f969410d0c90..3e2bb6324ca3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -36,7 +36,6 @@
 #include <asm/smp.h>
 #include <asm/alternative.h>
 #include <asm/mmu_context.h>
-#include <asm/tlbflush.h>
 #include <asm/timer.h>
 #include <asm/desc.h>
 #include <asm/ldt.h>
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index cda3118f3b27..233818bb72c6 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -157,9 +157,6 @@ struct tlb_state_shared {
 };
 DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
 
-bool nmi_uaccess_okay(void);
-#define nmi_uaccess_okay nmi_uaccess_okay
-
 /* Initialize cr4 shadow for this CPU. */
 static inline void cr4_init_shadow(void)
 {
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 913e593a3b45..e9390eea861b 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -20,6 +20,9 @@ static inline bool pagefault_disabled(void);
 # define WARN_ON_IN_IRQ()
 #endif
 
+bool nmi_uaccess_okay(void);
+#define nmi_uaccess_okay nmi_uaccess_okay
+
 /**
  * access_ok - Checks if a user space pointer is valid
  * @addr: User space pointer to start of block to check
diff --git a/arch/x86/lib/usercopy.c b/arch/x86/lib/usercopy.c
index ad0139d25401..959489f2f814 100644
--- a/arch/x86/lib/usercopy.c
+++ b/arch/x86/lib/usercopy.c
@@ -7,8 +7,6 @@
 #include <linux/uaccess.h>
 #include <linux/export.h>
 
-#include <asm/tlbflush.h>
-
 /**
  * copy_from_user_nmi - NMI safe copy from user
  * @to:		Pointer to the destination buffer
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 492dce43236e..14efd74f3e70 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -17,15 +17,6 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
-/*
- * Blindly accessing user memory from NMI context can be dangerous
- * if we're in the middle of switching the current user task or switching
- * the loaded mm.
- */
-#ifndef nmi_uaccess_okay
-# define nmi_uaccess_okay() true
-#endif
-
 #ifdef CONFIG_MMU
 
 /*
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 47e5d374c7eb..065e121d2a86 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -10,6 +10,15 @@
 
 #include <asm/uaccess.h>
 
+/*
+ * Blindly accessing user memory from NMI context can be dangerous
+ * if we're in the middle of switching the current user task or switching
+ * the loaded mm.
+ */
+#ifndef nmi_uaccess_okay
+# define nmi_uaccess_okay() true
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 68e5cdd24cef..0fd185c3d174 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -26,8 +26,6 @@
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/btf.h>
 
-#include <asm/tlb.h>
-
 #include "trace_probe.h"
 #include "trace.h"
 
-- 
2.34.1

