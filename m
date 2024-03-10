Return-Path: <linux-arch+bounces-2906-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168C88774DF
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 03:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912D9281426
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 02:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACA723C5;
	Sun, 10 Mar 2024 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="thYILaaq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A23C29
	for <linux-arch@vger.kernel.org>; Sun, 10 Mar 2024 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036335; cv=none; b=KelCaw+SLOmkR38N/W5W9vmLsUTRkHlZSClO+rU5GI/VSzWDHGtAPcesWWhD2aRY0WcobSLs63OZQBZvpkT4FodGYuRPvx5XVw4jdTU+Z/oyW3wNGcYSTFE+ViILGW2nsUPjmAme4RfoCdoAAaCnDIh32G1SL67krPca8pIsMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036335; c=relaxed/simple;
	bh=as7KSNoSZZw9qpo+zjIfLwBqz9yg94llh3SNLLkBgkY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=VYkR/CP7movAgtQu2aK8AL3f5AIRnuMPFgFmKA70nsxzxUjuN59L7qBaLJqkdy67V25TEfalkTtBTryuQnIFiRegAVv0LMeFkr7MqKlBvS1SVhFGwYu7rvZjFhA3uP8obt7Iv2JMtnQJUr/DDFowm2f7CtycUZfJjvca0znaCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=thYILaaq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29ba8f333easo2374570a91.0
        for <linux-arch@vger.kernel.org>; Sat, 09 Mar 2024 18:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036331; x=1710641131; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eHEIYqeti5loGAbMg5pT9rTzLm2kPQlk4+PZDUbNnbs=;
        b=thYILaaq0N8hztWo1a6G6Gna5tcUK7A8Pr9P0KTYl8eXkQzu4f5M4gJuRJSyTWIsCG
         I4+QDYfzsbg9YxV+Pjyu8vHBAZ5FXW7QkIz/FGBv1PaWK7/Hwc7GlhTPmH8gruT+4uL/
         t7bcVG7ZWNg4aqJH0Ercooi2T+Np4zQcIj4qfRsp7ZEMxNrXdDwL6uvnTYvKRiqUW+VF
         fwnluvnGaF2iqIWxm85sua6JPALE5wQSdzUuT5inUmSxZpQLR8kKYdMKiZ7xkjpm3Q1F
         WmIWPij3/Zcwd3sXtc2oWy1QtJWi4K1YxwfWZE9jznqUNPwflSNeHC/DhsrRKQK9ipoE
         kUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036331; x=1710641131;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHEIYqeti5loGAbMg5pT9rTzLm2kPQlk4+PZDUbNnbs=;
        b=LXFM40kRywM322XHwzxSVLnRmmk6Y2Y7qOvS8dtM50T8yZpwNSlB6Qs5hRZ2/eO6GV
         6EGK2t+XQrGkwtaDiuRx6KJaACg5LwNkufBooupqmsrfkq/239GKC6H4AqMaCjakknFJ
         AyQrWdnZPV86qSMHx8IJuvHWzKoY0D20siok7/QDJfvA8tATHziada8nj0wqQy0+As+7
         pBji0J1yVEdqal+qXF0hEdgzRdydwxaRF7p0sFugs7bsh5R1MHNCRuosQmtKthOAH6In
         pyK4WypDAu/K5cw5DCW4tKzcGBiIevBy5zmeo8B1mBrmVEB1fikXxQGAgBxjimv50in5
         mxqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT6mvZ+A0i3OSnT9ZP1wKZfsXswNDcZ2RHLqsOA04BmsaLofY/mFvwC0fqH7ZrAIV7j+C8VBA1rvb/YsdOEhQ5FYuv5i74C4wdbg==
X-Gm-Message-State: AOJu0Yxoaly2s+hCft5wnbNx+UXdvYdoiP3CgPYIDKznU1ik1Ksya+AE
	RvAF8T2RpsK0fOc1lSpGYxTpb3Z5qaaod/8aIK/9+6ZMlJphqrOx81UROgqKhdLEmolW/F2xO9y
	LLxRE4w==
X-Google-Smtp-Source: AGHT+IFFeRmPXH/DhdnrjLnsP7WPRqqtOIbezxRAyR/jnJBja3zK8/JuocE9C3SHGAEjuI8M5e1xF7iOTDOC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a17:90b:3804:b0:29b:b854:54ad with SMTP id
 mq4-20020a17090b380400b0029bb85454admr192655pjb.0.1710036330740; Sat, 09 Mar
 2024 18:05:30 -0800 (PST)
Date: Sat,  9 Mar 2024 18:04:55 -0800
Message-Id: <20240310020509.647319-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 00/13] tools header compiler.h update
From: Ian Rogers <irogers@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	David Laight <David.Laight@ACULAB.COM>, "Michael S. Tsirkin" <mst@redhat.com>, Shunsuke Mie <mie@igel.co.jp>, 
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, 
	James Clark <james.clark@arm.com>, Nick Forrington <nick.forrington@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, German Gomez <german.gomez@arm.com>, Rob Herring <robh@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Fuad Tabba <tabba@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Peter Xu <peterx@redhat.com>, 
	Vishal Annapurve <vannapurve@google.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Update tools/include/linux/compiler.h so that the definition of
noinline can be updated to avoid an LLVM libc breakage. Fix build
issues and try to synchronize other pieces on the way. For atomic.h,
don't try to synchronize and just punt to stdatomic.h that we can
assume is present since the move to C11.

Ian Rogers (13):
  tools bpf: Synchronize bpf.h with kernel uapi version
  libbpf: Make __printf define conditional
  libperf xyarray: Use correct stddef.h include
  perf expr: Add missing stdbool.h include
  perf expr: Tidy up header guard
  perf debug: Add missing linux/types.h include
  perf cacheline: Add missing linux/types.h include
  perf arm-spe: Add missing linux/types.h include
  tools headers: Rewrite linux/atomic.h using C11's stdatomic.h
  asm-generic: Avoid transitive dependency for unaligned.h
  tools headers: Sync linux/overflow.h
  tools headers: Sync compiler.h headers
  tools headers: Rename noinline to __noinline

 include/asm-generic/unaligned.h               |   2 +
 tools/arch/x86/include/asm/atomic.h           |  84 ----
 tools/include/asm-generic/atomic-gcc.h        |  95 ----
 tools/include/asm-generic/bitops/non-atomic.h |   1 +
 tools/include/asm-generic/unaligned.h         |   2 +
 tools/include/asm/atomic.h                    |  11 -
 tools/include/asm/rwonce.h                    |  63 +++
 tools/include/linux/atomic.h                  | 107 ++++-
 tools/include/linux/compiler-clang.h          | 124 +++++
 tools/include/linux/compiler-gcc.h            | 145 +++++-
 tools/include/linux/compiler.h                | 221 ++-------
 tools/include/linux/compiler_attributes.h     | 449 ++++++++++++++++++
 tools/include/linux/compiler_types.h          | 171 ++++++-
 tools/include/linux/overflow.h                | 331 ++++++++++---
 tools/include/linux/rbtree.h                  |   1 +
 tools/include/linux/string.h                  |   1 +
 tools/include/linux/types.h                   |  17 +-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/libbpf.c                        |   4 +-
 tools/lib/perf/include/internal/xyarray.h     |   2 +-
 tools/perf/arch/x86/tests/bp-modify.c         |   4 +-
 tools/perf/bench/find-bit-bench.c             |   2 +-
 tools/perf/check-headers.sh                   |   4 +
 tools/perf/tests/bp_account.c                 |   2 +-
 tools/perf/tests/bp_signal.c                  |   2 +-
 tools/perf/tests/bp_signal_overflow.c         |   2 +-
 tools/perf/tests/dwarf-unwind.c               |  12 +-
 tools/perf/tests/workloads/leafloop.c         |   8 +-
 tools/perf/tests/workloads/thloop.c           |   4 +-
 .../util/arm-spe-decoder/arm-spe-decoder.h    |   1 +
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     |   8 +-
 tools/perf/util/cacheline.h                   |   1 +
 tools/perf/util/debug.h                       |   1 +
 tools/perf/util/expr.h                        |   8 +-
 .../selftests/kvm/include/kvm_util_base.h     |   3 +-
 35 files changed, 1388 insertions(+), 506 deletions(-)
 delete mode 100644 tools/arch/x86/include/asm/atomic.h
 delete mode 100644 tools/include/asm-generic/atomic-gcc.h
 delete mode 100644 tools/include/asm/atomic.h
 create mode 100644 tools/include/asm/rwonce.h
 create mode 100644 tools/include/linux/compiler-clang.h
 create mode 100644 tools/include/linux/compiler_attributes.h

-- 
2.44.0.278.ge034bb2e1d-goog


