Return-Path: <linux-arch+bounces-14932-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E062C6FC0A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id E16F929D13
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21ED36C58C;
	Wed, 19 Nov 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bz492DHl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428A369984
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567144; cv=none; b=O+3nZrBh8VoWhMxV3TBzSfubPIrBEEegSo7bZqCESMnnPhCyoQUYa2tGfk94KEX7ZU0y74R6nwYh9wnd5V1xXBKVAWpJ+ekkWERS3+mPF00QPO9alupPuo0T7VjJGIVf0JkuPfTxx56/ZKzdELjcMlBo1zIkBy1Yi1RJDWS4RqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567144; c=relaxed/simple;
	bh=bdt5n2rAVI8cStNvPmdZt8oM87hfXgPy8mlP/xL4jOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUWu8EVP60C5771frZVWPmau3glCo9SIAOQMx72dUZKgN0Exfv/0RLdFomuxmpB0pVzWTiX7knC2lGRAhTXNrzyU4BXlEqMi90zFk5+i2cezskOiGY0+KUv+JYZEVBDV0G1/aS4+pESTY1k7sYzzcVYUBiqltg+hLEMCoA1ClFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bz492DHl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3108f41fso4232447f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567138; x=1764171938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slnZKLktel7FGULom0AhklQ/3aJdt8tuo66g65NOCPI=;
        b=bz492DHl5yOzE9yJqimKdlgCFvBmcsPkvDkuBNCriAVZnkeSAqY3nP7LGbyBZvdxbW
         oc2HOPgDgVH18yyt6HjNfvydEL8GIuHXv2Pofai7w1UKXlmII3hPumvCXNOvOePSROSi
         e/2BiBnIWC2n2sNn+FoRECLcoeEkoo+4CnwCEhpQwBpUULBVqNYLT4F1hgITIZqkJLqQ
         bfeKsPz9KlTRqx2ZVlK2A6artCAtJV32H7NQpEOqVUMiDR1uo3umGlgdSfA+RVSV9ygb
         zLmQSslT7dn9MaSqtfyzoxsSoi+0bpd+NdlBvr5Az29P7gmjqheUCt9rGNgINWi3WwuL
         Kn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567138; x=1764171938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slnZKLktel7FGULom0AhklQ/3aJdt8tuo66g65NOCPI=;
        b=ShrtQqOtQKE6d7kEicBNkLB3p0vco3Q0AeXBnezwefBiC9wwQxfi/Wlf7olNJEDqVb
         E2H0yZcJZQfHUbe/gUiMcdxfZ8bDGU/S5BBMVpt9YxP6gbNR6qq/Pf592RZ+fgylwHVw
         z7SkPdAdQLXd7qC0/uxKlmhypoihcLdj5bQeEgHv+WFYrhCsNH2TKIYepYoF8+hgDNJM
         /ul2WrkzqPMMF6CRVAyzz8Cu+PeSzSfTYTHbdnMDwoReSS7jCRYADcpaJsusbbCYG90F
         mor37DfkNVA7bffbt7ndBXNv/VH7hcmmvEDJHv8Phk2TYwNCWO8fhj016mC5c5r3EP7e
         gpGw==
X-Forwarded-Encrypted: i=1; AJvYcCVjuKNRKeRPoESXNVzNlxhz0XWJCiZdbm8P0tEyhWGNu5CLbuYb0G3SpEjB1rSb0DXA/1J4vylQyc6w@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIlkwTicNdVyN3DpsqRHqkcjnjXcgZbXxzTBRFLo8knAPqcIy
	4lz4uVWt2iGd+RP/+EHwaiBhGf6LSoIu2Y8UeKkvv1EyRVUATdEXF+zIe6KM26YpKls=
X-Gm-Gg: ASbGncsiUkrp/MjB72QXPVe4JQyLrzZsoQPnr1ybaWowprTVzPJWIQTj0ze09QlPzFn
	mVhFT7bPEf2rt0B9raPFCzV6vL8ySH9zS0iBYMeoNHnRJI4WZtkmlDV/czTP0y/CoyPMqstw95v
	WSo4REIPov0IhsgjmUwN3o0jMff9odXa9apqxootPTDRCffXNNq2jAhH555rXMHGRjcwHfSWGwl
	LTIA152TMMXfmCLmCHT3X+MFd0mLQUzOn/fuCBZgByW+JgqA7mAtPzOSr/VmAlywsc5SK2qpsLe
	86BNYsDNPj4IeIpPn0VqwB0cO0ZT80SreCaKW05XlokX5u0rdclTpcn2KOuXij0UJKI6GqpQPzS
	mtRJODEs5zUHBywLuARqx1mpiyNuBQUS+68MZa7+TwYgNXQwL1GMnaGaok9pk8XDmNkh6ARR9iW
	lZsefSLf/pRp3BN/rPn2jTFzSiZuZpkyw5it5/pWfj
X-Google-Smtp-Source: AGHT+IH9XA5XKwB+eYd4P52AVjjtUkCjRx7TcK6UtIfvF/aP3IOPVELnIO3YhYk8yezAw62YpuQ83g==
X-Received: by 2002:a5d:64e7:0:b0:42b:47da:c313 with SMTP id ffacd0b85a97d-42b593395a0mr22250899f8f.3.1763567137600;
        Wed, 19 Nov 2025 07:45:37 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:37 -0800 (PST)
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
Subject: [PATCH 12/26] kernel/configs: Register dynamic information into meminspect
Date: Wed, 19 Nov 2025 17:44:13 +0200
Message-ID: <20251119154427.1033475-13-eugen.hristev@linaro.org>
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

Register kernel_config_data information into inspection table.
Debugging tools look for the start and end markers, so we need to capture
those as well into the region.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/configs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/configs.c b/kernel/configs.c
index a28c79c5f713..139ecc74bcee 100644
--- a/kernel/configs.c
+++ b/kernel/configs.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
+#include <linux/meminspect.h>
 
 /*
  * "IKCFG_ST" and "IKCFG_ED" are used to extract the config data from
@@ -64,6 +65,11 @@ static int __init ikconfig_init(void)
 
 	proc_set_size(entry, &kernel_config_data_end - &kernel_config_data);
 
+	/* Register 8 bytes before and after, to catch the marker too */
+	meminspect_lock_register_id_va(MEMINSPECT_ID_CONFIG,
+			     (void *)&kernel_config_data - 8,
+			     &kernel_config_data_end - &kernel_config_data + 16);
+
 	return 0;
 }
 
-- 
2.43.0


