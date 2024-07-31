Return-Path: <linux-arch+bounces-5770-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F4D942E1F
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 14:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B411F25C68
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 12:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C000E1B143C;
	Wed, 31 Jul 2024 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lcLgK2bw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD51AE86B
	for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428410; cv=none; b=QrxsXpM18TzSnXUN8MSFj5/hBiwfzx9XQj5E3fnf/RF07hPZ9/miprIcybhYQN9/8YfbwX+ry1m5SdGDogIpvCTvZjjSGj9T+BQTb3sD2rliQKf4+xQWztEYGgQomrCJKDj89mUklcpuRJZICczZnC2QYAEsS0hDd/vSFvQwsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428410; c=relaxed/simple;
	bh=VLyIEhkLnhz9rx8+f5UQQQG3xPqtwVjtpvKYHmmZm3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxPuB/DbXhjWAtDOM4p+i99YVClDg//JKx740K84dvU1TONIIRZ9K34vXAyr370mtOF8Y+xMIER50w4OVbCgM+fQnr1Cs3Q56kbY1rgROU1eJ+SnNdQ1AS7qJgCvKBx0N99c6/ItGYM0XKmnfFNC4gX/gFU4tHppL9GiwOM+eVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lcLgK2bw; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f0277daa5so8987186e87.0
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 05:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722428407; x=1723033207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOIxnk7407zYgmcLnWaUjuP+BwjeEvDM3LSUzPdgUOk=;
        b=lcLgK2bwjT7dSj4YRuCAfOC8fe0caPTnrwZNL5tqKqeGpe1wiXBk8+cOCHC2X39j2r
         F32ITX27th9hXIrMt7fv0+/mpimU1anYHH3g1nfcI/LCKSkWlq/mu6z/Ncy13vaOYY5l
         tO/BrBhHp7XM4hTwu5wrJYyAkhXrxlJbKargpbeorD+91VrjRkJ6fjOo5Z36/N5+osYV
         VwypqvdUCtGWVblB8kZkIDA8t+vmntQds0SnMrcgCAyFJMyT55n7BjL7wWKR14w9qMXX
         039AThqwj9dplPOBxBM0dJJJ1pRB3fgC0AZG67yYtbubS/JL1O/1Txt95qLgb9HHQNZO
         nseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722428407; x=1723033207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOIxnk7407zYgmcLnWaUjuP+BwjeEvDM3LSUzPdgUOk=;
        b=Wu8HoL6KyuiMpeRHuBkj0CsdMcxalhV+Bdv+vCmWY9GTq+wnmilahDSvrVaa9UGeQu
         r0GBtEYjzliZVYDD43x2fu2N6C/KTtoXET8E4oYZl2Cq+dQQUGhaBd/hAelXG7rSiSz4
         Y8NKX/nXkNkjJxT0mUaxubrQhzR4rlhyaZKMG+LooU8hsG5+o9rQe0aogctPUujkaznt
         8QpfsL3tU8fZjvWrbArB20lirvwbhIvaltAk3zTd0XKC9B/rXYHVIxBm+JLQFZEaKF6N
         Y74C+PfbPRRq0d27G7R3EPrCmO0GtKehf1x52IfgPbHbHKxTo8h7zx/RGDWMjp8VoYNZ
         0z1w==
X-Forwarded-Encrypted: i=1; AJvYcCXTMpWExN2ryrh9yRSejX4C+v7TVOHzHFfW5RVwGu2riYJyTdnGMSFx3/XwcTMVIwNiTLnjyYmHpXGzx4HBcfeLKZGBE2hkA3YmpA==
X-Gm-Message-State: AOJu0YyFE1mGJeJJxgMNi98dh/ac3hU7oxUHYkKBNJzfANVwRHpm62o/
	FrbDa8GNDOG+f3RkVEZ9p5eryzwO2L/kTm9fdagEcfXvFygVu/LwrmkhBncEN/g=
X-Google-Smtp-Source: AGHT+IHyNIB5ow4TlUDHNH1tkbFmcks/+EVzVky0lfsDx0PedtHsujag8S9TeJckFJO9ghO9Oafw5A==
X-Received: by 2002:ac2:5b89:0:b0:52c:db0a:a550 with SMTP id 2adb3069b0e04-5309b2bcbe0mr9592703e87.42.1722428406890;
        Wed, 31 Jul 2024 05:20:06 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b04e1sm8624673a12.12.2024.07.31.05.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:20:06 -0700 (PDT)
Date: Wed, 31 Jul 2024 14:20:05 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 08/13] riscv: Implement xchg8/16() using Zabha
Message-ID: <20240731-60c5ad3ae9ec128886aed802@orel>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-9-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731072405.197046-9-alexghiti@rivosinc.com>

On Wed, Jul 31, 2024 at 09:24:00AM GMT, Alexandre Ghiti wrote:
> This adds runtime support for Zabha in xchg8/16() operations.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 65 ++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 24 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

