Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63062CAEC9
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 22:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbgLAVjI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 16:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbgLAVjI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 16:39:08 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C92C09424E
        for <linux-arch@vger.kernel.org>; Tue,  1 Dec 2020 13:37:33 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z29so3960208ybi.23
        for <linux-arch@vger.kernel.org>; Tue, 01 Dec 2020 13:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=B5HJdqCXUeL43UIVLVZJnxtwrYZ/thw26FrV4EWKXXk=;
        b=gzp1vYR/oXkNJrTfyPC+gU9AshMDJf17d4hXlEixyq63WSCsKKx3kDXJjLE3705Nyq
         Fo5ieQYTx2JVLwmaGskMvm1+jyZULJ03SfEv9yykRb2g73uRagV1yTPJy+ahrYRV99Qs
         VfiuyAzo5OTZaK2vNHAaDjnnZkvg7bkbVueCSfy5zymqb9Zl9C2ZImkyynaqirPNK6ba
         e2o6MqYUTsj7xpc/+jQAgUOMDI+fKOFd22bNsjjuBqWiITez5IABxAqzwCC3dIQDnjj5
         6X3ijsy0/J/N0HG3BH/CFt5ycSFf4nlbPH4Q6tCHT2m9Fj3AbeddPFsPWCTDAPwl02q1
         wRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B5HJdqCXUeL43UIVLVZJnxtwrYZ/thw26FrV4EWKXXk=;
        b=WCeLGSdzHUpSoVMSd7dLY0d7h4se3UnBgC/L4LOAiz09okWaUVta+1/yt1G2jWElnP
         AqZOl/rWpe+8Mr14hAj3UdmNX1EMrGVvwbFjE3RXbLh0AP8PLb9SxgQjhTbiFyAWjvkQ
         JlveAEPICi76PC57esX4rmNyhNLXLEcf+dGhDPADA2d8VfQ1wmwBqOHgTQEdgHbA3VcZ
         8VjcSQSVhOWYNv76sqfEJij/ULKv1/flujrpXZzXAo5xa/9+U3GkCtB+tL3mzKDKuLnz
         kMJDk5P6o/KO/4q5qLyqA0adIk8hDDsCQzv6d4RL7vxzLvcOpkIzYIywYsdO3jKuc0UH
         SQcA==
X-Gm-Message-State: AOAM531mSAnL+c8+RgQ6g8zAqPmmT5I1pasvpzU2XMCWxNxm0kZirJlf
        j46Y+UAivVVk7OQxjfkigvfU/Kc2ym2X5l7JQxY=
X-Google-Smtp-Source: ABdhPJyOyTY3dsog0bEyrf8FQNmA+LgDAtxW1LSmGP4jpoGSceI7DnRj4mOHZ3s0UwiUKjNjBIGpuS4DR9GRfrOYGf0=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:4189:: with SMTP id
 o131mr7599389yba.95.1606858652596; Tue, 01 Dec 2020 13:37:32 -0800 (PST)
Date:   Tue,  1 Dec 2020 13:37:00 -0800
In-Reply-To: <20201201213707.541432-1-samitolvanen@google.com>
Message-Id: <20201201213707.541432-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v8 09/16] PCI: Fix PREL32 relocations for LTO
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

