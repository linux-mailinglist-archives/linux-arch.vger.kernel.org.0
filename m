Return-Path: <linux-arch+bounces-6113-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9A794B6AB
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 08:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249931C20F6F
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 06:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E07186E5D;
	Thu,  8 Aug 2024 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WmGLmIUu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44013186E42
	for <linux-arch@vger.kernel.org>; Thu,  8 Aug 2024 06:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098328; cv=none; b=UNDxJtaktHJH0ZKFawu6WN0k0jyX3QSCUMrxS23WkbNw+aVDVqYAltVDWvx972d2gj4BbWdsvGxav6tUxdImECJAv8rFgLI7wI6ZQDMAABboJ0AH5vFojXpNIFVWRLCevu5BrQ6FC+Dmq/uPIW0nSOQozbxHg8jKO1Ib13aChE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098328; c=relaxed/simple;
	bh=vLLuKNqR9XU5O+YIcehGr09FLrfxLy2W9TjakvRNxc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f5FY8zA7X5TjyyaNkaWcqIiSuZefGHxgV3IlApMgGpiw6XLjsgecT8eGlBg3NwwE3W+hMcY2lKxI4N4tSfMmLoYYCAR4W/7my2oD7Q7tKqnQ49nFPFoUjY5RsPT0wEvLN99xsRnm1Ic46ECl63Gvq18fWp/wH0ILAJRKtN0Nmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WmGLmIUu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d1bb65e906so496864a91.3
        for <linux-arch@vger.kernel.org>; Wed, 07 Aug 2024 23:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723098326; x=1723703126; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sJzbBpFNwwY6e+GIMU5iIyI4LLoSSqWXmhkhActO1pM=;
        b=WmGLmIUuyf/l/oP5Hc2I25c7ckQjT7UoU3H/6dcJrZmI2maX7Bev/9eznq4a+khWXP
         /LC+JVPWu2e/M62gXdMw7ykdMV+5da8AdUr6dfQVlmsGBVWAKThLy4+iUS5xcdCD/7Ku
         lBZ79qs1pffGXIkx0MrEe2vV2LdTkbTQ6ZT1rgWfPeYiYyyGFimBWirEeqrIXoabg3Ou
         RgsGIFLJWbNHCyOHAJdJTXQFuur9jj0EXzMYoYz0wWmFGl/mXEoLzC/E6Fso2p/ImABX
         GL4pI9+q5ClclOpBH85/56Fa1uZRD1ciupe8PIaiAtVUyvLQD2KKJe//G0DKddq5+al4
         J0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723098326; x=1723703126;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJzbBpFNwwY6e+GIMU5iIyI4LLoSSqWXmhkhActO1pM=;
        b=dngzv+3KpZ/wFACsbh17p/poAoSbUIC8BUwKb39/jyQDIGo/aGLGUIU2sFQD4hveZk
         js0GY3OupbITBRdhmmGR9EdDt/D4UDdkS9ugYad1YBGKfmSSzHCf7Ghen9sl9L7p89kH
         ZvXjBh8bilNFxg2qfBi3TEn96Y5oAnhgIFW3cKwgFtPLkQP7CclSar5aVgvXM5hzYSi2
         LxTLHjnyHEItEiteNa+0S7Yo8XFqhnUMOtugxShahY5i0iMIP7X6HkBxUVMql7BFnPkJ
         70Uuf0EgFcSGnohLk+3Gdypf5X5QRMYXxIIw94h5+bCMJxSM0rZFVhGBWOJKG7z6YRiG
         qsWg==
X-Forwarded-Encrypted: i=1; AJvYcCVoki8W2WJuSERtI3PpKhh58ybh/smDcNhBVqmY5w2x5IkzAbikQI7y9xXBsswjXIXOv+JX9GochBQtztOq9nTKFAOS32Kqtli3/A==
X-Gm-Message-State: AOJu0Yy7lZko199IKSFQhyBdntT/jsZN79NFZU1TTTOBqL9FhK1UM6fD
	zSAYJFyiOhcoNyOT4RgJ1Nst08vvMTVbWIPRwqCRqRgZZBlLCovLiwg2fyp/ePs=
X-Google-Smtp-Source: AGHT+IG5Sh4RPZDFGIdFKwM0iRTPb/2nHrMhAgBHSqeUq3wn62Dbr5Jen5m7Eo7OeNMhWJA7SfHwfg==
X-Received: by 2002:a17:90b:4ac9:b0:2c4:dc63:96d7 with SMTP id 98e67ed59e1d1-2d1c349446emr921727a91.41.1723098326578;
        Wed, 07 Aug 2024 23:25:26 -0700 (PDT)
Received: from localhost ([2804:14c:87d5:5261:ed46:7c69:6cee:3c20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9db74a0sm328001a91.47.2024.08.07.23.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 23:25:26 -0700 (PDT)
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
Subject: Re: [PATCH v10 39/40] kselftest/arm64: Enable GCS for the FP stress
 tests
In-Reply-To: <20240801-arm64-gcs-v10-39-699e2bd2190b@kernel.org> (Mark Brown's
	message of "Thu, 01 Aug 2024 13:07:06 +0100")
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-39-699e2bd2190b@kernel.org>
Date: Thu, 08 Aug 2024 03:25:23 -0300
Message-ID: <87v80bcyzw.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> While it's a bit off topic for them the floating point stress tests do give
> us some coverage of context thrashing cases, and also of active signal
> delivery separate to the relatively complicated framework in the actual
> signals tests. Have the tests enable GCS on startup, ignoring failures so
> they continue to work as before on systems without GCS.
>
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/fp/assembler.h   | 15 +++++++++++++++
>  tools/testing/selftests/arm64/fp/fpsimd-test.S |  2 ++
>  tools/testing/selftests/arm64/fp/sve-test.S    |  2 ++
>  tools/testing/selftests/arm64/fp/za-test.S     |  2 ++
>  tools/testing/selftests/arm64/fp/zt-test.S     |  2 ++
>  5 files changed, 23 insertions(+)

The fpsimd, sve, za and zt tests don't find any errors on my FVP setup
when left running for a while:

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago

