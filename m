Return-Path: <linux-arch+bounces-3330-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A8891622
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 10:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C8F287A52
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533AC535AE;
	Fri, 29 Mar 2024 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+I6ES4A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB951004
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704859; cv=none; b=MaY+dW59nXDsOsjbAmsBOc1bObFtkf+8Q4wW/nW2uvQm8PtGxSCOLN4QWL0lNwI7TZ3+HDSx/PQBVsJncLmwYLKuJSp/hLA3im7bEiJxizTaSEHF1fn+4IWgPoCfsN1K16ZIOq/C5GeMQoi68b287tnZe077KUIDrtZRUC5pm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704859; c=relaxed/simple;
	bh=KUC09wtYmay5oVx7+9C+OUpDt1KQS0U9lKvW1u+lUzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mwjmX8HhaIMs7y8rhtnnJR2f/2TtGcNCBRFwS59Q708/cYUc03NBKzh2E0VqE3jK97ZDFrkU9CCit6IyOyexZ1U7N687XOHTldM/Xs4c9N3huYMgNoelxZ5OPdlKXd8IW/wWfqmYfHwyz362lA8TMAs2AaFSG5fT9qMLLR1RWXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+I6ES4A; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd041665bso34122227b3.0
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711704856; x=1712309656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dw09Gs88ogil/diQ6Vr0EqHQANsVVhIyP+7ZdKbyIx8=;
        b=s+I6ES4AxBivvRDaHcnmARZ5DuByeyfrx7ret5p6QdLqpF4G5hBbJD7OM6QquLzzGN
         nQZJnG704OtoxB/YvIv/j4LWqYHRjl3vE+bNJhD+FcyIOzq6KfNwYz8ofy3ht11skszm
         vJHQFbiOsYLQygbAGN5Bf0BOuzsWekUxq0idM0WfK4LE0WMbrIW7XqNc+ug7nqk8VhXo
         7pxLt7sToGvZxirUO2fRPZPbUMfQsxFJPYNdMS78ORalL/uoHMZ1rdWWzh55eNKtNRws
         LY6mSdec3zxiLVCulWyL1FYVpMH8N+Ynj0Gqi5onHgcAiXddad9rjBZKVg/f09rA4GCK
         YN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704856; x=1712309656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dw09Gs88ogil/diQ6Vr0EqHQANsVVhIyP+7ZdKbyIx8=;
        b=pE9gR+51ERgizNdG9YRw/hB64ioaWUfm9sD1asz0o2phVwhz/q0zOQ9D3edIJ6Po3L
         /uG13g54TRfH+Kx+73AaZSlIxqeqc2WcfDiVm5J4ikY1UtiMjEg0iG6W5AxtBKo3by2o
         Xf/sm7xydWUWiisGUuNjEMciamx4z96j+Ys2I1Gkm4G1ejEZOMm5oxPGC/ZI7DUZl5Yv
         0pMwRQF9/hA0QZHy3FATPh5pLN37JaKlvE0fgf8mw3RrwiXhK0TpQNaR3oIrDr0Z1rqo
         rf0V+ybVGmPsoci/OhbGuG809mz4pkonsKB1FiQYgkOCsEYzUGB4Ti5Bm+gX7zjThJKI
         nKIg==
X-Forwarded-Encrypted: i=1; AJvYcCVv1+yzyPqf5hcwKexQ1v4XB/cL/L9lIFvDKQd0942Qsb5BejF9rSLEuwI+T2ekyCW7EYpVQPqbU/xuDBS93S98VQy1kbi5dGRi4w==
X-Gm-Message-State: AOJu0YxO5sviyrpKPb36zMMeiGAzNlXFob84W/l3Gs4mTHfyjk/ILQ+Z
	kcWtE8IuxzqQrNLJsdEW4391hUnF/xj0RV2TM/sH6IE3bFv3FNDReGBmq2Yp7BmHyobtNQ==
X-Google-Smtp-Source: AGHT+IHww5cAwsi1pr9pBu+czX3UmFai9nj7XcxpaVhRpi1LgYQNcAUBxrSuXEicaf9NQtedota600ow
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:dd03:0:b0:611:7573:72b9 with SMTP id
 g3-20020a0ddd03000000b00611757372b9mr538832ywe.5.1711704856741; Fri, 29 Mar
 2024 02:34:16 -0700 (PDT)
Date: Fri, 29 Mar 2024 10:34:00 +0100
In-Reply-To: <20240329093356.276289-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329093356.276289-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581; i=ardb@kernel.org;
 h=from:subject; bh=q5UGicb35M6dvlAOCgO0axQESJYA1rUn+GPk9ZrI1w0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY2tm2OlVN6iHxUr9jYWMgmymJk94z0V9u5k6qIdE5rSD
 26LOdPVUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbSb8fwPzp8VsaB3SU2Br47
 13TyqzMf+HazQXOCcIe1VeufXy6Jrxn+Cj68+VHg2BXetLa8nEmMt64kzV5teF7ibP27fVkbfDK XsQEA
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329093356.276289-8-ardb+git@google.com>
Subject: [PATCH 3/3] btf: Avoid weak external references
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

If the BTF code is enabled in the build configuration, the start/stop
BTF markers are guaranteed to exist in the final link but not during the
first linker pass.

Avoid GOT based relocations to these markers in the final executable by
providing preliminary definitions that will be used by the first linker
pass, and superseded by the actual definitions in the subsequent ones.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 2 ++
 kernel/bpf/btf.c                  | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e8449be62058..141bddb511ee 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -456,6 +456,8 @@
  * independent code.
  */
 #define PRELIMINARY_SYMBOL_DEFINITIONS					\
+	PROVIDE(__start_BTF = .);					\
+	PROVIDE(__stop_BTF = .);					\
 	PROVIDE(kallsyms_addresses = .);				\
 	PROVIDE(kallsyms_offsets = .);					\
 	PROVIDE(kallsyms_names = .);					\
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 90c4a32d89ff..46a56bf067a8 100644
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
-- 
2.44.0.478.gd926399ef9-goog


