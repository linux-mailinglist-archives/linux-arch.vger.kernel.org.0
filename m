Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21262D7E90
	for <lists+linux-arch@lfdr.de>; Fri, 11 Dec 2020 19:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbgLKSsn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Dec 2020 13:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404795AbgLKSsa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2020 13:48:30 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B885C0619E3
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 10:46:54 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id h1so7028579qvr.7
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 10:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=B5HJdqCXUeL43UIVLVZJnxtwrYZ/thw26FrV4EWKXXk=;
        b=CI1Z1ksraZ9iV323F1+iZqU11ohoR7PeCXzqdRVa+VPq1uQ3aVlILlGyCMggutWSZh
         toLJVqMi1M53AWHDdaW4XL+FYrTYFeGJoBHf5coo7gwbFzOhZJL8v1qpLIOTb3z8aV1q
         LU62sjLP3/2xVwScgJOjKxlGys5dCTJXM7F9pbwXc3Us7y1Bms4nmyLFiAyAGs8raRLu
         mCsKDkGu/2yqUolqiz63Y9CA2BRHkf8FRGTon8/JBgKj4dTg9k2vBkMRQRW0bWup9J5Z
         B9KEUS2NCp+GN2iFEIoblQjbVITiJ1piXgw1hDZ29L9ZLU1esZxkERsW394RCsQNRyy0
         8b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B5HJdqCXUeL43UIVLVZJnxtwrYZ/thw26FrV4EWKXXk=;
        b=KNOxQvMAvwhEZbgAJaInEPHiHOV69wPmCFUayDx+8U1U/fi3cdJXlV7HSnfTO4M5fu
         CHDK+Pb/qSTDEtRu52ZYSnHJKkFv6zbwJ4q9Z89Xgc+62ruV+7m41W7KMCqZRulABxHJ
         cV7RJZbXMFKcM73aCpVPw9/bFNOT/0jya/rw6MVlFyjPhwZKDLRqsMoUIzyvU3dv+bYP
         52owMLpOO5poJaQpMjMrr2KKZhTsjvX2HBkzsT4TO9AwEyvN1oj69gDdflAkHmDXapCv
         4xPTGr5E24Ao3NNq/tOv/KLnBxuvi/qfFVAV93JbasQT6CYEbkuuy+8Qk+o3rIx2gqqk
         4RBQ==
X-Gm-Message-State: AOAM5335tKpYHv7TOzia8jqrj2u2jqMsIb2VLHQ5Cw9yt2jsczs6O4Ir
        Cv1aQzpKNlHKyQLNssAclluddzoDOwKsFUICMto=
X-Google-Smtp-Source: ABdhPJwrma1lcyBdkKY9Fn3d/aj96Xjbcqm6ANOmxB5F+S78NXSz4LS+Jidn8aXBd6ggUskWzgWXGBBPQ7DVfOBFzGY=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e312:: with SMTP id
 s18mr17700151qvl.60.1607712413271; Fri, 11 Dec 2020 10:46:53 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:26 -0800
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Message-Id: <20201211184633.3213045-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 09/16] PCI: Fix PREL32 relocations for LTO
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

With Clang's Link Time Optimization (LTO), the compiler can rename
static functions to avoid global naming collisions. As PCI fixup
functions are typically static, renaming can break references
to them in inline assembly. This change adds a global stub to
DECLARE_PCI_FIXUP_SECTION to fix the issue when PREL32 relocations
are used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/pci.h | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22207a79762c..5b8505a5ca5f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1912,19 +1912,28 @@ enum pci_fixup_pass {
 };
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
-				    class_shift, hook)			\
-	__ADDRESSABLE(hook)						\
+#define ___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				    class_shift, hook, stub)		\
+	void stub(struct pci_dev *dev);					\
+	void stub(struct pci_dev *dev)					\
+	{ 								\
+		hook(dev); 						\
+	}								\
 	asm(".section "	#sec ", \"a\"				\n"	\
 	    ".balign	16					\n"	\
 	    ".short "	#vendor ", " #device "			\n"	\
 	    ".long "	#class ", " #class_shift "		\n"	\
-	    ".long "	#hook " - .				\n"	\
+	    ".long "	#stub " - .				\n"	\
 	    ".previous						\n");
+
+#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook, stub)		\
+	___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook, stub)
 #define DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
 				  class_shift, hook)			\
 	__DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
-				  class_shift, hook)
+				  class_shift, hook, __UNIQUE_ID(hook))
 #else
 /* Anonymous variables would be nice... */
 #define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, class,	\
-- 
2.29.2.576.ga3fc446d84-goog

