Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD834BA8BE
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244634AbiBQSuQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244627AbiBQSuI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:08 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9385133F;
        Thu, 17 Feb 2022 10:49:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h18so11316693edb.7;
        Thu, 17 Feb 2022 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4cIot06p9bDQauaO1zbhigQdt5owQ2rXgJArey+D59k=;
        b=UoYO3PHZ4HTMVcUw5lv3zypcgWVf/5pzgSroMo+f3bngjaPxXFwX3HhKvS6xdlOAqz
         8gSBrl8c8D3qe/HOPg7i4DPGJFAQANXNLmiOH8o6jRLs/HghTGAURVHt+9fVmJgi+9qW
         MpNIRELNUgcaWdVylHzZfyTKu43QUEGjKcjTssKoJjQImdM9vSiuZw0gpLZPi/ZaWGS4
         ElGOpTM26javGFnnmSuuaID3Dr8g5c2MCbOO+AmvXAmxinBNP0oYxMLkuqXYk5Keqs9/
         O1ji42DyTDwWBOfuc0LY8vibfFUuNaIseAOg/RdfgPmZ71kHv+r+quLLVNhxtbYQpBT5
         5Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4cIot06p9bDQauaO1zbhigQdt5owQ2rXgJArey+D59k=;
        b=z7YXcB74Pp4AnetnBV3v0f1d8mdurBPS+S0wTBmMoaGnM2b3FxDY2rJUxnI7VSwNUo
         aY6HzbS4muej3iARPWAUsceFLCMJE+gnta2gaL/AhA6zODQgWsjzDZoe6BAD+JBtaON+
         Nx/JaAOZPIQeZWMoMhVrXnmEaKA57jSFDuVmEeddcmeotrk7c+YetrBJxCINvTeiXXtl
         /8PZzd5xyfqhEXQNH9V8NH2Vy1p17/9uqd5e8z6B0k9pdQjYWbVw9Ud7eImqL3CNB/Ow
         SNkhGj/M4yM4LiHIeaEiLaqQxCtStePVbc595FNNMXFc3DpYYBMqKUv/yIPHLDPYeZMo
         +b/w==
X-Gm-Message-State: AOAM533j6LQ+aqjN7A2jyThllgbD4FlpboR1cBzDploPIObtNmQjUJu1
        Xf1ntk/WPQsFJx8+e+44KUs=
X-Google-Smtp-Source: ABdhPJwVQsnOpusaPVplCNMtPOIo1hxXvJsWTnSyJXdpiYr6w0I1libJUg95L+1iei0vO6WtH3kbGg==
X-Received: by 2002:a05:6402:3486:b0:409:8ed0:9340 with SMTP id v6-20020a056402348600b004098ed09340mr4114511edc.255.1645123791125;
        Thu, 17 Feb 2022 10:49:51 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:49:50 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [RFC PATCH 01/13] list: introduce speculative safe list_for_each_entry()
Date:   Thu, 17 Feb 2022 19:48:17 +0100
Message-Id: <20220217184829.1991035-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217184829.1991035-1-jakobkoschel@gmail.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

list_for_each_entry() selects either the correct value (pos) or a safe
value for the additional mispredicted iteration (NULL) for the list
iterator.
list_for_each_entry() calls select_nospec(), which performs
a branch-less select.

On x86, this select is performed via a cmov. Otherwise, it's performed
via various shift/mask/etc. operations.

Kasper Acknowledgements: Jakob Koschel, Brian Johannesmeyer, Kaveh
Razavi, Herbert Bos, Cristiano Giuffrida from the VUSec group at VU
Amsterdam.

Co-developed-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 arch/x86/include/asm/barrier.h | 12 ++++++++++++
 include/linux/list.h           |  3 ++-
 include/linux/nospec.h         | 16 ++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 35389b2af88e..722797ad74e2 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -48,6 +48,18 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 /* Override the default implementation from linux/nospec.h. */
 #define array_index_mask_nospec array_index_mask_nospec
 
+/* Override the default implementation from linux/nospec.h. */
+#define select_nospec(cond, exptrue, expfalse)				\
+({									\
+	typeof(exptrue) _out = (exptrue);				\
+									\
+	asm volatile("test %1, %1\n\t"					\
+	    "cmove %2, %0"						\
+	    : "+r" (_out)						\
+	    : "r" (cond), "r" (expfalse));				\
+	_out;								\
+})
+
 /* Prevent speculative execution past this barrier. */
 #define barrier_nospec() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
 
diff --git a/include/linux/list.h b/include/linux/list.h
index dd6c2041d09c..1a1b39fdd122 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -636,7 +636,8 @@ static inline void list_splice_tail_init(struct list_head *list,
  */
 #define list_for_each_entry(pos, head, member)				\
 	for (pos = list_first_entry(head, typeof(*pos), member);	\
-	     !list_entry_is_head(pos, head, member);			\
+	    ({ bool _cond = !list_entry_is_head(pos, head, member);	\
+	     pos = select_nospec(_cond, pos, NULL); _cond; }); \
 	     pos = list_next_entry(pos, member))
 
 /**
diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index c1e79f72cd89..ca8ed81e4f9e 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -67,4 +67,20 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 /* Speculation control for seccomp enforced mitigation */
 void arch_seccomp_spec_mitigate(struct task_struct *task);
 
+/**
+ * select_nospec - select a value without using a branch; equivalent to:
+ * cond ? exptrue : expfalse;
+ */
+#ifndef select_nospec
+#define select_nospec(cond, exptrue, expfalse)				\
+({									\
+	unsigned long _t = (unsigned long) (exptrue);			\
+	unsigned long _f = (unsigned long) (expfalse);			\
+	unsigned long _c = (unsigned long) (cond);			\
+	OPTIMIZER_HIDE_VAR(_c);						\
+	unsigned long _m = -((_c | -_c) >> (BITS_PER_LONG - 1));	\
+	(typeof(exptrue)) ((_t & _m) | (_f & ~_m));			\
+})
+#endif
+
 #endif /* _LINUX_NOSPEC_H */
-- 
2.25.1

