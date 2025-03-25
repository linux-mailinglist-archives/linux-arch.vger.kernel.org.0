Return-Path: <linux-arch+bounces-11116-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34307A706FB
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 17:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91108188E8BA
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 16:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BFA25A2D0;
	Tue, 25 Mar 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WORJzFnm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF4257AF2
	for <linux-arch@vger.kernel.org>; Tue, 25 Mar 2025 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920308; cv=none; b=kzFKRrhmQTl3erCZQRq+okfTRi6h3F9zQyLVGC9o+eM7mWBgzYprkzs1S3OBlIa2NkKX1KKjVGcfrKEGpHTrKxL6Piu+QMQ6CE08OIP6iCpUswfVt7fE/WQ8wozrEf0SilVTz0i/3OcqRvXXdGbkXtYgiaAnyoGuFoKmufcZ8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920308; c=relaxed/simple;
	bh=FqCTIgh8QO/t7KPUealsnN0UqFbnMBx72fTK2JxImZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOAk+H+IposYafaSGrtdofcL2Kp+HGo1F5gUN6OA8/dYy7sRa78chmsF8lqE1RVcFdJifTG/ZiDzred2qfxt9rjH0D4E4lDJhbeZ9vGQa4xzMHcx5dok4B1R4b66S8YzHH4eCVHJHMBuZXps3mhrgtXOSwyjzpfo4obp6G5MD0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WORJzFnm; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301cda78d48so11248985a91.0
        for <linux-arch@vger.kernel.org>; Tue, 25 Mar 2025 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742920306; x=1743525106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FqCTIgh8QO/t7KPUealsnN0UqFbnMBx72fTK2JxImZA=;
        b=WORJzFnmqQKLQHUQGsbgutdP+8FYmzlWK+Sx67omcM7DaFtCKKPb8Z1aI6m12IrsL9
         j/zBWJ7yRpQ4ro0biN1qEl3ilk/F+brryi1dL0yPR9aboc7H5Kx6dHuyt74IjV1sDgQP
         Oqwg3mEYtOayzX7HHHRotOsqNJXGX2SmNT7K/TunrVibClWg3GrWYhW1HlxVFLUMmU52
         6X8dyttDKdzKlG0vVuoWfQExGI3A9qfwEp7RFQrCmSALEQJArEty1EdYxwwJhClhVmLR
         8mskdbfsE/bSF74xIFKZ8Y5LN2rHsFINl9cBcx+wc3nGx9Ge2rwmXxFdOlNs4LE0hW20
         hgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920306; x=1743525106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqCTIgh8QO/t7KPUealsnN0UqFbnMBx72fTK2JxImZA=;
        b=UVJ0zOzDpL2HgeuAfPHOEUNH0UaQblTU3btE3z/YfxgXfwSThoL1ZWZJ74V+utL9WF
         +zZCSAEcDuxBKAF+jT/YkxDeNrcpyF/xaqnqi8ybGjuyL1jy0cVMK+fYaJuZmKiI58lV
         /2gthN6sqfedFE+XMDaT+aIzkRtw31rphBjrQ7gL9nS2DFDXIgqB6N0dKES6tT//B1Nn
         A30QpjohK9muLsfUuQZApQ3vDsdu/5YEslIHcMPctI7JrgTMsWc3JvXGmUMPQMF0H1Ti
         3c5oB6975OSCCkMzOvAoJ7xbuJJBxVQxQikC1JoT+kQL6WpN+vWoRZDZ+kmmNGLp85Ho
         GpWw==
X-Forwarded-Encrypted: i=1; AJvYcCWlEMGHea8COeOlMqoT1jZDxHmUvsS1pNrpwib8m2cDiTtbeuqnog9UEYX8tUybGr906qUGXnQzMSMv@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1FkdfRX2FtRwbBJttq2VwqSaq7ud/uLySYQoVHM6dBG5nqSA
	cj6IRZriF+PuNU9U7aJ9dq+KW4T9mXnFnnsVb5AtWmTDnHS3KZmoINF2egnNw5XLRDyKZEqZRjl
	Oamok4Y5wf43DnYUPkVWKKC6EjTKqOGmhwHpa
X-Gm-Gg: ASbGncvBrXkIREfeGwlmmGf+juUj0kok/wMICuJ21bN8kgMQk2wQimfH6Vau/9tienX
	+Q/6sOHzQUvndP6VicyJoucWHIKYqOMlUsNY34RUoco27sN5ofsgLZD5VusECa/RmORKCaT2tZS
	0hjnXnVIBWNSFnnTPL1tq7eNEj1GMs5yj+VXvCzkL1/J4WLrL5jKsuGTbRDPGNQsG0
X-Google-Smtp-Source: AGHT+IE2SR9bpc54rZzeETcMjOZPU5KZizBq4WuPKmSbzaKhsMuxbQn4aRhsY1Rh/59zdT9tE5i7EBsD3SxvGx8pyiw=
X-Received: by 2002:a17:90b:4a44:b0:2f4:4003:f3d4 with SMTP id
 98e67ed59e1d1-3030ff08e4amr26346030a91.30.1742920305908; Tue, 25 Mar 2025
 09:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-kcsan-rwonce-v1-1-36b3833a66ae@google.com> <26df580c-b2cc-4bb0-b15b-4e9b74897ff0@app.fastmail.com>
In-Reply-To: <26df580c-b2cc-4bb0-b15b-4e9b74897ff0@app.fastmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 25 Mar 2025 17:31:09 +0100
X-Gm-Features: AQ5f1JpE-9eEvuTImZnrBRyMVLS4S4ftn6GcJfbHDvLlEcvUIVnaUo1LgJcC6PM
Message-ID: <CANpmjNMGr8-r_uPRMhwBGX42hbV+pavL7n1+zyBK167ZT7=nmA@mail.gmail.com>
Subject: Re: [PATCH] rwonce: handle KCSAN like KASAN in read_word_at_a_time()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jann Horn <jannh@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 17:06, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Mar 25, 2025, at 17:01, Jann Horn wrote:
> > Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastructure")
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Marco Elver <elver@google.com>

> > ---
> > This is a low-priority fix. I've never actually hit this issue with
> > upstream KCSAN.
> > (I only noticed it because I... err... hooked up KASAN to the KCSAN
> > hooks. Long story.)

Sounds exciting... ;-)

> > I'm not sure if this should go through Arnd's tree (because it's in
> > rwonce.h) or Marco's (because it's a KCSAN thing).
> > Going through Marco's tree (after getting an Ack from Arnd) might
> > work a little better for me, I may or may not have more KCSAN patches
> > in the future.
>
> I agree it's easier if Marco takes it through his tree, as this
> is something I rarely touch.
>
> If Marco has nothing else pending for 6.15, I can take it though.

I have nothing pending yet. Unless you're very certain there'll be
more KCSAN patches, I'd suggest that Arnd can take it. I'm fine with
KCSAN-related patches that aren't strongly dependent on each other
outside kernel/kcsan to go through whichever tree is closest.

Thanks,
-- Marco

