Return-Path: <linux-arch+bounces-10611-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7777A5969B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 14:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53B53A58CB
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1131D22A7F3;
	Mon, 10 Mar 2025 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiL87QdQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE971DE2A7;
	Mon, 10 Mar 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614334; cv=none; b=Qc+QrOMKx7Ctj4StdFBRT8K0GwtoI7hmam/+CfaJiV1uf2GE2EBu4rsGaxs2/ILqPVxDeUDWuHB9KAsTs6YCC+2QHHTwA+Bup6CdIPgOz8SMIdq+WAjdUbaJPXu2kH5yROoiIXt6sYA80VBFaDc/rov3GLicV+MTp8DNYwFgzQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614334; c=relaxed/simple;
	bh=PrA7rfUbhe2Pewgr5X93FRTG1RoQPZ5lbvHmNEd0rGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogdNTOSqAIIhRGX4t6AC2yn+iID3HHxcNWkqx6lbVOP/nR/WVDphdCMqn3+e5w7TuKV+iBvBm3bVDnnX513BLQmvXWPG2QNhigwNuFAAhMarMf3j3mHK51y5EcmhTePfyn4qmK1sGqNKIJWYDMHt8dDmp1wSrmI7Qij3tCLYUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiL87QdQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac29af3382dso173052366b.2;
        Mon, 10 Mar 2025 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741614332; x=1742219132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrA7rfUbhe2Pewgr5X93FRTG1RoQPZ5lbvHmNEd0rGI=;
        b=TiL87QdQA8T2KDkVYR2rW7FMa9E3oJgTotd+yIw22oQeOVOu10GtGug+WFh0Oc5BT0
         WW3v9QQYSHa5hcLgG8gh5kmTFAL8DQoYTWOC8btw1P+YQ7n+PI24ha/zRnzYqJxMuWP5
         dN0XlGbtBJI9gwGmuNU1Xw4x6ZyvS7jukYzD40iIbAFuYptEi/BENwwnvxoInFl2yoqU
         ENcDUuX8lvkSUBANUVw8MRKVvWD9a+b8Ce64HK7/M921lmPiC9n0VtIUmwUM7AU0Mps1
         zVnOEkNTIRsHAMGpjQAXHvv3Bh6OQZ11gvbZy1WTZURM/LgwLmfIZglbDtQwr+pbgbqu
         wnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741614332; x=1742219132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrA7rfUbhe2Pewgr5X93FRTG1RoQPZ5lbvHmNEd0rGI=;
        b=dcla2kofDi2RvabvyrXRYkWNuGwhd1XFq1tRGizTeJK2ueQWeAbCuudolToQHZdiiG
         P2gelUeT0xS211EaCzl2DMvbDaly+wAkQTYCwDahOk4eCGiOk1DYMhvA4J/1A3aJdfY/
         BjstTNTHvfla8rMfLAesQLv8TxkCmTjv6PVdMg4w/qqCFathVSzBAZUUxXs3sNzJS2FS
         a54OjYn6JnCmKxINQcBoNdZCFHKw/6Sp0+dVcIgWmWHvf5W24ALHjuKgKF29FOe7DqBP
         eIdVgujyBo5Lw/63Q1ch6flA2xRUg3HOZi6KbcxJr+p0VR2xzu7upplwKcft5zrL9+kk
         OJ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCULLcCys8FubU4IvD+ajt1p2+mra3PLqDi2ag/4wJRTeRwOicBMmKMHylu+4el9hd8G5r221sJNHY8u@vger.kernel.org, AJvYcCUzAmCg9Xm2DhGcfBXyhjNDI9KBaeTCNWFpM2SfsNEEzwf7s64WTvv7gdHxGGasRIQUkQ7zeI1rhvbyMMy2@vger.kernel.org, AJvYcCV/GLJxbWPciT+UfwE9uxBqWBiTiInuz5Ju8VXCKCiSDcaJfA56tg5A77xmMUDICjpqfDEIErkVjxXwfqjY@vger.kernel.org, AJvYcCWPT47fXmZ29V6UDxQAMEMNTOE+eZ3qAhaS1HyeF5A8ig/gr0F2Pm/bLeK1CD/B+4hYsAWM7ys4RuC9fA==@vger.kernel.org, AJvYcCXMFOxm1IQ4/q9Ev17NaLbWpkNYKV6hOWJh56V1pDUYnKTxQiMefSRqlwbZziJ6iBSxYzOIp3VwhOb8TQ==@vger.kernel.org, AJvYcCXhay8Hw2c/hDFmL0EDkHpKTyhWSmp++/W03L6XbYAKenUn0nIuZq7vTqTRarQr2goDlYaArQf/+8FF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6EDLBRZlgruV83NIYhnRUwDXy6teEX720TU5Ur2yD4Q6qmfAi
	71WSAN06Hmnhf1AT95iBYRo9eFKjTWW3HcvpH7ikXq8txFhQSSvlEuv98l4Isxt4krTxHSABQHM
	TLvjiekGGf9WY5CYU+JBasfW7LQogT92O8mY=
X-Gm-Gg: ASbGncu7uLEipZJ+QTXSJqic/do4hiHVE+lIhY0Hs7qW+94eY8m0bOf/6+96MWVr2ED
	I2LjgqTvnGnCecIY1A7ddO71UPKi1ed4X8ARMt4uYhDr23C0uSVxTISQ9BnNJSBrLMfXELae4ld
	l87vwHQZJWKSZURBQGAolf6rGf0lmSBRc6i3BklK7Tc1VVCDPRCq1PYMM=
X-Google-Smtp-Source: AGHT+IFrlV+UOZmk75f6ffZGqWNA8kEVBO9qwi1sfylUDo7SOrHnrhelQqcwKfQa9tx5Jczcf/SvJhuAPzOyWJApbV0=
X-Received: by 2002:a17:906:33db:b0:ac2:7b8a:7a24 with SMTP id
 a640c23a62f3a-ac27b8aa77emr821669466b.3.1741614331525; Mon, 10 Mar 2025
 06:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307220304.247725-1-romank@linux.microsoft.com> <20250307220304.247725-5-romank@linux.microsoft.com>
In-Reply-To: <20250307220304.247725-5-romank@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Mon, 10 Mar 2025 21:44:55 +0800
X-Gm-Features: AQ5f1JqLOmSVWjJdyk8kWYqh8Q05Ls-ycUphJL8s1J0KBJmCwQzJ1qeS4exHJxg
Message-ID: <CAMvTesC+McATYa-xsi0omJ0LnFUUUooBk_r+oYSHYimyXPz5ZA@mail.gmail.com>
Subject: Re: [PATCH hyperv-next v5 04/11] Drivers: hv: Provide arch-neutral
 implementation of get_vtl()
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com, 
	conor+dt@kernel.org, dave.hansen@linux.intel.com, decui@microsoft.com, 
	haiyangz@microsoft.com, hpa@zytor.com, joey.gouly@arm.com, krzk+dt@kernel.org, 
	kw@linux.com, kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org, 
	manivannan.sadhasivam@linaro.org, mark.rutland@arm.com, maz@kernel.org, 
	mingo@redhat.com, oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org, 
	ssengar@linux.microsoft.com, sudeep.holla@arm.com, suzuki.poulose@arm.com, 
	tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org, yuzenghui@huawei.com, 
	devicetree@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, 
	apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com, 
	sunilmut@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 6:04=E2=80=AFAM Roman Kisel <romank@linux.microsoft.=
com> wrote:
>
> To run in the VTL mode, Hyper-V drivers have to know what
> VTL the system boots in, and the arm64/hyperv code does not
> have the means to compute that.
>
> Refactor the code to hoist the function that detects VTL,
> make it arch-neutral to be able to employ it to get the VTL
> on arm64.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
Reviewed-by: Tianyu Lan <tiala@microsoft.com>

--=20
Thanks
Tianyu Lan

