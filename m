Return-Path: <linux-arch+bounces-13073-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EA0B1C2F9
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 11:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEDF180E0D
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 09:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D728AAE9;
	Wed,  6 Aug 2025 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rb8lJEQY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F469289E36;
	Wed,  6 Aug 2025 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471483; cv=none; b=bGGsh7jnSNKb3AVe91VCeMZUx66OxPaX3duK5J3wG+hh/2yD9yQGo3LVPQib9vK8US3hLr00MsWnxDNnsFKftlND38CVmXfxgup3z6iObuP+FACbCCU2K04d8BuC7d5MqlhJT+l3Mi94bRwD33nWr2eDCK3tUtCqvfYLSxbz3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471483; c=relaxed/simple;
	bh=vKuOYtp6YZBXgP8BThHwMtVBIlMmu3vdYk0HwcsjlU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pJKbWIyb0GQCchwUuOkigQkeo128srbMIH1LJoWJq/orLkZF8uucvrPsWy+gFOkFHBHzqzmU7nSel813mWyxg+Nf7qasLKZLs2p5SBfGu7dpXIt9OP/DI8nLt9qpnHIdAyvlEHM4lJ2D+OXMjZZ6J5La3zJXN8ciznHrrH6sObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rb8lJEQY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-240763b322fso63765685ad.0;
        Wed, 06 Aug 2025 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754471481; x=1755076281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kf6IARDG517Ct5jbga64hLa45ctk+jQVP+7WfAPSUw=;
        b=Rb8lJEQY36ppeheR2VjiUEkkQWgFd+Z6h5QpDjV4b7iPHh1uhkQAIUnEo1YmR1RemO
         vcIs9bdgwqoVLj3ZZlV9NEf50ilUxokaYj3HrJR9K8OanKP++GP1SA84ufYEChrPPI6h
         2qhTe29/oCPPOe87l7eEf3XH+C9Ds20WcII3nX9EGbLJyQINF+uZztf/FY2+njeSBfQ1
         XPaYGA+afmCSMUglstmwlCw72ll1p4oE7iByFcCBkgQYUqckh5tiHQNjsm0L3lGmuJh3
         9BMB1GEGbQ5xOpm+fHohu3K5ayNusB+Y6K6SKVAVpjfK2zlnwlT9gAh1n9xIAU4cY4a0
         RKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754471481; x=1755076281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kf6IARDG517Ct5jbga64hLa45ctk+jQVP+7WfAPSUw=;
        b=eUq0UBxwSYThcU/R6DNbILqSSa3FsHXdGOo6HathVg/GIac1L1lQPFyPpVslINwwjQ
         cdnBmin16rX+CD6C7MzVn8Mvvf3o/fkEDB4VNokXpWWpM5qfNwti5C/6dmm2DVQ7e5Zi
         klXfO5SAhmoJxjKwYnvFsR5Gw7UB7YvVu0BvIFw3c9Dc9Gju18CWoYghmh7htkVRB7Yk
         0g/tx3Ccdc4qwWm/kAQUHrByp6/Vy4KC8WEZ59je9cwFW+ALvSjicHUJRDsaQBP9dRyJ
         ArOm050QqyWGSQ9dItXdRvb3xQrbIw+1W/mYHsiIgtFYqCUlmT0ivBQXdP3eps0yTpWG
         Giuw==
X-Forwarded-Encrypted: i=1; AJvYcCV0e3VZz/aSt0Jx4ioLBuaxZRqDCg8FwQh7UqaBTzOgMGhwJxYXgrW66uCbKSg9n7PmBbTDQd75ciDB@vger.kernel.org, AJvYcCVkA7tewSwjfdSupEv0gRRb65pmxcs1x98xvCBv37Ceo3trQ0tU64k34JauJOHqdz92dR6k80S6YXtAxK8z@vger.kernel.org, AJvYcCXh0NKK+l8i+x25S7hAfnnF+7FobqoENtF+kqQRdhzy6smbi0IlcQsShYEnr8Ok1CUNMf5TKUtIZzCsxnM0@vger.kernel.org
X-Gm-Message-State: AOJu0YxNRGbWxY4J00A7mzXf5le6l0LHi+J8rXfhIJKt2mI3Yphe4F7O
	yxCfCvah/3LxB+Spw9SqpDFq8HtmhrWQlPUyr9GK9RbU3zwaKEbuV85d
X-Gm-Gg: ASbGncvMnBV+Rntgw56L8QXPKkrysC7hslbtgo8n4kYv1EM8FjXAw//KHE6GEIlBV4v
	NvB71+5z2TPkhZjgLUf8+oXA4USvFH51QN/K+kuoCGGXaKM/RG4BVomT0wZNkIJqWaOaJvS8uMh
	dH+Gt0p18ByeSeJ0tpXa+OfNvcPnfCPvYJcrEBRfycXM8p40olwGE7thYWMwFDrPNczspmlRo5B
	kE5HL0ib1jx0sLycbqDQ5ttYluXMoDDgnzvS6QQe1YLkIYgg5ncXJb1ct8lsw3oR+HJvoNXkn/5
	8gP5bHcMVxzfjziQmB6HJs6Squug+dEd6wa7PWpg0cNcPeFv7iWQbpb28rD/egI7zWvGsIQnIWf
	el+PXcT5v4p05uYTrxVnYwua12fvmMfbvksccvu6D1giASrvwp+7VIyi3Lw==
X-Google-Smtp-Source: AGHT+IEFcGfxsQOL1bvYHv7yeqoU3MeOn7GiPgYjiJT0Uby+ZBBzhUnPSnZ5wfccC9nX48qK/goMPg==
X-Received: by 2002:a17:902:fc48:b0:23f:f074:415e with SMTP id d9443c01a7336-2429f2fcddamr25814955ad.14.1754471481192;
        Wed, 06 Aug 2025 02:11:21 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e585sm153183585ad.40.2025.08.06.02.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:11:20 -0700 (PDT)
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
Date: Wed,  6 Aug 2025 17:11:15 +0800
Message-Id: <20250806091119.441257-1-ltykernel@gmail.com>
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


