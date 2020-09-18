Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3A727068D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIRUQX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgIRUPb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:15:31 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD17EC0613DD
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:24 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a2so5557116qkg.19
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iG8c4IVmV6SAigaVNA/2Da1zni30786ipLEHlcLZdp4=;
        b=Qgpy+pbznAwuGgS1UcHWV2+GgEBqJBW/QXwkjniAUgd0yEt/iVnU3kXXwNdozhgQzz
         MZzhTSncTCZS90D0o8lSwmN7wmdlvsaE1QWRoTj6Wbe2nae8ffdijksuNQIIVYs/eybZ
         PhIUX9y2TjqMSdsaiGH0h2KtARkrrLOZf/w8Sm2VeQum5NJG1Sy6tVoqsuv4aAwEG7YK
         02eRqNOcpZQaCeV7Ckrk7WrJ5FjODwlvlNCDUQkrG9fITgVhDbllmG+pZNctstR4JiRy
         rA0r42k8E4pddkc8iQa3ov74ZrsmEOgVOhRYMv7EwvJEm2M2DLQUQBG2GyMEcM38Vad0
         xDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iG8c4IVmV6SAigaVNA/2Da1zni30786ipLEHlcLZdp4=;
        b=CZqe/7BuCH/VsGcZqN1aJ+fDCF8rCM/XY+/nApcWTXIn1pTj+/2/DO0AWnGWhyoPrB
         SDQu3qhjtR0Vod2BHQ9KCUK/CpchCceozKQzhElPwoylOo0Z16rGig/AzY21bjV7hEM7
         FgvlELqs1VlsxP9EJeLlgSnsWG7WnxsKI4TsgtUMQUeqbBJrNtDtRM/CHYeZasO4dsi9
         4TxaGXi3vn4RLE+yEYfYKDgG/Sq0Hv9UeElGDn4bjSf6rUJv4Q0zcFAML80z9bHrWrdP
         RUC3mioY/gSywxWsj4paqKm5t8gMugX9LVNH5332ynhC75zNBFhgEwFAeyPGMb2gvxP1
         Qxlw==
X-Gm-Message-State: AOAM532flXWt9pQ3rXXr620ig4vwf9N/x5PsvuFPBmsh/5J3kVF11FZg
        DFohoZUTuiZaiLShl3/3NE2qPY+M7n+959qG7HQ=
X-Google-Smtp-Source: ABdhPJyAaI/eiFtDj86m6e83BVMlPsjdMZNZWL0L4WJ70VEUwFhQzIrnfngpXkviQEnEmXABI7Y2dHDcYxV6d7VeWCU=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:58c7:: with SMTP id
 dh7mr8337663qvb.20.1600460123968; Fri, 18 Sep 2020 13:15:23 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:25 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 19/30] PCI: Fix PREL32 relocations for LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
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
index 835530605c0d..4e64421981c7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1909,19 +1909,28 @@ enum pci_fixup_pass {
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
2.28.0.681.g6f77f65b4e-goog

