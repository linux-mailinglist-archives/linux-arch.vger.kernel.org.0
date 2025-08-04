Return-Path: <linux-arch+bounces-13061-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D95FB1A8E8
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 20:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2306251EB
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1536F28D85D;
	Mon,  4 Aug 2025 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MruUN+ex"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C2328C2C6;
	Mon,  4 Aug 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754330738; cv=none; b=ivhWpXsqJhA5MVgv09fkwWVS11QDxKIra7qDNceLiOyXb/zRt6umDMGabl6cnqQm91ronlWk0bIiEUiq/32Qy4/plms5iLVe01Bt4AafLIhOLm5YpoPX1Re35H1F3zyrOe8R2P0H5gX6g9XXwTf9OM2KQmpcUyl0hrkkTVeXnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754330738; c=relaxed/simple;
	bh=ma/BQawGYoy7ITtIcGnWLTuLrZMFRrj4k7am8UwuYVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z0xvzjxegKPPKBgdLal0qxNglAr8WJh+qy7Lotih48MZ4ydc+1ycERYmV5XRI17uwAtFfugq4oZ89qEdoze7MnZkHCIm59KlK7jYF+pLVtflgltsis2r1Fj8Q3Q1dKtMSVFnnVUBczwNmaD1DQIDk9adz3HAxZ2pPxpFdRee8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MruUN+ex; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7698e914cd2so4811779b3a.3;
        Mon, 04 Aug 2025 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754330734; x=1754935534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7igQM7Vyn71nhVvSbp2kQ44aAuz9LFYWyrsCyPIgIw=;
        b=MruUN+exMXU9hwUWpJ6eaWZAciraELEMZINQXbSf1EzpFr3r3Mo0sqbPPDwGImyPFV
         O+1LEGKhdJmv7cf8IzP5rs6HszmX7NzCEMF+retfz250q/G5k+kg9j/poqVxtlRYIfLl
         Y4+RCti8c6bfHWiq29IP3/vjY5UsWsov32jrq/M8ILRgQU4nShW1hmcLOQ0egUgMfguM
         OwnMejXQmZ7qP14PlnA6yAIDNQwPS2GHqmpxZfxNNrQiaMsm39b8DFt2PhuQNDW+UMtB
         hRnM+eTSm6q6O3Auqhiw0n5yA4S7DDOyeLwhhnLfpzdm60hGMYmFvtfUAgpb572EZdjJ
         0OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754330734; x=1754935534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7igQM7Vyn71nhVvSbp2kQ44aAuz9LFYWyrsCyPIgIw=;
        b=Xi4rM3IlbbxR4IKcmheER9rQVR1ptxCx2UQN7AGzKOvqBeb7JjpiGWKYLuGQF7ugNC
         lgRAgQ/jwOz010STxNniwBKeWJEk3I8TveMQD2ANxCf95FLsI4R5B8KwWeaT+EPjj9lK
         LhCGbeQQJPv0PPhAgfkM+5ZJFalXi0BTW+41zpfMI3/4QUGU0xgrxroTwaFlJEgDTWO/
         LIj1smbAoce/9s/hSydv27gCqSu4F0tMz+h+qqLtTERF+h9vYo/8JKtwUyhzAszyycTN
         bMyiirevk3v4d4wrnO3TLidlu7Ztlplh672ztuQSYM9JHaOVuR6xtklgIos5uD07Wr8L
         zR8w==
X-Forwarded-Encrypted: i=1; AJvYcCV0tBjLNJrAWcNx+f1TIak6lfkLZfqc0lqmkEskdDFza9nwiNSXKAQMXIrRUbXeD4zzbRvrz8t9WPLZ@vger.kernel.org, AJvYcCVBCB3WzVASwZDynvgq5pHQyh+6TAAmDANKCTS2BU3JvDF7vAFmvvbn2SqixiKNr7BY6WM1z11J3pOjIPHk@vger.kernel.org, AJvYcCVjwWVNujkRxwOkHl/1RnYukhKZo2LL54OL78KyyNKujBroMNWLrXLgMeQZXYbQp9fmgo6GgJRqhARmPUS3@vger.kernel.org
X-Gm-Message-State: AOJu0YzxsMXT8y/mzXUfTtotyDAjRE4gJegOEvtqZ6wuBBgWgYq2UWJJ
	nMOsUYwKxSaXdcAY6Kae6clzm6GH2XpfL1BEUCWW4Z4ysbiZucNfFH3v
X-Gm-Gg: ASbGncv3SMCB+vJ57TonD9q3I1tvv3PRD7dsSn48O3ej6HD7n5c+BXrjwcmnfxxJzse
	T61R81+qAsH2InQ9buUfkG21KF4Lmw7rW4c3wseB6e4L21PIyddlg/gSPxEBiQqooAqvRcszIcA
	wP4wrA0wjUKFQeZRyJNDojw9jBaJZ8ATa5aI04ZD+6pXKZ3GYCgzhq6pX0fMtgY6BYcx+M3phaQ
	8l5DtKfVbGTn1O8GgenXwomMn+zSuu/EF04eNa7YhRYMwMRh/NVkTd6RkLzzUd8Z08qePvUryi3
	GXaUXlW0tznMmf3g/QitpwdPfH94pplfzBpF9d9ZDjhBQX1OajxyKNFchl4iMn9xwKJpAQi2VbY
	FVTt2uSThmkH6iE8Z40ddAtQvM7DzOiMw243aYQS4PtnxX9MA5YmOMzXj57dkkyA=
X-Google-Smtp-Source: AGHT+IGEX9zQZ5yxqfGeWSNgESIzLOYxk4xxDtXRs6UBqCAGjHVyhfsKTVyBKHiF1X2tAvOh9Cxw6A==
X-Received: by 2002:a17:902:fc45:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-2424704958emr141890485ad.46.1754330733691;
        Mon, 04 Aug 2025 11:05:33 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:6f:2b47:96b8:6281:35ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafb34sm114144825ad.173.2025.08.04.11.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:05:33 -0700 (PDT)
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
Subject: [RFC PATCH V5 4/4] x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts
Date: Mon,  4 Aug 2025 14:05:25 -0400
Message-Id: <20250804180525.32658-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250804180525.32658-1-ltykernel@gmail.com>
References: <20250804180525.32658-1-ltykernel@gmail.com>
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


