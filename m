Return-Path: <linux-arch+bounces-12966-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EC0B12AC6
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 15:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064921C2647F
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 13:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8401028724A;
	Sat, 26 Jul 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt+lST7C"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134428642E;
	Sat, 26 Jul 2025 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753537377; cv=none; b=oUMN9geVy33FzHCACBfNntFvxBTm/z5ayW7h0YqPcv94td6ZB9KjxMHDOexzpgr1IwDYiOPFlrSHYwvBgb91YGi6eDcaZCxk6nH0LRhuMtm6TSaxbrsDE33Y3kHHnJbi/+EEJpFZ6whbU+dy2Q+6fRv2AZo7BsmwOioL+0s3Fq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753537377; c=relaxed/simple;
	bh=UuNsBdvtxup7jW9SkePiNmAzpgXCmgudIpQSmDwe/cA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mHUeB4kkhMfj2mTAhYJpETeRG0TVwszop82y3gzmNfdekDbihCYOrgx3zp4idpjWZKTb5qGeyrFG/mBKnFkKhYFyLK0gznFTLzbdlhzKqqAGRsE3lJeor9rHBN7XGy6pjil7k7tk0KzJA6/VtImF42NTveLQ7rrC+xzjyg5X090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bt+lST7C; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234f17910d8so26356015ad.3;
        Sat, 26 Jul 2025 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753537375; x=1754142175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJlrufef8Bsvwmu4OcR0axH9qFlPYK2uzAQ9Wh+0EEA=;
        b=bt+lST7CyGXrT2DKXfpUc2hxsqgvLUOl0x8PZD29EK6mqhlpZUSSLl1QxywhDAYBBf
         V53vLEWda5g02REAySJ90/dmAP183SARe6J8AhxY2feWuKTsmFGN4ZziFXaon0VCLkns
         f0anUKUllJr5EXF5M2YNaWdXVDRrYHmiltPrH4FuYJpOjtiSJ6Wdp8n7vsPlTRQw4vf0
         Uq4WUhw0SQaf8xkbGoLtqHQeSw4aqhkKd7t6+Uo4mcfNmYVZ99/Bxg76gziW92jgZiAB
         8uND8MT2JY4xA9NwB9OBV9oGaQqh+OFD2sBmcD0qZ8hHZQN+1JMY0NhtYvGQ3ZGFTT+f
         2FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753537375; x=1754142175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJlrufef8Bsvwmu4OcR0axH9qFlPYK2uzAQ9Wh+0EEA=;
        b=qB6SksJ/9VX+Jj9SMxZ0Nr1F7aIoqSWi9kW/r7DZCR11oFgblPhG8uIUNCsli25fSU
         +KPKhTjuWfpWZ6hucR7jhxQXFlCGV/lAsbklgtvaNYsx2pSMn3AFMVN4LJWwDVMtqFkr
         4BIfXPvNxTgi15Jm8qRyFacKrETUWzf8RpAvV/OL1yEQUZLArTiOWrW0e/mWVCALgCbt
         TdTWzgjPRJFipNwGcD9Kk+g+MT5ql+ubDUyfpllMRM4ui2U9vfmsoZGmcW874QUlHJuw
         mCKog4CaKFcgdB1hfXcXd0cM9sF4UyLHvW0N04eAGIkYhmcRqXAPAJw/HZjstBkHg+E8
         /95g==
X-Forwarded-Encrypted: i=1; AJvYcCUFQpGyoW3srYmbCdarqHQDAFYTTxt8X+u39h3vYo8NO00aJyUIHAMrOReLOWfzLfyT89sSge/zCBLZ@vger.kernel.org, AJvYcCVIF8qTYSq0jFC3t5GxIXPBtnq1OiexkB0izkFPeDb+d2CSX7RjMCYy717g8IFObCGvUZR/JNucUcuFuDc1@vger.kernel.org, AJvYcCVQ3+ufTY+2JXMmuNXZQmSeJ0s0Qb61mRjzBZbTQaoZMrL4W4x2LMqlxkGqRkF2Y8eBclJctReM/dHFb4m7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt5a7z4VX54nmEy/EI6+bTFw3M/1wiAQNDu1CQvm56ZNxGd3J1
	2CF8VqolqXjxaSgcR+/oTVu6VKXcV15KAByVBSyd/nhekCxPSV6IMzyf
X-Gm-Gg: ASbGncsv9/HLbmPdBCqjxbUkxTw/YpbGGFv/ftrXktr9ndCdz3SpLMbT8/DcmRJiSsj
	CNU+ZVa6w7GfosvJ6+PpSgyWtS4gw2kQzi0wBHmRZlC+JcS5qK7xZVt5q7ndlQh44Q/3cvOEVU1
	xbXp6cdcmNRuJi4au2c93Q4Dq5LfAyArwCcV4WHyFrobJZIEEr6yHLhkOEqaeAeU9oBV4WecA4k
	wbjunJS1Mnm7VTCpWV3D82is/hgOQGkf9g9nixa9cYBNiIOHUXb2q/SdIlN8GCFbYe1TFG5rn/I
	OIyN7vq5AzrW6yA9GN8B+WOe/5lLL2IfI8gwJO55S8kvjekU3KI2g1Y5hEHr30nvL4oGCi/wcuE
	0X5XfB5Au5XoMN+t9D4ZFKpElUCC6eMvI/x4YtQFxqI3TUABThvqPK2S39dCi/A==
X-Google-Smtp-Source: AGHT+IHe1qlZXAW9PZ96f1RjX/uLEzPFjAXVMf0q30Hpwrlk3uzY12aMbuj+6Tqo1M4z6vlAvOGg5Q==
X-Received: by 2002:a17:903:2347:b0:234:8a4a:adb4 with SMTP id d9443c01a7336-23fb30364f2mr99505735ad.21.1753537375318;
        Sat, 26 Jul 2025 06:42:55 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:77:9619:11b0:a73:e5a6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83508500sm1869190a91.22.2025.07.26.06.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:42:54 -0700 (PDT)
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
Subject: [RFC PATCH V4 3/4] x86/hyperv: Don't use auto-eoi when Secure AVIC is available
Date: Sat, 26 Jul 2025 09:42:49 -0400
Message-Id: <20250726134250.4414-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250726134250.4414-1-ltykernel@gmail.com>
References: <20250726134250.4414-1-ltykernel@gmail.com>
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
to force writing the EOI register after handling
an interrupt.

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


