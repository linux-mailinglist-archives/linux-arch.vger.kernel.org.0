Return-Path: <linux-arch+bounces-14940-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE27AC6FDD8
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD1103517D6
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945133A8D73;
	Wed, 19 Nov 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OlsKOf7C"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F25A34FF42
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567163; cv=none; b=FfqNDLXeydAIIlNkIa7nAD3+vrYXIfRT4k+uUMlwSu2ElfbKP1URn1Lx99S5tXjITPjuB1P2in7DHCKWpPrlIp13UVChw6t1Lzdxqn2QIS7oynNG4c7hNKFLjUJAr64Dv2vA2Zo1tKL2j6o3jq3HsKsyOQBQC33N6xyJTbQbLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567163; c=relaxed/simple;
	bh=seLIx9q9vL0GJtrOwhh44Y8oeZ01I2U3Qbuzz6J6f2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVVTkZRv+g9oUDgFzCK8859gO9kuu3a3FqVp2ygHugMGxHZ0OimmrL2d0nKi6ofjeKQPaYzOT3SEFdi2oH16e8bWYojGl37U4VulHiguv021xr1MTXEuXgdUVRwk+1uzsIJTMsl/BX8pYnM2LbbfPaPWz41BDL854aY+x2vLQ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OlsKOf7C; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b32900c8bso3968973f8f.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567153; x=1764171953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7Ucs3kp0oXjJAHNPlew8LSoAGCaHnYy/9pb2BVOQfw=;
        b=OlsKOf7CJM2UCkg8sSzf3D6dnC50mCYotNLiG83mI1qis2cSNEl6iYyMVoNUiPWFtn
         q+XeohqZ2L4g2rfVHlxX/Z74xnezMqq6Q2RDI7kKiJAAVdhgk1bmjDpTEad7w+oD+d5r
         XhwrehKHLA8zA/6PTLm1D8myUX20MDo61BthVNchOC3ajJi+FtetAbFElpDNH0txiQfl
         YkpKzG5UU3whCwYwxvP6bNGvK5NjG96/oE4wLDMc20Z9xA4rAsIdLgPvh/YVk9Ey+l4D
         ICFEIP6vLzLnMBBLHX1AFbnh29b1KM9hSgdIu/yPFwLWWVFyENhMFbVyN3hTLNk7gE9T
         2itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567153; x=1764171953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7Ucs3kp0oXjJAHNPlew8LSoAGCaHnYy/9pb2BVOQfw=;
        b=OqEoBm2ITmUASQgr+esJgxHZlFVQPqHPNxc18lMsvvOEw27+i0zMef7cgfaGjBSWlj
         cSwLGuV5qYewsdMGySqeEWsaHY6w9nK6YAvILz0a/bAIJHs7vdcUfjhJ/03cBYCrIOwE
         gwtLGlwTBr3zBhBsLoqrnLxrmsenq0rYl3lLjo2Ek7CniCCeTiUmtTa6+JYGDFb2yNX6
         ZxKaUv2hxQnsucwdbpOJQcdVtFK/Zs5FgUACuBEsN97PagmvdRbsP52RRJe7lcUgd3PD
         epqY9I708b3KtSXQX+cqES9T/Rm0zr2dQ/0BMz+cqNvtzW1t+OI9RtskUZTigc85bzJ5
         sjTA==
X-Forwarded-Encrypted: i=1; AJvYcCXNoP9saAtZq2sI00pAglxMnBW1+kcEfawoEVkCXaUu/hRuDK9OWcNECDu2byRBznzekCIEFwX79ety@vger.kernel.org
X-Gm-Message-State: AOJu0YxiNsjB0HZqVKzJsSz7jsOVNcWI0NOnnmtXxRB5PsxW3oM/cR/A
	KWkqUhxxgjV2k9Rkv4/LG/0M68ufGJeBO0FLYpbRHqeuKRzJS/sAH4HUKpytxGrIB1A=
X-Gm-Gg: ASbGncuwrDIsjsIisWiOdWhVsKG8iXR80OA6NzaKJJD580JfHzSpZVSyUeCmtKCkuIr
	STBTTvzBX+co8lfiovljAlBBMTbFzvSxl6S30AUvkAihmD9ZAZ+TdsvuGlKE4r/lOTqGY5RNZdC
	wqKCZZ9qyvtkufhJkSqQ7qzc4O/7ig/iYywii8lFC6mVYww92e6FFmRmhCMF6h+50V3C5Ow5cx8
	6sxTQQx2WP013L+d7DFByzQ413QKRjgtbX/2cIRBZ8skXiSjTo4R9/uGV0GNwfE3jO6wV3z1QcY
	g0h63pwu55EGXaV3uu/QO+CF3eMjqrtEmeeNJM2PNC/z9I4e3BeBzmaTmHa5ZVeZAtWd3CTUJ+W
	dMmBsHUPg4p7nmbanxCjoSqHZJGHkCvPI/hMUwMPRC5ER+B+1uuJJf5Exn8gVoX0Xa7JT5zbcux
	Q2zoRy1Uuy029UJMFbMOE3/SeccLhk2g==
X-Google-Smtp-Source: AGHT+IFMxVwxw3DtlUhFwveVzixkh9p9iHWd+faYE31GhqiINsGSMiGzAK7z2FWSCj0eS8F6/aaKoQ==
X-Received: by 2002:a05:6000:2510:b0:42b:3e20:f1b4 with SMTP id ffacd0b85a97d-42cb1f1de66mr3206403f8f.5.1763567153508;
        Wed, 19 Nov 2025 07:45:53 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:53 -0800 (PST)
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
Subject: [PATCH 21/26] printk: Register information into meminspect
Date: Wed, 19 Nov 2025 17:44:22 +0200
Message-ID: <20251119154427.1033475-22-eugen.hristev@linaro.org>
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
 - prb_descs
 - prb_infos
 - prb
 - prb_data
 - printk_rb_static
 - printk_rb_dynamic

Information on these variables is stored into inspection table.

Register dynamic information into meminspect:
 - new_descs
 - new_infos
 - new_log_buf
This information is being allocated as a memblock, so call
memblock_mark_inspect to mark the block accordingly.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/printk/printk.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5aee9ffb16b9..8b5aba2527ac 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -49,6 +49,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/panic.h>
+#include <linux/meminspect.h>
 
 #include <linux/uaccess.h>
 #include <asm/sections.h>
@@ -513,10 +514,16 @@ static u32 log_buf_len = __LOG_BUF_LEN;
 #endif
 _DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
 		 PRB_AVGBITS, &__log_buf[0]);
+MEMINSPECT_NAMED_ENTRY(prb_descs, _printk_rb_static_descs);
+MEMINSPECT_NAMED_ENTRY(prb_infos, _printk_rb_static_infos);
+MEMINSPECT_NAMED_ENTRY(prb_data, __log_buf);
+MEMINSPECT_SIMPLE_ENTRY(printk_rb_static);
 
 static struct printk_ringbuffer printk_rb_dynamic;
+MEMINSPECT_SIMPLE_ENTRY(printk_rb_dynamic);
 
 struct printk_ringbuffer *prb = &printk_rb_static;
+MEMINSPECT_SIMPLE_ENTRY(prb);
 
 /*
  * We cannot access per-CPU data (e.g. per-CPU flush irq_work) before
@@ -1190,6 +1197,7 @@ void __init setup_log_buf(int early)
 		       new_log_buf_len);
 		goto out;
 	}
+	memblock_mark_inspect(virt_to_phys(new_log_buf), new_log_buf_len);
 
 	new_descs_size = new_descs_count * sizeof(struct prb_desc);
 	new_descs = memblock_alloc(new_descs_size, LOG_ALIGN);
@@ -1198,6 +1206,7 @@ void __init setup_log_buf(int early)
 		       new_descs_size);
 		goto err_free_log_buf;
 	}
+	memblock_mark_inspect(virt_to_phys(new_descs), new_descs_size);
 
 	new_infos_size = new_descs_count * sizeof(struct printk_info);
 	new_infos = memblock_alloc(new_infos_size, LOG_ALIGN);
@@ -1206,6 +1215,7 @@ void __init setup_log_buf(int early)
 		       new_infos_size);
 		goto err_free_descs;
 	}
+	memblock_mark_inspect(virt_to_phys(new_infos), new_infos_size);
 
 	prb_rec_init_rd(&r, &info, &setup_text_buf[0], sizeof(setup_text_buf));
 
@@ -1258,8 +1268,10 @@ void __init setup_log_buf(int early)
 
 err_free_descs:
 	memblock_free(new_descs, new_descs_size);
+	memblock_clear_inspect(virt_to_phys(new_descs), new_descs_size);
 err_free_log_buf:
 	memblock_free(new_log_buf, new_log_buf_len);
+	memblock_clear_inspect(virt_to_phys(new_log_buf), new_log_buf_len);
 out:
 	print_log_buf_usage_stats();
 }
-- 
2.43.0


