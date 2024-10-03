Return-Path: <linux-arch+bounces-7668-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B030498F5F3
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 20:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5644E1F217BF
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC02219D895;
	Thu,  3 Oct 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClGcGw1p"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948C224EA
	for <linux-arch@vger.kernel.org>; Thu,  3 Oct 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727979631; cv=none; b=mtEcaSwaHNOWm7wLGUVFifSlBR++GHfPcuuwvVkitHyWGH/YAC2QfZjKWxFvVw9ze0rDhCQK6AWrerenxyUM+jbKRv3pKDybznZaphX7LvAnzAtxa9Q+qLtShNaZks47+T1x4QdwlRia6osjZpJ54kPKjCEFdvyjglyEhruUOnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727979631; c=relaxed/simple;
	bh=OPHzpIyuAEVyuENdRsgtRgBjbI78VqztnMoMxs6v4zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNSMqbl8GiV9evPPUrWOUxyN3thVoO1vMcDAt2NHVJ4JtAexiKIRACjCBHVQoIjULdkPzxn3Dp/3ttISCd0uPDs8h7QGLC5aswmTCA+eR/NUzVNEF2Bn4eNrVTjau6G0m1er/5Vf3eLbnOBUC1EldayefpzXz9aqWlJdXGk9e5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClGcGw1p; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45b4e638a9aso36931cf.1
        for <linux-arch@vger.kernel.org>; Thu, 03 Oct 2024 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727979629; x=1728584429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPHzpIyuAEVyuENdRsgtRgBjbI78VqztnMoMxs6v4zo=;
        b=ClGcGw1p0bf1ArtsX7OK/wC0c9Bx8FL0YNtsf/Go1BxFWpP9Y82VMGn/lgdNr6aX7T
         mSS6YHsoUkZRTP9Rw57FLtY9zl3e9r0Sf1L8Zd+/afWCfCpZwWvITUJnS/JuFjujh+sB
         KuBKSVUDSG80czxLY28ki+7eXH2Fk7/38BjwriS2XPX/VAWgeB5sj7dz/yGC2+4mACsV
         fsY2HDLIDCa5iZwXKk0JbOgLAr5qgkqs/fa2MlczJZL8Ap89irZRsWfObDYPRzg6ilRj
         tH0FKXBZT7QBKvlgaXW9n10cOuoaceYgdtx8FK9OO22X6jcVWWYaZ6BVjVWhd6pirlmc
         inqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727979629; x=1728584429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPHzpIyuAEVyuENdRsgtRgBjbI78VqztnMoMxs6v4zo=;
        b=iAP1yFE6ZLpu/hnehX7mITz9A6YvYDbnKI6LQgE5hJ/51dxHv7MPFSBoS0oRcE88Oe
         rlI04TDuMvFsKI4112fzIFn6K6P3dYSaJ5KjaVmqM0PIgftDUjXY/TqtSS0UqJBE8rdf
         77RLH+zJk1MOvYDLP1cm+QD2m1419ImRcw9Ez/Lvu7I0GI/oXr/xgiJeX+rtyRlY1Ber
         snsZPbT9eyl9rYrhxdT1Sezew6s/PLg1rg39ZIpmfh+aFFahRg9jPyQRDj4raatGaJfA
         7v2qs9sxPr31Abbza6TK1SMeX1dGl7rVQ4FYT9sfSun10dwT9wrIHMpgSCa6p5KfVapU
         iCaA==
X-Forwarded-Encrypted: i=1; AJvYcCUUsO/1QnXJCyN9r+lZRbHBIUYpiurtrqNqLEP7eoy7NjWCzZKENipH79LUBCO1g1lH5aR6TqEXzc+6@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgOPpDOeQBNKBlMuKafzZxIv1D5Oq5IUdsdJ8H0ZQjXsCVsR2
	fgjMzu5zZX1yhZ/8NDJNsWoFXcLr5ZMtRYVlnsLbkXhcGg3x/E4b5aGDRu6YyJgbwQ6N5/3D1Ri
	b4W5MjZgQwmSaBcJoaYr1cTLbgVJNz7mJP2NX
X-Google-Smtp-Source: AGHT+IHGZSKF56BASKK8GozB2yF2V8PIyDPsPS4fr3yQFHFDS0HG9quwxCeJ5MiYAd0srYGtlNnDajEe0HNMh2na5RM=
X-Received: by 2002:a05:622a:5687:b0:44f:e12e:3015 with SMTP id
 d75a77b69052e-45d9b947144mr205851cf.25.1727979629144; Thu, 03 Oct 2024
 11:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002233409.2857999-1-xur@google.com> <20241002233409.2857999-2-xur@google.com>
 <20241003154143.GW5594@noisy.programming.kicks-ass.net> <CAKwvOdnS-vyTXHaGm4XiLMtg4rsTuUTJ6ao7Ji-fUobZjdBVLw@mail.gmail.com>
 <20241003160309.GY5594@noisy.programming.kicks-ass.net> <CAKwvOd=CRiHitKeYtHH=tmT8yfDa2RSALbYn5uCC8nRq8ud79g@mail.gmail.com>
 <20241003161257.GZ5594@noisy.programming.kicks-ass.net>
In-Reply-To: <20241003161257.GZ5594@noisy.programming.kicks-ass.net>
From: Rong Xu <xur@google.com>
Date: Thu, 3 Oct 2024 11:20:17 -0700
Message-ID: <CAF1bQ=RAizpP-T_sRGpE2-Kjsk_RZD3r_iz_dpn25W+uDzpWOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] Add AutoFDO support for Clang build
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Masahiro Yamada <masahiroy@kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Wei Yang <richard.weiyang@gmail.com>, 
	workflows@vger.kernel.org, x86@kernel.org, "Xin Li (Intel)" <xin@zytor.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Writing the doc with all these code-blocks was not fun either.
We are happy to change if there is a better way for this.

-Rong

On Thu, Oct 3, 2024 at 9:13=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Oct 03, 2024 at 09:11:34AM -0700, Nick Desaulniers wrote:
>
> > > It makes it absolute crap for all of us who 'render' text documents
> > > using less or vi.
> >
> > "It hurts when I punch myself in the face."
>
> Weirdly enough I have a job that entails staring at text documents in
> text editors all day every day :-) sorry for thinking that's a sane
> thing to do.

