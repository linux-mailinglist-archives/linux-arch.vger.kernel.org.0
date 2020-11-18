Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8DA2B8772
	for <lists+linux-arch@lfdr.de>; Wed, 18 Nov 2020 23:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgKRWHy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 17:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgKRWHv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 17:07:51 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1014CC0613D4
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:07:51 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id g14so2094788pfb.8
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JUh1T9Q0UpH1P/k5MG3eyMCJDiIsKr/ZhdG3k4jEA2o=;
        b=GNMm1MAVTepQmZAF77rlDYxsuCdPaSo7+Ez7SIfF2FWVLeWy9R3mFyHA2wPW466N3j
         0SWe2Yq8j6EF83sMo6emozMTZ9ptK/gS+fCtk3yKY5a6UO91rxckJhgTq1xK04dt07lp
         6p26tDJr7oc3rv4oRJ6DOnLzLhSn87edt2CqXiE7YNvlWSgL9o2LDhtNJDbcJBqeQQWd
         0KEtkxJOmbT6JFsXb04tkZ4RCyVn70wiNpv4WilQN6L1DumoZp7goDqbL/XtjbAL/M99
         v3kUtHqpOiXPTfFRq+tP2O4TBYERMP+NYokmuOLksHWs2A228Y+lQf9s5GUGTnt79xuC
         A4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JUh1T9Q0UpH1P/k5MG3eyMCJDiIsKr/ZhdG3k4jEA2o=;
        b=ieVCRaiFLyXdFf+u7ardsIFkdgUCAREtHw5Mxz1WeLF1kElk2lQEfE1ADb5Vlc8Upe
         +c01581RRB3/R4K93NlXWv5ZEfyXGd7A5ij1+ygbEkj+2i5WFahrETmMmno5mwqzArBo
         zqXlW+/axOG//p8+PVW0G/WxgUxcv+x2wYcblKh4oNm1JoWyCVfzL624/00DA9hgGrSj
         QQ8cASlHSVNKPnARoOSBKGKU7UH3eysD8kfVJNaB3+FrjWZ+ZAaB2LBYkpRQVV7QMFrM
         mcp6lBFqGcseSHPbMOe7eU/DgNQ5nUa2C3IAafkls9noCkwIhA+mN6EwAPWCNnfsb8vd
         uwBQ==
X-Gm-Message-State: AOAM533+alF6pqNwmS+rHJOWMCC/+iIeAk7RQvT27wcNqSV7XsYTsOh2
        E57KYEt0H/yHNHouMi3lspbkYQ+ZEPhD3WVMZC0=
X-Google-Smtp-Source: ABdhPJxE6/lqSbIrIFD1BhHDD+bexarqDwW1+leKzxBz5MqxugP2bAoLKwReJ4geoR/cz0YhdybYAmKOwiK4l65zoYE=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:fb54:: with SMTP id
 iq20mr1047953pjb.111.1605737270583; Wed, 18 Nov 2020 14:07:50 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:22 -0800
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
Message-Id: <20201118220731.925424-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 08/17] init: lto: fix PREL32 relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With LTO, the compiler can rename static functions to avoid global
naming collisions. As initcall functions are typically static,
renaming can break references to them in inline assembly. This
change adds a global stub with a stable name for each initcall to
fix the issue when PREL32 relocations are used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/init.h | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index d466bea7ecba..27b9478dcdef 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -209,26 +209,49 @@ extern bool initcall_debug;
  */
 #define __initcall_section(__sec, __iid)			\
 	#__sec ".init.." #__iid
+
+/*
+ * With LTO, the compiler can rename static functions to avoid
+ * global naming collisions. We use a global stub function for
+ * initcalls to create a stable symbol name whose address can be
+ * taken in inline assembly when PREL32 relocations are used.
+ */
+#define __initcall_stub(fn, __iid, id)				\
+	__initcall_name(initstub, __iid, id)
+
+#define __define_initcall_stub(__stub, fn)			\
+	int __init __stub(void);				\
+	int __init __stub(void)					\
+	{ 							\
+		return fn();					\
+	}							\
+	__ADDRESSABLE(__stub)
 #else
 #define __initcall_section(__sec, __iid)			\
 	#__sec ".init"
+
+#define __initcall_stub(fn, __iid, id)	fn
+
+#define __define_initcall_stub(__stub, fn)			\
+	__ADDRESSABLE(fn)
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#define ____define_initcall(fn, __name, __sec)			\
-	__ADDRESSABLE(fn)					\
+#define ____define_initcall(fn, __stub, __name, __sec)		\
+	__define_initcall_stub(__stub, fn)			\
 	asm(".section	\"" __sec "\", \"a\"		\n"	\
 	    __stringify(__name) ":			\n"	\
-	    ".long	" #fn " - .			\n"	\
+	    ".long	" __stringify(__stub) " - .	\n"	\
 	    ".previous					\n");
 #else
-#define ____define_initcall(fn, __name, __sec)			\
+#define ____define_initcall(fn, __unused, __name, __sec)	\
 	static initcall_t __name __used 			\
 		__attribute__((__section__(__sec))) = fn;
 #endif
 
 #define __unique_initcall(fn, id, __sec, __iid)			\
 	____define_initcall(fn,					\
+		__initcall_stub(fn, __iid, id),			\
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
-- 
2.29.2.299.gdc1121823c-goog

