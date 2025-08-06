Return-Path: <linux-arch+bounces-13074-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9234B1C2FB
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 11:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D073B54ED
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3AE28A1C2;
	Wed,  6 Aug 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="locdVZxF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54F2853E9;
	Wed,  6 Aug 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471492; cv=none; b=L9Sq8XgQ3U6BW/oWJs7di3rwfc1xywZGVvdUQ1/eh08zyknhDxHyH4vz6WJskucHmZrofe5kt7fbN6dOcH0Tcw55OlBcaIOjWv+viEJG0c6OeyIbjlFeASsOmQrL0rj6exnUlJVmtlxy/jeuIZbkLO8/eRNxmobpB+DjxQ+XSEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471492; c=relaxed/simple;
	bh=vKuOYtp6YZBXgP8BThHwMtVBIlMmu3vdYk0HwcsjlU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qEtcyxo+Xo+xWTXj8pIfu4gLOAWNi9npesWPrJRpqCNbqE91yiZEuOu7mOW+kdVQziaaS8nBaV9Gvw+oSDJfiKS7CHlQCTjPuwaFLEyngsJ0doAvs98D6ZLJNctlaGg3v16zO6n9KgRTqTe8n7t8ynqr5JFm5pwohKSo/oJd7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=locdVZxF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31f28d0495fso7010619a91.1;
        Wed, 06 Aug 2025 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754471490; x=1755076290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kf6IARDG517Ct5jbga64hLa45ctk+jQVP+7WfAPSUw=;
        b=locdVZxFBBRWWycKN6xFz4v7GX0qiN4DIT8c7DYKDqfc+T5iXwizpuETViLbglR/gk
         Ru5KaANCoxM3wOBh0nseU0Uwc++C87d/OQUtVM9Ts0tOSB/fh6G8GMNrdfboTtNzthUy
         qx9AT8raPqcBQTdXDfOku+ezV8kDp9YE6v0F4/Hd9RPGSssVKag3d/6pYWH14b/TntCB
         5HYof41EXZbVPbT997wDAs/bh9EoXJmP3W6tRAJNrhQZ5b/UOtyrxAj0YUG9duFEhjGt
         QEl9WPqpQRMNSNfQG7cxgTXGjHbgGDf1lkPD/U9n9hAQnkzD7fQulL9dx+2jFLFlRsz9
         ZJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754471490; x=1755076290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kf6IARDG517Ct5jbga64hLa45ctk+jQVP+7WfAPSUw=;
        b=bNY99PgOFR1DwTp5n/X29YBMCtSNuXU7GQP1Dd9F5cBo/chN95O+rA34FyIut1aMDw
         MA/TDZY0rIfazAbET2ZE2HkMdW32Rn6L7Y1A4W+bgYWI/nn6Qxv40Mi3RCAXuoojWQYp
         l65lBSMVrLkfbE7CSwJ3xH+IXYZJ5wuxbRJkit+VgCUbtq1TB7mQ4I2TtwcSxRymRJBA
         15NEEdaqAUoLCsCRuHyHUjiVnUKaqwrg49rDfr+FvHZF7xT8g6NMwUfWNEQelszlRdfn
         Dj07QhWVkh522IhJQin3zAAH4C4Cxo6O40hmk7w2y/hyzJHvzZmQ204ggz2bCb9kG+MZ
         4Ggg==
X-Forwarded-Encrypted: i=1; AJvYcCV7w1/h9rAeo1wJCOedmRjqSyTspdziYFmzMvwkqhjif/WUS0+p8+ChUUu/d+iyrlm5NAfkvJqG9A1Y@vger.kernel.org, AJvYcCVa3KZvELJDSBrWmFL6OWolqtroXT2z2OBdM1wV2qxPRJRFeLcfVVSF8RH4+vcwI6xGPC1SByniLkid16rX@vger.kernel.org, AJvYcCXWBuVVdAnJ17S+XNTmcmQAihRbU+W/yrThMmNSzk1fYuFGbt4I8Xe4a1XQIViugR7pi/AcaItnm6SXBp+f@vger.kernel.org
X-Gm-Message-State: AOJu0YyUm2XVNP1ipfaI7ClKDG7Co389pHtK0RxHXDcbMJjw3ZbiHz/W
	EBxMmMRvFAkFK2YUJw37lpGYEJdzlG5ub7ZR+XkSrykaeQSwE8X6HPSn
X-Gm-Gg: ASbGncsD+NVA0yuKr99VLYLzaJ0XsUXng9yAQh90/xAHzbB4weyPINAxJw3RnQXEY/U
	BfZ81jdwksVrxfT7GQ0sPc1p6L5exQOVlHa68xAxcuu+6UGYfXcbJxZtae8Oo+B0w+wkr3+D3jj
	WcvQeKErClDDauir2bxvGUzQk7Qsgc3ywA6aab+Xve68g/FQu6EgHI55Qv7BxqwKKJ7PY8vsJ2V
	2fhJONEqZaEC2ReLgWdJPVQn6/YNIoX/25Ll6sDFKPBpKDJblAqBjz489Unx/T46r4KYYgubStw
	TZ9p382Iiz68Mk/7mH/xuRZ+HO80j9dklKqAAHJ43qv6W4TSnFq8uBcUMi4ugWhPAB+eW/gQruO
	zgcVjFKVv+F3r+ko9cPpDGgx7xeb8UROS1cioY2iM7c4nkRc=
X-Google-Smtp-Source: AGHT+IGQilVHlVA2dIE1ddUKVLGbLOA2ceMyC1uuq+neEILo9enVsIFq/BAbqcP1IBQEHpAEv1Dnjg==
X-Received: by 2002:a17:90b:4a84:b0:313:db0b:75db with SMTP id 98e67ed59e1d1-32166cf0818mr2890695a91.33.1754471490012;
        Wed, 06 Aug 2025 02:11:30 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321612950c7sm2255568a91.31.2025.08.06.02.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:11:29 -0700 (PDT)
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
Subject: [RFC PATCH V6 0/4] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
Date: Wed,  6 Aug 2025 17:11:23 +0800
Message-Id: <20250806091127.441323-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

From: Tianyu Lan <tiala@microsoft.com>

Secure AVIC is a new hardware feature in the AMD64
architecture to allow SEV-SNP guests to prevent the
hypervisor from generating unexpected interrupts to
a vCPU or otherwise violate architectural assumptions
around APIC behavior.

Each vCPU has a guest-allocated APIC backing page of
size 4K, which maintains APIC state for that vCPU.
APIC backing page's ALLOWED_IRR field indicates the
interrupt vectors which the guest allows the hypervisor
to send.

This patchset is to enable the feature for Hyper-V
platform. Patch "Drivers: hv: Allow vmbus message
synic interrupt injected from Hyper-V" is to expose
new fucntion hv_enable_coco_interrupt() and device
driver and arch code may update AVIC backing page
ALLOWED_IRR field to allow Hyper-V inject associated
vector.

This patchset is based on the AMD patchset "AMD: Add
Secure AVIC Guest Support"
https://lkml.org/lkml/2025/6/10/1579

Change since v5:
       - Rmove extra line and move hv_enable_coco_interrupt()
         just after hv_set_msr() in the hv_synic_disable_regs().
	 
Change since v4:
        - Change the order to call hv_enable_coco_interrupt()
          in the hv_synic_enable/disable_regs().
        - Update commit title "Drivers/hv:" to "Drivers: hv:"

Change since v3:
        - Disable VMBus Message interrupt via hv_enable_
          coco_interrupt() in the hv_synic_disable_regs().
        - Fix coding style issue and update change log.

Change since v2:
       - Add hv_enable_coco_interrupt() as wrapper
        of apic_update_vector()
       - Re-work change logs

Change since v1:
       - Remove the check of Secure AVIC when set APIC backing page
       - Use apic_update_vector() instead of exposing new interface
       from Secure AVIC driver to update APIC backing page and allow
       associated interrupt to be injected by hypervisor.


Tianyu Lan (4):
  x86/hyperv: Don't use hv apic driver when Secure AVIC is available
  Drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
  x86/hyperv: Don't use auto-eoi when Secure AVIC is available
  x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts

 arch/x86/hyperv/hv_apic.c      | 9 +++++++++
 arch/x86/hyperv/hv_init.c      | 7 +++++++
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 drivers/hv/hv.c                | 7 ++++++-
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 1 +
 6 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.25.1


