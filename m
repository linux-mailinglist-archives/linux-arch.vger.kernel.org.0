Return-Path: <linux-arch+bounces-15445-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E31A8CC0009
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 22:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65455302DB5F
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 21:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07A9283CB5;
	Mon, 15 Dec 2025 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQLrXJ5J"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41341C63
	for <linux-arch@vger.kernel.org>; Mon, 15 Dec 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834820; cv=none; b=VvGD8T8tx6ebcP6trysh3Ijig00aua4jbueaO542ovz/ZffsRq/mmuvsZavn3HWH+R12Aw8QY1BuSimTetcY8otaUlqFNyrBABj5MfFcTyzI4zjer1PUj/6mC2gq993NZfi/P0zzkb8bkVeWXgMsGetMdrLwE/gJvIaiUjkw77s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834820; c=relaxed/simple;
	bh=Y9B0PrO7eep9Md2S3cwjSR2T7fsBiwkpWkQ81Zxh7oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeNXNV/dP1V19XuUOwApc8GaBMRi0UXZVh4Y0i+N72pPBjCk0mikWN9H5cDAwTR0b6MFpteXlNcTV4alR45tQZY5vJ7Yp7uzb1JXz6s4b43z6o4XS5XIc9g9Pkfg+lBYBwqQnxIphz+/wjR8bA6QdYFwt3NhcLDh+mUiEcnZ5AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQLrXJ5J; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fbc305914so2265965f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 15 Dec 2025 13:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765834817; x=1766439617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtrYjcDo8W8ENLiooSwtuxxlBPD0y00FacSVPre/Faw=;
        b=QQLrXJ5JAUOzJ8Yt1jyd5kWZKLwJD6LCSRU0Tj/6IcYefX0Ty+qXaOOCXoVzD161Hm
         oz1eXEiyEZs1Db+2tRL0QVbtnLpASsry3v+lyOkqjtXFqQabduvZnaDnAunDTa7qJ4uP
         isD3IBOOlgDrc4PazKAYDV0GyoixAfeSmaHIZHKU3IJMZfasrCR9xa4SepsW9x1uuZZD
         GEHl9BIInSVE/5ZEdpq/SmJoxLGSqd2AAQgzRqUxhsbx3x9kt9KPJR977m/JDxTY8LTx
         Btuo/BDu9wLR4eu9NOnrxRc6XFAqYzAHNUMPU/Ql/xAVuXNFaz+oquG5jC0STwf0D3Nu
         p1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765834817; x=1766439617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PtrYjcDo8W8ENLiooSwtuxxlBPD0y00FacSVPre/Faw=;
        b=K5icIvI+Awf6AZ67qFTB4MxhxqxRlRx8dfwbLsFsxMAlRjyf3+6MFDaqyx1UWTcKjA
         CzB4h2VtljdxFr/fyuDwYBlWKaBy+jW1KKZYL3JT4n6IexnNbu9yFKkp/Zw9A7khCLCA
         xNOycibi46K6u6YGP4VfnbERmolMWENwtxd2YRdd4uWQH01Xew+LNzm8KdP/WIpbNdzW
         nI6BexlpOepnRSo7Lxi+A7Z6fCepf3uEUjQxYnJmsnJRe8lnDMS1uWFJvxXhKHTSXSlA
         SCno5JyMLzP/i3fUAYPZBp/rTmijOxhQ9yqXLF4VrO/2F3iLwon+XOY6j579GdFE1au+
         bNNg==
X-Forwarded-Encrypted: i=1; AJvYcCX2cJ8mzYZ4g9B9GJXFm0LIBm4utRkagj0h+gW6ArQ+IvJdj3h7+uiF8Rqy+NBU7O3dOLn+9KWbtdMb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ei27QFPkYZXa/QJ3zBotQh87DVESR5rwENPVwjultLIcHCiT
	5Wqt1DEG++2RcNswy1zDS5w46pAlTQZzgc8aiP1OvE1z01s5R/kByr3Ix4qncs6qXJ7kT/eFuU0
	uMTi9gXjfDndmEXmtHQk7c+GZGIfOMTs=
X-Gm-Gg: AY/fxX6x0u0PyWsH3f1/M1zk0ZZ6SnoHV0RvLHawwudk8VpFhdxY0ap0b633zZfpym9
	N1MFZeTK8/bysTrZABKWAqdYQ9p+a/ggTlJVQC64U/t9+iBCanI0swh5UGzfnOlvH0eBf5W4LUQ
	fmq0ityYTXqydi+x7C0FeLxaVv0ymWGNPIpNZ3NCNitIyw5rSuWRE2078lDwwWhOT/BGXkOJOQD
	mVNMnhIqpne4qVxs7UQzAs+jmk2miZ7uX3+wrjHKkbemLaQs6RelAm9o0ReonJSvIIB/nU7sRN0
	7SyVKIknmKVcSYP/zML8bzFs6K/M
X-Google-Smtp-Source: AGHT+IFLwg9qrtGIR+KKSJwR/7/cX3U7rq6rlbIqE5QA9N+Q5KZyJ8O41sxw+c2I52/X9p3wPLvNSGsFlF/3a+MqKoo=
X-Received: by 2002:a5d:5f82:0:b0:430:fd0f:28fe with SMTP id
 ffacd0b85a97d-430fd0f2a7bmr4935997f8f.31.1765834817292; Mon, 15 Dec 2025
 13:40:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215044919.460086-1-ankur.a.arora@oracle.com> <20251215044919.460086-11-ankur.a.arora@oracle.com>
In-Reply-To: <20251215044919.460086-11-ankur.a.arora@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Dec 2025 13:40:06 -0800
X-Gm-Features: AQt7F2rQ1ApFWmx4BVk_0MGk_PcVWn8dueHeO96jKZChfmmCmjnf-YqQHmYoFps
Message-ID: <CAADnVQKYoE85HFAOE5OBFpKbXej=h12m4DVvHuPViJSjAncK4A@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Mark Rutland <mark.rutland@arm.com>, harisokn@amazon.com, 
	Christoph Lameter <cl@gentwo.org>, Alexei Starovoitov <ast@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 8:51=E2=80=AFPM Ankur Arora <ankur.a.arora@oracle.c=
om> wrote:
>
>  /**
>   * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
>   * @lock: Pointer to queued spinlock structure
> @@ -415,7 +415,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rq=
spinlock_t *lock, u32 val)
>          */
>         if (val & _Q_LOCKED_MASK) {
>                 RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
> -               res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHEC=
K_TIMEOUT(ts, timeout_err, _Q_LOCKED_MASK) < 0);
> +               smp_cond_load_acquire_timeout(&lock->locked, !VAL,
> +                                             (timeout_err =3D clock_dead=
lock(lock, _Q_LOCKED_MASK, &ts)),
> +                                             ts.duration);

I'm pretty sure we already discussed this and pointed out that
this approach is not acceptable.
We cannot call ktime_get_mono_fast_ns() first.
That's why RES_CHECK_TIMEOUT() exists and it does
if (!(ts).spin++)
before doing the first check_timeout() that will do ktime_get_mono_fast_ns(=
).
Above is a performance critical lock acquisition path where
pending is spinning on the lock word waiting for the owner to
release the lock.
Adding unconditional ktime_get_mono_fast_ns() will destroy
performance for quick critical section.

