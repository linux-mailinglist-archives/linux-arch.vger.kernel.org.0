Return-Path: <linux-arch+bounces-9256-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB29E5A0C
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 16:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4F31886E01
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD222259E;
	Thu,  5 Dec 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDSJ0WY4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D23521CA1F;
	Thu,  5 Dec 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413387; cv=none; b=MD6SSuRJd8ZNtKYqsMUTmL75N/eIL8WDUUBZwhQV6MTN/yWvo0JRFj2i/udf/sO0W2ru6g4cUyo/YS21pezDVQFs6+OY8xStiE9rpIH6cYoG4r/eglyMhTIvhnwcAB+uJcKvlBKDOrpuTNo5eSV1MGm2yxQ8ypFklpyYW4xZDTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413387; c=relaxed/simple;
	bh=SzhyOtEUlK1I18A/FRrdDPLMEZiQ14djozclmiZRTbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnQaJ2NeVCHpPNeIWjB13f9QI6IEFBd+b0+oEQSEF/TViN2Xd9lbLvsQwp2TDa53/9Y0b0OI4LH2vDiaxbRMrF/KNhOwHEJGnyS5K4J3T2eeZE6yfJ+1dnnj6og1u0P14sDKH0GsUk0XzFZthvgMmXRFZ7Obwg5GOeSmdmCTezA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDSJ0WY4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a752140eso7419565e9.3;
        Thu, 05 Dec 2024 07:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733413383; x=1734018183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gtsnajd748RmcqOV4pJa0tup0XYC14zQ+bwWhrz+BbE=;
        b=eDSJ0WY4/FCDwq2DzY7sODawMIeM5l82rPmwAjJC987LutZfNnI93KmJpuhT+lsgj1
         pKGisQJ3vIHCRdhrEix2d1/dvUk2Ddj73Cu8OMKSM+NwSsPqJi9kl/st2G/SkehvK9j3
         lFngvPYbxkJY+6AKMNCjWAhXsNzatNJLFJN0TjbDzlu8iF2MeTNPspr8R77cZ4Z3kcPx
         lO1OlczyftvssrSVA2aDH6/ewLBCsJ2iBvTjvDkQBGr5DWsW9YpDEchJveJCEqS29bTl
         DkUJ/pKg/52adGJWlIVmm5E9f9Po7O1zv4EQDMMM/Nt7VpmOVwBlGu3V8WmPjzo8anzE
         YtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413383; x=1734018183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gtsnajd748RmcqOV4pJa0tup0XYC14zQ+bwWhrz+BbE=;
        b=u2oX2BFzfvsXxo1LpEOH+Z8oqDjhT+jtMvMJutUqhm16SWem1x8hGvG/1sEXRLbbMX
         DsfN55Di+e6JNPOXEqj3vZzhb/ROt9WEkl5dKbpSKSDxG6Qd+yosJAz20n3Ue917b9pd
         e5IUT0zCXHo3e1/hnpkjy+xNA3gTVeMnstRjPnefaZcxP2L4OkKQnyfrAN79FOs2vcG0
         2mnrE01WUgft6kPnbehCjIFnFlAJNnhWuwix0NGuheXWmks+3wNN34JGrXANtD3s23qg
         F+kjPozu+/DHpa/nOptxEYIbNpnENpmWbSkckB4L3N3HynBwSO/pBUrI2l+NhVouj87x
         +2mA==
X-Forwarded-Encrypted: i=1; AJvYcCVYmnkuPnxa6I+zCosXc+4TE4tWz8NNxookQCql6PFkp/mbgkX49IQLwTjvy36GKiYbj9v45lneOvAfFlp4@vger.kernel.org, AJvYcCVisWjdGbX3SMu8ljqrEogx/gCaFxMy8fit7wHHmDL7wEfHA0dvtHytkvuC9vYaLyu7nIBvh717PYPhjqlWpXQ=@vger.kernel.org, AJvYcCXXvCO3JoBwducJ1iUleycdcwhOHM07ZNXDHL8G+UHF/qYIGsmR5pcLoPN42Co2CZUeYnvX3Sm+8Jvk@vger.kernel.org, AJvYcCXp7L1YyYQ7Qc5hBfJ4pACH4P/2JT70KH7mdktNdwWxjw4juHKQK5dxRdnMaqsGz2gaG3A7qFtb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvo0Tg1/5BsN3ZxO89HPydCn7vREYGeoAXQukQ++lrQsgIBH5D
	xHOT9EXW6om6TrH4fSW8X6Ph8pKCouVo2fbVKhDmANozPlS70duX9NP0+XMJ
X-Gm-Gg: ASbGncvnbHDdnq4mFcxVlb0p2hUZOdVa9UOFqb7FvT1V5J5jaL0sZWxC7wVDgMixbvI
	bKsckak07OEA1tJVbMpl5V11IWjyEzRE77SZUC3apkk9rboD4H+Au97NEbBOUHXqo/kAVbRRowP
	jugwh81suMQ7Wa9fbczuFH8AdDlQXHwbafnaYY15Nx7/pTukXNkT7ju5JjljNfXaR/4YbfE6N4h
	ECUdZP5HJtqNBY0rCqsRn+KWJXfCQUlluX6Xa4CbosVmh+RThDv4l8Xqlw=
X-Google-Smtp-Source: AGHT+IHIQDuNJ6wnIX7o3Rq6VGxlYxR8KF29MJiQdb9I84zkEFXiZarY1wgT1F6E7EapNejJZs+W1Q==
X-Received: by 2002:a05:600c:1906:b0:434:a1d3:a331 with SMTP id 5b1f17b1804b1-434d0a0562emr87553825e9.22.1733413383199;
        Thu, 05 Dec 2024 07:43:03 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da11387dsm27020185e9.30.2024.12.05.07.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:43:02 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 4/6] percpu: Use TYPEOF_UNQUAL() in *_cpu_ptr() accessors
Date: Thu,  5 Dec 2024 16:40:54 +0100
Message-ID: <20241205154247.43444-5-ubizjak@gmail.com>
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

Use TYPEOF_UNQUAL() macro to declare the return type of *_cpu_ptr()
accessors in the generic named address space to avoid access to
data from pointer to non-enclosed address space type of errors.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Nadav Amit <nadav.amit@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/percpu.h | 8 ++++++--
 include/linux/percpu-defs.h   | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 666e4137b09f..27f668660abe 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -73,10 +73,14 @@
 	unsigned long tcp_ptr__ = raw_cpu_read_long(this_cpu_off);	\
 									\
 	tcp_ptr__ += (__force unsigned long)(_ptr);			\
-	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;			\
+	(TYPEOF_UNQUAL(*(_ptr)) __force __kernel *)tcp_ptr__;		\
 })
 #else
-#define arch_raw_cpu_ptr(_ptr) ({ BUILD_BUG(); (typeof(_ptr))0; })
+#define arch_raw_cpu_ptr(_ptr)						\
+({									\
+	BUILD_BUG();							\
+	(TYPEOF_UNQUAL(*(_ptr)) __force __kernel *)0;			\
+})
 #endif
 
 #define PER_CPU_VAR(var)	%__percpu_seg:(var)__percpu_rel
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 266297b21a5d..2921ea97d242 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -223,7 +223,7 @@ do {									\
 #define PERCPU_PTR(__p)							\
 ({									\
 	unsigned long __pcpu_ptr = (__force unsigned long)(__p);	\
-	(typeof(*(__p)) __force __kernel *)(__pcpu_ptr);		\
+	(TYPEOF_UNQUAL(*(__p)) __force __kernel *)(__pcpu_ptr);		\
 })
 
 #ifdef CONFIG_SMP
-- 
2.42.0


