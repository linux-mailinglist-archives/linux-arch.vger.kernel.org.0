Return-Path: <linux-arch+bounces-13058-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED16B1A8E0
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 20:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DEB18A42E5
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3FF28689A;
	Mon,  4 Aug 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxcUu/uh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF31C1AC43A;
	Mon,  4 Aug 2025 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754330733; cv=none; b=A5OfhuNAeP/7Ry5EFy83cFqLoweW9DX2BX4FQ6jfc3lS6RLofbYgNpbeHugzm3zA0y1YdBuLYhb5eByN7vbUAnRiLgW8BSaYGksv7uCU8+oMPdfseuElrNFesNPC5icpamnv/3oht8XRKm5cpo76UxUxJxe6N2naL8+Hio85Bt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754330733; c=relaxed/simple;
	bh=6h/O09cg2ZK10uc+cU66V/UVcpCZST8xldPxxpIQ344=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/JlTHSRpkCj/ND4+q75RxhrMAYzAHgajjIhfGDoe9N2o47A1OKDQC/UzIRUBoUXfRwhSJV9pkk5YyYEdkzW+XS6BJO0MFvqKRGRALHlbvBQg9PfQbGmgtqJTMqnOI1Bq3NWCR0IJl7JR/Sz1Vmbv0FUhQQIn1wDtWeTRGtExa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxcUu/uh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23fd3fe0d81so43311395ad.3;
        Mon, 04 Aug 2025 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754330731; x=1754935531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diFyvyzFwUlfwRkaCIl9yb8fUI7T6mrGkXOX6Pchcec=;
        b=YxcUu/uhXKWItkosLpHB0iIqpBj5JsPZQ86+AQILwujiiYrmVfGuOlCP5frdW7gO6v
         gHIl6+1j3tYoU01cMAwrjZss6ICE0nNR51ZeI1OWdrPRCU4z/064IYhVjgg8bDJL4JAO
         mmygKRFZg3l50EtsdS1ZuK9R657yRGO/vUg392V7QhJhWHs+aNeEJku875d4F8WTQWNV
         wDWzvE4mRe6gxs5FEdd7qH9lybLV0CZMfDPCAFdSBgwHvJL2II4zwxryfeMBWgVFbvEf
         Emd31x6fqiXd+KNGFlS1A686DSCU7pq6aYGspjFOfU3F+HUCoAxd7KpgTmUeqN+klx9+
         ruOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754330731; x=1754935531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diFyvyzFwUlfwRkaCIl9yb8fUI7T6mrGkXOX6Pchcec=;
        b=xVdPs5qIFpyyoYqUQpl0J83spmVURrReW1vTOlVRHm7Q+4amIKrzXAZ3EAbvk9SXnV
         JAE0lDnK5W3zqQZQVhEH4XZZZERobBtvgsjhPNkqzFvLft1JUujFXx4N+E62S/gCBa3Y
         wEAyH8rCr84wRGPtnKvxwqm1F8g+2YN9C5GwJVJgLnhm9UBOmcYhRLtKx74+ygickEoH
         7odEUSJHn6j9CbfbMvYnX5xbDpAuZplIx8IA8AayLajl7BdDHZwzvxVkgLeST1TmlCco
         taqH5dhZv4xmvlDjm8+wkHF9OlGW7WZngOCLWY8g3c4/Ya42VFc7/G6vCsvBdJIuWIZZ
         +Dow==
X-Forwarded-Encrypted: i=1; AJvYcCVo+PcDDP4wze1yW6qnawp8RHDsUyfe03Y9BwJPV913vxjAEf35lv/Jf2efkmwkvbW+yoA009/YhqVBu/eF@vger.kernel.org, AJvYcCWKDDPBl2ha3i6dM0SIPOJlAaBDfx8hXQ9V1PWNSejUlhSTXd/ykrREBhLJlfkXyXnMXeFCK7y7u97l@vger.kernel.org, AJvYcCX7deD1d0AS/MlFJI5yI3u9kn8M+9tvQ5ADnu9S7CdL6fGJRsHRURw4qUUJ9CJncqRQ1QTJL2IIPliZBT5b@vger.kernel.org
X-Gm-Message-State: AOJu0Yy78Ri502EAyUPYy2r1SGKH1WNodvbmLfNAdNpg9/yRsod9eBWx
	f4SL1bBXX0ibNWRjg8OfHk6R4YvOZXgA5ICLJ67yAF7DIYtb8Swk5BQiT/5LSg==
X-Gm-Gg: ASbGncsBk/l2GRrhp3WvIxViColA4K32sNJt7/TqlFB79q9qi/pbS175+IgcaMee8nu
	s5FTAU4QxF9GQwKrN9ngbXfqn0o/CbR6AKc2YQ+fpO6jW1KyC9aBFH18jfklSgoOyAJ2880TGzN
	df3ebAQ8bHbvSDd7txpomtFWKwU9pW/C6w1Fihm5YagaEoCf3UdUmK2wGmmM639fvKskY2Ykoyn
	aLdhzRs2cTLKVR//HdtezIwrOVfxZE+NGfyE4Ggnmoar+WpcRg8FSCxmt3PEpjXP+Y+7uk5poCh
	hbuk+ZQBdASPwNlYR0qGZu5oWL+umtk7fYkyTAlsnAhXTL5/FIIf7MPr00wHhbXumB4Q5NOwKbv
	GZOKEwGTTONJu4x1WVAIz+/DmmE4LI3OSv25eLKXVn+z8t+QqCxOHeAgOaQlgUZI=
X-Google-Smtp-Source: AGHT+IE7mHgAv0lcc0hWBFYThROiodeuo5QTQxbXshLlUBr+SbFWiKqcdbpU88AENOgaqd2elstJDQ==
X-Received: by 2002:a17:902:db10:b0:234:df51:d16c with SMTP id d9443c01a7336-24247047121mr169092885ad.45.1754330731141;
        Mon, 04 Aug 2025 11:05:31 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:6f:2b47:96b8:6281:35ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafb34sm114144825ad.173.2025.08.04.11.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:05:30 -0700 (PDT)
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
Subject: [RFC PATCH V5 1/4] x86/hyperv: Don't use hv apic driver when Secure AVIC is available
Date: Mon,  4 Aug 2025 14:05:22 -0400
Message-Id: <20250804180525.32658-2-ltykernel@gmail.com>
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

When Secure AVIC is available, the AMD x2apic Secure
AVIC driver will be selected. In that case, have hv_apic_init()
return immediately without doing anything.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V3:
       - Update Change log and fix coding style issue.
---
 arch/x86/hyperv/hv_apic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index bfde0a3498b9..e669053b637d 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -293,6 +293,9 @@ static void hv_send_ipi_self(int vector)
 
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


