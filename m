Return-Path: <linux-arch+bounces-2490-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE9185B0AC
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 03:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87EACB212A9
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 02:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EFD374EB;
	Tue, 20 Feb 2024 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+lMWkv6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A104482D0
	for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2024 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708394547; cv=none; b=faELn5MPhwuPEiZ3wBsLhTkcaoS425MP6YmV328+Nq7ZlaI3npLm+MBUrtjGOC6/DN8vGhsWxtHF2n6n0M2uAJZ4f/Z4Q8qGPwt5v2EW+aBwttLABIbBTYriJIUMTzAxLE3+YycQVweBHxYs1ytxYMemQtDdKAa8/teZgUuB96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708394547; c=relaxed/simple;
	bh=O/nANr4Yzk8b19D8GUBfK+BnFi8jpNxDwVTe5Jj/VYM=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 MIME-Version:Content-Type; b=tSZdvp3NCpEmZ/+dqws/VBFMBSKyMati/zP/UoFqw3TkNR9hVYcaYCLG4cdzQa980HOWxttQYgjephSdT2QjcHOG8f6JE3BMCptFXCvz/g6O0YfKxR90BRmwyF9KRXQWhVYE2gL6dugr0WbZOb3dAQgh6kzJ8ZSs1rz1n/DmyXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y+lMWkv6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so3496797a12.3
        for <linux-arch@vger.kernel.org>; Mon, 19 Feb 2024 18:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708394545; x=1708999345; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=gGuBNyvpaV2ObDTkL/I2kZTcUQ/VEw4s3L6Fk4TZnkY=;
        b=Y+lMWkv6aHQOnSB+VixiDnQgMHw2dRrdq5I+ygBWBshKZ9g2Zt3MeC55WV/ehYAPox
         bZcDtlNAJHtBozzTk2uyxWfD6GMD1qGcjsH79PRVZSOrx1g8nY3QQ8w80MwgZCouiKBx
         E8+tojwW4Sb7wRK5INTS+Rt3AHiXWBHVc+IBC0+0kREzbjXm8X4vUE4In348Uv/2fvkH
         82XGPw9uGkgJXc83AGvpgm0+Ke1FB8gLll9f58c3gFXEjBRParltSfEYVoN0K/fXmk1G
         yfxkD++xKRDeJWDzvmCagA+nukDUrLC94rI/VmSQdjdXA7MO4seGGLAHMiDz8q29fv6F
         kezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708394545; x=1708999345;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGuBNyvpaV2ObDTkL/I2kZTcUQ/VEw4s3L6Fk4TZnkY=;
        b=FdePzjKNIRqFHvSjaBDwPzGgbSC58tRKKwybg9LUYsTUD8GK+HYUulLietxFFvTe37
         NoeRVkkSVzXIgReNI1JLtZGJiT7jK2SvPAApEY7xy1PIFV4MCv9repAXVVSpEtUudW73
         rklyUn6Wi55cpdO5hmhIsK3Kuh0B6oO8iRgtal5N5tRwcQ7XcvaQ0MnB5A5wPRTUCEIT
         U26Dhy9AhPI2i4sGQ//BqEUXWqTnKYMdeosK344NYxX7tMGS56HDpYSjycW+Pbn3lJIb
         G9C1eRyhVRg+DASHmmqoaBbnnejBEnV0CkchAxh5aJtTb3H6CadaQNDPBZ8yJOUr7YsJ
         YZ1w==
X-Forwarded-Encrypted: i=1; AJvYcCVU5iIL18VkfUQhRTquAZntOcOYA+QcirtUxf1svcvLhYPMJr0W8DI+w1Mp0P0Kk+HG7xPM+R9CsYF2APWkqPMCVqKVjUiOXxrgoA==
X-Gm-Message-State: AOJu0Yzb3NRriVO6C9JmQyCuofh6t+JnNxu6h+1J3jI5gNuBuQL2dTLc
	rKGLHyldd+4raaGV0AwROQ/KhKkg6hOCv/JUedHqgrZTkwZxttF1M9+VKU05Ma4=
X-Google-Smtp-Source: AGHT+IF+n0ZLGWj8WZb6XJ83RSBfvZlmkL20FWmLTPsaWPlBrtsNjb413QMtpYGMBguWkAb2CMTxlg==
X-Received: by 2002:a05:6a20:354c:b0:19c:8d73:721e with SMTP id f12-20020a056a20354c00b0019c8d73721emr9670649pze.36.1708394545367;
        Mon, 19 Feb 2024 18:02:25 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:a328:9cae:8aed:4821])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090a948800b00299354e8828sm5949155pjo.51.2024.02.19.18.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 18:02:24 -0800 (PST)
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <20240203-arm64-gcs-v8-20-c9fec77673ef@kernel.org>
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
Subject: Re: [PATCH v8 20/38] arm64/gcs: Ensure that new threads have a GCS
In-reply-to: <20240203-arm64-gcs-v8-20-c9fec77673ef@kernel.org>
Date: Mon, 19 Feb 2024 23:02:22 -0300
Message-ID: <874je399ld.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Mark Brown <broonie@kernel.org> writes:

> When a new thread is created by a thread with GCS enabled the GCS needs
> to be specified along with the regular stack.  clone3() has been
> extended to support this case, allowing userspace to explicitly specify
> the size and location of the GCS.  The specified GCS must have a valid
> GCS token at the top of the stack, as though userspace were pivoting to
> the new GCS.  This will be consumed on use.  At present we do not
> atomically consume the token, this will be addressed in a future
> revision.
>
> Unfortunately plain clone() is not extensible and existing clone3()
> users will not specify a stack so all existing code would be broken if
> we mandated specifying the stack explicitly.  For compatibility with
> these cases and also x86 (which did not initially implement clone3()
> support for shadow stacks) if no GCS is specified we will allocate one
> thread so when a thread is created which has GCS enabled allocate one
  ~~~~~~

This "thread" seems extraneous in the sentence. Remove it?

> for it.  We follow the extensively discussed x86 implementation and
> allocate min(RLIMIT_STACK, 4G).  Since the GCS only stores the call

Isn't it min(RLIMIT_STACK/2, 2G), as seen in gcs_size()? If true, this
size should also be fixed in Documentation/arch/arm64/gcs.rst.

> stack and not any variables this should be more than sufficient for most
> applications.
>
> GCSs allocated via this mechanism then it will be freed when the thread
> exits, those explicitly configured by the user will not.

I'm not sure I parsed this sentence correctly. Is it missing an "If" at
the beginning?

> +unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
> +				     const struct kernel_clone_args *args)
> +{
> +	unsigned long addr, size, gcspr_el0;
> +
> +	/* If the user specified a GCS use it. */
> +	if (args->shadow_stack_size) {
> +		if (!system_supports_gcs())
> +			return (unsigned long)ERR_PTR(-EINVAL);
> +
> +		addr = args->shadow_stack;
> +		size = args->shadow_stack_size;
> +
> +		/*
> +		 * There should be a token, there might be an end of
> +		 * stack marker.
> +		 */
> +		gcspr_el0 = addr + size - (2 * sizeof(u64));
> +		if (!gcs_consume_token(tsk, gcspr_el0)) {

Should this code validate the end of stack marker? Or doesn't it matter
whether the marker is correct or not?

> +			gcspr_el0 += sizeof(u64);
> +			if (!gcs_consume_token(tsk, gcspr_el0))
> +				return (unsigned long)ERR_PTR(-EINVAL);
> +		}
> +
> +		/* Userspace is responsible for unmapping */
> +		tsk->thread.gcspr_el0 = gcspr_el0 + sizeof(u64);
> +	} else {

-- 
Thiago

