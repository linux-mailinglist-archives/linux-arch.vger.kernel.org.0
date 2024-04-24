Return-Path: <linux-arch+bounces-3939-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA9D8B1660
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 00:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A201284340
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 22:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1B016E881;
	Wed, 24 Apr 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ip2IuUZ5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA7B16E878
	for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998710; cv=none; b=Vf5DjXInqn/39STc+UXX1GLjrR+hD+O3ojrUmjpvb8K3HXnckFBEoIWkdhkurfkDloCTOxdhvqKUzB4Mv5lJKamQ4Ljwe4I0mF0lTJj4EfuMslhKvr43YPqHAxa/bE76gVCJ4c3059vPM2yNj+8eQb9Q3bCUHHs8ZQRclwkTJYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998710; c=relaxed/simple;
	bh=PesUfngxJz9TzB+RXrKPi6gidufT5NJWBpNfqP6UeSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCMX2NAQjXP+PmF2FtZnU/LxEv4yE9w0X2riOJmc/SJZ+T3GcNz/Iz8Vi6kQXgjnoxCYjZ3e246ZPyt2fEjDOc5GswZ92Z7U7w4N/Yvwy4NxY/7zFwNd7hkFAz52zd5rFDPblMbYnoxSKVIjVaXhYBG3oLgbsv6hIQDMKlx9eTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ip2IuUZ5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso373789b3a.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 15:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713998709; x=1714603509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bQ7aAoW8uYuZUJ8c+fQ05Y2fxYHEV3uQB6MRkhy36Ug=;
        b=Ip2IuUZ5LfeaeG8LgTT7FPRSNVprS1WtQ8j+0rOBMsdFH8RkkiUSJdxlYmcWm0keco
         D0VyxtpaYBK3q8eO/87uN8z81J/XdcHp44mFnYRtTQyLFhhWKfvbInbP/sym7rPhnNN8
         73IKrRKCZtycqCXOrZtxQ2k6kD6uCr8YzTm4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713998709; x=1714603509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQ7aAoW8uYuZUJ8c+fQ05Y2fxYHEV3uQB6MRkhy36Ug=;
        b=DQPlQIlfToUyvnPXjOyGCLQ0GY0WOG73RlYBhtGnoywC+mT2IY6o5I0hcAXC6a7Gxk
         oIUJcnHAy7J9L/4uG6kv99QeKBHZ7WzDoSZbMcoeXzmTZSjTa/1g7fnkQAcMwm61B/EF
         ot4AxdQKybaAWtOVYEr4yHKke9AfYnRC3/Whk1XF/F7IOMXi41ajfGbFpRZsjhbTK294
         7e2DM/99YufOPitkvLzb0v8bUirn739jTqDyb5Epkz1Jk618ErwN/w7lJjYESK10nmp7
         aZ71DZh3YaFIrk/syIpivwKpFuA4MjAwGM5QZV+nMZSB9KBQIm/LjBvemI+zePbWi/um
         lXag==
X-Forwarded-Encrypted: i=1; AJvYcCVO4e2nocsghMkrJqzi06qLZliFuBHxMV38QbTkuoGCGIwT6Knb0qZ/HpuOoFrtXsJ4eEpKerIcOCEyP01QfqdUOvYKGj89qlCKug==
X-Gm-Message-State: AOJu0YzYwjD7X8ynutbTJZESx/LI78upd4HTFAgGdnTRVb/voW2edy/d
	JanNq0FdJgZY4QLm5Sb3ApirG/sH7edWrWmdNs9Avv5dXLYzOjedeiTfJZ/OvA==
X-Google-Smtp-Source: AGHT+IEAjXKcOqWbmJBmZ5dMg2rtYhG1LF2zwzQbtnGchw8LS/JZuvVMQDMhTtYVw79O2YlLzJPAxg==
X-Received: by 2002:a05:6a00:4fcb:b0:6eb:2b:43b4 with SMTP id le11-20020a056a004fcb00b006eb002b43b4mr5470380pfb.27.1713998708861;
        Wed, 24 Apr 2024 15:45:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ln2-20020a056a003cc200b006eff6f669a1sm11902767pfb.30.2024.04.24.15.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 15:45:08 -0700 (PDT)
Date: Wed, 24 Apr 2024 15:45:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jakub Kicinski <kuba@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/atomic/x86: Silence intentional wrapping
 addition
Message-ID: <202404241542.6AFC3042C1@keescook>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424224141.GX40213@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 12:41:41AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 24, 2024 at 12:17:34PM -0700, Kees Cook wrote:
> 
> > @@ -82,7 +83,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
> >  
> >  static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> >  {
> > -	return i + xadd(&v->counter, i);
> > +	return wrapping_add(int, i, xadd(&v->counter, i));
> >  }
> >  #define arch_atomic_add_return arch_atomic_add_return
> 
> this is going to get old *real* quick :-/
> 
> This must be the ugliest possible way to annotate all this, and then
> litter the kernel with all this... urgh.

I'm expecting to have explicit wrapping type annotations soon[1], but for
the atomics, it's kind of a wash on how intrusive the annotations get. I
had originally wanted to mark the function (as I did in other cases)
rather than using the helper, but Mark preferred it this way. I'm happy
to do whatever! :)

-Kees

[1] https://github.com/llvm/llvm-project/pull/86618

-- 
Kees Cook

