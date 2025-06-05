Return-Path: <linux-arch+bounces-12251-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45120ACF56F
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jun 2025 19:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFFC3ADEA8
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jun 2025 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F43C19F42D;
	Thu,  5 Jun 2025 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5zdLkvy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5E1DFF8;
	Thu,  5 Jun 2025 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144719; cv=none; b=OVY6a3fduwQYe73Ppv+wk+4uePHb2wIOF7IB9TegGeI7gcaeDsRRlWsqvjbQu8DZTkKmlpgJUKmmuk+Ykmeixq07apa3c5ngYndBZ2A6UZ914ECsxqLhhVUp8EB3k0HqYRiZZ7imt/svOdwmm1AQd2p0+JjgSAhuF/NlPAbcnSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144719; c=relaxed/simple;
	bh=Y8nWB/WLZe/CCeemauG5YdXkbxl5jf3QmnhrkUgxLHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJA1oouIteb/UFNqly89vb17GQ6/yHVcaMVBMNxnCgZ8AOguyI6c9WpARsKWo1e8weDejtqKOmk8wcx2m4osIrkYyhXTU+jpeNiRloh/omSZbx367Eb64wGuz05G9eRAAESqDREw0SKZy2mcDgLyRdqFk7d10JwckcJ8PChqWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5zdLkvy; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5534edc6493so1518334e87.1;
        Thu, 05 Jun 2025 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749144716; x=1749749516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8nWB/WLZe/CCeemauG5YdXkbxl5jf3QmnhrkUgxLHk=;
        b=N5zdLkvysRKKoShU5FakBBvgRrt++NA9yEn/T/UYXEcUxgZpK58+nj1N/5kXX8UFPA
         +Fh94FcvBkGiMrh54z19QV3zZbZlUBRkV88bx3IikbheV7YJCkcK18/U/qwslLVYrC7F
         lC4VQHmAQCTxKl1ce7Bzdu3jR4760JLPDQ5x6qLJv1nfsO5ZSCOs3sJLHSrVlYbIln9O
         yV3UajJQf/GZvqIahuaopsE/WZJjjBXuyfxxqNzD3ie/rtZdmaBpJSK2DGv/z9essQdX
         ikh6LMy+lDr83yddYeAXVmZCYgT//1MaXIgRxpGnRX1xXmMIrxsDoVP2neAk8RstK8Cp
         eVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749144716; x=1749749516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8nWB/WLZe/CCeemauG5YdXkbxl5jf3QmnhrkUgxLHk=;
        b=eoOyNP0V0vBbA5ynFo4azoKB1Cs5MtfmbzD1BqnV9YD91wACtkz7WCDXoJ/GqnLdmN
         ivOxFnyOQPrnhe/2qlErj7IK6f4/4N5I0az5Rp6gdJtP26gsrpwRabI0pvZN3ylpVtYG
         ljm6JT8HGcImjb6YkVEjCt3yhEBVLyFSI7sPtQD7sHMUL6FQHvQUdsa/mKN4h5N1Od2n
         qbdJXPWYLNsXop3x7VsjXQ3FjVMsZj+oJ3PXePoyB6uPNXM2XKL8noc05dFEUlp2tcQK
         BoU6quEHRC9HdciTy/uZlhQQJYFP3QcZLFkfTDLteN1EHkkanb9vTGE1kBKbF3NApgSH
         z5zg==
X-Forwarded-Encrypted: i=1; AJvYcCVV8RP4YjfUqDTaTbuc/spq1eL5sx/hZ2z+QfVJpkr59Nl1N4s0m2ZI0GzAJf8y6z8CpScaxJFZtlCnq+Ml@vger.kernel.org, AJvYcCWpedeLDigJILyKwbBCM3XWzhDZcLNx3lXARx2YHwMAJtfnWLvx8c822Cqt2Gbx5nZNCHw0v2SM@vger.kernel.org, AJvYcCXIJ/ot/Rv+dVmOP49jH2rOrHq8QjQXst14gIdDMk1OAVoOi/qnT0HU1wcOye9UAnE/QrglqjZ54YR56oxT9K8=@vger.kernel.org, AJvYcCXQzhE3VNlwLSkz/dX2vuGt3cq6USYPT0QPUNs5qjO2Zhp22y4S52AFcXCQtIngD48yzixosDceFgYw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxab7/6exg3hp0PTabilZgZeHgovUeyuBE78D9TJfy7HbponFiQ
	Yb3DN1KqUbMEXBWhlB88HdFYhczoNMybZisctrS+KfMGK/k+WpZk4IO6di74C2pYMF8Af0Yop24
	orYrS01xyh5PdSu70B4yqOX8ITHVGQwc=
X-Gm-Gg: ASbGncthX6oE6txVkEXCoAkDtA71aaKcb5y/bj3eG0Gs7pHi8FlpQEMFIr9eB7MZ+fL
	erw6PmiUmDJx1ADWOfwu/iPzmzytJfmMC75GbgZGc4l5p8J3KNaZrDpWZ0jJjJAWrCBMWKQD/4K
	lV51Lr+DXOurn75e4lQnpn2Bb3L1GbZnIM
X-Google-Smtp-Source: AGHT+IH6Ge5MBQj226ro/trJtTDJEKqfoxutgYQ+NLGhGSTlIr/XkGznsHM3XrTD7wIOs/Zk3MohR7asrPwdDTPC0QU=
X-Received: by 2002:a05:651c:b0f:b0:32a:61cd:81f7 with SMTP id
 38308e7fff4ca-32adfcc5e7amr721251fa.18.1749144715513; Thu, 05 Jun 2025
 10:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127160709.80604-1-ubizjak@gmail.com> <20250127160709.80604-7-ubizjak@gmail.com>
 <02c00acd-9518-4371-be2c-eb63e5d11d9c@kernel.org> <b27d96fc-b234-4406-8d6e-885cd97a87f3@intel.com>
In-Reply-To: <b27d96fc-b234-4406-8d6e-885cd97a87f3@intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 5 Jun 2025 19:31:44 +0200
X-Gm-Features: AX0GCFueg9D52Q5ZKOUZZ4EHnuPhldYsmhABpjmPMClR-F5-yN8HoMwduFUUy98
Message-ID: <CAFULd4Ygz8p8rD1=c-S2MjJniP6vjVNMsWG_B=OjCVpthk0fBg@mail.gmail.com>
Subject: Re: Large modules with 6.15 [was: [PATCH v4 6/6] percpu/x86: Enable
 strict percpu checks via named AS qualifiers]
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	Nadav Amit <nadav.amit@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 7:15=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 6/5/25 07:27, Jiri Slaby wrote:
> > Reverting this gives me back to normal sizes.
> >
> > Any ideas?
>
> I don't see any reason not to revert it. The benefits weren't exactly
> clear from the changelogs or cover letter. Enabling "various compiler
> checks" doesn't exactly scream that this is critical to end users in
> some way.
>
> The only question is if we revert just this last patch or the whole serie=
s.
>
> Uros, is there an alternative to reverting?

This functionality can easily be disabled in include/linux/compiler.h
by not defining USE_TYPEOF_UNQUAL:

#if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
# define USE_TYPEOF_UNQUAL 1
#endif

(support for typeof_unqual keyword is required to handle __seg_gs
qualifiers), but ...

... the issue is reportedly fixed, please see [1], and ...

... you will disable much sought of feature, just ask tglx (and please
read his rant at [2]):

--q--
If the compiler people would have provided a way to utilize the anyway
non-standard name space support in a useful way, I could have spared the
time to bang my head agaist the wall simply because this would have failed
to build in the first place long ago. That just makes me sad.
--/q--

[1] https://lore.kernel.org/bpf/20250429161042.2069678-1-alan.maguire@oracl=
e.com/
[2] https://lore.kernel.org/lkml/20240303235029.555787150@linutronix.de/

Uros.

