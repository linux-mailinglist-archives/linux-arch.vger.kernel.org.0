Return-Path: <linux-arch+bounces-1140-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A86819795
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 05:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0FD1C25341
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 04:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FD9BE5E;
	Wed, 20 Dec 2023 04:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sqFpniuU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9F168B3
	for <linux-arch@vger.kernel.org>; Wed, 20 Dec 2023 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d045097b4cso22827545ad.0
        for <linux-arch@vger.kernel.org>; Tue, 19 Dec 2023 20:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703045623; x=1703650423; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=mNVWdMSAqfvpbN5g4IovRqwuhzgdiEbCZgrhc7x2wjc=;
        b=sqFpniuUv1jPeUcslD9u70BMjvDT3Pn1u4MVKC25xqk7qxT3ogc04/G7AzpnjFN9qP
         wX0M0o6fDxBVGgdq1KImwVb4xQARFPNes9FjuZOpYBPXl78+YLFexHeH/h/L8Nd46oF7
         fAtGCV4qqJLJvfql1Hx8OdbBb8T6rgdTXpDhofeX1aN/vUCjzKBiwFQhBDOFceaIVp83
         2azW/SVeUaLquJ+xCC8bz30l5VXWxfNSJDHiWYyq95ua3xyhNLNWr7xoHg6PfDpmL2BE
         LE2WARMFquM73UPg09z5t7bXfLsAARBhlaMR76KzetrUdMYZCIaOd5uQcViu/SWCjMdG
         s+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703045623; x=1703650423;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNVWdMSAqfvpbN5g4IovRqwuhzgdiEbCZgrhc7x2wjc=;
        b=RITcMnERPAx6NcnbsZ4gzOb8BROKFUGIbb4T2ZIW0KDXSBS+b8HWSPc0uThBbRk14o
         pOWAzC11+zUhJmc0oAvdHLb/H2ziRP2mTL0KLOqkbsH/gRoRNkv5f3BqtsX6P+3MSX00
         v+l2POapWUX0fTf0bks0wDJJk9OzCHmqXIPLaAZcsz1ROtz7NOwEL0HU1CaGCocUVhf0
         E0xuNsfWy+/p50zD/GBiLm4aD5XOXVobmjTyJmU75EzTLikZ7a0pGVlagU7FyUgdN/0P
         tMmjTzzV4BQTmTxHf1/7T+29f53SWx6VnbjQt3Zbuu7BsW/tdjeIi8qOR0H4pX8fWbqx
         ONlA==
X-Gm-Message-State: AOJu0YzxE3cdC8pVxFvNThVk7v16AnvqkoDqzu2zrQdiDIkCYCqx3oC7
	211ydNnHz061sIOkOb7lUASnxw==
X-Google-Smtp-Source: AGHT+IGTH7Uz/NcmceVfotUGElTRFy6BFXANyvxa2H36ukICplsk22hKc23OStWdWx3+9daWWuC7hQ==
X-Received: by 2002:a17:903:22c1:b0:1d3:c025:c99e with SMTP id y1-20020a17090322c100b001d3c025c99emr2935918plg.63.1703045623531;
        Tue, 19 Dec 2023 20:13:43 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:8f60:ee5a:d698:1116])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001d08e08003esm21884208plx.174.2023.12.19.20.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 20:13:42 -0800 (PST)
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, Oleg
 Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees
 Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, "Rick P.
 Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
 <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, Szabolcs Nagy
 <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>, Christian
 Brauner <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 00/39] arm64/gcs: Provide support for GCS in userspace
In-reply-to: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
Date: Wed, 20 Dec 2023 01:13:41 -0300
Message-ID: <874jgdh5oq.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Mark Brown <broonie@kernel.org> writes:

>       arm64/mm: Restructure arch_validate_flags() for extensibility
>       prctl: arch-agnostic prctl for shadow stack
>       mman: Add map_shadow_stack() flags
>       arm64: Document boot requirements for Guarded Control Stacks
>       arm64/gcs: Document the ABI for Guarded Control Stacks
>       arm64/sysreg: Add new system registers for GCS
>       arm64/sysreg: Add definitions for architected GCS caps
>       arm64/gcs: Add manual encodings of GCS instructions
>       arm64/gcs: Provide put_user_gcs()
>       arm64/cpufeature: Runtime detection of Guarded Control Stack (GCS)
>       arm64/mm: Allocate PIE slots for EL0 guarded control stack
>       mm: Define VM_SHADOW_STACK for arm64 when we support GCS
>       arm64/mm: Map pages for guarded control stack
>       KVM: arm64: Manage GCS registers for guests
>       arm64/gcs: Allow GCS usage at EL0 and EL1
>       arm64/idreg: Add overrride for GCS
>       arm64/hwcap: Add hwcap for GCS
>       arm64/traps: Handle GCS exceptions
>       arm64/mm: Handle GCS data aborts
>       arm64/gcs: Context switch GCS state for EL0
>       arm64/gcs: Allocate a new GCS for threads with GCS enabled
>       arm64/gcs: Implement shadow stack prctl() interface
>       arm64/mm: Implement map_shadow_stack()
>       arm64/signal: Set up and restore the GCS context for signal handlers
>       arm64/signal: Expose GCS state in signal frames
>       arm64/ptrace: Expose GCS via ptrace and core files
>       arm64: Add Kconfig for Guarded Control Stack (GCS)
>       kselftest/arm64: Verify the GCS hwcap
>       kselftest/arm64: Add GCS as a detected feature in the signal tests
>       kselftest/arm64: Add framework support for GCS to signal handling tests
>       kselftest/arm64: Allow signals tests to specify an expected si_code
>       kselftest/arm64: Always run signals tests with GCS enabled
>       kselftest/arm64: Add very basic GCS test program
>       kselftest/arm64: Add a GCS test program built with the system libc
>       kselftest/arm64: Add test coverage for GCS mode locking
>       selftests/arm64: Add GCS signal tests
>       kselftest/arm64: Add a GCS stress test
>       kselftest/arm64: Enable GCS for the FP stress tests
>       kselftest/clone3: Enable GCS in the clone3 selftests

Not sure if this is warranted, so sorry for the potential spam:

I don't have any comments on the patches I haven't replied to.

-- 
Thiago

