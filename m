Return-Path: <linux-arch+bounces-5428-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE19334F4
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 03:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C286EB20B32
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 01:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769DD1C20;
	Wed, 17 Jul 2024 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNKh2AeQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE7EDF
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721179298; cv=none; b=smT+Rjmaw4JiZxnCxX8s1zNpEIqCvvBxrexonIOwXQrZICTp/LMsnQ1KynUGRL36TPGGobXQiRjG1kDS0Q4UtcBcdY6AbR+oVoKlnrNo0QFG8WeuLKEFYePAygAv6U3bE5dVvXMU/i6HFQjDNINfJar8Qxz7nwXCAHII6y2zR5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721179298; c=relaxed/simple;
	bh=lhXGzSMA/JZRKD/aeyepBh11njIMXYWpRmumnS6D6Rk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VL1C/d8nLJWz6EO1kk1E1p9/cKB+0+ldrc5pdjrk+ulmG7AVVZua5NDaJk5RgYbAKBBw0AGAp6p1NqDtgeRL0VHvxc2dbAt8j9RZIU0WqTq1Hk10UG8PkMEjYcNGhTw5MYSKuWT/rGQT7KEWY9uWF1gD9IAGPEwTgXB+Xcj+3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KNKh2AeQ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-376266a65c8so1798025ab.3
        for <linux-arch@vger.kernel.org>; Tue, 16 Jul 2024 18:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721179296; x=1721784096; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxSuTpzy0m4oHhnzHH3Vl/gMhNpkpWEzqeVsFcwdgKA=;
        b=KNKh2AeQoO5RPXMW0exoIJniLzUvVSlvE87QnJDuAZbyudY2nGirqyZOgEJmVm40IP
         Ql6OTXYZiVH5vbvxbCxr4lLlz/sStGcEygug3+xRtGKCys0xNZRt8c0jyI1Mx67UIxNn
         Q7z04sTTFptgXu79goWkMATQDz1Za7GURr+82UpehA84qVIGSvbcOxdlUzwmx5O3DVnl
         VwC2JDtUdI1UnUkEYqMeC2/VBGsk1jvMY2n1N64r50eVOkVixg7ybgqH5DEUz1F639EA
         ui26sByFda3wF+JOWUbigX31tNLI3nMq7UzOytHIH6jaZK1oki1uKrSxN7UkZEDPWcLM
         PfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721179296; x=1721784096;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxSuTpzy0m4oHhnzHH3Vl/gMhNpkpWEzqeVsFcwdgKA=;
        b=TpTvadLDxCCXYl7QCxDnn2Nkr7FYTI1N31secs1jcUxJ48nn5PipWaGlZgrf1y0cWv
         9jy7A2QnOuO47+YsHwu9n2ohr2S72I95X2NPdpSykSGTvnrLcmGzPR3rARsunnif6UyD
         KqQhl82OYpXYBxoMeNND2a9YibQfxolZbtfZDsdgGa8JuqjfUcOGzr/VnclzEtVcBvfB
         tJ005sGBRggr1aftVFzk9OlCnaBwGy6r2lphFW0wWXHB8B5Fvk9VhCpAac7a2o/YIsc6
         LPMwAquohaLd5e1eK986A+t46erqBcCovArMN2wbTgFOxxXg+fS0yw/EjhmzwFIF7kcs
         azAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWISwF7LQgMSwDbXnpkrlQ/o335q3I5KQFSsosvOMLFOVC7Iw1kWzbn2CiE4y81GNaL45vsVcgQeTeIDoQxXLkCQi/VAxmDg1+bLg==
X-Gm-Message-State: AOJu0YzQcJ7iwxoyoMeEUJ2gYb1o/SG/vn14OMTmMIt8wEfnZ3Q13Z6B
	9hSCTjTp1uxauDA3qqgqlfgxj60B9TopTIBSUSym6+ctzvB1/yWUSQla4eO5yKs=
X-Google-Smtp-Source: AGHT+IFRPVkYVOcZWv1UNdg1RTMru4FboqdZLxvXpxoWV2PdP22CoQ+3xARnx+an75M9dDo1WCR1/Q==
X-Received: by 2002:a05:6e02:13a9:b0:381:3989:214a with SMTP id e9e14a558f8ab-395557ffecfmr5071635ab.10.1721179295925;
        Tue, 16 Jul 2024 18:21:35 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:4ae3:bddc:48f7:36a0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7c5ddsm7023267b3a.124.2024.07.16.18.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 18:21:35 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Andrew Morton
 <akpm@linux-foundation.org>,  Marc Zyngier <maz@kernel.org>,  Oliver Upton
 <oliver.upton@linux.dev>,  James Morse <james.morse@arm.com>,  Suzuki K
 Poulose <suzuki.poulose@arm.com>,  Arnd Bergmann <arnd@arndb.de>,  Oleg
 Nesterov <oleg@redhat.com>,  Eric Biederman <ebiederm@xmission.com>,
  Shuah Khan <shuah@kernel.org>,  "Rick P. Edgecombe"
 <rick.p.edgecombe@intel.com>,  Deepak Gupta <debug@rivosinc.com>,  Ard
 Biesheuvel <ardb@kernel.org>,  Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
  Kees Cook <kees@kernel.org>,  "H.J. Lu" <hjl.tools@gmail.com>,  Paul
 Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Florian Weimer <fweimer@redhat.com>,
  Christian Brauner <brauner@kernel.org>,  Ross Burton
 <ross.burton@arm.com>,  linux-arm-kernel@lists.infradead.org,
  linux-doc@vger.kernel.org,  kvmarm@lists.linux.dev,
  linux-fsdevel@vger.kernel.org,  linux-arch@vger.kernel.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 05/39] arm64/gcs: Document the ABI for Guarded
 Control Stacks
In-Reply-To: <20240625-arm64-gcs-v9-5-0f634469b8f0@kernel.org> (Mark Brown's
	message of "Tue, 25 Jun 2024 15:57:33 +0100")
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
	<20240625-arm64-gcs-v9-5-0f634469b8f0@kernel.org>
Date: Tue, 16 Jul 2024 22:21:33 -0300
Message-ID: <87msmgu82q.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> +3.  Allocation of Guarded Control Stacks
> +----------------------------------------
> +
> +* When GCS is enabled for a thread a new Guarded Control Stack will be
> +  allocated for it of size RLIMIT_STACK or 4 gigabytes, whichever is

s/4 gigabytes/2 gigabytes/

> +  smaller.

-- 
Thiago

