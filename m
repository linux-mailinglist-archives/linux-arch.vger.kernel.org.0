Return-Path: <linux-arch+bounces-14938-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CD4C6FE9E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 17:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9651A4FEB54
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205692EC55C;
	Wed, 19 Nov 2025 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvo8Ljd/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9430377EB6
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567156; cv=none; b=F1vjn23ofLve4NdWUpYs/IBpGYhM4d0p6Fy/25a0cKbMXdJ5Fl2YGa5MwHvIOlkrGWL0pjvG0CoHDK/HLbjhEXmXEnjK2tyBaRcYXd2D449itAOfBZR4KaMwll+fxucJnXbD61c2h/W6UwSQ8G5wPhjyi/ztmWcexmLXebmoX+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567156; c=relaxed/simple;
	bh=P2BpXmRz69DL/Mo9gvHTNRnm0uC420IorTT0EImakDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+/wukpecLvgIVLkUO1sADH0ZUVlGvWsq/5LgvSqUEId7wKqiCGihAcwIxRNdOKjkl1gjoyHJTYi28DTvIX7PJK3z6l3ZqHYjvxwoXdmCeLD9WSqahCfHsaCNnM4Zj/Ui4pitZNnyHaKGMDykBMIqdMEBw417LUDpeyNqz12dcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gvo8Ljd/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so4677185f8f.2
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567148; x=1764171948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/EyDboeiBDU/UfklOwVUegNW3M8PrbX9Ov8/f+MrlA=;
        b=gvo8Ljd//s70Ad6SW76idmhN0fRup0Xow21Ym1r2UBYinVsb5JC3n8VBpMue/pLWkU
         htLFLuUG9II22JuzokqrUBl0FIowDCJB+lvn2qVtL1YvmFo7+wDaTYDGikVNNEn1YcH8
         Iuhzb3XiCrFIuROQ3mOZhNdTianSbsO+8pjZSfDIvE4fFYqNI8gtbghZ+usPXOFIq8iq
         i7U4tprdGjDoAg5SYQnep+sFOZ250TUOuoTa24+ZPpIoZVtyds47wZSiGn/keBZApxa7
         Pam02IHJfIOB0F9q/5d2km4Th7hREloIwrLIh/HTlXC2IOIcZEQ7v0o90NFN6ydDKPp6
         rVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567148; x=1764171948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/EyDboeiBDU/UfklOwVUegNW3M8PrbX9Ov8/f+MrlA=;
        b=sRwXpBxoVgo8Hqjb/F9FN2xCEOS59+kAp+muhUZkVAHi2E22X5uiegnUSaHxKyjKra
         dmDIF1hdVg6xm1bueTSpd0A/GVvRA8v5wW/B5ybLH6kiQcJrNx7kieYvDPec15XSFaOm
         5itiL4xC4n6QTJkuYwtuti2BJQ8nhFWZZ9Op+YPQ0j77EwMb4P+mu/f2plwDShjI5ehv
         IbP8rKDIEmrtEef58at8yOtVF6H7JVHqttp8X9BOhXFvglDcgN6UtXtpR4sJPsESz4mA
         f6yhZsZztrPglPke5QzPCFbZEiEtN+7NPyy2VkJ4wCJRR+HX/ATTKA2PKQq8b98FhBxC
         9fJA==
X-Forwarded-Encrypted: i=1; AJvYcCW1f7KM/ms82eFdZR6F2riIq4j5SdjywunG6hbs3GgSBGjs1qRP+Q0NDeDvVDBYT1V9Ad+zyWz0N4tp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4m/e2NZ1TuinQxWWxaCxGgtmxNISsAyaIdybjl5+kzsQriFgF
	G4lh05ZL0hZHn88h1NoEIDEx4/jTbkhQww0WK0HVTGf1LBBOI9DsuOo40Od1/13TF6E=
X-Gm-Gg: ASbGncscqBAUEQETlQe60AojBIvXHedr1mBYtLZsg8FKY4gl9m0cNG9qYncWWqZCT/u
	ZolW3MDkgLKz9PK4CtgCG9YMf1C3lKBGDH1wmrofMpe+XdhPiZOXHo+L7X42aNoUwfpdhQqaAIY
	BLM890Vx412Y0yRCE6F2NS8PH1TU/Qdk/vkYV9g2AAB5n42fAzlyz7lqrXeJ7pCE7wUkbGJ9iwG
	oeub1vqRmBSuFlbdt2ALwHPHrcYvE0lTm0xPEGKhz/W2BqjTPevBkL/elwmdbSF/SqO1QoUuas3
	buhJTQJ/8GWWxMrDQlgcKOLsgV10GSpUZ5Wf01xrY04/wqPcbo6kKPuKG5zJdCvw5rrW1Y7Ijy/
	qCDTO+W//tPy8bO0eJvQ86yxLHVnVrR0mSZdQYxe54+V2s7O4RQMgG88A2XQn16pp1wcwdnDsN0
	6pShBNJ0FXW3p5wYaq2yA=
X-Google-Smtp-Source: AGHT+IG3jCLeDmXIRQk0s6Z/im1uj+pkHlGcqCZtyflKDhFiJA87zd6Y92IL7f4uFHeiMPUMai5jbg==
X-Received: by 2002:a05:6000:64a:b0:42b:396e:2817 with SMTP id ffacd0b85a97d-42b59378468mr19534486f8f.40.1763567148170;
        Wed, 19 Nov 2025 07:45:48 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:47 -0800 (PST)
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
Subject: [PATCH 18/26] mm/memblock: Add MEMBLOCK_INSPECT flag
Date: Wed, 19 Nov 2025 17:44:19 +0200
Message-ID: <20251119154427.1033475-19-eugen.hristev@linaro.org>
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

This memblock flag indicates that a specific block is registered
into an inspection table.
The block can be marked for inspection using memblock_mark_inspect()
and cleared with memblock_clear_inspect()

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 include/linux/memblock.h |  7 +++++++
 mm/memblock.c            | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 221118b5a16e..c3e55a4475cf 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -51,6 +51,10 @@ extern unsigned long long max_possible_pfn;
  * memory reservations yet, so we get scratch memory from the previous
  * kernel that we know is good to use. It is the only memory that
  * allocations may happen from in this phase.
+ * @MEMBLOCK_INSPECT: memory region is annotated in kernel memory inspection
+ * table. This means a dedicated entry will be created for this region which
+ * will contain the memory's address and size. This allows kernel inspectors
+ * to retrieve the memory.
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -61,6 +65,7 @@ enum memblock_flags {
 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
+	MEMBLOCK_INSPECT	= 0x80,	/* memory selected for kernel inspection */
 };
 
 /**
@@ -149,6 +154,8 @@ unsigned long memblock_addrs_overlap(phys_addr_t base1, phys_addr_t size1,
 bool memblock_overlaps_region(struct memblock_type *type,
 			      phys_addr_t base, phys_addr_t size);
 bool memblock_validate_numa_coverage(unsigned long threshold_bytes);
+int memblock_mark_inspect(phys_addr_t base, phys_addr_t size);
+int memblock_clear_inspect(phys_addr_t base, phys_addr_t size);
 int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index e23e16618e9b..a5df5ab286e5 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -17,6 +17,7 @@
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
 #include <linux/mutex.h>
+#include <linux/meminspect.h>
 
 #ifdef CONFIG_KEXEC_HANDOVER
 #include <linux/libfdt.h>
@@ -1016,6 +1017,40 @@ static int __init_memblock memblock_setclr_flag(struct memblock_type *type,
 	return 0;
 }
 
+/**
+ * memblock_mark_inspect - Mark inspectable memory with flag MEMBLOCK_INSPECT.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_inspect(phys_addr_t base, phys_addr_t size)
+{
+	int ret;
+
+	ret = memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_INSPECT);
+	if (ret)
+		return ret;
+
+	meminspect_lock_register_pa(base, size);
+
+	return 0;
+}
+
+/**
+ * memblock_clear_inspect - Clear flag MEMBLOCK_INSPECT for a specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_inspect(phys_addr_t base, phys_addr_t size)
+{
+	meminspect_lock_unregister_pa(base, size);
+
+	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_INSPECT);
+}
+
 /**
  * memblock_mark_hotplug - Mark hotpluggable memory with flag MEMBLOCK_HOTPLUG.
  * @base: the base phys addr of the region
@@ -2704,6 +2739,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
+	[ilog2(MEMBLOCK_INSPECT)] = "INSPECT",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.43.0


