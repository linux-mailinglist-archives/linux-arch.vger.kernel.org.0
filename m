Return-Path: <linux-arch+bounces-12964-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD2BB12AC1
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 15:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A677AF2C9
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7B22868A5;
	Sat, 26 Jul 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yes6/kkd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379B5285C8A;
	Sat, 26 Jul 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753537376; cv=none; b=FYgFzkQNH8VP/jQip9L9XKoIm1f8wFyoTU/mZp7Q+b04yyMjsZPtV9ekauo/YL5fkxcUZDShmFsmLPMf9yz4d0vXf7QEaTxrKhb7ouGKQ5eEMk+fYB47SNYVBgHQ+PeM+fJVJbFsRWHqEJRzsT+k7iKxfPN5VxGmloVFAcoIns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753537376; c=relaxed/simple;
	bh=nmLlAlIKWV25SWAnefxthoPfrn4Dlk65/1c8UEdjnms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6NXvFUqMA0wXMiDBMPca0mMuMRtfGgStNg4xfohP9qHwF40sJnAOcxryUw1IPi71dQr5hlWxu5zygLDYhbtiDztyWpOtd9XzeiaQ5punUqg2j5TaT/FsL/q3ZM6lePBY09lMY8RaNLfDkPjzdvrTnOvL+fRX3s2zhtIuG6Ge5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yes6/kkd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313a001d781so2513670a91.3;
        Sat, 26 Jul 2025 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753537373; x=1754142173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW4eue3VD6zS3Y9jBbWsC9XQhRs/myTzopam4iOn3Uk=;
        b=Yes6/kkdrkjaEPTouiPLFDmV6sb/iMlSKt3UDCZ3iXz/pSPx00pgSswKkYwi/9e1s1
         fPA5lfCskcewPj94XTCf49ta0ZlxvXjBaZUY4yDj9vd3wtdaqPkYwO1VoWv4e42rhKoq
         jp/ZHlm4o8S+ocOD+wCWX4K7FTWgVx59WW+seMNR47F130psolcVqoa/4rePY9VgPQmx
         btIRm3jcK01WYu+GFy9SO4hHdosIRtN4iM3FUNEoP8yB91u0x9Wc+FwZageK+XaTW5vD
         U2TU3khxgPGPZqmwsG5NlMaeuVYJhspUks4RSsehH9mP4XB1k/ZQA4IAhbgaJHaBgTQe
         yfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753537373; x=1754142173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW4eue3VD6zS3Y9jBbWsC9XQhRs/myTzopam4iOn3Uk=;
        b=Np3EKTxQNpsSioa9hc3k+CQZDYHJbC2+S54EWTWlPnE4KF94wWfJygTtBmYHAaKgGX
         6ApC90BTvnkbJ1+/RpOeoykNCa5IMzluRi0wdHF6+EVDad7ghrh62ksshl7t6NlZk2oZ
         OTlIcEMz5xN0lQzjGieGsDU5pOhjpwu8viRyC3FjxtW6R85Q/80BU1yNolrBQwdQH6h+
         iLE9sewGFEJ5h6j2oaK6q+GtUkuIDaqV0/nYUIqinoJkZy3fIsc5YhQssQZcdrQLroe+
         YdLZgDXSCzm02WJe3YOybMF0UrshGPXA/HXh4nXu0NIF8eMXl0aESy8k+UWn+EcA9U/v
         xUMw==
X-Forwarded-Encrypted: i=1; AJvYcCV6vB1VZyGrmXxPRa32t++hpuv6SzZyCfJ+Uc+FeQYf0cEqBHeXnLLXNbgpi3WJR2xy1XvtcGJT1jdz22Ko@vger.kernel.org, AJvYcCWNUpeloQaK9xOJz5ZUrvDCLOJJVqPaVSXRNyL2UOMmrXjTWZgwLpluIZkXCwwqkpDPkOTc3UNqk30z@vger.kernel.org, AJvYcCX1mnwzBtHsgQi78hP3OuNL21HU1AHi+jJZGxcWBXWI7UR0MALIfOeRZu6i24INDmvDPAYu/0dvNMcO8wEw@vger.kernel.org
X-Gm-Message-State: AOJu0YyriTimvIdU9F5ryj3V1W7GUdOvxejQHO+ZWXds6/dxh9fC9GVa
	rJGIaUbFNtV4j7+fi16hnmvZjQWYxkCQdMXyi6YjLWMYRUlbd2bL1gVh
X-Gm-Gg: ASbGncvCVQ8njhvYC+QjJkLTAtl0ce+Rx7DLX7YirCzOZUUtWSECu2GccC6Of8naw9J
	uh7Hwyo3nP10XzjyIds3BB9UQtTgoJj+VECLEvfYk+NvxXYzx5Fmwn0Baaa3aQVuB8JUZ/RCY67
	khdfyuFBN+2lYBsd3Jx5qvKOoGDktuUNK3vvs4QrcerGJbA8pa3QgAmN9yRlb91Ly2ifeQ9+pX6
	pqc1uvz0at9VqwLNL0vBpxsdvVm4u7tyWHFsVtZFtYp4Hz1+/FTH7Y9+jEXTkmEzH7khwNNFaQO
	3RDG3pEPPGzIZB2oCyGNcwoJJSmmYvIj33Xvn3TLrmo6/4pfIIYSDqtdKepfSZCiqq23h9V6vNU
	Im/y/XzNtyEl5hUPdSX0Q5upWEvNfbpcxi6lKuXANfLMyrA3Gy8mN3CrUC4CUDQ==
X-Google-Smtp-Source: AGHT+IFsZXTENIMM1s8lgv0s+Z+9BhTpPYq4/ZQSqCWgyXwlYc3lprg2ZzNSH8VsRRuqdkjW8hcgtg==
X-Received: by 2002:a17:90b:5623:b0:311:c5d9:2c79 with SMTP id 98e67ed59e1d1-31e778f27camr8887911a91.21.1753537373651;
        Sat, 26 Jul 2025 06:42:53 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:77:9619:11b0:a73:e5a6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83508500sm1869190a91.22.2025.07.26.06.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:42:53 -0700 (PDT)
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
Subject: [RFC PATCH V4 1/4] x86/hyperv: Don't use hv apic driver when Secure AVIC is available
Date: Sat, 26 Jul 2025 09:42:47 -0400
Message-Id: <20250726134250.4414-2-ltykernel@gmail.com>
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

When Secure AVIC is available, the AMD x2apic Secure
AVIC driver will be selected. In that case, have hv_apic_init()
return immediately without doing anything.

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


