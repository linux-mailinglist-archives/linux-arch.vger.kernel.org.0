Return-Path: <linux-arch+bounces-14046-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6298CBD4DAC
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 18:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F287567F20
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC162311C0C;
	Mon, 13 Oct 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpKq9IXz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A68C311958
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369992; cv=none; b=hCPtTj0yZvvqu9ptuzuPyFUdSFRVJIoa94V5ONvS5rEE02muhtV7+0ZUDa0cxTpdHtqaml62a5gQw35HHJmtEwpazxzotuB0zbb9rYo5uMRhaSVQINWBN/R6WrKmiqtJfrKNIj+NK8ND4sQBGyHbCiGNUXgBcbrTytbzTvODbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369992; c=relaxed/simple;
	bh=Yif0tpvEVYMz/HHDWBkZZeP1JAtd0/nIT+vjnx/3i0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jBnY6RL2CMDCmvlsckTRNToizednIgVIxhQXsPU7/DQUJs8FJhhBXGtn1env42eCQGvGWx3IROiL4X0Bsa87nUTIwgJ06rYngBss9StU/khm2TOs+EO/NLRXm2LEUZOruqkLGK87ajcCxcKzC5EyNQWo/tI4YAmJGEYN1TqIkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpKq9IXz; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b3c72638b5dso642638866b.3
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760369989; x=1760974789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IjM8d244naCxzVfKtaINlZql2XGUpipFpM5gsitgK2A=;
        b=JpKq9IXzk38cNBC/fA7lYEgDxwtPgLsT0lLDax9AVeIl5xbvB7S1zLd6x3KMWwRDGe
         IVvbSZPchTG9ZvltWJCynYwRAIMbsXSnjy/+daHa+R1et3JyCm9TsB6B81SP7KgDo0dD
         99HYeBA5Pm7jO3m4atQx1DraZlNXzOdaAqwTkmqw2QlBnCaiJNBM4BxYat2O+29Yt4LR
         4xk08xBUksMPlctojrnE1FxVah7nM/VT3n9AaEbLfb9xgm78aHm3zoGiK85+PcU3zKJn
         6N5Ckr3K3wl5jUszdD5dwia3ZQuV/ZEfJ6OIeqW4qtlRNLe9qm3GnMpA04MNZPCCZOJK
         /P+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369989; x=1760974789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjM8d244naCxzVfKtaINlZql2XGUpipFpM5gsitgK2A=;
        b=u6FqpNVnpdXg0s5624Mm8Jjn8pki6Fz6qfWZZro1V6k6E01DINnwU7FMErLZqO/JK0
         GTmMVuQq2uyseK6p4a+PkLgFBc/wPr1z7kD5p41ntu2GT6tiNuSL4GYEn434oCfSMDmC
         gK5JtSlWxQ0IAxEySPnoQIXPsygKFhxQQGJO+AR9zRyJM9mS/qDVH1Bv2Z910TlstSpu
         w96/LTaTGIsmb2hw8ndmpQcX8RmeWtgKEM5cwZ9lHr4FkFeccFwcOVGS9kWqsRFQuodK
         /fiRcfw9LsaO4xFAC7CFkV/IMjBJxHMMjxdOCjcYui3GSnDAUYobBkFvw5WM7f0wQiSR
         3n9w==
X-Forwarded-Encrypted: i=1; AJvYcCXqc7EUmLQdMsW607RUZ2/laEnKgseStcAiE+dsbxuGzg/zK/ietHT8cHcJtqDPp2lT65KxbaY3eG+M@vger.kernel.org
X-Gm-Message-State: AOJu0YxwU9DhPLoNlxZCqbPKCDj/PfYuZezIeA9jJ8mAQlOrcGD7E3UZ
	zt+DPcVT6mAtJq9o5JRf8q25y6MRuDYbqULY29BjD/lu7BeBuIe8OTITBwJJgPuyYs1pODXrrDo
	CbI9R1QHKJ6xcBMhlKg==
X-Google-Smtp-Source: AGHT+IGiQtyP/1ptL42LsvljMNhOg+y+bM7AeQigA9x43JIE9KmSCt7yX9mzDsBi3XU7e8y5ilB7RsBmmAFdHxQ=
X-Received: from ejrp11.prod.google.com ([2002:a17:906:6a8b:b0:b2b:e1ea:68ee])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e8c:b0:b46:cc3b:65fd with SMTP id a640c23a62f3a-b50aa99e1ddmr2177629766b.29.1760369988766;
 Mon, 13 Oct 2025 08:39:48 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:39:10 +0000
In-Reply-To: <20251013153918.2206045-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013153918.2206045-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013153918.2206045-3-sidnayyar@google.com>
Subject: [PATCH v2 02/10] linker: add kflagstab section to vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com
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
2.51.0.740.g6adb054d12-goog


