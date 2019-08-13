Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 148498B83B
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 14:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfHMMTP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 08:19:15 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:43497 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfHMMTP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Aug 2019 08:19:15 -0400
Received: by mail-qt1-f201.google.com with SMTP id p56so5474835qtb.10
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2019 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=52i5W7bwo5L4NKPi/t621ZC4mfXuxf76PQ3XmRwW6HM=;
        b=X/pgFG/TYnO3wKM8nw/G0c4v0tOMmQdSnN8sjbDmuSgMHWrl6X+89yGWfc1zRmqGBm
         2psEodSKm+/2j3izZcJSwh+do0lxOJ4IdJ919zTrnssGXYKHj74o5LYYGq9C8uPDHY5q
         g2LiVJBFkP/CGURRmfNZIany5JG8mi2TMrG0Bd6uXJ7oNOJoL/pnInv0Qzjz7lymxdtT
         GJKYSZXUWMP5I8obvV1nxyk8xIUK02USI2/gUQVi95NnK73bsBva9KSzKlQ5r01eUJZC
         vFkcc1Qu8HnPfg8KB//WUh0W5FcntqIdFm+4BfszHkaidZELeMy4MwnDiZUvpNyAafnm
         niNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=52i5W7bwo5L4NKPi/t621ZC4mfXuxf76PQ3XmRwW6HM=;
        b=Z0YJEA4YrrW0yfDzgSWTJYxPyhXk6uIsbBvTG2iedqc8W7J6JS7EtObkLYXapJ/fTy
         OcX9FhNvHF0LwpfuVzThhn4Z9BQzJeJ8bMX7sntRhPD2cV5ujzb6nTJbRhA8JazyMGh/
         WosB9FrdXBI+q0Mxujk6wJ02315//hTqeaezdIzNlENa2nTCDlukwa5TG0rjg/uxfyXi
         drgJ1Hvo1+alumphkBgwRrcCQJnVFVS2xL3qhbX2tzTonOIhw07e6ZDsoYr5c/rR/oyr
         ot1gmw64J7/PO0OBVbB2lOWTE20dCgFvimAJiVGoHEIwDHd9TyATVP2AqtYUpXcVw0Wx
         vlGA==
X-Gm-Message-State: APjAAAVFeIFTx0TrvncuhMLrChLcFXpq6s3lmin0SjFWKLlque1qod3Q
        AeRTJHn3tm6JweD1Jf1UYfx2Us8pzAGJRw==
X-Google-Smtp-Source: APXvYqx4tXl8kJyrgPk73kSdFDxtYVeFJ3ZKPrk2o0B9NEEoRmlA/4IcV5D6ufbujg8Fb+w0iwWYKEEibfHjFw==
X-Received: by 2002:a37:e306:: with SMTP id y6mr9040041qki.174.1565698753802;
 Tue, 13 Aug 2019 05:19:13 -0700 (PDT)
Date:   Tue, 13 Aug 2019 13:16:59 +0100
In-Reply-To: <20190813121733.52480-1-maennich@google.com>
Message-Id: <20190813121733.52480-3-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190813121733.52480-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2 02/10] export: explicitly align struct kernel_symbol
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org, maco@android.com
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@google.com, michal.lkml@markovi.net, mingo@redhat.com,
        oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org,
        sboyd@codeaurora.org, sspatil@google.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This change allows growing struct kernel_symbol without wasting bytes to
alignment. It also concretized the alignment of ksymtab entries if
relative references are used for ksymtab entries.

struct kernel_symbol was already implicitly being aligned to the word
size, except on x86_64 and m68k, where it is aligned to 16 and 2 bytes,
respectively.

As far as I can tell there is no requirement for aligning struct
kernel_symbol to 16 bytes on x86_64, but gcc aligns structs to their
size, and the linker aligns the custom __ksymtab sections to the largest
data type contained within, so setting KSYM_ALIGN to 16 was necessary to
stay consistent with the code generated for non-ASM EXPORT_SYMBOL(). Now
that non-ASM EXPORT_SYMBOL() explicitly aligns to word size (8),
KSYM_ALIGN is no longer necessary.

In case of relative references, the alignment has been changed
accordingly to not waste space when adding new struct members.

As for m68k, struct kernel_symbol is aligned to 2 bytes even though the
structure itself is 8 bytes; using a 4-byte alignment shouldn't hurt.

I manually verified the output of the __ksymtab sections didn't change
on x86, x86_64, arm, arm64 and m68k. As expected, the section contents
didn't change, and the ELF section alignment only changed on x86_64 and
m68k. Feedback from other archs more than welcome.

Co-developed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Martijn Coenen <maco@android.com>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 arch/m68k/include/asm/export.h | 1 -
 include/asm-generic/export.h   | 8 +++-----
 include/linux/export.h         | 3 ++-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/include/asm/export.h b/arch/m68k/include/asm/export.h
index 0af20f48bd07..b53008b67ce1 100644
--- a/arch/m68k/include/asm/export.h
+++ b/arch/m68k/include/asm/export.h
@@ -1,3 +1,2 @@
-#define KSYM_ALIGN 2
 #define KCRC_ALIGN 2
 #include <asm-generic/export.h>
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 294d6ae785d4..63f54907317b 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -4,15 +4,13 @@
 #ifndef KSYM_FUNC
 #define KSYM_FUNC(x) x
 #endif
-#ifdef CONFIG_64BIT
-#ifndef KSYM_ALIGN
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define KSYM_ALIGN 4
+#elif defined(CONFIG_64BIT)
 #define KSYM_ALIGN 8
-#endif
 #else
-#ifndef KSYM_ALIGN
 #define KSYM_ALIGN 4
 #endif
-#endif
 #ifndef KCRC_ALIGN
 #define KCRC_ALIGN 4
 #endif
diff --git a/include/linux/export.h b/include/linux/export.h
index fd8711ed9ac4..28a4d2150689 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -52,7 +52,7 @@ extern struct module __this_module;
 #define __KSYMTAB_ENTRY(sym, sec)					\
 	__ADDRESSABLE(sym)						\
 	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
-	    "	.balign	8					\n"	\
+	    "	.balign 4					\n"	\
 	    "__ksymtab_" #sym ":				\n"	\
 	    "	.long	" #sym "- .				\n"	\
 	    "	.long	__kstrtab_" #sym "- .			\n"	\
@@ -66,6 +66,7 @@ struct kernel_symbol {
 #define __KSYMTAB_ENTRY(sym, sec)					\
 	static const struct kernel_symbol __ksymtab_##sym		\
 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
+	__aligned(sizeof(void *))					\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
 struct kernel_symbol {
-- 
2.23.0.rc1.153.gdeed80330f-goog

