Return-Path: <linux-arch+bounces-5792-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690229437F3
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 23:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BC41C24499
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 21:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766B516C876;
	Wed, 31 Jul 2024 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BabB0a/a"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3D161B43
	for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461165; cv=none; b=m942RK7iO8CdQ62wtzu7ghwqqrmU9gp698hcqpVEF0AXY9d3HaLMUJyYMRXCCL890ThcqLn7/ASExrBCMRWdiYLNILbYxjieXPOIxv2Eun8j7vIHFiSjMMMuZ+AGr5tKaGduzb7yUP2Mx6JNpsjtH63utUcwHFfhYgAMLg+G18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461165; c=relaxed/simple;
	bh=YzqqHah0Kpz3UbF2fztwMnEVk3VdHYrzvKgv3Lijiuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BY9jI3IDEGv55lDimy7YRTMGohwhQaEIckqG//wleGkyWnO/bkdUNDXiwc5EkiBIfpxAg7SC36PuuVUGaVWLMe0Dar7M4QhAZW0n6UiNTw9guF7kHZ2LeK11atobnWnrVx8PzbwL++3Pb3aaboRtCgH4cwKKTWjg2ZoZmZ77j2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BabB0a/a; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso92415231fa.0
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722461162; x=1723065962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MGjVAGa4JRMfmw8pQbwqMF8JcxKRovPXiCHMReymGtc=;
        b=BabB0a/aONdksS6sZLDd3WMjgSACJ1gXvlokJFvVIoi+wityWJU6GtiCqB8tzKjU0m
         OL7/FnJ5YAmQMKL8DWw3nyz5t7uZWSMoGVjyMMb274Ew7t7Wat56ix13aB06waoHc0rD
         ROZLAreff1Af06sGG0p9fS8cdAo9l9vlWhkQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722461162; x=1723065962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGjVAGa4JRMfmw8pQbwqMF8JcxKRovPXiCHMReymGtc=;
        b=oQH6cvwkMTeyMhhLUsFDPMdAdKHVciLMcPxxs3IaLhfDifLc/yy2WXKHHXuNV7o2Io
         gSlA5hJ9y1HTtKloeTZzUn9qhz7zDgAntApepB8Xy7La3Sy3L3/izRDSRZx1DOrV7coO
         rOXGZHVuE4iMjTGQQbxFiTf5Qn+lz1eIPL850guySjvFqe/nkLWDrDEuZINsa5zjRshM
         BhVt2gSeC9F/9NTKNxGsTez+UZBNaufoS+XsgD7oHA6+pPaEFNb7/IHwNRXUP47S9Otc
         Qn8iPTID6fA1xdeR8MwGPU9T5U9qqUqEg7SQzwy7rLDZ5F6GkKpFEoPUkedU/+rCrjcc
         aXuA==
X-Forwarded-Encrypted: i=1; AJvYcCW7UI2qFIn3z50/lTbLLHOw9Z48GZKaeneFDGtqfVSVh20SBGgRyLDvHedQfgo8O1hdFvq3uMObdn2vEkEvhIQcbrz9aafekEEstA==
X-Gm-Message-State: AOJu0YzEzYPmXYP9l3bQbRugcG5E/c23XSdlxCRjkWOCTAlFbrRFDgGT
	rc+E1Uq9qecCP7ppP+HjgTl3smDxtJXrlFPNlMboBcYvudlLAxs+fLS3g+9tFGD+9mf7qdzj+Jp
	s7HLwvA==
X-Google-Smtp-Source: AGHT+IEqDFwAEEgLoPqjlaCY255ZSfoshMY4i+wrEb14grIXshaZC9oS1OHs8rUJdmJeWRXQq1ArXw==
X-Received: by 2002:a2e:9019:0:b0:2ef:22ef:a24a with SMTP id 38308e7fff4ca-2f153399704mr4608521fa.31.1722461161573;
        Wed, 31 Jul 2024 14:26:01 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de90sm807196266b.62.2024.07.31.14.26.00
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 14:26:01 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34431so4934066a12.0
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 14:26:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyyoUKzY6Tb7gx27Sw+XVQsEqvUb+7XYNvoFmqdpIRwHN5DUEynM+tN6hBQrV5YoyqB+5MyhJMMQ8Q0QdThue/wJg64gsZJQA9Ug==
X-Received: by 2002:a05:6402:a41:b0:5a1:2ce9:f416 with SMTP id
 4fb4d7f45d1cf-5b700f83fc8mr263651a12.37.1722461160632; Wed, 31 Jul 2024
 14:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
In-Reply-To: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jul 2024 14:25:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjB621UfJiUBVU+FuiuzL=_Nhv60moO=_2F0YWmRq6+VA@mail.gmail.com>
Message-ID: <CAHk-=wjB621UfJiUBVU+FuiuzL=_Nhv60moO=_2F0YWmRq6+VA@mail.gmail.com>
Subject: Re: [PATCH] runtime constants: move list of constants to vmlinux.lds.h
To: Jann Horn <jannh@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 13:15, Jann Horn <jannh@google.com> wrote:
>
> Refactor the list of constant variables into a macro.
> This should make it easier to add more constants in the future.

LGTM too.

          Linus

