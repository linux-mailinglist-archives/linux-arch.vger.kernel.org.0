Return-Path: <linux-arch+bounces-3703-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4308A5796
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1656B28A760
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E63824AA;
	Mon, 15 Apr 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2hTyWwGO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596A7FBBE
	for <linux-arch@vger.kernel.org>; Mon, 15 Apr 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198056; cv=none; b=ba/dtImOj4w8lCbYy9Rn0XKbYDNS3xBsSYFnre4dQl2AQi2h3eqGLqY6XcNjcao8wA3Xt4GOIb1GiS8E4PClPxRD897WTy3VX5QhJe0f3PqoLqEfuhGAiJhCuaE0yIOkF+BCkN1EtZPeLW8VfeHUfGnC3AB2svmjIYfvLExSUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198056; c=relaxed/simple;
	bh=DkpORLakWw5z143JLN76w0dBh5hI4i2x8TQpiySZiJU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g6WZyHW5D1Sxg/nJwMlNtptE8huUHuSidEVUojJsO8Jp0NZHDLNl9ET+MZgKZwNDdGN5egl9guqTldfIjfylA5d81SrkpR7DNOTqa5S7yK6brPqmhmIJQbbpa9Y61rGHROjTOoolSP4srO4PLvLKC7S27EsTiQ6gpM/ALalDIIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2hTyWwGO; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-343bb240f70so2323679f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 15 Apr 2024 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713198053; x=1713802853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nirUBk2IWA4nfF0nBoVFV5ytdr6rujdVL1Z+GvYP3xQ=;
        b=2hTyWwGOiijyzdkgJKWjBYRBN0juykEX/pdXT82Hk9M9ehDh2lmbNVxm0S2eLeXUIc
         0+qfeZtBQf7SBll9UoDuyRVUUuPc3pFwGr/Ucds+dH2oT51UZ4MFGot+K5Sm1iq1mWon
         AzW92YaJKuc2Nv6VxEvQlZNRSQEyFc13HslSF0urNT2B/hBPMFLJvx4TD1cGyAMzzGFm
         HjMcB9hPy5mVyzi5jWc6YSJ+OobsWx3VXjc/Ett7YQAuoKkK6HfOHPDAXvLrhxT8NoWp
         PDzkJU0cqCvbbWRFckyzJD7J6fh5+soINdykIWTEevOUZMTFxJi73l7okeddtYN488E8
         lJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198053; x=1713802853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nirUBk2IWA4nfF0nBoVFV5ytdr6rujdVL1Z+GvYP3xQ=;
        b=gHaNAVgp1ok/MUCRX0WU6zrcfcjlL2y0cPDDUarlCzxHrLZk4zeyfsu+ouMdmzbkFQ
         2+yi/JfprD6ld3jF9F7t0/FNn6wxpFPaSiuTcu+yICqJVzkbP7sS6CsvYhiyvBo+QT6u
         iAfM4HBNhLRMqCx8XRCr3B3rZZMwp3k6AyBbU5V7DrItMhY1g1CIqQYSr0qEfNyWCtNx
         gV+kDVHfS7rt4Nvjf00wtnQOCm66aUfua1+KNyl5By+9La4RHvjB9F5rxXjTVF9E9BSp
         LMNKdSVcZs4ids82tdeDd2QZS19wXy0RDSa5KZtXQ3vseZ4N8FH0c4OMo5ozY41toDcq
         iMQg==
X-Forwarded-Encrypted: i=1; AJvYcCWuWNXlIJFKQFAG+w8SFbRX6ACdqZiCXq96j5FqdMholAPgKd2hApEYkJSUklvInAMKHxKY3BhtbjWbEhk4TVMgTODNT0KARgXZ2w==
X-Gm-Message-State: AOJu0YzgdeS09IcLZeHw3GxEenhl78dzFMCmK92X4KOfD3/7jtT5oY+M
	pET4vp+IfrLuoc+m/WRnTgJ/HlRp7zdZVN+QgfpUnVB2YcuCXbRGvsnT967N3ETlEhnWuA==
X-Google-Smtp-Source: AGHT+IEG7QWukhC29WPVFqvJ0sHYtNkZBwbl+gzNLcWFTahlxsENo50bU+lqtlSx0pNqfKHmhlU8U2H/
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:688f:0:b0:343:8a84:475b with SMTP id
 h15-20020a5d688f000000b003438a84475bmr224wru.6.1713198053081; Mon, 15 Apr
 2024 09:20:53 -0700 (PDT)
Date: Mon, 15 Apr 2024 18:20:44 +0200
In-Reply-To: <20240415162041.2491523-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415162041.2491523-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=ardb@kernel.org;
 h=from:subject; bh=iEnd1kipFuUW1SJUvbH5tb3oJXutwpN4deu2O40wcts=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU02+PbdQ+w3umb8jUpXzD++6X70lFcO50+yRerp3Fu1w
 u7gZeuEjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRgwsY/sp9Lo7xVcwX3drs
 /0us5puVtGicWcs2px2BT80/9DcujWVk6BX4vJ7rUV3f3I1vZhU11U9/F3z0+kGJP+zGzA9Xyng vZgcA
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415162041.2491523-7-ardb+git@google.com>
Subject: [PATCH v4 2/3] vmlinux: Avoid weak reference to notes section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Weak references are references that are permitted to remain unsatisfied
in the final link. This means they cannot be implemented using place
relative relocations, resulting in GOT entries when using position
independent code generation.

The notes section should always exist, so the weak annotations can be
omitted.

Acked-by: Arnd Bergmann <arnd@arndb.de>
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
2.44.0.683.g7961c838ac-goog


