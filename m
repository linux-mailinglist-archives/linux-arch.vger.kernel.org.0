Return-Path: <linux-arch+bounces-9311-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9F89E87E7
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 21:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C410418854F5
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 20:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB27519C546;
	Sun,  8 Dec 2024 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwikKHmO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BE6199EB2;
	Sun,  8 Dec 2024 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733690855; cv=none; b=jkxrJR4fIxDctnoeBqi/1O3paU4cvQeH7oAmQ/SkO78b5hvCYbIOJgDtKYZ3n8ShUJKbc0AU/+/CV/BTijud/pZeCG06v3+H7zJbISIJQ9kVW+R8b9api57erQzkW/SbnVccXsV+wVVRbineeE0M6yFiiQlg0EFCV/V3MIXZGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733690855; c=relaxed/simple;
	bh=3gHJZMqBlwbfBRUKCL4jcDgTquYDbPdPUUNGrhzl3OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lH5phiW+HDEBzh00AAI60cTpg5k4+5uSPDbd8nsiuDqFA4kD24gSJrV2/4B1uo4531F3/clCfLHrrzP8aGLyfaqub68bBr3CkukPxvE11hlMzCOGcgUNkEgb8nJKfrBDD+nF89b5E2f2DafglkIvkVLU4vciuaihAa6FKvI0oo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwikKHmO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385dece873cso1671382f8f.0;
        Sun, 08 Dec 2024 12:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733690852; x=1734295652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KOZI0Av9UpRI0wc6f07qNDNYBakRBN27GYpajM6B9g=;
        b=GwikKHmOulEwk37WW465skIoxx860CxZC4BQe0DbLf/EelgtW+Qqi2Athjn4TvZHMb
         hoN96a4Jlow0/iwTdcqHsMEvclZn4LdeEP53dd6T2lOyAq9HWFGcbRBenVkNde0qU1LN
         a3Z3iW9Izud6cd9Cjca29Ak+oNItS6EsM/QyRFtFJ1qfk4W6b8/Ehj4PefaU/EMOpw1e
         uwaEOz1WtrwK2KcAWZT/0zG/2VOgP3rQtaWyx4aH8mC1fYwdSH3Dgq3IOMyMt4k//F76
         RUq8/oScF2HgRSd+LWbeh1TZzHfH9Kj0MlU1gP2iqBEoLJFpoX3GpTetdqLseXpyCOMI
         ebdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733690852; x=1734295652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KOZI0Av9UpRI0wc6f07qNDNYBakRBN27GYpajM6B9g=;
        b=evcxO5NN6IRHfvnB6UTEmBgOY1gKbo8CsXH7dO7nR7+xGKdOns8xT18cF89LJ1dF5W
         35q40vZeJAnKNQa77kXPMjU1sST3I/OnHBZh1AcYgn5ZFC9izY3HdyXpi+OAeox/HjAE
         p8ynDChTTk7wyp9KjBZy0oZ/3NqDDvmUhxORTCiSUyw/PxbvbubddPAoqFm7wY3FW6Tu
         wBLZ5qVEt5Uh891eLmVofHY2Y8FEhmXlc49QjsTXh7RL4XnLsng08/9cLWIyAiIRNQ9X
         L//Gv6wh4vXaDjwI3OLkroVhfKsrPJO5jrJplbAFwegtMFdFDgPJ/zREF2VN8sffNkxz
         SYgg==
X-Forwarded-Encrypted: i=1; AJvYcCU8GZPpNjeIUhJ1Bdi0W71WhGkbo/dJCZeunOu3gt338vhjzq/EFIoqjajy+o6kq0DGbfwC/XMdKKbEBWmXSdI=@vger.kernel.org, AJvYcCWbpgytGrKYEb7jLjALmWJZgTi6q7pxe5ra/hF5+6ub17yVy5S7fJ/dJ1Q9cGYHZc6VZUufihFVeaQm2MF9@vger.kernel.org, AJvYcCX0O9q/Isjy5HcNQdcI1IpuKtpwqXfuIv9o/TyhAQlkPHBX5ulV7QIQoR7ILEKGbvyZAADqfqtWdcBK@vger.kernel.org, AJvYcCX4HnRUrtQUaUTvKQsZtz9z44CszGEv5uUyxIZY4v72Jw32aeYQSkYyE3SeAZMxyGFhDKhUmhyp@vger.kernel.org
X-Gm-Message-State: AOJu0YyghOp77/UGWukhHDLNoOqW3AfaYL9V8yV2mwM26nw8++YclHSd
	kVEdFepxJRjY4qrHm3LdyO0mWK2ujhJaAsWMmmuzhysmoKQe3oEB
X-Gm-Gg: ASbGncvVInZR+agE+EayyHuesNWZCV2JHHzJL/oNgyFK3C66kYa3SpVOkfc4yRB0K5i
	0p5A7qmvgoYzCxaej08ljf8NxH104BVyGg1+0k4sNg1AiKCle5H7bzj1DC94VwF2d7J6D84zGgC
	RSOa40p56dEzlK3WtJ73E+CORYSZn8SaXtHL6OPMVjILfYIz3XPsOEyAa3wPWI6uP7ydZmnBXup
	BMF3dRNHibF7efj2tLB445rynDoIvWjIF7cxFYWIzk1gIdOZXrWgM8Lmfc=
X-Google-Smtp-Source: AGHT+IFoKEXuuJkWVyc6E+OV4Yi3aleXB7y+UqdQJgSPCnb15ZOKQ6PeUxcw/WuP8movSkRgO7EseQ==
X-Received: by 2002:a5d:64ab:0:b0:385:f271:a22c with SMTP id ffacd0b85a97d-3862b3f289emr7788206f8f.59.1733690852077;
        Sun, 08 Dec 2024 12:47:32 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cc6fsm10874975f8f.34.2024.12.08.12.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 12:47:31 -0800 (PST)
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
Subject: [PATCH v3 6/6] percpu/x86: Enable strict percpu checks via named AS qualifiers
Date: Sun,  8 Dec 2024 21:45:21 +0100
Message-ID: <20241208204708.3742696-7-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241208204708.3742696-1-ubizjak@gmail.com>
References: <20241208204708.3742696-1-ubizjak@gmail.com>
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
v2: - Add comment to remove test for __CHECKER__ once sparse learns
      about __typeof_unqual__.
---
 arch/x86/include/asm/percpu.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 27f668660abe..1ef08289e667 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -95,9 +95,23 @@
 
 #endif /* CONFIG_SMP */
 
-#define __my_cpu_type(var)	typeof(var) __percpu_seg_override
-#define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
-#define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
+/*
+ * XXX: Remove test for __CHECKER__ once
+ * sparse learns about __typeof_unqual__.
+ */
+#if defined(CONFIG_USE_X86_SEG_SUPPORT) && \
+    defined(CONFIG_CC_HAS_TYPEOF_UNQUAL) && !defined(__CHECKER__)
+# define __my_cpu_type(var)	typeof(var)
+# define __my_cpu_ptr(ptr)	(ptr)
+# define __my_cpu_var(var)	(var)
+
+# define __percpu_qual		__percpu_seg_override
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


