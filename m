Return-Path: <linux-arch+bounces-3295-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F17EB8912C4
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 05:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5904CB23D9D
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 04:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028264F887;
	Fri, 29 Mar 2024 04:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jnYDFceL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7924DA12
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 04:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687600; cv=none; b=GOTJoq9JO+Q1GoEqaWBk8/nwG5A85L5q8BxnPVS2kZ0/furOybMVg54mvf4S3RwCJiX4sfct7Yl7Ibv6wxEDY4zfR6HjxJjfWvWuuBVMwSqzKX2U7CkDk4ncEZ6IlKayPLdQAmO1klW7FMZnrbHDwRnyAPHBJL+SzvmTW2jQgWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687600; c=relaxed/simple;
	bh=WZoX9OMaTgZ5W8TxdmEgour/LDEOHemNGGvTExrcBSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qwJSGCTYK2q595M9YEsNXDOQCHcfQAWCWqQj4fyO3iy7K+tH6bWlEpEfQSTFZ2Dwo8z22oKyndwub6HZHlGckxQbhYtQA15SrzysbJjoaMGDAjZ5X8h8SEKXytfKe8dzKhDdDL3FTq3VKaa30Ttx+nQezy9O7dNvrwyFzB5gRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jnYDFceL; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2282597eff5so1116789fac.3
        for <linux-arch@vger.kernel.org>; Thu, 28 Mar 2024 21:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711687597; x=1712292397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOjKUP7R2Pn5KHy+bcQHndffhGuedIhGkkiUJ74Ko2E=;
        b=jnYDFceLOMiF4Lkr3b/7DoM2gfBm63VgJ2aeU5oqHWQ3iKMFVHE9xRGmMIePNNKXFu
         WOXY0dIqgK6YzeNWCPPFwlEP/15NqU20rqGhlwMHdhUl6Ly1XYPP4gnannd6nCqOha7r
         JMZOzCo1Ww5u+OR0Uj/AgoWzujDIJjMPznzR93nuDRshkCqSfOh65G+TVLHLJ8xXmx4U
         zC9WHvujAm/y2K98Y2n5Q87rg6M+ilR5ItyyNo4kl07oH5cHUx0zucQynn8DmIOa6WWU
         jWePgXUksnnpMW3yrwDSAwQ8pSrBpPNe9PDIHN+aYUiZ0Um1aOK9mjwQD8N04TL9gzKf
         lCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687597; x=1712292397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOjKUP7R2Pn5KHy+bcQHndffhGuedIhGkkiUJ74Ko2E=;
        b=tM672KXP6w4MpQyBnQboY7vtg463zdO5rlahxGn4BvJuXP+LV1veXWWKYO4K7VUiAZ
         c3ot+alD0q3+VKZMUTXDmRZIhO92v+eyudpKLzORBfP2qYIJfpO/NDUpOAd8KhGi78el
         7B3+Z29t+/n1PUwKE+B+g6F11NC7vjNtX4QsbFStBZot57GPKEz5tCB+N3CzbXjoPEii
         uSu/CZjyDat3NqnxSgVKaf67CQaaLlJq8aPcNXQOaB1RHjN6vNZKm2UbwxthqpKUMt55
         jRo4AZegYOKRdpihZ4Nn0LNycKI1fd2mQCbAYaHBPMKoiNOAVXbOQIgFLitcQYazKtDu
         lajA==
X-Forwarded-Encrypted: i=1; AJvYcCWGCpVEgZAEGNwxXr7CHyHmEFwCUAKfKb1l45ccJt0VXIMRwYvP7dapSzT56TqV+2m/0q8HQwgHLR31aMepwssHvf1gq1hmqpjiAQ==
X-Gm-Message-State: AOJu0YzEpGJp50/ws85YUH72xCeO6Gm9kd+CkuJsAlkNi2YhBoUjyXvA
	z7AyfJO2ts8dzZ+kxr58bXUpHDTaBkEud/EnNPpk0fb+9MdZTfsS+eJ/L1G/tcs=
X-Google-Smtp-Source: AGHT+IGJQSx7xjJ7n2mbejRm8WQQAwrhRnla3swVvKyB0ZaA2dVNGQk8U096glMvDQJ5OLMIlZU/5g==
X-Received: by 2002:a05:6870:b698:b0:229:e636:921f with SMTP id cy24-20020a056870b69800b00229e636921fmr1250647oab.49.1711687597188;
        Thu, 28 Mar 2024 21:46:37 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b006ea7e972947sm2217120pfd.130.2024.03.28.21.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:46:36 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	tech-j-ext@lists.risc-v.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v2 16/27] prctl: arch-agnostic prtcl for indirect branch tracking
Date: Thu, 28 Mar 2024 21:44:48 -0700
Message-Id: <20240329044459.3990638-17-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329044459.3990638-1-debug@rivosinc.com>
References: <20240329044459.3990638-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three architectures (x86, aarch64, riscv) have support for indirect branch
tracking feature in a very similar fashion. On a very high level, indirect
branch tracking is a CPU feature where CPU tracks branches which uses memory
operand to perform control transfer in program. As part of this tracking on
indirect branches, CPU goes in a state where it expects a landing pad instr
on target and if not found then CPU raises some fault (architecture dependent)

x86 landing pad instr - `ENDBRANCH`
aarch64 landing pad instr - `BTI`
riscv landing instr - `lpad`

Given that three major arches have support for indirect branch tracking,
This patch makes `prctl` for indirect branch tracking arch agnostic.

To allow userspace to enable this feature for itself, following prtcls are
defined:
 - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect branch
   tracking.
 - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch tracking
   Following status options are allowed
           - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
             thread.
           - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on user
             thread.
 - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branch
   tracking for user thread.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/uapi/linux/prctl.h | 27 +++++++++++++++++++++++++++
 kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 3c66ed8f46d8..b7a8212a068e 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -328,4 +328,31 @@ struct prctl_mm_map {
  */
 #define PR_LOCK_SHADOW_STACK_STATUS      73
 
+/*
+ * Get the current indirect branch tracking configuration for the current
+ * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STATUS.
+ */
+#define PR_GET_INDIR_BR_LP_STATUS      74
+
+/*
+ * Set the indirect branch tracking configuration. PR_INDIR_BR_LP_ENABLE will
+ * enable cpu feature for user thread, to track all indirect branches and ensure
+ * they land on arch defined landing pad instruction.
+ * x86 - If enabled, an indirect branch must land on `ENDBRANCH` instruction.
+ * arch64 - If enabled, an indirect branch must land on `BTI` instruction.
+ * riscv - If enabled, an indirect branch must land on `lpad` instruction.
+ * PR_INDIR_BR_LP_DISABLE will disable feature for user thread and indirect
+ * branches will no more be tracked by cpu to land on arch defined landing pad
+ * instruction.
+ */
+#define PR_SET_INDIR_BR_LP_STATUS      75
+# define PR_INDIR_BR_LP_ENABLE		   (1UL << 0)
+
+/*
+ * Prevent further changes to the specified indirect branch tracking
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_INDIR_BR_LP_STATUS      76
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 242e9f147791..c770060c3f06 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2330,6 +2330,21 @@ int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long st
 	return -EINVAL;
 }
 
+int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
 #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
 
 #ifdef CONFIG_ANON_VMA_NAME
@@ -2787,6 +2802,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = arch_lock_shadow_stack_status(me, arg2);
 		break;
+	case PR_GET_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_get_indir_br_lp_status(me, (unsigned long __user *) arg2);
+		break;
+	case PR_SET_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_set_indir_br_lp_status(me, (unsigned long __user *) arg2);
+		break;
+	case PR_LOCK_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_lock_indir_br_lp_status(me, (unsigned long __user *) arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.43.2


