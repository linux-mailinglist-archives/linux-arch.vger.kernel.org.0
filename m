Return-Path: <linux-arch+bounces-9042-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2649C650C
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 00:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696D8B61CFC
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 20:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D8B219CA4;
	Tue, 12 Nov 2024 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdO18lPB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF0E218D7B
	for <linux-arch@vger.kernel.org>; Tue, 12 Nov 2024 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442419; cv=none; b=O+upm4T0SFoSM/jQoLe+QD+SZf8BlNOWrf88RAeKsyp2AEodbHRBo4fu6ki2qEzvkogsMAPEXhDllpSeg5o73hO4lmdjhfKIn+8wcPSgznqknSNTEDs1YbxfoRIyzORf4XOlMDgDp8DCyu/XgM7tYasaesQOP3PdpcCVIs9wQrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442419; c=relaxed/simple;
	bh=QY+lZkSp4pEMsOH5ViLZZ71ACCvNupC89gqwzm36rVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5Dp27qErD4Br03WKbpC4/BqJ3YAd1pCV+v0kxeenNFAVnB5s+87UgAsIELq0SimQYXEdsIsUfkXSfklnLvwdENP+QXipCRW7xC8+Eenpgv7HVn+DycvFRSbzBE5waw6N0CYE9btfiwZu9nMO68Qj/Hj3Cg9zwjol/GJTKBmjJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OdO18lPB; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460b295b9eeso54581cf.1
        for <linux-arch@vger.kernel.org>; Tue, 12 Nov 2024 12:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731442415; x=1732047215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok3qcHy+me2Jj8oTM9OE18MgpCpWLeklNFe0Xu3psIY=;
        b=OdO18lPBo5qORwZj/3PVqK06R8y3jZZ8+yIx6rAIojUQdnvwzHf09Fbhw/UUkIk3dV
         dWXwNP3Xkhi3z4sVkW3KudtMhWrBJz4ZtVra3Zmawx8zNO5lTyzkcYrRDA9hCtrBdthR
         /SAKmtiA1IETUMkg4nt0LrmB+gYpchqCaVcEWxMrJVnbWVYYSHusxI0Iy3mS2mEGD7/b
         h+F7Ylwu1aTKwBT0U6bHRvLM0fAuSWN72IgICbhMD4saSHFl3bPpZHeusFLLB/4IsHzv
         iptWosQ1aiDYT7jBk4oDWYR4eAGUMw2Er0rSqCy2JAg9qI9zcK+g3NTLiBHxoB7HgRoX
         mfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731442415; x=1732047215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ok3qcHy+me2Jj8oTM9OE18MgpCpWLeklNFe0Xu3psIY=;
        b=iSMstX6JLiazRP433wrtEYNsqc0YprVQrXrVtAW2RPC9ZNMAH3DWewasEoRISO3D7P
         JxmiZdNgy3MSIu4sfJMwt26eTVEgkVsANSCX00xISe5m7WW7+2cA0tEu0VBdMvtDDef0
         Wz0BzitXbUnQxXfn9LXveYk8LFjkZibUc75Mqyxf2B3d/bXp19xJTfKim7QI3T7HhUq5
         8pwroBwAN2o8qehLZn5cm6kDZ+vj12fda54nn4PVjsI5SDEIoheaLKRFVFf+nwxSqIFC
         3UQbAe3G18X/D7S8WvYHTgh8wNvp6fhR3aYncFauOU3kEYYyc1oWbRR/rjbY4xBu8y4o
         YKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6NHhtGw2fro4IzmGYLg5L+uU5l10los0tL/nKAeqXyvyPOQES+JSuh+kvUzaxA0LSFPi+C3S31/gF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ysVCfEm2FkmKZBs0UkQP5nB1wqxcXjZDumCu7MlryIbad396
	bpclSdUe5fVgJ6nN+oQ8x9h7WdIF1nLP01zosSWWY9VBBZJO886bPHqj+H250nEtoSeF9FWJGpV
	dPkoC47MXb/o6lAXcTCSB2mlGghfWLEkzFt6Z
X-Gm-Gg: ASbGnctPRgze5KlxtZqJIYRE7F1yyqC0Rs9WZxBj//hqjd0r3z0UGSxZ6JLtINftpOm
	xkbhtYUTLjDUf1uSlc3D4yiIj86sik2YJBsQb6Sf+p568Z5kScmxy4L1PgFmb
X-Google-Smtp-Source: AGHT+IHEhri+khloSfLyc9f+kn+S0I//KWGpBCIikR491QgXS5ZsJTa+TGjEAvCX7DRA5b9a6+qU8vYdidxIcZgIBaA=
X-Received: by 2002:a05:622a:47c6:b0:461:679f:f1ba with SMTP id
 d75a77b69052e-4634bca4e56mr371601cf.20.1731442415109; Tue, 12 Nov 2024
 12:13:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026051410.2819338-1-xur@google.com> <20241026051410.2819338-4-xur@google.com>
 <44193ca7-9d31-4b58-99cc-3300a6ad5289@gmail.com> <CAF1bQ=ShjoEQZGPjDoy_B6wZdD_jr-RevVXwEDPA_-o-Ba0Omg@mail.gmail.com>
 <e7cd2746-0ad8-452f-aa12-e3a37e8a9288@gmail.com> <CAF1bQ=SYeeKLUTfbqw-KH1rHJCj_CfJBuk+mZUrnnb7aDjRV2A@mail.gmail.com>
 <CAF1bQ=R18HLC2vjCGj+M=VYidrVzz3RT=U8cckXgpgrxc0kG0Q@mail.gmail.com> <70772ce5-9dca-418e-9714-80ba4ae28959@gmail.com>
In-Reply-To: <70772ce5-9dca-418e-9714-80ba4ae28959@gmail.com>
From: Rong Xu <xur@google.com>
Date: Tue, 12 Nov 2024 12:13:22 -0800
Message-ID: <CAF1bQ=QycziM6GQoTWSMQCGWPkZEDmAHMLfokoJ6k-vn7rCA=g@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] Adjust symbol ordering in text output section
To: Klara Modin <klarasmodin@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>, 
	Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Wei Yang <richard.weiyang@gmail.com>, 
	workflows@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Maksim Panchenko <max4bolt@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yabin Cui <yabinc@google.com>, Krzysztof Pszeniczny <kpszeniczny@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, Stephane Eranian <eranian@google.com>, x86@kernel.org, 
	linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I sent the following patch for review:
https://lkml.org/lkml/2024/11/12/1565

Thanks!

-Rong

On Mon, Nov 11, 2024 at 11:45=E2=80=AFPM Klara Modin <klarasmodin@gmail.com=
> wrote:
>
> On 2024-11-12 06:38, Rong Xu wrote:
> > I compared the System.map files from Klara Modin. The linker script is
> > doing what I expected: relocating the unlikely executed functions to th=
e
> > beginning of the .text section.
> >
> > However, the problem is with the _stext symbol. It belongs to the
> > .text section, so
> > it is positioned after the unlikely (or hot) functions. But it really
> > needs to be
> > the start of the text section.
> >
> > I checked all vmlinux.lds.S in arch/, I found that most archs
> > explicitly assign _stext to the same address as _text, with the
> > following 3 exceptions:
> >    arch/sh/kernel/vmlinux.lds.S
> >    arch/mips/kernel/vmlinux.lds.S
> >    arch/sparc/kernel/vmlinux.lds.S
> >
> > Note that we already partially handled arch/sparc/kernel/vmlinux.lds.S
> > for sparc64.
> > But we need to handle sparc32 also.
> >
> > Additionally, the boot/compressed/vmlinux.lds.S also the TEXT_TEXT
> > template. However,
> > I presume these files do not generate the .text.unlikely. or
> > .text.hot.* sections.
> >
> > I sent the following patch to Klara because I don't have an
> > environment to build and test.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.=
lds.S
> > index 9ff55cb80a64..5f130af44247 100644
> > --- a/arch/mips/kernel/vmlinux.lds.S
> > +++ b/arch/mips/kernel/vmlinux.lds.S
> > @@ -61,6 +61,7 @@ SECTIONS
> >          /* read-only */
> >          _text =3D .;      /* Text and read-only data */
> >          .text : {
> > +               _stext =3D .;
> >                  TEXT_TEXT
> >                  SCHED_TEXT
> >                  LOCK_TEXT
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > If Klara confirms the fix, I will send the patch for review.
> >
> > Thanks,
> >
> > -Rong
> >
>
> This does indeed fix the issue for me.
>
> Thanks,
> Tested-by: Klara Modin <klarasmodin@gmail.com>

