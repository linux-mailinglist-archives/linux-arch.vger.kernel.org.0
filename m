Return-Path: <linux-arch+bounces-12931-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367FEB10C9D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9A65834B4
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAFC2EBDFB;
	Thu, 24 Jul 2025 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpN1qSTE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103762EAB9F
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365411; cv=none; b=VfCRPUjLfnJm0w2Xc5wj99vqKvf6GZh9NZ34iQNQdJTu0CvARi0tuZN9AR7qYnQhRUhcOfeKQpfTO7Egixx8sPKzqcbX71n6j9w77xzAFz5uxeJ7105sXqbK8HfL1WfFYsUTRGwA5pxiD47UZeUfBWDQSHE9mOxkQ4CmSOL+NbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365411; c=relaxed/simple;
	bh=DC8BX+UCsCDL0s+QjMq45E4j2zLW64ooBSHspomP5gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7nBMCy9wnScuRoXoUC4oFU46rEwOT3yFVcfqRa8C8aWQ6XedrdC3kVp6dVOhCyt87MKSgh5BHFjezp8FlXqsa0EwXWgnQVvDRTJ6/uuVPQcnVDMelxuAcFUFZwG6G+Hqpill4tR/VHYIw0ym1vbyLh7//4Q0Bf6Z7ZUF0e0i2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bpN1qSTE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54700a463so670489f8f.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365405; x=1753970205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAPeYZVy8llrcCGwu3MIGe2nhyxNrtHRlXTr72itWZc=;
        b=bpN1qSTE5qttk/lJ/GnHbd0ERBi37+C3fAMBhgPXYw+BVR/WyOg0llV5z/0JJ7K2sm
         bDTGWXiQz/1Y6EShBsHND4rx8+2J9ALqjcHQvZA9S8raNMW9NIGuUxAR45E8oD5KIj3k
         MMeACj8mR3w8DdB1YvvhdJf0G1TcovVBN41fR8+CdmgJDlu7U4BinEBWL2j6PfzZmR1R
         WhGUVRXll9Qk0QS+28daFSbHOaE3DdEp/1s9q5S2tmvIzjk+efVkVWvH7AQ7oukiDmiM
         t3AyKk1j4j7YI6a84OnDQdFVn+XSH2YYYTVUJfV2hAAjoDwVPKh8P+A5rJcLcChPYEtp
         Z8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365405; x=1753970205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAPeYZVy8llrcCGwu3MIGe2nhyxNrtHRlXTr72itWZc=;
        b=PMaEDNStSLgAD1nzhYl5oo207OR3PeGbt90o6cjZDhHboTC26cUUNOEXB2DN6UpxYk
         +hqYL7QPEdg0mAX5BVNJAKyNHnILkKE3QUKmPIoqSVmT80HQyLsiku89vUaXTXlIJgs9
         28IoiquEeink8TUSBFUjoBvaWMApdCMyqZa3b7BEijnQspoJ+bSa2QtH/IuuVe6tg+wq
         tKKBDPPodjIxy80Pna3raaFv2+GDsYnEBlzPeCelFr7KKfbmtwx1iZwXUFL9iNjtfccx
         OUn7qpo3DsHlHqXSI0LVJrmDztRWzGWKfxfSoe73DNas4VwCzYzcoA3JwbfWgS434lqp
         GTIA==
X-Forwarded-Encrypted: i=1; AJvYcCWTFOFEAmrVTDRw5XFKld3ky6GnF3HJ09Gf2HIFqUwFOsBS0j2D5QbLh0DSLu86uZ2tKuMy7aKiMYwt@vger.kernel.org
X-Gm-Message-State: AOJu0YxTW6JZ1Jm2iiXvxjeVQJg536FW6CmFH1IF0waI+na06DMkMrRr
	Rbfkv2mXwSW1wAU08vZohjnBdC9Sv5Tt+A8mZRmLz/n+qCjVQEOwzMKdg5zfI5O33FA=
X-Gm-Gg: ASbGncusDTbarycLxR9DGoX8Zg6220TpwS+NRAqBhyOrAdMChwyh/p7JVDZhk+1y3XM
	EpNrI11Xik/8NDiYvesiWivqzZgxfKw2qR6zF8kc6NmRd9yui5/7nYA/oFY5LZFBdAouENq22Rx
	tKKIdbk+1PCAC81upBxb4uDCFWdiAuzP7UTFm3tm+iYfVhRyC8xJsSW8huoEdfgw4Eiw8rFjM+B
	3ZGzC3k2RJQy2qBOwOZ0OiA8digTp+DjEbfjzlDdfiEX/MoLGv7hChhSNnx8XGC+vm+l5yIHkmJ
	M1tQkm3AH1+ALFVUUVgQLmzh/5Gd4EDsF9LVYadKSrBb2jMXbBYS1UHbcA7rJakJdbFKHRuT2u7
	kuBN92hcocy3aE3yqYeTO/NDbxOgVCbmJH/MvV0Lk4v/X2dWmPpYMAMR99THZ2IIl0KxUwPQNDc
	yW8mNThYHGQtr2
X-Google-Smtp-Source: AGHT+IE/tOxCaZJgBIx1z77DRVJHCm2c/RVz26viacIOb6VPqsOvedK5J5brFqoj/rS9r4t912qyvQ==
X-Received: by 2002:a05:6000:2482:b0:3a4:e1f5:41f4 with SMTP id ffacd0b85a97d-3b771356cacmr1929316f8f.17.1753365404772;
        Thu, 24 Jul 2025 06:56:44 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:44 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 25/29] kmemdump: Add additional symbols to the coreimage
Date: Thu, 24 Jul 2025 16:55:08 +0300
Message-ID: <20250724135512.518487-26-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add additional symbols which are required by specific platforms
firmware for dumping an image.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 include/linux/kmemdump.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/kmemdump.h b/include/linux/kmemdump.h
index 7933915c2c78..94493297d643 100644
--- a/include/linux/kmemdump.h
+++ b/include/linux/kmemdump.h
@@ -35,6 +35,22 @@ enum kmemdump_uid {
 	KMEMDUMP_ID_COREIMAGE_high_memory,
 	KMEMDUMP_ID_COREIMAGE_init_mm,
 	KMEMDUMP_ID_COREIMAGE_init_mm_pgd,
+	KMEMDUMP_ID_COREIMAGE__sinittext,
+	KMEMDUMP_ID_COREIMAGE__einittext,
+	KMEMDUMP_ID_COREIMAGE__end,
+	KMEMDUMP_ID_COREIMAGE__text,
+	KMEMDUMP_ID_COREIMAGE__stext,
+	KMEMDUMP_ID_COREIMAGE__etext,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_num_syms,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_relative_base,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_offsets,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_names,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_token_table,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_token_index,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_markers,
+	KMEMDUMP_ID_COREIMAGE_kallsyms_seqs_of_names,
+	KMEMDUMP_ID_COREIMAGE_swapper_pg_dir,
+	KMEMDUMP_ID_COREIMAGE_init_uts_ns_name,
 	KMEMDUMP_ID_USER_START,
 	KMEMDUMP_ID_USER_END,
 	KMEMDUMP_ID_NO_ID,
-- 
2.43.0


