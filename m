Return-Path: <linux-arch+bounces-2913-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573388774FF
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 03:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9371F210FE
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 02:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99A62B9BA;
	Sun, 10 Mar 2024 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4RRJfEVF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA327447
	for <linux-arch@vger.kernel.org>; Sun, 10 Mar 2024 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036351; cv=none; b=UZQXIEX530gwVcGzTvemyHQfOcKoPMXz6Qnyqxz+UqELnl9Orevu+NiR36F7oX6yo0KvfFzCfrSrd+KX/od7l6Ibh/Xj8dS2eTjX8uJs4KeVyRWSDCdvAJzdIoDnrClFg/NZLsXP/6KMKpVrK68HLnPOiMI8RSpy9O+Dw+oWvRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036351; c=relaxed/simple;
	bh=gXS4/PmUcr/u98E5bD8fZ0t4D/xMUtOLNVIZOZ/mooI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OBdRUnrwuwL0XREPPQtpERZ7Nb1Z82ZIywV+RiGTQWRywGfd7kE4kM8/nJuIOLIzyELEH2/1gq46dzZO+0+pxacYDRClju6lirp1J/nGEV8er0BApZTfn01hpMS9wvUimBu+5GJrAstEMXHgPc0Td45CjcwRny6UUlX225/maRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4RRJfEVF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a20c33f06so4761727b3.2
        for <linux-arch@vger.kernel.org>; Sat, 09 Mar 2024 18:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036349; x=1710641149; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgONc26lvm/9ZOmPonAKLBWVK7kvQvvNgc4EWpL/eBk=;
        b=4RRJfEVFPtrJeHkpe6FwktJhu6hedW8U/v/FPR5lEZLhqQphPs7rfv16DpEvOLsq3p
         uJY87zLQNSikrSGbJjnZmvv3SXwvszzrcdKMS+PKtWJIUZtpzl7R0QEuJARFoL8xscwU
         rLXoSBMrzfFNivUw+I2NtMiETimmNkJd6cd7MXkpMcOn3sAm3xhnGlM7JJ0agY8uLr+f
         aziq4Fo6IxHBXY0idncI9OQeKuvL/Oh585fTQgef3OOR+7L7BZeWsnsPOiZaR5WeSN0K
         OthKQCtrXWr5CHwo2KSZJcHxH72A5++tGB32b3HTV7eIH7HP5uHRbMBhpcBc9t59/bku
         QaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036349; x=1710641149;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgONc26lvm/9ZOmPonAKLBWVK7kvQvvNgc4EWpL/eBk=;
        b=JfsP88B34IvzfcKhWL+Y/4meR5TdAOn8WBSdABV6pV/KQvE3CDycTN2KptTisjwHOX
         2vD5RS95Es7sYP6sKFHWGkDUdAC1q+p1WCtzwmWSczQzqzoBwuZhUxCvIveGYIMfrA6Y
         7KNp7RKu7d8RZZz/bkeTjbzseCcwLXLVDdPqWobpoZiqW7QdWlNUIDYK6QUC53NP4ARN
         eK4o28zLJ3ap9NwiH7GHJcV79hwX0v3XCnfH8h68whyKMx+7FTlNqSIOmZjJkb6ppdRD
         6MEgVqOHSXiyaim++Ndc+3E7sTtHkG2dmamdqfixbN8JJbJS7JiWlJH0DrjaAsilOUmZ
         beQA==
X-Forwarded-Encrypted: i=1; AJvYcCWLNABu4ao+9ENp5Afe3o/GakfAX2hRpqEze751c/EqVZYoZ/nPukmOuClcbt1BYagtLqzJtLZRzMJf6nB8wVcG7xAtrVfCVfeX7w==
X-Gm-Message-State: AOJu0YwYeTolJk3cPxcNlyXaGXAfVMv5V5JaUAWGysz+MIKdfMCUdJ75
	ebuC1bFFjoyZgYuQpPWu4K42pb47VXYT97WvRvgWD5rM+2LIR9TAAYdSNJdb8togwCXKXlPBBwW
	hnVufNg==
X-Google-Smtp-Source: AGHT+IEHSaymlJ72bm2wFBwRFlyvHmM501SMsBRHMdMGbeCTQVSAZx2WeXRxeWUBMJJSsrdAYYWs4TJGUV9K
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a25:ab6f:0:b0:dcd:3a37:65 with SMTP id
 u102-20020a25ab6f000000b00dcd3a370065mr144117ybi.7.1710036348960; Sat, 09 Mar
 2024 18:05:48 -0800 (PST)
Date: Sat,  9 Mar 2024 18:05:02 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 07/13] perf cacheline: Add missing linux/types.h include
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

u64 is used in this header for cl_address and cl_offset, so
linux/types.h is necessary. Add to avoid compilation errors that
aren't currently seen due to transitive dependencies.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cacheline.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/cacheline.h b/tools/perf/util/cacheline.h
index fe6d5b60a031..50b77129e1a4 100644
--- a/tools/perf/util/cacheline.h
+++ b/tools/perf/util/cacheline.h
@@ -3,6 +3,7 @@
 #define PERF_CACHELINE_H
 
 #include <linux/compiler.h>
+#include <linux/types.h>
 
 int __pure cacheline_size(void);
 
-- 
2.44.0.278.ge034bb2e1d-goog


