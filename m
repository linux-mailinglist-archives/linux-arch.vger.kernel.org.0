Return-Path: <linux-arch+bounces-13081-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314A2B1C5B7
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 14:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2631626624
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 12:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F86128B7ED;
	Wed,  6 Aug 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7+HhwGG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90C28A1CC;
	Wed,  6 Aug 2025 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482743; cv=none; b=DSFEz/XjS6lbKHH91hQhSw+VF+FEk53qTm7YrG7AfbCa9dLB2mUftBoh0eGC2HvLxkmSmEfST+g8SeXQ8KGezP0/yyUWY2M63DLMFwrj8V22QfsLAiaHXZ/MHF2okiq5u3ZEvVkyBVqdShmNXQBhxXTjCjFuvid58u/D9JfJNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482743; c=relaxed/simple;
	bh=v+x3oOA6VBkhoQgMaBoDpjblp1uQrgSriRdfjEaYUkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uECkZBaq+Ydvb14VaMIGQtXnCZ9RD23qauhnz6+Bq+USeXgmQF2213obXbgS16Pdu7V/sr2p4Zi5n4GZ0STiA1ud82q/r7oTMa9OstOFIc73Ue5ql3tPSM3m2b/auWCRJdsY8sh9BuLdpfq2CnLJhfHeQl13rkfuKaf59S+latE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7+HhwGG; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b42254ea4d5so3425967a12.1;
        Wed, 06 Aug 2025 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754482741; x=1755087541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nu1fPX8hvZAwlh5hbY7SO6NLCMrkEFDf2Xo0iEBAdP0=;
        b=V7+HhwGGF1F3dn6iQF4wRolkWACQU658H7XOO91MopQ9FXBjp6whv01U5UUH8KXKnt
         y4LSMmsFutKWpsiiFZaughTCmfeQUMT8/M9PYbeVpJ0EmXa1WRvx22n8hqFeIVxXCe0a
         1DJ2e/Tqkpv7yg72UEvkrnttCbp6Cl2QlV0uM5dYS0FK6teRPrIiZSw7AEIJmRgQHQ59
         V22bQjy1ybPpHLGzBAvhqn5yggXiyRfqIS/AmLr5gMOmTbCrYqiAGFJNPOc7aQn70vff
         hsxjoTyaOSVRoWHo/qHtTpnrHDIY9yBHZOfI/mxVrRFidWqQf77f7jPXHgcS5tocN9DU
         X8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754482741; x=1755087541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nu1fPX8hvZAwlh5hbY7SO6NLCMrkEFDf2Xo0iEBAdP0=;
        b=E2w1iIY3VfcDw52gkyxgs2Rf8/4itlyGh+Ed2D8KvU/LQMPwpHOL60chq0fFpd6+Pk
         vyRATaxHwsF9L5aiMVZAw6Zf2ONuJL9yrNlVjUrN0L61PLATcbcRr7CH6zol6DCSg3eU
         xampZM7lUC6rmBAvA6+5HsMvANsBs+fnlpj6t3lziFbajvqG0hy5460lQncpZ3En7H9h
         FKzIJS024CEnDbrd43eKnKSFruO/ICqIINMP3oQESnf0sXjrgsGSYPc2KceJEKiTLKZ2
         dE2OJahgaHwpVAZ0mOViJgb+1Uz3seqfXUq149GI4x9IS4X0r+MpoQ1xTJ3c54xawKQG
         wf9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGK7IW2usuMDIc20S/VVBBuyqMabmpwknLruEcheQsT3KmDVsxSWJc3XCaHua6Ey5gKUTXSzy+8xsMP2sd@vger.kernel.org, AJvYcCWP5ANcaFMau+6sI8jVZv+qRTZpNeVYBpzainDqFER0+TDf86ar9WnPutpOWLW3gairfLCDX32lI0eJgSvR@vger.kernel.org, AJvYcCXbb8sQFcUU4hSJbZR+yHiTqIL4zEnJrbK1n41BxWWXh18Pq5b4Kmwre3NXG0gkhOSSnSeTfb+T1WB+@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHGzQVDtHYyIPWe3um6p2HJ4DsZhlLJkekkj9r/cACNvKww3J
	5TKfxrj577BDgB34SHj+xE58xemBPhPRc5zD0gDEuOS1E17pS9wi0JGK
X-Gm-Gg: ASbGncu0bYeqWIf3g0j8FwscFVcRAAYIM4NMdT1E6agyM0bsn5MDSl1bzlRWSOjcoUH
	BnIqZWzNNs3LRd1TF3GVGI6f1qlc6k3sBzghU9jtB9LEMF/N8gkyiHiJYPHOAjLkzrPrTD9z5Oc
	w9Ko+sXkPYC0jNiuILaE0tPFJkuqhO6b4oO9WfYtOhqtthaQ7BXz6sN/ywLR1MBiQ0DxFRl+xeA
	6wonhr07myKMhQ+WAF6Z5oYE3tGeBakUWZWbF7mzrlc+VjJnicFTsXu5UR2ckE7dVlvo3LWm7b9
	PHx/gxni8H7OuZ069aWnwKLTtr8q/2zM+azIsA9ET3aAPB1OpkS67U8TYvlJnLpRj2PbHXO4t2S
	HKFDvBs9vj6T03oJgDlpWAzEUsN/ezMk8ytQvbtmfG+zd4I4=
X-Google-Smtp-Source: AGHT+IFNPXn6wXlF+pzvpwbEuiDwLg8sOlt62mrcl3zQ7U/rTr0AevvKFL/Nog+roe9u8I1PpBu8dw==
X-Received: by 2002:a17:903:a8b:b0:235:5d1:e366 with SMTP id d9443c01a7336-242a0a766afmr26881955ad.10.1754482740993;
        Wed, 06 Aug 2025 05:19:00 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.mshome.net ([70.37.26.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e81dsm157512705ad.46.2025.08.06.05.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:19:00 -0700 (PDT)
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
Subject: [RFC PATCH V6 3/4 Resend] x86/hyperv: Don't use auto-eoi when Secure AVIC is available
Date: Wed,  6 Aug 2025 20:18:54 +0800
Message-Id: <20250806121855.442103-4-ltykernel@gmail.com>
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

Hyper-V doesn't support auto-eoi with Secure AVIC.
So set the HV_DEPRECATING_AEOI_RECOMMENDED flag to
force writing the EOI register after handling an
interrupt.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V3:
       - Update title prefix from "x86/Hyper-V" to "x86/hyperv"
---
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c78f860419d6..8f029650f16c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -463,6 +463,8 @@ static void __init ms_hyperv_init_platform(void)
 		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
 
 	hv_identify_partition_type();
+	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
 
 	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
 		hv_nested = true;
-- 
2.25.1


