Return-Path: <linux-arch+bounces-9842-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D21EA18301
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 18:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7FF7A1C4F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 17:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6731F5411;
	Tue, 21 Jan 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/Vhel2a"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0561F5409
	for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2025 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480980; cv=none; b=rMV5dPk8K2uoeyLH+lq6957SsjA/7MDGajG2nIz9/8+I2DivxzRGZsSpo622m7xjjDY15W1xF14RyXKB+C1pGT722sN0TCBZyt6s+QbZ0SPoq7qV5ORLFhdug+1Jv+k9cylrrvtX9wrFSn/+Dc8WkO3+oIsF8t6lVxnPNG6yqs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480980; c=relaxed/simple;
	bh=kaibDFjXomFyHzSXXuoRTyzvHOyGuhRdxpJB+5UfQyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wb6EePhHoUSP/Ay7e1hUaem3y4YkTRY775G1H0q+vUcskbUCjPAREVRziABHUTXcz08FnKb2D9vy17QpUY1bswZTi3cyq741ZxLRwR4cMjVbjshJQjgleUkOEs4Lr/F9RlLqyjQSF4sN2XBjgxQ5SaTagACwVYjmnopm3iTBODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F/Vhel2a; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467abce2ef9so911cf.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2025 09:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737480977; x=1738085777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYocvZzKFXOf1dOmFr+W1pL8HyxuFiKuumlmBUt/QYE=;
        b=F/Vhel2a4JdCp5+3jQZ5LDRl3f7qUJmoJMlduvi05UuTxncIR2J6W3Wk3GX7X2Iq+M
         pBSgDTFN5AprxEmuJJAizaASJfwfj0Wy0/LRlys1UKFDX+RSvb7X3wPDL3F9NWv7jung
         IkKu7PCm9d4sBWDx298iMWfU/kdAPgkeDjBg6IFF3ZvX+3RsrLP0IHhwkuzDznCO4GQM
         VBwjCoD+Ipk+IjHc6MnUOf44gNZBkE1f7aSlcXlBP9Yk9lqKP4vYMV5iScOaNUN2ChmH
         myBml8tWnS0I65WfWQIFCU0FkrsTiQd/tw9ggGKtZAO2vqaOAo85vwPnTAPt58w4uEnN
         nSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737480977; x=1738085777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYocvZzKFXOf1dOmFr+W1pL8HyxuFiKuumlmBUt/QYE=;
        b=BBw4T4+T/3LnfWdfRAtwzPJpGElD2HMlti5lSxJdhNzG6w6jDtlwUuE2nqZAgKurx7
         iceDyvIjJ4BE4MRQwJamH4nIPQ6AIHCh322OQdTDNB6+bwP/zUwkhTG2oLZs1skYXbGa
         oWiRPjXgvyX5ILNxws1QLxesKt/I/3zKzc43spMu22nuLNZm6MrEfG73d1AowAuoYg4o
         An43o0fgRGUU+6WM5UpstIW+FBXAcCOCDuowY8cYMTN51YtaMuN7u+HD9mYz+p3R6rUC
         1Gsy7H56EJVp9Yhmy+V+DpAiGLVPgNsY9N26lP34h62Qs+tppiSIVXVwUsHIx84PHPqb
         7wwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyH3vWM7jCwcXiTYcvj+eeslpNwNf8pNAoMPIE5bOSbJn4VjvctntUaNw7ySsgJwQhm9iNykVNk/Dr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05LWDvTZeBRXzbkLbIzgJGnBN+8Nf/Ir6jN6KoqquMaJm1Ece
	o86qi8yE9/gNX5HOwWPjQ7dB26XCHchwm+yyOrrq7fJY7Dx7lWQ537tDHZsKFZ0jwatgOu6bMz9
	eI3PXa10d+JKNxreDHqjScwNgU58Pdd40G9fS
X-Gm-Gg: ASbGncuXv78fNsuPxuPeYpDtZgc74X7/kZRa9rgU4i7m+tMieV8U1LaWkQ6VY0aH+f3
	r1H9DYkVukZqayuE2Ls40HVdfuCdNPg858DRJctiBchfOo8Ew/lHxPnZlw+dYudIgFZ70ySmOaQ
	mAzfLopA==
X-Google-Smtp-Source: AGHT+IFIrZRx7xQrWDRLQ69FuUYdW0SvjjzhrnjhSnOksbO+ngHVevTnFyfppx3QzIQZhDwNLsCaUtTO2x0P8LdfKLw=
X-Received: by 2002:a05:622a:1e10:b0:466:7926:c69 with SMTP id
 d75a77b69052e-46e1fc28582mr12795651cf.20.1737480977190; Tue, 21 Jan 2025
 09:36:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120212839.1675696-1-arnd@kernel.org> <CAK7LNASo+wGhpCVhBi+ew1mOtLbSXgx3AiQ6D7RtXO5P=R0EfQ@mail.gmail.com>
 <fef7c633-5577-4cdf-803a-a1fe10787186@app.fastmail.com>
In-Reply-To: <fef7c633-5577-4cdf-803a-a1fe10787186@app.fastmail.com>
From: Rong Xu <xur@google.com>
Date: Tue, 21 Jan 2025 09:36:04 -0800
X-Gm-Features: AWEUYZnEsgcuCWBwvZBjbUeXp_Ck0mg61w9DJwmvH6xjwQ8ss7VEyk3ZAuur6X4
Message-ID: <CAF1bQ=Qk7pRWUxAcZNPjFquukHpXgi=34NmMbuRBAwv5+KcWtQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC, DO NOT APPLY] vmlinux.lds: revert link speed regression
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Han Shen <shenhan@google.com>, Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 11:42=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Tue, Jan 21, 2025, at 01:19, Masahiro Yamada wrote:
> > On Tue, Jan 21, 2025 at 6:29=E2=80=AFAM Arnd Bergmann <arnd@kernel.org>=
 wrote:
> >>
> >>                 linux-6.12      linux-6.13
> >> ld.lld v20      1.2s            1.2s
> >> ld.bfd v2.36    3.2s            5.2s
> >> ld.bfd v2.39    59s             388s
> >>
> >
> > Is this problem specific to the BFD linker from binutils?
>
> I only tried the bfd and lld linkers, but I assume it's limited
> to the bfd one.
>
> > Did you observe a link speed regression with LLVM=3D1 build?
>
> No, the ld.lld line above is what I see with LLVM=3D1, it's
> very fast (1.2s) both before and after the change. New
> ld.bfd versions were much slower before the regression
> for this particular config and got even slower (seven minutes
> for each of the three vmlinux link stages).
>

Can you send me the instructions to reproduce?
I'm seeing a significant performance drop (18.5x slow down) with
ld.bfd v2.39 when
linking linux-6.12 (i.e without this change)

I will take a look at ld.bfd. It looks like an ld.bfd issue.

-Rong

>       Arnd

