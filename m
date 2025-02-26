Return-Path: <linux-arch+bounces-10391-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB7DA46BFD
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 21:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9367A2CC7
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 20:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D149425D55A;
	Wed, 26 Feb 2025 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI/7btwn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D31B25C6F6;
	Wed, 26 Feb 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600389; cv=none; b=qB10aVfnW56ZPr2B7XH2NTbXG1R77jIiVfQXN/fvgPoMR0qgY/jkxFnJkAPS+XG9IISTT3WMpzBGkpiiyIKu4aWzEyGTNoXCx3dF3KtagavM7IKp+TGxPuAYEeoWvFFn1dQyoU9lR/eDU/zif6H1BGxk3+LTVJs/zH6wKLvwkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600389; c=relaxed/simple;
	bh=M5iM+v3BE6xddWKmrkHslf0oPFkrxg8orhL4OW9AAeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oYG1A8TS39t9jTZqaBiSBrsBFEddMnsABxuDQLRJ0/Q+zf51yp8XRDB4jIB1qRT5qtp4TY/rvloeTUiTzj2qKrIvzOZKqe6vcF06lGOPhveNSJcwX8CgWa6i3LY3o29fhohbI7zeIm8NLreSN/st83/AKeT4ZNcXZCU75KCU7eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CI/7btwn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-222e8d07dc6so4873105ad.1;
        Wed, 26 Feb 2025 12:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740600387; x=1741205187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ELYv+am9ZuaVjiWbWFLOkRsJsowJRkAsb1c2IjCc1to=;
        b=CI/7btwnRApQ+SWSowIj2GPzT+XPhsuXtIx2v8G0q2tgzutiTDj+zkWyqZKkvehAD1
         Bw01N0PZCDKIcHsLcJp+ylCyVfll41qOB3RXyW4vtefCxEpqsJIND3g3w/7EbXvXVHmd
         vxvQNdYHD10an4HzP+vw4EOMuvz7nyeNyYwGvFf4w5VaVRC0uTtSwn5edOXVaBu/LKOL
         nfq+e8fd6eFI2nHfGIZtlTRtwHMUaTwh2xZxxf9uBVXALmjYUg8+i3lJ0FUxSaX1doZk
         NKDob6H+K1x/DywErZpkZFw6ktQKH3xNlGsDz1D0gdDzNY80UDMUegmM/OR1bSDgwFWQ
         7RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600387; x=1741205187;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELYv+am9ZuaVjiWbWFLOkRsJsowJRkAsb1c2IjCc1to=;
        b=GzPqNuoiWYeYJ3LTpBuyNptW0tZGrfci5CrQVhf+DlxuP4xGRwFhdfaUzyLF3+Vn7E
         9/iUTrsIcwVVtDcdHdVN5eU6esjwZJrd3LZhbHeEuGuLcmiOVb13qs96XLFXeOGde0yT
         ARLuXc/ynv1ymqcxz1ZNAh3SeyUrdF+yyVXAVGKcP0p6gdSqABhvku8NqHngc9wwM7L0
         HVcSiAvmjnpPJkB+pRgXD4nAmILMDENUJzr8K+bpnNvl0aFMcs8Lwjqb2Ucdjpln/jFr
         5lYsoCGWne3o781nj5Li5gPCKTz4bjJCg/X7Cc9T8gtw2aXPMpBguIZP9RloMQLMLOjr
         RduQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/f01Hp8hWewAMAaGnEnZuJoUyze6Oj7if3ZtsJEpWf3KVqGMbLwAxarb8/hCZc+lbb3KZrrcA/8HU@vger.kernel.org, AJvYcCUf97Zf9uC5InqAMKl7Nh4fZMXJ5d4khRHAcBnAIGr7ZFJMBLBGm2LJM6mAeUrkbPHuEbgM9vM186dX@vger.kernel.org, AJvYcCUznwb4QxCqYY3esdDet3XaF7fOjMfOTtT4AQe/mlemDqeEsfxyPmsFl1Ik9PVGj+bp8F4R3BkrvmsHg2Cn@vger.kernel.org, AJvYcCWC/llG700Jxhx7mh4rMbWH8M9ZfJbXqh9iYCe3PHUYHp+09ILqhbFD2sinSweud2iCR6AAqL5oMEKXhJB4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9l0Oqsezp3QOYe4QfHms3oz6UiVp4wHIwhPsnuYga2UK5uZnH
	IhFAjWlba568tbHLu+vY0YO1lVOP8/aHBdYv9lAehMJua2L46quO
X-Gm-Gg: ASbGncuGUOJ3mh4zg6FP63dT4648DPsM3Bew8KQPRYeMBHhAjpe+1ANQJb1OOrV4FzO
	FxDOcsx1yD89ubjtcoEH8hA4oBdurOlmK7pKQ95ei5oqg2KblV5WH3UpBpyZn67a9J7RP2q/C5K
	DUFtg0l8gfsqHIBqyE3tWgBQt9UqD/zG3Q2nN7j65IEDI0Kji3dXKW+6cF81NnKkEUpUmj2gFOY
	v1gPEz2LZFNUlCEwzToigXrU6gA24BAcDhW1rvccJJRflA/nAjUOzaOJw+cFSBxyGtbngkbtHwv
	/eIOWwCFFH3N06/kGrOWtqYICbl5eM6RUSzvXUmSmPdAXxIy72aeT3iBeqXXBNQvf5nPp0XydVG
	DXSnl
X-Google-Smtp-Source: AGHT+IEF9gSycAUTpsQfXxyyfb4BCEiV6gy3DT9yWoYp/0qBCfPYI4EN3aEwUEcsNwLTBnte36b+ig==
X-Received: by 2002:a17:902:ce8d:b0:220:e91f:4408 with SMTP id d9443c01a7336-2234b083b0bmr8783675ad.22.1740600387328;
        Wed, 26 Feb 2025 12:06:27 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81bbc7sm3959455b3a.127.2025.02.26.12.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:06:27 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 6/7] PCI: hv: Use hv_hvcall_*() to set up hypercall arguments
Date: Wed, 26 Feb 2025 12:06:11 -0800
Message-Id: <20250226200612.2062-7-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226200612.2062-1-mhklinux@outlook.com>
References: <20250226200612.2062-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Update hypercall call sites to use the new hv_hvcall_*() functions
to set up hypercall arguments. Since these functions zero the
fixed portion of input memory, remove now redundant calls to memset().

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/pci/controller/pci-hyperv.c | 14 ++++++--------
 include/hyperv/hvgdk_mini.h         |  2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 44d7f4339306..b7bfda00544d 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -638,8 +638,8 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 
 	local_irq_save(flags);
 
-	params = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(params, 0, sizeof(*params));
+	hv_hvcall_in_array(&params, sizeof(*params),
+			sizeof(params->int_target.vp_set.bank_contents[0]));
 	params->partition_id = HV_PARTITION_ID_SELF;
 	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
 	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
@@ -1034,11 +1034,9 @@ static void hv_pci_read_mmio(struct device *dev, phys_addr_t gpa, int size, u32
 
 	/*
 	 * Must be called with interrupts disabled so it is safe
-	 * to use the per-cpu input argument page.  Use it for
-	 * both input and output.
+	 * to use the per-cpu argument page.
 	 */
-	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	out = *this_cpu_ptr(hyperv_pcpu_input_arg) + sizeof(*in);
+	hv_hvcall_inout(&in, sizeof(*in), &out, sizeof(*out));
 	in->gpa = gpa;
 	in->size = size;
 
@@ -1067,9 +1065,9 @@ static void hv_pci_write_mmio(struct device *dev, phys_addr_t gpa, int size, u32
 
 	/*
 	 * Must be called with interrupts disabled so it is safe
-	 * to use the per-cpu input argument memory.
+	 * to use the per-cpu argument page.
 	 */
-	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	hv_hvcall_in_array(&in, sizeof(*in), sizeof(in->data[0]));
 	in->gpa = gpa;
 	in->size = size;
 	switch (size) {
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 70e5d7ee40c8..cb25ac1e3ac5 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1342,7 +1342,7 @@ struct hv_mmio_write_input {
 	u64 gpa;
 	u32 size;
 	u32 reserved;
-	u8 data[HV_HYPERCALL_MMIO_MAX_DATA_LENGTH];
+	u8 data[];
 } __packed;
 
 #endif /* _HV_HVGDK_MINI_H */
-- 
2.25.1


