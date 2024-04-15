Return-Path: <linux-arch+bounces-3701-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D64238A5790
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 18:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145271C21CA9
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5CB8174C;
	Mon, 15 Apr 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ksiS3hF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B677FBA3
	for <linux-arch@vger.kernel.org>; Mon, 15 Apr 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198052; cv=none; b=UcHTVuMpXMaaWrEgHnllZm0CVKl0bj7Ftrv84b/0f9ymnyNr/0PII8vbMXviSCQiwIvuW/OUS4O4ubzNZBUW70QPxeq2wmfsdY0zCJKDG2F0etmVFF3JfS9+dvf/iG770F0atHVYKo6p7iz5OK4sXyl9FFXQ2fly4UdSNCq6f0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198052; c=relaxed/simple;
	bh=1zoC3bi6KaCU5EtJaBkjNbuqfFNt91Wb7VubIJIcaL4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GzESadYxYbjTWRW0092/48FQjFrSiSO+OBNkLxAr+z37uwReZxUTzW+fvfgaVBq+QQrUEycihaeNlTctEw5PQva6M2JBaqLlo4s8dOHMNBrcbC4dvEskYSnNvfHus1BMfh3G2YXzH6wyon0VUNXfe0HHHkAXlZePRcsEZB8Hap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ksiS3hF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2682870so5490288276.0
        for <linux-arch@vger.kernel.org>; Mon, 15 Apr 2024 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713198048; x=1713802848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K1arzZzM3WsRaUONp1y4sZyDHfuKJUnHI7TXwDMLR4c=;
        b=3ksiS3hFsRJ9BBIMV4+o6RVlKQIJ6NUbu0WMBxwffPlJkbzZ+Ks7hUwfFbtO+Q5bHf
         5cwea4zJ/IMv4UMgyUkj9Px5fSZlgyJy9V9MbssZTPrDdvwg2SF9gqBjdhaNAPoHGKfU
         0gKkNEyF11UiZL+yKd2sxxHmcvr2JnJZLo7jEzsIW8A6WcO6blY/B5mioHMSfzCrrkyZ
         kQ8UDmwV7dRDJjxEH29PF1LosROWjmAZj2mXmRr/sh6obNifsW0+VMX5s8pTxC/FDKV6
         v7ExDIJ9jZxQjSYYXmGDVdZJPACV4oXQmJAiws/goSvhPBWMCWwSUT5Ng4zXOZV7izAp
         a5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198048; x=1713802848;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1arzZzM3WsRaUONp1y4sZyDHfuKJUnHI7TXwDMLR4c=;
        b=eVFAbsJLkX3ML7+voDp710dY7Kmto42ntsHli4BzgM+HVwDb884gWtqWuZh+vhmkc9
         ZfGi2d070mgVeK+6kVWoQNo4eKvofKdCD3/7YXSe8VFmuAXT7jvnus7rKGnES2EuYQeB
         wrpD6vgSsZ0dYCvqCYO/i8No0cicijG/j5bNIP4sSgFBPVdJlArQDfrgT78VmVc2tPI0
         POw1D3AwTUTvZcqLgWDB749iUI5EcBvZ4tNZaHeGxvsuoO5BNec12kYyW8rT8rYRt7xy
         1QZbDlL8kNUm/6VWIgSAfr87m5ff7D/3R4V0uMVtLec5RYa+/yxRlItvraVS8+RYBcx/
         g5GA==
X-Forwarded-Encrypted: i=1; AJvYcCVUNJewygcCUaB8XKRVJbnfdueq8pKr7i8yFgtQjCOCmRR9FrXqop3RndxIGcm347M7UsxOP1DSJyx4xy6OflFv1dj47FfkOovMiQ==
X-Gm-Message-State: AOJu0Yw/pNsB3a3y31V0CzDxVujp78H/jUGtL5uVTQ6ZTHmQExMN+Gig
	hzwpdjIWs55vJz/eH22ZxBePadcPmOQA0OR0vEqBJSCgytLqfYrbtGK93u4lKA+MjZb2uw==
X-Google-Smtp-Source: AGHT+IG5K9apYfcWPZPtdIptSJfI/lmV9B4/LFJ2tYhX7R87dpX23NOUKwOmR1jcniTv1WDXWCZcH4k5
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1009:b0:de0:ecc6:139c with SMTP id
 w9-20020a056902100900b00de0ecc6139cmr3152952ybt.11.1713198048326; Mon, 15 Apr
 2024 09:20:48 -0700 (PDT)
Date: Mon, 15 Apr 2024 18:20:42 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2166; i=ardb@kernel.org;
 h=from:subject; bh=X8zyn046NSpabQR5ICGmu6GxwA3wTXrOLB9VrAXNWLE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU02+NbiXGuF+9VW9377aD66Imx21S5X4aDGWr1F1zf+X
 nueJzu2o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwk+y8jw0ZLI8Yrp1z3srH+
 fZ+zdbHNnKg1Pv5TTqacPywsEPvedQ4jQ0tsQ8U+jnq2b0dLn2hb9btWLPseXlXAobb41OzUdtP vLAA=
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415162041.2491523-5-ardb+git@google.com>
Subject: [PATCH v4 0/3] kbuild: Avoid weak external linkage where possible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Weak external linkage is intended for cases where a symbol reference
can remain unsatisfied in the final link. Taking the address of such a
symbol should yield NULL if the reference was not satisfied.

Given that ordinary RIP or PC relative references cannot produce NULL,
some kind of indirection is always needed in such cases, and in position
independent code, this results in a GOT entry. In ordinary code, it is
arch specific but amounts to the same thing.

While unavoidable in some cases, weak references are currently also used
to declare symbols that are always defined in the final link, but not in
the first linker pass. This means we end up with worse codegen for no
good reason. So let's clean this up, by providing preliminary
definitions that are only used as a fallback.

Changes since v3:
- drop unnecessary preliminary definitions for BTF start/stop
- add Jiri's ack

Changes since v2:
- fix build issue in patch #3 reported by Jiri
- add Arnd's acks

Changes since v1:
- update second occurrence of BTF start/end markers
- drop NULL check of __start_BTF[] which is no longer meaningful
- avoid the preliminary BTF symbols if CONFIG_DEBUG_INFO_BTF is not set
- add Andrii's ack to patch #3
- patches #1 and #2 unchanged

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>

Ard Biesheuvel (3):
  kallsyms: Avoid weak references for kallsyms symbols
  vmlinux: Avoid weak reference to notes section
  btf: Avoid weak external references

 include/asm-generic/vmlinux.lds.h | 19 +++++++++++++
 kernel/bpf/btf.c                  |  7 +++--
 kernel/bpf/sysfs_btf.c            |  6 ++--
 kernel/kallsyms.c                 |  6 ----
 kernel/kallsyms_internal.h        | 30 ++++++++------------
 kernel/ksysfs.c                   |  4 +--
 lib/buildid.c                     |  4 +--
 7 files changed, 43 insertions(+), 33 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog


