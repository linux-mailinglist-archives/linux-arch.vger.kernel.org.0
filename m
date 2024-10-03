Return-Path: <linux-arch+bounces-7662-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BDF98F3AC
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 18:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B7D281189
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E7C1A704D;
	Thu,  3 Oct 2024 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htZCYnHn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A621A7057
	for <linux-arch@vger.kernel.org>; Thu,  3 Oct 2024 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971909; cv=none; b=hEeVJxr1JKX6e4N+ykvVxTFb3fuIemeGmHNyoORfLzg9I2GkTC28HVnjP/8mtFK0GmAEavCYcp2QdQNEx+oxcel9vDAP1+PYL/i5vlQ0Zbh3m5bcerkJ56agSkvOYErq812FEMLAc6tmgYN3crLDC0tQGSantFQmp6rwwZ8YSgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971909; c=relaxed/simple;
	bh=KAJhNktsKQBL31h4FFeDeoZJgORcWmVqd2YZcjRTjio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEAPy+CPA+DtsWBIbhDokFLn3LCygPvz/1hCkol3LK1o/ZRgq52r82nONtKdMGdzTBxg+rnXATDF5bLxIiz5OWi8WDGta/TQwySCfEuQsQXdagh98YuE16EssbZGml+PKetzffQrzm2Ie22in0qBsM2Q+ddzlEYDAtVn8tSNCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htZCYnHn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cd0b5515fso745499f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 03 Oct 2024 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727971906; x=1728576706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8M94Szf86aflf7GYtGP4IFREoq5t6mzeSASTe2kb0E=;
        b=htZCYnHnXDGWCP+6zbxUw779bJe8vH6gOTcHBU0FS6B+yhLxoYKbh3SeI9QwfA95m7
         OUUCpDRNaFtGYJMc84CNmcWcJNAJc/2pnjuJkMQy1CbQJbZVmfsl9/udA67Zkr33hyMV
         YKJtPC0B25j8jGWbG5CZy1BRX9K4QgmsZ0fZ0/PUX/wBVk+12sHBFBI+mMCdnWM2A/xB
         M4D995eTb2Op1U6It1TzoW4+rp9IkCmpbZMGxDK1CICnRODHIhNEHZJGj7Z7UFMssR1s
         rqfaObnFpqU9kAN5Uxw0VzHDv5ddSv4E3HJR0/I62I0XkCHnUfnG3tTcQmeas7S1199s
         SxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971906; x=1728576706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8M94Szf86aflf7GYtGP4IFREoq5t6mzeSASTe2kb0E=;
        b=cMbG/G5tT4tQV50+5fzsGs/+ZJ9TBzRdiiw9A7eY+AVcLIQaNp3fKK/edKCT3Yx6rX
         Jf3BdPS50grF4wN3/QAQmL83nqy7OaHN/BhiydF+Wqpqo5dynvU/ajvxwjG12qDctzn1
         rJJE9lL+4SgNBVhn9eW+I44oz9yiYURDz7/RKwUuyTWM/cvV0bUI/Cs9N4qGk5+imw66
         /eWcxWd37wJ2EuL9ri1VsR1RriRSo3rVdpficnehNvU+jDVU3kdUQ1aLD2cH+/sTSHaS
         X3Odo8iW7bfc4kjOjHC4Bo6oNccUs28mCr651hkP4k52ayaNHDOdaW1Eivv2jslGNW5C
         7OlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7BsUwJm+my3Jto/auRQaIY43+DjJJkstzN/hLDW96uJcBz6Xq3D8F/nH6EiiK8NupXN3NoIHvKYsx@vger.kernel.org
X-Gm-Message-State: AOJu0YwLD0OwCH8/XRuzjWees7FU+iO+btnhTvEyC/Wo1bVn6l2dSMN0
	k+6TSKr223tw6JBihQ5EHn7xRlk3nEMrIY8Y0JQ6NSoEblgNos9ukH5pikDaELK4KiFZYTBCN8x
	Tptkkvep6+ITXsiojMUMPXNWeVTvQPrZE2qqR
X-Google-Smtp-Source: AGHT+IGsVwokVwDnq0q9EW2iHbb+PYH+PmCbmotDyShkoPWSykbINIhoAZtW8xfR6197nX/vMfmDWCNcz9sMeU0B/yE=
X-Received: by 2002:a05:6000:4009:b0:37c:c605:218b with SMTP id
 ffacd0b85a97d-37cfb9c8d6cmr4943794f8f.35.1727971905843; Thu, 03 Oct 2024
 09:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002233409.2857999-1-xur@google.com> <20241002233409.2857999-2-xur@google.com>
 <20241003154143.GW5594@noisy.programming.kicks-ass.net> <CAKwvOdnS-vyTXHaGm4XiLMtg4rsTuUTJ6ao7Ji-fUobZjdBVLw@mail.gmail.com>
 <20241003160309.GY5594@noisy.programming.kicks-ass.net>
In-Reply-To: <20241003160309.GY5594@noisy.programming.kicks-ass.net>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 3 Oct 2024 09:11:34 -0700
Message-ID: <CAKwvOd=CRiHitKeYtHH=tmT8yfDa2RSALbYn5uCC8nRq8ud79g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] Add AutoFDO support for Clang build
To: Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
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

On Thu, Oct 3, 2024 at 9:03=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Oct 03, 2024 at 08:51:51AM -0700, Nick Desaulniers wrote:
> > On Thu, Oct 3, 2024 at 8:42=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Wed, Oct 02, 2024 at 04:34:00PM -0700, Rong Xu wrote:
> > > > +6) Rebuild the kernel using the AutoFDO profile file with the same=
 config as step 1,
> > > > +    (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
> > > > +
> > > > +      .. code-block:: sh
> > > > +
> > > > +         $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file
> > > > +
> > >
> > >
> > > Can this be done without the endless ... code-block nonsense?
> >
> > Dunno, I think it looks pretty nice once rendered. Makes it
>
> It makes it absolute crap for all of us who 'render' text documents
> using less or vi.

"It hurts when I punch myself in the face."

https://docs.kernel.org/ is where we point people to, and what we
should be optimizing for (IMO).  Jonathan, do we have a policy about
using code-block consistently throughout the kernel docs or not?
Otherwise, this complaint smells like "non-technical non-sense" to me.

--=20
Thanks,
~Nick Desaulniers

