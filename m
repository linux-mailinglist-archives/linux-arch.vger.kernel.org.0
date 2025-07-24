Return-Path: <linux-arch+bounces-12909-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEBEB10C46
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 15:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BAC57B5DA4
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468F32E174F;
	Thu, 24 Jul 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NnjTYfIk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179702DEA8A
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365389; cv=none; b=HLAdX+IGmixPfmgiY+HLn84vvzmk7aOQPxBNvF3Xav03CFh+ueDYhzVcGCq7+92gxdIVrtNvt3jXB8NdWZzKEWTfJOjjqMakm/DbSjvUQFsDV0KRodggABsP+JBXkMeHWpbdCNObN+9ZG4H2ZAT7f48UqGTLNNvU4zNK719AraM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365389; c=relaxed/simple;
	bh=I45+7S3jIU0dNMjyY0XWrWua5DCAvAPB8OAPs7f8VDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZarstr3a1Nu5W19HIHSZN7FXNAb9r2sOpAgf1w1RswTHUqbRCCVP99f17TGlx5DRtxR8Kba+MyUu/1pQHYCLkwL2YZXVzMh/QLgKWnYS/qJWkT/Oa9nyY7fizkXeexj1JnaxhWYb3MeXuQF21clK0zG2tjgyFKj7co4jRQNhys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NnjTYfIk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45600581226so10579545e9.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365385; x=1753970185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6vaDGqz93WFfpGOQ4UOrak1EBQhkmEoatVxlVsxTPs=;
        b=NnjTYfIkoofWBpyRAUQVrPINFMHx6ciLZrAV3551c/s6Bj1eu732dX5Sw4jJritVva
         fnALdGP4ixmhlSo2YP+i2J5UVqKiq4Z/HvlNvym7QH1ERjo6JRMClZDHb2+uCVkKv6qA
         SSgQ/q3VMTU/BUyiKphTinzhE987stIVuRh59Nv/roytHJcP8ZDeI5/sX1+TRYO94HbO
         zkCevDJTtJIdsndC2GstqBIpVfeDvKB35SSg28H7MZ0nxa7MNiJzIka4YGQvxums+hZA
         uLxS0NOrEzL1WroNaPvAzx7yd1q0ilyUzo8DK6if+U60oMf010Icukd9OPspDyfp1CPG
         Zp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365385; x=1753970185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6vaDGqz93WFfpGOQ4UOrak1EBQhkmEoatVxlVsxTPs=;
        b=u/Kr6Po/DQGiaekf2GA0d8VJRI17RwqTLHkIvfHUSFCsnQwUDUGqs1E/TcQvZPWeqW
         8jB0KbuclN+qufzgnO6RDvAibrZkbkudCVBTBN4vuWu5DQYTGHvk4Z9XE3VBOZneKHvS
         HFQKcElaeAbBzrtJQ2zcWmC2LAzpw2gAvNhN+QpcXbbpnuKrT3MTOkfFZJ6D84SYxJpt
         878EFSfpah6nINfuVyeDYApbMMC24bdrlJjn3oERTHPP1VyrZv9ohzv9FKCoMGgr8Aww
         fWk4jijDp8mfUad8crq0YCVqVErwLC72SBrWnY1dhnTmvLB4k17iuWZ7KSdvHsMLcRWP
         XRmg==
X-Forwarded-Encrypted: i=1; AJvYcCVj2snujbfyhxk8qE7khXjykt0/ChbY6BpcwMYkxTt4cRcrYcRjrajKItf7aEw5smxa7L7fr9iKpivz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/RDC6C9ufSb2O0f3kOhMZJ7bbWsmuutRwZW3SXSB/D7W/W9z0
	N7qyw+6Bt+wC/8pTBrBtwnbmmh9XcXcwgzJL7edZ2HZIcwAJcf6sRbecdmYlEBGKsOA=
X-Gm-Gg: ASbGnctC5b3lucGUNoB1b7wDt4YIgfnijIAg+RIflGe7N7HJkvWESbWEh03wxiWdiJG
	yM9coVwgrqk2UCXf7ohWUZg5iWIEzfnWFTyquQ6GApaQD0bsvsYMZ1RcBga8/OujgtPmYw9o/Vj
	6b5W1HFDKsR4IEbGM9g0T3yavxFno+OGpDW/CtMuthQD42LkA78QlFx5df8aBl3i0k/KLQ9+8Vj
	lg/1IX+g5idc9FU8LQkmA6GIpBvBF+6ftap+WrmhRkK7a2O3OE7hFjlG3UOAPWz/fU+2Omtpw46
	odZcipPv5ieEuf+syNqF0NgNwC0tQOYjxaOde/gQjPtkihReCMWUMrNZ9Fz7dA5Qaa38UYBGfAN
	drMWfsHbOOxq1rVX9l7pympHSYCPqFvk0plvK0t+nEkYskN3T7kwjSG1GJNoj8PkUyqvQf1st5T
	AXUWTNFzxlvw5T
X-Google-Smtp-Source: AGHT+IHYnD8d7A8aBh+5tnrqY0LYzarTFZbBZJYJd44Ilh6yiLc/UVbK9j+FmYRR9VqOWZQpLWbc7Q==
X-Received: by 2002:a05:600c:500d:b0:441:a715:664a with SMTP id 5b1f17b1804b1-45868d3289cmr52540145e9.20.1753365385393;
        Thu, 24 Jul 2025 06:56:25 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:25 -0700 (PDT)
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
Subject: [RFC][PATCH v2 04/29] Documentation: kmemdump: add section for coreimage ELF
Date: Thu, 24 Jul 2025 16:54:47 +0300
Message-ID: <20250724135512.518487-5-eugen.hristev@linaro.org>
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

Add section describing the utility of coreimage ELF generation for
kmemdump.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 Documentation/debug/kmemdump.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/debug/kmemdump.rst b/Documentation/debug/kmemdump.rst
index 3301abcaed7e..9c2c23911242 100644
--- a/Documentation/debug/kmemdump.rst
+++ b/Documentation/debug/kmemdump.rst
@@ -17,6 +17,12 @@ kmemdump allows a backend to be connected, this backend interfaces a
 specific hardware that can debug or dump the memory registered into
 kmemdump.
 
+kmemdump can also prepare specific regions of the kernel that can be
+put together to form a minimal core image file. To achieve this, the first
+region is an ELF header with program headers for each region, and specific
+ELF NOTE section with vmcoreinfo. To enable this feature, use
+`CONFIG_KMEMDUMP_COREIMAGE`.
+
 kmemdump Internals
 =============
 
-- 
2.43.0


