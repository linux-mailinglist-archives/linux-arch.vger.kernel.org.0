Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A437FCCA8
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2019 19:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKNSEY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Nov 2019 13:04:24 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:34300 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfKNSEX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Nov 2019 13:04:23 -0500
Received: by mail-vk1-f202.google.com with SMTP id r16so2970548vkd.1
        for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2019 10:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A8ALfglUAafCNqhIvaCjHjdAel0vCMD5ZtmY0/3TtjA=;
        b=mJoHEAo5pqc+qK89IBDOQOcVkVYj619MJaPZ705KzX7T9U8iHezXczplW4ubbIxVdM
         84nMLUV7d4T4EVNSQTS2UgACgz40aa3H48N9mrK02ROhyHQgvmtLZJ+xQoaiCe9PXjVg
         uLAw3gL1JH5FRJ4tQXR1oHyfqfEt0GvvVH4yzLo+x1znGqmMUJFXYrXTA5TlwSVD+r5x
         N14ZvbEDJ9qialK2dhrbfOIsBSTOF3zr0Bp3ndHbSaf30aYV2Ri+II3D010YXiH8t0fV
         vnyCC7WhuaFr7Tvtz7eCjw3hEHqmO8miwf5UG27RLIZJpONke9XpSy5sOlk+sbbzAPFl
         6Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A8ALfglUAafCNqhIvaCjHjdAel0vCMD5ZtmY0/3TtjA=;
        b=fIvgBcRitq2PoZgHxLs5UCCex/aU/SbMfwbFJWZeHxJspsBVt/wWn/MVOwmOBGFRZ7
         TY2LlAZhRXMoawMFPGQkX/ctFUwD809OweOi0SsebdRYF7o7bd/04ZNWSasW4/Mn09rn
         buc3GWeSqFHM6g6P3kyGiJBWks2SjbneP2aARfWfaNd8jeHpZ2rjUyJOCYymtK38mTg9
         fLwbtqyZplEk2w0B1jBU2AbMxMuHpDh8TZMiEuspatvgcVZR4CibVFpil1OraldtNNzH
         rgNmWC2+9X4DQ4uBeYoEXwpbP6A/5XAHXrnHQIrrBHQ2RakLNi81z71XwnkiGHltKnXf
         vavw==
X-Gm-Message-State: APjAAAWkBg/bB9KuM2NQfhAPljwOwAwvHk2cA5Lhx2OezCOenl0dsnJB
        ZclRqnPpol6fycHgLgg9UZKSAT94nQ==
X-Google-Smtp-Source: APXvYqw7JnmHN+nEWhLp7FzaV0lkDhpgCLsWCQoT4EFYL/l9Bdo0fKwoOXqxtktyO21eG3K2d3sQq29XBQ==
X-Received: by 2002:ab0:2395:: with SMTP id b21mr6064758uan.122.1573754660635;
 Thu, 14 Nov 2019 10:04:20 -0800 (PST)
Date:   Thu, 14 Nov 2019 19:03:00 +0100
In-Reply-To: <20191114180303.66955-1-elver@google.com>
Message-Id: <20191114180303.66955-8-elver@google.com>
Mime-Version: 1.0
References: <20191114180303.66955-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 07/10] seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
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
        npiggin@gmail.com, paulmck@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, edumazet@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
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
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
v3:
* Add missing comment that was in preceding seqlock patch.
---
 include/linux/seqlock.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 61232bc223fd..f52c91be8939 100644
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
@@ -284,11 +291,11 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  *
  *      void write(void)
  *      {
- *              Y = true;
+ *              WRITE_ONCE(Y, true);
  *
  *              raw_write_seqcount_barrier(seq);
  *
- *              X = false;
+ *              WRITE_ONCE(X, false);
  *      }
  */
 static inline void raw_write_seqcount_barrier(seqcount_t *s)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

