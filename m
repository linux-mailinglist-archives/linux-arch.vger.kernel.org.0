Return-Path: <linux-arch+bounces-12920-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DFBB10C61
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 15:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4C17BBA64
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B942E8894;
	Thu, 24 Jul 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKo7RQFf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C72E62C6
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365399; cv=none; b=gUI5b+pe2YGc/61RhPV+Rv97BhFwbaDHVRBtWaqHwGn+vos9AJ2k9TBuw4cLMk4dwU/bt6EyJbzYxEj5WDbVEp0heV+dw4znYLsRqrMPs0WrYa9qw1AAU7BxTuphIdBGegPj+cEIJ2mPgkF00u/CcRzw+0bIxxXBx7vmIEuMsik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365399; c=relaxed/simple;
	bh=Zu6zHICMsbDr9iEKVVQXs5NvRmjCVnu1EFLIYvz+qoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZQ1q7YHO0HKjTejnRBs/eTevJV6VvgMmXzqK1JHVpFRUnqwEAIW/KwrL8VOEqUF9EPOl8K1gXAQyk05XQFTgbeR8vhYQ7jEY8jePYPLOtjhrysg0L8+ZRj+D9cVX1jAjBVasTu+sstBMuwyrzqueP0wjNC6SHagMnaWhNwHHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UKo7RQFf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45629702e52so5061205e9.2
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365395; x=1753970195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQxVhQs93RF2j5r69/kyB3XsN/D2SLMeChyoBk7vwm4=;
        b=UKo7RQFf1yxGOBkJXGeh+sfBmBXkK1H+4dY0li35Yw+u8GlIDgctfLJSJ4gGAGBQ2e
         GpkP54mAuQWTEzVRa637gLECXTG4LBD+H2Zf/5hnwBXl+0qVNriDWLr6BaX2ks2iEWBV
         Mv0LJV9V0FGC4soAaRZCjk8RfDbvKEMAJLRjcque3PsP8alr8TJvWdUYjSqS+DRr7vxH
         eLswUfmFOgcFn+aCBJClnkAnPFfGh/e2rEOVqJpIN08L56pFgqzxoVpF4AU3+fyoZ+1U
         +4/H2qvGelbzeKomwnogICW0n8OA9YwHGMszLF3omZ4MskFKLs2D5R7Q/FM2tWps4Txx
         N1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365395; x=1753970195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQxVhQs93RF2j5r69/kyB3XsN/D2SLMeChyoBk7vwm4=;
        b=vE6nWr3eCGLN6KhWs7BArOheNgwKNKBTxGKenjMqXhkuChDUzbpvrUupvrdXHECIA4
         ihpV6ZMfrwXVUsyXwRKMy+yEmSv6+xOcEkiwDKPEaqGwBSrYQCFQL1ETerEisuoxvHj5
         k3INl1e7stSYziayxgiouOQynPEeN2LRqh5tEqZs7CdoAoIKhR/EZhjM+iWpN++8D6GD
         /IZDXlP8AVTBypMWCYcX4EXUsAkgXKjA626n7qwIv4McXzZeK09+8TY4KMHFMIwnWDKi
         dU98pYSjqCy8CYeM188rGh4y6YrVU3mftuASFK3eR+uG+qtZAoyyEBvq/9CI+2HehFEg
         6hrw==
X-Forwarded-Encrypted: i=1; AJvYcCWeGnG/D1bgXPfDQAFVE6lPFVUrAtAmDe7ZFZbs8v+sDqVpwHSGsCxqFEOogTO1oebUbwhK+Ya+jFvS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcg9o0/2zmBZvMq+JNMtXFwhzYRdilYfet/u02ww1o3yXDlA96
	bRwX/gCCNQmfWTGJcskt9RFNTI56iY6ZzjT4xPqg5Bes7I+zfTzmQ1/+0SymLOtPndg=
X-Gm-Gg: ASbGnctixui3yfuvsIZUYVExGarbkW9x7CZlhyUP9bZ5F8eTr1/5FhpVRaj517gpOxb
	yAcEt5yc7baq3EvXC/l9QwLIm01NLafFHOcMLTj9Fhp+zfUiOvpl5C8Y+ADX/XAlfu1FikA30HY
	7et+DLQQfuahGQv4LuSetGlHAsfiSUswbaCoXAMZ+qFZ6kSdkT6CMMMKSGMvODunGIWiUkxpBfZ
	b+yuPm34P+yImtNPHzqdXI0CUyBjTyesVl+MVPHg0pwQBD+rbCBhADTcoCakdgl/gJr7wNGTpZl
	V4YYKUxMFqFBtALEiZVnPKO5SOZgblPBRGkbBEF2+OeXhUgCCyNFElM5S5opfJVuG+7nx3CTiC3
	3m6egMqZ3BwQhZHIVL19LpLrlUikfph2OxItfnovpGTPzCi7nS9Y54D6m300oVkiylEQkTqRPVe
	aIGJTYVqGw3IV8
X-Google-Smtp-Source: AGHT+IGhn2BhSHWFDoozkG8rL01GLeqFkYg2AyJwTWU+9+XF/fbe0VNyrElgCTmDYeBHx6jzMQbcKw==
X-Received: by 2002:a05:600c:4e4e:b0:456:1bca:7faf with SMTP id 5b1f17b1804b1-45868cf76e4mr72058865e9.16.1753365394813;
        Thu, 24 Jul 2025 06:56:34 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:34 -0700 (PDT)
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
Subject: [RFC][PATCH v2 14/29] mm/page_alloc: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:57 +0300
Message-ID: <20250724135512.518487-15-eugen.hristev@linaro.org>
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
 - node_states

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fa09154a799c..5f0015e27a30 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <linux/kmemdump.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -207,6 +208,7 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 #endif	/* NUMA */
 };
 EXPORT_SYMBOL(node_states);
+KMEMDUMP_VAR_CORE(node_states, sizeof(node_states));
 
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 
-- 
2.43.0


