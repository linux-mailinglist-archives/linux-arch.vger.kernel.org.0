Return-Path: <linux-arch+bounces-7529-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC7498C26C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 18:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AE41C24040
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2D41CCB46;
	Tue,  1 Oct 2024 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gQdL286E"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C461CC892
	for <linux-arch@vger.kernel.org>; Tue,  1 Oct 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798837; cv=none; b=HIE3gvy6E+kQczaTd1iiHxapUGCUgQZ00IpbTiwyi+pATSK3Ul4fHU8MWUhQbp+Fh0jZdAzDnw+fNrjm+BRHFPhlIG7GqqcTFd4w606RkqVC0bsJxZvpzDw+tTQG0dckeoOPuGWouqSWRmEJMyN5dml5QzcOCoAAI7xLh46JHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798837; c=relaxed/simple;
	bh=Cq07DZYYTuLqQ4gxwqCLLHBNKJv4iDz96fE7XrIs4Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GFwKZ6CJDbrUCAsuIQsmqJZVAvfKoifGSGpD3+fPWIciI5WUMdS1bw7WOCBC4boCcOtQOOMLpV6LOKdVER/IqO83lLfqiUsqd36KD2KFEuvRtzLMLxeFv+4FRjBMB1ZgSvJReIVyIcUr4yU0PyWCRBuA9RcQndlWOs04YsSjNLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gQdL286E; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e0c7eaf159so3760246a91.1
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727798835; x=1728403635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxvPbFdPQ1tC+j3wFHGGOQBUzN++1F4GTwbS3f8RUbU=;
        b=gQdL286EriOvKuyIIAfyek5awxMP6bl6wgvBevWfpq9TulYGm7jWarTNrbF1fRUsLy
         wGjIFVtxRjyVvWdgMIC3at2JaT5LVT1AM1VTwaOMVR+EVS/VNzo0dXWu2q8hZa1VMAnu
         564/nLuybd9x2M6Bau7S7Eq/ZfX2R4qCDOftkLvygLNjSvCOB4o8ynFNeRSfEP4cJ+Hi
         XSYiWSerPJk7RmJKqKS6g7yAUTus/Rqa5iF3afbihMrySeYAonqRCBMVDTJcJjmOCrAy
         q5E+Xj4KkQ1AApM62rnzgMz1ReuNVNroNg89OnBDFq6cMICNiCAtGpAPxTjSGz6AZqOH
         BbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798835; x=1728403635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxvPbFdPQ1tC+j3wFHGGOQBUzN++1F4GTwbS3f8RUbU=;
        b=e+n6S/VJn/uexhwciXLV6jC3OeGBD6hap2i3tdmM0yliTYXvbNg30G20uqk0unvxd/
         UrFdetor1LSVXnGj4iwcvvy6wZaiHQGN4mB3iMgT/Lh1GkgmFiiJKvONM+J8BY+cqrw1
         KPKHlCKjrTKBgramD7oFu3XOhiWXgx4KRRsTEuqwEOhejMJ6LTBbvbSwjr9ZGwl26QxS
         AyTrbBoJYdRS1miQaaFQDjL012r26bMpiBPMdGx1HM/1S3LAYh2GKvfCNI/qRoxGPt4L
         81JvTcj+HBovVOgSoTiA38H1n+vTXoOKjVVtSXtfp9Izvr76GWB7wzQ4tnAtcxVZbJpA
         TJBA==
X-Forwarded-Encrypted: i=1; AJvYcCUkugCmQHcjLFNWjcFXPYjwwK1lCeaPvS6sBgDNctLhAxSOk/W6pFFOqHAzB/mVdA5yNNUnnEUH6A+E@vger.kernel.org
X-Gm-Message-State: AOJu0YzK+qTQ5T5LbAJRnLbloJPU+SNWmBhHf+McKWjgMgx+NI9515S7
	QkwjssO8i0M0tsVoF+PlRQu5MmDdasz+NJDfYPi86ld+qu4b1reMj3pSmluUPcw=
X-Google-Smtp-Source: AGHT+IH2Sm4Er88BRFmxFtoVQlQZa6M14xX+NOC0OSBp2pCUlTzjnB+u1q8ipbNjt5+sqIq3C7HKbw==
X-Received: by 2002:a17:90b:3b52:b0:2e0:8784:d420 with SMTP id 98e67ed59e1d1-2e1848013e7mr226286a91.21.1727798835139;
        Tue, 01 Oct 2024 09:07:15 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7d47sm13843973a91.28.2024.10.01.09.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:07:14 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 01 Oct 2024 09:06:11 -0700
Subject: [PATCH 06/33] riscv/Kconfig: enable HAVE_EXIT_THREAD for riscv
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-v5_user_cfi_series-v1-6-3ba65b6e550f@rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
In-Reply-To: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

riscv will need an implementation for exit_thread to clean up shadow stack
when thread exits. If current thread had shadow stack enabled, shadow
stack is allocated by default for any new thread.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig          | 1 +
 arch/riscv/kernel/process.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 22dc5ea4196c..808ea66b9537 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -182,6 +182,7 @@ config RISCV
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_EXIT_THREAD
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e3142d8a6e28..1f2574fb2edb 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -201,6 +201,11 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
+void exit_thread(struct task_struct *tsk)
+{
+
+}
+
 int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;

-- 
2.45.0


