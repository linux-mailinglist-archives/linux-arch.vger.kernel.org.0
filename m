Return-Path: <linux-arch+bounces-5394-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9A793136C
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 13:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AEFCB24373
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2024 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0514518A946;
	Mon, 15 Jul 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IzA8ESAn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352018A93A
	for <linux-arch@vger.kernel.org>; Mon, 15 Jul 2024 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044151; cv=none; b=P4kbSx6nXcySnA1RNZI+IQu4+WoWlL1GDspa1U/vvPO15AmJSK7W+wZ0O5LD2jItYQ4/LpU5cIqKS6HGpbLnxqWige9yPiU01cc98WceW95/8XkGDxt1FfGdaTnN9p9+MbNvKoEFRxhzll3Q7uC+Kobf85fr86j5Os+U8OcJ3nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044151; c=relaxed/simple;
	bh=Rx2Y9LemseZJuQEPmIapBsiBSl9jftAgmsKlya+dApE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUvRPHw0pz1syNNeV27K3Lv/B6lpj+oRu2DhWrzWYWS8Y6Jt/boWofYTe46VaPGNfB+OTerjg1gEYi0VgrTXOiF2bwyciG7M/31QlbgLEzbVsjM3wI+7IxBeOzXe7EpFvRMrDk4CoKKu3jBWfMRyUOArHlqOJnBbVJqFsDANTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IzA8ESAn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77e7a6cfa7so463802966b.1
        for <linux-arch@vger.kernel.org>; Mon, 15 Jul 2024 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721044148; x=1721648948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWUt7fUeOslaf3J86kT2EHlZPfYeTYeze0uqvoVnIhg=;
        b=IzA8ESAn19+FEDlzbOtrDYK2tftSWbRX9qQLYHU2gv9/MGJ6A0yuyVBpIs6QyE6kbO
         5qXwlyg1E+rUF5xC/MsDDoYFIzHOi4tHF5lCAQQ30uOwBGqwM56OpOaIz7bVrlzZVR38
         ofZntBVKKRxcLmpv/cTGRl53nlYF2RRFbd6pUhSa6m6nc/EhlkfkDphC6GLnpXkDNdKY
         lmsgBPovNt1jv2ygdn0roQX+PzF9d0az+lp21m6eNwcHWzMcSWbqEzF9evMV3Y5W2Rpr
         CHqr3C8gk+C1r4bjuZVc5qq+8qBv25fUSj5FSt6UPd7KylCeImaqoHDXCsNutmcCUMc6
         aDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721044148; x=1721648948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWUt7fUeOslaf3J86kT2EHlZPfYeTYeze0uqvoVnIhg=;
        b=fUcxCsMCIMNMMWoj2mg/JeqRIuKyyYTg6ieqJE5HnEf2sOAbSwlds4EEOWHTs0nJHw
         bwCpJsuUROhotxX8rHddF/4RfbLXP6TUozdYwZZN9LSWMD+PkDJ1Ye0wXtumLAWfVefg
         EzIC5Lbs0Z0HyXtWlnCKOLaGvzhby5jVLKb9RvW4Ly7/VXFX9jtuJLrD7rtL2KCUTSKs
         GRzleB76n7AdJ4KHthK7VUOXEIgwJUTXIKxo8+ndXv68DHaumjOX9IbJT4vPwKK3EQQj
         MpN3zR96V4nqUDuD8Wqv3A1rWKh7ct1+qp6gJ5lKKvV/G+9p2LkJVS3GCgvPGarZXW0M
         8Owg==
X-Forwarded-Encrypted: i=1; AJvYcCVDsGU6A+7iT5U/Mpg1+PTqjcz/6upbsRCbecV56t3CwtO3kYrKou2DGm5jfkQqRMHXdE4MxHqYdyrw6MXp0WJG++lw1if7hdbGmw==
X-Gm-Message-State: AOJu0Yx1c+W4v4TXUjgyzyJ09BQ2rtP/RjV3IMOiYBPsobje9eyrzRZu
	qhdLArsLi110np25jx06IWnpxOzq3PlgLFcX4I6/CjG1aGYGs1guijr8Usat1B6LQqw6U1JeeQs
	Qxv/3yYnO4GRm86vwUbQZs883X1fDir3HuMuW6g==
X-Google-Smtp-Source: AGHT+IGUcPUU2RIzFJtJOINEci/osf15ph1Bg+CJXHIaSjFd2XfYUaMENDIEhkpgMuT9oddToIRteMCL4WHc0Fj1gu0=
X-Received: by 2002:a17:906:1388:b0:a72:428f:cd66 with SMTP id
 a640c23a62f3a-a780b705222mr1125612266b.39.1721044148245; Mon, 15 Jul 2024
 04:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-2-alexghiti@rivosinc.com> <Zn1Hwpcamaz1YaEM@andrea>
 <4008aeca-352f-489e-ba07-7a11f5ab7ccb@ghiti.fr> <Zo3MH8idihW4o+6Z@andrea>
In-Reply-To: <Zo3MH8idihW4o+6Z@andrea>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 15 Jul 2024 13:48:57 +0200
Message-ID: <CAHVXubiLJWtAit9T6OYx00qHu2QOVNqYRZZiOZHtmDBrDoW5Ew@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] riscv: Implement cmpxchg32/64() using Zacas
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On Wed, Jul 10, 2024 at 1:47=E2=80=AFAM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> > > Is this second IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) check actually need=
ed?
> > > (just wondering - no real objection)
> >
> > To me yes, otherwise a toolchain without zacas support would fail to
> > assemble the amocas instruction.
>
> To elaborate on my question:  Such a toolchain may be able to recognize
> that the block of code following the zacas: label (and comprising the
> amocas instruction) can't be reached/executed if the first IS_ENABLED()
> evaluates to false (due to the goto end; statement), and consequently it
> may compile out the entire block/instruction no matter the presence or
> not of the second IS_ENABLE() check.  IOW, such a toolchain/compiler may
> not actually have to assemble the amocas instruction under such config.
> In fact, this is how the current gcc trunk (which doesn't support zacas)
> seems to behave.  And this very same optimization/code removal seems to
> be performed by clang when CONFIG_RISCV_ISA_ZACAS=3Dn.  IAC, I'd agree it
> is good to be explicit in the sources and keep both of these checks.

Indeed, clang works fine without the second IS_ENABLED(). I'll remove
it then as the code is complex enough.

Thanks,

Alex

>
>
> > > Why the semicolon?
> >
> > That fixes a clang warning reported by Nathan here:
> > https://lore.kernel.org/linux-riscv/20240528193110.GA2196855@thelio-399=
0X/
>
> I see.  Thanks for the pointer.
>
>
> > > This is because the compiler doesn't realize __ret is actually
> > > initialized, right?  IAC, seems a bit unexpected to initialize
> > > with (old) (which indicates SUCCESS of the CMPXCHG operation);
> > > how about using (new) for the initialization of __ret instead?
> > > would (new) still work for you?
> >
> > But amocas rd register must contain the expected old value in order to
> > actually work right?
>
> Agreed.  Thanks for the clarification.
>
>   Andrea

