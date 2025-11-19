Return-Path: <linux-arch+bounces-14930-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 847E2C6FBF5
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3A4342EBFF
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CA736A03D;
	Wed, 19 Nov 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6sLEfh9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC9D2E6CC8
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567141; cv=none; b=MihGUoYDC17VuzCNCW8SQ9Wwo55VkixvN8B034rUeOP0JNuIl/Zg26TCKPo7ec+C+nxcqbOKxet5X/agbcXyFUe4/t284iAEWXsHJAWePtC/RnqKRE1bbkCVMD+IHV+uD2bRewvyx4wTb4YFvPSJlOmVF6Vu9zQYlUCfrcN0pug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567141; c=relaxed/simple;
	bh=+VK7KRl6+Lq6c3QG0QoLNUfpAYwW2X9fA09G/NfS6uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlmaIfwB5tulSXuh4ouSwY196zwRbdnZUhk/x+kpxxZv9fNbtkbOO4fZ601Mkkxf9qtGoFuQmQNZr/2G9cEVQIQow7J2abOgcgYZglA7GunQyJ7ctY+LndSqvmOEZpt/GLkrqzrpFHcBPBy0lC1Y1zATlQIKwA+tpXWqPEFBwtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j6sLEfh9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c48e05aeso712916f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567134; x=1764171934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuFAdi/dQ7TYcP6kPKC/D+o7MTxWjWW8Ku2RD10GvbQ=;
        b=j6sLEfh9uv7+dsvFnDqDQa6anzRkocsy8dt+OoGqRNipZTLpbhM0kN8gp+hG0HbaBs
         MMBo7xYfGVPH43vHvKGRCgch64x3w+5gOHyhKTn6HQ+sYqIorf4m52B2SrG4bBRx89Ci
         k7s7HPQsG+hLYQe0dBWwwYUE3j83EEMt+amQKWLX6AugMw0fo3ZbbVB5M+piJ6Meo17+
         DvU/V8qk2/79vb7SU4ODsNiDcw+a5f4qtSc80/uGNdJXinhamtY1cOT2Gtifllx8JCIq
         7cY4R9Y0192OrEL58Af8mu4tpPfVY0/Be+sl7rGwPj7IfS35Td5zUv2USdiF44V8DV8K
         PVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567134; x=1764171934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AuFAdi/dQ7TYcP6kPKC/D+o7MTxWjWW8Ku2RD10GvbQ=;
        b=Ni+W1qEZ1JLsLmHz7RwZ1SwQQJ6qrapI3zmEPhAeLpVnML4esGv8DoD1F3LryuQV82
         UeKXzwvhjRhgjKsrzs6mPL7x6nrz7VLvHLQzbczL1gnbTaFaPHrMXlQUyCuRo/lTgEoh
         p1NOtpoHB43B9h0q5PtbNt/TpwVXjnVbv3I2nhiHhWtLufJH2/x5r+XKbpL4yQK+LLyN
         2VDCRZGoMKH3J0/x1pf+GpzIf4zImU9NBMwk5aeMZMrZLHnruiYrdrxuNNiakv1yFJDt
         V98jz1sBVz4Lo+LaIH/cBlJ2sgPVvNFwCXAFXPRyc/ejQzav3hayAjfZbMiuZ+cxiH57
         jGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvLSCV+pJfZVSAkdJ4M8NAr34h/D03B+vVUknadJXdLwSgXwnAaToB/81rBROOJGJuXBN89Ly9yXXs@vger.kernel.org
X-Gm-Message-State: AOJu0YzGB2mBF7z0OWDq6JvLWJPClQ3uoqcVueF24uuuyRohMmDm/PM9
	Z/vnVLd5Cbv94L6PD3cNxzGQSoTQwRn06QoEadnc9TYmXH+1M+GcpQKObBrhbmAHNV4=
X-Gm-Gg: ASbGnctIPLf92orugCr9kKS/ZZKKYJGFzNpBwBtwnYSva7tBWLA29vwigMn3xwdBd/f
	wO+JRwYm7xu83ETc3N8tDRdD6yXurTsKVAQqRzM7ABbIROoYVFqfYg5ktBokeZkpZDyCiT367wa
	qd3Ulgr0l6dLfNb8C+LOzX9iRNM0T5VGOxN6yR9+fdYzl7eGj5k+QrCp4EpKNR8BZILtJXqw/7D
	562S/arjCffHzcpO3Mo2iLnnQuvrbv7JmKdQSUjtD7DjXJNN9iGDWMF8o+bbpB1f+ztM6t8BG+T
	AiSKXBc9eIa9Mt1iBxHnAIifwDq6wRZlbLHi4WFyuGfuw8+i4oyvL0MPIjODlziQ0TcgBWmWPXI
	FlTU78rz5V2eGJBeYG6zxOWoieHedNj1u7ytz6Y/Bg+BfBhIdFTGXRjJfcQRxEGqJpNpZC7KY3H
	fcflmV1GOnih9ZLeHSSEa9r4VWI3AcVw==
X-Google-Smtp-Source: AGHT+IEEW1UNe8+i9pRkQXcVi1K6qHmkkggtbzPn6ocK+c8Bp9XYSPJPKkUMg9h5XQagLem1rvsEdA==
X-Received: by 2002:a05:6000:26d0:b0:429:eb80:11f5 with SMTP id ffacd0b85a97d-42cb20e4a02mr3468125f8f.26.1763567134112;
        Wed, 19 Nov 2025 07:45:34 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:33 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 10/26] mm/swapfile: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:11 +0200
Message-ID: <20251119154427.1033475-11-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into inspection table:
 - nr_swapfiles

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/swapfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 10760240a3a2..ee677be19041 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -42,6 +42,7 @@
 #include <linux/suspend.h>
 #include <linux/zswap.h>
 #include <linux/plist.h>
+#include <linux/meminspect.h>
 
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
@@ -65,6 +66,7 @@ static void move_cluster(struct swap_info_struct *si,
 
 static DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
+MEMINSPECT_SIMPLE_ENTRY(nr_swapfiles);
 atomic_long_t nr_swap_pages;
 /*
  * Some modules use swappable objects and may try to swap them out under
-- 
2.43.0


