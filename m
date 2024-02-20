Return-Path: <linux-arch+bounces-2491-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B188A85B0B3
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 03:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4FB283F5C
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 02:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0859C3E489;
	Tue, 20 Feb 2024 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Suls8slr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300F38F97
	for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2024 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708394630; cv=none; b=NkuiFlGadQPNhznrtEv0olHfC2xf3BmzS/Vfl4ipTYUywFpARJpBuZ1iYv3HV/jJZDGnXcKJBCGQ9KdaoixOGI3tcT+DvExh7FkuDICqP6RAXmqmTZIVbQirUok2VlrT+/zZyl3QUeSBCZpHOGCs26A6De+qfAoP9BfyY72OXo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708394630; c=relaxed/simple;
	bh=tl0G24XOjbGzUHwVuSKAML2L5w2w/ukL5jhI0xL8Wbk=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 MIME-Version:Content-Type; b=RBXJzC7aL0vMZayZIpWZLzi0aWuN/0DkqE2YM3bukT6KJTH5GlEFzPux3t10f77kQFxtewbeOJEvv0Xof0q7FeBhoyrydOotFMBQfTT857qyfnOJRbOQSlB7sNmkqSKIeKQCuP/NWLuhTTdanEqNsdXUPFf39LAnU+KNbURIi5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Suls8slr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc0e5b223eso6307775ad.1
        for <linux-arch@vger.kernel.org>; Mon, 19 Feb 2024 18:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708394628; x=1708999428; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut8HYrvCDFac0esrbFqk2cfgA544kkLlPQaAT6Wttz0=;
        b=Suls8slrlKu1GWrkWeiJyMMq8d8OmJjG4HQRDqGKkDxCGvnQXj3NkpLK8YeFHW7jhR
         AAgjw2yso4yD4zEgGmYJfcDHbqiouKzolEOKeB9Hpxwi19d8pL2q8lCXZca3vncoL3SQ
         k1hTGX6ajH2IjdKm0iQkpPvFirt5Q8PlGudv6VB60Whz+Po+CFzEzUCM9fOo5UdvTl46
         /WqgZXqtFBCVds2NvymzgcVNOQjTg/hfB6M8TJj69Kh9PyDrR2Elmf2U9h2Hl0j/gZpQ
         F6wCGVVpNXxcahTQO8wAAuZ+Rk1Z1zsipM4+hqxCKo7TiqlZofPkHZXHt+ViOklVfoLN
         dfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708394628; x=1708999428;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ut8HYrvCDFac0esrbFqk2cfgA544kkLlPQaAT6Wttz0=;
        b=sYtZGHNjrtvmPoQEz4alRCM+W45xYcInOlwSOajSeOdp+kgBjPddRG15737If8ZvV6
         ElcmZlWCRdGuqHWy1jeZ6bptbT6U4h54UeY0nL6w+4o/ZTBj47XeEqUEEB49210Ev57w
         +3EHFfcBSi1v0uCTY5D2lZwAEqOkwG5/iAFDAyhvJZfWaLTFerH04aEmWCGtFUrfMUd0
         CJsSEX1WaGxrGjrYWloE8h2DWQaemZ0xwMPSCejJse7hKMQ5Ylyy6iw6+5njtRLN79EY
         xtKnhgmoyDO7SHbZ+7OZgn2U8lzfjNzkWloIbmiM+WzIZgRtgcuihOvXzSxzPBqJ1yHA
         4Ewg==
X-Forwarded-Encrypted: i=1; AJvYcCWUaP+Gy8Ux33eCh8GqoF/ReSLgc2p9YGKUPdKPsRv4kJ288leqMYdTCMpaZzKt46cPkCQ0+5gNEwTtjqMzq9VWZyBB06AMCSPeJw==
X-Gm-Message-State: AOJu0YwYQ5IlMQha343lE+vs+cgvS5sSSzqGWAm+nxrVuDFzvV0mdTQb
	rEt10/63tQFTMna41gEKZ8LSyoRHU8V776uF1DPYchWdSZdClcfMYQObzsGcPhs=
X-Google-Smtp-Source: AGHT+IGPIHUy8hPqScHiSoGgxRjrCJE9JJnAWETOMrecbYtciaMsbgwu6AZ9cPzFGRlUwvHmQwNF1w==
X-Received: by 2002:a17:902:e5c3:b0:1db:fcc8:7d96 with SMTP id u3-20020a170902e5c300b001dbfcc87d96mr4258933plf.14.1708394628501;
        Mon, 19 Feb 2024 18:03:48 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:a328:9cae:8aed:4821])
        by smtp.gmail.com with ESMTPSA id kg3-20020a170903060300b001dbbd4ee1f6sm5058425plb.11.2024.02.19.18.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 18:03:48 -0800 (PST)
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <20240203-arm64-gcs-v8-23-c9fec77673ef@kernel.org>
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
Subject: Re: [PATCH v8 23/38] arm64/signal: Set up and restore the GCS
 context for signal handlers
In-reply-to: <20240203-arm64-gcs-v8-23-c9fec77673ef@kernel.org>
Date: Mon, 19 Feb 2024 23:03:46 -0300
Message-ID: <87zfvv7uyl.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Mark Brown <broonie@kernel.org> writes:

> +#ifdef CONFIG_ARM64_GCS
> +static int gcs_restore_signal(void)
> +{
> +	u64 gcspr_el0, cap;
> +	int ret;
> +
> +	if (!system_supports_gcs())
> +		return 0;
> +
> +	if (!(current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE))
> +		return 0;
> +
> +	gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);
> +
> +	/*
> +	 * GCSPR_EL0 should be pointing at a capped GCS, read the cap...
> +	 */
> +	gcsb_dsync();
> +	ret = copy_from_user(&cap, (__user void*)gcspr_el0, sizeof(cap));
> +	if (ret)
> +		return -EFAULT;
> +
> +	/*
> +	 * ...then check that the cap is the actual GCS before
> +	 * restoring it.
> +	 */
> +	if (!gcs_signal_cap_valid(gcspr_el0, cap))
> +		return -EINVAL;
> +
> +	/* Invalidate the token to prevent reuse */
> +	put_user_gcs(0, (__user void*)gcspr_el0, &ret);
> +	if (ret != 0)
> +		return -EFAULT;

You had mentioned that "ideally we'd be doing a compare and exchange
here to substitute in a zero". Is a compare and exchange not necessary
anymore, or is it just being left for later? In the latter case, a TODO
or FIXME comment mentioning it would be useful here.

> +
> +	current->thread.gcspr_el0 = gcspr_el0 + sizeof(cap);
> +	write_sysreg_s(current->thread.gcspr_el0, SYS_GCSPR_EL0);
> +
> +	return 0;
> +}

-- 
Thiago

