Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B8DAF79
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 16:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439949AbfJQONr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 10:13:47 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:51940 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439931AbfJQONn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 10:13:43 -0400
Received: by mail-wm1-f74.google.com with SMTP id q22so1132125wmc.1
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3gVtAYjAise6qkpXvJpnBc4+Dg01VPHxIztWXKyEDrs=;
        b=nw1HzU4YhpADMRj5UcTtHVLYN5BYzkEigcx4qq8GgANxDr1oa7wwp9eBrai6SevU3L
         j6+eBoMTDTLr4MfHhPgQAfCVxbs/TDtYH3dM34nHE9GwrKvxMVkIM8SKmzOVCgyNsl1J
         8JCWp8E1/V2C5sPtkhe+9qZtMe1Jlqj/tGsabkTzYwAXrhNRPPV61Krj4j7eL33dzCRo
         vi3iEmj/yoEDHZlTklvYDdAo2+pPavz2RxydqsIaxQBoN62eHioWvJMGflKNnvf3DEvQ
         uH0PCgQuc9bA4n/QMMwlzKF0xDJkVO6Esd8Thk2Un4lhRcJMfpw6KYrPCMgh7QspQH3M
         /3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3gVtAYjAise6qkpXvJpnBc4+Dg01VPHxIztWXKyEDrs=;
        b=JFCzUR94eLEiCV2CHg671tbSv0Mvm42/wL+U3uXVgaOgyYIBlbfnCsLXd3LlIm/X1a
         OA7f7ilFcQ/kEmfCIIPLKT7TPBAsZA5piHfY8RJPNYwFCh1M1ZkADUEqaN1bRp3DxJVM
         zok6ts0ULrv2ES6kpzS37k8FryBLyOjFNjoO5+CQWzCqqRLWESUWBUVZeUQFeiyjp3lg
         1nJQvYdc7+JUgNaP0mfCphlQcFT4464AhHQTqwp4yWznfRz5IRDEpcQBIrpEsGdKvYX+
         Ts1X6IJ8X7kvFHC1tvN6mWmSde0MyOE6PlaQnq3kVTVOUUe6bVrU2/QWAaJYM81C6nWd
         lj6A==
X-Gm-Message-State: APjAAAX7em4TMvfjT+/iU9pE6HKaa1cZkAuPSwgGYh8vtNNA2yfsoFZn
        QRXeZDYEV/KAU6dgANkE+2rP8GLMSA==
X-Google-Smtp-Source: APXvYqwm5MBAQfwag+rUQZPLBD5lU8Dcy9D4qbG5eYoF6kbjjpG7UAv0Jr3LBxiSV8B2Gx4Vpx/JXFdfwA==
X-Received: by 2002:adf:b102:: with SMTP id l2mr3493651wra.269.1571321621593;
 Thu, 17 Oct 2019 07:13:41 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:13:02 +0200
In-Reply-To: <20191017141305.146193-1-elver@google.com>
Message-Id: <20191017141305.146193-6-elver@google.com>
Mime-Version: 1.0
References: <20191017141305.146193-1-elver@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 5/8] seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch proposes to require marked atomic accesses surrounding
raw_write_seqcount_barrier. We reason that otherwise there is no way to
guarantee propagation nor atomicity of writes before/after the barrier
[1]. For example, consider the compiler tears stores either before or
after the barrier; in this case, readers may observe a partial value,
and because readers are unaware that writes are going on (writes are not
in a seq-writer critical section), will complete the seq-reader critical
section while having observed some partial state.
[1] https://lwn.net/Articles/793253/

This came up when designing and implementing KCSAN, because KCSAN would
flag these accesses as data-races. After careful analysis, our reasoning
as above led us to conclude that the best thing to do is to propose an
amendment to the raw_seqcount_barrier usage.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/seqlock.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 1e425831a7ed..5d50aad53b47 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -265,6 +265,13 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  * usual consistency guarantee. It is one wmb cheaper, because we can
  * collapse the two back-to-back wmb()s.
  *
+ * Note that, writes surrounding the barrier should be declared atomic (e.g.
+ * via WRITE_ONCE): a) to ensure the writes become visible to other threads
+ * atomically, avoiding compiler optimizations; b) to document which writes are
+ * meant to propagate to the reader critical section. This is necessary because
+ * neither writes before and after the barrier are enclosed in a seq-writer
+ * critical section that would ensure readers are aware of ongoing writes.
+ *
  *      seqcount_t seq;
  *      bool X = true, Y = false;
  *
-- 
2.23.0.866.gb869b98d4c-goog

