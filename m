Return-Path: <linux-arch+bounces-9194-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C389DEB19
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 17:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E44280E2A
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4023B19F119;
	Fri, 29 Nov 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxDOwPls"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC414831E;
	Fri, 29 Nov 2024 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898029; cv=none; b=nE5rTlC2wM3N9Kf9gzy++8DvGAzB349XpN1yzdfQZbM6/kAa7A7sMZn+roVzmpOzpjKW21eNsS3ikmTWOMdoeS8upC4QZMXAtzQlcSp0V6mxrVRuC4oqJgX5wusyp/ouSLTMwiX8RcNfRdADutOiFVVgklRCIXcKUkIGmOvOJG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898029; c=relaxed/simple;
	bh=jV/HJJoyFisUlmpbEwO+vSgy0MZZ5vDW7dpKoJjtGRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jU7+VqxfS7Ax1s4t69fO0KAjya6EXRTepHJsVlLiSK7gO+241ANDhJD8JfnIBdpeTxagHbdOcXM8DBrzy1/yUzFmeKUJyI9SJMV/XtBgDC+QNe/VxvhaDH6vl3tJvF8UON5Wh65xZzJqP8rFXYwbXhKXOyTlf1PmhIkS5HdA2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxDOwPls; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffe2700e91so17496231fa.2;
        Fri, 29 Nov 2024 08:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732898025; x=1733502825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o5c5OkJBnxuHx2X8U5fNa7RxI4N2MNNsd2C+SVC6H4=;
        b=HxDOwPlsOuNayfgqQF/4HcFAN22Bb4SyTY+kvR1RfeDjOizxefu7IPvSnAt9vIfoLp
         5LKADzcTCqv5llUj7u/0On9zPocv2BXGnsJyge2OYlxy3+y+2gzAKRekavk+AqXCCUjz
         nteQzH2SBeqXii8rtsFggHya4pAyWAb4kJsXlmNmMAPVwfBMQUpUE0l5JfPmeruo5isR
         U8KCcOGqCzPfLt478jEy7bSlU0aPQY+Y6GSm4UHKC8jPF9oNSOYyRuDPkTcNAiOXC4oM
         1Ej4HYjq5NcAjDO/Fq5VnAwl71deLoDI0k/Sn1FMBINezkQXdD6ThhCT7cKKb7/TIrV4
         xivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732898025; x=1733502825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o5c5OkJBnxuHx2X8U5fNa7RxI4N2MNNsd2C+SVC6H4=;
        b=fqigoB+nc+VuB9GdJrQJyYgw4tlt/z0SkE/IAmGmtQqOHTqoegh/NJJW6QC6tckm2w
         SmjNoI6Q1KJnCblJU1iKEaj82jq2Yo+mNre9YN8EAFXgbJlt0uTWCDIQNx9EhxQeSPrW
         ct05cKckv/2TYJYWfB6RLEbUZKL/Qq6FRIPEO29zHG2GzS5AwmP7HbylUPcs/I76ZHt+
         Nc9RmRHic5N20NjxctYL/mH7La8Bagnqn43wa4lxLPwe+XTD50xg0sVxd5/5tfAHGbpG
         mi6H/f0BqmlMHEvNdJD6v/qQ1Ome5qQbKTkJH8ZJwuRamkgBzXT7ozu1WxWW2Cly5x2U
         q6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUMDexXD9KRhQGuBqTw7W4HSR548SuYu2EtQSLgvTADKBXN1ofYBNRa5xTP7IW7wafOYU+A331t11oHkq7z@vger.kernel.org, AJvYcCUcVnSePwPCoHb4rqjbPNKOdCYl1t30nYf/NJFvcwOkE5DgcEpVa5o04ykVacZC6kWXxYxspga2o41Wx4Jg@vger.kernel.org, AJvYcCWvKXNAHV1zlmJUGYVlwA4uqDwZuC2/6QsGaeMB9rVWu5ukAWOvwDb8yWpVok9KHI5ahj7fSIVRd6RuuNnL+6E=@vger.kernel.org, AJvYcCXMwRRabvNq4mGVoR7JybdFEfrPe0BRFq15/2OGVPxwt7Vmf7CfeIlQif1p79sr14fyvS6LeG4XTRDV@vger.kernel.org, AJvYcCXrNR2O809X59JevlCfAaLXWQDZN4cSOMUtbyLVVhehJ49YrNUFwFVtJM5mrg6kZiOJelMPZCcA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw/qVdAjVlng84exwc0fxG80dyLhw5hvhQFuNJjx3aZTJ+KgzA
	DkVGJlnIsHRbR1Q4msYRxl0vQ7DipmAolPWQrwx+HF2X7qiyTnonlAOfg7Mz/ve2GHStjKCJUro
	vKElRcWcFtNV9cl7l1ZjG6wtY0bs=
X-Gm-Gg: ASbGncsZhFeP1wnlVX03FwEuxAqG/QDd+Igz0CW+x5uY/T9vTgCoB+1yr6xH1wejpaH
	xDmp6vpMkkZGHv7pSJvT1qwBMdnecYtQ=
X-Google-Smtp-Source: AGHT+IFlFVlEhUxi6HFl3pGJQ6QkeeDU+I701r/q00tFH5KVLO7PE8iiSpjGYGZRstbj+0OGHuFgSmi6H+4E2uBgCeM=
X-Received: by 2002:a2e:a916:0:b0:2fb:4982:daea with SMTP id
 38308e7fff4ca-2ffd60dbdb9mr82866831fa.32.1732898025269; Fri, 29 Nov 2024
 08:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126172332.112212-1-ubizjak@gmail.com> <20241126172332.112212-7-ubizjak@gmail.com>
 <9CECB9F7-E700-4A92-98B9-6FD027F9CE65@gmail.com>
In-Reply-To: <9CECB9F7-E700-4A92-98B9-6FD027F9CE65@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 29 Nov 2024 17:33:33 +0100
Message-ID: <CAFULd4Zs32G+NToyGSHv8quQbSOfaEC2UjtQ3vwnn9jufK47rA@mail.gmail.com>
Subject: Re: [PATCH 6/6] percpu/x86: Enable strict percpu checks via named AS qualifiers
To: Nadav Amit <nadav.amit@gmail.com>
Cc: "the arch/x86 maintainers" <x86@kernel.org>, linux-sparse@vger.kernel.org, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Brian Gerst <brgerst@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 4:45=E2=80=AFPM Nadav Amit <nadav.amit@gmail.com> w=
rote:
>
>
> > On 26 Nov 2024, at 19:21, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > This patch declares percpu variables in __seg_gs/__seg_fs named AS
> > and keeps them named AS qualified until they are dereferenced with
> > percpu accessor. This approach enables various compiler check
> > for cross-namespace variable assignments.
>
> [snip]
>
> > @@ -95,9 +95,19 @@
> >
> > #endif /* CONFIG_SMP */
> >
> > -#define __my_cpu_type(var) typeof(var) __percpu_seg_override
> > -#define __my_cpu_ptr(ptr) (__my_cpu_type(*(ptr))*)(__force uintptr_t)(=
ptr)
> > -#define __my_cpu_var(var) (*__my_cpu_ptr(&(var)))
> > +#if defined(CONFIG_USE_X86_SEG_SUPPORT) && \
> > +    defined(CONFIG_CC_HAS_TYPEOF_UNQUAL) && !defined(__CHECKER__)
>
> Is the __CHECKER__ check because of sparse, as in patch 2/6 ?
> If so, do you want to add a similar comment here?

Yes, this is the same check. We can declare _percpu variables in
__seg_gs named address space only when __typeof_unqual__ is used. I
will add a comment in the next revision of the patchset.

> Other than that, I went over the different patches and it looks good as
> much as I can tell.
>
> If it means anything, you have for the series
>
> Acked-by: Nadav Amit <nadav.amit@gmail.com <mailto:nadav.amit@gmail.com>>

Thanks!

Uros.

