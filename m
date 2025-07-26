Return-Path: <linux-arch+bounces-12967-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4064B12AC9
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 15:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8433BD702
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 13:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765B128751D;
	Sat, 26 Jul 2025 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhDBAQ1t"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60AE286D46;
	Sat, 26 Jul 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753537378; cv=none; b=WXrwrVaB+yCjMDqO3fQY+S6feUalAw83/t5v2cE2oXuaiIrDCYb8ei+Jg64Wi2fHxk8EaS6kJnuIFUCTO1fr2ECfM3EKQSVa1qDbbmrUit7LygwgdXd6DtIu8mOH2Enl9wrkA9x7PjFA2/hLBkfMUqwaSyEpOP9kXQ2EjORDh4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753537378; c=relaxed/simple;
	bh=ma/BQawGYoy7ITtIcGnWLTuLrZMFRrj4k7am8UwuYVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUkO/YFkkWQ73tqliR2wvG0qCQXj/F1/8brAwoLbl6nNJTyHi9GcqBkgHdvhOOVhPiAONe9/L5dZQtTAc9UEwIbRYvzOW/Yv4AbEjI5e+Rfc/S+OG2wqVNnFAUXxz+appcqsdvhdinVVCLYeRs2OzyFHee2KuEjgRdiIZ3e/QmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhDBAQ1t; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso2755971a12.3;
        Sat, 26 Jul 2025 06:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753537376; x=1754142176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7igQM7Vyn71nhVvSbp2kQ44aAuz9LFYWyrsCyPIgIw=;
        b=RhDBAQ1tY5JPysUvfQlhNFeMEczXXmY3pvzCMemxM34hd8OpXyf+1fy23F8uE5md6m
         Zf/sCBO9+GeZ1rTDuoOheAnZ5wQk1yLwkiyexmnDjm9UYaSxmVdxJF6uTZgJqT5NTglu
         8dDmxifx3y0wrm8iSyCfNcXUM111Of+YZ27+5+XDRLq4JU6NvKs0AD+VJ9rTf31zVeQx
         AEO4tB4GIpYRB6jgb2eGkq2DxJkrG7YVgGOy0/lQ2SjdVw14DjurWt1K6HUNQNBMvpsq
         M9H4cYT85iFjDNLALKTLKbjg8RKVJQv180aRYDalt8tNHG8C10i56O/Hy7dWOQK+sQmi
         5Ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753537376; x=1754142176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7igQM7Vyn71nhVvSbp2kQ44aAuz9LFYWyrsCyPIgIw=;
        b=qrYSvXUzcXYTrmMOD03gD5dmBWg7h6J8pTxk/pdBc7WznGApdHlP0kw5HOuIDgEGIa
         Kdw1hv4xz9VF1fbXyHsPDQTGjrFugpybWL8rvFnqzfIbgUNppmDo640+wRiRfUTyKuNK
         lRxHZSeukatTq/bZ8IQ0fQP/tuDlGXUfrRsnzZ2iYxGl+2huNQbiTrBONbOoHPnr9JoS
         VU2EFqQ2SoovM9omlY/YOCPQfO/4BYlV/KTwKp2Q9T1IexoBghW1JgEkjDN6voYyzRD5
         ZN39y2752vvaDu1FpxVMuql/XCWVYy9kolV8J5Bo/Uu9dNOuhCrSlsSvUIkD9y8eAFp1
         ERQA==
X-Forwarded-Encrypted: i=1; AJvYcCUtU/Mwq0+yndUMBk8RsASdcZaH2uhq4XMN/NV4aYikmCGV6k+/xXN6zDkkbhAYEZkL67J5ABXn/V0CT7W+@vger.kernel.org, AJvYcCVvTXFlMNauhoznvKB/BQXvll1D2teSiXsJj/D/hBkC/tMlmknFEL0As/oV+WMJXOimlI5rOriRj5sF@vger.kernel.org, AJvYcCXqjWrpIrMAqRxi0l9UBYH3aNj7lAuq8NPfxDPLLmtcG0J/3nH5hpCVAw4FLrlpj+MbU85v4Uzli/oX3Mi4@vger.kernel.org
X-Gm-Message-State: AOJu0YwCnyA83g8D9NIOHALmxNgX1pz0AUmXsdz2SFiwpa7j9BToYdGW
	c5THpKg3lG+Vve6QOl4Rc50slMKCqEk8lrles/gSIG5YcJyuenQQ6TBm
X-Gm-Gg: ASbGncvmeONGqEEvr9odQtJr/GuiJwgN9dToTqBz6vK7+LbMe2iejnUAGNDSJ5UOrHl
	qDPF2Tot9BD1ufFKehw132am3PfSVFkpBnXlVisNBwC3uR/rprmIPuyXKnlsZnUdREUerlMI5Fl
	aI77BFeMa/gDHxydERfd+0FUsAKbNJqTWs2rHza1fhveqgjzPB1H77bmS722ayPz/xncJQpl6Eg
	Tq43HTZrG8PU0Dn34Vc8QHVhI8WVNOvPRZcRihv4UvoFU1v6deVcNXvv7PmcjUxvhr8llk5bhOl
	7TtkPaIw/rxhbmmkd1kkDXORsT/LqNpUl943fnvilGyeyotnBLUye8YVQoGyrhXmAyeLK8d40s+
	ps3z+rJmEjZdldsHQjewasoDebYS8bKqgr/oslDIlr6SDB4YiO+xQNWGBL8qtGA==
X-Google-Smtp-Source: AGHT+IGykL3x0uCuxja/bgPqhGoOyWm/WxysnfAYTbQkxQLZoEShTNhvEthuDBcdTIEqtQJLd7SBjQ==
X-Received: by 2002:a17:90b:5804:b0:311:f99e:7f4e with SMTP id 98e67ed59e1d1-31e779fa061mr7768141a91.16.1753537376282;
        Sat, 26 Jul 2025 06:42:56 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:77:9619:11b0:a73:e5a6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83508500sm1869190a91.22.2025.07.26.06.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:42:55 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [RFC PATCH V4 4/4] x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts
Date: Sat, 26 Jul 2025 09:42:50 -0400
Message-Id: <20250726134250.4414-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250726134250.4414-1-ltykernel@gmail.com>
References: <20250726134250.4414-1-ltykernel@gmail.com>
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

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
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


