Return-Path: <linux-arch+bounces-9310-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA039E87E4
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 21:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27321885323
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 20:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D95C199FC1;
	Sun,  8 Dec 2024 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHiTaU3P"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402441991C8;
	Sun,  8 Dec 2024 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733690854; cv=none; b=CLVVSgVu0BZEiBH8nPanL2Gx2SzK+npWhWmb71RUTk0yhHhGsl2S/a1sytkl21f7JtCWWxTIlfEGDnt8KuM91gmmKoeaZKBLXf1VHl9t46PHQV64UVH8NLBayLHHVTJMJmwp8JORfpSvsnNLK/Uutklre2PJirP40QkB96+a+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733690854; c=relaxed/simple;
	bh=VD2esfG+2A7H5xnu8x5ip6Z+n1iO/sQ6fWXzAj+5R9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=on1nIAgn3uJbm2ClLoqrAhm8rQuvXE4v7kgRbXSdJDVG/m55ZbfYn4ObVuPkPVhJzRYF28+lIToYiK1+2TzdY2kg0C7MVidZfQOiEwL0+c1Db4vHarf1Bp347ZmU7p5kY9EkXVmGVqNgwvJ+K2B92LIWCCdpPq2LObS15IQwc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHiTaU3P; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862d161947so1666871f8f.3;
        Sun, 08 Dec 2024 12:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733690850; x=1734295650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQICK2kFPsfEELpT4bODj3LxfYome5g697HLvcS8DLE=;
        b=JHiTaU3PxOmgrxeiAfhPeZ1i9kuouRuuqKjcwuUSuA4YVoM8Yfte02Ecrf3rlXXYmC
         Dq1oKofUJTKBcbJHIwgmfxozKFNJRgI+E+SLo7VKaGcSG6iJjME+w7amNCqUA15jBa+0
         shM3X7jeOTJGeUaoobxYNqAzIIQskUUkJSTsSmUWyvJz0ldBeh7s7PSgAnXyP9MyBtOE
         rx5queEX+mif8lMEn06QQBc6hRxhEiwXF+1YBt04l34dDUKZLPysluxsWKpB5WnK5fJx
         whwM6tJMrDbZgShu9z0La7PsDa7iR6xOaJrejzBUNn/l1Un7e/WZ1zFPYteSaxCjL7qo
         rm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733690850; x=1734295650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQICK2kFPsfEELpT4bODj3LxfYome5g697HLvcS8DLE=;
        b=kt/xCRX2FoLKb38qcmc26ouGaZ9V+nM1VU/+ZRb81jkI1moNAXm1HwGjUoRosm1UJC
         I2+QwqFXWFtDo0HYvjGpuiK4JY7Ac6A/UQLCa5/JGEDUSas/ULtecAxzuzfhcRJFxcz0
         u95evwMlfxzs5HfP8yiJ+HtSSX2cpObfDtli5oKhMekDc63p/GL5rDiaheAY9JvQFvj5
         9mn8MU2+CDBePj311MMYjgBCFBBlwm5pDeAb0ZbBEKVYBMJZ4kZwQqC+1BEARcbVGB/7
         0j87lTQetH1eylGmhqmI05e8755hVJfY8cpd2bm/0rwG8DiKnUQVFih99GhS4Tptgbh4
         9Z+g==
X-Forwarded-Encrypted: i=1; AJvYcCURJjf5OOAd9JWPmihROLdlbeDsAwcpqLmfO2ljPktT62uTetEBRuXase2OnkPlNMHJY3L/VhsWliolBVGb@vger.kernel.org, AJvYcCUThUvYwGybQTkmqxH4782JQwYLLyG9V8EJQvSBAwj+QFOIXKznP7W3CnuxpcwhJf21Cqd6KJku@vger.kernel.org, AJvYcCVGXsZUvPn2+GsgxctHafiDrD/o+OJ8xQypO1xjo1tNe/jNoeQR2SDheYXL9kIpfHMyeNohCNxm0KSXBCcxIWg=@vger.kernel.org, AJvYcCVPbqwg5mkyzVUQ48ziddpoKLiNfxpNrX5HHaft84pzzlOjd3hY52Qn2gihsob1y9VBRdNNpOIHTRlo@vger.kernel.org
X-Gm-Message-State: AOJu0YzXqJFGbztDlgq0PvvvFHYhyXlu83JBkWQeCWO4j/Sd5pZNsRkv
	4hf2iH2vflJyYvZ0PqhXfUH6fnqhjQ7tYI3vZiDPNCcNi8nholvX
X-Gm-Gg: ASbGnctTVza//jYbr8V7Nkt75K28A/Nm303w40Ql67ApgvRNip67qq/Ka5FBQ8++Lc5
	yG1SYLrmsJFSewlflYhOBVxk9oDQTKN1kSe70QxmK50WQF/rhyrQc/ZxcWAPOSVNey8LhK7enkZ
	acHyh0N274GaEicPWpJQQRy5CiNv2MAgrn5MKfHc08RPn4DqK5+ghH2g/7bmtIyE16UugnyX15L
	cZMuL+Dgzo5oAUyhUx+p8L6Q73zAvtHF62oe9/HlH7Oozk5Ai3ebIEipH8=
X-Google-Smtp-Source: AGHT+IEgK+5BlWjK5hYmyAc92iK0vY/52y9egBCaI4T3OGpocF9n9vCZzb2/329/9E4vHrdt2CJvTg==
X-Received: by 2002:a5d:5f8f:0:b0:385:f092:e16 with SMTP id ffacd0b85a97d-3862b3e3ae1mr6811496f8f.55.1733690850465;
        Sun, 08 Dec 2024 12:47:30 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cc6fsm10874975f8f.34.2024.12.08.12.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 12:47:29 -0800 (PST)
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
Subject: [PATCH v3 5/6] percpu: Repurpose __percpu tag as a named address space qualifier
Date: Sun,  8 Dec 2024 21:45:20 +0100
Message-ID: <20241208204708.3742696-6-ubizjak@gmail.com>
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


