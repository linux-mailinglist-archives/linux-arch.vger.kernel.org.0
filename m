Return-Path: <linux-arch+bounces-12919-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A469B10C75
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C4B1657A4
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EB82E7F02;
	Thu, 24 Jul 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhHBBf8J"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326F2E612A
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365399; cv=none; b=JjVrUBnp6VTdZSqupoEGcPTbpmRtpCpFaaUoYwNcBXnvoznJIuaAS5v80RdM/YO2jFsnIwoDneQPVORb+a9M7q91h1g3L8c4oB4wMWIPntSd4Ua4MqYpBKB6jtXvpAC39OqS0QLH1LQlKtvcswTuGeJmvBp+Iuaiabq5MMGKnVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365399; c=relaxed/simple;
	bh=QpOyX3O1zVluz5hSldO4dnPU9Pz5bkE/gs9RkenFruo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UibORWmlQfeDUfu2LI2oZK5zHxVQop1VSDnnk6otDEf/Z3Cvel8T1HCL45kre3o1AmaymHrHh5jtBPnlv2DtMnob0yfX5t1bI6rkizMuip/rPa451xYuLFLwYv/Dbnvq4cmrXUYvWIYDN+dnK3m5eU1TxHBOt4ks8sh4LMBOkSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NhHBBf8J; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a575a988f9so608098f8f.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365394; x=1753970194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6EjHBZibILbBUp2qJIWYHcXS7kn/hLDSQS+TJg877Y=;
        b=NhHBBf8Jzh2UWPCgsbFcY8aPFwvtxFOq737cLLsrQCZmRgkKkfwMJqNysXsBL8QsXC
         qmzgwjtJVYsVGW89ouotrXqKPHH++Kh+n8fzAJGfeTQQgN3xUx8umehWdVe6hxnncmui
         vMMx7OFls9lkmSMYrkbutgmBveGsrwvyQbxtNkw54UmbUH8TGVbf+pntg0yVwqDgKKpp
         sW91XbQn7lQRduhAgmkL+m0wfWr/G35EOLGF3ls9tPJArHfaRx2kec+lQcZd5sYG22Ty
         VQjkDwvKt34FiJcreuIkEXHvXuP69LMFBp1pM/55KiGjJ4nmzQMUSN1xoQGuC6LmZbcE
         fGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365394; x=1753970194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6EjHBZibILbBUp2qJIWYHcXS7kn/hLDSQS+TJg877Y=;
        b=MUnAq5nfs5VG/MS9eWpfv+Xm9ivH58OK6w58ZSWwELbzGVd81PVXt3attiwXpQoqER
         B8dgLoD05wkifZCUo2D8367SfEaQystHLSm3sERhmFOSgiec0GfTJo6Pmv8MRdbFgCj7
         CGFxwu/tRXkIkHRRMHILVfWE9tnssIBQryuKE0Vg5SJZ3xv6eaOyhAd8b7CqBPD1L1/q
         3dDUv3F8bqVoHJNFnnIUrwPB5jBKaRnVkvPYtrwjArZHReYjroavaFVxXKngUH/G3iKx
         svORt8IQQ+cM6ZarwhVoJfDiz5dn7MLw/poY+9a5GvhlyEvtj3SLoz58Wjgno25Losnt
         2W3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfF/e9IH3tkXfNRoBm492wPcEGeHhJTNgr5jNo7iaNvOC5GM84Se6gXTpkFqWuIdx+kK6ZzZXp+/hr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/8kxgIkL8LntUNBvGycAzPUEsNOYCZ6i1l5mpyf3rI35Pk6AV
	z1l768HPd+JoX16qBSM5Xb1hMvzL6hHt7oTTIQlY0Esc8+etk2iYXlq3QddE6HXVkU0=
X-Gm-Gg: ASbGncsAAgC+SpQ2Rl0YoUnIjNirL+izA53SgHJUPVEigzr4RbgluNptC0L86LTnPsV
	0ICOwRonEyKeW1cshmPwY+T0pkPW5G1/mJ2CmugV8Y2uLe1duWZxbdUOI51dEdJ+vfHXXnlTF1t
	0p+MoWYbdG9Sm7nuZVayiOuesE6ss6QLP9cQBeMJ4TLwjlUo5J3Eacs+AtswlCtHbYnbLzdhrgn
	LIYbnRLLmvQV6ayHvmwcvehbzBDNeKYI54c4nKMyzCPr1Mmd4dxgLS4utJyj+7dehEhfmjNO0g/
	n6W0Y8nFzz4XtXD6ThQ0T5Mf1MU/LoXYPQG7g/2BJK8kpZzVuWKpO2ePxPtd3OQTImvR7Zmdd3y
	VW+9aW9kAr2bSfo2hSmNuRLxi8qLs6tq//dfEZvOfb5zsJvwbCIreViNnDUpoRJ4ohnOXKM20wn
	e4cnEvnTVmoZ9m
X-Google-Smtp-Source: AGHT+IGRlGdpZ28v11nrKuEy26SoaDmKeIQI1w12F1VyMMK6OUtkgi6ZkZkyO989nTl8PB59Q+K5gg==
X-Received: by 2002:a05:6000:290e:b0:3a6:d7ec:c701 with SMTP id ffacd0b85a97d-3b768f1ab39mr5321094f8f.30.1753365393821;
        Thu, 24 Jul 2025 06:56:33 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:33 -0700 (PDT)
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
Subject: [RFC][PATCH v2 13/29] kernel/fork: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:56 +0300
Message-ID: <20250724135512.518487-14-eugen.hristev@linaro.org>
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
 - nr_threads

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/fork.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index edc6579f736b..ae8ae9b9180b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/tick.h>
+#include <linux/kmemdump.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -137,6 +138,7 @@
  */
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
 int nr_threads;			/* The idle threads do not count.. */
+KMEMDUMP_VAR_CORE(nr_threads, sizeof(nr_threads));
 
 static int max_threads;		/* tunable limit on nr_threads */
 
-- 
2.43.0


