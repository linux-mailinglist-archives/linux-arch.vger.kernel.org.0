Return-Path: <linux-arch+bounces-14054-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A992FBD4AFB
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 18:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55E76350268
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A876331D74E;
	Mon, 13 Oct 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSTb07DZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3878C31D374
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370000; cv=none; b=qktFaw3NugOfAnwLJ3NybX80JoD+2feU/qKm9sCy05ohMDKmUEe98tIcyRDaV+FSAG9ypWiyNeXt4AjVUdHwx/F9/wAEYfAvePoXaUyv0CMIzIgH9/mYxm2jrB9uqnWQFZyzAh1Tyd27xZRSiUs+is0Sn34NxOt9dCWVBD5zBcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370000; c=relaxed/simple;
	bh=qWYTuEu4IG9GCT7DjS/hH5Ft/AQYcQO5Boog+C14wCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W9VbNlJgKMTKOK9lJbTmnw73baz1/+At/XOMHjxrBRXGnbSjo2n/jukM0UZd5WnXoqyFA/m35MQ6hs6JRlICffPyOkuqXwsTOj6urDm4E/QCucJts13wbvggLPAZjS75ndmmWbxVpO6LZjxcMXnQVtsmXdNdT5qKZVtYXT9NkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wSTb07DZ; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so5372703f8f.3
        for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760369996; x=1760974796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EWqoEOZl6L4UgifcuVH8Vvw1RztpD/4r7yVFa1CMC6A=;
        b=wSTb07DZc1jMbUWpnaVe7yVdz6j3xUJ1419LXaEz6dFZd5WxEEo12pnpzqy8Gcu2VE
         XZcCAkEBdNgt7PN5jszViZ9yhurTzR/wZkbmmSVUUMhIHXyMP7kNp4EvuCSkwUzxSnJI
         +woNVO2taJvhNZQWQmZyGDGqQzy/5Pvcb2e96ieSn38Ch879Un/jMx4LaFvA7Vs9Bw8E
         yM4XJxOUZCMGfMk6X/BZo1aurOlcCKQdP6h/HSMzHi+WU943VQUFMX5WLEoO9/T00A6g
         82s7KTgl7q4Fttk5O7713NbiGLvPLNOIxGQt8qMpZtPF2bx/H0m8AiJ3fxjRVjomy/8D
         r/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369996; x=1760974796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWqoEOZl6L4UgifcuVH8Vvw1RztpD/4r7yVFa1CMC6A=;
        b=wHmOdl8CK+LwjTJCtH16rs1m+dnkRlbHkloT7KuXxhiEOMN0qBt8LCRUCnVhTWCLfh
         dpkd65fTo7i+CPrwHyMUOn3Dm6YSLMunTV6mEMgk6Y1go4NVXDbGPBRrRReFegVOauKB
         aPTuZ3vn8JxxLkyH8mwBHGSXswegCVR+hzrbPxfQqCFvbYoDoZWc67ijd7EYpfjAAsgz
         DkqKlHja2Ko0YOg2u8mxzLgp7+JiSMds4D3p4sdBGF9akvHwhUWwA/z7VJntiR8B5ktF
         daNMR7FhMLCwC6S/PobzJDbVeSThDMM9n7sKCBvfqNji6YOoFgzv+KdNZK0j+TKYVnIM
         xxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSJdmNRIOrqorUNgL943eqMeBBHBPIoiE+NggdcvpMvRqp5fvQ7eMH9IiJGRfB/7QTcfxrJ/B9RChd@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3ERI+Wx0Z1XJ2B8Lm80MTA5vbRAyFOsbHW4PteYqnJWAb1fF
	disrvRSIVEZJQ9CPML59WAYcHJYryYZxpNf6rCqv21T99s2afeotcNPQxlms24N3JzSkqRbYQ8J
	TmJTKnyvf4HN50x+k6w==
X-Google-Smtp-Source: AGHT+IHLek4r1lwro3GQIO4ppkzexXFiEHQSVL/Za4DDoRCAzgIf53fcpusHRbOINss/Tpngpku8rgJ4Go3IiS4=
X-Received: from wrpk16.prod.google.com ([2002:adf:f5d0:0:b0:3fc:7d28:6438])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4901:b0:426:d51c:4d71 with SMTP id ffacd0b85a97d-426d51c4e7emr6015254f8f.8.1760369996504;
 Mon, 13 Oct 2025 08:39:56 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:39:18 +0000
In-Reply-To: <20251013153918.2206045-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013153918.2206045-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013153918.2206045-11-sidnayyar@google.com>
Subject: [PATCH v2 10/10] module loader: enforce symbol import protection
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

The module loader will reject unsigned modules from loading if such a
module attempts to import a symbol which has the import protection bit
set in the kflagstab entry for the symbol.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/internal.h |  1 +
 kernel/module/main.c     | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 061161cc79d9..98faaf8900aa 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -108,6 +108,7 @@ struct find_symbol_arg {
 	const u32 *crc;
 	const struct kernel_symbol *sym;
 	enum mod_license license;
+	bool is_protected;
 };
 
 /* modules using other modules */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index f5f9872dc070..c27df62a68f5 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -380,6 +380,7 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
 	fsa->crc = symversion(syms->crcs, sym - syms->start);
 	fsa->sym = sym;
 	fsa->license = (sym_flags & KSYM_FLAG_GPL_ONLY) ? GPL_ONLY : NOT_GPL_ONLY;
+	fsa->is_protected = sym_flags & KSYM_FLAG_PROTECTED;
 
 	return true;
 }
@@ -1267,6 +1268,13 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 		goto getname;
 	}
 
+	if (fsa.is_protected && !mod->sig_ok) {
+		pr_warn("%s: Cannot use protected symbol %s\n",
+			mod->name, name);
+		fsa.sym = ERR_PTR(-EACCES);
+		goto getname;
+	}
+
 	err = ref_module(mod, fsa.owner);
 	if (err) {
 		fsa.sym = ERR_PTR(err);
@@ -1550,7 +1558,7 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 				break;
 
 			ret = PTR_ERR(ksym) ?: -ENOENT;
-			pr_warn("%s: Unknown symbol %s (err %d)\n",
+			pr_warn("%s: Unresolved symbol %s (err %d)\n",
 				mod->name, name, ret);
 			break;
 
-- 
2.51.0.740.g6adb054d12-goog


