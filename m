Return-Path: <linux-arch+bounces-14935-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 198C1C6FD93
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BEC14FE40E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22B736B072;
	Wed, 19 Nov 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XeaDF8kX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675236921F
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567149; cv=none; b=pCnEiYrNx4M5iQ4wD5/h0ALMlXKdEz+GZVj79jMtwhMYY/4p1+GF/jkKCGUKzuH5kJsgfUjUEFkq9i5pTF4mr78OhsABBy+9pbVWEdvk2rNtEjL5mS3oCw60UcbyDvxGkb6nYrrMZfVk5LydD7R9HmhgwjwVq15UnuWavHrZD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567149; c=relaxed/simple;
	bh=b7ZOQzNfYMyF79i/MOcMgt4XB6zny2khgQb+AuAIOw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWmpcax5KFxEyQQ+ooajWizCeNYnmLKsLcaLoKF2p1EDuPETQzJB1SD1VGAPWakd+Qla76UV/AemJAiSoE6x1hfWOXLSvYTslWehlomgAculr0YBazNAk9Tig7UQjCGTVSv48XGwDgOyi9BsOFO/KcJ3n4C/MTiGboY5b6xfrbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XeaDF8kX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429c8632fcbso4851369f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567143; x=1764171943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVYkZ+YGVFmg/wGLFr+Mopllp1/vePaMucgqpmR/GFM=;
        b=XeaDF8kX7ZMHl7X8ve6YNTs6euc7cDzNwMF9/a96PZftfKYfkZ/jXE/thXL/LIiIaQ
         Q02MWmIB0O+JZ4GbrTxisOUMxALtAyHyz7jTCadkeqf2n22P1NIagu441f3tgFfM7QcK
         dPVYhDfsgeVsAh6mkKLn7q2BI2RpjPAWudhIFGd5mliSmMThEjsoxYZzUd8k5X7CyRsw
         sHUf1zcJWaopAFbyIAHxwLNqAwpL2GPHXcCGTngCCzojxG1y0pFkuHuu7f41aalfT3XU
         P6RMp8UgCgz+zFoKCmXIQRXYYotpvNuXYRt/Q/hWzlmcyHHgx4Vpn62xuszXtlAhNHlv
         FbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567143; x=1764171943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VVYkZ+YGVFmg/wGLFr+Mopllp1/vePaMucgqpmR/GFM=;
        b=Z0Wd9cdXEZNARp2D0O1g1k/Rn3IVRErjoZIB0TcyTe7nyRcW6iLlT3eejOdS/JRzos
         ho56aARY29VcUeUdq0ikFlMKtG5qaVEQkjU/7cL50vtpcJqe8lHmx+PEUEpgY8Amybd9
         ZODLTQ1yieiu+4OrFJxH/FkyMO+xtD6eJuQdgXf6AvYm31osoOYJqfk3GgwMRxuHFlwg
         JkUrqDWsMWJI0+t14sbWZocm/g9VvCLZ2ByUstEzB5WFyQIygEkXqVQvBeGH1GqnNAe8
         Qgh0HK89hKl4aym3NXMAmKE3plBPm1EaQZn4Fz3VLTXFDfeUPeIEBv8BvRx5yIWDpO6K
         L0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCW7XcnmFDOPxB1y418Qqa8VXHwR6JXUG6ufO1KL0Qtk1Hffn5cqpLCPIvotJscHKJMcIZt8p+WF0Fjj@vger.kernel.org
X-Gm-Message-State: AOJu0YzL49E+BBlBlqtj6EOAkr2k34neZoZSjay9fuPdAOlLXbAqpXh5
	o5TKeEi+ItLo/9JVoX1bo7LpSAVINzVui/nhoZr/peAodcDRdPL6mU/Ha3VSim1s6q95CdoN7h9
	O7Ie5BZJvrw==
X-Gm-Gg: ASbGncs11wfnWERdsZT3NseNosnseTqUBzfsN8gmw5KRaWI+G/vVFWvuGAn/exzkxss
	VBQPvf4fXqec/bS+cgoSecjJG+UgFAsZkQZimr3QAyz0s1AMgaTyHmIXMThd9BG2ZkgIkNORzDY
	a2FzSSZr9IDQI6Bf2GgKAhMEhOmjLuoMHxMnhnxUWeMU+Eq3nIprEtuM81fXWbNGz/A8NgbT59X
	ICf9UO1sqT/FxLSXMQUyTAor+zGFEQVanIirWJdwdubbfGyEOkq0c+Ukny8FwlIsgH7MkGdd3/H
	kdIqtjuSNE6kQOIwN+jD5fJfjqVb6QonqapifyAWpvU1LWuDB9JDIcT9j5SIRwR5APLdb//HAur
	HVNigO8qbnP9xVbvKNxNv7HGWBqUnQRBBaIYACSJnnNTkf854MczO3m5skRC2HkIWv9nHUU7z1d
	afKEcOKXSQJ14Hdzcf/zLreZ80KVbEsQ==
X-Google-Smtp-Source: AGHT+IEZRkUZWC9WWo9OX6jj9I/ZWQe6urgV7WqPXknOd3CwNTmQvHOBkmKtLsoZT2TI4A/OTOkOYg==
X-Received: by 2002:a05:6000:200f:b0:42b:3806:2ba6 with SMTP id ffacd0b85a97d-42b593394b4mr21022814f8f.25.1763567142926;
        Wed, 19 Nov 2025 07:45:42 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:42 -0800 (PST)
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
Subject: [PATCH 15/26] kallsyms: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:16 +0200
Message-ID: <20251119154427.1033475-16-eugen.hristev@linaro.org>
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
 - kallsysms_num_syms
 - kallsyms_relative_base
 - kallsysms_offsets
 - kallsysms_names
 - kallsyms_token_table
 - kallsyms_token_index
 - kallsyms_markers
 - kallsyms_seqs_of_names

Information on these variables is stored into inspection table.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/kallsyms.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 1e7635864124..06a77a09088a 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -31,9 +31,19 @@
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
 #include <linux/btf_ids.h>
+#include <linux/meminspect.h>
 
 #include "kallsyms_internal.h"
 
+MEMINSPECT_SIMPLE_ENTRY(kallsyms_num_syms);
+MEMINSPECT_SIMPLE_ENTRY(kallsyms_relative_base);
+MEMINSPECT_AREA_ENTRY(kallsyms_offsets, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_names, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_token_table, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_token_index, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_markers, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_seqs_of_names, sizeof(void *));
+
 /*
  * Expand a compressed symbol data into the resulting uncompressed string,
  * if uncompressed string is too long (>= maxlen), it will be truncated,
-- 
2.43.0


