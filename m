Return-Path: <linux-arch+bounces-9923-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A85A1DA38
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 17:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09F357A4F2A
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1AD18B477;
	Mon, 27 Jan 2025 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTLkKca2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DA11898E9;
	Mon, 27 Jan 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994052; cv=none; b=p7ugDCAqCMV34HrBKZSyPcj56bBt8D8dZw2F5pppQcObrRenXVF985D/ROCn4leq9BwByJMxBjMPniSE8uQYpq4Y/Bz5+8asjmxEUDRHsL5e+wSO05fL3pHk/RLW99E/Fhwv2VpblNY96cWxwTGiG+kRAy79QXqvCSaz4Kq6Ip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994052; c=relaxed/simple;
	bh=VD2esfG+2A7H5xnu8x5ip6Z+n1iO/sQ6fWXzAj+5R9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9uzn+zRJog3wOq9c6seGjhV2eDf6EvjP9d0VYg3SUziRnO3Gtl+eh/EB6KL+gLo4pQEWn/tiwCcQEvboFB5MvTFZeC53GtsJGfILvUE6DE63U08CB8BosQ/ibZizXX4HRXh3m+gcNDDw39+iuEyvuoLUmcsDlgb1ZxV7fo2FkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTLkKca2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dc052246e3so9419645a12.2;
        Mon, 27 Jan 2025 08:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737994048; x=1738598848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQICK2kFPsfEELpT4bODj3LxfYome5g697HLvcS8DLE=;
        b=cTLkKca2U04HWXPM43X8JQRw+cJrzyWhQiVLMhjjNzQY45zDA99Zqboa/mbFfPCVfF
         6+7mnuMh+ppxQiQ7EMKTW05y7hlc4mgXcjHBTkCp43IxZJF2pW4hU+3/HpAbxwdVzWU1
         0mUUvcZW2wITnTkPUTny8HoZrYsXfgFcKx6iROghMIRt0AI5JIMOabzLBwCqAIDNXbdq
         0X1rkqSpX/MkgHkEzv8J8+jdaBL038ylexRzifTVm6UCiag6it8iY/lshTeAMSLvDdUE
         coaTrIjCyqfDN3houcKj5w/yZwzblN8HMJylrOyu22CVDJ31MU4dYX81oZg0phj9JUqE
         CCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737994048; x=1738598848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQICK2kFPsfEELpT4bODj3LxfYome5g697HLvcS8DLE=;
        b=rrXTTgHsAk1wz6fkMzhA3K6ckvtdh7EERPOSZI7LIOwmiRsCFE/+cSn9p6aLO4qbjS
         1tdsQh8hXNB8WXsQq2DDt2qW6lyJz1Wk1euYj1ehbsnhR/EwllGrxVETT8vLLIC8lOWZ
         2oKo+iOp9fWRbEJBVUJ4vDPV/lrJAAw8A8gbMTKL5v0FaDoFGqqDZX8s6gomDlxQ5dIx
         wNeSwrVoh485T8H/zr6nJUfXz/wSAhmU47D8rJb0CGxCy7bnEehZ3T7tFlqfeiBu8SvL
         PL2pnRejLOgfzel2db4kkUKRXqMcXukElEKkK+qA1PciKsu2olz+v0c+3lLeZGU0F8Sp
         vVcw==
X-Forwarded-Encrypted: i=1; AJvYcCUx5V4W90M4OJssH2D3xyViqD9WlmXd717xvzaGQd04FkdLQem6Di/YLdOCuBKYcKlGg+Co2lColffk@vger.kernel.org, AJvYcCWRu1DBA0YCLZiyHljfpl/ESwDqTRkXoGNiUK59YVd7yDbi/nvWaIb2csIhpAHjZyfBw2zZB9B0@vger.kernel.org, AJvYcCWZI7mepDyS8z9c9TruCIG/bQrdY1wPVgIaIyIU1w7gqwJBrzDYW+t55buN2ar4eGrELZS3B5luv+R52soq@vger.kernel.org, AJvYcCXSSrIWjpCvuhOB3oZ/RS6xaa4vOu8C/b2EIe8m4ZNa0RG1ofy6zxuB5fjwQpYBI1wJJmp/7FDx/CL6DzMF3Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziZuV2rsHLw/Ymctr5qZgjlZmTHWQUuyuYTSDsHAzkCYhPAH/j
	Vaeo0TpXiOWMYxPL3WakSc6p6ypzcN2jaJOFIIQiC1CQmJh0laaB
X-Gm-Gg: ASbGncuvOhTljAUXAyqaudm87SzyZqlclTp3/LPMVHc8BKx6qp+5joK2Y3jB+VZcxzD
	rMrXaFNbrdAZEP9f/UNe9wm8rHIg8232k2QAIW5YnEH5eNHU3xHLpyCnYnx8he5QbtAD5AFrAQl
	4m4PFwX+6iu7gKMtwWyVYbBYl8+cNasEUHyQRW+kk4B1AMkM1hDii788w7el13PzRcJtXahym8k
	YUUboyeGBtVDJWtbB5Nge1+K8aJ/waN9HVdHP7zHkWPxJ56RUj2UQEItS5IC7nZBR2AutUnJxyN
	vIj/FT/gZTAlqA==
X-Google-Smtp-Source: AGHT+IFAuvcto44xbfJbzToMqvasWkjx8mJOE7NNj1gZKmPQ5KI6lBKJIGSybMmZDHGSQog3h29n+w==
X-Received: by 2002:a17:907:1c19:b0:aa6:acd6:b30d with SMTP id a640c23a62f3a-ab38b4c63f2mr3942830466b.48.1737994048224;
        Mon, 27 Jan 2025 08:07:28 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e8b01asm592643866b.84.2025.01.27.08.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:07:27 -0800 (PST)
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
Subject: [PATCH v4 5/6] percpu: Repurpose __percpu tag as a named address space qualifier
Date: Mon, 27 Jan 2025 17:05:09 +0100
Message-ID: <20250127160709.80604-6-ubizjak@gmail.com>
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

The patch introduces __percpu_qual define and repurposes __percpu
tag as a named address space qualifier using the new define.

Arches can now conditionally define __percpu_qual as their
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
v3: - Rename __per_cpu_qual to __percpu_qual.
---
 include/asm-generic/percpu.h   | 13 +++++++++++++
 include/linux/compiler_types.h |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 50597b975a49..02aeca21479a 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -6,6 +6,19 @@
 #include <linux/threads.h>
 #include <linux/percpu-defs.h>
 
+/*
+ * __percpu_qual is the qualifier for the percpu named address space.
+ *
+ * Most arches use generic named address space for percpu variables but
+ * some arches define percpu variables in different named address space
+ * (on the x86 arch, percpu variable may be declared as being relative
+ * to the %fs or %gs segments using __seg_fs or __seg_gs named address
+ * space qualifier).
+ */
+#ifndef __percpu_qual
+# define __percpu_qual
+#endif
+
 #ifdef CONFIG_SMP
 
 /*
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 981cc3d7e3aa..5d6544545658 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -57,7 +57,7 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 #  define __user	BTF_TYPE_TAG(user)
 # endif
 # define __iomem
-# define __percpu	BTF_TYPE_TAG(percpu)
+# define __percpu	__percpu_qual BTF_TYPE_TAG(percpu)
 # define __rcu		BTF_TYPE_TAG(rcu)
 
 # define __chk_user_ptr(x)	(void)0
-- 
2.42.0


