Return-Path: <linux-arch+bounces-12901-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 038FEB0FA9F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jul 2025 21:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A7F3BCB77
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jul 2025 19:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6A6222564;
	Wed, 23 Jul 2025 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti1M09ex"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3D1F12FB;
	Wed, 23 Jul 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297396; cv=none; b=PVy96EbYZ5D3/FoanRHV0NH5hQpyOn15dCB1HCVXB90sy0m1NFIUZJdKDaMOmtgxK9iyxUVBj9aUF7NGXKUZSrYL7d3hgxGzkf3fTGymdTzFu4B3bP+YxJqJXdvw42zgY4WrevAne/AjfGFZjoOEL9Fqkej10nrI6z7OMMznlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297396; c=relaxed/simple;
	bh=NpUgUKlbyta3HoUzbthZJe9nbJi2yA/hVsL5jpI1Qgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StGKM5h6Qry04jteG8suJrMVxNcaW77Z/aHCinH5w8KII3BBo3PNwXYgC7MbJwi/rF40zelATXX2SBb2AjporXu6Y9+JAtgvJJw6wxicBA8SO1mgi+SnnNdyBJT0y/aoqhWEBOg0siehyRmpTEw51UNHYn7uBbkd9Auy+eBZsZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti1M09ex; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74931666cbcso281070b3a.0;
        Wed, 23 Jul 2025 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753297394; x=1753902194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUGyln3YUNvAev0vt+DFy1ByCk18D3Xp07H0Oxb4O+I=;
        b=Ti1M09exPTm0L88wI3lIP/X9W1dfVQdUr8qTSMC+fpL0E1oSaOSsGeq2suAuSNEOvx
         TmFgjk/n4GxsaskYZRB1YwgLDUNfle/TgWLY7m+aR+Xya5RBlnX0S+VGUKaAlJ3RhxSu
         a7tx2mgcnEtdpYFmBShJXbeN2FUIorOD24Xn1DSovfZhlIYxLExkPcBkf5RCAg7Tnh92
         nphj0AiPAIsRHgYBaAqcVI4t1wxY+1G2PZvTzn0UgElHskk8pRefOVqCAnpFVPY3sBbG
         rSf6RWg1kAIJiYdnNjHd4E2K361ZKYC7sglcAiGJezGI4RykPHP5r3j0lJ27rJOS20be
         Y23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297394; x=1753902194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUGyln3YUNvAev0vt+DFy1ByCk18D3Xp07H0Oxb4O+I=;
        b=tSiYL1vsyotjTTc9ib8qD5I12XLZS1xpAxor7sWV6Yv/9tKPJrCpP53KHg717uwET/
         O6gDUXeR2pRMpXDcaZJRX1HHm9Q6eEBCVlV4QSwCqc3J0cTzsWKZNGA29dPa2nLBqC55
         TyXej5bqgg5ik0/5Tjp+TEovzJM+POBeS3eDFeHe6hooArM+TJn2jEnWOPRk+F/aqysz
         /XrEw0+DZWxowYZasoixU27YZcu/lq4mFJ64TXQR+JJqClqrPVZGIhXl9nrVX77xu98l
         swU7Ou3bF79lhUSEz72TG+pg8s/jaMos0weTDUV9m0eH3E+fKsZtfDDs575z6WuIvj85
         YEAw==
X-Forwarded-Encrypted: i=1; AJvYcCU7jk14SYlmoduDyneC34wlfacMxhEoME8zEr1W/hc1mrfCllTvf93+SCjZ+pfudla8MDUsR7qv4VTM7h/w@vger.kernel.org, AJvYcCUhKmfqpTMBXX2bnNgZEeTVQIovjoqYB7xlcYrpY1c1h7v+TTe8PIY9ePCCkwbni9QjFNzfy6RXAZk6/a3w@vger.kernel.org, AJvYcCUsl8c7HXbf4MjwVaCASdh+LRw60Fp3DTFgvLNot9Y2moQYfjNhDu2MB5f2a6+GBNYkHFzw043z0kyF@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmSEMTwoDVoI+TG+r6ORApXIy749tmg2fUbuqiFmJ+32LQgC6
	mZbmztH7/JMf7/9eEp8Zv+WeyP7+Rjo5lDAnuUH5+dtwUwGbEsWXjrY0
X-Gm-Gg: ASbGncuKPRY+MqbVnI18G4IOGQ6YBvGJk5EJ8dY6NUUQ0IF/nLhsDTVQZblfrIinww/
	lSa6jtLShy584iwKzHRMh9exirRU8RbDoNelMfwLOMMtIulXblBcivLExHZhhybijC+2jwmPoZy
	Kepa+SVTNF8UB1M0WZWPk4otGrYBBNRHYlSFirt128fOBj3jx7O4efLd9pUHIsund6aEWedqN5M
	ygXCfTHKigkc09YUo0SQjncXy4gxNvUnLXF+31ALGaqxAocFySB9H3Olmsfs9m5QfzN8q0Tuuxf
	NKEVHrYx5TuTIq/zW93bVgXhuvmeoFhEUHU6derkw9qBaRAi2fEJmfiioHTNcpJKuW/4595ND9j
	6IDEY0iOq4XtrJ/nHUSe25CUwYsQo2adzEBzUML+KCxLJ0dP7Wy28P62DApcTUp4=
X-Google-Smtp-Source: AGHT+IH1b4E3Itoypv4MRl5iL0FqnogJ7PlOeKFLKTuH18/7nhFL0FiruFb69ahdgLRgg0qkix8ZGg==
X-Received: by 2002:a05:6a21:9989:b0:233:3036:6fae with SMTP id adf61e73a8af0-23d491311e2mr6217548637.27.1753297394207;
        Wed, 23 Jul 2025 12:03:14 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:73:51be:8747:b004:dd13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe653a7sm9513884a12.2.2025.07.23.12.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:03:13 -0700 (PDT)
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
Subject: [RFC PATCH V3 1/4] x86/Hyper-V: Not use hv apic driver when Secure AVIC is available
Date: Wed, 23 Jul 2025 15:03:05 -0400
Message-Id: <20250723190308.5945-2-ltykernel@gmail.com>
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

When Secure AVIC is available, AMD x2apic Secure
AVIC driver should be selected and return directly
in the hv_apic_init().

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index bfde0a3498b9..1c48396e5389 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -293,6 +293,9 @@ static void hv_send_ipi_self(int vector)
 
 void __init hv_apic_init(void)
 {
+       if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+               return;
+
 	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
 		pr_info("Hyper-V: Using IPI hypercalls\n");
 		/*
-- 
2.25.1


