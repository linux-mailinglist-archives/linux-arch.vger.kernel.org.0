Return-Path: <linux-arch+bounces-14045-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B74BD4A86
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 18:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 299EA350003
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5C5311976;
	Mon, 13 Oct 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjgXCWRq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318223115BE
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369991; cv=none; b=mEh2jBToNnU+SZKJ0amfvUYGYUewm8DkZfgc5IMEozLAfoWWqdpZnzPfOYAYPIfcSJlZWgnqlGmuBcsap60GKtGDGPQkjOVbyRbxPHtLMUOq6L8x34zewL1854rb5+MVfrxD/QCTDQgYasJwcLGeRfGcZ/wF0EfIqBaszlYIfwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369991; c=relaxed/simple;
	bh=mUdyWiaMtVvum5RTj9ic5YSdMHipXTsRvWK4ObexLVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RvPwlcYm0WnLM7+htWDzX+EiTB9lzkFGnQLhWXwJTyynyxhpIuQQL6AWQGarOe6MBe81Gif5gcvcHf/oXE+/OEePXKw5BKVQC9ayC2A4ldUSFzMt+J5j3CqXctUczLJCiVRFpl1lM0QNliCZxuEQfaOYRItwAO3oANbRGG8cGB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjgXCWRq; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ee1365964cso4359875f8f.2
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 08:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760369987; x=1760974787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8l5v6qiimGPtv9u5QonCWzpEhlvJ98SCHb4SgKDHVc=;
        b=KjgXCWRqzLtxqtRGkyFp1OT/ckSaASJ6feu6CqLLa/He/M07ri4tWczTjjwiLGB/oL
         fBxPi/o4LQGx/QIoE78VYtEJfqMze/+zX9ga8bu2VUSWCUtQ1VjNQKlGwy4UbI1zkYZ4
         HoIPfLQJfZZ78yjiLNTCBwZfLr28L3+buKbY8vl0ZS8JlmGLD3pXDeMBof8TO2sZWyze
         JrUYR1C+CknKMyFkiVWM+yXST235jYdvNZpbclvhHgQZM5J0bT05/nWqAv8DdaQOt84U
         5iOw4ZAYGXFh8SyAR6orNaqVxy8fRA+tvc51ybgY2Ic1+/zO1o429sdhGwwq6y6+V9c3
         IUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369987; x=1760974787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8l5v6qiimGPtv9u5QonCWzpEhlvJ98SCHb4SgKDHVc=;
        b=odfzZhzcfBfEXSSlm4hdLYEpqcSThL7M/6hRSHmTkQpbFnd9yWnLq+DDUdCPklymVY
         /tol+sIbc85l1p3Iwwv6PDn3KjWPKRzweYVCwWawc0gkMNfrvqiRUzEchEkvSaMp81ac
         Vts8HNeD85TBzXHXuDLrj9Pl8al/uCdaX7FvAOnD9oBLN7BE6UYEqdegLiM23RRzxxup
         ZE6b1vo7cvpzOlEBIpwcybHliSqqYGGkdNJMm0q+enjIbVF3brMJWHszRzm1L6Ph05nk
         oGIUFc7LUeqY71gU937knxOaChahAeV5wp+CzktKQHJmiKzX7Bi5cpj0176QgHRgVvF+
         sAvg==
X-Forwarded-Encrypted: i=1; AJvYcCU8PMFkDWABySGTsJCL1I8Uvgpx2Ebn1LJoTVGsQPBPiqxfxK7A12KIAAS9OCYMZ2NzuW3RXECK0DmG@vger.kernel.org
X-Gm-Message-State: AOJu0YzOss2uSfEeiB6uU+Iec1E15gMosVDBNfKU44nsYVN0/6ABOX7G
	gmxi64V1lKM3EYWqzdqkhzDGZ0m+kRCD/1jbnK9EEdAOzgTbqgCkqLs7bwTyFalVNhNdrnhipJF
	juJSovZONM6Wq1rHN2g==
X-Google-Smtp-Source: AGHT+IH1j8tUfipQWeFaA8XhmoFYMLY/hNVnlYfVWyuGOekLQXj/Amrxq8GIzS8vIR8WKDj6T3Cvmmf/SjVMboU=
X-Received: from wrmp8.prod.google.com ([2002:adf:e608:0:b0:426:d630:53cb])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e18a:0:b0:426:d54e:81a4 with SMTP id ffacd0b85a97d-426d54e81b9mr6525079f8f.56.1760369987644;
 Mon, 13 Oct 2025 08:39:47 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:39:09 +0000
In-Reply-To: <20251013153918.2206045-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013153918.2206045-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013153918.2206045-2-sidnayyar@google.com>
Subject: [PATCH v2 01/10] define kernel symbol flags
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

Symbol flags is an enumeration used to represent flags as a bitset, for
example a flag to tell if a symbols GPL only.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module_symbol.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 77c9895b9ddb..574609aced99 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -2,6 +2,11 @@
 #ifndef _LINUX_MODULE_SYMBOL_H
 #define _LINUX_MODULE_SYMBOL_H
 
+/* Kernel symbol flags bitset. */
+enum ksym_flags {
+	KSYM_FLAG_GPL_ONLY	= 1 << 0,
+};
+
 /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
 static inline bool is_mapping_symbol(const char *str)
 {
-- 
2.51.0.740.g6adb054d12-goog


