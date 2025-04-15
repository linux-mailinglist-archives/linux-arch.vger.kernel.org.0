Return-Path: <linux-arch+bounces-11408-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11EAA8A663
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 20:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F863B7F10
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 18:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A771230BC7;
	Tue, 15 Apr 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu/wpZHz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3941222B8D0;
	Tue, 15 Apr 2025 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740478; cv=none; b=p/uVeJbQVWgAuZpD5Fz414bSNMxLbV5MXZ40ivjgZWKRrfDkYka2qE0elEILew78oG/jFeUkJoa0W73wPWhqOZusDc21UK2qM70RthtUQm7F7aPYYD72xqhE/9JzxdDnHyaIKOTgLE7RArDN86MWoTG3mt0ZWNTNB+LOFTFNgn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740478; c=relaxed/simple;
	bh=tHvS4sD7u8RlP/7Sm+j33Q/6kIaZHzfT/DVYlUSooK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/Y8IeZr5vVghmXEUG+qqAQzbQ7xXIpNjkRJNSJYMBQKB/mDtcgVo4y4VQVmHzQDvV+JjoUr+n/66R/16put6ALEYS8zKScIzYRl8jkSYvIn3VA3fgkOB7Y73U6VrCok+RU7z6CDs/HVGBOY95FrOE94B+cV9w50x4/Nunx71w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu/wpZHz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2295d78b433so62135195ad.2;
        Tue, 15 Apr 2025 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740476; x=1745345276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4HcM3/w5HL+RHoej1RKlo/mHsgL2Lr/8Mc/iXAK+U3I=;
        b=Fu/wpZHznhRsSKdPnrKicF+WwrzrX42gre/vxClFLDIFma6EPmfLEqDgQDgJzgDQNv
         DXqljy8Ru9BvQlJ9SPGZrOjhsBGl2NnH2MFUMqGgwB2WwXFicrncyAKuxoCgmQjNLciw
         buEMYhqV7+cMTVlqqKGciENseN0AwmT/gPJJGJjmThbgP9I2XKH+hGq+PJQNUt4wOT8M
         BDyXn7cq6WisUApAz3mJSP+EJEXjHjcCUcuJq6d1W9rlKrYkWqug3iZEHDWJbywT1Ln+
         Kg82N/F7iWQr2qeG1mzng0VCAhA28jdkGrEysNeftfFv24jfEPh54+V2dQ9hMeQXBbk6
         qOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740476; x=1745345276;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HcM3/w5HL+RHoej1RKlo/mHsgL2Lr/8Mc/iXAK+U3I=;
        b=YqXFNNORUjvvmhRjSnoo6U2QdPe22xXcl0qYQWFvBBlBuZZmL0kkwbSF+glFZ0VGlN
         y7FeEv3uBPqSF5/zjyRYOI+kwrmjPRvSnwoXiLqhARViop3NPDgU470N0dM0owGVBWp6
         AG/5nXI7cONGGewjqssSZWjaaYSZQou7dxRPiHApIo09mMJXx/oWe451u59EByNfuYRI
         IZAwrh7n0CiYKVTzq+jR+s84SR+5P71c+MbT2FkYfliAohmiOxjqdn0IffTl4YRjVSI4
         VlK+/oNJnEvahbAqYrZt+ZggXUTXcqICOyxNcPkLOuRZFrqfUisp/OfWZSm8OQhVKvfq
         +iOw==
X-Forwarded-Encrypted: i=1; AJvYcCU32wGdt8vz1k0noeirZgvyN9tqbAPukb05L7wwDWCX90anufAMw6xtFwvQ/rMRh8FBBo4SweHRKkbo@vger.kernel.org, AJvYcCUO3ZMN9DARULvaaVZ5YoOkASzdLjbBc0Bu3Dg1q361mhtRxB9cM60rahZCv+JK7CGQ7dC04o7Yegse6fY0@vger.kernel.org, AJvYcCUaR2xXoABi0rjZdesvbCulvWpbif7S0XQKHhM8+wdbNVhh+eayAkvZmKOPnuCEoVUdP35lrm5ye/Y4@vger.kernel.org, AJvYcCWTpifQaaQEdqChiwphBCV4m9XaeXHIO7YBEy8Jodj/obZzmc/w/u3H4+YFQlQyWiVDuN6x9v3NArCEHAjH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw96PmgIWuw+PbNDgtkH0SUu+CFgeX4GMSaVIj3yUbP47+H+ZPs
	GPmkdtshP5f4elgswzbi2oCbDdBzWlndM87OkLIEyEDYxR4Si6Uz
X-Gm-Gg: ASbGncvQgHylMF38xrlqYTvo2s7tateGaC3eG3o0T+9vMufJGNm+qdUWOaI/cG2c034
	b4pke7G8TmGuDR0inw2P4scW+Tu+tHgyabvMohVJcsuDPWQ960PkwXnDDXoQ1rNB+nDXj5G7f6k
	yAhAYSRDQH9N7NTOCyaJLMthlBeMmFTLwseLiXrkMh3Gj0tfCKfl9CpIJEozXvQflMzXVcgPZUA
	pMXZei1FfqwKjgu7F7y3kZuSFHzDOp0jaV8hTolVeJX9nz3KmjSFOwPMStipnIK2EWm5+smDTBZ
	hA+vWyJGQWs1tcjz2VNhddKgAFDYX9M+6XwU8uIRYtPlx7zTn8p4Xe/K8Ek2crIQiVtcujYYjqo
	cHQEBveIDwBpT1/S0v18=
X-Google-Smtp-Source: AGHT+IF7nmoqXsUryR0Xgsda8/UJFBbejHAoiXc5leJyjQhDOw1gsSFxcS69JUGK9LMmq5/eiBrOKQ==
X-Received: by 2002:a17:903:1946:b0:224:1221:1ab4 with SMTP id d9443c01a7336-22c319fa063mr1640305ad.22.1744740476399;
        Tue, 15 Apr 2025 11:07:56 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb52c2sm120168425ad.194.2025.04.15.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:07:56 -0700 (PDT)
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
Subject: [PATCH v3 5/7] PCI: hv: Use hv_hvcall_*() to set up hypercall arguments
Date: Tue, 15 Apr 2025 11:07:26 -0700
Message-Id: <20250415180728.1789-6-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415180728.1789-1-mhklinux@outlook.com>
References: <20250415180728.1789-1-mhklinux@outlook.com>
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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---

Notes:
    Changes in v3:
    * Removed change to definition of struct hv_mmio_write_input so it remains
      consistent with original Hyper-V definitions. Adjusted argument to
      hv_hvcall_in_array() accordingly so that the 64 byte 'data' array is
      not zero'ed. [Nuno Das Neves]
    
    Changes in v2:
    * In hv_arch_irq_unmask(), added check of the number of computed banks
      in the hv_vpset against the batch_size. Since an hv_vpset currently
      represents a maximum of 4096 CPUs, the hv_vpset size does not exceed
      512 bytes and there should always be sufficent space. But do the
      check just in case something changes. [Nuno Das Neves]

 drivers/pci/controller/pci-hyperv.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e1eaa24559a2..32cceceff062 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -622,7 +622,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 	struct pci_dev *pdev;
 	unsigned long flags;
 	u32 var_size = 0;
-	int cpu, nr_bank;
+	int cpu, nr_bank, batch_size;
 	u64 res;
 
 	dest = irq_data_get_effective_affinity_mask(data);
@@ -638,8 +638,8 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 
 	local_irq_save(flags);
 
-	params = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(params, 0, sizeof(*params));
+	batch_size = hv_hvcall_in_array(&params, sizeof(*params),
+					sizeof(params->int_target.vp_set.bank_contents[0]));
 	params->partition_id = HV_PARTITION_ID_SELF;
 	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
 	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
@@ -671,7 +671,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 		nr_bank = cpumask_to_vpset(&params->int_target.vp_set, tmp);
 		free_cpumask_var(tmp);
 
-		if (nr_bank <= 0) {
+		if (nr_bank <= 0 || nr_bank > batch_size) {
 			res = 1;
 			goto out;
 		}
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
+	hv_hvcall_in_array(&in, offsetof(typeof(*in), data), sizeof(in->data[0]));
 	in->gpa = gpa;
 	in->size = size;
 	switch (size) {
-- 
2.25.1


