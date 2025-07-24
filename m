Return-Path: <linux-arch+bounces-12930-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEA8B10C93
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AACAA7BB6
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 14:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E62EBB87;
	Thu, 24 Jul 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDK8xxre"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3002DCF4B
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365409; cv=none; b=MrLiHoZlG68t01qLlGF0BywR0n9iJVb4fbMbacfs4HfkBCh9cxIKCpNKKM4qjrQoKAWEBtAsnwrf916K53kwqiECbSJPGbrm6sDS52Xck8o9ZLNAyfuhswnVW4Iisp9nJGpLu3UITaTPdk/RUuNzY5WWrOWp0T23n1fokLPDru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365409; c=relaxed/simple;
	bh=X7sQWVi2ES5AdRRit9jippI6XjHYlOeEQQ68I6dFb/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5CztqDrDqxGRO+Kx+nz4B3i+P8cmnBxNMVyBLqLnH6cklzA73lLk8G6NbI68967GEnM8x3vSf7+3Fg/rq8Vehl6lWWvHIs+sXAeC0IKNuajY1sfO5bLv5pMYTsmIiGZ0bOnHr4S3siGRKdwVva6ScSCDTkDHdaRoWxQe/baMb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hDK8xxre; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45600581226so10583765e9.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365404; x=1753970204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io4h5WAIvfQT3VZkI4AOHF3Wp3PwROfn1AQPtlUH1DA=;
        b=hDK8xxreujp3pWqlOMBgHmmfxII1+ZylRyCnatQz8Hk0KNv42+sXlYYp46lcSWd523
         4LuB40mwAABhQX7sjVmSidiHpqHylox331Mjz4+Lchqvwum1GNawBGl4vQ57S7M+BsH+
         vZkkP2Mv1RO4CpOAvit+S8EBWTHEIOFr3SehSdTDrky7xm0ndHSqS4Cov+H+OZSN1Q92
         o77CgsrPAOIQ51h59pGKu40MHnFCuMgl6JMJhv6JcB6E3QJZqv1yx31SbUUXPSj0Nv+s
         NwxZaXNRDj4Xckeql1Mrll1FKb64A8a/27wwvKfM9If0OvfszU/UF6rmMUUqGVbUJG/9
         acsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365404; x=1753970204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=io4h5WAIvfQT3VZkI4AOHF3Wp3PwROfn1AQPtlUH1DA=;
        b=LTnjA3Uaei0o/vfqgXDQTD87xJovS4yGs6PDPxWeungnnAyHJhVZ/e7UnWnDyq+hqe
         ljXuJNtKTxqtS2ATCuQiUNDGVUj8k99y7Wf7NMowgn1Iy0oVVR53sXewn4h5IyPQP9UT
         DU2hR0Qq4BJSSyFM5ef2L4o2aODfMwGTYHNvv+PUXdQwZr65TGAsIGxVoIIEbumZdyN2
         Je0a/RIJpO6c2HRO8gnTZb028FBXd8fvFnwlpD4oiVZOPboJ/E4UEiheQlNmPBfSi8zx
         kyIs09VKj0SQvOZh88VYZZCXXtreOSvpLBBdB9t22fCU2v9hcB64hiyxNkHKt9t6m6uF
         s24g==
X-Forwarded-Encrypted: i=1; AJvYcCWKsB2GO3bJFqIhKFarBvZAQ3IylpQ1mfWYplKtLkIuFFKLXKhGhtGBPk0ZHXJndCksmNUZQpJx5QnF@vger.kernel.org
X-Gm-Message-State: AOJu0YxrAkyp7SZH87+7mvsBDQHy/hIawIQh/b0UtYFR53DC9S4h0cmy
	bSO4LaRrL2z0QNs71JbwWz6od3xXTXXaU1kuimqsejWf97fXwh2f39aGiTSkpz9mfgo=
X-Gm-Gg: ASbGnctuvhAnLlzOP9GnIQEbmAVUYmO+bfv3H572qJ4IFcPOFi1VfUg8i4EjAMyA2Ma
	ecqTJyVPFoR9jMuQ1lUUG2g0H8xdb1ixwrl6q8hikK/bbd8dH4I40Lj+8eGSZ5u2anwadeHBHbV
	Xd9ctmZwEH8plzDtzaRxwn9XZBDbS2+RlcJ/3ry4L2CN5Ol/yznnCkilRkxDIhwPL4XbGcifkIV
	ZaOWJ+Y4CzjJIUvgefDj7Y2Nc5wjF6zXJyPC86xidxk1Qy9c7Sfpfh+xseEbcXGJDtFUhL66aQL
	+5RQ8oFMIA3pPWHnAY8lN2R1/ekU0OpzNvva9FN/l7wpJC41u64wKTZWiGgUHAhqjuH/Wfl8DJJ
	nv7CbgAPBQErsfbWGS3RnfGaqYMz0IoC4VsX3nco51pCu7vUNfaJ/UiQyLHXdiiN8z5R1l/+krQ
	f/u57Bi6HgSC8t
X-Google-Smtp-Source: AGHT+IGKgu4NRvfPslcwd+sSrmwQP//isSIOnofkVKYWLLSsjM6dUJOy4a8soeLJ5d7o54vF2kp7ew==
X-Received: by 2002:a05:600c:1c22:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-45868d31a2bmr69596125e9.18.1753365403699;
        Thu, 24 Jul 2025 06:56:43 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:43 -0700 (PDT)
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
Subject: [RFC][PATCH v2 24/29] kernel/vmcore_info: Register dynamic information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:07 +0300
Message-ID: <20250724135512.518487-25-eugen.hristev@linaro.org>
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

Register vmcoreinfo information into kmemdump.
Because the size of the info is computed after all entries are being
added, there is no point in registering the whole page, rather, call
the kmemdump registration once everything is in place with the right size.
A second reason is that the vmcoreinfo is added as a region inside
the ELF coreimage note, there is no point in having blank space at the end.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/vmcore_info.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index e066d31d08f8..d808c5e67f35 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -14,6 +14,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/kmemdump.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -227,6 +228,8 @@ static int __init crash_save_vmcoreinfo_init(void)
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
 
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_VMCOREINFO,
+			     (void *)vmcoreinfo_data, vmcoreinfo_size);
 	return 0;
 }
 
-- 
2.43.0


