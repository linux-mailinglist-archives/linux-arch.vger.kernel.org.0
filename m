Return-Path: <linux-arch+bounces-14923-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41213C6FD48
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A0D04FCC73
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3B834B199;
	Wed, 19 Nov 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s77ePi5V"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61382ECE92
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567128; cv=none; b=i/mclbiUCCNySJAZk2of/rtiEzBpSFKTcoYXRsgs3+fWn3eUd14FAXQP01hIE89yrwT9mud7b3HJLMqD2nMDNnKidI7WopaCEruubd0vZ2dDx4h5R+87upu6tnOI96iTuPBJ2XOlO95Kb7YIsSbmpgwIEmTcPkyso11OWJdlMl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567128; c=relaxed/simple;
	bh=xVX5vMoWLhUppTQAzGqUyciUL0HvTWD+fRU1g1HFtlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUCInn1eiu7vxa6HDff5IPY1MQ74LZgxbINfHQ7N6JhpTVfIs3XtwA5aQT1sX6BrurHkOPmjqTqoDQErglQQZGBijgasZb7xqGWaagHBBBB0KdyGubOmDXGeaL1kcxo9w90m+qySKtk6hVOnHg33jVUZUIFGrj4nAk3Cvi6TRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s77ePi5V; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775ae77516so75155255e9.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567122; x=1764171922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0blJpzJVpLViS6yP++1+Q3N2n4IWObMjESar9bHwcO4=;
        b=s77ePi5VwhAc5RdCjyAb302P4Ka1p3s03BC0V2FspdVUm4i7WYiQ2/MLytX6QDfaGN
         kK0mUXAjWAWky+BcR4OpUoRFi0GuLC8Jj5SFvNrkKqqTO0fWekjRVtmOv5IQvQfdHEQK
         TgXteXNfAy3vUVfU4mt5qaDa2qJFDh+l7TG550TjqEsNBBo3aCcHsKC73Ycok+9pbhk4
         4qiYo9F/ku0uKX/a+S6dfpVvgv0UCLbmIZ6q2Z3sPsILWyDBj5OUEh6kQHBhCPh7EmVD
         hwar1tExtLfqrIQdYXQl1vj4KnszoQmpLBQ0hyx18qnEvaC6g0olZ5w+plmslpAGCUNT
         kFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567122; x=1764171922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0blJpzJVpLViS6yP++1+Q3N2n4IWObMjESar9bHwcO4=;
        b=VoXPc3SE2HaSGNgCNd3yAHb5/o4aOWeG0HaeI9lEfoWWyadNlOUr4+BYZy+zWClyOQ
         144RU4tfsib5mun+YZ4az89Bxzhjyt+Fm8trCVvjuBcmSyfTK8Xtb4sdMh5AjvsUCOXl
         wgF/eCsbSwua3pamuh5z1h4Q0rqTUZc5n8vw7Cn2Zydlnzf5V6Mu8rCL4C+iDx7joegs
         RXi5Pkp+61SFhRTOwzjAfjueI+45talOzjoeDLriKfxnOEM3uHCe7ZIe40nXBjYIu/BA
         rB/k0+fBvR6zprlp2iTCzVj2tvoQIyE2RQvpip5kj5Wu16YY8c2c8v6khDNkisMVK97w
         2zTw==
X-Forwarded-Encrypted: i=1; AJvYcCVRTpdsaLqJQSbXvttsw7I8oDJFsGCYpl+TEBW4XACeixCkLlbomE999wKlheeLaYuSxuRQDDM5rQ8R@vger.kernel.org
X-Gm-Message-State: AOJu0YztFJgrreOmKa/KLbfcpzs4vDai1VE3w0jJESoYpxTVlf0b1ulD
	yA7YQkiyLyt8MB6i7HYOEIGnixIE2letZD/d8yR22OPL7krkiObsCTvQCub56sH05bE=
X-Gm-Gg: ASbGncvG2y0gtSb2LjjYkjK0V5/kBPRu5JfsOUVrLBxv9JIeIaClxoNeCFHCCeCCVYQ
	lzkVIOBZTq4KXbg5Vzmc5cMqLnd+oKF9n/DAhwwCYQMfQe2sh+VCUDFx3GkxhOW9Rrdw2CkAru4
	aB6S96LY4d24HeqVD7De5GQry9uTOdRI0RuKYliH13e3vbx9Xp+NdEFmRFrose9O2m7qIpe91eQ
	AHniQJgH0AoAUkYPRlD9Pu4IggZ4RNbO1VvUo9PidUH/zcFUX1gtmfxsH9gtUoe/3Q7YOPtsI4g
	gSEoro341RqDVCq8Sv4wZ2kpk9a2KVov0eD11+lrEdZwK8rVnevoywGS2qh0iIZHc1Z8i5yeZaW
	KyJ10E5V0WX08YG6yw4o/QhXAiqGsjQMSmJadNq3vP3gDlE+z2b6/+BroiM8i4q5HoRAoVHhvcY
	lnju5jdxgIhfvTR9fRmkY=
X-Google-Smtp-Source: AGHT+IEf0A8SfCPAIU5Y+01ECXL2jbadglpozgNAZPe+3fJhQYPBk8r7h45IbtadEb3Wt583O3k4NA==
X-Received: by 2002:a05:600c:3587:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-4778fe522f3mr209598755e9.5.1763567121930;
        Wed, 19 Nov 2025 07:45:21 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:21 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 03/26] mm/percpu: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:04 +0200
Message-ID: <20251119154427.1033475-4-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into meminspect:
 - __per_cpu_offset

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/percpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index 81462ce5866e..cdc5b30f6a99 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -87,6 +87,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/memcontrol.h>
+#include <linux/meminspect.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
@@ -3346,6 +3347,7 @@ void __init setup_per_cpu_areas(void)
 
 #endif	/* CONFIG_SMP */
 
+MEMINSPECT_SIMPLE_ENTRY(__per_cpu_offset);
 /*
  * pcpu_nr_pages - calculate total number of populated backing pages
  *
-- 
2.43.0


