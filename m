Return-Path: <linux-arch+bounces-13078-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE3BB1C5AF
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 14:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD677A063F
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 12:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C06288CAC;
	Wed,  6 Aug 2025 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7mcyDtV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC170244666;
	Wed,  6 Aug 2025 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482741; cv=none; b=P+HpSkq67RVitWuwv8+vXwEJ49AExiwaEiM6JPCGBvPc/GKmAzug4QlWI5kB2uHLMMFVUYZTfY4Hvb50MB9nfoJYAPMCokFDWY6lVxHT4EtrkRh2dpNBlz7Cw3iKDZEE5cbfJ5vHaYHkTK8eYiUTHxOahcXPjg3qQCvtn9Z3rs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482741; c=relaxed/simple;
	bh=JNQsMgeNI7dyxfT/fCyC4blA7huvoyzVLHlWWVIRIkA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PKYJpLIm6S60K6GXmj2v56aATQsGXJSucu/oEIm6IRaI244vBKkGGkfaSniYSx10Oo7lj69TWLnt88H9DXzMwTNQ232ZorVfxqwquAIwSOyCA4CBQ9DZHt1XsYe7FWfwS666OiweQamhevUprINRypY3jFWDrfyr3Ze0+QyO6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7mcyDtV; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso5554302a12.2;
        Wed, 06 Aug 2025 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754482738; x=1755087538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJEj03wUT2DDKSynQwS/JODgRGzJkdVLdYCxcoigdhg=;
        b=d7mcyDtVWLmvK4/kWQrZD6QC1YG7OzOgd/9ena12X/kjSppKYLdZJnEEGoV5aE8kRF
         e2oS8MLUsMEg+Tg9CfmrW5oLpVymw9tgXZ+pVpLSankPw7wzFutXlAM7pi3+DH8NDAOJ
         L/+u/LhdS2QJp0CPowNigV6usV//XvH35hGf8m744OiSScO5MhrMNcr7Dqo8AJJH9NlR
         fZB/ai667eNbKmDAK6B3HQKTsg7P2iRi0IazSYX4lXveKpban3rw/vM3McGuTVBiuDGj
         OqfKp4pq0EdisCFGAc+WBuQz+Pyvz7w3kN0eUd/kEYuZ2t6FS6gQR0MSRlKYkK3dONW4
         HWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754482738; x=1755087538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJEj03wUT2DDKSynQwS/JODgRGzJkdVLdYCxcoigdhg=;
        b=YESr2Hls6Qi/g9+ofrPjUk35yhcNCG89tBNb+ylix04eNV7sBuoVyPCX3Ok3Ll5sv4
         WXsgYhY/rcvIi7lCqXDFSW1fMDacDZtRe45FX06zFcLzCZpyPoP8Of5GaFysw+m0vRBA
         50YumoQvp2Xf3RnilmrAamO2sIbgFu49FhO3OcJsrh2eoiq+Om28EAV6J/QeGG0JS988
         Rz2Ruw/+D6Ofa/5zXjbUJQI/fXu9Szh9oU49g/Kax+Ofab0dRjzwavUXZS9VhBDv/Viv
         4NPKzEsuS4qjiqQN7qTQjCnaFLiUfEvikqNLwc83LmSinYVcxMR9sSUcye5+FxRgjb2I
         1Zeg==
X-Forwarded-Encrypted: i=1; AJvYcCVUIcVg7cnTCZnT7iZYXotg6JGCgdOAx5pPWJ388kWsqXWYW31ayAAWT28daCaFwbck5l4/tw9EOfQi@vger.kernel.org, AJvYcCWKxbFLcJFH122UelySGH2966RiT7k5xwJUf7gAKPelS+mlLZ/dmwQvaPwSRPylc5spdq9j+/8qL8OLXNWq@vger.kernel.org, AJvYcCWQ6anvBudKHpSfjKtTgApVpDeQtlHiT0U9t7jhdPeY8yxKhugL91W1k074SFwRrFEcM1wFYs6cJiTW24nP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8nSS5qjZXOSUshCYzgDaxnxqhkCv+4mEfge18rN76sI9T6bJo
	StSr+WJw+kQYsnyubI4DGZiu1Krd1pDpyLMvVYicYIEUU5yn6fg+Ib5m
X-Gm-Gg: ASbGncsj2LeFMGd+0PuYeHzto70V8fcurOL9dD33HwP814gde6+toaRBU1KvfLqtqsc
	uXFlEHv4FLjMdNiUNkJM5lNk7MNbJIsQEbzZRyOIgXij7AWL3V5ntJSzRoQQPMTSxkCXivaRmqY
	q9KtqR/O+J/ULyvk+blamiV2jSJNbSFzEEkA20by6hjybcJvdLXZ0qyDDvGDkZq2zQobg0jOv95
	k+e963Hbg57ZtHy0buIfPVW7dIWlB3Ofjt8zufLbVa4dLNeiJIEU2bdpBUrdsj0tMl1Fiu2l2OG
	OIsX6UB8c02nY3sL6owXDUuP34o6D7haR8I2iIPqebmXfArc3lYXCNkN/83Td7aGbh9Nw8L1t/K
	ANrGh1ZNFwcmZE8ktKeB8HLG4kL53fDcFJ1Lxj8TeKi2VruQ=
X-Google-Smtp-Source: AGHT+IFGvUmDzJ4btSsp7PGF2GZSSPgyl9tnATzWAWjkrTfUzcMGL4Q4pgNozfJwSoJd3KyNBb2biA==
X-Received: by 2002:a17:902:e850:b0:235:f078:4746 with SMTP id d9443c01a7336-242a0b8c8c8mr37982505ad.42.1754482738140;
        Wed, 06 Aug 2025 05:18:58 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e81dsm157512705ad.46.2025.08.06.05.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:18:57 -0700 (PDT)
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
Subject: [RFC PATCH V6 0/4 Resend] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
Date: Wed,  6 Aug 2025 20:18:51 +0800
Message-Id: <20250806121855.442103-1-ltykernel@gmail.com>
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


