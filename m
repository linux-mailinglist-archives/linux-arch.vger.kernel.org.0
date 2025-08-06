Return-Path: <linux-arch+bounces-13082-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F14B5B1C5BA
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 14:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B347A48B7
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC3328BAB0;
	Wed,  6 Aug 2025 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5jeUesI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089B28B50B;
	Wed,  6 Aug 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482744; cv=none; b=YZcHSQpf3V0xJa2TycHBdIe9eIWj6ARDiThy/4OnUn3yq0ojf5kwLr+16jZCqNXSiKfKuC/mmyfaSjwG7ZjNIDmFj9MKeliKObdvajTNwNASB0m3UNPejlNIzdzfM76K98CWrnLeEARpgWT/x0LvY+GjdBf/30WCn8HWm5crbaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482744; c=relaxed/simple;
	bh=fQD5va3FLgNwnz5Y/3p+Iv4jlLgZJbBdD3Cs9ytq1aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=meX/KfDaulVu2Ht3kNQwwKCi7fnqEvXXdvXuO7rrVy6d1eK8fxlbmq812EEfO1kVVTEXoZ4Jn4BY1usXXw7qOZk0mAiMocrsdaenCWkcZS/6bVNl0XCET5vz+AlFSjIaO7N7lra8HEr5Y1OZX5HTldiLsRTuGuSkGdT4N4k2pRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5jeUesI; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b34a8f69862so4015904a12.2;
        Wed, 06 Aug 2025 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754482742; x=1755087542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJgF5PlTKEpMBduF+V4BQX8h7RaWsdri9v3vr/B/Jk0=;
        b=D5jeUesI09lcJf0mw+Py6uvO6686Ag7VA+cvdm2YVqnCtgXA4ozwH7JUj/ko8cnq7u
         jd0dEsKt0a6xe/wGpYXV0TSCUBkY89h/5/sCTn50/I56HgNEJw7D1xYPIOtzvALfP2VE
         U8464j8jVhKrX3lVEJllQrzPAwqYXnmXnUjOKaj7JhPfXUNplSqKZo4UW0ZDWaSmup54
         9k2CMzDNTMPJSxRj8SFLGijopM/M72XHA4rw+7dTU+LAZBMSMOXMeBIdb12oBY11Qcy9
         O3BTRm6h+0eJv0xYo7J/+GR1VomN5g6Zenp+kiZdPNpkhBCqXfbaxkXfKyRlWhzPzJiz
         sU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754482742; x=1755087542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJgF5PlTKEpMBduF+V4BQX8h7RaWsdri9v3vr/B/Jk0=;
        b=gkUarV1BjxMsj0J6gUiql1HWdsW3MnGzYyvHSTT1rVHO/D4aLnxO5dFjSjRw9EoQme
         0MYbUerFeqz6Wq7Qm3cgwG7I1kO+e2ZePIISB1InWxUoCXmnhWlQRfKGqinoEf/LBfdX
         LpeZngazcGkNvd7yKouQ1Hg9CQoVH07Q0CEsaE+xVRlhCtlrSDk/BPd2V8dezs44laoH
         CF9KJcgTy5oULwedmLOowzkaJQQEv+bWQGam7j9UsPPco5hHVYiJbhXA62xeTUXPRVgv
         JPShop0WVRncm99UgW4mcIuG1KUvpaFhpIHGGayu5EkIDs3MjJvJdnkSDOVSi80PYonb
         iqDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO3NyYAxOovYGWKCIgpY45hZQRapONhjSjoe1YQI3KBI1bNEFb502l95o1/5X0s6oF6FgJYMlrXZw6DWqM@vger.kernel.org, AJvYcCVhgWsOQQWPZfzDbxyuRjNWhm22fDd/0P6TXAcDSwUspwx7TsI8RbYzQdamhD7U/deXKh1kl82OU93G@vger.kernel.org, AJvYcCVxcwifwAWAbxd+u/cDLsjlUCfJrz5eFGdBr1YkKFPAGCNGegmICnh9qyfdkDiP7XMMpmuhu/x+0sEHKs3J@vger.kernel.org
X-Gm-Message-State: AOJu0YyZgLVc33NYE73S7n79rysE+XShQgTh9irbbjPjXCCT1D4VFqEL
	4DOy7xqt5T9D1chgF1qS9CwSUBdszAVX+r2YzmaX8L0Z2lz07s7pWuA8
X-Gm-Gg: ASbGnctYGFuF76p8JVC5c8J0JpuUheaS1vBW2HpmhNtsOg7i9c1OObKKgOG7JIWkYh5
	Ow8851i9ErrF/R7PbxWuebbcGQ53EUjJC1Ot5GuPVyAxSoNDX6LcyJjqwpEUiHB2TttOVEWaAkT
	HtjtjYs5bs2KoY2kctbesLv15ioIa2cQeYqxqpabV59SDROuTsHTk9+8JgKhs87dEid4tj7/39W
	ELFLIRerRnTpJWG7m85St4PXV30lUfbL2yd0Fxzz5wL0/CBWJaD72Xo75e6N/POp3vbfHKwuAi3
	jcPHwPrhc5sAWuCWpk2WHTJ7EdjYhZI65DdTrsiHz4mWpv1VyMyr2uhdZ48SwibMToo5XwFCdiA
	lvqLa/kXzO2LiI+EfIlQz95lf3XI0dy+zEBigKNI8q1Bo/Jk=
X-Google-Smtp-Source: AGHT+IFn3pqXg+FgY3dqFkUytqrevszprpq8fZlrYrzfhf7thHXIiuA5KljshhSz6MHWi97+seYKxg==
X-Received: by 2002:a17:902:db0a:b0:21f:4649:fd49 with SMTP id d9443c01a7336-242a0beaaf4mr33174185ad.49.1754482741945;
        Wed, 06 Aug 2025 05:19:01 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e81dsm157512705ad.46.2025.08.06.05.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:19:01 -0700 (PDT)
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
Subject: [RFC PATCH V6 4/4 Resend] x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts
Date: Wed,  6 Aug 2025 20:18:55 +0800
Message-Id: <20250806121855.442103-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250806121855.442103-1-ltykernel@gmail.com>
References: <20250806121855.442103-1-ltykernel@gmail.com>
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
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
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


