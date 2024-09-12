Return-Path: <linux-arch+bounces-7259-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4209774F3
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 01:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEBD1C24200
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 23:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C691C7B63;
	Thu, 12 Sep 2024 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YvcTjC5h"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA11C3F21
	for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2024 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183059; cv=none; b=QXHQsxfM5CbdKbPoJSpLr5fWNP3IRkH2StiEM5At4ipFHlfZ7bvZf3K0+qE9e6xT5lJQKaWqUsdTw/f7VCAbe94JQtsWAbYci3n0PougtoHtbyk0LX2FmaPe2I6eykyzofPo1kVSx2hqv/e+8Aal0L6SZyYgUjpcf7CsBzmWV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183059; c=relaxed/simple;
	bh=cwARFgjF2bUwAreZrfeSiuKLNwifZh7gPR/VBRlAnHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9jWJlzcSQM+IMj5WjNDLc9XxouhehFoel00j6guzARFhXpckb7Q8/yjbQNgLrtaJwKkIO1FUyEGIHvUU+s0lxMaaNG8VH5oPxfYfrkSWaKv7USya0t63NA0WDRbjYNIcn8+LRjzjk34MgeWnV6vSNpFg4nR6SXkuSRH7PHvoDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YvcTjC5h; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d8f06c2459so301445a91.0
        for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2024 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183057; x=1726787857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veWGRHreCjgq8h7I/yOaDBNsZmlAimjJ+4EKqlz5IR0=;
        b=YvcTjC5h/5SNi5RsoBQt/PvIyBz8LMpFFwQr/jd0RU2tvfNt5BbzOgAb3dHMOiKcun
         BE0qARaMKoFjcOCThWcqOxxgT/qVs24vmCyClpHR8ETrOKh+GftGjvgWiWsprHblBzp5
         nGzaz0oCIRajl9+gFUfZw+rONPhVFTUhJdaZ+1fZCm67AR/9W6UhSyEdgRjnReXP4zCk
         lQIol3cB7zdkZPxHRMiQAtHFc2cjyYFKIWnfspEa9p0u9QLplek3nz7XT1BxctrxXE3p
         mwTc9dC8D8AOTNkq5KnNaihZLIbY8VMchIphiUF7ZvMcjbIS4YqzQ7a3EYbLlv7EAng5
         eoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183057; x=1726787857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veWGRHreCjgq8h7I/yOaDBNsZmlAimjJ+4EKqlz5IR0=;
        b=CGUQLDWaeaim5ytrvMrNmw9nJMyp9zx0Gs3ou41KurHGCkvuBLjOgiF40Q1ZrsEHy2
         mfi22SLm1N4Yv2U+Ddazvn4ovhTFFTu3YBgJ+TZ5IJkbUpK/ftiTt+C8rVuaMv2DXNFB
         DGkdQvZsckYhp4jk6VhNEeH7F1dqs1m/Tul/t2PNOKCLcgH5wCrges9rvVFBNKyzSW0s
         dtRG5z8zHfYJ9ZoAN3hHiCdr4BlpfRYUswWNYmbolOeS4I4BkBy5kf/baXlX6XxDrmjy
         RufCDDTJYMPMtYn1BmxcvooIjW4/PckZD/FNX57bCOSCbr5vRBoNdINLc+oPb2gppwex
         zdog==
X-Forwarded-Encrypted: i=1; AJvYcCXsjjG5lwcaOp+NY5TvD54/fDOrclsc1zgLp09jcvrHgvFq6EpKOOCN3YEN6l0MniNKXLpx3pkHYJzO@vger.kernel.org
X-Gm-Message-State: AOJu0YwBVHemOLtKw9LS9+XxXmVxZd/J7I6lYrBQlM9iXCAA2YKw5AEz
	TKzwjajfohM1iK0MEkJoJRZsfoLJNyKz7+LPtOkL1fAC5XEy9jKNoiWldm61LMI=
X-Google-Smtp-Source: AGHT+IGi2PGJAtalAbRDIiYrcdX60Gd/jBapQHqvC1T650woNs+55FVEzfftOtbKP4fBLGwK941M2A==
X-Received: by 2002:a17:90b:1c88:b0:2d8:9a0c:36c0 with SMTP id 98e67ed59e1d1-2dbb9dc0f39mr1063170a91.8.1726183056629;
        Thu, 12 Sep 2024 16:17:36 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:17:36 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net
Subject: [PATCH v4 07/30] riscv: zicfilp / zicfiss in dt-bindings (extensions.yaml)
Date: Thu, 12 Sep 2024 16:16:26 -0700
Message-ID: <20240912231650.3740732-8-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make an entry for cfi extensions in extensions.yaml.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a06dbc6b4928..b7c86fb91984 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -361,6 +361,18 @@ properties:
             The standard Zicboz extension for cache-block zeroing as ratified
             in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
+        - const: zicfilp
+          description:
+            The standard Zicfilp extension for enforcing forward edge control-flow
+            integrity as ratified in commit 3f8e450 ("merge pull request #227 from
+            ved-rivos/0709") of riscv-cfi github repo.
+
+        - const: zicfiss
+          description:
+            The standard Zicfilp extension for enforcing forward edge control-flow
+            integrity as ratified in commit 3f8e450 ("merge pull request #227 from
+            ved-rivos/0709") of riscv-cfi github repo.
+
         - const: zicntr
           description:
             The standard Zicntr extension for base counters and timers, as
-- 
2.45.0


