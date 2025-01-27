Return-Path: <linux-arch+bounces-9924-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D610A1DA3B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 17:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B5D3A80DD
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B54818E750;
	Mon, 27 Jan 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rrk+SjZC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECCD18BBBB;
	Mon, 27 Jan 2025 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994054; cv=none; b=D6w0BSvdTfjMi1fL2lKQlR1RROjAowKG5qO/ET2XrN9Nec4wsHDBsTtYkr9VSvYYxrwJdWA2yHYSSm92pKXMJpMlW/C9KeqhG3xVmrzjn5ouEatQ5DISuG6wiopsecRnEofUNBP4AgSOxS8ernYlgpEYNVty6dc41DP7DtWXNho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994054; c=relaxed/simple;
	bh=akMqODiqeN8wWk3NHvjbNPcxc03Zh5d0pwf+U9K424c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc42QmAbc54rC2sCtK/BF4m9o8di/vpuFbnENsaUiyI3o3hjCapFdNOlzaOlYiybAasBLcWRcMa8VdWotvBuW5MYbXO0fwQ++zcR+tIRhyXCspYaDfopVWJWiAyqO50+gDU7PCNMfCM8QzrlUZfTLAVb9Q2S6TGYVkt3TJBDBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rrk+SjZC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaeef97ff02so767671966b.1;
        Mon, 27 Jan 2025 08:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737994050; x=1738598850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrZpQikn3aM6B3Iqd/Ucnjx7jHzSyajd3QTmq9Vwrvo=;
        b=Rrk+SjZCZFuKVTuU3ZxE/CBmDV4khDaEmpCki1+V4khao0clWNGCKzVpyyMhrwXHoI
         l6W9VAuzEfaC2+D2sD9ZqksrYh7muCEAqkzOQlYZnfk6nrGQghEBXvAMNISdlX81f2Rh
         4b9c8lShMDohWV4cBWwW9MqREfaFkB5PtvCpKTx7sE4TQB/6N1dIvjykHxklz3h/aYqL
         ZSoBlRkTdovCuI0tluFuwZLdZn9TnutUyeF09Y7dw9Ef+SalRBseUe4cS0r9AP9/OYvs
         8itmFrturJnBsLsT6Iw4KHzVQyRSfpmfxjQXEZ0zGzwVwMPnNWtjEig4Ow6J8XM8qpEr
         M3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737994050; x=1738598850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrZpQikn3aM6B3Iqd/Ucnjx7jHzSyajd3QTmq9Vwrvo=;
        b=YPvSfUPbCSGdupb9a/2S0ScrdPvhQgn+1otXGLXA8drKHgVw+BWqg2Ui8Q0Bz7R/MQ
         iR4Tmqn10P9ZIjnE0WVB4rUClP9hb+wdZtRTqxrVldvwUTP2lnduKB4AqHcFnswAhGdz
         f5x7HGh3btUgcL47siWCrvAGjwko0Hyu/041I6YV+cqBnX0IC53Vab20UiA4B8dFr2kv
         2tMe0+KKBTu/shinmqtdY2qOflkhyd70jGVn+OiVjr317ICR85r91eyI7fS9g690hzHT
         07bdlcIOUbkSOd8ORHN/Dv7p4aoFWqlvcxRL/JdDYWyQUhQD1HyMeUqrV5GIvQjDxe1C
         PSmA==
X-Forwarded-Encrypted: i=1; AJvYcCVgKaUo90mNJaO0ttHKhKAukRv+C8oVofWSEd9QWo2frPRsmUQ1Ipuf4K8IOttgSIuf1fJnSkqO@vger.kernel.org, AJvYcCVuK4YUK43BT3KDrj5K9F9+RUNV47Eg6c/QQFaFTuN1gJzB1VfxhNG3MgTmzTatoWxolAUwTeWROZj+RhBT@vger.kernel.org, AJvYcCW32n+7KYF8HKsRiwbPRmQD9PM4bfsgppE6ON43gyo2xf9F4wTwm4xf873FFKT44dpDyW7Abs1ErKU5@vger.kernel.org, AJvYcCWAgqeVujaSXfD1ToXY5p96dh0iWSuLi00BLOAgPHSdu5a2ujSXA0bxyQtgVRdcaI3/Vnc/OgPqTO6k136PaiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaRq8k+gsnE4dEtO4JySGdyJ8WEkuKzDrSRGS00a1aJjCguatc
	Utf0IPIlVkb9wPQsWS+jL9AhHxwpeWze+4js8JtHDmG8JcUzIecy
X-Gm-Gg: ASbGncsB0GL0SQLkQhvrxgG7O8FBb43FY+UoqYlQH1oGiBDSGkIbSfY20LV7Q/6ho8p
	6zo1xQukrCx5fcznPUq0Ji3tTbAe0E0V4rwlU9dmsGP+wMGJ2y+15gnaAJumfHcfCQlyQi0yGDo
	mCvDN36xU3wKrVyat7upIM77ULJR5OMuLO9dh2f0b7drSfKoZpYFqcZNe5x8Ul/aXO04KkWvXFF
	c3Mo6xofPxWtN/t/mSI+zZXBNcuJ/IRZvHUOMP2hSgpRAVXay2LQWejweS9BdncakRRjBa0id+o
	CXJqPi461Z3tgw==
X-Google-Smtp-Source: AGHT+IHVilwWp86cIXuCPcSCEjAlKAPSZRo0H0MsLWLvAzoRKeZuFBp6uVwp/VtMeJUTjVHCLgUcfw==
X-Received: by 2002:a17:906:4f8c:b0:ab6:362c:a8ab with SMTP id a640c23a62f3a-ab6362caa41mr2246025266b.29.1737994049651;
        Mon, 27 Jan 2025 08:07:29 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e8b01asm592643866b.84.2025.01.27.08.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:07:29 -0800 (PST)
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
Subject: [PATCH v4 6/6] percpu/x86: Enable strict percpu checks via named AS qualifiers
Date: Mon, 27 Jan 2025 17:05:10 +0100
Message-ID: <20250127160709.80604-7-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250127160709.80604-1-ubizjak@gmail.com>
References: <20250127160709.80604-1-ubizjak@gmail.com>
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
 arch/x86/include/asm/percpu.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 27f668660abe..474d648bca9a 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -95,9 +95,18 @@
 
 #endif /* CONFIG_SMP */
 
-#define __my_cpu_type(var)	typeof(var) __percpu_seg_override
-#define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
-#define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
+#if defined(CONFIG_USE_X86_SEG_SUPPORT) && defined(USE_TYPEOF_UNQUAL)
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


