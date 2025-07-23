Return-Path: <linux-arch+bounces-12903-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F09DB0FAA7
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jul 2025 21:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175B25410E1
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jul 2025 19:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582EE231836;
	Wed, 23 Jul 2025 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLtr4Qda"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7322B8BD;
	Wed, 23 Jul 2025 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297398; cv=none; b=m56mLlR3mHc5hJK/42hquhi11k5p9DwjRLQSmBxB6Y8WMcgMq8SeEOc5EtI+ZPmXN1NRF75NYFMseOjKJe40qNIX2WbEONzCNwvVJKT6e0pdoq3lvH9PRhHvznIeda89B3ezUgg3i+xezhgkYvOZSv0WJKk5OxDgoc++UTqRKLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297398; c=relaxed/simple;
	bh=bdcmFsR/RQ3H75sRKpSmbprpwo9X63LE4Pw/O0JTaQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SjD3WWK77g9jz5AUf6x1f6yc5eOnKYzJLGPvGKr/51sszioZvLmqRwM6Ve0Boc0GvxZTLytTa+ayfUposU84raWVWsBNsFT5lc9cEWcqhbFdQVP21R52cT5ICbcrpBIAusinpHLwNPAniMIoQctF53PAREY3V8/RRxSHh7ThI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLtr4Qda; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74b54cead6cso202263b3a.1;
        Wed, 23 Jul 2025 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753297396; x=1753902196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J59q3wJp3DzX0AaSMzXIfjEZnXs9Xrj++0C93Jd2C/8=;
        b=kLtr4QdaaK85Om8kNq4/Dhh4N0OWaRDc2x9PY1V33mfRBkdVSeSr/xjTqAwKBpqGv+
         PtcZ/humGdWTUpeGDtWuzNfZI9sd333gj2KnwuvhhQNnLANRopzaDJPvD3LPvX+u7CRN
         huC0nqYIxvcdjsAB47QNq9JN1wbu5aEzhdEzqNskh70zqtui0WDn4iWCHMwqsVCp7rVp
         tDedy8baZZ9Fz84qbmD0PDoNVZwyyebervZ8Qho/y1MhyC9MfZBPdwo6d3CkW4V3de5x
         K6RL1dxEgsEBRFdoQGnZpBhML6/1j6bwEGNpTGF3tgPxaeftXnGzXDcYoP8WDRFGUuVr
         UIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297396; x=1753902196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J59q3wJp3DzX0AaSMzXIfjEZnXs9Xrj++0C93Jd2C/8=;
        b=NIbn6gnqdoB23BbHiXi8HJnKxGPqI/Gk9C/U03rtGCLH/+dyX2jkMW8YtWU2kwbX2Y
         1oyieHR92PSsS9Y/qdiut/kcqrxXfH8LhpfNNyZ4ZCngvqcxgCMR/G6hlQ7BcsH1x4Pr
         1wpByfiGHZJS4Yz12fudNVMlo/Y+OZ43qj95YJ9AN2JUrFP7sQkDEnuJdN+W+MWv88Pl
         eztd4wHp9x39LMcLVk5CKtMLT2UKA59Ov7kcA14Gixy0THuO1w0kVf+SuYh4qHLW5Z9D
         YDY+x/P6qarnY7b2+w/ldn6klu/mWX65INYCXePDj2+Be4ipdBVGZOhI3PV1NowzLNK2
         nx5g==
X-Forwarded-Encrypted: i=1; AJvYcCVmB4gQRDF1GGfDN3DAih4yzVxGKcfez4A9lG4H/i5oDOYIXXiKmpcKtCCTlnfv5NGy7Mx9WU0P/xHL+/LH@vger.kernel.org, AJvYcCWlvwE43FWnVv02CaL/wd8z0AbagPKMDI/qzDO/s1e2LSHHUHm/IVXxYRcduP2tdmrBx6iZSg3vL2n8zmgJ@vger.kernel.org, AJvYcCXRwAQsG0XcUQOqfq9H8kOCPZyeNdwlfc1x/y4iamnk/Rb4kgFExHfRfgl8jpdD53l0d1ziZ0yL21qd@vger.kernel.org
X-Gm-Message-State: AOJu0YxWyPLLrvzEANcRjwx0RkfZzmJjak980iFpNgFqSJRB+eL9712R
	6CsEgV4lkqAD/C75zkJOcpqA5NQpHkH522VcZ8IWbGgXpeU0mnisnMGB
X-Gm-Gg: ASbGncv1a2h72scj4oyXQWWFh2Y9MD/E8zS26HXyuk0MnUNzbOcG1wce3XAnFLrgvIC
	l2ohkeYkg5h93g/IaaiyetQPOPXk5u+4G0EPXAq28h0nv6W5LbvZVBl2wTlWH6eqQdSm2KV4tQn
	qrfoynr07lv/P1ag48asCtDOAeIMcta7hJmOKS76AGwWTvsHzh7IHRuFVUmV06uT2Bv6eevEjTQ
	fbrqQIahsTYKRY9EgpZnRQplbGc5FxKxdsPHaIA81S3muARPkCMnyvmpIDQR8+wkqhFVlVm5YD8
	38z1W1WwKZ9voWcJTbqaoCrPobEZQqCXAOV1LZReups8hTBkQ+8oeF6AxJvdDwD17ptLfSQKaGi
	cfPHBMvx34ry9fHnzh4FKYgkv3TCU3r9AaSAi+2/ewY0q04bxXnuMC3gmc+bgZuA=
X-Google-Smtp-Source: AGHT+IFHhyaKGSTBdYCxIj73PlM2Bszsat9K94uOgCnq67D8YqhwYY8DW/clVn5vlJ5z+55XbCgo4Q==
X-Received: by 2002:a05:6a20:5483:b0:237:90ae:82de with SMTP id adf61e73a8af0-23d4902052dmr5626009637.16.1753297396085;
        Wed, 23 Jul 2025 12:03:16 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:73:51be:8747:b004:dd13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe653a7sm9513884a12.2.2025.07.23.12.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:03:15 -0700 (PDT)
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
Subject: [RFC PATCH V3 3/4] x86/Hyper-V: Don't use auto-eoi when Secure AVIC is available
Date: Wed, 23 Jul 2025 15:03:07 -0400
Message-Id: <20250723190308.5945-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250723190308.5945-1-ltykernel@gmail.com>
References: <20250723190308.5945-1-ltykernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

Hyper-V doesn't support auto-eoi with Secure AVIC.
So set the HV_DEPRECATING_AEOI_RECOMMENDED flag
to force writing the EIO register after handling an interrupt.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
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


