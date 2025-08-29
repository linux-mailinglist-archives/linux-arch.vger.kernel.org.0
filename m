Return-Path: <linux-arch+bounces-13332-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1632FB3B969
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 12:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BF31C85F6A
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BB43148C7;
	Fri, 29 Aug 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5n0O6Wt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A04431280B
	for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464878; cv=none; b=A4oFqWu+HtBq4O+d5nQMi2sCEzyssY2Pbb7jX5Lp/IEQz4BpxCOhoqAXqsPn1Ws/teqRKLka7i6MHUrAHLHOLSe4NQ3+5mPJgxJYq8Pt9v+Ia0xPv1cKL9SQmXZl1VlCI2MVRexdLU8mVLq4h+beXTfeQ6pGY/w+ALsF4j64yqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464878; c=relaxed/simple;
	bh=zCQKK9m+KKuyKhTLmtwoTILfUCZPd/hNRBlyLkdveFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kc9LFmTsholAlr6W5ledaRsDECSfh8UgnhP5BkXLebec9ZjGTh8pQlj75M2Y9LZyTfdKyKJ8B46g0/o9DNmp4H7xMRsw4g+N4k1iyIs0tUb/dHgUOn1+WiKB6fJ0yeEcCVBZM8TSaE6uwd7oLkQF+Pp/ycP7eL+Ci4uFi1VJQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m5n0O6Wt; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0caae1so9716865e9.3
        for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 03:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464874; x=1757069674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qmPxRzAkCLsUXg26vuwkDnrhDTwJQL7buKLtRL62U1U=;
        b=m5n0O6WtgFU8lJRL6ltcrvQ0ZkaBnzp3kjOgjRI++TxlWGrLj+bMkP6InbIKodn5Oj
         L1dBqsJeoZP4O4x8kKxCOQ6wgLZtMI1QGK17oNzfZZYCTX1o3dbSWdx48a2xvaPIfNbB
         67DmQXtbgmld3OW2HKadXGFphXa67YCGeHEG5YaKV4Sfmpkhx7/K4ldv9AHv7EABronG
         cCS5IkeQBkyMqMsXpBc/y3o60gAAsZk+eBEHMui9rGsktuy/Su1nDfO/kI8rr6CxgRvZ
         yiS/8oLboSdwaZID1zollV9VktPaknCE69J5N0oxBfUgBRQ4MQtzt5YYOvnkUUXYL46+
         HzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464874; x=1757069674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmPxRzAkCLsUXg26vuwkDnrhDTwJQL7buKLtRL62U1U=;
        b=Dlv6iIZD7ibiN1C1banHWALVxxCihwad92GH5kwoT0N7/YFQc6HVijFa0NkKXIyt8S
         6AIaKAKEC6elqU1alit8B7JwsX4EK2eNh7VKAJ3okFD8t9dDCvk6j0LNTjucN2EMsxst
         xNCfqRkR8xx3cmYVgwvU4CWQl5zm9lSjRZzgs/snpVmrKUX9h6B3sqiwQkJeQrzLgZIA
         6XyuYe94zmoFJkjhow8zCi94i95FD+W5ake+p7o9t8ZWlnLMdM66nPkATnt7gzdIGSLA
         oWQsn5jRDa5TXJu2pdmAJsUjfH3RSO4jfk80VXfzAUTPh2SWt8EjCP8Pv/ZBCPo8u2A5
         DwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/iuCaPPXl0Egnw8nuG12raSptfahueTiv67nsCF7db9ZcDF+qBlE6BjXdlJVpDH0Xtle3q6LSaqz1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7UBfrL0x8tMnTIGm/oOtNlGBO/oTyLxiUvgO+aRqszsuWXByz
	hN6lWNf3m/f/jIs1MfF824nqNqiZCpBxSgt0R18QBx8swrMtR4SXP5ESNzgGmkOszQiLvUhJG6l
	+YvPv3QbxNQdEv8CHzg==
X-Google-Smtp-Source: AGHT+IElRmJCyExdp5sqN3Bq7s04CX81XnHqEMpfJfcSboz7fZGDW9C7V4YwGMPKStkjm9pWTX9m+C+ad9Vw1dk=
X-Received: from wmbji5.prod.google.com ([2002:a05:600c:a345:b0:459:7c15:15b9])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34c8:b0:45b:8067:d8bf with SMTP id 5b1f17b1804b1-45b8067db82mr16690415e9.14.1756464874501;
 Fri, 29 Aug 2025 03:54:34 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:13 +0000
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-6-sidnayyar@google.com>
Subject: [PATCH 05/10] modpost: put all exported symbols in ksymtab section
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

Since the modules loader determines whether an exported symbol is GPL
only from the kflagstab section data, modpost can put all symbols in the
regular ksymtab and stop using the *_gpl versions of the ksymtab and
kcrctab.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
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
2.51.0.338.gd7d06c2dae-goog


