Return-Path: <linux-arch+bounces-2217-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F179F85203E
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 22:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FD51F23BB6
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 21:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7432254FB6;
	Mon, 12 Feb 2024 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjFxZ2KC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6191054BFA
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774008; cv=none; b=mH4q62YmThmSrkhlepEcqSN29OEkpyE4JaAoUSJ1rEQbC64YynP0+3nfmNy4N6Atjtq0cfzH3xHUkx2YBdM6mTdGET4yvgblTh9rKtvS17KzUWpvV++Gpi6ppl1vSj0zmwz2yhP3A8yo+0NjIMKG+SUp/b5panAeu42beiHs3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774008; c=relaxed/simple;
	bh=lCACRJohYV6DrxkuBbYJIHOo4uDQQ6vlAkwkYmSc41o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j90jHBwPqc18uZsKdaw5fMfF+XNOljqvwkSz9bm0leU/tSx7gPJMgYkDDzQU/uzuviCZDTct/Vg/yx3vs/eFJmCYZrgvUcCrrHINPJYcVDYoSofAyQPpV68mYyuUSTEKnHyU4m5O6m6sAVjGpwX/eyA6zbFL9AFPeavbdYrPySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjFxZ2KC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6077ca422d2so6812087b3.1
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 13:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774005; x=1708378805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hiMFMYdTb9wRLf05RpnPyNZaK7+4nxliVbJC61s+/Q=;
        b=UjFxZ2KCC355kvjGN70ZH5aMxAZF3oPs8MXoT83AjabFOObuIbwX+Zz5S5HxhVAwwp
         Sp1+5iN63jCp4wapaJswQEOyTSURxSaMcmj60Zpe4ay91RdIzdTj/Hp/c1ypfiNLLegL
         sKQWxJJP+R/ax210KmJgTLE+FjZsQ4dUaHhLaTujAkzqoZWhPIIab8XtycseoO/9sxZy
         Qe0pK8eSDdezy9MMie0MCuAYsSoPR7VspLN6rZMN5Z/9NWLYrt0l3v5kljhIHm8BOydE
         wtiZrPju++W4eynLMlaUQDaQ/2G+mZB2BrYoLxKv5R/fDVOjico0JYgV0WuvcMUE1cKW
         22bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774005; x=1708378805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hiMFMYdTb9wRLf05RpnPyNZaK7+4nxliVbJC61s+/Q=;
        b=uonex6aqhBaRz7YFgckqh2kgBx1wtu8yXdYIEhj/Ajrl05BC8aPuwzUqQ5Z/TBbP/u
         JPoJ+oBlrwFJRGrHh2yue+1+vhWm+HQra0gZVZgaV09L5mcQznsLptgJbqOzZtscqIK7
         v7i4iKm2WyHMD4JqJ7Nx3+Jd1c9gJXAS783Vv2lxlUTz2bqcvMoUJtii+dtLetv1n9T+
         +xvta+zGuOtZkvNID1Od57DgJIYyAUvq1h70pgv3XvYRapYe2tPE5cc3DmeXtuR/w8yn
         Ra5+sTm0hs+yfUQgL1O+KNff+zVyQCWMzUfJO2b8cpsbJSlBPg7kLmKikCEkb3XvewV7
         NaXw==
X-Gm-Message-State: AOJu0Yy88T+uJNpnZw9tTJW2YVXK9kN1o8mQ5LcYm6cqy3fvfLoGxUuU
	9AIaf9mRlBOvf5FjwLeSmcpNY/A/DUNG4LbKSv6fkEOIAZiJA7wRWIhWZZ3z446WQ65NhMz4Z28
	rFQ==
X-Google-Smtp-Source: AGHT+IHMymVhDhc3vqzIXqR7wXKts/Huwxqw8epMlcUK6WIr6/J3gYxRwjZRSc5OiXO09TM/bRBKSIcClBs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a0d:d650:0:b0:604:7b03:4223 with SMTP id
 y77-20020a0dd650000000b006047b034223mr2206277ywd.2.1707774005345; Mon, 12 Feb
 2024 13:40:05 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:01 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-16-surenb@google.com>
Subject: [PATCH v3 15/35] mm: percpu: increase PERCPU_MODULE_RESERVE to
 accommodate allocation tags
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As each allocation tag generates a per-cpu variable, more space is required
to store them. Increase PERCPU_MODULE_RESERVE to provide enough area. A
better long-term solution would be to allocate this memory dynamically.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/percpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 8c677f185901..62b5eb45bd89 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -14,7 +14,11 @@
 
 /* enough to cover all DEFINE_PER_CPUs in modules */
 #ifdef CONFIG_MODULES
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+#define PERCPU_MODULE_RESERVE		(8 << 12)
+#else
 #define PERCPU_MODULE_RESERVE		(8 << 10)
+#endif
 #else
 #define PERCPU_MODULE_RESERVE		0
 #endif
-- 
2.43.0.687.g38aa6559b0-goog


