Return-Path: <linux-arch+bounces-14051-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F484BD4ADA
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 18:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B65043500EC
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1E531D397;
	Mon, 13 Oct 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/vvyxhD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CF31C56E
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369999; cv=none; b=EzGZ9NfQMw/J+gt8Xv6iE4wtatbGUsMD/Q3YfojBIfEzAxTVklUMXL0RfT5kxycNTcjtWRPJrqWd2Majuip1eGt9gvwAjJks7ewwx32sTiYIv9Ln60xpgY5kG2M9xHmihvieJRCKhlApRwLXi/54WcDEbAlQgcUatryYKwH34/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369999; c=relaxed/simple;
	bh=lFWAd47m9WYWwYOwfmcdqTMftDRqoXt8LOsJmWA7WTg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kI04KNbthXK7HIsYRyJ7j1d0UBazmKlz+N+x3eyYAPfhKqFc2L92SdJWL+qQvooQQydfSuEpXLYjPhdf2mFY2rU2BaXV5Xczw3g5A5EJS4z9ZzE6AuxvwMYgoXMhrArfSTZyKwXFKbmvY6G+YwY2WfOpVZ1fDucEcsBHypwHq5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/vvyxhD; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-639f0a38c43so6274735a12.1
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760369994; x=1760974794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eG/97FcPJjq5NmEgRW4PArfa7yqTL2l/aJZCar+bosQ=;
        b=g/vvyxhDWnZku3wjYliqv0l8G9npqfzcF2S6oS2yQXUlDgFHAm+aQIhFRdE81DobVe
         82bridSCQqMFxhTArZ7ov59YaC6gs7uaBF7ZpbaHY92fGzYK+6ErQD2/MCO3/KLyxEcw
         tI9OAIjFSBtiRIDaKfCsHj41lE3N9ZMUJimdl/RSH+pfoP2WYZMFw41AuXhMQwF4jLyU
         NV+78TGIv7ZtlLhksz+nHFdnPuhVYy3BOcFLRqXBFxRGJoGV8NCGVbEwR6qK2+SUn2rn
         8/XVBVSXR9wDdcKu7MDHseR6at+mn9UtJOeoCts29dXPTtcJM/9WHuOZFIUPMcKLKqHD
         oaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369994; x=1760974794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eG/97FcPJjq5NmEgRW4PArfa7yqTL2l/aJZCar+bosQ=;
        b=YBkCqRWXEGnXOY635gtT2JHQ2SRxRe5DgeP7TS2zIN8mTCDcx7R7hlRHXk4QAqeyx4
         tM4kBPCUUOF7VLbUs9FeIdU44gIxHuqPhFElY5zdHV1RgPKe5oNDHtj4kN2eXZf/7vF9
         bBS7Avqq9xpUsCDQYBQ7u93PPx3uolPrkRM1CTPUz8MtH8gJ+86ZWug2H0QZiLXTuO6g
         lrJFTHjvwSlwEyEDMvvsg/h4Y6LSlhbh8egK8+1YKgWBdYxim7KFVmDG6s2VrpPig6Dg
         +KC9ctc9I5oFo7wR70W/W+YzKAtXS7qXlpbMI4rKt5A9KXIEfEBBVdqqnNowPcJZTHC9
         OM1w==
X-Forwarded-Encrypted: i=1; AJvYcCU4pnldF1NA5DwKb6RBSU/xzuVDzRljNYxDdQsUweqnVVkWBLTpPQFuOZdHNh2G9TuQy5BdxA8uKied@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5H8tAtzvfnsK5egz79gp5OhOtWnzNGkbheRap4CjNDAJectUh
	6KS9hlie87MCzJ0zL6uRM9qxuy5i4kkxIjl2IsrwhpSK+zpyokrJ7QzvotjwyZbMLiEI4ca9YYH
	AMkVEpnfGJw2ncG4rLg==
X-Google-Smtp-Source: AGHT+IHM78g7/9ceK5BgemHYhfAGssyyk28SSEXehcoYdtwkhhg6hYVEul09QjzOoJajkOTlNWCkbmyfjJw/coM=
X-Received: from edbm27.prod.google.com ([2002:a50:999b:0:b0:634:9afe:3dc1])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:cd43:0:b0:636:7b44:f793 with SMTP id 4fb4d7f45d1cf-639d5c76f3amr14705335a12.36.1760369993704;
 Mon, 13 Oct 2025 08:39:53 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:39:15 +0000
In-Reply-To: <20251013153918.2206045-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013153918.2206045-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013153918.2206045-8-sidnayyar@google.com>
Subject: [PATCH v2 07/10] linker: remove *_gpl sections from vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

These sections are not used anymore and can be removed from vmlinux and
modules.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/asm-generic/vmlinux.lds.h | 18 ++----------------
 scripts/module.lds.S              |  2 --
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 310e2de56211..6490b93d23b1 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -490,34 +490,20 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 									\
 	PRINTK_INDEX							\
 									\
-	/* Kernel symbol table: Normal symbols */			\
+	/* Kernel symbol table */					\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
 		KEEP(*(SORT(___ksymtab+*)))				\
 		__stop___ksymtab = .;					\
 	}								\
 									\
-	/* Kernel symbol table: GPL-only symbols */			\
-	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
-		__start___ksymtab_gpl = .;				\
-		KEEP(*(SORT(___ksymtab_gpl+*)))				\
-		__stop___ksymtab_gpl = .;				\
-	}								\
-									\
-	/* Kernel symbol table: Normal symbols */			\
+	/* Kernel symbol CRC table */					\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
 		__start___kcrctab = .;					\
 		KEEP(*(SORT(___kcrctab+*)))				\
 		__stop___kcrctab = .;					\
 	}								\
 									\
-	/* Kernel symbol table: GPL-only symbols */			\
-	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
-		__start___kcrctab_gpl = .;				\
-		KEEP(*(SORT(___kcrctab_gpl+*)))				\
-		__stop___kcrctab_gpl = .;				\
-	}								\
-									\
 	/* Kernel symbol flags table */					\
 	__kflagstab       : AT(ADDR(__kflagstab) - LOAD_OFFSET) {	\
 		__start___kflagstab = .;				\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 9a8a3b6d1569..1841a43d8771 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -20,9 +20,7 @@ SECTIONS {
 	}
 
 	__ksymtab		0 : ALIGN(8) { *(SORT(___ksymtab+*)) }
-	__ksymtab_gpl		0 : ALIGN(8) { *(SORT(___ksymtab_gpl+*)) }
 	__kcrctab		0 : ALIGN(4) { *(SORT(___kcrctab+*)) }
-	__kcrctab_gpl		0 : ALIGN(4) { *(SORT(___kcrctab_gpl+*)) }
 	__kflagstab		0 : ALIGN(1) { *(SORT(___kflagstab+*)) }
 
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
-- 
2.51.0.740.g6adb054d12-goog


