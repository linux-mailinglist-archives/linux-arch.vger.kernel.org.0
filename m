Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7023622BE7D
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 09:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGXHAx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 03:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgGXHAi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 03:00:38 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0DC0619E7
        for <linux-arch@vger.kernel.org>; Fri, 24 Jul 2020 00:00:38 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id t3so845346wrr.5
        for <linux-arch@vger.kernel.org>; Fri, 24 Jul 2020 00:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nzPB/8gD7tiXvmPnGkXWvRfHEEqZYmZWnzjoz4lCFa4=;
        b=URAz3B9pmI3bMj/6AQUMnQQhW0rplCGsl7EloPnKMvSTNGhtNnCDfpGQ/8+TWhN/lS
         eu93QjVcDkQhVrqUknfjSvB0XOajZEZToOyVflz40sULKVkXx6GdG2Jl9RetHholLscb
         PoV5V60V4M9lw/Srge2zKAj1zk8uQFxfbooBj805sbbIK/sv+2won75T8Ek6ZGQN9uEK
         4+p+bDebrCVEHu50+mjp7zz0MS0fpWFGfLHruk2rEJmQEiqiXAcTlPldK0MredKRg7Tu
         hIeWfrLaMilSJpOi81uGZWmzYRa14TOKhpPwhFvIXdYF90TU+Nm8AI28zeAGN4zl+ncI
         mmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nzPB/8gD7tiXvmPnGkXWvRfHEEqZYmZWnzjoz4lCFa4=;
        b=mYZQVsp8kRZcA6iZwk9eIalgcTLJ5+MOjEpreCMDT8ZrxLvscJE7223YySRtNZftTv
         qNR4I3Z1Cnq24tMfBLk9/vzyjCy1j/TYRDc7Qz29CV6dpTHbYNEtCZIkTS93pULCSNzA
         Kec+J6h+k8cxrTztZwQ8s3XG/bnB3BOj8LWe+SWwu2puqGvDyyRJcS/xqmdWvvoyquJE
         wq8PbZIj8wBhm5y7JMAv7jSvDU7Qugboj2yqYZiRQg0MphpkDKVQ8jlJtg2jmU+It2vz
         3+VJGxYstQ2ckOQTa5dHzVd3SQU95pHCaLts3amJWYB73CjSCriFp60Vyr0zDH7Y5XEP
         XKqw==
X-Gm-Message-State: AOAM531PVmm9o9Ow/87u+KWZ1fvfbDO7+nUQcvL7DckhEkRfFX/cm2fx
        upcQPUQ+hySWxJEqNociizloIZruPw==
X-Google-Smtp-Source: ABdhPJx2JoNHbcPJzjn4ZQvYwamZ3dXW5+J9rF1Ytf7+0vXB5i7gS14K5hdGsJuzH9+fJNjTZ5Y2F4/QdQ==
X-Received: by 2002:adf:e805:: with SMTP id o5mr7608214wrm.419.1595574036687;
 Fri, 24 Jul 2020 00:00:36 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:00:06 +0200
In-Reply-To: <20200724070008.1389205-1-elver@google.com>
Message-Id: <20200724070008.1389205-7-elver@google.com>
Mime-Version: 1.0
References: <20200724070008.1389205-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2 6/8] instrumented.h: Introduce read-write instrumentation hooks
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce read-write instrumentation hooks, to more precisely denote an
operation's behaviour.

KCSAN is able to distinguish compound instrumentation, and with the new
instrumentation we then benefit from improved reporting. More
importantly, read-write compound operations should not implicitly be
treated as atomic, if they aren't actually atomic.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/instrumented.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 43e6ea591975..42faebbaa202 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -42,6 +42,21 @@ static __always_inline void instrument_write(const volatile void *v, size_t size
 	kcsan_check_write(v, size);
 }
 
+/**
+ * instrument_read_write - instrument regular read-write access
+ *
+ * Instrument a regular write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_read_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_read_write(v, size);
+}
+
 /**
  * instrument_atomic_read - instrument atomic read access
  *
@@ -72,6 +87,21 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 	kcsan_check_atomic_write(v, size);
 }
 
+/**
+ * instrument_atomic_read_write - instrument atomic read-write access
+ *
+ * Instrument an atomic read-write access. The instrumentation should be
+ * inserted before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_read_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_atomic_read_write(v, size);
+}
+
 /**
  * instrument_copy_to_user - instrument reads of copy_to_user
  *
-- 
2.28.0.rc0.142.g3c755180ce-goog

