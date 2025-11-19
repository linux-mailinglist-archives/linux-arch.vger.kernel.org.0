Return-Path: <linux-arch+bounces-14928-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D63D2C6FD16
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC130345204
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D86D2F656A;
	Wed, 19 Nov 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFLOD1dQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD72F0C7D
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567139; cv=none; b=gTucyygIs/rnafQY15Kh1axfcPZ8LH3Z010nXpEp6rtPtcWapnBF4V+xk6/uFCFxnDrBTTc5Iutg4b89xKbbkBP7gqIaWSJAZJh/+uLV4dhRWvQ9GujDqWkLLjsC7UBKs5LTVfZByUTxDRIKB5r0FXkWiN7Fo6+1rpp36KquYi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567139; c=relaxed/simple;
	bh=E0xWWAAtZ+sb1tFoy69j+X8UfYdpBq6LQ0ZttxzoUlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkeLs0gagvS1LdlQ6VjraJRCaFj6ao7gqzUeVAVdCXSJidMWgH9OIknhzN8zEtvyv6QA56s6w7RxA3ArCuVL7pbgVGB+qhIRAg6iWj/yIdntY58G2zOSpdJBry7XKTw25/q4Qt/+AZWFLSmlMVLtrNeehsjVUSZRTC1tDJYj/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bFLOD1dQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477770019e4so71951245e9.3
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567131; x=1764171931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93DS/ScHi6FgD35ajGLpv/dHTyNaaklJOjylE6wX7jU=;
        b=bFLOD1dQC0Q4Eym89MV7724Zm5/qYdVd2/MyrMm0XvxbrzU2lDJ7f3Hv1VBREo0swI
         VNOqEN4cIlEgl+4RG3ftwarzTx6ULTRfRqQECW4NCGOea5bakUcUwadftn+o9l5qcuQr
         GqOhGsYig2eyjmviFGaWge0Ow+AucMs/GddQ7Kvm24vYmAkB9N2JvTJG65NJ/KsZPbV2
         WLjgsvnPwFwpu+sLHn5AI3lW/12WVyHGZzzBopJ60S7mOvi8gmM7wjOlCW9IqzOHKDLp
         paCwK/zQhMrhsuME+ta7z/kdBso55S8pQQVjvaunWcA3poAn3wdp0V295gegBTryfFZD
         wv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567131; x=1764171931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=93DS/ScHi6FgD35ajGLpv/dHTyNaaklJOjylE6wX7jU=;
        b=AXcQsEcTiMGkjnH1cvB7oOwtH9E35heP4qp0OXANP8RFZd1kNc61KeJbe/MDpAYBSC
         APHkqQx5TAqcDC404VcWa9BKUmwjPA+rEGB0zuAiNUL3KpBgBlKP1jDFduTmwxNKuIhz
         w4MeiG/7mMttjOzuF66xSPvR5Hp0/9z90NCSm4KPoLX2RHHS1HBTxIJX71+qrN+gZIdZ
         8kaYlbP25tJVlwIR1trV1TETcm4YUYqRjyHTdmDuk9UtrbofeABwDdXEjTWEWTEr2AfF
         fH8NTIoBV30MY5ah2liVPmw/2f4bnC4y7AElerB5b9Gh3AGFPbGqBFOXHhxUpKVV9sbO
         JsFw==
X-Forwarded-Encrypted: i=1; AJvYcCWTBBc/XTqTPrnnOfDOGyzymlTmiPkhbbM4V9Y1in9jktfLb+aAvl7rSKXYka1wePbrPqFipR17f+bf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9QZWRw7TLW/WkDRFlsl8SXV7G1A03TLiyoS5I8l3BNFtY4P0r
	I3W0TKD8NxShGCASRJZKha6IRZpwo3Jvt4KPZpN2A6DydLxu7OLFF/MzzLsmKEmnqWc=
X-Gm-Gg: ASbGncuhJvXwNbPZjtJ6tFvMDhzoFwo5PLremO6iTGD+NuBWcZ43YYij0CHl4YlX5aW
	fNdM+UbGTOJka/YjUiCrWIEsKg1gHEi5Yzs7GHZu9lMcI97uH3+70O3kFnF/oVB/3MOVkwz7PQ9
	jHx3zTJpgwuxgbmbT/fVR2GEqB+NegAjag7nUCRw1enTF1HOXRxFpN8UueL3WcfopVfuZRy2i00
	Q4Z/iILfhwD/AQuUxKOYoqgHjfhrbzDoSD6yxs3ZOa5oPamNyB3BNwZ3/hbSU3oRm3uvdrdfhv2
	Ep53Lswb9SwtB6puWBmw+qS66TdPu31UlKMOrmhHeNg6XjVqMoVRvn3J3vP2ANnwuHQEqXVTW3O
	s19/ULLQsaziWhlt8Nq29Jutvglui2WxNJRgtvDv8OnufHYvQ7Gth1ov9hXT3V4Kv3/ZKztlbCG
	LDrb+IK5VCRMt/zE222/HC/Qu1RW1pVJJHaG2lymhw
X-Google-Smtp-Source: AGHT+IFTd+L8MIsFVmd5+4R/tV4nej4oyMMzTvyobs7oRMR9eeDnvkZRxA29k7Ua9rj2plkllb3d8g==
X-Received: by 2002:a05:600c:c48f:b0:477:7b16:5f80 with SMTP id 5b1f17b1804b1-4778fe49c0bmr204044185e9.10.1763567130586;
        Wed, 19 Nov 2025 07:45:30 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:30 -0800 (PST)
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
Subject: [PATCH 08/26] mm/page_alloc: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:09 +0200
Message-ID: <20251119154427.1033475-9-eugen.hristev@linaro.org>
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

Annotate vital static information into inspection table:
 - node_states

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 600d9e981c23..323521489907 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <linux/meminspect.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -207,6 +208,7 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 #endif	/* NUMA */
 };
 EXPORT_SYMBOL(node_states);
+MEMINSPECT_SIMPLE_ENTRY(node_states);
 
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 
-- 
2.43.0


