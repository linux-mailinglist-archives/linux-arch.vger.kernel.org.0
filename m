Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7216D288E17
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389785AbgJIQOZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389750AbgJIQOT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:14:19 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87822C0613AC
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:14:15 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id u2so7154234qka.2
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=b5rCnYz4obhAgpKHq4mgEn5Hvv5UPGIbAlGkTv5aKg4=;
        b=E5G/sJ81fFEbU3UrV/4DwBfDWW8suW611A0G6/DwYfbR04ohtV708reO0SJgwS2rf7
         bSqsXq3OjK2yL1hKhQfhwZRZ5aBj98+xPOc+UFD8lX0GapobLOFhUzyy2r2Ix8ArAd0p
         mGmDn3PZkPNl1b/DlynJoS1L8xMBaXaj6SJ35+lWUlg4xMQamvtjXzlzzct2MoZ5wPyM
         MNKTdnp/zeU1v9mmBSvDZzYwOLTZJr2sWDxiglMg0b83/FZMs4lgJsucTLS60ojx171N
         0Z36nkDB3h5N6Ml8sbsV3TfqqbNBcSFUY1hiHFHCfLLxtVk4pfMm91HtyPzFHHq4SRa4
         QS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b5rCnYz4obhAgpKHq4mgEn5Hvv5UPGIbAlGkTv5aKg4=;
        b=TBdWO9ngfOwrrGRtOUjGijsmYD8fAq3kD9btNsNuZHf6rlbA6meN4+vZ5/J4DQRfzI
         BfKtM9A80s0UZvKlho9mLkCYY+2Pts9T/gjdrfK6JQK69ZCgOGEqK/iigatA0XJ3Ghb0
         SvwwnGOKdaehxxrGGOXBcPgbSwsH26p3z7iD0RAQ264gNNWuoGmoYF6vmZ104ewtlgrZ
         fh8wqhihI+hJBVYfwhSiyXTV4Qsw/tkYs8WxMfULZixfdFgkemC0tccL1aJSo4mvr5q4
         FGC2kb5hWEboAH3pei17G0el9vGU2poLLxBy4dYwdmW8IrDW6/J9NhVyIRw32YYagi3S
         DzCQ==
X-Gm-Message-State: AOAM532pfXc0wIIYxHiAhuNH3pIwT7E4+QxkjzHGKxwIvSftbrf7I+yz
        OoZGrzCibjWf0x7ZeIyBmK0GBz4vp4BT2cC5rb0=
X-Google-Smtp-Source: ABdhPJxUsLNRYd2SDtvgB7CmXqlcp3vGOaCoLMxBFjkUgYB81ry88e1Q7zWE2vdzY9Ol+dTKaZMDIAjVS73Q6wHF4BA=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:122a:: with SMTP id
 p10mr14125090qvv.0.1602260054668; Fri, 09 Oct 2020 09:14:14 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:26 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 17/29] PCI: Fix PREL32 relocations for LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
2.28.0.1011.ga647a8990f-goog

