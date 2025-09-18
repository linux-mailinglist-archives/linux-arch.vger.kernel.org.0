Return-Path: <linux-arch+bounces-13672-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54688B856C8
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 17:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D641C83DF1
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 15:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2CA1CAA7D;
	Thu, 18 Sep 2025 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnbL51My"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A09214204
	for <linux-arch@vger.kernel.org>; Thu, 18 Sep 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207668; cv=none; b=P/+XBEUpVMlPrW8Wn9IuU0rdmd5VnlOExvrlB4RCIMqhWWuGZthTpenJ6yF+3c0Xtok0/0Fn/4zyQcs8Elfmi8Dqt8QmTrzwex0yu3ZyYj25GZtr7jNufW6Ev9ZYB+pb8gjbK3hiZw3qn2+8aYkLBO/sE1APMaoh6VcS3Kq7uUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207668; c=relaxed/simple;
	bh=AHhSMOoeWjfl0vFPCrm0Cux2fhk1nlNWkzKPRjm+gHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VAf1Gi5lcEvjDNUvZa+DXY2kM8EVaBMuGZmK//JBK4S1vVnqfMXqEbi287ih6x6l2ewMQ8EjZCJMuOPaasxM4bcSW+mC4zmKSs7TsRJ5FynBlhheGM3bBAUSEjL4HWAlz8fDmPnK5P9Zm0Qpt5D6XAs+cLm9cS4FvNgHLKSEGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnbL51My; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b54f57eb7c9so589400a12.3
        for <linux-arch@vger.kernel.org>; Thu, 18 Sep 2025 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207665; x=1758812465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=71og1L1moGnEtlU3hPRTvSfcrOKYYypZv/voq78BbaA=;
        b=JnbL51Myep+r2FeN86BTbSqthH2ADfhbuRbB2eY0raq3hVyfIuglZPLWoE32xwOjGA
         KsSgSITKcBajErxgHC/daZJJMEf+eXA4UF/+SyWq5f44S4tIOFTz97tEfd/Ig+FjeCAv
         cnaMMfwXEIsw2+JX9mtCvLEksP82y98n5Xr+o8cMzT5pckYTWtw7SYr8bdwwF3Vfhxk1
         VZV0N45ZBGfNQumG7zfm/G6fBFaeNzDd8YVIT5qPTHAiuzDBlR/XK+k5CAIpRAZaJj/z
         0Xj2KCH3Q1Dww4odh5RAgTLmQfp0faSGqmSMNF9Kjjedu6w0HclhDuKqvrtCjxBZ0vFj
         jokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207665; x=1758812465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71og1L1moGnEtlU3hPRTvSfcrOKYYypZv/voq78BbaA=;
        b=FJyZpLFcFkEkFUdDWyiwvf0YPLl5/5eK5+khNfxP96ZrFCo7Y6x8QWle/6jGnXvq/L
         NR93J63++oTmDF0ajKIVn3L5mLEPlIGKjg8jGRpicJtzt/WaekOupjZecHFhN43EQjCP
         rWz022kbrGQ6RJElPBthl6Une2s55dMDM50XwKbjciTCXiYRe12v2tWcCox65e4G+l/h
         ot5HwT3d8w5I161AAIBCRXywwOzSo7bf1KyFp/rM/PdO4jBzZPRazLssieo5+8/vKdvm
         dnLU3wJbIb0h0DJ/aQ7ZnvwrmthtTSEtwb+VPIfJCmXjoJCD12yXq+lDd502ab2Hi4sL
         EiAw==
X-Gm-Message-State: AOJu0YyKH2iR8C+btR4ChBehhG3J7Q1kaRQJ+FS9cw2lE0meB3UILefw
	A5ZbRlq8F5Cgf7OftXbNzksV0nxDgYQw+thWicjvxyw+L3k1uW2GX8yo
X-Gm-Gg: ASbGnct77NG3SzsIHtHZphfArtHa8HYBT2VZNpMLLbbSm/9iQmOYuVJBz89IDJDIrHM
	6NtX1IRSWBGJQHqQKkXeEyCI9xehMakBgRbN1Cm/V51sLY5RCzo4pPCPvnFCBNFLBdQ6a021SCg
	kAmIRmhYSTrtuWI+0h1zierJIUrADLGQIkO0Bum1q7jSJIVZykjv+Pk0tMthPhptXzbfSnkeRGe
	P0ZQLkizejSOaYZ6khLvgIQ9wQ772ymzBjfEWwc1IdxOuSg9DW9plN+bOHh/b4GA+QQJuVvROiD
	E8Xts1eYwySnvzkSPG2CPviSn/bdDFQAFgE2qifr9s88HA4/nYOV41ImWa5R/A62DIXN1z3uSFF
	0pjhHP7H+cZ0mGDsUROdcz7NRVqtkWsZ8719ZDxw8pej+kq5/fT+WYEE7j6D75bPfhg==
X-Google-Smtp-Source: AGHT+IFF4QX2AbWB9fcEg1ekWHfAYk3ZX29fzrI+wOrqeGz5H2M50u4oTVO4eAHdSnCMCh9Ij/n/0w==
X-Received: by 2002:a17:903:2c7:b0:267:4b13:c855 with SMTP id d9443c01a7336-2681217a94fmr72904825ad.14.1758207664287;
        Thu, 18 Sep 2025 08:01:04 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980302b20sm28425005ad.101.2025.09.18.08.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:01:03 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
X-Google-Original-From: Tianyu Lan <tiala@microsoft.com>
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
	tiala@microsoft.com,
	kvijayab@amd.com,
	romank@linux.microsoft.com
Cc: linux-arch@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 0/5] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
Date: Thu, 18 Sep 2025 11:00:18 -0400
Message-Id: <20250918150023.474021-1-tiala@microsoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

The patchset is based on the tip tree commit 27a17e02418e
(x86/sev: Indicate the SEV-SNP guest supports Secure AVIC)

Tianyu Lan (5):
  x86/hyperv: Don't use hv apic driver when Secure AVIC is available
  drivers: hv: Allow vmbus message synic interrupt injected from Hyper-V
  x86/hyperv: Don't use auto-eoi when Secure AVIC is available
  x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts
  x86/Hyper-V: Add Hyper-V specific hvcall to set backing page

 arch/x86/hyperv/hv_apic.c           |  8 ++++++
 arch/x86/hyperv/hv_init.c           | 31 ++++++++++++++++++++++-
 arch/x86/hyperv/ivm.c               | 38 ++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h     |  2 ++
 arch/x86/kernel/apic/x2apic_savic.c |  9 ++++++-
 arch/x86/kernel/cpu/mshyperv.c      |  3 +++
 drivers/hv/hv.c                     |  2 ++
 drivers/hv/hv_common.c              |  5 ++++
 include/asm-generic/mshyperv.h      |  1 +
 include/hyperv/hvgdk_mini.h         | 39 +++++++++++++++++++++++++++++
 10 files changed, 136 insertions(+), 2 deletions(-)

-- 
2.25.1


