Return-Path: <linux-arch+bounces-1574-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D2A83C0EE
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D67E289970
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBCC54BD1;
	Thu, 25 Jan 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQytFWvY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9351015
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182387; cv=none; b=G6ET4GWdjCwpSZ4aNKqPpMsgup3vJOYCTbrDYzfjLNmy6wun8HZJC6Gz0MbRo5lZbhf5sDmqML++DKsk0mBN36pArd0LO4dZ743jGYEOFFVsmJ0ETg0hCQ2cUfQrXY8ZO3C+MPElqQKdRV3w9kJDjeHXL8yM2pfL7HJGXI6eoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182387; c=relaxed/simple;
	bh=ywQcTtrCDMHJcI+QkXWX2nFyJwoVE8xehI2i+Z3nGsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pj9Itlu5CxH1gharipQTkAPDTqHeEhmn46C5QmS+4PCl8fR+VFILZzewM1OWY8Heq+Qy/H+/9+lpuUAmEDbykH5wk7+15SjADAwHJHXSXrJumjYod5ZbYQnEvG5IQDlhndjq2iKTB8BHCSZx2zwfjtam3/JU2jADqifIh5kMPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQytFWvY; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e5f548313so56765445e9.1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182383; x=1706787183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLl1bcVbRYtnIzLBeH2xJGti8beoepv/z/uSZlJPHo=;
        b=XQytFWvYz0bgtEjZlafmrVEl4JEGRW1LWuubtwVLI9igMlHJWWkC1YTeP1FRIfRIAx
         lucFeZl+VkbkXqEHqmtIfC2zdtOJabRsOMcySxVIGN+SWIgdiMmSzR1DV+BRVBaHM6aL
         OyKMYAceo2D2x3l7aaGlWtnDOebsXAvRPQaPrGs1Wo2QYQXt5fbBwSjlC92u+ufupZrE
         MT9Fcz1Svw4NkYbd22PQwyARrrASBQorKidt+F5+IpxYIA1yz3OJRAuHuhJMBU76Z3St
         s6YLKYzMys6U5ZrHCK7wLb/IgTwzfheETOCp3HI58mbn+MewguaWN5vOkZN9fZ7rKWM6
         quYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182383; x=1706787183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLl1bcVbRYtnIzLBeH2xJGti8beoepv/z/uSZlJPHo=;
        b=TYZXMTBSjfgPEt5afaGI7mJ/z0PfiMTTrlE5GsRDBKqSaIckxLVW99qsOzLIFRJirN
         7X+hkTYKRB7bDeh46kR6p3NqoImPJMsHZqXuMohr6dPUugN08wo2jezK+X0KoBiY6+S0
         Xq15PJIKdfIDmyCUPzfACWCPG0H2dPJO4OudvevJkH919yHSovcjJTSzaNLo5qo56GLy
         eh1VALAZSzFu1H5zxr1HlLC5RcPjCxPmYLsRo/8q2awVbiBWOy23jVAv4J6BaMgHpu8k
         8SVT8TCTzEoSLH6rBCa6WgUVTK3JNtLOvDU1DQa/kPpLiF3uYKrFll2FNKN7I4rLx8GN
         6E0w==
X-Gm-Message-State: AOJu0YzYYCKrWAeeWQ7Gbc6uMe92/nzVLcd26i/p9kw3+FmTCRUfSO2a
	ZqEo3Y9NKY6pVRLe0GA9lfvH3cd8Qbp1PaFpCJDBtLSGPXT79xoDu0iTEH9EBeQxgNxyzg==
X-Google-Smtp-Source: AGHT+IH+tHtY9FWpEc9qh8w6jVw/qndHIKRZi4Zi4jc1hJlvKLmXv0672PzSqvht8FRd715mL9u57xeg
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:4e0c:b0:40e:c720:f327 with SMTP id
 b12-20020a05600c4e0c00b0040ec720f327mr14276wmq.4.1706182383051; Thu, 25 Jan
 2024 03:33:03 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:30 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; i=ardb@kernel.org;
 h=from:subject; bh=DDaOUA3J+CFMHhm3e2XXAeDqtyhjkdr8A2J8hJRp8QM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT6wfmH+v9haLvWOZmMFrJXOT6Yz094E3RseZ9K47vm
 /XtUvaHjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRpg5Ghm0sH1ScTbRyzT9y
 LT5+VOxYRanmRG27Jp4J++av9Zuc7sLIsLeAS7395J5HEZYJvUVbV/Nxt13WjZNdJpJ7wl/vXc1 bLgA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-30-ardb+git@google.com>
Subject: [PATCH v2 11/17] modpost: Warn about calls from __pitext into other
 text sections
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Ensure that code that is marked as being able to safely run from a 1:1
mapping does not call into other code which might lack that property.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 scripts/mod/modpost.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 962d00df47ab..33b56d6b4e7b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -825,6 +825,7 @@ enum mismatch {
 	ANY_INIT_TO_ANY_EXIT,
 	ANY_EXIT_TO_ANY_INIT,
 	EXTABLE_TO_NON_TEXT,
+	PI_TEXT_TO_NON_PI_TEXT,
 };
 
 /**
@@ -887,6 +888,11 @@ static const struct sectioncheck sectioncheck[] = {
 	.bad_tosec = { ".altinstr_replacement", NULL },
 	.good_tosec = {ALL_TEXT_SECTIONS , NULL},
 	.mismatch = EXTABLE_TO_NON_TEXT,
+},
+{
+	.fromsec = { ALL_PI_TEXT_SECTIONS, NULL },
+	.bad_tosec = { ALL_NON_PI_TEXT_SECTIONS, NULL },
+	.mismatch = PI_TEXT_TO_NON_PI_TEXT,
 }
 };
 
-- 
2.43.0.429.g432eaa2c6b-goog


