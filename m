Return-Path: <linux-arch+bounces-14049-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4D1BD53F5
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 18:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 636A556835F
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 16:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B21831C56F;
	Mon, 13 Oct 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rEuKg6E6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26653311C17
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369995; cv=none; b=oDvgkcPd1cL0axx6ROLaDZ96XllkM4Ekr+p6CG6iw5LN6DFqJ8evm1s24zgeqUPPcYPiD7k25xTYTQdJUADQKu/UBl9Tl6REM6txVKOx9dGXmUcHrSxSXIUELFkJOXOspHyrdZ8Dz1ttX4gUskD+qazcmdJhmfVM8a+grwFmE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369995; c=relaxed/simple;
	bh=fDM6kg3PMSfYuYByY6oqdA9ZDhOomL/usVMge98nAI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mV5gFGOB5spJPShz9yzWVt+Ri0yPVAY5KVzKZnFEOWimBODhN8isRzwDVC2XypaDF7Rg7ds1VnX5M+x7mXfzWFxSok9wYuOAqdHdzxlRB6oQf+0dEHpjMVyUhwH9DI0+3gIcjYnWPxxlkKsdP9YmfF0Elz0GO4mis4/0Tvz0dZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rEuKg6E6; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ecdf7b5c46so2063992f8f.2
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760369991; x=1760974791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LLIMysTR71S/0o+W4A3DXR+AhBZbEvctBTcDuVNaPrw=;
        b=rEuKg6E6xRTEhj4pvTGndHEOsGa541HwYGEMeNSiahe8xyt9HdQtOxbM/wLguGzfHw
         lbrEV0QW/HkVblNVjqGDdBNJEv15rEQAYLgodGw6xBFQdP+ilJhHa0lo/9aa3Pu2I522
         mMco7EARXC2YgdxxcW9O3CKMom1yo9+NS+awMA6uDGEOmK5/nkVfB+jLMTmyrj6OgBlI
         ghCI0d08+ud70oNV88fISMXlZAzUUYkdhCAtxpPqJ0owxCpsVagtnsacRfQGX9TFELZJ
         1OmEK2JzEDwrPhWB0Yj40N3eouXIWrUptrTLQ9+fWt/Q5UxZqPyqmK+PAoWGgO9cBfe3
         nzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369991; x=1760974791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLIMysTR71S/0o+W4A3DXR+AhBZbEvctBTcDuVNaPrw=;
        b=s+7a5fV6d7dyG/8SBx0dEA7slcJ58vpTC7Ep8acLVsvmq6USihq/ABrUTeoNUg+IbO
         uxrQ56RF0YdIoCCqNjyEzZzCPLFVpDIb5uYrg5VvNCtnlXyW3EFPqa4CmPbXs5fM+fAT
         FWeR0BNykmhFS1gZkhIULRqu+I2xtcZe7BjbYNjtPvPxWpx/fImuEGJW8GGU8oQEg0bZ
         jJKTbADfxp9rlG+wtyN/bd//90bTlZTwb04taEMs5xMKzHEAvrG6b255/Oq0nhHN8GBI
         2EVhe7Kbwp98n8TZ5q0L6DHfnh+iP0VacabixP0uzg1Ksm7q39iGB4N9r1jZ0fmp3UjE
         FA+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsk6TVAPASArK1OSRrifeDxWdeA3+p7PMhOGQIh7U/bj8r4SXosBgiq4du9QHVa6HlV6NjyCOV75AS@vger.kernel.org
X-Gm-Message-State: AOJu0YyXs9nhnaTHEZPCcx1XNs+0gtrVg9g+/qs505Bam1d1HmiML2Uy
	CRRCm0MOJoy0NtEWq/ICY/kJeyiLAfsx3wRfhtdt8f+e8QEr8+K2I+efVhiEvc1E8EMjzo5F5vE
	85MLCdhtat52C8FwcvA==
X-Google-Smtp-Source: AGHT+IFP4hNwTNRL33nbMqqEWJZ6dS2HryYYTX8R63ntqFIn3FAoAX0EvUWPA8ISlAngJYPDX/qIYNcJsWpCB6o=
X-Received: from wmcn2.prod.google.com ([2002:a05:600c:c0c2:b0:45f:28dd:87d9])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6304:b0:46f:b42e:e39c with SMTP id 5b1f17b1804b1-46fb42ee509mr93409275e9.41.1760369991432;
 Mon, 13 Oct 2025 08:39:51 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:39:13 +0000
In-Reply-To: <20251013153918.2206045-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013153918.2206045-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013153918.2206045-6-sidnayyar@google.com>
Subject: [PATCH v2 05/10] modpost: put all exported symbols in ksymtab section
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

Since the modules loader determines whether an exported symbol is GPL
only from the kflagstab section data, modpost can put all symbols in the
regular ksymtab and stop using the *_gpl versions of the ksymtab and
kcrctab.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/export-internal.h | 21 +++++++++++----------
 scripts/mod/modpost.c           |  8 ++++----
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index 4123c7592404..726054614752 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -37,14 +37,14 @@
  * section flag requires it. Use '%progbits' instead of '@progbits' since the
  * former apparently works on all arches according to the binutils source.
  */
-#define __KSYMTAB(name, sym, sec, ns)						\
+#define __KSYMTAB(name, sym, ns)						\
 	asm("	.section \"__ksymtab_strings\",\"aMS\",%progbits,1"	"\n"	\
 	    "__kstrtab_" #name ":"					"\n"	\
 	    "	.asciz \"" #name "\""					"\n"	\
 	    "__kstrtabns_" #name ":"					"\n"	\
 	    "	.asciz \"" ns "\""					"\n"	\
 	    "	.previous"						"\n"	\
-	    "	.section \"___ksymtab" sec "+" #name "\", \"a\""	"\n"	\
+	    "	.section \"___ksymtab+" #name "\", \"a\""		"\n"	\
 		__KSYM_ALIGN						"\n"	\
 	    "__ksymtab_" #name ":"					"\n"	\
 		__KSYM_REF(sym)						"\n"	\
@@ -59,15 +59,16 @@
 #define KSYM_FUNC(name)		name
 #endif
 
-#define KSYMTAB_FUNC(name, sec, ns)	__KSYMTAB(name, KSYM_FUNC(name), sec, ns)
-#define KSYMTAB_DATA(name, sec, ns)	__KSYMTAB(name, name, sec, ns)
+#define KSYMTAB_FUNC(name, ns)	__KSYMTAB(name, KSYM_FUNC(name), ns)
+#define KSYMTAB_DATA(name, ns)	__KSYMTAB(name, name, ns)
 
-#define SYMBOL_CRC(sym, crc, sec)   \
-	asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""	"\n" \
-	    ".balign 4"						"\n" \
-	    "__crc_" #sym ":"					"\n" \
-	    ".long " #crc					"\n" \
-	    ".previous"						"\n")
+#define SYMBOL_CRC(sym, crc)					\
+	asm("	.section \"___kcrctab+" #sym "\",\"a\""	"\n"	\
+	    "	.balign 4"				"\n"	\
+	    "__crc_" #sym ":"				"\n"	\
+	    "	.long " #crc				"\n"	\
+	    "	.previous"				"\n"	\
+	)
 
 #define SYMBOL_FLAGS(sym, flags)					\
 	asm("	.section \"___kflagstab+" #sym "\",\"a\""	"\n"	\
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f5ce7aeed52d..8936db84779b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1867,9 +1867,9 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 		if (trim_unused_exports && !sym->used)
 			continue;
 
-		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\", \"%s\");\n",
+		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\");\n",
 			   sym->is_func ? "FUNC" : "DATA", sym->name,
-			   sym->is_gpl_only ? "_gpl" : "", sym->namespace);
+			   sym->namespace);
 
 		buf_printf(buf, "SYMBOL_FLAGS(%s, 0x%02x);\n",
 			   sym->name, get_symbol_flags(sym));
@@ -1890,8 +1890,8 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 			     sym->name, mod->name, mod->is_vmlinux ? "" : ".ko",
 			     sym->name);
 
-		buf_printf(buf, "SYMBOL_CRC(%s, 0x%08x, \"%s\");\n",
-			   sym->name, sym->crc, sym->is_gpl_only ? "_gpl" : "");
+		buf_printf(buf, "SYMBOL_CRC(%s, 0x%08x);\n",
+			   sym->name, sym->crc);
 	}
 }
 
-- 
2.51.0.740.g6adb054d12-goog


