Return-Path: <linux-arch+bounces-1412-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A330E835DC3
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 10:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62CB1C24289
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 09:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631939AEF;
	Mon, 22 Jan 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zxLgZszY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8658D39AD7
	for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914769; cv=none; b=s4RwK0toJa+s/ks6GqMhKuS6Z8YcRC5dnJgXIWjT/V2cXllIZHuf7S2uLHzcJGz0olJyJXiWGw1Ggle5ccPb17UbQIciFb0hwkiFUyWfJ90TMnKKaW0lZRKFjjtfMaApiyQIORudwidDE/H2+KzuMsoBbAkp3DIk1WjaQ3vb6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914769; c=relaxed/simple;
	bh=FI1bdkhRdpG4w1m18XkG1rAosi5jGY3arzDb2dniOFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T2ROFFS7cAKpKHP5XrrF9CJ5YQQAk7ujf1OlbCaOrEB38t6QSXJilUR8pORLQHvl2zVZNzzmDwX18Lc2XRMlTsHGFQSUPOAPt44+MTSBKbGahPsnpGlnAMr0ybMbzI/QmwTSxEfNx3+/fSr3U0PqsXwHCqrs/oI6eupMcNB3Sg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zxLgZszY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ffc7ce3343so14576117b3.1
        for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2024 01:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705914767; x=1706519567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+ATsTLfC/nfRiaNDc88cmvgZOlK0W3C+DyqDLNAS68=;
        b=zxLgZszY5qCFT9j2KKQ7FBZEXkKspfEl7tSmlTGlFQb2wI9I8kZ37QgSy3J92sjpsQ
         2VKXpbtnJR9WipyM2RiOrfMjQ0TzYPZzEmynjngi22XvKQXGGEYWRr/e5mCJOLd4LfR6
         U6tGVZYer3km8r1ZasNb1HOMcirsomwit2HUP3SOxJN4B7K0smGzhcDUdWd9FDFTAKdf
         UuiAtQKkZYqCXnqT6c0d5UvFhi1p8JDc1C1gtkV0oXHTwlFtMcZzKdw7BhjUqpFI64xm
         K5n0PKee0zOoc7DVKhnYe3wrmp7H09jj0D5hujaOooKUb6a53MHly0bIa4KrKkD4Rurr
         SpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705914767; x=1706519567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+ATsTLfC/nfRiaNDc88cmvgZOlK0W3C+DyqDLNAS68=;
        b=TgkK6S9Cy9HBtMlsBdwXPVyjG0pyKV3enjeNtqHxvfheXCFtq9p/e+F1NbkdTX3RCJ
         Ddlbl/gwsWHmbMX2okMRWUHc7ODb5G2HDrOKnVDRxQlkdRc0OZ52AWa0I1xKCsT6Uop+
         nJ6VvWY8xoaliADIrWZ6hS1E63VpvymxfSe2HTuKPLEXlk6h6q5dpJDqiGxdSrIOq9+h
         lEJgnn54qf0M7h7gka2eSukvpWrgkhYYmISCuXZJQDtUeBy9gc4yZub16wcMeTDlSo8X
         VsPFQs7+Vk069dfzseL0FdFUZIUXyBZWVKPNzCC1c06nCmGtIU6/vbFcNKaDm4vRvAuU
         +x8w==
X-Gm-Message-State: AOJu0YyGFQM06rePltVLHcc1byjNNTvqS1JiqZjATkEG/h5sdppfl8Sd
	sSkvaSpdmbqrkbCAeGR6BdhZ4ZBk1iQNWahAXFdlSipV1WFuCvMa3MD/qvbSbLBPW49tyA==
X-Google-Smtp-Source: AGHT+IHj5jP1/bPHn1fKlYTBs3hflLPsW502amseDci9rhfzPpL0hjRqnXR0+7HXx4D0UcvjnLYzNOYw
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:5753:0:b0:5fb:7e5b:b877 with SMTP id
 l80-20020a815753000000b005fb7e5bb877mr1288192ywb.7.1705914767726; Mon, 22 Jan
 2024 01:12:47 -0800 (PST)
Date: Mon, 22 Jan 2024 10:08:54 +0100
In-Reply-To: <20240122090851.851120-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122090851.851120-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=ardb@kernel.org;
 h=from:subject; bh=A4glY9lFGh3ZCS2BolwbxkiHAY08LMb32QJUAkFZOD4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWdwbIambt6UbumlW3o3fUnes5Ggxs7A9m5dyfPXsn/d
 JVi3k3njlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjAR7l2MDFurHzxqXGW4W4t3
 ia3/+5v/H5kWi8SUzC64/r7UO4X93XqGX8w7t6fEqAq8Lsi/1jt580dBlTI521k3p5SKLZda6x5 VwAcA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122090851.851120-9-ardb+git@google.com>
Subject: [RFC PATCH 2/5] vmlinux: Avoid weak reference to notes section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	llvm@lists.linux.dev
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
index 1d4bc493b2f4..347beb763c59 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -226,8 +226,8 @@ KERNEL_ATTR_RW(rcu_normal);
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
index e3a7acdeef0e..15109fe191ae 100644
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
2.43.0.429.g432eaa2c6b-goog


