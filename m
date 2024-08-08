Return-Path: <linux-arch+bounces-6112-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E7194B6A3
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 08:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CF81C212BA
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 06:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6C186E24;
	Thu,  8 Aug 2024 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUo65wpZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840D1862B8
	for <linux-arch@vger.kernel.org>; Thu,  8 Aug 2024 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098236; cv=none; b=MYD1PN0/mYZx7YWAV+UXrjFDSIlDkV3CjCO9fNRLLwe8or1wi0PMT1+KMDPIhlKh82NYZPz7Xc65hh7zv5aMXP6rb5xYtjj9CWCyndFKpjevF6zFAdEWk8o8oHmAv3VEZzFEW/EFY3EAf7cmTrEj7iDzoraJSl9d4AponffKQIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098236; c=relaxed/simple;
	bh=uKqCXjU3OwyQco6s8NZiGRa60Gd+8G0xHDsozU6gM1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kvez2uBv3MGqilv4aB9EeVeeM14vPZ6JmskkKUR62FYh61wAkeMPhn/k7R5HiCbW4FruQiVBo98DswLNd5Ljn1u+TUwfG/r8CNKnqmfjCuBPKTvErOvsa3SmK4lo4nml+qOGiQbg/PHMte/zSjWPIiaUvJGs1d/e2RUoAyx9M6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QUo65wpZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so584532b3a.2
        for <linux-arch@vger.kernel.org>; Wed, 07 Aug 2024 23:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723098234; x=1723703034; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WK8rtcyRr8ddH6sUXU5fxnXTw/gvxfa7lKvESZemSbI=;
        b=QUo65wpZ5EG/+gbWg/6d2zgmY9dnXT+tMlD33MqDxT+VcHFh3+/Qg5FiqEgHNu+2+P
         7JGEtQI8cSyXHqfVpZPZr4RjyBlYg71SFeZgnKwk/HWCzyW0ne3JoAQFTW1AnoJNwgWk
         eWYkUVjnoqr8PtkeMgh153LTm7KXx2Tn0y+Q8kNcP1Fd9CsmFBurE5B8JF18Z8c5lGoQ
         wLRa/358D3sxt7aGLTCsrnmK1uFgUT5dHkPsJGqNWKPvXQcewppyOxmzE5f90CFslytR
         7+5qhyOokdb51ieb1BRm4qFw1+lmtujdiDvYr6ANr4bx6OJ5B3ItM3KBZb2iumLcvHKL
         hdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723098234; x=1723703034;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WK8rtcyRr8ddH6sUXU5fxnXTw/gvxfa7lKvESZemSbI=;
        b=XdfZVBAf/yJ0IdhmxK5xZuP5sSmKL4ctKf81BDfOB135D/5MkF4Q1YKOFxE4e3i6EK
         lySEXqVXCgntC3HYkA45Wg8BGe+xinAeduZK4BVndVpSuHT/ilOqLGvTqKvYT2zxRdlO
         KtG4+RtmPJaJn6GHRT/KrLgTIjPzt0Ib+8tL3RC22insDrpXs1XxQn5qj+lNouU6uF49
         1qE5Gxhm1RUwfTmerwX/x21iuOIg+eG+OT+5EH7hOsCvnkcyLmmcDXW/IXvt1DUyPhD+
         afe+quKFSrx2PKomAXChevcGsRNTHCoYS5ugcRWRJlp1IpHFDtGUINEFGSK0JMgm+mVn
         Sp7A==
X-Forwarded-Encrypted: i=1; AJvYcCWuucHJTA4IRTZm6aB4og40wRutnUa+LgCRJmdJFBCnd9zepKytmSrv/HJxJon2Ax8nHYcAuPc6L2rnvnhsc+cov8XeuZMyMRVIVw==
X-Gm-Message-State: AOJu0YyJaMRhCFFtoSVwSZA1gBkHNroOC8I+nHeso5shVsmOn2/uJhPD
	5f7R8WAXCO7orpRo4u7K0NqncR3yht8dxxpqBtGOWp3EMTaC5cPPGVS4Tzi+R1k=
X-Google-Smtp-Source: AGHT+IFYw3pObWR57BLXtwXu43FaZ7f39AGJpk9DJobImXbFcvJMmOT0vZh2bJKK6Qf6HCB4wbBa5w==
X-Received: by 2002:a05:6a20:7f8a:b0:1c3:ce0f:bfb2 with SMTP id adf61e73a8af0-1c6fcec8890mr851553637.23.1723098234214;
        Wed, 07 Aug 2024 23:23:54 -0700 (PDT)
Received: from localhost ([2804:14c:87d5:5261:ed46:7c69:6cee:3c20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2e89ffsm480393b3a.180.2024.08.07.23.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 23:23:53 -0700 (PDT)
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
Subject: Re: [PATCH v10 38/40] kselftest/arm64: Add a GCS stress test
In-Reply-To: <ZrP-9gHsvVHr2Y5B@finisterre.sirena.org.uk> (Mark Brown's message
	of "Thu, 8 Aug 2024 00:10:46 +0100")
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-38-699e2bd2190b@kernel.org>
	<877ccsdkjp.fsf@linaro.org>
	<ZrP-9gHsvVHr2Y5B@finisterre.sirena.org.uk>
Date: Thu, 08 Aug 2024 03:23:50 -0300
Message-ID: <87y157cz2h.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> On Wed, Aug 07, 2024 at 07:39:54PM -0300, Thiago Jung Bauermann wrote:
> 
>> # # Thread-4870: Failed to enable GCS
>
> which is printed if a basic PR_SET_SHADOW_STACK_STATUS fails immediately
> the program starts executing:
>
> function _start
>         // Run with GCS
>         mov     x0, PR_SET_SHADOW_STACK_STATUS
>         mov     x1, PR_SHADOW_STACK_ENABLE
>         mov     x2, xzr
>         mov     x3, xzr
>         mov     x4, xzr
>         mov     x5, xzr
>         mov     x8, #__NR_prctl
>         svc     #0
>         cbz     x0, 1f
>         puts    "Failed to enable GCS\n"
>         b       abort
>
> the defines for which all seem up to date (and unlikely to fail in
> system or config specific fashions).  What happens if you try to execute
> the gcs-stress-thread binary directly, does strace show anything
> interesting?  If you instrument arch_set_shadow_stack_status() in the
> kernel does it show anything?

Thank you for the pointer. It turned out that I accidentally ran the
selftests binaries from the v9 version instead of the v10 version, and
the gcs-stress-thread binary failed because it was using the old value
for PR_SET_SHADOW_STACK_STATUS.

Using the v10 version of the selftests the gcs-stress test passes. Sorry
for the false alarm.

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago

