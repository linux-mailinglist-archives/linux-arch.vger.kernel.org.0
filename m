Return-Path: <linux-arch+bounces-2907-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDA48774E1
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 03:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3FD1C20C79
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 02:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7132443E;
	Sun, 10 Mar 2024 02:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZG3qtOl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986C61FD7
	for <linux-arch@vger.kernel.org>; Sun, 10 Mar 2024 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036336; cv=none; b=ix2G1ulqk/FbNC2EGIUxLL6R+U4tQDQfdW6gyD3kfdYIp/GzhyrNj15tOG06vqMYduyPtVCEzj/WeyqOHbU9JfBeEr4XWQtsywWLUEaJZUbywY7lOSisUepDeSjvEg8Ok6xEKEE4gbx8QybU5rlU3qxS+DqiRttMJMNVk4fb54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036336; c=relaxed/simple;
	bh=ZSKBQS+8Mn7aJnZUbJUB/8XB7m9MXAj5PzIqShvjvqw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jdpgx8t0qSMOllIMCC4k6qsIyqyeNeHlsyIJKccnewg+NuuHrc6LV3IWHuemC39vNsNOmd8BYvIhmVl3zwyWzfZHvEkKeFsJWRq+tDSbKi5NdB1G97l90W2izCLhmVqbyW8p1YUtX//MFtRMt5VY/YEOTuBZ6nqSKta3sL3TF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZG3qtOl; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so4932857276.1
        for <linux-arch@vger.kernel.org>; Sat, 09 Mar 2024 18:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036333; x=1710641133; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1Gx+zOxHa5G/G1Me70ulKh3Qhwa8FiZyBNMKmpUzIM=;
        b=BZG3qtOl1Lk1bJytdZIVHW9ExdwmwN/JyuPocEHdNsRCuLVNgssy0pB7ZrYEQaeIYt
         Xpch/sx+B2mZNpYIaXqj2ErUzL6DyoV9k51hqaseqtNGf+tFPDIRK0M4UZno+WFKhLzx
         I/I7jVpTe4tOwOALJYHX3N8rV1W+aEpvY8fz70RitI7T1/f6kzlysPSkUjqFAx4JYqr7
         RL4UC9w9/wJzj4mfBMoUr9SbFp/bd2Wl1eTTa5pbVD6pheNUauDUd02cBvj+dgS3dj0R
         cif0w2wMFYBZxxJYd0amy0KrezZWmVQ9RRQYg5tMQh/H/faAl1wfckVzIhOyijqDmJWc
         XsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036333; x=1710641133;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1Gx+zOxHa5G/G1Me70ulKh3Qhwa8FiZyBNMKmpUzIM=;
        b=BsEzdIAEYSgrI2FhAXd7GEZu4y7zNBzuVS+Pt3eSGgqDVV40BHeCBKtwZh97Zi0VMp
         aEkFZwBqo3DC4f8Y3BYlxlifg8AGyyvARiSJkuJCQGuTJ9ZDcu/uWuR3sSRRZY7lLlTl
         QYsufQNiads4IbKRoQ84jgWYv7+2vbvEJ4YTIHNg7CxOFGdZMjGqxVSEKIvThwfe+yRu
         zM15xtp83/ZIrnqj3tKeBBFcsnkbESzguIUH3fWvh5Gh2jTaQSjkVJAN4Ym5GTavj6HD
         xZBC0xvOLs2/Tbkupf1PkqzSa06hD1BkDoikNdSmrtsVqEIOSKaAR0MV70mqyIYTwVoR
         jhLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwroDiCyK+tXVJ6oDGJ8deshEteVc3z7kJTW7dUEhPxAEgOu8hCSkPL7N+aE1mqV2wYlYLEIeqQ0JiELUTUpDog2S3OvoQHB1vIg==
X-Gm-Message-State: AOJu0YxSr7aq6DiNg4UnccCiwcCFsRcB7x3jBCNNojNZJGWuWGBKMtaC
	nsgiBKvle3u5tyHJ512POBUAWPNU7dhzehW4GeSIutG5Tz5NpzXCdA0/51yfRIf9jHux+oypGK+
	GnQnnJQ==
X-Google-Smtp-Source: AGHT+IF4u5R6JlS2lv4g7BW2szOoJKeUuXHhe4ENBdL2Zr6Mgb8g7E49MW+hNNmJV1buj1jkBdxVOnRyOcxA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c2:b0:dbd:b4e8:1565 with SMTP
 id w2-20020a05690210c200b00dbdb4e81565mr1091610ybu.4.1710036333476; Sat, 09
 Mar 2024 18:05:33 -0800 (PST)
Date: Sat,  9 Mar 2024 18:04:56 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 01/13] tools bpf: Synchronize bpf.h with kernel uapi version
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

Commit 91051f003948 ("tcp: Dump bound-only sockets in inet_diag.")
added BPF_TCP_BOUND_INACTIVE to the enum of tcp states in uapi's
bpf.h. Synchronize the tools version of the file.

To avoid future divergence add uapi/linux/bpf.h,
include/uapi/linux/bpf_common.h and
include/uapi/linux/bpf_perf_event.h to the check-headers.sh script.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/uapi/linux/bpf.h | 1 +
 tools/perf/check-headers.sh    | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7f24d898efbb..754e68ca8744 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6904,6 +6904,7 @@ enum {
 	BPF_TCP_LISTEN,
 	BPF_TCP_CLOSING,	/* Now a valid state */
 	BPF_TCP_NEW_SYN_RECV,
+	BPF_TCP_BOUND_INACTIVE,
 
 	BPF_TCP_MAX_STATES	/* Leave at the end! */
 };
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 66ba33dbcef2..64dbf199dff9 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -6,6 +6,9 @@ NC='\033[0m' # No Color
 
 declare -a FILES
 FILES=(
+  "include/uapi/linux/bpf.h"
+  "include/uapi/linux/bpf_common.h"
+  "include/uapi/linux/bpf_perf_event.h"
   "include/uapi/linux/const.h"
   "include/uapi/drm/drm.h"
   "include/uapi/drm/i915_drm.h"
-- 
2.44.0.278.ge034bb2e1d-goog


