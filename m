Return-Path: <linux-arch+bounces-2909-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72CD8774EF
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 03:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F71F211A1
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 02:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD43C12A;
	Sun, 10 Mar 2024 02:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRsNZPe0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF62C12F
	for <linux-arch@vger.kernel.org>; Sun, 10 Mar 2024 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036343; cv=none; b=szWNmMXc+TpZ+0hetrwET1p5Ra9JRzRrJCiP0lvFNo8jgPZjZ9pHVeqfL0ClCUOcmaX7xdxO7/t+pDsYdnoJXqBAFtS6hrZnGUnuV3uERK3ORCMDed3VFK5+xnP7OTf+t3JI6nIGl+LmWoOmT8sT0N5AkESeSTK2VR1EKEgIhlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036343; c=relaxed/simple;
	bh=RGHR+QiLceocR0H7Go2J+IFsQikYIqGpUdA5u3bRq6I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eE9eo4P6FI7zYvNWhkHwWTyxbDrwn8YPKkvkXeNnfsHSvet/bQwVtUDs05ezd9L41JRrLSxSgo5Ie9tmJV5q9ROcmkTsVAoopdPwqRJUFlAJi8vzAOFgpb7/+w0k/DkJD9GxKFhX5LijnDKMr9NNC955KXhN6PFDQTRgnEB4Rz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRsNZPe0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a08eb0956so24606727b3.3
        for <linux-arch@vger.kernel.org>; Sat, 09 Mar 2024 18:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036339; x=1710641139; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lEogdjVExxayJMRv1u0mjZw+1C1F2zoHt9ebGCOCyUE=;
        b=VRsNZPe08ukQkLbC8cLeYP0BRexi0H/ytB079Ek1//YKN6get16huQfO+BpiG1tXOD
         /DfXJJsAhbpa41MJSgaY2NShFvyfGKd41kr50rONuG+9vGjXxf92ch8Hl6eGAPWS0hw7
         V3PejFFmfmrU5vPpGLAigL7iSv4mZImqptxoFxJQ4OjxVvG0ERXdGOpP+Lgn2PtK9AWA
         0g0yb0s9m2oHNGuLPm57TNOEk03to2Zrwt1BJs6TA32/yB8FdcS9VHIy8Wq9TRzx0jSD
         Bgqc+g/01i/CxnEOjKXp+j/RC3Las1cviN75DkghO3v1bmFnfAoqbBTNS/IAQpDlv+tN
         PkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036339; x=1710641139;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEogdjVExxayJMRv1u0mjZw+1C1F2zoHt9ebGCOCyUE=;
        b=enDjvr+RmUyxs+KjqKjxjs1EPHTFW/TYmsFj+0TYyNWFQfliOAfmtNhndUSoN7U0Y3
         5Z5G9lpyJ5sGWL6uYpr8+s7TaDiAJV74bwKFWGKsIpS2oU1ITpkAwThjXttzursFxIbe
         Pgr00x+0QxEvW5lvw3qr+O9o8EnPf3PIX5SVJdByyziEwyvQoFKzlJKLQGQc0LUJUJ7B
         gZ0OuB1Kdh+ldKbl3IKc1dpzEk/lMf6G99aq/zs9OZ58DWVUDFSJAWofR8E2X66t8e8w
         FLZuBhHrLNL2ssk6OoH5I0lGFpSjEagRqRkti6expkKImN1a+Ug/KH/KU04Y+cbXCJ5M
         lLCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlphJOfbGDvqwGXLxzsUNGon0eu+idYik+1yKQpYDrSqnmFXoBnqcNVf8EYj+XuUG3f9lMNPRsM8ncZ1clTWQPVLOfUdmwJSpCFw==
X-Gm-Message-State: AOJu0YxAUDqtOp73iYEhuhQi7jGGatrEA8KJk5K4nIGLiReAaK5WLdQY
	NcTRBmaXzxB3HxP+oYR/lTzaOOpeBEF1Surv+1VEjdMifC3+RftehOFLatTsmzS4lhKjvrtPOVW
	an1wNCQ==
X-Google-Smtp-Source: AGHT+IEyM3cHgr9ZVgnZoKCZ0SYCN/4S3200GAqNBDyFBPz9iTsTIsAdJdgR5M7Dk98A1ko/gir8jVGY1z12
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a0d:e84c:0:b0:609:d325:5826 with SMTP id
 r73-20020a0de84c000000b00609d3255826mr678752ywe.7.1710036339213; Sat, 09 Mar
 2024 18:05:39 -0800 (PST)
Date: Sat,  9 Mar 2024 18:04:58 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 03/13] libperf xyarray: Use correct stddef.h include
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

sys/types.h may not define both NULL and size_t used in this
file. Change the dependency to the correct stddef.h one.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/xyarray.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/xyarray.h b/tools/lib/perf/include/internal/xyarray.h
index f10af3da7b21..947804fb8c85 100644
--- a/tools/lib/perf/include/internal/xyarray.h
+++ b/tools/lib/perf/include/internal/xyarray.h
@@ -3,7 +3,7 @@
 #define __LIBPERF_INTERNAL_XYARRAY_H
 
 #include <linux/compiler.h>
-#include <sys/types.h>
+#include <stddef.h>
 
 struct xyarray {
 	size_t row_size;
-- 
2.44.0.278.ge034bb2e1d-goog


