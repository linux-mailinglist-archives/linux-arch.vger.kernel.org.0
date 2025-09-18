Return-Path: <linux-arch+bounces-13675-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852C0B856F8
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 17:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA5E7E16F1
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580B30F541;
	Thu, 18 Sep 2025 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX8f40vZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D630E0C2
	for <linux-arch@vger.kernel.org>; Thu, 18 Sep 2025 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207681; cv=none; b=XmK+xWkIeAPVGE3zLTHZDHBRG9ZJvaznrBAGqtpA6UjUlCB4UnwH6cMpfS4PK0t2gUUIFJd8Y1qzvRxipBb5KtXfI8oJ8P/oTt22NyJFJ9yOOkXctFASpjPQVmbB5Ank5DUE1qarguQiRFJccOvd7MHUqk/K/ULowyeSDdyRQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207681; c=relaxed/simple;
	bh=eVQr/Kx6NZQK3rRjt7zFL4OZxVMPYo8FaFD5GEZkQVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A9msGjFHLQgOlh/Udcy55XqwiGTzbb1K85qA6Hwrfd7hWHWa4w1koCCqp14ji9/EV2dNZ0BiZJJOkr4sin5dGUaGgwNnkVF7PerOmT02v9rflC+TfffU38yN84f8yrH1Me4xFUBIwo6sB2aUEb81XvDeI9fMWPAJEx/2fytfhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cX8f40vZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2570bf6058aso13980655ad.0
        for <linux-arch@vger.kernel.org>; Thu, 18 Sep 2025 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207679; x=1758812479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dG0jro0uTdkJs/pzarvH7pNTSG+qtFn+7rA2b+WmfoU=;
        b=cX8f40vZbQapzX8D1VSxwmrNjoJxNqWNoWGiLwgrBITmSpWCQ9mMTGvm8YMY6vr5+7
         R4MHIIzCzO2a9M7drYcChZlBox3pBt3vVRY73tcBDsPnJo4YDYMy+jrqFn4AyIfuArR1
         e8uEDu22+zLsZYgymsdiCIpzzpMj/J8ezH5yImJiK/uLGbDcKjMzWvQOkifL7njLWE7W
         Dvi/rPT5fgfhalEi0gIty3B/p82ZTftPwXFXB82tkuk5mfmIY9GKQ0wP2XB1qzo9gpfQ
         3xDn7k4+avHOD23KcDeTwGldoKQ0yVUPKTshsQLZBvARrrCMBbY2vOliDScv/YKe+1BD
         hntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207679; x=1758812479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dG0jro0uTdkJs/pzarvH7pNTSG+qtFn+7rA2b+WmfoU=;
        b=j1gJb9l0pl2Y+Ib7GoRKE6yFkmdTfdDFx4JmoH73e5wMw+Axq6C/h7yBwmhzS6Gkvo
         NK4rE86Qup6i1S8MMk0nYxbqaXIUMqIXeBIipOZtkDA7/IQPCK9Ob67Cijytcx8/i1ki
         HLWK5gpmVKmDUB6bIaXbOamzJR1/w+q+InwJweQDFZ0IdHjqxlUwfcqDyeJBdBQJ5/0Y
         wV1146ADYowPRLLfl+Z0x/pGi5Ij8Glv9QrSKpwGHm1BNZb/KspMrk+Bgza+RXWTIisM
         RINm+QBBPpKHb782JByr50jYsoKgnugMBmxw2SnRLiHcYVbFj/8MN0aVwCanO5nDb7xT
         xlxg==
X-Gm-Message-State: AOJu0YwuismehucEumywi8y9YHshU6TefXyxES3YCgpItL2YfNFyhwk3
	0ZUb0cG3MbTnhPfkZsUtpopfiZBqhs7q5GFUtvXUae2LA9/NRBlAw2++
X-Gm-Gg: ASbGncu38zdxPoGOaerDmQTqKKKsDL/CoQoRx+GUPyxYRveSvO64c+A/bmK+2UdVN4W
	G461Jw/XqWOUtFtZW3rvLH/NDa7vqKCFtY8G41CDDnrVvspK29PQUsNzYVBEbSiTRcdvU1Rt4Gl
	3ghxFNLOtPhG7FKP2jzlZ4V9oo/CxVwR8zA/t+LNotlLp7sbUSTDYIZDK3hDBodBxMAj911UFX4
	+0nf2g1YBHSKcC6NfqPmiGUgGBBpw7qY/XWTqPNMvp541iVHKwS1vPETMw3dcNCedhM2ZZEtuSd
	HcMxpbCwmN6sDnJRtumbaTQO0RfryotTFi83AhAhmxStSNPlHtNuaqodp7NVg2DcEJ2n5HKRy8L
	/oOV2rwa6dspGyM/R8yFY07G7yBRXN8FyjI/XG6mc+E50pkzs6Z4fu9dMOOBBF2LRRZEHxprC7m
	oL
X-Google-Smtp-Source: AGHT+IFLnIbH2uyT2zEhKLQLVqmq/YgG9sNgP7kOLxvII749sNXuGepABW+zJ4LvDcTkJfKXX8GKWw==
X-Received: by 2002:a17:903:124e:b0:267:cd93:cba9 with SMTP id d9443c01a7336-268137f318bmr84863505ad.35.1758207676944;
        Thu, 18 Sep 2025 08:01:16 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980302b20sm28425005ad.101.2025.09.18.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:01:16 -0700 (PDT)
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
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 4/5] x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts
Date: Thu, 18 Sep 2025 11:00:22 -0400
Message-Id: <20250918150023.474021-5-tiala@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918150023.474021-1-tiala@microsoft.com>
References: <20250918150023.474021-1-tiala@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Secure AVIC is enabled, call Secure AVIC
function to allow Hyper-V to inject STIMER0 interrupt.

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index afdbda2dd7b7..a38bb96c9f5e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -133,6 +133,10 @@ static int hv_cpu_init(unsigned int cpu)
 		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 	}
 
+	/* Allow Hyper-V stimer vector to be injected from Hypervisor. */
+	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
+		apic_update_vector(cpu, HYPERV_STIMER0_VECTOR, true);
+
 	return hyperv_init_ghcb();
 }
 
@@ -240,6 +244,9 @@ static int hv_cpu_die(unsigned int cpu)
 		*ghcb_va = NULL;
 	}
 
+	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
+		apic_update_vector(cpu, HYPERV_STIMER0_VECTOR, false);
+
 	hv_common_cpu_die(cpu);
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
-- 
2.25.1


