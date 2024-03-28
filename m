Return-Path: <linux-arch+bounces-2853-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEA1873EDD
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 19:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405FC1C20C64
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6FF145649;
	Wed,  6 Mar 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSgZl286"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A0A14532F
	for <linux-arch@vger.kernel.org>; Wed,  6 Mar 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749513; cv=none; b=FB3+v//PvikyJX8D1vz+mw26WBa8XTmA8M2tOPTF/tEHpXzAt/6XmTqWyxK2z0qFX3tBLUJI/+ubxepI3RCKoCX9HkFk99xxY7jUZwt/YBcSrXtUQcn6ESaz12VRyCJcN0d+R1I49jOSmqLwogEG1NOlHDEG1zxLYTRXkpTYwfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749513; c=relaxed/simple;
	bh=w76fRUGZUp2sEJ4t0V9JFFjEr0Jh1N1N4LA1RyBtYmE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XCpFq5lhECnx5xG/QW6kPv8QO8hxWiGsJLNMQf2qmISfubXDOdk8arSXo7vaNG8/cv7JMo2ShErXab1TCQ8u9nYcIbISYX8UNFazcYjp2oRrnaRNoFSHoruXTkCcKbykfY/NQ674LdrOufOS5ClWhdij5qzQu9uasitYigNdSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSgZl286; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609ea26233dso694987b3.0
        for <linux-arch@vger.kernel.org>; Wed, 06 Mar 2024 10:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749508; x=1710354308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPAQlIYBmu/nqjnWAR+Y3waoaH5kDJ/L5+WSbugHpuw=;
        b=bSgZl286jTnsqnlKTgB4OSkFLrCqwd+ab/e6Ll3b5TdHAkTv831brq97jYhDBqJ0ev
         Ohwgj97508UjJBOdcaoHbEN4c8+iLCUTKpAa3J1f7WhSHvLdcxyvM5i610EeoVF4Augk
         YbiI8CrabV2DjF/aOtWuzUldlNrU4mCkTAmOqtaf5Oy5gdv5ercVk+go0royQOPpExYO
         v/ic4qJ5vZ+txVO1/YIlkLjGBCVbXTOoG0Na25kmfltbaihSa/OsGz8rj/bV14e+dvvu
         6qqB+TAx5pCaX3K71u+q7a9TueFOMcCF9VQyqlKxCc4zJTIqs/T/Xv57Cc9xDp8dj/Jm
         zOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749508; x=1710354308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPAQlIYBmu/nqjnWAR+Y3waoaH5kDJ/L5+WSbugHpuw=;
        b=aN8Z0qpcSEdnYqokaQjbrKu4knPAxz4LofSnHLaDFRaRdHpKMDw2WjDbmJiQMHmGXt
         JSG9HQBE3YqYr4SoX9ytkWYcnuuTkeZ+CKGkMjxzhcMoLEZ5sRrdSgVllyCrohutL91k
         0eubZ58BJx4zaN1yjqqJgUN+4zxC44miXdWrISSOvqoHPRQStVg01ge+PxtuWNGA8e01
         1RDZsW7uomVMQ5jG5DG5R2iy6BkF1gnjb2ikcsHEZeHc2RdL0/p8oR+bllh+BH0HM0ar
         k7F44GI1M1XXB4w/7NL5Iu8KiRyziJU0Wg6EqRIqFz8LbfkupmBdsxkcsEKITdNCAKbV
         s9dg==
X-Forwarded-Encrypted: i=1; AJvYcCWDmvprhMSkT87Ff0IkrYZQtiWKsxBgWaN3ya8shgVHLQXvx5ScEcJxFCgUs/r+apbmn/WJ+FuplP194cADrRY1Azr1/clGwpKnEQ==
X-Gm-Message-State: AOJu0YzZcSmWoToi2i+Kn/fRSphHCLDSnhnOs7EWbN5lU54RPjqD8zL0
	y/DrwUrqPdSNjzYYHgTwoj+WLzZ6R88aYxtRk4dJ3iDnxonanQD09cPCniN+1YaHdmFPkDNSRTp
	TUg==
X-Google-Smtp-Source: AGHT+IEd0tsvecVu5KDk9xxf7Y3b9Rk1jgR8DS8Z815x0mHqtjUMO8iZmPCQu0I1T2SCEsTJC91g87PAOnY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:690c:ec5:b0:609:247a:fd3c with SMTP id
 cs5-20020a05690c0ec500b00609247afd3cmr4821873ywb.2.1709749508522; Wed, 06 Mar
 2024 10:25:08 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:09 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-12-surenb@google.com>
Subject: [PATCH v5 11/37] lib: code tagging module support
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for code tagging from dynamically loaded modules.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/codetag.h | 12 +++++++++
 kernel/module/main.c    |  4 +++
 lib/codetag.c           | 58 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index 7734269cdb63..c44f5b83f24d 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -33,6 +33,10 @@ union codetag_ref {
 struct codetag_type_desc {
 	const char *section;
 	size_t tag_size;
+	void (*module_load)(struct codetag_type *cttype,
+			    struct codetag_module *cmod);
+	void (*module_unload)(struct codetag_type *cttype,
+			      struct codetag_module *cmod);
 };
 
 struct codetag_iterator {
@@ -65,4 +69,12 @@ void codetag_to_text(struct seq_buf *out, struct codetag *ct);
 struct codetag_type *
 codetag_register_type(const struct codetag_type_desc *desc);
 
+#if defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES)
+void codetag_load_module(struct module *mod);
+void codetag_unload_module(struct module *mod);
+#else
+static inline void codetag_load_module(struct module *mod) {}
+static inline void codetag_unload_module(struct module *mod) {}
+#endif
+
 #endif /* _LINUX_CODETAG_H */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index b0b99348e1a8..bf5a4afbe4c5 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -56,6 +56,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
 #include <linux/cfi.h>
+#include <linux/codetag.h>
 #include <linux/debugfs.h>
 #include <uapi/linux/module.h>
 #include "internal.h"
@@ -1242,6 +1243,7 @@ static void free_module(struct module *mod)
 {
 	trace_module_free(mod);
 
+	codetag_unload_module(mod);
 	mod_sysfs_teardown(mod);
 
 	/*
@@ -2983,6 +2985,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/* Get rid of temporary copy. */
 	free_copy(info, flags);
 
+	codetag_load_module(mod);
+
 	/* Done! */
 	trace_module_load(mod);
 
diff --git a/lib/codetag.c b/lib/codetag.c
index 8b5b89ad508d..54d2828eba25 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -124,15 +124,20 @@ static void *get_symbol(struct module *mod, const char *prefix, const char *name
 {
 	DECLARE_SEQ_BUF(sb, KSYM_NAME_LEN);
 	const char *buf;
+	void *ret;
 
 	seq_buf_printf(&sb, "%s%s", prefix, name);
 	if (seq_buf_has_overflowed(&sb))
 		return NULL;
 
 	buf = seq_buf_str(&sb);
-	return mod ?
+	preempt_disable();
+	ret = mod ?
 		(void *)find_kallsyms_symbol_value(mod, buf) :
 		(void *)kallsyms_lookup_name(buf);
+	preempt_enable();
+
+	return ret;
 }
 
 static struct codetag_range get_section_range(struct module *mod,
@@ -173,8 +178,11 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 
 	down_write(&cttype->mod_lock);
 	err = idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
-	if (err >= 0)
+	if (err >= 0) {
 		cttype->count += range_size(cttype, &range);
+		if (cttype->desc.module_load)
+			cttype->desc.module_load(cttype, cmod);
+	}
 	up_write(&cttype->mod_lock);
 
 	if (err < 0) {
@@ -185,6 +193,52 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 	return 0;
 }
 
+void codetag_load_module(struct module *mod)
+{
+	struct codetag_type *cttype;
+
+	if (!mod)
+		return;
+
+	mutex_lock(&codetag_lock);
+	list_for_each_entry(cttype, &codetag_types, link)
+		codetag_module_init(cttype, mod);
+	mutex_unlock(&codetag_lock);
+}
+
+void codetag_unload_module(struct module *mod)
+{
+	struct codetag_type *cttype;
+
+	if (!mod)
+		return;
+
+	mutex_lock(&codetag_lock);
+	list_for_each_entry(cttype, &codetag_types, link) {
+		struct codetag_module *found = NULL;
+		struct codetag_module *cmod;
+		unsigned long mod_id, tmp;
+
+		down_write(&cttype->mod_lock);
+		idr_for_each_entry_ul(&cttype->mod_idr, cmod, tmp, mod_id) {
+			if (cmod->mod && cmod->mod == mod) {
+				found = cmod;
+				break;
+			}
+		}
+		if (found) {
+			if (cttype->desc.module_unload)
+				cttype->desc.module_unload(cttype, cmod);
+
+			cttype->count -= range_size(cttype, &cmod->range);
+			idr_remove(&cttype->mod_idr, mod_id);
+			kfree(cmod);
+		}
+		up_write(&cttype->mod_lock);
+	}
+	mutex_unlock(&codetag_lock);
+}
+
 #else /* CONFIG_MODULES */
 static int codetag_module_init(struct codetag_type *cttype, struct module *mod) { return 0; }
 #endif /* CONFIG_MODULES */
-- 
2.44.0.278.ge034bb2e1d-goog


