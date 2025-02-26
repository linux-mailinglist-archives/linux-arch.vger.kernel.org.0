Return-Path: <linux-arch+bounces-10386-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E321A46BFB
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 21:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DBD3B24F5
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 20:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E5F27560A;
	Wed, 26 Feb 2025 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGsI8jDS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD12755E8;
	Wed, 26 Feb 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600383; cv=none; b=uMS/cGjjikJcO+yS38IgEOgstK9jJjNdR6KpsQUb90CMw7zJDN6EAZpykG1/ceSCezUsEi1aUSdVJEutL1/ItwAdEU02IumIs+h7owOXhQKTOzBOl0IYG8M9mHrF/BD+wKl98Kwk5/w1pQcJi0PF5L9OG15r03+x9DgtvwFlzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600383; c=relaxed/simple;
	bh=KnE1M4pDyDem1/WpZ046tGoH2Z26OE6TWYZHJPkydU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mWvY4nCPaNarCHpbKRQpIxmk0NdNZITnpxhfLItSONSPRBx8Q2HC6h/4eeQD/8+mfsIYyKc8dDoFEq53cVfLn0eU9xa30pBewNYLKocLIh5wZnpjK/xmxwvkCli77R8ORsPCMWbxntnY92BMRvyTG8nVjryMxldP46DeCvVZVUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGsI8jDS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220e989edb6so3557475ad.1;
        Wed, 26 Feb 2025 12:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740600381; x=1741205181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XgJyZ7y87Cfn135tyI1dS2xkOMoi0hm5jbxPv0m7Eec=;
        b=eGsI8jDSlArWoQvsWPdagqKqv+6frGQ6Atvq7/AX9O3ocGmcQIQHeaq10tB+DGouzO
         SjsGxTeeK0NkXvwcS0cqnFvA8GLKr0rk+OCsXeOTLgLoN0Alm8R+u91npVoWYapCClxJ
         qZy5wwKiQzQSQ8eTYq2CDWBC4b5dKQgyiXe1G21MYDQdEBI22rLLrqb8RgPDidL36wbE
         ScgPRIHBh56bqLbwQSKXcsh7I5l3xI2yfH5oeM2QktMdgGclq6aqA3JaXEhba9XBm41m
         XnITyLt9UR1U8D17YuftVzIjgmQ40Q6OwgwrXYuBKG8uzojYb8gAYjU11UBo0sdZv2lL
         l9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600381; x=1741205181;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XgJyZ7y87Cfn135tyI1dS2xkOMoi0hm5jbxPv0m7Eec=;
        b=sJ8Uq766jZOEMoVfxLrjpn7FanX1GHxw0TUr3P/1GlNQGEXqCVbGWyK2zc0oogMs+L
         Qu7hrnXS6QoY3yJf7wYsfPBBLzaKg6YNSVGfgSUMjpjuWwBrgCKhiXHeCxPiP8QdnphC
         Vwro4UU01gExCDeXeifXXMD6MmHOwVdQzmeHoqQn+MOUMhvZX5wOqtfMytVnwELfoqyR
         zdCR3vwGKun2gyKXzyfs4aAhEGsZ3XvD4t+NFFLyU92rve6GS1BsTSI80ki38GA6LEKW
         tfS0SZmJrGMQ94zG0OuLatE7z+EYAY9FgZBLfYDBBe7KEocH811F6j0rm5B7tbEPffB5
         1AdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqytEEcMS1mqCwcMyzX1NNN09WnIk2Sa2oMTRgNqThHkGFDGTZ3/YhsRKfShgsfMhU3pMJH3sb6w++8NUr@vger.kernel.org, AJvYcCVOOnVmSVJ2cmHkcHBl+KMszHOMelOQ0yBnSuRr6sgpntOq0zWJOjvexuLe6y9hj7EMB7ORZ9X9OVAe@vger.kernel.org, AJvYcCX46Jwe3Ou8qV8X/ZgXoI4FBT7EDICi8SIII9F1zYzoTM/9FjvzqvLHlFNr9G8HgW3FT5Kq98e2vakQ@vger.kernel.org, AJvYcCXUVJ6pbtrhl+bpLihmPNa83pYEXkDT+lWlAYYyp/sLLmD4UGQ6UX3Mc0L7q1+Cd6yhOdYJhQXY/hNu6mwa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Gm2XSKbqFYQJgqDuGMzTE2RPa2uU1pS88j5lnsys3jYODLke
	AZ4JiDv6xMgolrNyZ9pdj3lEGS4EiyAxVQbmqsowdbu8CLcQgImm
X-Gm-Gg: ASbGncvT7rMqKFs0YgW9AkHUx/lRICABf26xGyJ9yyYGg+HXoRNMFiMqd7UzqxyN5q4
	Hm5P8eXAqkx0p/81kuLDwmsZzuTfaGzkm8m/J6EEjqvyMxXfsEwTb5nwJovmfJf2WQZ1IG0XIcx
	ectayvVTQunQ3z/Oal9d9Y0M7eIpbLtyXvoEXECjdyH80vmlOtONutNhQAC52XDxkkPaIGULFhd
	iJ2gmaxdAIu4f1YEXHyaGfu0Y6QojzPT6nmDcD02XCfYBkCb+PCRGUztYGvfvETLA56JsULo2X2
	AO9SGKyjlNdtos2+P5dlPjVjLUbliPT3kRUdm9TwW2Gi8FTyWW2EHYUKARTzE9v8OgrViAw57P3
	HH6Ou
X-Google-Smtp-Source: AGHT+IEkTvSswxO7SHDrOXgfTx8tntlEBKUKPjfmvp+LW9KVLQneY3F5dVvMti+uUCbeeniPuo+e+Q==
X-Received: by 2002:a05:6a20:12cb:b0:1ee:dd60:195b with SMTP id adf61e73a8af0-1f0fc98ea2amr15910629637.41.1740600381328;
        Wed, 26 Feb 2025 12:06:21 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81bbc7sm3959455b3a.127.2025.02.26.12.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:06:21 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 1/7] x86/hyperv: Fix output argument to hypercall that changes page visibility
Date: Wed, 26 Feb 2025 12:06:06 -0800
Message-Id: <20250226200612.2062-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226200612.2062-1-mhklinux@outlook.com>
References: <20250226200612.2062-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

The hypercall in hv_mark_gpa_visibility() is invoked with an input
argument and an output argument. The output argument ostensibly returns
the number of pages that were processed. But in fact, the hypercall does
not provide any output, so the output argument is spurious.

The spurious argument is harmless because Hyper-V ignores it, but in the
interest of correctness and to avoid the potential for future problems,
remove it.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
I have not provided a "Fixes:" tag because the error causes no impact.
There's no value in backporting the fix.

 arch/x86/hyperv/ivm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index dd68d9ad9b22..ec7880271cf9 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -464,7 +464,6 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 			   enum hv_mem_host_visibility visibility)
 {
 	struct hv_gpa_range_for_visibility *input;
-	u16 pages_processed;
 	u64 hv_status;
 	unsigned long flags;
 
@@ -493,7 +492,7 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 	memcpy((void *)input->gpa_page_list, pfn, count * sizeof(*pfn));
 	hv_status = hv_do_rep_hypercall(
 			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
-			0, input, &pages_processed);
+			0, input, NULL);
 	local_irq_restore(flags);
 
 	if (hv_result_success(hv_status))
-- 
2.25.1


