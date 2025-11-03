Return-Path: <linux-arch+bounces-14484-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42719C2D15E
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 17:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EDD1888127
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A6731AF22;
	Mon,  3 Nov 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4cxwHzI0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CA83191B6
	for <linux-arch@vger.kernel.org>; Mon,  3 Nov 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186811; cv=none; b=uHagwnyBF8fGqrGI77qXW2yfnxG6CAV1iT+Xf+XipaNwK3aNwNZD5kUZZYxt78NX0hNPosucNrsyhzoAA7SgzjPn5AzLuW/MDw3Rk5/TVDunvotUX4F5Wk3JQXAVM5bxBAFr7iHIv2z02EjiGE3P8QGBBkqltG8mGyPmNe88lJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186811; c=relaxed/simple;
	bh=9Cwz4yVXI1l3qeHRLhyx4TZ/Ev1Njh9gQAluw4KuMPo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dhvAnqEW2UJhkTnorBpg78hHpM14sEJtcWg3qMScTSY+feHi+nbwKJqGy8QYFvysmbszcMQka1u63cD86Rn7tf/sW3wOQNJ9XLSk6z9vngR72PGMM/MvXR9XJ4IXlulJVwcThTLrtV8mxjE/kBYog/pPQeUGWfxALGSTOBxeBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4cxwHzI0; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so50743225e9.3
        for <linux-arch@vger.kernel.org>; Mon, 03 Nov 2025 08:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186807; x=1762791607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I3NEOOYIbpeR+4we18GdYqD7b1OledoGg+btJU35ZGk=;
        b=4cxwHzI0AQ7iZu5m355hJAxmp43DNe8NLTTPMxhU66Jvx5j63K3bc/HwCkxT0latvQ
         EKQWh6CYyJKgX6ubDo/JA/Yw+NSB3c+H+YRb4Gz95zmUKM2LCgYYEMOCZS+0nz7zXoJI
         ScBdlLG3xmJzAyHc5musgPZgb/XeVPTHtydcbOMX+/vFohLDx+npb8oY8V9Y7wYaNd9W
         s6vEWqIBslb1LKqJnCBWOJ6bdyhCduby0FITfZFGNWN6Bgi4E0pONa2zgySBUMBfaDtQ
         xiXRLjp16Kyc+R2f2IgiuNuKzgUkRwU0pKNUJpAmGzV5e40qIr+SYhgPKs3x3tFiQwAm
         SXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186807; x=1762791607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3NEOOYIbpeR+4we18GdYqD7b1OledoGg+btJU35ZGk=;
        b=H/JyMkjWnUUH/XckK205jHD4xzFi3kHvIoTVpCZrX/oJQ5gpG+8WyY/vRYvIPgpTkk
         iXT77GMKxKvijc+xDdLstDm5eVuMZd0wdA4dI4BaYM/N4tegvYXcjZp24+aE1hgQAs06
         PwL/vd86xS1dykO/Pr3Ju0vsAvg1dr+fHSkvqvVxkTzXf5+acqIACR8fyYchhjN13EUd
         CUN6I2TlHN3519kt5EPWfLqPxJFifH+zauZJnPpxAFRG7EHARVYC4Q/zRCGnmM1TTOhQ
         slb/exfKcbQaMaEi4ACcLrDtV4brGxng82kB1qW1JFe9ndmyhajLtP1BJyGKlFTuudmQ
         lJuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeTlbYHmqnRpH7ERfJhtWdCeuY0baT9TfsYpKp40jnUxo7k5m7woHLPX0LDn2//yLM0z8/TPSrk+fJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb51JLONLQt6ArflIQDb7ebG83khZQeUn3J0K6VxO1M1DU88f7
	k0sPeNYaSV/z4Ql9l3nj0PuX4boXyrgjkhDm1AIf2lnjjYJWKMp3G9JFMowPMerB9D0zGkYKQKP
	QQ6RY0Y7zc96xhRxpIg==
X-Google-Smtp-Source: AGHT+IGWADIxrNkiKWiAtHE2F2qUzfmmzbjTu7H/WDRRQcPsxtPCSsOpwinifQgqwk4x+PMn602oe0eH71+Kf3k=
X-Received: from wmco23.prod.google.com ([2002:a05:600c:a317:b0:477:40c1:3e61])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6995:b0:471:15c1:45b9 with SMTP id 5b1f17b1804b1-477308b0606mr131316165e9.29.1762186807379;
 Mon, 03 Nov 2025 08:20:07 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:51 +0000
In-Reply-To: <20251103161954.1351784-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103161954.1351784-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-6-sidnayyar@google.com>
Subject: [PATCH v3 5/8] modpost: put all exported symbols in ksymtab section
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
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
2.51.1.930.gacf6e81ea2-goog


