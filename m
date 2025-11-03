Return-Path: <linux-arch+bounces-14482-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4E0C2D23E
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 17:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981EE426646
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D2319877;
	Mon,  3 Nov 2025 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VgxSYz1+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915731815E
	for <linux-arch@vger.kernel.org>; Mon,  3 Nov 2025 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186809; cv=none; b=kjOO+KLSUGMGHZOYUham4T1Qh+sPYb+uOI+ZtRi49Fv5QXwWKPq0Ffo4OAG89C4QTtE1IFOruWFm0um272Ia5wflaRuqdguQEqKGesU8cDRnhi01AYnpOsrIOuEthPDQZjcls8ijFN3P8su1JZ8yi/uO6XyTfRIuxDduU8cjrqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186809; c=relaxed/simple;
	bh=pkHX++p8KzINn4g+tNG5oYVFuXXq/LyOGK2x2a5Q39w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WNcY97VjoirBJ4gm8b7QCWFel7ayXgAGB496tQmVvxLKdFRxvb02v7+2iN/NNakpb1gn9TNtnFz8KY09Nq5g//yOe3w+Y98TBeyUPAvIF6Vql6u8iajQNn2hKHEPIt4MSWAkjsNRNvN0+Pzw38TgDO16ZFM+nDejED4vcsMqboA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VgxSYz1+; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429c95fdba8so1264529f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 03 Nov 2025 08:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186804; x=1762791604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKpzC7OwKr3KFY5COtWMHui39YTNk2I7jCnxEbVs+Mg=;
        b=VgxSYz1+TQ68Qc9k+4Zdm6LZd3LumOrbJybHGNYBI6SkLuy+sI6c0lh2snSdMN1dgf
         rN1iPIKCkPXrjyHwuBQPnNnYaUg5hsa1wf0Gai+OH4ZxKwXE9LS+TIaFqGmmxIyehvBt
         1o9wA5PPPt2HmH+U82DYmrv4CSOHAZl+ir5JhUZglRmRmWjTDGLWsJmZ2LWlQFxXrxC9
         6pkl5DYQKXwDkgxeB0dI7/RN58lyq1Iy9N8p5Cz+xvnXeJSiDQvfzRleiMosD6bLQOCU
         3jiHOMIiMxKqirQCdnIksZdQFNxD0zpxRk3CGugflFVZYZtZ5bkptE2fIuuByxLlFkNy
         urng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186804; x=1762791604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKpzC7OwKr3KFY5COtWMHui39YTNk2I7jCnxEbVs+Mg=;
        b=vCHtjWpiOPlVut9JhqwgwVMDDazv4BkXlDlYf+IrJHITcGCCStzK1SP6W87HGZmBZ2
         nGY2pK0+4YgyWURzMSt15PjWPoWHpsox7FEQ8fhHbTyeC0c+/8qVsORO9aMbPqgD8VeS
         BwTGtI8uo75rkZrSp0qbwINqGkD4AcxgR1ldTW911frXBtdaBlKbYT79H1p1Vt4x/YtX
         2WKOb9z6Vv/RXhrUqjHUmcABmyDvMCV2XMRBLZkXTr+LwS0i2SswznpfvetZ8xyU/UDN
         7MF6jzu5wtwI30PgRe0xsnbtYC258/d6LuWjEQv+e5o/F76b3asW5BPMpepAK7BZ7POV
         IuRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO+q7sTzzcQF6YAsLZUeHCrwSj5eQOKEnbtHyXt8KiD/MLDCJL+jePudpwLmYLKPoroy212cyikY31@vger.kernel.org
X-Gm-Message-State: AOJu0YzId58wBFxVC6ri6rclSc44ismbpBMbJ1LZ+QJsB7HaVgWXUHjl
	I8Jq7+I3DY4mey4KfjZeeP44ncw+bwyfR6Nna6PjDDhRSm2I9smVbsMAk1JnnDUPbiBmKjNS53N
	2N0+f6v67reyH1r9egA==
X-Google-Smtp-Source: AGHT+IGYgTuLSihsPJ88Spd9dISIsCQuf62e7EG7IJZ70IGjE1Hy68HXjMiE6YNWqCxl9BmEEpOCUF8ubsRZqv0=
X-Received: from wrmr5.prod.google.com ([2002:adf:e685:0:b0:3f9:9fbe:f838])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2281:b0:429:d2d2:5032 with SMTP id ffacd0b85a97d-429d2d2519emr3619316f8f.3.1762186804331;
 Mon, 03 Nov 2025 08:20:04 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:48 +0000
In-Reply-To: <20251103161954.1351784-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103161954.1351784-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-3-sidnayyar@google.com>
Subject: [PATCH v3 2/8] linker: add kflagstab section to vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

This section will contain read-only kernel symbol flag values in the
form of a 8-bit bitset.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/asm-generic/vmlinux.lds.h | 7 +++++++
 scripts/module.lds.S              | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ae2d2359b79e..310e2de56211 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -518,6 +518,13 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 		__stop___kcrctab_gpl = .;				\
 	}								\
 									\
+	/* Kernel symbol flags table */					\
+	__kflagstab       : AT(ADDR(__kflagstab) - LOAD_OFFSET) {	\
+		__start___kflagstab = .;				\
+		KEEP(*(SORT(___kflagstab+*)))				\
+		__stop___kflagstab = .;					\
+	}								\
+									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		*(__ksymtab_strings)					\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index ee79c41059f3..9a8a3b6d1569 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -23,6 +23,7 @@ SECTIONS {
 	__ksymtab_gpl		0 : ALIGN(8) { *(SORT(___ksymtab_gpl+*)) }
 	__kcrctab		0 : ALIGN(4) { *(SORT(___kcrctab+*)) }
 	__kcrctab_gpl		0 : ALIGN(4) { *(SORT(___kcrctab_gpl+*)) }
+	__kflagstab		0 : ALIGN(1) { *(SORT(___kflagstab+*)) }
 
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
-- 
2.51.1.930.gacf6e81ea2-goog


