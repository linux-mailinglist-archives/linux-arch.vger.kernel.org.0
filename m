Return-Path: <linux-arch+bounces-12904-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF3B0FAA9
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jul 2025 21:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D127B0FD6
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jul 2025 19:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F042343B6;
	Wed, 23 Jul 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSsudyFj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6164230269;
	Wed, 23 Jul 2025 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297399; cv=none; b=pXMS8+25DKanurQBp5NodlpE0dAmgdIoBhtpFBjPV/HKcBwPglkjurR0sk9C8MUyRaye3sGkdMjwl6PJDPIafoaVtoSKMhN2HKwxXtJOLkM+XzlYJY7S91ERPEt0Ow4lG7JqfTf326B5o54kNBZ/tisor/b+dMo7+zliJp1OvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297399; c=relaxed/simple;
	bh=rpgouV2UNlv5UQtAMZqI9RFffnu58ens9a6v7P50Ppc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R507GHurY/77QAN7NNgB/qdPiiD5vL8n59HvjuJV1TTuvbibPotu5APdzY00Yg+UW7mLvHIMhOQsYu6n94cNx3S4eUxHxkwVrDecGnX/2xjmGG86WnZ2EhL8sCuvXGgKj2kBatvBN9B8VPdcxflGEX2ILOO4HjWp6o814F8mSb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSsudyFj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so163613a91.1;
        Wed, 23 Jul 2025 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753297397; x=1753902197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qvz4eJix990MTN9WykLFHm3CC3XOPtY4y7Se1Ck7rzE=;
        b=PSsudyFjQQzkzUNNMr72Zyf4K0agKMCq7OE8Lq3BpaJI5y+J8NoH6dBm3Jlv6lNS5m
         KyBCZ+MYRiGtGYg2T38n+zBSBwX0v5O/m4pi8PVrUnE7sbznXTTvhGrm5x2IEdZppcRX
         hkfbuYx3aOhkG6XiwXWxxdZniqe7q3OcCq6VlWUeSfqYWs6g3e6BWyhnNwgcnYeK4fW3
         bA/yDnmF19t4c+S3ibwMuAfHAQOH+f7y/gpDl0MRp2llhts3VnpCPbWVcWw0SB4DwJfg
         ejQv3K0O/1m8jomO4uL2RSj19SRcN/Sv83xTo66RBBCX/DslEgU4H9qCh3zfzRvS0sIt
         9HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297397; x=1753902197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qvz4eJix990MTN9WykLFHm3CC3XOPtY4y7Se1Ck7rzE=;
        b=YomACPf9MmhF6YGrdhbR58hFauf5TUR1atJgifAZpz4gzuCT7aYhbZCdPyqo6iYyUQ
         GZ15jmXdjN+4i6o/f4Y0RYbg++w1qkV+xtjwUF7lChs0raIn+oH+6UfVVCtLdczAU3G4
         5UxU8n9RfAKtE4OjyGwW1EVT0uofzDRo90BBMRIFV6Pbi61Ud5sUaZPisyBo8P3V2B7R
         GufiBK9+/wtimdKfIbw1IxaVbYX9hrKVKavzPVdx/o5q1ijxZMeq6EBs0vZec5RA7c/0
         YFEYvIgZmWumFbGxe7i1qPgDyhJr4iO1G7gF4IblQ1OGGG+2yNFTWWL/ONpCVKaq4HBZ
         mJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3imy1vdwii1x6I46soP3BkVRw+lxB818jg5u+tR89gRLGVoTAFllTeQHlIaMM9prP9Nz2f6r274Mg@vger.kernel.org, AJvYcCWdehQSBnxsvYTlV6kdSrLOVxw+7QU+CVO55oXy9No7+K+2s2r18Tk1E5jFqV6XtBMfv20Bj6SJh/z3dTx5@vger.kernel.org, AJvYcCXJS2W/GooqvPKPxDBff4fQSqfduMHB5fNa2bb5J9iho+Cktk8wqin7Qa+kLv8X2kRDuy5sktzjzSX3dhzN@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/kveZji0ooRCSCHFJusUkLSj0ZXDCvQC/Mw314EL9Ep4cv7v
	6AL7DUpFy1ww0sU+1eQvkmFnIdB9hRrS9fjDqRdqHWmoh2kU+ZntMg7J
X-Gm-Gg: ASbGncuRD4mnhteiX+hSVZIF3/x0HJutuAwmcxxJEOcJMIC/GRM33seFF8eWot2OB/K
	496QjjPeHNYUEPuRqulnepKJ4ffqY/yik9Xm+4CxQsmH7NPkidrILDhR4rpSJ19WaZc0qb655P6
	x6etKFeu0fCU90nFMCKKwbBPot6sAPXqTXbmLwbNSJFZcmepsBbSV/Lse8SIggMDbH/3nIcbu9+
	Dnu1MIcoLPgTL/Q6gBI531VUNzDsbGgro+kFkNYI5HIMN4pASf2yvmT/HE8GKFQgKw2vezzx/ed
	AJFOwJRznblpn28VuxwnxHbdOT6njtFTz/Vi28ZY1HZPO9rhjx6n4OXw10wCHgYHpof+AvJCTBe
	o7216jgiBNNcuDesomJ/n1hp+RpUJoXsONDSEE3UZCiov4Y4cfdRf0ZaTJlcB6g4=
X-Google-Smtp-Source: AGHT+IFk2dGWLP3aTIpnshwqZ+XHgyeFd0zPZD5TT4GHB2q83SPzzRHCIVayY2dPEzhtAganyQZ3Bw==
X-Received: by 2002:a17:90b:388b:b0:312:ec:412f with SMTP id 98e67ed59e1d1-31e506ef9afmr6338751a91.14.1753297396988;
        Wed, 23 Jul 2025 12:03:16 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:73:51be:8747:b004:dd13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe653a7sm9513884a12.2.2025.07.23.12.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:03:16 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	Neeraj.Upadhyay@amd.com,
	kvijayab@amd.com
Cc: Tianyu Lan <tiala@microsoft.com>,
	linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH V3 4/4] x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts
Date: Wed, 23 Jul 2025 15:03:08 -0400
Message-Id: <20250723190308.5945-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250723190308.5945-1-ltykernel@gmail.com>
References: <20250723190308.5945-1-ltykernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

When Secure AVIC is enabled, call Secure AVIC
function to allow Hyper-V to inject STIMER0 interrupt.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 3d1d3547095a..591338162420 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -132,6 +132,10 @@ static int hv_cpu_init(unsigned int cpu)
 		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 	}
 
+	/* Allow Hyper-V stimer vector to be injected from Hypervisor. */
+	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
+		apic_update_vector(cpu, HYPERV_STIMER0_VECTOR, true);
+
 	return hyperv_init_ghcb();
 }
 
@@ -239,6 +243,9 @@ static int hv_cpu_die(unsigned int cpu)
 		*ghcb_va = NULL;
 	}
 
+	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
+		apic_update_vector(cpu, HYPERV_STIMER0_VECTOR, false);
+
 	hv_common_cpu_die(cpu);
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
-- 
2.25.1


