Return-Path: <linux-arch+bounces-3329-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA47891621
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 10:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220831F21DC6
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56C652F82;
	Fri, 29 Mar 2024 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dlk4AmJd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9A4F5FC
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704858; cv=none; b=goNZWT2J28KvaNyqzy3VtJeZ6Q+tPyDOeXCgZLzS8+K6MFVL5YJdlOY36xpeJQZzaerwyMOo83t8fyvHP5LsKUCbMFCsdYr/6UtljbjN8EIMyvsruEOa7V72b2xGgXlBL/jgVpPkL58NoZhGGF8I0Fa05Pl3dRiDo8goSetqPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704858; c=relaxed/simple;
	bh=ne1nIh0Qwrvg61AZAr4OTz8Z0LGxASlvMGm2cM6SR1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U8ZREv4lYQsD66qN5vreBcLIUwQyf5q5IPvMOMC345XFnNeZz2TXS6rcpD3G12zOuiL7gwtVDU5+fDOpTY84QQ8rzmXot2dAUqgaGon7CeBVEAs4wE2GV+xfhd0ATVSfeoQ/cV1uCTEX+XIrRkiRkxuDraeV+PuvrG/cjwB9o/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dlk4AmJd; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso9405235e9.1
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 02:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711704854; x=1712309654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=24D5emD5FgWK1X1kR0N5gec4wW0lY0v4XxqAgq53xkE=;
        b=Dlk4AmJdYHMZwZboC4rO5mMhtdndQIzNjUynYqSw3qMVV3d1PLIvcP9cxXDWGkDXaO
         dpo8wsza87cWt270/bZYj7vxmUUZNM2fhP/IxJENaV5SRhPMjcGsuH4zaWRDzG50qe9A
         fjk1cUW1XL6FmG/7E8J+tUbnyC6DFS7D11XBQvG2deoo5Qjd13R8OEJ1vrFVg5DLLmT0
         WZGUVViY0cD7NQiCuYqLaC0HA7y50yt+PrdSpGD+TYm31SJqcRyOAGHYW6dPCscaaWt2
         d/tPoavHG6vSUhWfQjlZ/wTk72ii+asGCdLl0UfCUwxXlI9EdRxzUP+yDA58wiXSnTqm
         c6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704854; x=1712309654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24D5emD5FgWK1X1kR0N5gec4wW0lY0v4XxqAgq53xkE=;
        b=P+5LERW/vJGa2b8O0bNKrgNSDLiV33ohICqfLp6pOZEBYQqc6wasiqf2BOAeUcck6G
         Fa944y+4tJFl7nmzjoUrMNivCyYggbA/F98nXtPkXOnxJLlUK5a8sI0S8ShQoQ+7A5Ro
         pmhYqJu5OHMiQfkr/SCFu63q3cb0n8h2xZCsXb8Pbohf2VP7888QKrybrRyyGSPEYtPD
         vY0q75Pa6nxFpPo/cS0o/Tsg5rBfKjvpft/DnIG23drOa59VEmQNxqz2RuIxc3mU0yF7
         2Jz06HFXbizO7sE8vKI+mrH4lgKpTE9FU4s0naz6Jbx+DYdvAxnmVh73HLW7L36asa2g
         Q2wA==
X-Forwarded-Encrypted: i=1; AJvYcCUnWeLqObRr50Xi2teOZoLR+MuRF+LgGYOiGf9yxh1whvWgk0ywtXEFVhUCkGqiBD9JI78fGp7ARdd8OhuVF8v9Hhj2LGo0DHukiA==
X-Gm-Message-State: AOJu0YwrvtxMrxniUPUCWi+QLYqiyIz27IRbzGx5NhA5GhxgaUSI/UD+
	o4tAg8jQnEe46+TQkrapQWuY4PPZXSeKM/hKjgT7SitLFcZhpC/rlcigTJYmk3FIg8RlfA==
X-Google-Smtp-Source: AGHT+IERC/xlx8lH+yq6bq8yyIt9cEBvXeqlbzaAJ1b5JFraFrYGAoAaIl2LTkJk5C+U336G9ed99TBB
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:5114:b0:413:f62a:aaf8 with SMTP id
 o20-20020a05600c511400b00413f62aaaf8mr58714wms.4.1711704854514; Fri, 29 Mar
 2024 02:34:14 -0700 (PDT)
Date: Fri, 29 Mar 2024 10:33:59 +0100
In-Reply-To: <20240329093356.276289-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329093356.276289-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=ardb@kernel.org;
 h=from:subject; bh=ORZChgCpQukYWaId1hq+FAluQSgY7FsL4Hz5iVd1jE8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY2tm51pL9M1t7Sty6RbsvftP5R05JPTl/bSvhflPYdjj
 uy5XCjfUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZSc4CRYQJjuz+PZ9rFEKu2
 +t2GcpNi7xqs4OGL4PA34HglprvnEsM/hY23dhiJF2lWfq2SYn16s9jzF3vsjmqBE99mHezX/3m BGwA=
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329093356.276289-7-ardb+git@google.com>
Subject: [PATCH 2/3] vmlinux: Avoid weak reference to notes section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Weak references are references that are permitted to remain unsatisfied
in the final link. This means they cannot be implemented using place
relative relocations, resulting in GOT entries when using position
independent code generation.

The notes section should always exist, so the weak annotations can be
omitted.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 kernel/ksysfs.c | 4 ++--
 lib/buildid.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 495b69a71a5d..07fb5987b42b 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -228,8 +228,8 @@ KERNEL_ATTR_RW(rcu_normal);
 /*
  * Make /sys/kernel/notes give the raw contents of our kernel .notes section.
  */
-extern const void __start_notes __weak;
-extern const void __stop_notes __weak;
+extern const void __start_notes;
+extern const void __stop_notes;
 #define	notes_size (&__stop_notes - &__start_notes)
 
 static ssize_t notes_read(struct file *filp, struct kobject *kobj,
diff --git a/lib/buildid.c b/lib/buildid.c
index 898301b49eb6..7954dd92e36c 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -182,8 +182,8 @@ unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
  */
 void __init init_vmlinux_build_id(void)
 {
-	extern const void __start_notes __weak;
-	extern const void __stop_notes __weak;
+	extern const void __start_notes;
+	extern const void __stop_notes;
 	unsigned int size = &__stop_notes - &__start_notes;
 
 	build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
-- 
2.44.0.478.gd926399ef9-goog


