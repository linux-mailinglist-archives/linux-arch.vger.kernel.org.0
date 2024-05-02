Return-Path: <linux-arch+bounces-4139-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F058B9CFB
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 17:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C7B1C22DC5
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 15:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86F015AACA;
	Thu,  2 May 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mJlV47bB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1042D1552E1
	for <linux-arch@vger.kernel.org>; Thu,  2 May 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662049; cv=none; b=ON+5eDdM+uIrxY4ixKmbsRRqgM/A1yqALjsxSwbW5vHbSOPBQtWQpmu0Ih79X31kzn1Jeg0tO2qf+vNVN8NWalMMenu0vN3hrXHJCSYYhAPnaL155hiEI1bvjmQs4z1jRsnWYJ3EmYNPpAJKiZKFd0CTWpfXd2i5lbekMnOchxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662049; c=relaxed/simple;
	bh=IXZ0XVHyeLiV27rkSUTUlGzkN9VnLtKzOMVCMNoC/O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv48FL+81ityEQ62LCQ5krrWPejW5hp+BDHDYCoLaYWRHH0YIh0eZ6IYwFUK7qtAfBByItLaGUkrN++ZvwmzkFPHFG4+6Be6P79yJpndXejc/j6Febzf/7NfOVa1TPaxc6AwLmRnV3/KJOJ1Fdb5K4nZrzF88C6e2AQpwVmjpPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mJlV47bB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eab16dcfd8so69121875ad.0
        for <linux-arch@vger.kernel.org>; Thu, 02 May 2024 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714662046; x=1715266846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fgw/gW1T+dxXdhkHqh35xpW27WxDl5iViGaENoxdrdU=;
        b=mJlV47bBZG2YpQPx3If6bekdR7ovyeFR1tJ+caocLpyOOupx0y407Lln1O91HmQPGH
         6gwqpC+LiTNn5Tg00r2fcYuE63Se2aZ80gp/ulaDtAHplyw7n7xuEUqoNxqhxFCuSQI8
         ZTeRK9oKJ5+GsOVLw/dQcHrXxUP40u1BYRhws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714662046; x=1715266846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgw/gW1T+dxXdhkHqh35xpW27WxDl5iViGaENoxdrdU=;
        b=j+JDPZDUX7+dV8TNdDBo5iV3La7K78PnbtgEZC3HT0SFip8aSARqjNWCHB+/Pfy1Iu
         Ai9QY3Fn+Qk5VsO8x3KoVJF69FHhaDuykXxA9QohCEAPGYoqpBsBLaHFk0Qgib2UYcoh
         7U9M5ue+NYoALVTO/85JnFt4K9fXXsrg0TScOOqNCC08bzXjelUrIyZcWaR+yu4QJYuP
         NfDYv4LPuM9x0deDj+u4z7dVShxfAK7JrxH0TsVQE5yVZS5aVv7vxSpadxjZEaojkOBf
         UdYMqBlb+G+OgZXYEoLUpICcn5o0tsFzdSWiWNdOaEMBgmCSfqIlf00DInXOthPAL3Pd
         af/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqGynYW/wlQx6cR674K7O1ywEmGLDHIXzRocrK+RWCjyENp1jc0y4KJJioqat2hSvoeRtmvu2YzQwlUhcsWfa5/BEripjx4t3lTw==
X-Gm-Message-State: AOJu0YwurBbaCKqVrZGvquiVF1OYvh8eFesdui78e6KoD+lx1cYf8OzD
	r399snPpiFCgvKaDazYiRdjT4SsHSbYTsEfM1qXKYLoNv502EVJwD4LOSaI/WQ==
X-Google-Smtp-Source: AGHT+IH29bay7toIy+Kv6yjDc1RgVK2wZSKXsZ9Gj+t64lyFsqoM5DD3wZ30/iSnTvCH8VXfcondMw==
X-Received: by 2002:a17:902:ab95:b0:1eb:551f:99b2 with SMTP id f21-20020a170902ab9500b001eb551f99b2mr5093641plr.65.1714662046285;
        Thu, 02 May 2024 08:00:46 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jc15-20020a17090325cf00b001ece59458fbsm1376105plb.286.2024.05.02.08.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 08:00:45 -0700 (PDT)
Date: Thu, 2 May 2024 08:00:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: atomics: lse: Silence intentional wrapping
 addition
Message-ID: <202405020759.55CD47C@keescook>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-2-keescook@chromium.org>
 <20240502112127.GA17013@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502112127.GA17013@willie-the-truck>

On Thu, May 02, 2024 at 12:21:28PM +0100, Will Deacon wrote:
> On Wed, Apr 24, 2024 at 12:17:35PM -0700, Kees Cook wrote:
> > Annotate atomic_add_return() and atomic_sub_return() to avoid signed
> > overflow instrumentation. They are expected to wrap around.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > ---
> >  arch/arm64/include/asm/atomic_lse.h | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> How come the ll/sc routines (in atomic_ll_sc.h) don't need the same
> treatment? If that's just an oversight, then maybe it's better to
> instrument the higher-level wrappers in asm/atomic.h?

Those are all written in asm, so there's no open-coded C arithmetic that
the sanitizers will notice. All is well there! :)

-- 
Kees Cook

