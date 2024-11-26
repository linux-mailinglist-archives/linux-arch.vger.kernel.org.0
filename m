Return-Path: <linux-arch+bounces-9172-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C692B9D9CA3
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 18:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED09B2D255
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 17:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB021E00BE;
	Tue, 26 Nov 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxJ5Kt3T"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C21DE880;
	Tue, 26 Nov 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641845; cv=none; b=q2vqdQHfypL1+vf3G/rPAmofHn1j3RZBF8y65UypKbEnZ57gkqmcWV66qYmBToo51NMqFyy7C0vPYC6UGJhRbe3+Ibb4AITRRyjyYkaBaB2BpA5UDoDP5GXV7I5rUDDj434BZWBTDsQBYEUPYZ634puZzV5prporOWYrKrG/D2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641845; c=relaxed/simple;
	bh=4OHFcqeT2AuYq8OOGzyp2EVumvns8aqChYzt49dh7GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FM3Fhpcy2+FP0U4ojPkCepnm7Qi/I9mrbt/9SPV6PnOsYhPHj0lUcOvGohHh6z71ZISAbIHNzI4okZXQP396/yqpggs6sJFgq1j5qy1bOoaMP0917yNo5tyop4tEPZjIEtRMsZ4uM8NQEs0Va6cdvxXaxR3HMy4QCGKBi/6S9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxJ5Kt3T; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa52edbcb63so607612466b.1;
        Tue, 26 Nov 2024 09:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732641841; x=1733246641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYQhfY8XS5QoJJ9ROocmWAxArKh2nECE5yY90QqkfaM=;
        b=DxJ5Kt3TjyZCKe4FdtR+FlKe+nypTY20rap7N+7ElE9SJ2jwWDI/4OZls/pnafXGxw
         A1VeeBx2+sPjNvSwftPac77KHG+nsWFnumIdIW1heQ4jWZpf1kc7YPmtgF3/TQuwXCgt
         YZG5j38j5BFCS9o9ehoRkXAlQv7ie0QJJgIXQqAfOACdDOGzDLc3Zs618dl7uarR2yC1
         flYQE69f887Ic9526A9xdpt3Jfd2jH5ZscWZtmmIHCXFB4lkAzyOOrx+yNAN+eI241ef
         NiiaxEjpuH8AwlQlCO93SQB1uUbb1NlAPByCdMyGeEpHXOLTHLh6U3L4xpFetk7LwwMF
         ydWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732641841; x=1733246641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYQhfY8XS5QoJJ9ROocmWAxArKh2nECE5yY90QqkfaM=;
        b=FryF+cxf7oez3yrh+qpRJ3vq85HJbRaJYZWChtSvlGHAjHj+0QVbRdzAspyXnQ1h16
         nPvfEqxN8quu+NqMHbN3HJTJHRlDqQZ4wcGh3uf7oEBoLXuyNvziiv061o4W+FKLqUGW
         QUjBOJyScEbcrqoCOiEeIIWqGmyRj8/SIF0eWj3tGd6LjpBL9zszrAhqjBqc3Co/BxuD
         hXF7cxuFYGHJBVXQR/D930GN1d4PpEJQ9dBaq/aVqZvyu6uUeOGISpuQ622OHfIRlEJC
         crYCcWqDC/FEhPaTokcakkDjuFzXir1DyI/xvlH/jhLgw0pOjnb1u2kudBalCKyIdN8a
         NmjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5LzB9ZS06BLdO4lVxTsGzkGnPVHcGhgkhQKewGTgUO5BgG4Lho+X7Xi787WfGg0RLejSs937gpHMCdx67@vger.kernel.org, AJvYcCVBZ993GV2K8b0iycgDp+o4GG7BLV9WW2/vAnfNnPDcU6384eQiuSWrigBkl+VlLdlMNXe0t7we@vger.kernel.org, AJvYcCWL7P7J0di343GjVNVNnqT78XXhRbnoOVSA3yHJ0b69dmVswMIV/q7HQl2H6hStwS+4LbrvO2nIc9B4Zn2i@vger.kernel.org, AJvYcCXIRtOaQyuQwX+hOkpBt/tG0yfllpsvjABB+y61h5mTVwOpc34DAf4Tds1ngTwH+jVZqq0Va6Ggy8R81ee5wVI=@vger.kernel.org, AJvYcCXLguZcCsJroTTRzXoC63WRgmlrj63fdk724ejyxbYD7FhHSoLOnjhjZtmXBH3rtwMfLFBtjkNQ7Cw5@vger.kernel.org
X-Gm-Message-State: AOJu0YxZXwa6cxyqN9H7J+f03R5kag6CqdSicrqAVR7+6wBVhyrhHrs7
	EZNYdHwovsA1SjcPVbi+WjQU2FVnn8EPaYS/eC7Z5UmucJCo4J9F
X-Gm-Gg: ASbGnct5eNeAz39VYC6K+PS26/TScZtq7H7JqLVeVBD2nvsCL3E71tDOk3DA5d+z9Np
	9P7HE57A0TfK8IPCbuJ5B3SF3o6hyagbkx3nz+s5h231VpenALxflhWkNTmvK2I0Kc4qh2CRTce
	PCFp529JfphlVMFp5USdOdGs93uQOTUm1N2h9V0bBLBeHBO5fG+s8cTOIecb3W9I/p8UrXlWjRw
	ew/mu3vY01NwLWbGO22R4rNqpzPTyDZDivUB2ccIihbJXHBS1NpEf8gsCg=
X-Google-Smtp-Source: AGHT+IGyDslpGnIuA7EaGQJjOGzUF02XOkLJcH+fA/4c2TgsR6qaqxDya98ILXBrNs7h8xnzOadyXQ==
X-Received: by 2002:a17:906:3d22:b0:aa5:26ac:18e2 with SMTP id a640c23a62f3a-aa57fbba709mr3970966b.23.1732641841517;
        Tue, 26 Nov 2024 09:24:01 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa534232086sm473832866b.42.2024.11.26.09.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:24:01 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-sparse@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
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
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6/6] percpu/x86: Enable strict percpu checks via named AS qualifiers
Date: Tue, 26 Nov 2024 18:21:23 +0100
Message-ID: <20241126172332.112212-7-ubizjak@gmail.com>
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

This patch declares percpu variables in __seg_gs/__seg_fs named AS
and keeps them named AS qualified until they are dereferenced with
percpu accessor. This approach enables various compiler check
for cross-namespace variable assignments.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
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
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/percpu.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 27f668660abe..61b875243ea3 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -95,9 +95,19 @@
 
 #endif /* CONFIG_SMP */
 
-#define __my_cpu_type(var)	typeof(var) __percpu_seg_override
-#define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
-#define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
+#if defined(CONFIG_USE_X86_SEG_SUPPORT) && \
+    defined(CONFIG_CC_HAS_TYPEOF_UNQUAL) && !defined(__CHECKER__)
+# define __my_cpu_type(var)	typeof(var)
+# define __my_cpu_ptr(ptr)	(ptr)
+# define __my_cpu_var(var)	(var)
+
+# define __per_cpu_qual		__percpu_seg_override
+#else
+# define __my_cpu_type(var)	typeof(var) __percpu_seg_override
+# define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
+# define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
+#endif
+
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
-- 
2.42.0


