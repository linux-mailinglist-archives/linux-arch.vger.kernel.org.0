Return-Path: <linux-arch+bounces-9171-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C28639D9C7E
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 18:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72373166114
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61CA1DFE29;
	Tue, 26 Nov 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9uZy5WL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C51DFD98;
	Tue, 26 Nov 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641843; cv=none; b=ABvtvt31GGpWruvDvKclfD7zxf5AepqVaL3Eri3P9AZICkFKq9Mk0HKMg4lGvT4IwWaRF0qWteZvUMa1TvSR1yQ1+x9IDgGngKGYeXmUXzFsK/DcGMFfSZ259uBCWvo66llHjVvcXAH7NEnJ0xLK7zNJGHdVHCV7D2ZR3FAYBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641843; c=relaxed/simple;
	bh=eC25SyhqUQGBuichpm/2M12L5lE0TLdJk2x0WWN6EXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTdc5/rK0zY5w90lDO5ugInMSUXW07XvAFId7YB3tmP7Rt/1EMzwX51kP+oVor9dHXUcPxolYrHJWcffhqg1eigtigAddI6g/J7uhEpeM6pZHFO0B5KdBcYlKwPcfz6K6nl3Jb0crQQLiYRHQncsWhSlC7lpiK/vwUcNQxSl2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9uZy5WL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa54adcb894so334377166b.0;
        Tue, 26 Nov 2024 09:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732641840; x=1733246640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ky+OlLkDMElBCNtIUb2edtqmSrtx7L7/4FrYNlOF0QA=;
        b=e9uZy5WLP0/V+640qEBXyxSmB16ueWiwFChxZ7BOW/vXyV/kV9HoTjniEF9H6dGaaQ
         c7Bv+1drknNdKMTNA+YyflkLYvYSpfhvbHpvxOPO2J9LixAKnJXx1L9BBRbTD/piz2Rh
         Z+3ObOE06kaIcMIHy7j9quqoe6+ULaxziOehQ4GmZ3U76q9zHKlcoOQAO6uPrBmk/wAm
         SpjFSuWFoWeZp84ew8F8o4x0ilokxr761xeCVDkGplGG26S7BpzrydUr9yrjGa3sgDb2
         en0gxiDfAOdQmiOBiuqdjNz52DQrsnWfbHUPMIntOdkdyGHKUP2CKIgkdq1/KwJk243Q
         ejog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732641840; x=1733246640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ky+OlLkDMElBCNtIUb2edtqmSrtx7L7/4FrYNlOF0QA=;
        b=P5BLd+8lqm3RrLE8gKNcjNqZodOb1twFcJhWTZEg9THg/gab+Yq7YK/aIsKJqAP3nR
         ZSug0YTJCLxqHZ8p1xL1TnKiho05O+QQXSGUoCwaTgGuTkr0iKTT46IolT1YcmjrT+9f
         kgwGPviBBmE73EnARP4deblORiMC6+0b1Qs31L8z7XgqGN2IVFd1JO4qK2XJCRrBRqo0
         x84IW0yC3tu5XiMQ9cQ6d1Oo5UmxG3/N+rUs/lSoYE41Xr5EAinq+cYPzt7f3KG0GyNM
         e7R8WLyZG2zxcPTJM39+ZiTWs1rlhNuIhM4bUILSPsiVJiO9quOP0qTpxhkd3Ub9abZr
         RYyw==
X-Forwarded-Encrypted: i=1; AJvYcCUowTzMvyy1nDbT7aNPEQbS6kB1DKFqMZYYwm/WGdI3U5M3b/G11RGWG0s0m3qma3j6kl+Bc5Z1@vger.kernel.org, AJvYcCVzLDqMV3rIl7Y8bPHEbA/bR4hgoiIWvPaaY1PfJFxTBGwjgMz76aY2jjUlj0zRCeu62tSC4Fgw3e6QTzyT@vger.kernel.org, AJvYcCWG8J00yQ9SLjDERxD1yVYhRBaf1LDEtaBWSuPLKdseEA4oS4FMl0eWH5U/82HDqzT4RfPc0EwpQlG7/4NAVlE=@vger.kernel.org, AJvYcCXDH53Zv7m/mBWxjhw/1ouCq3xoyYIm+18jXok+nHCZplBVmqmsJhteI2ao0WfFKgOtcHPIUYon0w7SiJ/3@vger.kernel.org, AJvYcCXVZY9izTuS7GPtHD9RvubjxS1Xtg7ifvoGiXvc9i/QG1OdX/u3SfFdd+kw53obK6xNGBrTzSn95D1G@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qmPwRW4l+Zw3WxhnBPMmjEudaWxHpBK6F4UvD/nYrCd++Y/n
	+tdrw8azJglvVgL79zjqjR/7mqSxc9d8Ad+63QcGUgaajjrqSS91
X-Gm-Gg: ASbGncu/6//1edAZlJbKGZyJHaG4/HmTmh/dG8SYIOSyNM1ZrNJWpikjdv2YSOjt7fE
	KvaROQ56sWUhDyBnq3oekRG1kZhOl7xQv1oTLL/rxuOpot0cVQUZONWMJYbmP+Sv7IH2AsnCQCn
	+i1cP8y+I/qjOf2DZC2RucM3pri4Z0Is3lwmB67UNzU/wTdlAw0+YE4HF8vRsUjSmI7QqXpD8TS
	Zum5bQH32NxzcdbvO0m8CpWiVTznGtVIn2tyyP/u3G4SNd2NAQWXZ71uDs=
X-Google-Smtp-Source: AGHT+IFf/RvtHifh9xfGRhKVpgriIMG2kypuYoc32969CCQP2/adNO/7HRTialB1HvpO1MqhLIyC7Q==
X-Received: by 2002:a17:907:784b:b0:aa5:15ab:a5d4 with SMTP id a640c23a62f3a-aa515ababeemr1070027166b.22.1732641840123;
        Tue, 26 Nov 2024 09:24:00 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa534232086sm473832866b.42.2024.11.26.09.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:23:59 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-sparse@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5/6] percpu: Repurpose __percpu tag as a named address space qualifier
Date: Tue, 26 Nov 2024 18:21:22 +0100
Message-ID: <20241126172332.112212-6-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241126172332.112212-1-ubizjak@gmail.com>
References: <20241126172332.112212-1-ubizjak@gmail.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
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


