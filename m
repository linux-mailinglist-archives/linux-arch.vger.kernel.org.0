Return-Path: <linux-arch+bounces-12851-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614C1B09ABD
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 06:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6057F3B0574
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 04:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A61FF60A;
	Fri, 18 Jul 2025 04:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F21PP2Qm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AE71F4C85;
	Fri, 18 Jul 2025 04:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814565; cv=none; b=uD88c07uUeRxHRtLONfIU6YdSrR1XC31BNMpsdx6rdHlicQvD0IkLLlEb9o7kKel/RYUm43Lg+XJ0Zy4VOw3I0bou+GhkaBblM7GLTijc/V7tWxXoO7qqUfPymZj7Xt2N5ZUlDsBkKOlmCLyMq50Us/o3Q14pUvm5YtPsSn4LAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814565; c=relaxed/simple;
	bh=BKaWIB2wgYVNtYQhaONki9R26s0WjL2v0ItYEtgD5Fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpQjgmoUBnkgHczDmYCHGTMUnTR2A+cXY2fde1A95i/ms0+yn2mtvSRFRlsBlBGuW4eAUbcR2KY+YKFgjWqTU03iFTgw/EsWK0rouasGP7Hc6UqfPOLlOVfwGW//vQFxnkoPVoRWhI8dD+5J68Wp7NpH7TaMqghfeLoPqXyC0wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F21PP2Qm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso1730465a91.3;
        Thu, 17 Jul 2025 21:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752814563; x=1753419363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OELaLUArYgl6Nbrrs2otOCrr4yJAcP+COHiIGixloOU=;
        b=F21PP2QmDkAGCzDElJtz5bsTkmqBWH7iVD77e1386HNMS4cbJCdwc+uUdft6B+/l7V
         VFixLUPo1ABNij2Wa1ayMiGwjxCrnzcfV2LycknCMs0Qif3vzo12AXMOuuPrQxr0QQdV
         9+p2GAL0Cb7T/cWYRXf9+E3Ri4Yhoja9yEy98BQHgPuhuyBp1lLYmXBllnTZiCzN7A11
         SYYSE7P5L45F/PYdpSZ1+wUxfJAsQFbit3HXE8BBCGr3zd6WdqP3OfImi/pCJEkRfII2
         OyPkW0G2XsLAZ7KERRAlLDT+T+XoQVFbl+nBAoTGCHbFOZGJKl+rVt6HMX04YWPdjVKg
         4vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752814563; x=1753419363;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OELaLUArYgl6Nbrrs2otOCrr4yJAcP+COHiIGixloOU=;
        b=sfXADfW4dFbqREVM7Xjj16mVCesiEMNRwnlRGG8cIwX4l6J/snS9LE9j5Vzb3TwBDp
         7H7okc6FtvZldZM7PTMI44YKtN4THWaqiLeW5SS/12aQ5V0XODouj8LsVq+CVB002KIE
         djGtkp11cgLSUE4I90VUt83d1gwp63qSj4RMA/g4BFPY62GcJG8KWEdFV6Qp1rFiDH23
         2MNfxkdp/zyJRBaKKP+8FiUUzFKm/Gin0Zwaq9sB/yKXJ4YQ9/357El1d4llXq43ELZ6
         a8zzs23TOOAZNjhG4rqHqEBnDw5YINjuTfTHayqZH4TlUxuAXspNnCUiiJYs3qxLi/yW
         se5g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ96eToMeVDjN/OqU9+RR0GqeKrXGgGrWU/Zega91N9A4UgVCIT5etJmq3rPHMwW+7nInZqjR/wFijUXVZ@vger.kernel.org, AJvYcCVNM+hHv9+wXhRcOH0ZFx750aXzBz4BoWNTTURi/JVS/Nz0O27lpqfi7wJ2tkPfZkDc4xv+6UkOKiBt@vger.kernel.org, AJvYcCWSpiEk1FgahXrOMRMM0AcNd1am5UWYOdxxDJGngMbSSLfSty5EfjGnuc5ygVKUL9GPfYyL/4v93I6NmEUL@vger.kernel.org, AJvYcCXWWMiY0G40ig7+kvUySjtfnv8Wshi28zLDVm/UCekzWMl1E5Qbg4R5vcXZubvL/wiaG76tuJ0J9W7C@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoe3MS6/fWpfad0PRYSEuJw23j+ZommhNqbp1D/zVyWLXB05Mc
	3SC3nXa2G6aZEVUEvusepXf8NIKncH+9X+2fpl4RSUjuAi+qKL6siM44
X-Gm-Gg: ASbGnctw3I10+MFHw0UdMLo5hVGmRevWokxxKtiy7/qA5F/u651vmr6JH9uzyPZo3WR
	tCXAiLVU/IIwgyxLyUp0DWwBlRxambGF0q5pd0HfFrW5VNAXYU4nhTD9Mvnc4mT3knA6d8QROlH
	jQJdYCiWbw0OwL2HT9b93JBbN4+Y4OHd+mLV0q+MXfvP0WIVMTjxTdYzKxjiNQ8DIN41td1nRkm
	+3y0anuIs36prOcMg6OmzvJUAJo2LSDBHPsmCZrjtQsnlGe9mQb4SwMyg1+e0ise5DbttrmZ/WU
	ST/F3e+N3F4bI5C1XBIlqeaR78op+ZaYVafPwwEBqXRlK66UqP5nfNSU6vp4v82Yjs5V/dkiA4U
	4SfkK53iOTI6rI0JJqoNW62ANz/UhFAMDF4Q5XKe2R+ZYN8Ko0cGzrEqWVcVQ99IdWYYoWYBWVk
	41Aw==
X-Google-Smtp-Source: AGHT+IFB4pKgv+NsYZFlQrIsfY406acCVGR4YZib65yN3O+pU6FCfbS2MibN7/36bzl4d5JgsYpoAA==
X-Received: by 2002:a17:90b:2542:b0:313:d6ce:6c6e with SMTP id 98e67ed59e1d1-31caf8433admr8045510a91.8.1752814563364;
        Thu, 17 Jul 2025 21:56:03 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc33715b2sm476907a91.24.2025.07.17.21.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 21:56:03 -0700 (PDT)
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
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v4 5/7] PCI: hv: Use hv_setup_*() to set up hypercall arguments
Date: Thu, 17 Jul 2025 21:55:43 -0700
Message-Id: <20250718045545.517620-6-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250718045545.517620-1-mhklinux@outlook.com>
References: <20250718045545.517620-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Update hypercall call sites to use the new hv_setup_*() functions
to set up hypercall arguments. Since these functions zero the
fixed portion of input memory, remove now redundant calls to memset().

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---

Notes:
    Changes in v4:
    * Rename hv_hvcall_*() functions to hv_setup_*() [Easwar Hariharan]
    * Rename hv_hvcall_in_batch_size() to hv_get_input_batch_size()
      [Easwar Hariharan]
    
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
index d2b7e8ea710b..79de85d1d68b 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -620,7 +620,7 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
 	struct pci_dev *pdev;
 	unsigned long flags;
 	u32 var_size = 0;
-	int cpu, nr_bank;
+	int cpu, nr_bank, batch_size;
 	u64 res;
 
 	dest = irq_data_get_effective_affinity_mask(data);
@@ -636,8 +636,8 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
 
 	local_irq_save(flags);
 
-	params = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	memset(params, 0, sizeof(*params));
+	batch_size = hv_setup_in_array(&params, sizeof(*params),
+					sizeof(params->int_target.vp_set.bank_contents[0]));
 	params->partition_id = HV_PARTITION_ID_SELF;
 	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
 	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
@@ -669,7 +669,7 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
 		nr_bank = cpumask_to_vpset(&params->int_target.vp_set, tmp);
 		free_cpumask_var(tmp);
 
-		if (nr_bank <= 0) {
+		if (nr_bank <= 0 || nr_bank > batch_size) {
 			res = 1;
 			goto out;
 		}
@@ -1102,11 +1102,9 @@ static void hv_pci_read_mmio(struct device *dev, phys_addr_t gpa, int size, u32
 
 	/*
 	 * Must be called with interrupts disabled so it is safe
-	 * to use the per-cpu input argument page.  Use it for
-	 * both input and output.
+	 * to use the per-cpu argument page.
 	 */
-	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	out = *this_cpu_ptr(hyperv_pcpu_input_arg) + sizeof(*in);
+	hv_setup_inout(&in, sizeof(*in), &out, sizeof(*out));
 	in->gpa = gpa;
 	in->size = size;
 
@@ -1135,9 +1133,9 @@ static void hv_pci_write_mmio(struct device *dev, phys_addr_t gpa, int size, u32
 
 	/*
 	 * Must be called with interrupts disabled so it is safe
-	 * to use the per-cpu input argument memory.
+	 * to use the per-cpu argument page.
 	 */
-	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	hv_setup_in_array(&in, offsetof(typeof(*in), data), sizeof(in->data[0]));
 	in->gpa = gpa;
 	in->size = size;
 	switch (size) {
-- 
2.25.1


