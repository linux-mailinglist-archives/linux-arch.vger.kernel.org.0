Return-Path: <linux-arch+bounces-12934-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A8BB10C9F
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597973A5BEB
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 14:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662202ECEAC;
	Thu, 24 Jul 2025 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+yP+DjN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED382E091B
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365413; cv=none; b=G+CllhZ6Phtr050tdax8faShFZTddwVy371lbjTdzcPh6QyC+/QOyPQMw8kIDJsFS7QuMSRgAfxsOAJEoB+sc/S3AdaSteFpiBcl5PivixRZGyDVR8y6CVYXj74Ft0v+PPwF1gJf8C+TJxfWw3R9h21wvDBawZlmXpeMCvtbKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365413; c=relaxed/simple;
	bh=SQxu0R+MOijEBbbV34mwRJA/GN24qy3N7mFo2kprDqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3zOaVF+TpZRVWSw9HSC3JqGGrBfkJbX+DebGPQCNTWEwMjzOvNAh62bDUI1dpx81UPDLP8n4zyR8Sr94FMGC4+zq8X3J4/YTK4GO9X/sBG5lVJrc7U0+WAX5bkKCTPyGAtuM4KnIlNicXkCGDEPvyL90xK7LuYgFVkwGglS6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V+yP+DjN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455b00283a5so6424325e9.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365407; x=1753970207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVVaZTfA71hNG0BSuf2xrM/AfoVAw+w3Csdp+8nmO5Q=;
        b=V+yP+DjNiFBdmZX0+X+1GT/0jSDVJQdpQWqF0ppRaNQzc49toUn7rWNbIPLNzBTV3v
         wNWkiexWDjY63ikTVsoU/ILyqacQjZ8QacKphScsC4/f5U/YePpcxYSjHSY+u+V5+Ltx
         sskxvykF7Bu6ijU8AFPBb6/AO6OoNgxwzH9F4MeY4v26sSuSak4sPl62uaKzjx8DkVRd
         jLbvBD4ef/mS8ygVvLqsdORg8bSZCWfz5Gmfn7oatkWV7HvTa84xItdTnRbb2envSyQ9
         LHRe94Xf+/ggX86LXMsDhr6R4dQIHDZ2xL7nhc31q42I1RLqBZCiOXI8TCGbKrwR9TTW
         712A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365407; x=1753970207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVVaZTfA71hNG0BSuf2xrM/AfoVAw+w3Csdp+8nmO5Q=;
        b=TWIHAWcn+w3TQDjiLAgvbE+nN8bNCoBfosKH9ZKStlCDpSyx54iXurGzVHY0ms1kfM
         +JmVpap7n69nI1npok7P2ovjek16mf1sYiQRZ91vPaFnsSTQ1fiBZWnGBZuZbM2A5J1+
         /5D5/LmvPk8zDKsatf1DpeERKTdA8ECqcXONgfZJK9fZW/nTk2/JGO8kyLFSOU54+Enz
         21hJND7FDmJj6YxUNm71104i3V1MUn3Tl/zPhMK1Eu7wMwiP4u0y/A9sTfsviTfQ484/
         DXXYEkWBylQa01++7gKTemtFMZvPzKJ1YPPP7c5Xw48bbg5TD2q3KRAUc1obU+Rldgxq
         0jEw==
X-Forwarded-Encrypted: i=1; AJvYcCVKt11Sptk4Dbe2BNH86HewKe4uGv07J1fbigUIoglqsEGNAFGAbzvw0/LKQJQp42oqCFPXOQu4+yYL@vger.kernel.org
X-Gm-Message-State: AOJu0YykqWKyQpIai5JEaf15+GULMEdmOCFJalkJojmVsFqgfmgdTNV9
	v/c/gnIw/p5i+hXZ8ytOaEVWKIYmdbdiEYWpwp9b7SFwlFLTi6KjX3qGBXbwKUWsPno=
X-Gm-Gg: ASbGncuNal5LshA3VvzzrKMbP6FAvN8wmBLU4zY/XuTNE4kJEh61M582FAcWcUN3kww
	PIfIPC0uUI9K1lpdKCBWXIbETuzwP6xFsIqkaVj7H90uw+WJ8b6GmT8WcdKcIla3Y6zvOypEBqq
	X3gYsODnsUPz8uWB8DWfGHBFbO1puqZuDxrGrjy2RU3Bxxek1Fgv/XVCTskN+VeiMJfNUpg0km+
	NDdDZBKfj0obeKxID4SEvny+0lmUXu6TGr3ugz3gnzkpfpFkJeIxATQWpX2yDOlvDgg3vaCAtWi
	ynM6FzLhXIeXVXFTKEEfec+B9dsUAUOfIdrAuUbJnFe7yfM95BTknxMrTk08IjIipaLUyagAwxc
	9NX2vsOHC8qwQFnHQtU5U/v8B8HdQNBG6Mo5UqVNUdueQ4Ws++ouPX2rUkcfMekCthUE5c3e1LL
	fEf4yZWxX21zkM
X-Google-Smtp-Source: AGHT+IEY/sSxRS3Okztem0YstmxIRhVbZi0Ba2eKMOhhVazzTllUuYgXqZyOH8eoFni3mxJ7gmSmCg==
X-Received: by 2002:a05:600c:630f:b0:456:2bac:8f8 with SMTP id 5b1f17b1804b1-45868d485b0mr79331075e9.16.1753365407522;
        Thu, 24 Jul 2025 06:56:47 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:47 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 28/29] mm/init-mm: Annotate additional information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:11 +0300
Message-ID: <20250724135512.518487-29-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate additional static information into kmemdump:
 - _sinittext
 - _einittext
 - _end
 - _text
 - _stext
 - _etext
 - swapper_pg_dir

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/init-mm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index 2dbbaf640cf4..01ff91f35b23 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -20,6 +20,13 @@
 
 const struct vm_operations_struct vma_dummy_vm_ops;
 
+KMEMDUMP_VAR_CORE(_sinittext, sizeof(void *));
+KMEMDUMP_VAR_CORE(_einittext, sizeof(void *));
+KMEMDUMP_VAR_CORE(_end, sizeof(void *));
+KMEMDUMP_VAR_CORE(_text, sizeof(void *));
+KMEMDUMP_VAR_CORE(_stext, sizeof(void *));
+KMEMDUMP_VAR_CORE(_etext, sizeof(void *));
+
 /*
  * For dynamically allocated mm_structs, there is a dynamically sized cpumask
  * at the end of the structure, the size of which depends on the maximum CPU
@@ -51,6 +58,7 @@ struct mm_struct init_mm = {
 
 KMEMDUMP_VAR_CORE(init_mm, sizeof(init_mm));
 KMEMDUMP_VAR_CORE_NAMED(init_mm_pgd, init_mm.pgd, sizeof(*init_mm.pgd));
+KMEMDUMP_VAR_CORE(swapper_pg_dir, sizeof(&swapper_pg_dir));
 
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk)
-- 
2.43.0


