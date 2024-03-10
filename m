Return-Path: <linux-arch+bounces-2914-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D905877504
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 03:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C202D1C20C1F
	for <lists+linux-arch@lfdr.de>; Sun, 10 Mar 2024 02:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A5C2B9DD;
	Sun, 10 Mar 2024 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wez/FaFs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586352BCF7
	for <linux-arch@vger.kernel.org>; Sun, 10 Mar 2024 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036354; cv=none; b=kdztI6EaLTAH4SQEyYrdpHT+gkZXWNtQuFEElohyV7UktbovoEzpvBxOCCrTNhF8F0JogcFdz6d0YgVuH3dimPaEB2ZiR2xp75RoJPsNyDGw7wu9Mib46bMzoyZUz82Fuo754l6pFVP/l+QzTRRZ4Fya2mkuxl/fP2nTPzIS+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036354; c=relaxed/simple;
	bh=nyI9dgaoU2HMw/TgIDnIDYrLQif8D0L3I6qaHvxp6Ug=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=s5T2jCP5y4z3koDbB3DpKXqkfXuh2Bcx0kJAVSbXq65v5xULlilq1GE/7vL8WFJW1bbKjK9Iq6Lut11LIxrNmTUh3vH3Ti/xvkFTxjL5rcNyCH08W8SAkS8MYZ2jdJInWgu+iV+vTWl8vXHNvnv2HWAO3Iv4OG/vQf+gEQbtqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wez/FaFs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0a5bf550so28763207b3.3
        for <linux-arch@vger.kernel.org>; Sat, 09 Mar 2024 18:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036351; x=1710641151; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/s3J+Sp6Nwm5vYKq4/rEI+V8C3zBszpK/wcDil3Uhsk=;
        b=wez/FaFsRjHRkv0PxDcesvwFad++DgjbL5QV9cfERctSQJoTj2UXGQ9UA0SVyrBMS1
         MmWpxfWDlUlmdFQZzAEfEc9cequA/fJUA24J4wmP1XJuT86NqcIMF3zamj22F9LCMRB2
         2ZcKcGrrMeu8Ya8Icq9g9DKOhaG/tIwJ17Qjsw46RzsTNDBEkfF//4FHu1n0YJxEgIbx
         41qP3ACy74XDqDuHmaSaQOMGeDw20pQSVKcAD4QAAalvxoCkw4TvMsv/sgdx2Hl3rQYa
         UX70j7T0A8KWX512RuVd3u3LTJvu/rcq5dYIpQYApfjWtnlGgWDhMvKiMDR08SBCjXeC
         U2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036351; x=1710641151;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/s3J+Sp6Nwm5vYKq4/rEI+V8C3zBszpK/wcDil3Uhsk=;
        b=MOrSOyvVoi8mretCr1wk+MvDu03wA5PhPbk4hUqqG22JcUkr/+Ly8w5q5cvIGXa29p
         o1mPtM/8mrNr3APt82OqDf38WovY3fhIX2Rk4qSopw6xsnw2KQbgrgiQ8/jDh/mQXfDo
         Esmr6zUMpR0KQTRuQSKk4Hf0s1XiQ1TH+3GvIZUseOWAaK/ZRQbqgN45JdeQdrYCjN9j
         d2exXv0iSza7GSGmqvtpEfIVi4dVAc4wrCD0nZyfkdBLr40A9fgNV2q9LmTvozqwkWul
         Agpz+pNlqluQICU2K32U+3f6+ZjMvIVZRdPwVJUoLG/cgJQyQTx5laF8EMqXqQws6rOi
         09EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ60MTV2yET8NpCU1U7m8T1r3S75VvYrtqJoc2eHX2NOtXi3SwlKbNlM0I6F6xU+D9EX4ezr8cIEbFfrLUCLyP0BrG72gK26D9vQ==
X-Gm-Message-State: AOJu0YwpvmDj1fDUxr2jvY6Ju1+LVlLsBklWV7TMJGnjnRnwnCl/SQOF
	t3ViR6rl7UK3y/faGrEfdKhcCkkQoiI8fjsB6HPve9t9HLUACs2VSm6K8rAEbpD35+Rcn1UycPO
	axZMdag==
X-Google-Smtp-Source: AGHT+IHPD3AdhB6c0T/TfiXMF4uI00y32OTKxm5DEXBOiPnGnfJTzAmtckpif5kyd4Qr/BOAcbdh5KWG2LgR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a0d:dd04:0:b0:60a:25ce:c165 with SMTP id
 g4-20020a0ddd04000000b0060a25cec165mr362319ywe.6.1710036351589; Sat, 09 Mar
 2024 18:05:51 -0800 (PST)
Date: Sat,  9 Mar 2024 18:05:03 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 08/13] perf arm-spe: Add missing linux/types.h include
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

u64 is used for various structs in arm-spe-decoder.h, while uint64_t
is used in arm-spe-pkt-decoder.h. Avoid transitive dependencies
bringing in linux/types.h and directly depend upon it in
arm-spe-decoder.h. Fix arm-spe-decoder.c to use uint64_t, as the
header file does.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h     | 1 +
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 1443c28545a9..da5c5816c948 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -10,6 +10,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdint.h>
+#include <linux/types.h>
 
 #include "arm-spe-pkt-decoder.h"
 
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index a454c6737563..e035f49f28ad 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -292,7 +292,7 @@ static int arm_spe_pkt_out_string(int *err, char **buf_p, size_t *blen,
 static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 				  char *buf, size_t buf_len)
 {
-	u64 payload = packet->payload;
+	uint64_t payload = packet->payload;
 	int err = 0;
 
 	arm_spe_pkt_out_string(&err, &buf, &buf_len, "EV");
@@ -332,7 +332,7 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 				    char *buf, size_t buf_len)
 {
-	u64 payload = packet->payload;
+	uint64_t payload = packet->payload;
 	int err = 0;
 
 	switch (packet->index) {
@@ -429,7 +429,7 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 {
 	int ns, el, idx = packet->index;
 	int ch, pat;
-	u64 payload = packet->payload;
+	uint64_t payload = packet->payload;
 	int err = 0;
 	static const char *idx_name[] = {"PC", "TGT", "VA", "PA", "PBT"};
 
@@ -469,7 +469,7 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
 				    char *buf, size_t buf_len)
 {
-	u64 payload = packet->payload;
+	uint64_t payload = packet->payload;
 	const char *name = arm_spe_pkt_name(packet->type);
 	int err = 0;
 
-- 
2.44.0.278.ge034bb2e1d-goog


