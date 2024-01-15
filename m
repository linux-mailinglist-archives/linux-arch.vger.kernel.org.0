Return-Path: <linux-arch+bounces-1381-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DB882E40F
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jan 2024 00:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5297E283FEE
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 23:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B79E1B7EA;
	Mon, 15 Jan 2024 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTx61PM0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC4B1B7E0;
	Mon, 15 Jan 2024 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5f093e7c095so10950017b3.1;
        Mon, 15 Jan 2024 15:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705362109; x=1705966909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=li88m9Aw/LCRAibakjpHlPDF8glbTaanlpZnqcTkC3Q=;
        b=mTx61PM0RfW81476w3SxgKhunmpkb+X+BRYdcyxZD0RZrTxtvVNMXfvg8o9D8eYlNY
         5kzmp4o6p1hISU4ISHyk2U458fgCYNDvruavKcBnvdsNv9EYXPmTy8lkDmOBbCKqxLfl
         C9VohKLwJvjO63pPmdw4KjmaQIMGOeefcNarkcUJ1KBlUwP5BROL9kgcHCVN8+QhJ0Bd
         G0F/zrVzlR6IA0Wv3AH2uzLoTmFwmbZ4xzh1jKC+spGfAQzjzUsDdsg9ljOeU3dssjFy
         HA/XXQYZ5YOqd9yIIlZg0+rtI4WNqqQBBguYf+s6Q8PgNrW7IEl2IRzvj+WlEnCfaBF2
         duvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705362109; x=1705966909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li88m9Aw/LCRAibakjpHlPDF8glbTaanlpZnqcTkC3Q=;
        b=u2TE4xwssw4N10+ebMx/40pJjnrEC8SfIkb5k05oGOBMcKm/CBIVcP4rhYN+9gAff6
         59l7QowriWoRpBYdQXpsszHIIYMX2Wk0O2lLu6i8yaRFB7uaGyFmnvLG/EX3tWLpZZQf
         ThQrLXbBeaERlLc05awz7ZlJv944i8Te4xxwAkucx3wcRYLztkrjtqx7FnEvhd5zYyfP
         wqloSuaqChLvy5QF4qqmzFZU5mD+tVhnAEEVqcNZctjhOh0IZkjcpFAtC6h+//VusQtG
         f0qJwAd5jD0fq/CYeM0zX7FLLNaOpm2Q0777r8tlzhlfpKYpRcW72uLnQtcRFxgN59go
         3ngQ==
X-Gm-Message-State: AOJu0YxdB0QlQUjWHX8Y7HBihQyuHh2v5T0ze4UCnpV/wyZwLFieLqT6
	mmmrXLUN9D8Jb09lDjYSstQ=
X-Google-Smtp-Source: AGHT+IGoHxdCVz46pwuSIwlG6SlJkCKzggHGVAWjVqpMq2qgnnp1pcozB9Kcp8x25R40Z/y/SU3Z8w==
X-Received: by 2002:a0d:d046:0:b0:5fb:d0ad:9545 with SMTP id s67-20020a0dd046000000b005fbd0ad9545mr5518884ywd.4.1705362109078;
        Mon, 15 Jan 2024 15:41:49 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id cl27-20020a05690c0c1b00b005f48b0ce126sm4280575ywb.62.2024.01.15.15.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 15:41:48 -0800 (PST)
Date: Mon, 15 Jan 2024 15:41:45 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
	tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Nhat Pham <nphamcs@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
	Kees Cook <keescook@chromium.org>,
	Alexey Gladkov <legion@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v3] posix-timers: add multi_clock_gettime system call
Message-ID: <ZaXCuV1Dy0e_E-h0@hoboy.vegasvil.org>
References: <20231228122411.3189-1-maimon.sagi@gmail.com>
 <f254c189-463e-43a3-bc09-9a8869ebf819@app.fastmail.com>
 <CAMuE1bF0Hho4VwO6w3f+9z3j5TtscYzuAjj10MFt2mZXG2P8dQ@mail.gmail.com>
 <84d8e9d7-09ce-4781-8dfa-a74bb0955ae8@app.fastmail.com>
 <ZZ-ZNHgDsZwg9CaW@hoboy.vegasvil.org>
 <CAMuE1bF4sSeiDr-jyebF6F8oRxGs1b2gtT39fTJ2JeaFabr6Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuE1bF4sSeiDr-jyebF6F8oRxGs1b2gtT39fTJ2JeaFabr6Ng@mail.gmail.com>

On Mon, Jan 15, 2024 at 05:49:32PM +0200, Sagi Maimon wrote:

> Thanks for your notes, all of them will be done on the next patch (it
> will take some time due to work overload).

No hurry, glad you are keeping this going...

> The only question that I have is: why not implement it as an IOCTL?
> It makes more sense to me since it is close to another IOCTL, the
> "PTP_SYS_OFFSET" family.

I've often needed other clock offsets, like CLOCK_REALTIME - CLOCK_MONOTONIC.

Those don't have a character device, and so there is no way to call
ioctl() on them.  That is why I'd like to have a system call that
handles any two clock_t instances, using the most accurate back end
based on the kinds of the two clocks.

Thanks,
Richard


