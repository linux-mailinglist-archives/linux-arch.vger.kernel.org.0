Return-Path: <linux-arch+bounces-938-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C0D80F97D
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 22:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DD31C20DC0
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E559C64145;
	Tue, 12 Dec 2023 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Zx9ABdme"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A38CAF
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 13:35:01 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso30665205e9.0
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 13:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702416899; x=1703021699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=692HNWJOlFtonZp1MhpojM8sdqlm3KHIVwJ0Hg03uAs=;
        b=Zx9ABdmelIvI892XBZPnSeYuq4sZ0jwwghjohngIlcD6LVcDMrlL24aTQSSWFPWsyL
         X+I1IAyOQYJfJ55qFzISJ4OXNCLdFRgmiCPl3rMhHrTB6m5GR+kxg4XIuH3gTL1qBL1H
         WhCjT6/utnc66ahcXxkDI1djU15KFfj1UY3YmGlHTmDsjq59jlcT3ipOUkagNiXdc9KV
         aMIcsv7YxrsYzyP67OIq8qQZETwByTLSHq+BdZtjWjAv0Rh1DOcpGpigqFd1LaiZ691P
         dG8kNSFrQJA6DuRcC1JlNLhOmKo4OqVCvRqZvPqOSLIY4dObLLfcENUUvIsAY3wRf+Ow
         5PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416899; x=1703021699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=692HNWJOlFtonZp1MhpojM8sdqlm3KHIVwJ0Hg03uAs=;
        b=BbiCcNdqzVmKQLrEBoS9mQO4xLFMBx9Z3z9y5l3DCdXHK/XlqVLqTlqKvtrLoCGyXL
         ImlWTQUdmBgfZk3ehIjzA8iMUAP6IyH9ISjYHTcuHA6edOL5G6+LGJoUJ1Kh9T42Ov3S
         GB/t812bYzbE0GqhTc4By8in14Ogu/0270PQQkVsBDXzFKaQORooDMRI2dWI69l662J9
         xzeFQYLVIe1SOFQriQuxT85bxw9h9pbdZTNMAdq01G7nstsayRfs2kgQYgxtmUxaU16t
         9y08FRMMBQyitlryJ/5wL4a8PoXuorHiIFOoSFprZoNmx6ueLF9mYdNNmRFbRtVaAxXU
         vNOQ==
X-Gm-Message-State: AOJu0YwAHAZNOkAkiKqN5IFfImp2MpppXsGQO+7MFRnTTOU83iUtESPM
	ZOugmqcMFhj1eexdLceKID5H2A==
X-Google-Smtp-Source: AGHT+IFkzrnkDCYHfteg2uRMUBp/558DJ+5TYEbB94HHSPp6l/nbeDaimGFYdGQPy4EXupq5BMw1bw==
X-Received: by 2002:a05:600c:600b:b0:40b:5e4a:2374 with SMTP id az11-20020a05600c600b00b0040b5e4a2374mr3902004wmb.118.1702416899421;
        Tue, 12 Dec 2023 13:34:59 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id bg38-20020a05600c3ca600b0040b540ff0a5sm17655337wmb.19.2023.12.12.13.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:34:58 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 0/2] riscv: Enable percpu page first chunk allocator
Date: Tue, 12 Dec 2023 22:34:55 +0100
Message-Id: <20231212213457.132605-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working with pcpu variables, I noticed that riscv did not support
first chunk allocation in the vmalloc area which may be needed as a fallback
in case of a sparse NUMA configuration.

patch 1 starts by introducing a new function flush_cache_vmap_early() which
is needed since a new vmalloc mapping is established and directly accessed:
on riscv, this would likely fail in case of a reordered access or if the
uarch caches invalid entries in TLB.
Note that most architectures do not include asm-generic/cacheflush.h so to
avoid build failures, this patch implements the new function on each of
those architectures. For all architectures except riscv, this new function
is implemented as a no-op to keep the existing behaviour but it likely
needs another implementation.

patch 2 simply enables the page percpu first chunk allocator in riscv.

Changes in v2:
- Rebase on top of 6.7
- Define flush_cache_vmap_early() for all architectures that do
  not include <asm-generic/cacheflush.h> to avoid build failures

Alexandre Ghiti (2):
  mm: Introduce flush_cache_vmap_early()
  riscv: Enable pcpu page first chunk allocator

 arch/arc/include/asm/cacheflush.h      | 1 +
 arch/arm/include/asm/cacheflush.h      | 2 ++
 arch/csky/abiv1/inc/abi/cacheflush.h   | 1 +
 arch/csky/abiv2/inc/abi/cacheflush.h   | 1 +
 arch/m68k/include/asm/cacheflush_mm.h  | 1 +
 arch/mips/include/asm/cacheflush.h     | 2 ++
 arch/nios2/include/asm/cacheflush.h    | 1 +
 arch/parisc/include/asm/cacheflush.h   | 1 +
 arch/riscv/Kconfig                     | 2 ++
 arch/riscv/include/asm/cacheflush.h    | 3 ++-
 arch/riscv/include/asm/tlbflush.h      | 1 +
 arch/riscv/mm/kasan_init.c             | 8 ++++++++
 arch/riscv/mm/tlbflush.c               | 5 +++++
 arch/sh/include/asm/cacheflush.h       | 1 +
 arch/sparc/include/asm/cacheflush_32.h | 1 +
 arch/sparc/include/asm/cacheflush_64.h | 1 +
 arch/xtensa/include/asm/cacheflush.h   | 6 ++++--
 include/asm-generic/cacheflush.h       | 6 ++++++
 mm/percpu.c                            | 8 +-------
 19 files changed, 42 insertions(+), 10 deletions(-)

-- 
2.39.2


