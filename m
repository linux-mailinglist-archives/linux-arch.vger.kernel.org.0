Return-Path: <linux-arch+bounces-10701-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11768A5EBAC
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 07:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4477B3B8400
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 06:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4831FC7F1;
	Thu, 13 Mar 2025 06:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSpA4FzX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6011FC102;
	Thu, 13 Mar 2025 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846774; cv=none; b=aCNZNezoRmZWxGPkOT60K+X3vpHQ5X7o2dyo/lb3E8TiNiPO0SGkSUkDqw8Ok0T8WAcAFd3EBGRDETgk9Dg8SAIBX3tnKEdgRX55RHMXF0pH9IL8cVzuNzH81zLP+u4VP853htrhFEPzRJ5tEZ51S3M2YMSPB2iLRGqqXo2p6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846774; c=relaxed/simple;
	bh=MBsWXYwv2VcUzCKC7z2YB1m56xcFcfFX3itPj/cZh6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZS/trw10Usf6IyNngVsEaxO6V8ssJDYwKBRqz6XUMqmsXH97C+VGnhonGmXUox53w0BcGX/u+o1MsueDdB2yB9Gc6plXZSTljjfGB/sXOuKHnCOOxeNVbyfJkUQjm9kgWusxglhEoVh8bbsz6POV4HJvPxivqJjT7K94bSqp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSpA4FzX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223f4c06e9fso10593505ad.1;
        Wed, 12 Mar 2025 23:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741846772; x=1742451572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oz05HLp3NblZaI9ceF6GSEmcnmK2sGIqBfO9rFYxlJw=;
        b=BSpA4FzXQvXzwGN2L0wDKhAEZWdVupd8bu+jCjQ8Fue7VgjNq9DpKpuOtoz5Z/6r12
         4+gdQpeOrwOA1Glet5LrrVdDeVyQXlog709LBvz3vTqayiqvyl6L3JM85bJItG2k8kfL
         K79hcLOasJxSkVeaQdw5PfhqAroEkrl6WovGpxtCHXq/mL3p71C0b1bRyIzopM2R55n+
         2L020bCOS+653GvqJOwfwB/aUHhtgs85VaNR6wcH6smKSJ7Fz59YyKvTfAgJ5T4HSiIA
         oznyC25iHdKZNX1WHJhgkCj8JxsAIGM7E+/N57p9MdfaF4JHezbRygZkHpZM0SkpRvFj
         KgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741846772; x=1742451572;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oz05HLp3NblZaI9ceF6GSEmcnmK2sGIqBfO9rFYxlJw=;
        b=m+4lMmGX4qEny8LoQseIqnPyDPPuX2duG963rBwL0bSiV2whguP6f7q8/uSaaV+wcr
         6XOT/pqGoFhyHbS2vtZTuKCgqWV3755Kl/piYJsd2oxpk6sl0+7h7UaQRtskXEeI89Hl
         WHN80anWe91wpFsh4Xz9GZwVOhPFYu3pz4jTvwtjS7ARUKmTqydOch2Enw3TP5LMQiUi
         5ACTT19oEJ0v3ojTORk1AvgweQzCGytPZN5oxDaruvstCoeufGXkLjU5zbgk4Yd2X+GO
         bFkg+TxpIJQluaaXlUdE7zBSAiq5Ev4Kx/z198igLOUvsbKFgxpoCwWQIi6fOSV/FgSf
         /WKg==
X-Forwarded-Encrypted: i=1; AJvYcCUZOjM1SwejBriAwhtuUqg5GI0zt3GpkpvhDc8oNYCz2mRb3sSwUXGI2YuSTaEIVVn4R5Uek5Vm++Jv@vger.kernel.org, AJvYcCVJGpD74I3czJqavloFgZlMgPC7XyuFHXYygTbFI0nw66iL/puOZWbU9iTYWD2v9jTDLMOFcFI2T0mv1aNj@vger.kernel.org, AJvYcCWv/tMzkiM4+/lOKlO/G5MWVKLpbwVEp92kKK+IS09s18pd16GPEIA6TDU8ZMzpf8J2yYTOH/Kt2prIi5dy@vger.kernel.org, AJvYcCXNxUPC+CT+pym1RT3Kq2SAWcaqtt0pw3ksDqEkVY0j3Q00sHsEK5HkDWxzRgrVbimgVhMdDKcqbvAv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxegsd2jluIVcIx+HtZfk54L6+V0UsbAEiA1i5J5GnpLXj1sj3h
	UAiHPiCNbKhyTHBb+AX5cpmPJaTjVYTxwa6XlFMRc9atu96N2j5b
X-Gm-Gg: ASbGncth0Lvd57PUrqbOeYRbG7VKRNr0Iv8GJ8i1xt6WqBNDYGbn6mu2L0YBVb+sh+Q
	Gb4hC5uKZKwoA2Q888vQTggJ05gEn0qAx23W7E4JK3CMVRipYXG4kMsA7qfacgvCJrvDufjKknm
	cnW8H4p4NdwRe7opGn0Y5sjG+adZN9PWVFp79yyK7kwQlc2tOgkTpWofAw1aoE8xqJV0M6FUEbV
	txa5P/HwdybfIcti2P47gzCZbc4I2InqrZSpK9JfoQ4lLwLw0/9ITmJslQN4O2x9BK6reOi3jFl
	9RGE2EVW+5XXMENAd5plxWou6//EPkj/T4ubRcKRod071zazhQXXnPpMugj1imzd83Utqy6bUR6
	MvAWrxAlkJv+y2CUasrLDcxQ=
X-Google-Smtp-Source: AGHT+IGWWEw4YJmPUWWdWOZCtx2jqKvh3NNjsC0GjhIUGfB2i9nD1wziWUWDOAcLHVhn/w/FyBZO9Q==
X-Received: by 2002:a17:903:8ce:b0:223:607c:1d99 with SMTP id d9443c01a7336-225c641e9d1mr23875815ad.0.1741846771715;
        Wed, 12 Mar 2025 23:19:31 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68880dfsm5856985ad.38.2025.03.12.23.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 23:19:31 -0700 (PDT)
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
Subject: [PATCH v2 5/6] PCI: hv: Use hv_hvcall_*() to set up hypercall arguments
Date: Wed, 12 Mar 2025 23:19:10 -0700
Message-Id: <20250313061911.2491-6-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250313061911.2491-1-mhklinux@outlook.com>
References: <20250313061911.2491-1-mhklinux@outlook.com>
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
    Changes in v2:
    * In hv_arch_irq_unmask(), added check of the number of computed banks
      in the hv_vpset against the batch_size. Since an hv_vpset currently
      represents a maximum of 4096 CPUs, the hv_vpset size does not exceed
      512 bytes and there should always be sufficent space. But do the
      check just in case something changes. [Nuno Das Neves]

 drivers/pci/controller/pci-hyperv.c | 18 ++++++++----------
 include/hyperv/hvgdk_mini.h         |  2 +-
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ac27bda5ba26..82ac0e09943b 100644
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


