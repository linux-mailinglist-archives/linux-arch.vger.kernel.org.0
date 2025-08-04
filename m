Return-Path: <linux-arch+bounces-13057-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF6AB1A8DE
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 20:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D05418A3F28
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F02264B8;
	Mon,  4 Aug 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4FSADI3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C280B;
	Mon,  4 Aug 2025 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754330732; cv=none; b=Dg9eMX24HaL9UgggxadbTbRBZXaf2pDAZ7J4xDuMOArVAduK65IyASmoXx19dcw0hIkTFQP/ywEGa546gO5R8gafAOYSc6prw7hJaOqOSuUmeuIXaHwnSHwcU3OWeetpIe8T7yRh0VJI+tbqn9GoDOZe7l0keqGJn+7nxZK0RgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754330732; c=relaxed/simple;
	bh=6zTPG6d0vxCIFNEc4GTa+0E94i42BEKaVmM1da1i2zE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pGscxZgXdsqsMv/1WcLAEU46WxHB3fhTdH+m++Y7P8ypcVyztZUcH/8dB2i5rQgeGfr0Ky8ImOJJYF68RqfnBWrvmaO0HG4wiazaiLhdlFoCMsXaI12IWP4HrN5hnrcqzNV5AYAv9DByVxnCPowg/6McgrQk0p4QSY2NHmdq8no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4FSADI3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2400f746440so36630815ad.2;
        Mon, 04 Aug 2025 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754330730; x=1754935530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=piGXEg2/WNG2aCKVhEsJgjQz9/NiO37zp1kGcHP/kKs=;
        b=J4FSADI3hfqy6nYzJOrJkhEyXozKwJaX50WMj7SPPW0skIOJ0dbKE6hpenV5QjhSHd
         eTFs0tE/xfiCu4aJkQT0lQ87TR4AV6xNZPYRfHX9neKSj2mKDkby14OkScTrmx+SQI6S
         ZgJJAtiMgsw1djNdVxlbT7UWNCO8fY7VxQ3kiLdmx/Q7JtuUUC3omEiT4C4cVaYG4bbJ
         ZNEoG6Yg7VksMI6w210+JeK4lV5w6FovvjQlGSfnlOq4GRuL0T2qwS/C/heAX/sxTWRX
         bG5OVA4fwfeC7V7jEaxS4dZura0w15SBx1IN1fXDxhiUh2tXozzsOy3IfDap3IDreFL4
         4Rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754330730; x=1754935530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piGXEg2/WNG2aCKVhEsJgjQz9/NiO37zp1kGcHP/kKs=;
        b=gBc4S+mP8O3eJjyq8wHaG7d10TmqNMCMEQkETAOmRJn+FCph5C9Dwt9+IQYRGru7Ky
         FmcU/GQ7Zi1G2/GGAFFKXcinvgVj/BOPY/KCYbNEcZx2xXTo7rKr3QAYhVFocQ4FilJk
         YaXPSx/lkg1FwnCJELfv9r90bHQ7EzcGzT9Bd12X5I/LI4fV5viVtbL0t8NSylBpOcwK
         lqILlkEYtd+CU4YiDLyWrkiV6zz45mwLsspPn0Tn7Z/fyeYSU/K8r8mijiMkcf+ifszN
         oIsAWBGtLl0OhYxdjGE0KZ3xctlYLEfY2yytCSpM2d/iWl138Dea5oMEcxICly2dDjsf
         js1g==
X-Forwarded-Encrypted: i=1; AJvYcCUxldVxtiRqDGZvxqLhlnUBYNbNrPM/tT1DEWR1lLumU+2q9UayLvsP2+h3eQxkDfYN18WBklt2g7JRAgFD@vger.kernel.org, AJvYcCVwPriEeekgPr46EYgvXdPV7qJSNvO7q90iRjJ10MliuQuZ/XIqlCoREv5tWpgcjmHrAxWmDyP0rNS0Vs4F@vger.kernel.org, AJvYcCW6E2yTCP/uHblywEURtxskxHMcTgJaptLUNM/73glPZwWybA9XCvKysModfF04I158O9Gc3aYsQSqi@vger.kernel.org
X-Gm-Message-State: AOJu0YwROkFDBkbvgdw1vSl8w+HukKa1Qs8uowZxIwnKHhjzkBSHVrS1
	+Od01Z7gRulGwzGQ3fffoc9XGgNpvZDbORV7edM8zCL2z5xtH4WTX9yEy99Yrw==
X-Gm-Gg: ASbGnctLgOkE2GvzjLe2+0Mo2+1gbo+4z7qz0fd15m7XVmfAKxi4gsD9WPaPUUVcoi3
	cPgfPxvvoyo04oFQUzbbwBXsGq6As8el/euI8mGiCqb6qaMradA1q9wNQOtH8RQguM+e62/HkNE
	QsYbnxvm8y7fYpVA/IB40U/q2mABODWzUmFC52btfqacFWuZdtOvBcoJwGXDg90jMG8VUPuK+Wt
	MCmXiAnFNLj5yko00LlEIC20ZjCIDgr4fCozqVnDh5e5qNtuXydsP2BtZDqZzaGNfWenvQhiy5j
	ceHbQyXsxio6m56rw0hZZtYxGTxja4CJas/rrtR4NYkVBfkzhYAbIjpiy6bdvy/qFWj1pT1w4eJ
	7P7hBfGYOOCp+6kPdSalyJWlPW6DoahneMRPSs87ByfP9wjBd21Gw6DwLw0SgBiM=
X-Google-Smtp-Source: AGHT+IHgpaJ2If9iIHkMgpAt6naHSFDhIA9ilUDT5pGxMWywV8o4ihOwhDFFb8o35/LifB/RO+X3KQ==
X-Received: by 2002:a17:903:2446:b0:240:2e99:906c with SMTP id d9443c01a7336-24246f6b703mr152832585ad.15.1754330730058;
        Mon, 04 Aug 2025 11:05:30 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:6f:2b47:96b8:6281:35ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafb34sm114144825ad.173.2025.08.04.11.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:05:29 -0700 (PDT)
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
Subject: [RFC PATCH V5 0/4] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
Date: Mon,  4 Aug 2025 14:05:21 -0400
Message-Id: <20250804180525.32658-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 arch/x86/hyperv/hv_apic.c      | 8 ++++++++
 arch/x86/hyperv/hv_init.c      | 7 +++++++
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 drivers/hv/hv.c                | 7 ++++++-
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 1 +
 6 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.25.1


