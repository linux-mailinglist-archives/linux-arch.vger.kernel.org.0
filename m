Return-Path: <linux-arch+bounces-6328-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78655956E69
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033A51F22A83
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D702C2AD2C;
	Mon, 19 Aug 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0FZSam9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA832628C
	for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080517; cv=none; b=sdkAatqlR0FbXO8VUP7BypARuugITB77l6GPm8m1yfbCzVLWdC0+Wn08lBwazMhTXRU3Qumv8YFjzFco0efUZdFsFSnu7Y0ejgdy1DpymYFCLUVgx5F0zLetVQZ/z87jHAljAfu5+a8cLIWmn52L7kC9LAVOxI5XJ040W/a6Pus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080517; c=relaxed/simple;
	bh=E50KkIeJzI2UI/KUMPCFchsUF1az6c7lpuIqxhkdzhs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P+Ad0K72nWDLWqfvn/sDUF49fKdw+Fw3h8YkpXyjQAHcogmW5Diyg8obawKkPcWvhlipo4p5BWZTMAGrK++Vn83crsWKhVkNJRcRqiLG1Tb582APSkuZG1Knsl+VMYjSSlN/9B/se4r3CN5/1uaX74kp0SfUD8yI+LVuJY0Rc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w0FZSam9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ad660add0fso56109537b3.0
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2024 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724080515; x=1724685315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A78JLOnxz0DbZH9XkqfQj68kUgx61DwizYim3aGCBzo=;
        b=w0FZSam90qoqcmPtroBX1SfaxkIY3OAsY76yGUY8YBorHDlykooSOtSI7QQPkFd1Qs
         RYqYsb/YM9dHdZC0EFvgJTgVWEek+zR/1tkKLXnSsW5QiuOOLTmhki+gKZ2x7/O2YCT0
         PMgeuDbvhb9LM6H7Tgfqq5ufU9OzYLyUTTh0D+K60RncIDgkZIPBETUJ1pDVSZsT8gRx
         stRTX3O2moscXjYzOHjgTwKjvDjB4UiI7KZU+XU6FbVyASe1VjruaRQgIKC92IHABrdn
         qgOUeoTnFMo/TTN6ustLebs9tk1spGwDt8dylK/AytdvtSuoFyBjNwMwUv6xZ3LBaajO
         yA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080515; x=1724685315;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A78JLOnxz0DbZH9XkqfQj68kUgx61DwizYim3aGCBzo=;
        b=bEENzcEhqVwee4ExXBb31mnZUZryF84AVgPgVeliWySjo8B0E1sFSKtbi8bTBTN8/9
         fNQG1gOOCQnUl7SfYzKY+7omGScI3tCzPR3xERMn46sQ5hAp3rHdLitlkcAjunNVuclA
         hqon/ZMm0VdZkWAIxDFH/Lsl14XqbGceomT1sq5I7uLt356RwlunWnJ55JsZ1sPlbCus
         BmgPCVN2NqdGS56eXoSDvf8zUZa034s9eeOyWYiqB0nBo6EZe1qE8tf7cRBM2CNwlf1R
         XzVsm0SrND2uYLrzixck68cvwL5voh6r4IPSZKSBAE4pvDNWY8Fb8iasovClmf2Ifn78
         qDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbENNLMqpDw/wIxp1b14BKk9Fhz+wUkMQd24YgYihbvw0B1GqzJHocmNHeFdKw0vrA/v68JCIN3BSF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5tjb1BBuQFkBOw8+YVfsrjRgTxlQ4JaouhPO+Qvh6nGBnX4WH
	wweYq32f/b1dgYwZElkIQg69P5wKMEUnAvNILHS2PB7GtigKa0xbzSCJSHJByUyZCd7n63/lEEV
	SmQ==
X-Google-Smtp-Source: AGHT+IGn4wFVR9Ch9/vmxxSH0rhO9DsLWlVWUxLzfz71jRdOXd7qjKZt0JLceuItsIaKthQC3GCSSl3ZiT0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5aea:cf26:50f4:76db])
 (user=surenb job=sendgmr) by 2002:a05:690c:2b06:b0:6b2:e9cd:ede9 with SMTP id
 00721157ae682-6b2e9cdef05mr783597b3.3.1724080514873; Mon, 19 Aug 2024
 08:15:14 -0700 (PDT)
Date: Mon, 19 Aug 2024 08:15:06 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240819151512.2363698-1-surenb@google.com>
Subject: [PATCH 0/5] page allocation tag compression
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

This patchset implements several improvements:
1. Gracefully handles module unloading while there are used allocations
allocated from that module;
2. Provides an option to reduce memory overhead from storing page
allocation references by indexing allocation tags;
3. Provides an option to store page allocation tag references in the
page flags, removing dependency on page extensions and eliminating the
memory overhead from storing page allocation references (~0.2% of total
system memory).
4. Improves page allocation performance when CONFIG_MEM_ALLOC_PROFILING
is enabled by eliminating page extension lookup. Page allocation
performance overhead is reduced from 14% to 5.5%.

Patch #1 copies module tags into virtually contiguous memory which
serves two purposes:
- Lets us deal with the situation when module is unloaded while there
are still live allocations from that module. Since we are using a copy
version of the tags we can safely unload the module. Space and gaps in
this contiguous memory are managed using a maple tree.
- Enables simple indexing of the tags in the later patches.

Preallocated virtually contiguous memory size can be configured using
max_module_alloc_tags kernel parameter.

Patch #2 is a code cleanup to simplify later changes.

Patch #3 abstracts page allocation tag reference to simplify later
changes.

Patch #4 lets us control page allocation tag reference sizes and
introduces tag indexing.

Patch #5 adds a config to store page allocation tag references inside
page flags if they fit.

Patchset applies to mm-unstable.

Suren Baghdasaryan (5):
  alloc_tag: load module tags into separate continuous memory
  alloc_tag: eliminate alloc_tag_ref_set
  alloc_tag: introduce pgalloc_tag_ref to abstract page tag references
  alloc_tag: make page allocation tag reference size configurable
  alloc_tag: config to store page allocation tag refs in page flags

 .../admin-guide/kernel-parameters.txt         |   4 +
 include/asm-generic/codetag.lds.h             |  19 ++
 include/linux/alloc_tag.h                     |  46 ++-
 include/linux/codetag.h                       |  38 ++-
 include/linux/mmzone.h                        |   3 +
 include/linux/page-flags-layout.h             |  10 +-
 include/linux/pgalloc_tag.h                   | 257 ++++++++++++---
 kernel/module/main.c                          |  67 ++--
 lib/Kconfig.debug                             |  36 ++-
 lib/alloc_tag.c                               | 300 ++++++++++++++++--
 lib/codetag.c                                 | 105 +++++-
 mm/mm_init.c                                  |   1 +
 mm/page_ext.c                                 |   2 +-
 scripts/module.lds.S                          |   5 +-
 14 files changed, 759 insertions(+), 134 deletions(-)


base-commit: 651c8c1d735983040bec4f71d0e2e690f3c0fc2d
-- 
2.46.0.184.g6999bdac58-goog


