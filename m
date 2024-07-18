Return-Path: <linux-arch+bounces-5506-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7579370EA
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 01:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C04A1C20D38
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 23:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD9E146595;
	Thu, 18 Jul 2024 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+PBN2aR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD61442FF
	for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343827; cv=none; b=nCAZIN9pfxxgimIspBTtPsO3ENROZt1ymi4t9TUg/3TKzg8goJ7f5sN8ULd31DPSDFkNrWb6x9O4JmsMrKPUmtHpE8H/0tzSRJF/rPq92y9Cyg3qBQFcdpN7ljyYFKOzAqVWl88lN6GnXPFru39rXI7AggTPwCeDvuqTc+CCz2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343827; c=relaxed/simple;
	bh=ZlxohWJiVwAqoT9g5IouKqA+eC9Q/GshbQdY1r9is2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QUTaCRY/Jkzfzug/XzOXMd+yTi1jC+McGFwjeqOVhdMocHmPmmJJNDT0NbrfVsC/H5DEDOwJAX18KWs1yoSUODM1hkKGW/xvpx1PIJDgud/WdkyaoR3or2Knn3Vd50+6+535CxBcNOXw9kQViAzs+1PmRCsOJYglc4j0HJPyab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W+PBN2aR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb0d88fdc8so8447565ad.2
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 16:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721343825; x=1721948625; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pz/gqH3g6k+Tlg5PlSG754DQsZEyo/RAObvbOwwmn1M=;
        b=W+PBN2aRA4gn0ZHLHAD3l3+rtcOMqbNhBblqTH10seGmxKXSIM/gdGXfqr2NJVCcC/
         /TRUnWk77f+K+ZVvbKkg5rquOwN0y4TxqeXNA9O8k3pMEkNdRvodmtYyGgs5bqbfHHKT
         2t3c5ue9lwf4FtZA9w8GcIYkJ6AmWgHfOERhM2n4M9l5xieCZQyGj3ewMRYI9DFIGgHJ
         6ntB6euLzI6KsDTQpIE2oCqhqxJ9U3gPRfQLOIU3b3ssX+Wk2/+/BBL6/+mi99YQDj4R
         CAF9uFTz47IQVvxL0BvqD98C9SgIk8j21PmbrDDJccOIFbGzRc+PXxLHLsIVj+HWENAZ
         8JnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721343825; x=1721948625;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pz/gqH3g6k+Tlg5PlSG754DQsZEyo/RAObvbOwwmn1M=;
        b=BMX81H814HquA6ZxmjKoYjTsnuqLXtwgLnxq1QK5yiSpDxH3LSwVBuyWZjRzZoF6M4
         6sFxhAaxMp6tkZvOF5Tg9g8euzH942WaNQS0axcHMOp/7zfS5z0Q8A3Wpo/u8lC/Le2E
         kIpMQIWNWB0G2ym8zCeWZ+ApXQeMTDfu8rizpWKdijser4pQ9szEz/H0zoFIOMWWEtdu
         LXPZml85gzw0q9Ebo4LdZiEgvEDl0cgMCOU+oTR/fBMfI0DB5YovHoJkPubI6gfGM/fB
         4F6+tsRG6QyvwcKsnLXTUbGannOXJIlgl5uiiRDZCr9E0P2I0vJ9OTYVHu8tJOohCrDL
         etzw==
X-Forwarded-Encrypted: i=1; AJvYcCWNnpATYkswgyCRzBf1p02BNfAXWcEQKYcvMGpYTMBNHkPw3fWrZAcEr5+bFH44YRbUrOMyQvNAypTKd+woQW0qhjOQoKqZg/gR3A==
X-Gm-Message-State: AOJu0Yy0aw34fXadwC5Jv4hCES1hWA2GM1J9Vsn/QUvGase0rJ44Yi6t
	z8iC9O8cPnlRUFiOfJunPIL3PbS1o+s/Vr8yCk90GABZhnNh6WVmQXMmgwYaWOk=
X-Google-Smtp-Source: AGHT+IF1+3P0pRgwkXsR0FAWIIytKywrIML3Fqxwpp1fn6IdRgXx4TsuO6HiuiBf9bLph6vSY6g+qA==
X-Received: by 2002:a17:902:d48d:b0:1fb:24ea:fe02 with SMTP id d9443c01a7336-1fc4e16ab7emr52140735ad.18.1721343825147;
        Thu, 18 Jul 2024 16:03:45 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:15c8:3512:f33c:2f80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64b8693asm1105435ad.72.2024.07.18.16.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:03:44 -0700 (PDT)
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
Subject: Re: [PATCH v9 37/39] kselftest/arm64: Add GCS signal tests
In-Reply-To: <20240625-arm64-gcs-v9-37-0f634469b8f0@kernel.org> (Mark Brown's
	message of "Tue, 25 Jun 2024 15:58:05 +0100")
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
	<20240625-arm64-gcs-v9-37-0f634469b8f0@kernel.org>
Date: Thu, 18 Jul 2024 20:03:41 -0300
Message-ID: <87a5iexpyq.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> Do some testing of the signal handling for GCS, checking that a GCS
> frame has the expected information in it and that the expected signals
> are delivered with invalid operations.
>
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/signal/.gitignore    |  1 +
>  .../selftests/arm64/signal/test_signals_utils.h    | 10 +++
>  .../arm64/signal/testcases/gcs_exception_fault.c   | 62 +++++++++++++++
>  .../selftests/arm64/signal/testcases/gcs_frame.c   | 88 ++++++++++++++++++++++
>  .../arm64/signal/testcases/gcs_write_fault.c       | 67 ++++++++++++++++
>  5 files changed, 228 insertions(+)

The gcs_write_fault test fails for me, even without THP:

$ sudo ./run_kselftest.sh -t arm64:gcs_write_fault
TAP version 13
1..1
# timeout set to 45
# selftests: arm64: gcs_write_fault
# # GCS write fault :: Normal writes to a GCS segfault
# Registered handlers for all signals.
# Detected MINSTKSIGSZ:4720
# Required Features: [ GCS ] supported
# Incompatible Features: [] absent
# Testcase initialized.
# Read value 0x0
# SIG_OK -- SP:0xFFFFCF1292D0  si_addr@:0xffffba645000  si_code:10  token@:(nil)  offset:-281473808879616
# si_code != SEGV_ACCERR...test is probably broken!
# -- RX UNEXPECTED SIGNAL: 6 code -6 address 0xf76
# ==>> completed. FAIL(0)
not ok 1 selftests: arm64: gcs_write_fault # exit=1

It also generates an "INVALID GCS" line in dmesg.

-- 
Thiago

