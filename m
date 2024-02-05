Return-Path: <linux-arch+bounces-2091-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9645B849B05
	for <lists+linux-arch@lfdr.de>; Mon,  5 Feb 2024 13:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E4F281763
	for <lists+linux-arch@lfdr.de>; Mon,  5 Feb 2024 12:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF02481D3;
	Mon,  5 Feb 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mfp/C/w0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9522D04E
	for <linux-arch@vger.kernel.org>; Mon,  5 Feb 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137291; cv=none; b=PfQDxs5zHpE8RZ2SbbJQ0Nyehstz9izgbHGDYzUa6VI2kcpEgf/bXXi1QyCwnE53+h6ED3uDMSJoHIapZJAZ1IGDprf5xPgRKod2dT7w/0FikzgLr9AsWM1j8GaLhzYmjg0nIpE/9UvWO1ASkwWPEp9tSV0n+/cw3UzYw94VPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137291; c=relaxed/simple;
	bh=hMQsxleb2DgLiOtL+XcLnQPzsO2TotOD/Pmi3+oKloU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6sv0bpm3/uqeLSC882oaL6adC36Rnbv/hB2y/AFkoJ5hTt7urGgWAaphMvPaiYBikrkXAd/GbXdjBLaCHF8ncvMJQ/NlrcpojXxRx3mTFLOT7wpGbg5nlMUdIlX9oiwAQqvWKD1QSNzsS+t9YaeNayJoqgjpFZiHy7zU4vssbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mfp/C/w0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d7881b1843so38087975ad.3
        for <linux-arch@vger.kernel.org>; Mon, 05 Feb 2024 04:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707137289; x=1707742089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jp4Q5U+zIlzWB/BXVKcZBw8dz1qw2kebfH71OdMWBLA=;
        b=mfp/C/w0RUq0WdHImmd1e5PIByl8SjgLcocSUhdGKfJiLLA+Ej7uC5hh/b3uRhczvu
         HrZQmgZu+7H6Rb3L3SiEI8GKfAM1wIU6MTYMj2kfvrhxWvDOsH+bLufs2C1T4ajflRdl
         6vmu4EWt5mfJdSJChg1xgzRCt4aedwf9PI3cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137289; x=1707742089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp4Q5U+zIlzWB/BXVKcZBw8dz1qw2kebfH71OdMWBLA=;
        b=b2eE+El+YqlGlcRksDxMItp5Ukg5wrnz2nCO2BkgGDU6ftX7kFDB9I0udAlp4TLDAf
         EuS/AlGEjynwC9Rt/3+yFmylA8kVAja4NLVya97rVNQprG6ngvI8DdLA57jESvI4yi2Y
         ISh7D362laD5dvQG2kOya5QeegaJRDX8T2Jj5upvY6oWxCG+WmjDHnOTLQ/pkdQIFO0F
         uZQ5JO7UG1KrM0qVlzqKFVtHk9QT1FGT/NhRGslHPgtlJmqBAPQsir5Wr9V4rXWfJSzZ
         OdVQuMlFLIyy+guBhlAnNg3lJ80En/VrKpgLEgLKvIzzrupTbtvl+0L+kW+4vWFkUdop
         rlBQ==
X-Gm-Message-State: AOJu0YxKi6Cfkx0RvEsVsya0Rl6zRpPpslBuS1JFS4BlHWGKGAbB7Eyh
	ncrEvkpHWuD8a6RWn2eY+uSoyr0/LbRkATYCB78UPTWgq5GZCBjRVjvA4EQ17A==
X-Google-Smtp-Source: AGHT+IHYbwF4AZxr+BIBzkFZlJurA2gYc1bK0rKQHMh9C8dej+7vIsMA2pXzfcqyntpLUgE85vHpwA==
X-Received: by 2002:a17:902:650c:b0:1d7:5943:21b8 with SMTP id b12-20020a170902650c00b001d7594321b8mr10194131plk.16.1707137289454;
        Mon, 05 Feb 2024 04:48:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUtCqunCXxFNFT2rH8Qo2NHg52HZy+4Sa2MQq2EyuiWJcNqHwBIykWLL0u4UqEOMaCvzCtpjJoWSPJUbo7DhzhZ89KO+u16Y1JBm7o5562Gp5pgdhGCm8ufKd7vcjieySULkIG/nzq0GkLQsstXEXl735jvLqddCGKwuHrNHkKp5ZiLBWIes7Vokht2n+r5MJeiPbiSiASXCuBhAAgdrAVebtCTsIVjqdKCwkMRQMYSwJsF6A0+Iz1F5wUcBFMa1Nqw08Pqw1euJtfaGsVLoDWOyTvqaNfiTKMjqmL/vrlUN5In9PeXNXXyH69zZaeBBLX2H/QFEFDCWpg/TUy18gJVkR0z9HhIcZhfZ7GxZndTXSPRoqSjSaq21UcPhGN2Z3TPQSo=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b001d8f99e4737sm6318404plb.49.2024.02.05.04.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:48:08 -0800 (PST)
Date: Mon, 5 Feb 2024 04:48:08 -0800
From: Kees Cook <keescook@chromium.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH v4] ELF: AT_PAGE_SHIFT_MASK -- supply userspace with
 available page shifts
Message-ID: <202402050445.0331B94A73@keescook>
References: <ecb049aa-bcac-45c7-bbb1-4612d094935a@p183>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb049aa-bcac-45c7-bbb1-4612d094935a@p183>

On Mon, Feb 05, 2024 at 12:51:43PM +0300, Alexey Dobriyan wrote:
> +#define ARCH_AT_PAGE_SHIFT_MASK					\
> +	do {							\
> +		u32 val = 1 << 12;				\
> +		if (boot_cpu_has(X86_FEATURE_PSE)) {		\
> +			val |= 1 << 21;				\
> +		}						\
> +		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {	\
> +			val |= 1 << 30;				\
> +		}						\

Can we use something besides literal "12", "21", and "30" values here?

-Kees

-- 
Kees Cook

