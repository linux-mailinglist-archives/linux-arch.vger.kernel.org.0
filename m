Return-Path: <linux-arch+bounces-12900-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D643B0FA9C
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jul 2025 21:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519C13BBA2A
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jul 2025 19:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B377C204F73;
	Wed, 23 Jul 2025 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsgYJHcO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC74D599;
	Wed, 23 Jul 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297395; cv=none; b=csQtXMQlTYKRFSK0AtbRvaB8vO7dRCW1hvP47gnEogzVzIv2D5h3H01EJnVabn2Ri+omC2A1JSGaya1a8n0DWA4MH9CSzIjR1F1Rm7ab9pgoTAleDbGMlbhiEz+EbDdCBjiEZRS/x9UXmbLURsoCvDVRib6ZfBoUuReVcC5XiW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297395; c=relaxed/simple;
	bh=spmKQDYGe2p977LC0xDuEuVxV69c+OH9v8Ui0avfaRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C0f6bpygpD1RTH7g9RbT4F136vfgpKUZmRpYOMBnNY7rmJoU1heSI5Xi9Ar7fFlihKgVXg95/8hIL5dMG3qCbQirDoGZVTu01eoKRE5XEZQW9jkqvy9o2MvD/fxLrltRwGn1TjQm7q+hWsbZyxJwBR/Dui9eq4yub3PMG9A8syE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsgYJHcO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-75001b1bd76so190722b3a.2;
        Wed, 23 Jul 2025 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753297393; x=1753902193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq4Fcuggb54pCUskYuR+clah5MseRSL+VLsAddqENWw=;
        b=AsgYJHcOi4VOJ18zwgcB5ePKlviO3YCQC5j8j0tE0H/PmZYPBBrGwPI8/Qhr5NI3vb
         2GajtxY7I3obDgwn4UXBvskt8HqFGT/sfmCrlgJeLlfzB4qIFM8pGK7Jy6afQKoLBdUE
         eWjfAw4MTuJTZH3gxifyHYR4eEf5ItZ52Sao2BIx2CUvI/E5wKFxfDXV83llAwd3NTqt
         YdU9AsnwhrbgjwQbPxVAYiO15X1MS4/qHUKfxXfsr2fj1JH1o2Qjph2/T5rnAD05MnIF
         ++6AVZpO39P3MLIcQaBKAElplgZ+/scedTBwHfu5p1GXL5PVAJ3wngJEJbG08d9YVunU
         21rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297393; x=1753902193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vq4Fcuggb54pCUskYuR+clah5MseRSL+VLsAddqENWw=;
        b=UrSckzfXo1bsML0vVSl7Z3SGKkU0aBbXGRC1Z3eWB/k8XhCb8lLHK8V4uqUMMD1L7s
         ummyUVOBMM0T6gyvKLoNhufDhJAIjY7gawFmjgN0C4/RpiFfJQ2c5dbBvhaWR492pbia
         96AK2vXaPXXPy1s44LiNXfwgL9jlAeEbArVOqiwRwIcvBtr02Tk9FFvlpCYLjpj7Bvko
         kM6iTpXAICGWARkSjBiSbOQ78Lq3oduB+OssVEy9BTHWKEA3UknXJ/M9x/np/lfRhBqR
         pwizq0a1zlCa1Yn4f5N1BgaOH79DC7HT8HrD8P+m65jf99iy7vDW1C+p2jeWM2tuBwMQ
         BECg==
X-Forwarded-Encrypted: i=1; AJvYcCUSWGCjNytq/HZrr/juBIx6ab55fxAow1GDVRFJOcrXTOJcv4iBp7dFKo57op3x9FKLcH2oWbwQT+nfjU9A@vger.kernel.org, AJvYcCV4wUdZ7Hm98U86TaJ2q19EAQXEhmCysHz7BTAd7Shz/uh2VY0f6UdJU+rSiT2V+rRsnXjPeALpjlFD@vger.kernel.org, AJvYcCXIwaXd+7ut9LqJs94x2Xr8DvyvFeJ/y1pE5WFfPAnMk3X/Q+sgy0/jBU37xpai33+gEI64eEnY4wLxtyHp@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFCZVdPSUY2O1HiQ7pMAMXpBI6veHgThkPlTst5pcLs4C8Hft
	GUzHwuOoFhO4fCCPv6s0ciVBvebsCIeJZGe+ySQavSVqBsvqR8/KdBAYFh/YEQ==
X-Gm-Gg: ASbGncveBwYiRPYXPUReWOY36ju95LhbSXqNzDWJU7D6ku3CCpQGJVqfdSO+kH0Q1w7
	KTcigHTd8ZqlvIsEp7w1gnRYV4jTCaBNRTHDT24A6RyfaqNKcqfrgyLW7BJmCptr4kNWvk7zwXy
	NVqL/3m+Z7asS30nyU7kXBbBHzOJkUEs3QI1FJP7CJ66qqEOYNQ0GdotW9FGIrJa4i+DP8PINs5
	zKi64rr6HqN4Z17UQ4OQKLjMDS+DMSMUOAHjJEclHgaKXeJOzRfUJ9JVYAsPyMWBlHtEfkIvMo+
	Z+7U8ryzoCvL2YktkmBE1TT+OZ6+d6aIQ3WXyI5OmnfBxes5LQj6lDTGrfg/xHG04WcoqxgJKWe
	xATFy/ldB5JXBLDmKVry7riVwTPeicJVYj5rtTrrbqe32FZi4pPfsk9b7rYCD9YM=
X-Google-Smtp-Source: AGHT+IGIHsyisn/2KX1N96ANNxR6dC7yK4qz2awkEi9eq9XHvMkiuKb0SERkYBhXbxBzgG557SIWcg==
X-Received: by 2002:a05:6a20:160e:b0:226:c273:1882 with SMTP id adf61e73a8af0-23d49042066mr5615712637.12.1753297393269;
        Wed, 23 Jul 2025 12:03:13 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:73:51be:8747:b004:dd13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe653a7sm9513884a12.2.2025.07.23.12.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:03:12 -0700 (PDT)
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
Subject: [RFC PATCH V3 0/4] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
Date: Wed, 23 Jul 2025 15:03:04 -0400
Message-Id: <20250723190308.5945-1-ltykernel@gmail.com>
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
  x86/Hyper-V: Not use hv apic driver when Secure AVIC is available
  drivers/hv: Allow vmbus message synic interrupt injected from Hyper-V
  x86/Hyper-V: Not use auto-eoi when Secure AVIC is available
  x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts

 arch/x86/hyperv/hv_apic.c      | 8 ++++++++
 arch/x86/hyperv/hv_init.c      | 7 +++++++
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 drivers/hv/hv.c                | 2 ++
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 1 +
 6 files changed, 25 insertions(+)

-- 
2.25.1


