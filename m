Return-Path: <linux-arch+bounces-12932-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC64FB10C8A
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CB51D00087
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018A02ECD04;
	Thu, 24 Jul 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwFZiSQV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A22EA72A
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365411; cv=none; b=nXrk59l7CxCJ1Ra0yK6QgKNU/a+0OCaWdI5W2e4DNpf3uiEfj2o6isemI5Qx4d7Es7AkB6BWJqdcxMsj01CXmrcwz98u30/3f2SU4KXrX06oGus6h3ZfLw8pTuSdwAChFBXSIY1LsXp+QLvyzTVTXu0T/ZfpGeFARK2GNS8P84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365411; c=relaxed/simple;
	bh=yDgqovov3P+BgQJIgQIcPJeeBOVhAaLQJOWmJvGhnm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ST4W3xJ4zaknQg9TLAFVcwwTtPGs5Ro7/JQMm6Df+IwITC3qcXqtcuSQhQ2OWbc74GIa8Oz8CrJhPpuOWgnjpe4lAba0kmQY1Pf/IDFQjTk6E4Bv1B4YEerXJ7Q7EH4MDxDYCsEOczbBDUJ/qFlgAouKc2LLVOaDV3wjjcDUTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jwFZiSQV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45617887276so6901435e9.2
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365407; x=1753970207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la6fP9HkJphfM0jMf+9F231C5ZYtMe+0kHUA15eBYp8=;
        b=jwFZiSQVJYWsamCDFeiyWQiJ3l/lmU7kS3tELReNf7RPsOKXGDXYGlWUMofbznWnLw
         8ZnZ1porHZcgssDi+CbL/Nm4MVmuNi2l0vKRD7VTDAoimUJoblalg2o+NqLFQgq6YvSJ
         phfuCAjdAtTiLT/9XNloAnkBqNCM0xkC6j+phLm04TSGt8Fq+yFcCh3Uy5EFmcCdnOR6
         cPIKZdFJos5wrXSPtaaeGbXhStNFIWhGew6+hUqzuDMNoMCgOyv7hMD+aIFhRM1QbNaw
         T0mAS/mSYMrXQf/WBLp34BXnb39XN4U3ImwgOQAqkZ2UQWp5Exo2pQmuK5X9xRzfG5Jt
         WZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365407; x=1753970207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=la6fP9HkJphfM0jMf+9F231C5ZYtMe+0kHUA15eBYp8=;
        b=rhlXkEnBq1BMnKG0iJAGNeoxrhoSMx3sccsu/0QxrzOXkmmsl5lFlaR2YrArB3lMY/
         VnQ9AykFssSyFxpCrCYWqsVunPxVG1KMc5ZmRth1p5MAitOgfXtVt2csL/ucX3+rHYUc
         lIqoP8B5TroPzQsMdkWvZ6ev5d++539IoaNF4CJuGk9mT+LlI7fkyengp5ufVodCk5gH
         mDHI3myaWRb02MEvkgOrqb5KIiiClRqco2sQo37Kr5SNNjd0g4efTpBA14QGXFsyUjIC
         ca4MWncpWkSKopMXSQPiuWRFjWGNKzOqVdhxSjjspRMLL6u4+KQAXCqXnfC/1BfedML1
         hznw==
X-Forwarded-Encrypted: i=1; AJvYcCUuqJ2GD44gpUxn7UI9mkyXk0N4w0HDYJy5NCUMW/Wbu33HSuC+8C0nvWNHPPIByeYmmhc8s7sh+TXg@vger.kernel.org
X-Gm-Message-State: AOJu0YyRRLnHgE9nEX7oCOr7JOFNMSTZPihVWDJSMrYudj5qOkPS4RpW
	gu3b0bmvJZoR2GAbj4SzQPAXSR4HQGt2H7RLeYnlNE5o/BZoVtiXRVnFgar1N5IIfcM=
X-Gm-Gg: ASbGncuuMVOfd7fet3Kkh6PSYlti4JxlrAlLYOM/TNVS8Xr64vO7UuJ9J7PchIviTfS
	kvq1hCLu+GQzI2OI/TDSIdEk9GI/XvBv0/Xk8AUY23JQjf6B5MiOGkys7LbQtmUosnexekkr0BO
	Lc4++j4Og/pJr2x6mnUD3c7w0qA7ApyuGE04hlvdCAbQY9gPNTODC51LPhCSyIP4qGGf9oPdSmk
	4hVj8WQfeF3l0Yb/8FzzeCtJUY9fJmn+a2+2nL4h1/jwLyHyHX3MR9qWBOJ6YbDrWXB0z61mapS
	73Ubk2FYSzBnf7pmYGueG+guPPjhCTKm7qDQ4h0InB/d6F+G2NRkH7kt50Bpj3iYHVo/CLGgf9f
	XNsyisnjB2FFyhrauT4/jiw0L/VcL3bUYS2qfjwKB/KCeTuP8Om17tcWZTteb7YwDdkGIWvCJAS
	ilZGJBB24yxs1f
X-Google-Smtp-Source: AGHT+IHN52iDsRUI3MC45fB2NHZ78a+PI04sVz+MJmf9Pj70BNaVdCA6rPCjq4NJ6xqIYAMwjrcKOA==
X-Received: by 2002:a05:600c:4693:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45868cff3ddmr60788825e9.20.1753365406597;
        Thu, 24 Jul 2025 06:56:46 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:46 -0700 (PDT)
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
Subject: [RFC][PATCH v2 27/29] kallsyms: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:10 +0300
Message-ID: <20250724135512.518487-28-eugen.hristev@linaro.org>
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

Annotate vital static information into kmemdump:
 - kallsysms_num_syms
 - kallsyms_relative_base
 - kallsysms_offsets
 - kallsysms_names
 - kallsyms_token_table
 - kallsyms_token_index
 - kallsyms_markers
 - kallsyms_seqs_of_names

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/kallsyms.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 1e7635864124..442dc13d00cf 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -31,9 +31,19 @@
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
 #include <linux/btf_ids.h>
+#include <linux/kmemdump.h>
 
 #include "kallsyms_internal.h"
 
+KMEMDUMP_VAR_CORE(kallsyms_num_syms, sizeof(kallsyms_num_syms));
+KMEMDUMP_VAR_CORE(kallsyms_relative_base, sizeof(kallsyms_relative_base));
+KMEMDUMP_VAR_CORE(kallsyms_offsets, sizeof(&kallsyms_offsets));
+KMEMDUMP_VAR_CORE(kallsyms_names, sizeof(&kallsyms_names));
+KMEMDUMP_VAR_CORE(kallsyms_token_table, sizeof(&kallsyms_token_table));
+KMEMDUMP_VAR_CORE(kallsyms_token_index, sizeof(&kallsyms_token_index));
+KMEMDUMP_VAR_CORE(kallsyms_markers, sizeof(&kallsyms_markers));
+KMEMDUMP_VAR_CORE(kallsyms_seqs_of_names, sizeof(&kallsyms_seqs_of_names));
+
 /*
  * Expand a compressed symbol data into the resulting uncompressed string,
  * if uncompressed string is too long (>= maxlen), it will be truncated,
-- 
2.43.0


