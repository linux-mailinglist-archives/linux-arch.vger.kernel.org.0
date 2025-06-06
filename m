Return-Path: <linux-arch+bounces-12253-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9BAACFF44
	for <lists+linux-arch@lfdr.de>; Fri,  6 Jun 2025 11:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A7D1725DB
	for <lists+linux-arch@lfdr.de>; Fri,  6 Jun 2025 09:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614112857F8;
	Fri,  6 Jun 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc0h1XGU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE0204F8C;
	Fri,  6 Jun 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202047; cv=none; b=ezjyX/q4exLanXrvGbIqMUOnQJwxPMvG5LfvUzBscB6IPZtQNyxMd4We2ilJfdEsewBhlHgaUM375a54rBUdyoRf8ZnWFX6/BRVbNtfju7ysOx3x4cLp1Rq754c2UCZme7nfJFp16EtFezOfTqwckqDpjRzg/Fi/C/lkhpd0kdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202047; c=relaxed/simple;
	bh=qAQ8mJSWYlTfWRB8Ep92WYLN2lrT5PO+Q1r4q7E7lCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qddf+PzG3iVfTJOcxWm0q3qQGOfqyEumVs9SZLHIL509odYWKbooVD5KwKw6WYTdWadC2bnwMeIOk5ZVufHDpkRuKTp/zT9FQz6nc02XXQNjR3kyrSiXj4VvqxKqP1rjp7hCuiLUbjAKaRtEI8bNH5OPv0tPiriu2LHkHyvVZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fc0h1XGU; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32a7a12955eso9568281fa.3;
        Fri, 06 Jun 2025 02:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749202043; x=1749806843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAQ8mJSWYlTfWRB8Ep92WYLN2lrT5PO+Q1r4q7E7lCQ=;
        b=Fc0h1XGUHHGJL6WSgZ4nf77xGDipBDeHi5BrcuyhpfTL5EuJuSO7Ct7DjA9EQRkzoa
         2Bl2iK3q2UzSRn8FA6xxnn1qIC6AuO2wsLZyO0RTQ4mKmmpZ9UQP12y1IQOdWgK1TyN4
         5/m4bCc0ELmcIj4aRUq1WgAy3gtkQ1kr79njiCGcyqfS04fV/1iCIUPBXcjh2pr8mK0D
         HwXei4kDhv9+/g4KoEpXmg66UBx1fN/LNQmEpjaoYbj36dDeo6WX8xF8UimzfkvOV8jz
         aq7hGn+BtTX8dyPTRo0/itQiwLQe+yPNYIWwnCEWzUxqY0CIkAu9NKszZOBPq7RwFNUq
         2IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749202043; x=1749806843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAQ8mJSWYlTfWRB8Ep92WYLN2lrT5PO+Q1r4q7E7lCQ=;
        b=MPb4T6YkC/iBEBcM4dV86c168TaR5outM5E095cb9RY1vgZQz14hOo3WOsvt8FAbKq
         6cBr50fBpzxWa6v1SqscbJloGgwDvVuKIXoGuavDVx8kINE5o+ILP0GBagIlhpPwGJqZ
         e0AXM0C41W60svYEn6xpmYTCN8lXu/PWsg2e4P9iipvu9gOEx1lm4Lt715/jY2BMxp6q
         ZGnUsrGqOJzdJLKks3CUhvWGyTXok0cjmtxNP3pErjhPPlv5j+CX4LpKENFvAa6yl2c4
         /ODLrmQLwn6JPdJJYRQIFztmDn55sgv6n2AcT3+0bgoC5nT6KRwFiFfighOsCknJNimS
         nwjA==
X-Forwarded-Encrypted: i=1; AJvYcCUisjMyAxVcu6GgT4tcTrowQknEaZ+ud93zfP3pYwwp9GZVIqimRoGy4Q+hvbwmbHGuaJBCJqg6n4i1jI7nL0c=@vger.kernel.org, AJvYcCV6bu5/eJ9Qjk1EPQPVja4bEdpqXyk9aRZ7Q7Bu26wmmywRwprxYw/wQV9dq6pSbvx0jfTMQOBk@vger.kernel.org, AJvYcCVW26c6adDSMrsV8SsXrx4e8CwHaf9A5NqnKwTkUIOwwNLjAZG19yrWgiop6fedwsIXd4fjEb+aqrv8@vger.kernel.org, AJvYcCWbHFEb+h0wFekz0i7SvW/evHbESJ0Ul+sXHOnbCucj5uMyUU6FajJqaqdOv9bHQUfVADnw23ooD4dShbUq@vger.kernel.org
X-Gm-Message-State: AOJu0YyG6sym7IJVUVgmAL6BLsiJNAdw2duNlvVESpK8Ps8hskKEmat6
	9DcFk54bYFDBwgv16HOLUVCym2tP/xWM2HK/4xXrd7bFTyEs/LTbDwTsogZl3rt80U7dAKteDPL
	SM85uidUm1ITf2FCr7iFBL9J4MaoBJQw=
X-Gm-Gg: ASbGncsm4XliZ1/RqQfZKf0FbSI6buZB38OIjONF4xyupaOUhI20v0enLsCJeqKDbFy
	vtkal0VP5BN+8nksIS5eG+Zj+XPTQrO3NCwasM88e+4NJP53CEon62ZF84zt1LwgFOKxUyvrhi6
	cH5+7CboIxnY7+Mh3c3qHdY/uKFUeLSB/7
X-Google-Smtp-Source: AGHT+IGUeijlpBN1uonipWsqdJg+nWSH/xMPJaX4H/+mQ0DOM4jhgZHNPYVM8V0AevFO7SK/JVaeJNVvlpd396frMbw=
X-Received: by 2002:a05:651c:220a:b0:32a:8591:668f with SMTP id
 38308e7fff4ca-32adfdd88abmr6163341fa.31.1749202043172; Fri, 06 Jun 2025
 02:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127160709.80604-1-ubizjak@gmail.com> <20250127160709.80604-7-ubizjak@gmail.com>
 <02c00acd-9518-4371-be2c-eb63e5d11d9c@kernel.org> <b27d96fc-b234-4406-8d6e-885cd97a87f3@intel.com>
 <CAFULd4Ygz8p8rD1=c-S2MjJniP6vjVNMsWG_B=OjCVpthk0fBg@mail.gmail.com> <9767d411-81dc-491b-b6da-419240065ffe@kernel.org>
In-Reply-To: <9767d411-81dc-491b-b6da-419240065ffe@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 6 Jun 2025 11:27:11 +0200
X-Gm-Features: AX0GCFsBhLxdX-uCBdNC6NAFJUOZLU2V-9ugVfL-X7mjzETyRN9kjHa3cvoik3c
Message-ID: <CAFULd4Zf4FOP-h0GVYo=frJ90tF07yvbuLbngnqUwyx9x+qz6w@mail.gmail.com>
Subject: Re: Large modules with 6.15 [was: [PATCH v4 6/6] percpu/x86: Enable
 strict percpu checks via named AS qualifiers]
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	Nadav Amit <nadav.amit@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 11:17=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 05. 06. 25, 19:31, Uros Bizjak wrote:
> > On Thu, Jun 5, 2025 at 7:15=E2=80=AFPM Dave Hansen <dave.hansen@intel.c=
om> wrote:
> >>
> >> On 6/5/25 07:27, Jiri Slaby wrote:
> >>> Reverting this gives me back to normal sizes.
> >>>
> >>> Any ideas?
> >>
> >> I don't see any reason not to revert it. The benefits weren't exactly
> >> clear from the changelogs or cover letter. Enabling "various compiler
> >> checks" doesn't exactly scream that this is critical to end users in
> >> some way.
> >>
> >> The only question is if we revert just this last patch or the whole se=
ries.
> >>
> >> Uros, is there an alternative to reverting?
> >
> > This functionality can easily be disabled in include/linux/compiler.h
> > by not defining USE_TYPEOF_UNQUAL:
> >
> > #if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
> > # define USE_TYPEOF_UNQUAL 1
> > #endif
> >
> > (support for typeof_unqual keyword is required to handle __seg_gs
> > qualifiers), but ...
> >
> > ... the issue is reportedly fixed, please see [1], and ...
>
> Confirmed, I need a patched userspace (libbpf).
>
> > ... you will disable much sought of feature, just ask tglx (and please
> > read his rant at [2]):
>
> Given this is the second time I hit a bug with this, perhaps introduce
> an EXPERIMENTAL CONFIG option, so that random users can simply disable
> it if an issue occurs? Without the need of patching random userspace and
> changing random kernel headers?

In both cases, the patch *exposed* a bug in a related utility
software, it is not that the patch itself is buggy. IMO, waving off
the issue by disabling the feature you just risk the bug in the
related software to hit even harder in some not too distant future.

Uros.

