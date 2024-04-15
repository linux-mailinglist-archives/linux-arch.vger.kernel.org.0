Return-Path: <linux-arch+bounces-3704-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5878A5799
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 18:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFDE1F22D98
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F088249F;
	Mon, 15 Apr 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olNOjuVN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646182490
	for <linux-arch@vger.kernel.org>; Mon, 15 Apr 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198057; cv=none; b=MvtszqQAsOlUEJh6rcwm/bugX14mLViTMMIQyPDv5d4IcUxtN10m0rQI9pHaDpfj47x1AYo/Nuw/0zpFKwtqarDNLIUqb89AT7EyHA1nUWT0XoV+UU55WLu5lk8eRbFxMugV6tRYEeXhxD0UtDzFI2MgyvPqjtwUAX2f9H7vTJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198057; c=relaxed/simple;
	bh=GbAxPIv/vbclXmPWPZ8Tu9s+wJ2dryRysJiHKFw6Xpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+/lFbX2qJK+wor/7QY5ajoVbxIhDfEGvgr5FCKOZMPiB6nOj8ls/ORhNhf+K+xnLTuXIV+86Ot7whvuqQka3ep3cxPBr1JOU+7vAD2foMUKGVSNmVYDshwP3K4YpRHGqWBR674YWTHRe5hDTR45cR6R4WT8TSq4mAfWfAFn90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=olNOjuVN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso5289625276.3
        for <linux-arch@vger.kernel.org>; Mon, 15 Apr 2024 09:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713198055; x=1713802855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHqqRenBwHH3dYNpNtPvujl3JPCakWggIzfiR8Bh9XQ=;
        b=olNOjuVNcxnUhXkcnnpsE/1bvkr4YCU73TVdBmvsBCde33BwBW5oLO/oQjGbGT4MVU
         iy0+0pmV7z2AzNN0iJtqrYRY26rIwKSKgg3WX735Q3RCQPIel7LLoXL2NTAm84QJdS/4
         s/a8b1Ntmoc/s+fpF7CXx8p4IPxxiiVmjzxWRflAAnJ10AIHz1rs8lwNlwDjdqrqDPGb
         qQk4JhqYAvnrZedkPyAed66gG/oFnrC5mLWKIDF0xare5irK/VjCPSN7RJIE60S4ot78
         l7dLM1L1SB6G4XKVfiF62m++pm4IfRb5Yb7Y9uDj5teNNcaPyyzm/0m1aVUDzhf8uW+t
         WTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198055; x=1713802855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHqqRenBwHH3dYNpNtPvujl3JPCakWggIzfiR8Bh9XQ=;
        b=GRVRurL8DuJWNlYUSR6oRBd9wqwTyPLUQkxtAT0GU/5ti7pusuCA+SRUbOrBd6MF4i
         qNUa+BeYaF5ouWdS5upnsDXSF6Je1YdKqMlZljaOvSgslFvNlhWEQN+pMUgCwobe7+Lv
         YFKwPdeONHkfqB7TiMsPWS+A7/dG8TO3YD5Tyq823AOg/H+OCYxBXDNIm3Sth5/fzhLK
         RqxlzP9Je9kdQ6HqYqVw7leFlT2kWOfC7avTrbmuMEWwnqo0cYS5EjYLoLzYLmbNdp6o
         UbtpK6afI6wGSGGdAAkwW0WUlVMsVDGBmJ3CPCrRe/IjaX7i4bNbaBAGYr4rRKT9rFpk
         4mcw==
X-Forwarded-Encrypted: i=1; AJvYcCXK87LMktPUdA9I10uc4QssPM1Plo+PxbvUs+800p+K6C7sOk2oVFsCzC97CwMo+fCnz68yB9MaTKVInnlDbB1cf9nXucg6bU+lkg==
X-Gm-Message-State: AOJu0YywiUyue3nWCd6s2j7NcQ8cIwrXkTZJ8+c3R66S71PWcCmldtXY
	CLGcqymd9kEvwCZHVFluESLfjkPf12W193sIPRZBw0T34EafJA2DN8uwKBiwp8nEgKwBIg==
X-Google-Smtp-Source: AGHT+IHNIhta4/6qEKdeuxUljM7MuC6zhk7FC1Wn5VGF0YXerg2GpmyYatVfwOIpnK57xSofd22De4no
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:150d:b0:dc6:cafd:dce5 with SMTP id
 q13-20020a056902150d00b00dc6cafddce5mr3570371ybu.12.1713198055314; Mon, 15
 Apr 2024 09:20:55 -0700 (PDT)
Date: Mon, 15 Apr 2024 18:20:45 +0200
In-Reply-To: <20240415162041.2491523-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415162041.2491523-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2668; i=ardb@kernel.org;
 h=from:subject; bh=r5HeLLaiZQAh9QWD51AJtOhyniRpUOwKFejoofTylQw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU02+M7jo28Fo36cTxHbcXHZE5f2CWJ3C1mm+lxU4Ww4e
 rA53Ni2o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExEJZzhr8CHbGvGxUIxhboC
 bnceXbJce7Hx7oOShfraG7sD76299I2RoaeEq++zoZeohsI2xcNPzws8dNRcm/ZAlknm1+JvGV3 ejAA=
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415162041.2491523-8-ardb+git@google.com>
Subject: [PATCH v4 3/3] btf: Avoid weak external references
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

If the BTF code is enabled in the build configuration, the start/stop
BTF markers are guaranteed to exist. Only when CONFIG_DEBUG_INFO_BTF=n,
the references in btf_parse_vmlinux() will remain unsatisfied, relying
on the weak linkage of the external references to avoid breaking the
build.

Avoid GOT based relocations to these markers in the final executable by
dropping the weak attribute and instead, make btf_parse_vmlinux() return
ERR_PTR(-ENOENT) directly if CONFIG_DEBUG_INFO_BTF is not enabled to
begin with.  The compiler will drop any subsequent references to
__start_BTF and __stop_BTF in that case, allowing the link to succeed.

Note that Clang will notice that taking the address of __start_BTF can
no longer yield NULL, so testing for that condition becomes unnecessary.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 kernel/bpf/btf.c       | 7 +++++--
 kernel/bpf/sysfs_btf.c | 6 +++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 90c4a32d89ff..6d46cee47ae3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5642,8 +5642,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	return ERR_PTR(err);
 }
 
-extern char __weak __start_BTF[];
-extern char __weak __stop_BTF[];
+extern char __start_BTF[];
+extern char __stop_BTF[];
 extern struct btf *btf_vmlinux;
 
 #define BPF_MAP_TYPE(_id, _ops)
@@ -5971,6 +5971,9 @@ struct btf *btf_parse_vmlinux(void)
 	struct btf *btf = NULL;
 	int err;
 
+	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
+		return ERR_PTR(-ENOENT);
+
 	env = kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
 	if (!env)
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index ef6911aee3bb..fedb54c94cdb 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -9,8 +9,8 @@
 #include <linux/sysfs.h>
 
 /* See scripts/link-vmlinux.sh, gen_btf() func for details */
-extern char __weak __start_BTF[];
-extern char __weak __stop_BTF[];
+extern char __start_BTF[];
+extern char __stop_BTF[];
 
 static ssize_t
 btf_vmlinux_read(struct file *file, struct kobject *kobj,
@@ -32,7 +32,7 @@ static int __init btf_vmlinux_init(void)
 {
 	bin_attr_btf_vmlinux.size = __stop_BTF - __start_BTF;
 
-	if (!__start_BTF || bin_attr_btf_vmlinux.size == 0)
+	if (bin_attr_btf_vmlinux.size == 0)
 		return 0;
 
 	btf_kobj = kobject_create_and_add("btf", kernel_kobj);
-- 
2.44.0.683.g7961c838ac-goog


