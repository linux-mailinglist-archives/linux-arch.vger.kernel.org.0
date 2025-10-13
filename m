Return-Path: <linux-arch+bounces-14053-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF1FBD523F
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE083E6626
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C96031D738;
	Mon, 13 Oct 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EoGaZkvb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2D31D361
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370000; cv=none; b=Mw3YMZuHr26aYAFCmX8PW5ya6cNsf/+D1if8sxn1v22r9+JxNVDNaP8qHsln5Cnn/ux+qlcpMF2pA+Q2+XrflJ/mPG6JwYIQuWl6ACEosYilU0vqj+277eC0SGXOB0p+muyW4Q5ydVSlmJxNXNOwurPfBfb3uaNMDjhYHFzjbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370000; c=relaxed/simple;
	bh=bdfeOJ1CSPp//SYUVDBBQsYQyaNxDAAd/0lEE35bEzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hVilBo+PaNeAGq5pLRfT4JpunmjwvGymqOEaXH129WgXdVb6D7v5z/VH346Ug6Mk1wAB8tByTfUW83Z4eUncUxMHK7WA68emJq2K+M9qFH6ToLiftLjZeW2punvXUlrGfjUanx6/x2lq0hbuUiIrJhlnOq0o7F/YWssiaFDjNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EoGaZkvb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e509374dcso18342215e9.1
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760369996; x=1760974796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kwQoFRjsq01KVdK43Vv6ynyDB+DHrQ33po0r+B72Arc=;
        b=EoGaZkvbAHoVLP/1Qqz3QEWC9Bu6buB2FzlNyVguEOY2Of1OKSUH08OO9ugDWHSdMT
         zThb95JjRQ8T1cZp85fi/vLMC5Kjd3xVu55ZkQsYe86hhAWauuDojqwr88z+OUHrnngp
         cLAdKHSOgPkmA7nSrT9tX8g51Kw0Sctqof7CaWYNcZn3vTJV+CJ/A6e3DbsFdT6C5Hvs
         WfzK1XR2OYdYGRSGkcMco6c898jlxJv2H7xSGxahwP/mZmfWWqJw3tOaQxg4dnJuzXR7
         Qnw+/ztls/FttKZe5vqeYU8nNQgSoXKiT2N4Y+ePjMdcjDvkRtT+l+jjuufcRkODTQdU
         QRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369996; x=1760974796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwQoFRjsq01KVdK43Vv6ynyDB+DHrQ33po0r+B72Arc=;
        b=PsPremAbI+Cin4vj86O22eyp5MAmBRGmYHj0b5QRogQhLloUKz1bPik3DKKpVLPp2d
         JaU8fQLvtsb8qoxAuZ2BmUDuQB8ehh0eGDXlesNV7y9MahwHDRyA9MSvdGErUHmmo1Ja
         BCheG6MajSZ1RVkACshJmiWo36iS+UAIajwzXMaAepVGCf8ZKbYXc/ItHqBQ7M4C+p6r
         5uSUXraO5wlpPaJhSkv8EYRchLlirdsVK+aHdXFxJh9ZhO/UJY/3Af7Ac3IOQx/9WpDy
         Q8VaJJ+Fsqj+ZLdTgkdCgYjwOdX0jW0NwC8NgT2VDLcSWhPGJTWYwLl41w5C78ZBAcVP
         kkgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpMJQgv2NudNUvVdjoi8Mkd7Prfwr4y3K/e2A2sSo9lo6zsku2fGPezlU2WlUCgOXppPxtBycPHBO/@vger.kernel.org
X-Gm-Message-State: AOJu0YwWunbQbIUQrTB0C0JNaZripHV/P+A+wuIXjLz3ALhdG37xlVbx
	a4VdBnyhPNgXoqQPRpSE0IUqRfCfxHfPBYPTufLQjpko4oLe6D2Y7N0m9fzKj625YXsgq/arp7P
	A1IStPgzFpDiH9dq+aw==
X-Google-Smtp-Source: AGHT+IGVlYoiHkeXsTQFrvn9kgZVTgCWcB8oIqtDdxIvtExFOS98aaxHP9f4wr11J0Rsb8Np2hM9BT88Mo6nEpA=
X-Received: from wman12.prod.google.com ([2002:a05:600c:6c4c:b0:46e:6740:21ac])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8586:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-46fab89b7abmr122964145e9.34.1760369995668;
 Mon, 13 Oct 2025 08:39:55 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:39:17 +0000
In-Reply-To: <20251013153918.2206045-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013153918.2206045-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013153918.2206045-10-sidnayyar@google.com>
Subject: [PATCH v2 09/10] modpost: add symbol import protection flag to kflagstab
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

When the unused exports whitelist is provided, the symbol protection bit
is set for symbols not present in the unused exports whitelist.

The flag will be used in the following commit to prevent unsigned
modules from the using symbols other than those explicitly declared by
the such modules ahead of time.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module_symbol.h |  1 +
 scripts/mod/modpost.c         | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 574609aced99..1d0414da4c7c 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -5,6 +5,7 @@
 /* Kernel symbol flags bitset. */
 enum ksym_flags {
 	KSYM_FLAG_GPL_ONLY	= 1 << 0,
+	KSYM_FLAG_PROTECTED	= 1 << 1,
 };
 
 /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 8936db84779b..8d360bab50d6 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -61,6 +61,9 @@ static bool extra_warn;
 bool target_is_big_endian;
 bool host_is_big_endian;
 
+/* Are symbols protected against being used by unsigned modules? */
+static bool default_symbol_protected_status;
+
 /*
  * Cut off the warnings when there are too many. This typically occurs when
  * vmlinux is missing. ('make modules' without building vmlinux.)
@@ -225,6 +228,7 @@ struct symbol {
 	bool is_func;
 	bool is_gpl_only;	/* exported by EXPORT_SYMBOL_GPL */
 	bool used;		/* there exists a user of this symbol */
+	bool protected;		/* this symbol cannot be used by unsigned modules */
 	char name[];
 };
 
@@ -246,7 +250,8 @@ static struct symbol *alloc_symbol(const char *name)
 
 static uint8_t get_symbol_flags(const struct symbol *sym)
 {
-	return sym->is_gpl_only ? KSYM_FLAG_GPL_ONLY : 0;
+	return (sym->is_gpl_only ? KSYM_FLAG_GPL_ONLY : 0) |
+		(sym->protected ? KSYM_FLAG_PROTECTED : 0);
 }
 
 /* For the hash of exported symbols */
@@ -370,6 +375,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	s->namespace = xstrdup(namespace);
 	list_add_tail(&s->list, &mod->exported_symbols);
 	hash_add_symbol(s);
+	s->protected = default_symbol_protected_status;
 
 	return s;
 }
@@ -1785,8 +1791,10 @@ static void handle_white_list_exports(const char *white_list)
 	while ((name = strsep(&p, "\n"))) {
 		struct symbol *sym = find_symbol(name);
 
-		if (sym)
+		if (sym) {
 			sym->used = true;
+			sym->protected = false;
+		}
 	}
 
 	free(buf);
@@ -2294,6 +2302,7 @@ int main(int argc, char **argv)
 			break;
 		case 'u':
 			unused_exports_white_list = optarg;
+			default_symbol_protected_status = true;
 			break;
 		case 'W':
 			extra_warn = true;
-- 
2.51.0.740.g6adb054d12-goog


