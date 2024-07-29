Return-Path: <linux-arch+bounces-5682-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8B193FFE2
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 22:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD5D1C22691
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 20:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03C418C324;
	Mon, 29 Jul 2024 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/nnWeya"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4761891B2
	for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2024 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286526; cv=none; b=oAefmkCGzVeSjS3ig3rJ1u96cCDXrVPSL6fWflSF6ejqz1HF4/Mq3KD68gV/LPcaZZ/KXdHQtWqqwzWF5Q4NuWcaJDMk9p3myOwK+tlKxaWmiYJCbTar4hQ/xufsYgYA34EOVjBc9zTzLOJJevacOx8TvnCfLEniXbwMg3lIN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286526; c=relaxed/simple;
	bh=RTz+0z5SbA8fg9idABtdR1W3LTdJAfQ+K1FoGhBcJKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/BelTWuM11UcjGv6Q7+/OYd89i86VFwHb/gmSVRejSU4aa0tCcnz9ZxFDA1ZI+2cGmO+y4oVmHqz9AFitM0+tbmFf1YON5UbQLI2EbLlXhL19IPQgUwPENYzlqTG2kkO008GDYotYgSp3f22YydgU9S4G8D2pVlgnDxkWCQIfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h/nnWeya; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44fdc70e695so110531cf.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2024 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722286522; x=1722891322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niejWPzSGiHspwj4YntTxK5/QOZFWVp8np2sDleyrVI=;
        b=h/nnWeyaW27Ao2xvbbFSE/Zt2VJmO48EkAeQz0RZj8F23e7gNiryg8lymrcGLWEWT7
         fHdVAEg0XPtUc0g56RjGO+qOEix/2Io800UeFfwXdUZLQrKZZtAJdCuWJYiuVg/8QvDQ
         YEcOLiM3HeSBtMi82IDcBqR397rtWDLLuUIBJQ+qJhfZJPuDB4Vme1SjbtedSxs0OC7y
         97Cl5VKseASfQI2QSiqLovTiSBLLL6edYy3S1Bd0khZUsKr1nwQOPdH3Kub/5Glj8GBN
         M3RELBvQnEbtI0qYiF2z6Id20NHzjZeQJ2G1SE3uvcHxiWgH4MwXwNukN4MOuRHVTcJ9
         cb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286522; x=1722891322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niejWPzSGiHspwj4YntTxK5/QOZFWVp8np2sDleyrVI=;
        b=MRjXA9NWF4bvz/UqjxMpiUGgbbrqMNAJqM5Rpp54OIxSCec0OAuc/TF6cZGfKktz/r
         ickv3ZDbrRDLtarqU/6iuOrLi+5OUSWn/sZ7M0V5jAPWaN5m9zrwydkcU/DvZEWXkxZp
         5lseWFiqhCQgD8AzvWt42fpbfUNr16kGMaZaOsMNyKst3XkINUUbyWRbqw4rHXL302XB
         eLqclQASGS6Nfk6yYslNUn2RV4eWow1ti9LzSdAoXrmr93mg2xTj1vC6uQxDou9uRrvP
         C1l8FgJfQZCLuJhT808+EWYT7+X/3sLp5DAhjWxy0x+Y8dIOGRD9bFov/yIUGVao8Kg9
         wX2w==
X-Forwarded-Encrypted: i=1; AJvYcCWplTDkq49m1cspe65c7ZSNRz2EGWwCHg14ZGEcOEtYh3iy3oVGpzagtQ0mnZI2A144HbQzzL2S05RmIXKf/GwzG3E0JbBAMwF6Hg==
X-Gm-Message-State: AOJu0Yw/JtUxPb3Ky1bxXHBji657HYM3KZvPsYSF2RDB3uqXlfYp5QhS
	0J8ibQxk+JsmbHoToydHMiUiDxwHknduGy+pscSheZPDmgqZ0eLVkrEJvJ+GsvA8Qu+sJ4kZv6r
	DVsz6DOWefKLtNRWL3fEtH//OCnu7ws19Aayj
X-Google-Smtp-Source: AGHT+IH2rSZTSsniocXI2j9VEsSuvZAH/+8U38Hr61bPybhBcITR+1rWGMzIbas1ALvho8R2h8RifAfAD1wu6fS6OdI=
X-Received: by 2002:ac8:5910:0:b0:447:eaaa:c852 with SMTP id
 d75a77b69052e-45032ac32c8mr1554811cf.23.1722286521955; Mon, 29 Jul 2024
 13:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728203001.2551083-1-xur@google.com> <20240728203001.2551083-4-xur@google.com>
 <20240729093405.GC37996@noisy.programming.kicks-ass.net>
In-Reply-To: <20240729093405.GC37996@noisy.programming.kicks-ass.net>
From: Rong Xu <xur@google.com>
Date: Mon, 29 Jul 2024 13:55:10 -0700
Message-ID: <CAF1bQ=QgBBEBt1sZYM0HfGf_NhC+cX73Vf+wcu7dSsZ639EGXQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] Change the symbols order when --ffuntion-sections is enabled
To: Peter Zijlstra <peterz@infradead.org>
Cc: Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	David Li <davidxl@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, John Moon <john@jmoon.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Mike Rapoport <rppt@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, Rafael Aquini <aquini@redhat.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Eric DeVolder <eric.devolder@oracle.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Benjamin Segall <bsegall@google.com>, Breno Leitao <leitao@debian.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Brian Gerst <brgerst@gmail.com>, 
	Juergen Gross <jgross@suse.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Kees Cook <kees@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Xiao Wang <xiao.w.wang@intel.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:34=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, Jul 28, 2024 at 01:29:56PM -0700, Rong Xu wrote:
> > When the -ffunction-sections compiler option is enabled, each function
> > is placed in a separate section named .text.function_name rather than
> > putting all functions in a single .text section.
> >
> > However, using -function-sections can cause problems with the
> > linker script. The comments included in include/asm-generic/vmlinux.lds=
.h
> > note these issues.:
> >   =E2=80=9CTEXT_MAIN here will match .text.fixup and .text.unlikely if =
dead
> >    code elimination is enabled, so these sections should be converted
> >    to use ".." first.=E2=80=9D
> >
> > It is unclear whether there is a straightforward method for converting
> > a suffix to "..". This patch modifies the order of subsections within t=
he
> > text output section when the -ffunction-sections flag is enabled.
> > Specifically, it repositions sections with certain fixed patterns (for
> > example .text.unlikely) before TEXT_MAIN, ensuring that they are groupe=
d
> > and matched together.
> >
> > Note that the limitation arises because the linker script employs glob
> > patterns instead of regular expressions for string matching. While ther=
e
> > is a method to maintain the current order using complex patterns, this
> > significantly complicates the pattern and increases the likelihood of
> > errors.
> >
> > Co-developed-by: Han Shen <shenhan@google.com>
> > Signed-off-by: Han Shen <shenhan@google.com>
> > Signed-off-by: Rong Xu <xur@google.com>
> > Suggested-by: Sriraman Tallam <tmsriram@google.com>
> > Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index 5703526d6ebf..f3de66bda293 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -582,9 +582,21 @@
> >   * during second ld run in second ld pass when generating System.map
> >   *
> >   * TEXT_MAIN here will match .text.fixup and .text.unlikely if dead
> > - * code elimination is enabled, so these sections should be converted
> > - * to use ".." first.
> > + * code elimination or function-section is enabled. Match these symbol=
s
> > + * first when in these builds.
> >   */
> > +#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LT=
O_CLANG)
> > +#define TEXT_TEXT                                                    \
> > +             *(.text.asan.* .text.tsan.*)                            \
> > +             *(.text.unknown .text.unknown.*)                        \
> > +             *(.text.unlikely .text.unlikely.*)                      \
> > +             ALIGN_FUNCTION();                                       \
>
> Why leave the above text sections unaligned?

They are considered cold text. They are not aligned before the change.
But I have no objections to making it aligned.

(Sorry if you receive a duplicated message. I'm resending this in
plain text mode.)

>
> > +             *(.text.hot .text.hot.*)                                \
> > +             *(TEXT_MAIN .text.fixup)                                \
> > +             NOINSTR_TEXT                                            \
> > +             *(.ref.text)                                            \
> > +     MEM_KEEP(init.text*)
> > +#else
> >  #define TEXT_TEXT                                                    \
> >               ALIGN_FUNCTION();                                       \
> >               *(.text.hot .text.hot.*)                                \
> > @@ -594,7 +606,8 @@
> >               NOINSTR_TEXT                                            \
> >               *(.ref.text)                                            \
> >               *(.text.asan.* .text.tsan.*)                            \
> > -     MEM_KEEP(init.text*)                                            \
> > +     MEM_KEEP(init.text*)
> > +#endif
> >
> >
> >  /* sched.text is aling to function alignment to secure we have same
> > --
> > 2.46.0.rc1.232.g9752f9e123-goog
> >

