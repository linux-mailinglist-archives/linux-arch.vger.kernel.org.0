Return-Path: <linux-arch+bounces-8411-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D6C9A9427
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 01:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A9E283F89
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 23:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C168E1FF5E9;
	Mon, 21 Oct 2024 23:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HSu4SRoJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071421FCC51
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553304; cv=none; b=kd37qiiJ1t26oGOoV+bBHmbpveT9yfVD/RbkBE4DNXta0S8tNwL90wZXX2yfV/aUZek9d8cVa5bNjVI/XnKcrphvecOzt4TQ5MKF622CUKY/Jiev/ErAmdZ/d2voX6dT2ErxurO+kzuKAZet0A1dGp7WLCYRQk8ou3MOykZsfNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553304; c=relaxed/simple;
	bh=Zff+RWbA2FT88lk3jSWQqGKGPHCgQFk2oW3h5uX7IeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0bxlHo0f9PkXCPj8RyH9d3U5sJqcnMUlzgWByYxljYp37E2kGf7po4AbLolV9rZ7wNM4HLEqtUbiqKv3txeBqrmToDXAehmrOsSGsYsBWKKdsKx4GkYY1d20NhbuK36m++zwSN1NlalSAqQfsFoB1MAOiN98BjH48SEDa3grDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HSu4SRoJ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4608dddaa35so150271cf.0
        for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 16:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729553301; x=1730158101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7g9rImT4RZY0eWuCNKQmXqLXLyfWgLkLWLrUC8CYD4=;
        b=HSu4SRoJsW8fiTfLNoPfWtmsST46EkuJlHkjES1+/95VKhqN6z816FGc4rm9uWnMb/
         VJ3ppoKimFUlHoXvGXX2AfWR/jtFel0iuPDF1mhGnSCH11gSzLun0/FuCtIv7ignLa3G
         bogy8wfBdAbTEWcEIMLlAf/KLo1InWk7wFyJODV+4xpxwqWUafSk1xFxcIILHB14UZWF
         0s8NWDbERo26AlnUM0qrUDhB+Y8GIq/lp1VwmK3qHBgTHLJFTZNEP6zf1AiRYR7H3OqA
         12tseM+/pynF9DXeZM81eyu4n9NZ54i2Sm8PaedyrR32Fh+1ohfR+LMVZlKBCjYTiIJG
         8xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553301; x=1730158101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7g9rImT4RZY0eWuCNKQmXqLXLyfWgLkLWLrUC8CYD4=;
        b=QOfPg6R0if61afMyCs5HYfhYvADomT5/xchjdLf7vqQdJlQFMSd6eiYNgWQyUYjrA6
         mKQG8u1W1ZyBONRrqC9Pcxb2apoO0fSXZFnXxW6QQbc/BJRKEt7LzAbBZ4Jo60Q3bBtY
         R/5+hQQ+nKEKArKAE/So4b37YuGZGLPbpQE5xDCxYWCr0jxOEKMgU9BNEkO3cu/RlmEK
         /xyBq8Cmwcgl/vD2mx04nugs5gltI8uZr8BNNEvLBYyM0xEBWXGYi4wMVmfYC9aEQTGs
         6dJCJlIRr8NEw54JqrpyOl78RBKhv48IzXs8oF1MrUoXj2FfhwmxHReCevoJbLdWG4ef
         3+hA==
X-Forwarded-Encrypted: i=1; AJvYcCU9HLxleVjRAIZmr+p/0k+usb57IqGG+xLwmrJ3NGrgUbXmlwriRM28KVCnpJRkn6Dbfe4W8m9wpt7d@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj8g3XFtwpw6RPNCNcHR80QrXWfkvRHOn66L/j6m25zf/uvBBV
	Ssib2ru2hXrjengZ0dTBta4rDHiDz2/RDsYA6S1ZeUkyrMCfyJeBCLHty1cQ3AHT1xEHKICw0Ot
	L8yQevS22ShY9MA4dKih5G2h99VMLV1AxU+wJ
X-Google-Smtp-Source: AGHT+IHlHILW/VtCMnIvRhHu4MUnVCebk8xwRyaArpHaBD/sb8cKitt+/rPJqdaQ95G0uL5u4b+WEZY+T68Iy0r6+2Q=
X-Received: by 2002:a05:622a:303:b0:460:f093:f259 with SMTP id
 d75a77b69052e-46100b89943mr1430991cf.22.1729553300622; Mon, 21 Oct 2024
 16:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-6-xur@google.com>
 <CAK7LNAQ0RwJYkCXHj8QMH3sqXgY2LBTiYV8HnKD8oANB8Bb+Yg@mail.gmail.com>
In-Reply-To: <CAK7LNAQ0RwJYkCXHj8QMH3sqXgY2LBTiYV8HnKD8oANB8Bb+Yg@mail.gmail.com>
From: Rong Xu <xur@google.com>
Date: Mon, 21 Oct 2024 16:28:07 -0700
Message-ID: <CAF1bQ=RuLmO9S1W6ofmgVQZR7pBqR3iN7gCuUO2TkwGQwM76Kw@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] AutoFDO: Enable machine function split
 optimization for AutoFDO
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>, 
	Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, x86@kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Sriraman Tallam <tmsriram@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 8:18=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Tue, Oct 15, 2024 at 6:33=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> >
> > Enable the machine function split optimization for AutoFDO in Clang.
> >
> > Machine function split (MFS) is a pass in the Clang compiler that
> > splits a function into hot and cold parts. The linker groups all
> > cold blocks across functions together. This decreases hot code
> > fragmentation and improves iCache and iTLB utilization.
> >
> > MFS requires a profile so this is enabled only for the AutoFDO builds.
> >
> > Co-developed-by: Han Shen <shenhan@google.com>
> > Signed-off-by: Han Shen <shenhan@google.com>
> > Signed-off-by: Rong Xu <xur@google.com>
> > Suggested-by: Sriraman Tallam <tmsriram@google.com>
> > Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 6 ++++++
> >  scripts/Makefile.autofdo          | 2 ++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index ace617d1af9b..20e46c0917db 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -565,9 +565,14 @@ defined(CONFIG_AUTOFDO_CLANG)
> >                 __unlikely_text_start =3D .;                           =
   \
> >                 *(.text.unlikely .text.unlikely.*)                     =
 \
> >                 __unlikely_text_end =3D .;
> > +#define TEXT_SPLIT                                                    =
 \
> > +               __split_text_start =3D .;                              =
   \
> > +               *(.text.split .text.split.[0-9a-zA-Z_]*)               =
 \
> > +               __split_text_end =3D .;
> >  #else
> >  #define TEXT_HOT *(.text.hot .text.hot.*)
> >  #define TEXT_UNLIKELY *(.text.unlikely .text.unlikely.*)
> > +#define TEXT_SPLIT
> >  #endif
>
>
> Why conditional?

The condition is to ensure that we don't change the default kernel
build by any means.
The new code will introduce a few new symbols.

>
>
> Where are __unlikely_text_start and __unlikely_text_end used?

These new symbols are currently unreferenced within the kernel source tree.
However, they provide a valuable means of identifying hot and cold
sections of text,
and how large they are. I think they are useful information.

>
>
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada

