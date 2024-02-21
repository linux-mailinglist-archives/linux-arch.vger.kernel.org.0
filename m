Return-Path: <linux-arch+bounces-2610-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ABF85E786
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 20:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11791F252C2
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 19:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B71486AFB;
	Wed, 21 Feb 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lsy4Y1o/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12DD8665D
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544463; cv=none; b=czLGvfyKxhqCYEL3mexmeL+ruZpzCY6abTbEbgfrvMeKKbWCVTXPsbxR4jsPvJJXVqBvcE+fakV8GZhZ1o+/5BWrFbaH8vW+X7dfre9x+G7N0DMU1GzqMJd2Axpm777y32XD2yu6od3MIawhGAaM7QGcKfhOdczFf3Lb+0v1jy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544463; c=relaxed/simple;
	bh=XvI76MSJf6n8ycfULIR+dpUzLDxxCd04CalcxvixqtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hmjD7Q4UJz4nL8eSH7YmTRbHo86IQ/Eh4Yw47JJNCnQO8JHPySLZrd0viD34dE0WBGdIb0gxIHp1UBVY/9oigzGcOqjMtkgoUTjefYshHCt9I2ZWLCfrck0kAyGmOEVUOx2D7ASadYZ/w+11QRfbIHoOAUTC1qF2OhbMJEYQ5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lsy4Y1o/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so9721558276.2
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544461; x=1709149261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOix7cIZ9OpjtRmnOCb5oo8qhMGRBISTNpiHk2ice5Y=;
        b=Lsy4Y1o/cScEtlw+tphqx2teWGVdZTJvgOXQPbI1Y58lqPV7JelW3Z3i1qznu1dmJR
         CKcj0msql37fyX2oCVKqTQtBglvo+ePh761e2E5bkVDds+vWiyCiQ8nQKNx/0QkfpcfW
         bsO+pvW+RWBLd7z7TSagQKq+rkVY9GbiDqSXqtF1MAW9wlglo4hgc9fQ0MBdRoUDFQpC
         BgR18foC4w2y29Prp09CW6J612QcKNwE9rZDNDvsPvHgL+IQq4ktKrpW3Fv2I3ydiAHc
         kTjzs7kR1O63Ua7R5yUaJAy05OJdRDe0Fl2ylvvudFbfclVFq4fShUsZThe4OhzJvlf8
         YCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544461; x=1709149261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOix7cIZ9OpjtRmnOCb5oo8qhMGRBISTNpiHk2ice5Y=;
        b=diTraFmqArcn5geTrNUA6/sm0Cvkt2J+zjgeNh/z66junFojJFmV80E9lcib+9ezbI
         /zW2YcqRJBbif7yFrPnV6/xReK02DlyDko3MmwPy67OqAC0qEpm4t1cBLLyh8TEhHIAX
         /VHj1+PiRL4SYLo5N9F3JaiLx7/vAzkyNjof++VCQyn9XBQpvCu4JqbLdx/P/ZdD9zUp
         /gOCLz7qULR593o+F1yHY9M6VN2x3VhwGRySE4I08oUEFTLiLWy1Ty24AZpP7nVuMkHJ
         EZz0Miw3+M1CQLURNrlPLkg16Ayf4ffF5IP46qZw8UBvS8+esOlIACPiH+tSDZDYqFMB
         ghmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3jMvUJJpQhREYt7jgAJI/mj07QvCPtSXVF5Ux+CDN+kBFY3eL3Q3WuE6t2SAk0ds628uMiq5Cgp1zElM6cadO2hgddgexbVSE2A==
X-Gm-Message-State: AOJu0YyMcl26h8/ydfvybW+SOYWjY4OYF92fle9sJZD9upKOuuZCwr1y
	hUhTVe3NvgmbmRrYCGTt94TtdhvoVVkXUbqqtYnkheFr0Q1nDLY9KEL0bPuTEqRrZGh7P5pUTQG
	RwQ==
X-Google-Smtp-Source: AGHT+IFQED8r11XAmHCvTPIM6osrIYpquXv216eXmkF7EFZy4gkeT8fImMy3GTq6A3JUXD3VP8Bk7+J6aLM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:120b:b0:dbe:d0a9:2be8 with SMTP id
 s11-20020a056902120b00b00dbed0a92be8mr7992ybu.0.1708544460699; Wed, 21 Feb
 2024 11:41:00 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:15 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-3-surenb@google.com>
Subject: [PATCH v4 02/36] asm-generic/io.h: Kill vmalloc.h dependency
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

From: Kent Overstreet <kent.overstreet@linux.dev>

Needed to avoid a new circular dependency with the memory allocation
profiling series.

Naturally, a whole bunch of files needed to include vmalloc.h that were
previously getting it implicitly.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/asm-generic/io.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index bac63e874c7b..c27313414a82 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -991,7 +991,6 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
 
 #ifdef __KERNEL__
 
-#include <linux/vmalloc.h>
 #define __io_virt(x) ((void __force *)(x))
 
 /*
-- 
2.44.0.rc0.258.g7320e95886-goog


