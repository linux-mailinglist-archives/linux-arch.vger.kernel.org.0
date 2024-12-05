Return-Path: <linux-arch+bounces-9257-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD929E5A03
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 16:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6EA2868E3
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 15:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BFE21D58B;
	Thu,  5 Dec 2024 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGBowfRR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400C22258E;
	Thu,  5 Dec 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413388; cv=none; b=gvQ7bt34g3eJUNv9gsNshL235jFdhhQtEumuwJiDfdGaZGw40UeItTbIX8sA4AN6S1jQub/n696koEpD0IF1jD7TCJtQ2OSOdeUc4I9o85eoIKvxXp6PVa8lw8ucQypQoKvuGhS2bEAY4GYgXY46dZiYCCOdThJiMYcNUJV1GAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413388; c=relaxed/simple;
	bh=ktV65QC69LkK7D1GQXmkIK0gDDH2eVmDfQ/nHwDJYe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePc+cUzjWVFbjHXZSw/RyQVyvkKTo504N4kYaeBLam8WX7O8aoLgfR1tb+WZDRRBIMt/IiqHErzBbazHsoEwQnQWxRc7lSduj2VD9NENfPmVqQYe+UZZQnAFF8vSdUWilm+RfpgrXHezWu3i8wylVsNNoS6drlK6nIGH8fbfySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGBowfRR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385dbf79881so1406834f8f.1;
        Thu, 05 Dec 2024 07:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733413385; x=1734018185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJNYPM738NzsA6HHUsuEIDtHtfWH4Z1j0zTSwQJI8Og=;
        b=RGBowfRRrqipHUMn0zu1FqonY0cYxVJTEs+NDXEveFRd59LfjyMYnmWgP75S5vn2a2
         uMDltCJD2GWbjeiXxiUslKNZtkHI2I3TAsX5oOG9bFxxPBy3szTrls+E4VZsU5pU7FHQ
         bWCo/uGNHM/5+Id8lldbVE9I4V4x6W7ashCDaWgWvvRmJBdWHGKcrq1F29CmbyxKJOe/
         sOlwcZLWnGXQVpcndF5nHw72FZmVkSR/5ZI6s3azm4y1a1fW1UuqRMVTY7GXMgfMXXcg
         c0LWxrS4Cr6sVBUcFO1iANTkMFL+qqSobIBIABPgjA+va14pBzQ8ERkC3WYliHTKjni/
         +pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413385; x=1734018185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJNYPM738NzsA6HHUsuEIDtHtfWH4Z1j0zTSwQJI8Og=;
        b=vmCUC3imJzNukd1WiLIs0c+SB+9WziCDVKt3ItaFvj4vXww+b7uY1ksGpDylKdnejc
         tdsntuRoWtSXYrtZtBxNCpfXkabXApunQ9oku0XFSJcZUiWt5ay43r6f6aundl4/ZebD
         o4AMWnGjA9ZFlFc5fX46Z3gJSD13qCrjIXpNfcIgmxbhWeggO2vRQ5gvea/0TkyxvPo2
         YszDRPqQSC28ZmTjotImWIdto9stBn8KcZuyHusUFWG6QSMhr8qSWQUAXejM8JundKnx
         ZzUIL+HVAJlrDCkwWuEeRklTX2v2xsIHGNjn01GqOP6IrIAnMudM9RiYJDFQ/tDVBcyQ
         lYrA==
X-Forwarded-Encrypted: i=1; AJvYcCUVJuDtANP1a+DfBsmisvJX8SYJiawh76PwhX2NpSUrHlfpbi4cl/a18Lh0QTeD/0TLK4ND0azgGxiv@vger.kernel.org, AJvYcCVNM9VEvekwihi2t5xtA0na2Ygg1iFKVIkPxrJSyqcd0l3dNYkVVyW2VFEziYUYYFLw2sa76fhtW6ioq3Rh@vger.kernel.org, AJvYcCX9RTlvY4rQELX3l5Now/nsh3MQUN3Az9QwhgQldgSmbTRkG63+X13MwbzNFutZYk4yrhhBF1R+jiIkxU4D8eI=@vger.kernel.org, AJvYcCXqJn1OKtibHXMbMgK78l6leuDjlSdfyFUz11pXOUhIt34HZ2c7q2BJXQfW9jA14fsn8D7e8x7r@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc60fdSXnNRCdriAKa1UAGtJqpYUBIui6YBpvtovMbOwoOY5JC
	JOptcmC29m8W42JaoUC20fTJbKYbmZbUYLx0xcIcniCYr2Zrh4LC
X-Gm-Gg: ASbGncsDTQDhVEFUo4mGeb+lCQSz4VpG615bUZPLZCne1lkNDGGKpaXN8cg4EyYZ+1M
	PGDwcg3Kc8s8cimgyzN+/G3RFCCdYeqNdNBFjWsytIH4g4wP4vG3Us1ymQzMA7iX78e2nY6B6yZ
	lxQFKqd+UAwT8AUrMlD76RgGauzUfwePR8s1lGUxXAyRW853zpktajLwAqIxJ9pAHw8Tt+AdEDB
	jqmoR/613iU5Ol0ldD3IClu/lt/3eaIJHUKZ6/NzWZSqQ37ljZOcJ7gqFw=
X-Google-Smtp-Source: AGHT+IGn7dKioDdwzHt7K3WXKx3wPwP6zSj6uvEE4p+BYKAxaPsN8hx7Tq/Sjh+LihcUt5zH/T9B9g==
X-Received: by 2002:a05:6000:1ac7:b0:385:df84:849b with SMTP id ffacd0b85a97d-3861bb5d3d0mr2805156f8f.11.1733413384489;
        Thu, 05 Dec 2024 07:43:04 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da11387dsm27020185e9.30.2024.12.05.07.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:43:04 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 5/6] percpu: Repurpose __percpu tag as a named address space qualifier
Date: Thu,  5 Dec 2024 16:40:55 +0100
Message-ID: <20241205154247.43444-6-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241205154247.43444-1-ubizjak@gmail.com>
References: <20241205154247.43444-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch introduces per_cpu_qual define and repurposes __percpu
tag as a named address space qualifier using the new define.

Arches can now conditionally define __per_cpu_qual as their
named address space qualifier for percpu variables.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Nadav Amit <nadav.amit@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/asm-generic/percpu.h   | 15 +++++++++++++++
 include/linux/compiler_types.h |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 50597b975a49..3b93b168faa1 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -6,6 +6,21 @@
 #include <linux/threads.h>
 #include <linux/percpu-defs.h>
 
+/*
+ * per_cpu_qual is the qualifier for the percpu named address space.
+ *
+ * Most arches use generic named address space for percpu variables but
+ * some arches define percpu variables in different named address space
+ * (on the x86 arch, percpu variable may be declared as being relative
+ * to the %fs or %gs segments using __seg_fs or __seg_gs named address
+ * space qualifier).
+ */
+#ifdef __per_cpu_qual
+# define per_cpu_qual __per_cpu_qual
+#else
+# define per_cpu_qual
+#endif
+
 #ifdef CONFIG_SMP
 
 /*
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 981cc3d7e3aa..877fe0c43c5d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -57,7 +57,7 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 #  define __user	BTF_TYPE_TAG(user)
 # endif
 # define __iomem
-# define __percpu	BTF_TYPE_TAG(percpu)
+# define __percpu	per_cpu_qual BTF_TYPE_TAG(percpu)
 # define __rcu		BTF_TYPE_TAG(rcu)
 
 # define __chk_user_ptr(x)	(void)0
-- 
2.42.0


