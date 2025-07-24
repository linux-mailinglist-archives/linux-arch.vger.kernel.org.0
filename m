Return-Path: <linux-arch+bounces-12929-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B76B10C92
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34305B02ACB
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD0D2EAD0C;
	Thu, 24 Jul 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iClEbVMJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472CB2E091B
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365408; cv=none; b=mtcHKVT8XiGP73VuYGLIhLCA22OX1KCD2+ddQ8cKw8cD+VYoX400U7t/jQD8d3OH6trKPt3xqrsknyf8A/wrA7+uMdWX+hTQaQ9fZv5/Y6/ALyPjH2ItjUKhtKYMUIUEibuSl80E8ruagIuIYlcP/kqBj5VBOiMNNaNs5INl39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365408; c=relaxed/simple;
	bh=4mzNhzQY8HFx0bk+CHpi6+2DgmZYfQ8vHH6EB20MlrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMxjK+eRLnJNpS/T15GfYNxVyBBXGTLyezZjBAHdU8vtNlQkJx6GAe91+2FKv9yF9POi90qpRRGB+dlqnDykNhUZKb/M1YbdxIbpMWQoRTgGB0IbEiY9S9YRaKuTpFrqexknBp+ye83DdmBL8NZluyYXKo2j43nZr53xZ/BGWP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iClEbVMJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so521006f8f.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365403; x=1753970203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5mN880WCISqsqqypOE0OCrYzPzbEuiPZ0HVDAJk/kA=;
        b=iClEbVMJGbk/PyxXaSMMcxMAAqWn6IMjOCGbXGY4SbpO6tWlrOvED9WZH1STFKee6Y
         hHtDKSjj9AXb/itAOMfu+NlNgcBkRokxFC5lEdIpCJJ+u0F3wh8ftd0RFHgtT2YaraSq
         ketGNDB0x/WxBU3SwLV8Obj3mnpIWnW4qIcuRREvISdg4EGUpwQhA4rQRanVEWxhschX
         QLhS77NmD3AasXN5Yqd1WPeHDUyi4MJVAtLajTy+fiY3NdBPLN5juxw4sHLap8dmWM+E
         K4f+4lYqgXd1aplpdLav6VbqVnXZ3qrRTthuhfvreR8lU17u+Vsgb2/2AhqcfcZPWSjc
         BIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365403; x=1753970203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5mN880WCISqsqqypOE0OCrYzPzbEuiPZ0HVDAJk/kA=;
        b=RzWEbRKHAMmYjtTErr2UGkPUUg+lxJ5MAUJH9lSMCftcI9JAFWUkgKgFbo9k85kLnF
         4GSXIa8S4m//W4wryRRuCL57pJ3//StD57fgt/vcADgCnzdb4ktVzkg7tFXGn5Sb1SHf
         9wgvKlMFzJpvO3qUjLOi7di7z+/siX8dQCd6CHkf6+9UYW6kHaFvamb5krSyvBFJMne0
         VS2P4QghpZGn2xUb8PLkWKhicqJkOHSGgcfAAdURPqoGoLKTQn56sKdpmIKTrYhNE7Bo
         0NiHa8yEq5t/BpcLKhJD+p5Jg5PY/4hmshvYEQ5ifvJZqgHsjck8yxs5wWvMSDc2vil8
         E2og==
X-Forwarded-Encrypted: i=1; AJvYcCWgMOOFSuASBsX7AQR2OT+Rz+ucUrsvLa9nUQSlgGQVxu8VmcXYG0/e6xRfXawuLtxB/kzzVYRAUTkX@vger.kernel.org
X-Gm-Message-State: AOJu0YxXiaThcH4KRbWwKecUK5PfgQgUkvpKYx+N9ntZ9q8CTsx09T5d
	nBCYeo/WyyeSN1LkHH9mUk5byOjtsD8WL7zxGkXvjGRni4eta9pi1D719PidmkDhwD0=
X-Gm-Gg: ASbGncvB1JZKnW4HIt6rr5fvmIN71i6JYetFZIr/1fZQ/e5IqG/lB8m3TT7uyh8gHEV
	RqvI7ibo3puXUAaxiuk/tGBEEzgBTVesU9R4Dr0U/an+7GZiSn2HAfr8YS8uX0jxF9JNr8P9XxG
	yY/wwClVC1D5YYREC9lXWcNj0DyQzfIKqqdhtNuc412WCrtPLSeePi/tNjvsBC0mGXIHOoYBdhI
	DLtncLGTswmI6ARGHxyyPICIiYmRtj5Ygq6kIMKkmnviDZjGwOurQzBiEsa/1oKSDVYAS5QyLuE
	azCXiOqAC0WuE/gJoBBrcFlZSWxanlr02zvzQe0v0fEaGmY0xRjClXnlh8GyU/rmADikk3S3t4j
	YfuIPX1pUxhV7TJz8Uv+1OUoB+MhOROFPAzo4q/HoRM5b9rckDmxtwjKE+zpXPo25SQdc8nY92t
	uXLwkfYkQae5Ga2DeWNiDvSfE=
X-Google-Smtp-Source: AGHT+IF4egT06XIAWuc0TJnVdNpe1wQ7sn3xvEGeH8Rc0pzDJnMJjBpN4GYnZW+sz3u5f7Eq0JGLQw==
X-Received: by 2002:a05:6000:3103:b0:3b5:dc05:79b with SMTP id ffacd0b85a97d-3b768cb0f15mr6041122f8f.14.1753365402888;
        Thu, 24 Jul 2025 06:56:42 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:42 -0700 (PDT)
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
Subject: [RFC][PATCH v2 23/29] mm/sparse: Register information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:06 +0300
Message-ID: <20250724135512.518487-24-eugen.hristev@linaro.org>
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

Annotate vital static information into kmemdump:
 - mem_section

Information on these variables is stored into dedicated kmemdump section.

Register dynamic information into kmemdump:
 - section
 - mem_section_usage

This information is being allocated for each node, so call
kmemdump_alloc_size that will allocate an unique kmemdump uid, and
register the address.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/sparse.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 3c012cf83cc2..04b1b679a2ad 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -15,6 +15,7 @@
 #include <linux/swapops.h>
 #include <linux/bootmem_info.h>
 #include <linux/vmstat.h>
+#include <linux/kmemdump.h>
 #include "internal.h"
 #include <asm/dma.h>
 
@@ -30,6 +31,7 @@ struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
 	____cacheline_internodealigned_in_smp;
 #endif
 EXPORT_SYMBOL(mem_section);
+KMEMDUMP_VAR_CORE(mem_section, sizeof(mem_section));
 
 #ifdef NODE_NOT_IN_PAGE_FLAGS
 /*
@@ -67,10 +69,11 @@ static noinline struct mem_section __ref *sparse_index_alloc(int nid)
 				   sizeof(struct mem_section);
 
 	if (slab_is_available()) {
-		section = kzalloc_node(array_size, GFP_KERNEL, nid);
+		section = kmemdump_alloc_size(array_size, kzalloc_node,
+					      array_size, GFP_KERNEL, nid);
 	} else {
-		section = memblock_alloc_node(array_size, SMP_CACHE_BYTES,
-					      nid);
+		section = kmemdump_alloc_size(array_size, memblock_alloc_node,
+					      array_size, SMP_CACHE_BYTES, nid);
 		if (!section)
 			panic("%s: Failed to allocate %lu bytes nid=%d\n",
 			      __func__, array_size, nid);
@@ -252,7 +255,9 @@ static void __init memblocks_present(void)
 
 		size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
 		align = 1 << (INTERNODE_CACHE_SHIFT);
-		mem_section = memblock_alloc_or_panic(size, align);
+		mem_section = kmemdump_alloc_id_size(KMEMDUMP_ID_COREIMAGE_MEMSECT,
+						     size, memblock_alloc_or_panic,
+						     size, align);
 	}
 #endif
 
@@ -338,7 +343,8 @@ sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
 	limit = goal + (1UL << PA_SECTION_SHIFT);
 	nid = early_pfn_to_nid(goal >> PAGE_SHIFT);
 again:
-	usage = memblock_alloc_try_nid(size, SMP_CACHE_BYTES, goal, limit, nid);
+	usage = kmemdump_alloc_size(size, memblock_alloc_try_nid, size,
+				    SMP_CACHE_BYTES, goal, limit, nid);
 	if (!usage && limit) {
 		limit = MEMBLOCK_ALLOC_ACCESSIBLE;
 		goto again;
-- 
2.43.0


