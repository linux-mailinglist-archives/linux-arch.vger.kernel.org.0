Return-Path: <linux-arch+bounces-12922-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF58B10C7E
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485341691F0
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58652E7177;
	Thu, 24 Jul 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtHD+ISg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C92E765D
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365402; cv=none; b=Xrni0jxzomiGubTckUz8IuhVJKVFls1swqiM7XzMWvJXkT+IsledG4RM2Swm0RM5VGtCIl57a0iTFSYPw1zh+hj87ox+Xdgm9fJywU+gLweqyZ1hoiLd1sU6/vfKh8GdNO8fpLy4q3/VWtIY+tASvRIqa7G/AMyhWChnmYd3+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365402; c=relaxed/simple;
	bh=kDQ1UVsh8/N1GCc/zzfiOopIyL3CRcZ04ezY899nhXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UooL7S3JFaWwqgKmWAqgiOzRrRGzuTejm0Tj3Zs63GZWfV2VK+5V5fNXsx6yCeFZqJ7Oe/Abqr8hwOLd9ZOYrC520Obk7ccrzte5QdKL5zK7d7kfaV0xMLeQDzn04Bwag/Wu0NfKkdubtborh/rbjhhJHArxOEUWCmpg8KuXWws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mtHD+ISg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so10699555e9.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365397; x=1753970197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX4Svte8gqoaTLJ1gLDVO4a7qJdtBtTgEqouOAtsRZg=;
        b=mtHD+ISgSM+SUfi253ZtmszbOMyw9ORPp7cADqLUVvtUQSh+F2uKGW/HoI+6/G8h+b
         sgquvAhnD90ntjDcj493uMRFktkg0EB3wJdjEsJffTHNTqZvaBbR4T6UlnV63KAgJu50
         m8mhqe8AUSug1EtN8ewwaTIHIaTaMF1/2/ELIKaNg7AZaxcfN+A1nTo23afrhhqnk0mc
         yzsgOXEQE7HAgnyWUvWTbiCJPteSDFEDgILZsOtDaEweLOzn4WmfwXgGka8te1qf8YjK
         qRU+D/j+Wfz273ZqaD6mk4O8BQRoVRpM4s3MPjVrrTna5m6Vj38zKVqQHrOwG1Uq1xQr
         d6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365397; x=1753970197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fX4Svte8gqoaTLJ1gLDVO4a7qJdtBtTgEqouOAtsRZg=;
        b=O2WBIh1wlyBfgA8DbE/zcRZGZk23x6BCW4RjSNrdgjT3yvUffJAzZeEqLOBtElU9ty
         ww+QWKI5Y80DppmeVCzKfbiV1WPt/RcB6FOdIqDtQdDo2wqFhgs7KxWI0OHJYMIu7Ezk
         IH1vM/HY0VAOvH/vh/gnDkYnzy6oEbwPwD4sOd1HDDTer81JaTlf4RA8vGwIeNZzuraJ
         JXSu5wVjDCvc6FUSR96npgR4J/3BJ461vOvwtMauZ+1hqaXxm0zKUz9FZbYeT0tCBzD7
         eEQTjSFac5n/EVToZKTCKJsuYajPbd7YD7Rb7Uqt6AL+1s2YATG85Tvci2mwdxCIdy/U
         l3tA==
X-Forwarded-Encrypted: i=1; AJvYcCWja5biYevoj+XWCCGpU7AOngdHiMvdHwg+ywIoBDQuTIUjQMShN1YGjGWV73dkGo7P2l3kbMYXOmW/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmi7Kp8I87HsOTd4mau4tDjn9my/ZQ9wdvR2FYeFu/OP4YD/Lv
	64NtOgl7Sbjm5AzJhhuTwkR80R6dOusovyHKDG+iOEXMijt95CL4z8hClsYt7mYoVh4=
X-Gm-Gg: ASbGnctoS49ouRJTfjAUWoPG06WD0S5Dln/6XG0ItsAzGc+pEOvbnLCg0Q/wCYi2hcp
	+4iv74pGCKDVgExHAEPou6ZhCllY7sfMklVBkEdp6Wx//Md+hU3A/XGV1D48yD4vVsLJoiT+Ehj
	0WkDn7sv9vC6u9Bz1JdFblABh3vcOy2U7BvhrTqP+4ooEp5SuYQ6EWls5qmvCTNyxgpPTpKYEP5
	NSOuK3960Te59QTf7T2QtP0fsfyjXM7Yu8Rz2YPcee7MjymXyYbQKE05xwqOGYn/Ymve7ErkOas
	QmhkXtqDdZ2oZ/ZZVITaHtCfl/RV+cQz+gNDmC/WVThWmHlMvMtxZx7eprTCZvSyF1gdVxpL+wk
	JFRnjJp0mt4IXKkAFL5v/WW/8LODBZbxQDB1V7At6x6It7DILVV2oSyjwIgAHvkLrCsCHDEqr8s
	dNAUZ343SE+pUH/AUS8SqmiR8=
X-Google-Smtp-Source: AGHT+IEQVvnmK8e1EDhTYEG0c9433X/scuppejD17sDlP6XiymAvLgXWbUNkWttS4mn1l7PUSu9quQ==
X-Received: by 2002:a05:600c:6090:b0:456:18ca:68fd with SMTP id 5b1f17b1804b1-4587118251dmr22564675e9.10.1753365396747;
        Thu, 24 Jul 2025 06:56:36 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:36 -0700 (PDT)
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
Subject: [RFC][PATCH v2 16/29] mm/show_mem: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:59 +0300
Message-ID: <20250724135512.518487-17-eugen.hristev@linaro.org>
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
 - _totalram_pages

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/show_mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 41999e94a56d..93a5dc041ae1 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -14,12 +14,14 @@
 #include <linux/mmzone.h>
 #include <linux/swap.h>
 #include <linux/vmstat.h>
+#include <linux/kmemdump.h>
 
 #include "internal.h"
 #include "swap.h"
 
 atomic_long_t _totalram_pages __read_mostly;
 EXPORT_SYMBOL(_totalram_pages);
+KMEMDUMP_VAR_CORE(_totalram_pages, sizeof(_totalram_pages));
 unsigned long totalreserve_pages __read_mostly;
 unsigned long totalcma_pages __read_mostly;
 
-- 
2.43.0


