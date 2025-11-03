Return-Path: <linux-arch+bounces-14486-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D386C2D176
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 17:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49D51895CE2
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EE431C56A;
	Mon,  3 Nov 2025 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEd2Vqwy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3843191D2
	for <linux-arch@vger.kernel.org>; Mon,  3 Nov 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186813; cv=none; b=eZbQ5W00ECgNOZys6oGQeh6JnXBfTOrNhqc9xD09tPlWFJEbocDAmGsqCzbc0yeWOU9BeA4a3o5qVZWUl5n9E8t7F777fi6jsnXSgPr1SKaZ1J/MGvzNSSQJiwKC/74EZt2FpB0SApjW3DEUjarkUPRiZAi1As5m7nvTAqdkQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186813; c=relaxed/simple;
	bh=90zgfRi03LUPC/zqKQIwgs11pM+miVnc5O/8fUC1p4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IyPMlEp4+Lx12kfmnInZXr/9CU+DpS3KVKwkHzjeZiVMhSn29TjIogxijZSt2FjqOzcVVgR3Ewe1R/ZM8V2SVZDVZv8hAeQNLsnNj57A3lJiUe8rqe10t4lR8TyyvLyY0Nhb1bgnCndTDpCc7bU0zz14vja82xlzK0QXpveW3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEd2Vqwy; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429c61b0ef7so1073759f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 03 Nov 2025 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186809; x=1762791609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=olCu7FTS9PcLYXD/iow1F/tBLcCLSX9gN8Zi1GrdvXs=;
        b=OEd2VqwyKjLVxi3c+TEVNkTSh9+vhMjXybRGbzI7I0glzxpfS8SBRHnBSi6Xa6U91+
         /qPNXCXg/F90N5a8KV+mn5fCvuHy1Tm3PsBVKyF2LfYza575371qrIOewx4cYpvzZdX9
         uvBlm3xC6KJmLgYIqv1kOp7c0NOH4Rp7vt1NrLyATC8jwYzDZUiwYWgpOCw8VxQxydXp
         miykrXrrqbqENIdKi5HVPNbhJews4HqvlQjTOOLG0te+VfcbuokYaozF6F0Q85UOQLmg
         RCnsTFkrFS3HVWLU+NAV66M0qqX+tqWMfq2mFAYfhRjvBj8EikKCYVULGRH4UtOa0mYi
         UeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186809; x=1762791609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olCu7FTS9PcLYXD/iow1F/tBLcCLSX9gN8Zi1GrdvXs=;
        b=ppwOdJZVrOUwP/Pkmr1pdAyr5AoLlhLRADWNbdqdwyBTxySEE+pMmQixQto6TIbhjX
         NIWjaJ560HtDiTLoHouCurkORE9Sp1VaTG0QBxNiT42Egp3AH0cMuIKE7VPTKxD+FYN3
         ojmCVOVtEY8dX5fVWkqF7JEacRysJwGU1+/0++vS+Vw2JAOpgRqrlYQZ+MyI4DBUWcxb
         UOkSiBoQrhvoy+VXnIwLaQlIVelWG2lFXgVLRsnal8Hzt2aKBmea5H98iKtdKSBg6USb
         /5HQNtznMI7In9t8m1l8Oaplf7axW7qC9v9NGoeMCpPJL8H+vd0swOxhxph/7fdIsFvU
         J49A==
X-Forwarded-Encrypted: i=1; AJvYcCXMIimHbVZhRvumcvBfPjb+VGTE7POp2IwRZWYpbbo5HcSTUqzgwxn3qrBDHV8gXzDCS8OHpJ4W0K4l@vger.kernel.org
X-Gm-Message-State: AOJu0YxANcsuht9Ghy8xwhVuAKV6vI1jyzSubXED7Alygkg254HdKevv
	DCsxRq1d20QvXFMjRqxipAOVdx8Zuyih7w4ygXUcDnwxuFJsXEL7jV+/My38sUgpdVCp/VTxz4V
	z8dyVjYO6ftjyK30R4A==
X-Google-Smtp-Source: AGHT+IE9IPcvmbIvQwAMqkVKiUmE8DZiY829fkrxxcHOeyR7WshNvHPAvPnZKpl9Eu6FnQkKKw9nU3nVrpj/Nr0=
X-Received: from wmcu9.prod.google.com ([2002:a7b:c049:0:b0:477:f0c:b354])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:25c2:b0:429:b751:7916 with SMTP id ffacd0b85a97d-429bd6ad961mr11484402f8f.45.1762186809292;
 Mon, 03 Nov 2025 08:20:09 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:53 +0000
In-Reply-To: <20251103161954.1351784-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103161954.1351784-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-8-sidnayyar@google.com>
Subject: [PATCH v3 7/8] linker: remove *_gpl sections from vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
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
2.51.1.930.gacf6e81ea2-goog


