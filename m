Return-Path: <linux-arch+bounces-7056-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14C096CE16
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 06:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04A528356F
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 04:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1A1152166;
	Thu,  5 Sep 2024 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b="Gnbn8lh2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0C149E16
	for <linux-arch@vger.kernel.org>; Thu,  5 Sep 2024 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510885; cv=none; b=aeAyJ7sOVjr+Yha//iBV+pZcBUqadXgIRD+f9tT53jy1ohFTonTAtseF2QmnsszG8Dhhxa8K7fYkWx24afeuNM/IAUsrwnfLAVCwYM9sdBcL9oM0DOY3yS/QfhDppIWPK8u6Zfmw1m9CTTsbwN5GLnxJm7W/KLY/7k8f7Aw1e9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510885; c=relaxed/simple;
	bh=8IWvP1Qy4mBHGbKYw9Ffftawr3e2vV2Wls3M4VinXRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExMCrrHCD1BeBY6VJJVIO407bbdl6rSPF8FxVlU+5CkAXjw40EVtEiONP/Z3J3NTrT5zINW21kttgCBBpFRz6tgBW5PAVjvwoYM/9OkEVRjBPc/MK0RfrgEy4N650MSxAS9ix9a2CX8lrvJf9AIR4pWL3DhCpFGXiUgizt9QdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b=Gnbn8lh2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4568acc1ca8so2157731cf.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Sep 2024 21:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1725510881; x=1726115681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJxcrlRpA7xjaDp1f7t4aVNh8eR9s342zQrnnOBKUEg=;
        b=Gnbn8lh2kuya9hMRYu87gr4Nv/2BiVveUixbwkiPBbQKMGPEAGHLItMUWSZadTIUp4
         qcOsFK5zuyTnISjiCXXxNL3KeI8C3+iaCEJbiYp/2hsoesRQgiykTB27vjzdT04A+Ad5
         T5Y9XHK4jmGf5emChyikukyjPgD+DD3rOx0tZACVPi1ajrvQfbsbZTVQDo7BBxYiBCtC
         +wZzRtyX8i4hnX8boxBShinjiuLAj5blbdmwdC+TpScXDet3/z51GyAm0Nb2xT/jwOVn
         ywEG2SwppiHDuZNQvpcCIrsjzLnizXOGkeorMlu3y15I8n+NRkgpN4jsAp8YISpAZhFp
         Ao0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725510881; x=1726115681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJxcrlRpA7xjaDp1f7t4aVNh8eR9s342zQrnnOBKUEg=;
        b=DY/Ln0lwJ2q3f+T1gE186a9qZDH0WinW8W9PmqCQmGjN5c1zIry4NtZ+SQbAkev1Ss
         bgRvZIj+tQujAsbfJU/JRfFHwKer9R/W8XjF2bBoJRop6ah2IcpsFPf/NQryAxnQPBzf
         JgnB6zhig58dOn+eB4sKZ7FZLjyHw5zR8IQMc1gkwDaYd71QRmLuI8FjlynRtzK/FA5R
         m5AytGVqAA++Flt91/2tdK8IntArDRpfDdAbRgY+zkwoOVHEMy20/eVHIKvwPo7A7Xu/
         VhCxbSmeP3HvmYgzn3Gt8Sv6xLW6K6VOgQyY2B1LyCA1jpOFkr0nHH2P9zlaz6g89Itl
         dX5A==
X-Forwarded-Encrypted: i=1; AJvYcCUrIAJZndccfErsDSbetD7fZ3+vo+fJ3IWUC2OfasetSjq4IzjDm586bjq80PaRnZUF7fwWAqA+V/sS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9AgpSt8Mv87AWRrzzCf01UEAGmO1mQuGnjrr2255LahfJlpvz
	kGJDjUbBRBwQnfDJVkb/oVMEaQs9NcuETyJgDy4qGyYbJQ5tTh/YpYNQ2ND1jw==
X-Google-Smtp-Source: AGHT+IFj3a9cchP0/vieZqbkqznpCBKGRkfgZYOb8Jn2LlQ3lfAJzRpY8vMS81DOZGJeiUwzkUU8QQ==
X-Received: by 2002:a05:622a:993:b0:456:847d:47a5 with SMTP id d75a77b69052e-456fd7da328mr225326911cf.38.1725510881546;
        Wed, 04 Sep 2024 21:34:41 -0700 (PDT)
Received: from node0.kernel3.linux-mcdc-pg0.utah.cloudlab.us ([128.110.218.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b4cf4csm4182341cf.48.2024.09.04.21.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:34:41 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: wentaoz5@illinois.edu
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	x86@kernel.org
Subject: [PATCH v2 3/4] x86: disable llvm-cov instrumentation
Date: Wed,  4 Sep 2024 23:32:44 -0500
Message-ID: <20240905043245.1389509-4-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905043245.1389509-1-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable instrumentation for arch/x86/crypto/curve25519-x86_64.c. Otherwise
compilation would fail with "error: inline assembly requires more registers
than available".

Similar behavior was reported with gcov as well. See c390c452ebeb ("crypto:
x86/curve25519 - disable gcov").

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Reviewed-by: Chuck Wolber <chuck.wolber@boeing.com>
Tested-by: Chuck Wolber <chuck.wolber@boeing.com>
---
 arch/x86/crypto/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 53b4a2778..57f3d4921 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -119,5 +119,6 @@ quiet_cmd_perlasm = PERLASM $@
 $(obj)/%.S: $(src)/%.pl FORCE
 	$(call if_changed,perlasm)
 
-# Disable GCOV in odd or sensitive code
+# Disable GCOV and llvm-cov in odd or sensitive code
 GCOV_PROFILE_curve25519-x86_64.o := n
+LLVM_COV_PROFILE_curve25519-x86_64.o := n
-- 
2.45.2


