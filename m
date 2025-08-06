Return-Path: <linux-arch+bounces-13075-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB9DB1C2FF
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 11:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A93B3B9CB1
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 09:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD2F28B419;
	Wed,  6 Aug 2025 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvumqQnl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF0289E3F;
	Wed,  6 Aug 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471493; cv=none; b=GWyx+1ENZyqhJjIYlobhilKmuKH31/zpJtMyYNnHYYQVMVYtk7G7HmonGanMGCUExx0sfJyFIe6SQQvSkx4M+tVNyopl7hG+9JlKj70RrELpoAasWxxyXrYp3dQncsX9sQXcG5Co/PiSL4ProJ2e31qQQG8yyBuzb4LU5g7FNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471493; c=relaxed/simple;
	bh=hSFA8qtVfzMc5s9jfMNEqt+3cXNT7uR7K30ErKjltc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJuwMji8eDdLa3zWD6aShfwS5fbwK9oVsOFFdRh7geUKKVDsUIEAsGdrp/K4yEjvaofrf1IUzaeE8ldcMGn1nCG/9ybGX+Qf5OFpQvzgL1dEQYymBnU6qrNnqG0WLpGze5rTSEAMYjkaGeQ1+juOtdyNJLv7i+28lFdP0osY+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvumqQnl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31eb40b050bso5406476a91.0;
        Wed, 06 Aug 2025 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754471491; x=1755076291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jgc038c2v6U/eJUJ8uwSr0YExE6QXlfF5ru9RBAi2LQ=;
        b=dvumqQnl4ZKC2SeaYp4SER+bWMZhChjoF7oCBjWtx3grwqNqwqr1ZzIN6RMRF3Ackw
         5iTagrisYF0OTAXBRhSsw6y726D2T1Sa7tireYHJy3ocvwcaXPfsU4WYANmovIzA4FEt
         H/Xnkk8Bti31fJKXMC9rI6NSszZ7oDUP3j97ngorAsiugcpAaJQ9D3baugY9LMry93A6
         nNNBF3DJWhK4uNg4ZouSs6HTYQnVASttvESU4LIc6W86n5Y+n1OreZSRtxTgxyaX39MC
         XRwwkYC7w14vN3lUCr2wliSopGvZj9022P+qUxDVeFVJLIVYD3bNUyPtUSHomJlwM94c
         /3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754471491; x=1755076291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jgc038c2v6U/eJUJ8uwSr0YExE6QXlfF5ru9RBAi2LQ=;
        b=Vlj00zeAZC3UJAy5S1AxM6m8OjsywlV39AkwnWwgXEfLDYhggNFNv8l7cgqI9Aoa9F
         mh/jwlW3hGBf4gVWWhcwHTwVsXaBtFg13L1wcoRnyPEvjnKe3Z+Fj8WlZasHL7D0HFaM
         mNnNAiHI586gXzo/pkFVJFOUXX1aR02WkXM+dNidPQuOCUpOKxAwpQWV6rJAVEWn7qFE
         T5zUfbMnYwq/wpbW8lzp3TeU8Y3X7E4n9dHbC6qvqcn23ALWWMdDWUSeZW5AbCaoRUyN
         iREcbQN3hGrReURdFAkQ3nci96itkjIf15LQkMrt3YQuB/uqCB6WLkK0KXKGjf19Ycnn
         Jt0w==
X-Forwarded-Encrypted: i=1; AJvYcCVMfmdj0E8kMQFghSRRLLkoAh+aiwF/mwPEb13vcH0nZH4j5bBxV1RK6IByZ/iqu1ofHtPKOXnBHaKj@vger.kernel.org, AJvYcCWkAXB0fS+KLFEb7nb5hgdEVtPGw1mcH1TMhYzgTC8QZTkHc2ekiNMmx75OS58kAsbke5xtXKVSASfUafus@vger.kernel.org, AJvYcCWsED8Aa+an//CDrkLmNzWAU69G5W0qyN2/N67jbG+usQ9NsQfPAFEh9otENDWgDjlSHLJHrXP+3IWhWHLQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzPa6SNMigSimK3umvScb5ta30JOeXu6u63Eb8JrvpQZ11Lips8
	u2IdNNk02y+D2wla+5c7vMA+W36bJRGabKoLB9LPWRuylduyQKisbxK4
X-Gm-Gg: ASbGnct3eSJ58fmxcQu3lDzT6YJKpYZOm/WJ4HmPPyRKL1pfhG5zsggkqkrI/gz2Bql
	86lzOfeu22Y/n315/qsfDGSO6pXHAt/zdbxwnFoqJVuaITCZjS4QBxcrZck7J1jHy6zOgngq/S9
	RiV5rDVm3b5j9XbOQ7fANZgL7zw7YbKb+dqArXmkjCtIJTfIvzP4V7RmGIDfEaXkmZg4mgR2qhO
	dbJvnNLmZGLuPlw/H8//t5OVUz2YinCSIWh7yijmi+JXw8RUJJm0p5JkpFLd4TonKLym+vG9hj5
	LCz+JdhT4VsNpyhAkb/GJYveC33/SYV9Z+zmNShs/X6eSN7QcSRVnAWPB61RVJ1YwdpwOoOBl9D
	n4YkfzhdaKlOnz1x+PQYEM1aCjmjyHjYJVJSeZflBIQEhYks=
X-Google-Smtp-Source: AGHT+IEgjHhyWY1hXPfacxW300tut+YuMBH6Lo69k+KqgBnHI3oRDYcoNoRIvBXIKaALWr0yyLDuBg==
X-Received: by 2002:a17:90b:3a85:b0:31e:8203:4b9d with SMTP id 98e67ed59e1d1-32166ced9fcmr2445166a91.29.1754471490971;
        Wed, 06 Aug 2025 02:11:30 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321612950c7sm2255568a91.31.2025.08.06.02.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:11:30 -0700 (PDT)
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
Subject: [RFC PATCH V6 1/4] x86/hyperv: Don't use hv apic driver when Secure AVIC is available
Date: Wed,  6 Aug 2025 17:11:24 +0800
Message-Id: <20250806091127.441323-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250806091127.441323-1-ltykernel@gmail.com>
References: <20250806091127.441323-1-ltykernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

When Secure AVIC is available, the AMD x2apic Secure
AVIC driver will be selected. In that case, have hv_apic_init()
return immediately without doing anything.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V3:
       - Update Change log and fix coding style issue.
---
 arch/x86/hyperv/hv_apic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index bfde0a3498b9..01bc02cc0590 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -25,6 +25,7 @@
 #include <linux/clockchips.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
+#include <linux/cc_platform.h>
 #include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
 #include <asm/apic.h>
@@ -293,6 +294,9 @@ static void hv_send_ipi_self(int vector)
 
 void __init hv_apic_init(void)
 {
+	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		return;
+
 	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
 		pr_info("Hyper-V: Using IPI hypercalls\n");
 		/*
-- 
2.25.1


