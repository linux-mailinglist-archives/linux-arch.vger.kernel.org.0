Return-Path: <linux-arch+bounces-12928-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AC4B10C90
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A46B02748
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193E12EACEF;
	Thu, 24 Jul 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVQlTHGJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A72E9ED3
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365407; cv=none; b=GN+REbTc2+ei0fuQ96Mj/VneiUqx+03dsJYQ7ocvxSZXXFnHarZ1vqTeK/+CDEY6gs0kbFLislPjWPIe+vj834Bbkswz6AwgKppK9KLL6B+6VXk8M+V3q5Rnxq9zOdivMMuj9ZIxbtQDmHvYjVDGVp0LBFrSboIAnXVh1d9DcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365407; c=relaxed/simple;
	bh=5jI4DslkjyJiQZE2KZ1KI70K82ssb8psrTPB6JrU6fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYHZhfSJTkZ5CX7xV4rjhNcIzijM7PWzQ6tnqMyRqMDsAiYnqbSOZuv3k49LKuq0E08h9sFGxmBb4EAOILnQnDLSB8/9Qhn+/isM7ONtIrM7lkTrqC9A9h5mgJ2+HX+AwSDNIbDKM7Yk5hjsZZhB/P+aIojJarSLI8/9zmdIsEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iVQlTHGJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-456108bf94bso6529805e9.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365402; x=1753970202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx+zx3hCg8Qz6JMSxLg+rjsObdnsN3uv3uvSypyoc0Q=;
        b=iVQlTHGJ4xtQ7RNKSFLjRG0xpbvSMhSWzygQvQWNrpIweobCi7oEbrHSeBlt+DniE4
         4xhPpdciMiwjDaxlqgi/WQNTk02AB0hzNo5/qgY7M7d0ovROZDKA5vOdLDwrKyMJpBpL
         rbxBWa1ZGy/4Syc7iYRijahPPiJrPpMfo5SloRBdOdPRV4tsZC+eXB2eKg4yrK6ayet/
         u8/5SDt6TKYe9IUDX7wtVjISOMDsBnM0RRcwIsmuYEXo4c1Ho9vDY06487FUd6ol9XWm
         y0hG4uwNd8ulghEu4SHFN/pLexUeHGf+c+3veUu3YpR90dqYiRMHJ7QKyu3WUxLKFYq4
         YNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365402; x=1753970202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx+zx3hCg8Qz6JMSxLg+rjsObdnsN3uv3uvSypyoc0Q=;
        b=ZaFKWdfoGaQsiQtdJ1i911oIzaRSVN9OmKjFH9PkGQuqkXnC6YLd92dwpKPrB1eUx/
         IeQ3MOmiEm8jXeprMkxJTQmYyGxHFMAFnZKPEbAjaFTuRflPG7+2e74mgOxglGjMtnLy
         wEE0+xGZLbcn4NE3RRJ4rGf7t/KimGtvZZJjM7QuMZF3konbluNnOY0xdcJA1xZvld26
         jsyeXJ2ObZ9JXH1iKzdb9EP0P2hsl/+QszYFitb9a1qcHZ9oIJvGxXkp1uyMYEt3BysN
         8rc4FG9tnSLsaS08OhmqhgClaYQDPj2+xnZimqPHrXFqOmDUg6asrJcGTBV6kc0Di5r4
         tH1w==
X-Forwarded-Encrypted: i=1; AJvYcCWig4Dc22ZrD2fv3foobYLBz6maQYoBCGGlveRCk5u1PrhM74TB+rRy1sN/WvRzBvycVnmK4IWI8nR6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu0hDQlbT5ZBoi683yKRQRRCJefLKqjnzI0crf9Kz1lWzDZpmN
	Ancf3u7VpaxufOIOSRqwAClHlYVx1g1nO3kuvg3C5BiQ/B7OKDFUbXIuxMwrkDfYY5VuCuGLHbo
	02bVkJdY=
X-Gm-Gg: ASbGnctlFHAprd/ULKpmKtDcG3cRzhy0zgf+7Ks2+9Ubm7HlE0m4QfVQxZ4DOH2tkGp
	o0m5Q0dl7WawolC1QLv8ARBiXa9ae94onQnlQT91tRIlDxNNJ0kV7mmj7yz1wKWt9BumDzxLHoG
	pc9UQ4w+mkClWP09LubCE4yqj6Qj0RbwNTstZkVf0NlejlxEd5fE68fsGGOumTSIKkG7aX1WN9D
	nAVt4zTShCpwWSNkEpMOwln/l96VLjb5DCCMPos8ePWyj8KCGBAgVE6rFAU7TplCNLb6BjcmeDI
	TT/jQdAP1yVGdplDq9kI1ikPiwC/2nomw8pLZVqtr1M5aIuuSqbpiHVKiE51ilRMnsKJ2S1UFXs
	bgLPP7HGqPfjyYe0tYeGlMGESEvrvTq3olNHed+3o/V40XRYDXfS1p4n1uOiMohSjKowh5+jAZs
	802Vj3kXUPOgZQ
X-Google-Smtp-Source: AGHT+IGliARSjFjzMbqI3XaGwe/LefU8e+9kx8i0i+1k/+nyeMB8SAYvSTjLiytSObV6pAe7PVl9aw==
X-Received: by 2002:a05:600c:3583:b0:456:161c:3d77 with SMTP id 5b1f17b1804b1-45868cff2b8mr75404365e9.16.1753365402037;
        Thu, 24 Jul 2025 06:56:42 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:41 -0700 (PDT)
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
Subject: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:05 +0300
Message-ID: <20250724135512.518487-23-eugen.hristev@linaro.org>
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
 - node_data

Information on these variables is stored into dedicated kmemdump section.

Register dynamic information into kmemdump:
 - dynamic node data for each node

This information is being allocated for each node, as physical address,
so call kmemdump_phys_alloc_size that will allocate an unique kmemdump
uid, and register the virtual address.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/numa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/numa.c b/mm/numa.c
index 7d5e06fe5bd4..88cada571171 100644
--- a/mm/numa.c
+++ b/mm/numa.c
@@ -4,9 +4,11 @@
 #include <linux/printk.h>
 #include <linux/numa.h>
 #include <linux/numa_memblks.h>
+#include <linux/kmemdump.h>
 
 struct pglist_data *node_data[MAX_NUMNODES];
 EXPORT_SYMBOL(node_data);
+KMEMDUMP_VAR_CORE(node_data, MAX_NUMNODES * sizeof(struct pglist_data));
 
 /* Allocate NODE_DATA for a node on the local memory */
 void __init alloc_node_data(int nid)
@@ -16,7 +18,8 @@ void __init alloc_node_data(int nid)
 	int tnid;
 
 	/* Allocate node data.  Try node-local memory and then any node. */
-	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
+	nd_pa = kmemdump_phys_alloc_size(nd_size, memblock_phys_alloc_try_nid,
+					 nd_size, SMP_CACHE_BYTES, nid);
 	if (!nd_pa)
 		panic("Cannot allocate %zu bytes for node %d data\n",
 		      nd_size, nid);
-- 
2.43.0


