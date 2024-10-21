Return-Path: <linux-arch+bounces-8413-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CBA9A9455
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 01:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E43E1F22E1E
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 23:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D0B1FF5EB;
	Mon, 21 Oct 2024 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBMsnG0C"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75581FF029
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729554207; cv=none; b=RQ+fEiAaUgdciyyMdd3ZGfDbp4DzDFDCocYSmkDUvjKGW/Zhrydk+2FUb4PJVvHUFG2vsEnCf9ogvV8K1/rfaqWPzz5XybBOqtQ4fs1MZF61YZfcf7zF1XqVPuM3/pV3c6g3jTFPJIXvhcQCoLyrF+eEfKjuG/vTCnmCu1KcnlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729554207; c=relaxed/simple;
	bh=670Rx8VhAsuQw1rqEOWFlDm06/IQZHXSWxj6k8/pKYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adQy9IY4SkUur4S1gOHjp63uZ3QZArlyGSDuwZZkUhW+FyXP6XOhBxPGYYm/W0lZvoqlMEvB01O/iDCXRmj32UJAWGJABaNO+lc9eCnfyDTd0LZGocoTxys3aIl5ChIAMimtA0+umdoZhwmsrfvzU87vrbWQ57vrL/Z1oxMLGxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBMsnG0C; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460a8d1a9b7so82981cf.1
        for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 16:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729554204; x=1730159004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VH1I9Ut0mQYyKMoQvkGxIgww2ZJ9ePwLy+OSXFMT9R4=;
        b=ZBMsnG0ChHKUl0wQKdVYuYQPqVHsNl+qZhUBU7c+0ggXFcD+1CvWi3OzBlwqutlfER
         SFvWLUc0UP1bPkA827mmxjUJjiP9/yVZ9sHFDbD28KU4ctH+YV/F0mOvwSZbI2xh9dl4
         j6Km0ND0dE528TRBxFPAntNqMh2VAWshGSEKFUznzIpHov13Ij0X+dryYY6CY7N4lpZw
         lJYkVpalqAGenQrv/sKZFNLddgIDtFw7RO/1lLphSxLBw5N6xN51LIrcX7Gg23MtuQdY
         t2Oa5gRbxDDg4TnCQHgEJUMBjFjRldvA/vOdzd9Z9ftNPrE72hMTd+jyUFce+9uyGO6e
         vDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729554204; x=1730159004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VH1I9Ut0mQYyKMoQvkGxIgww2ZJ9ePwLy+OSXFMT9R4=;
        b=ilkgflOXP5hk36TVDfE5diuw7zgQKdAVhIagYbpS35/Iz2Ve7dtZCkA3orfB6FGKdE
         JpF0WJZoiF32f3Ve2c7l3fc4wjsIHp1+LYnOamIQY6YRWZp3ltHQaqhq5ezR0XzLSapW
         NbHkPN8DEDHKb0q5is+NwpPoipj6UbAtBPL3ZU3/2IOwbnWfax+8uCOAM7fYpbNDjVtK
         c4dBLM/y4J+VFQT8wEmGiHFF4i5aqtE3yNLG2LJ9oWqBY3w616uaISP1pIb1TmX0AN59
         ycHT8USgzshuOMURzAMFNI0QV2XWWPQG/QYS/dHaCw86w/8npZ8T7Kilp89KIespvYq6
         /AnA==
X-Forwarded-Encrypted: i=1; AJvYcCW2rG4ICA6H3Y2eCkit9DVGM5AxWOJl7/3fxWOrXbnkxRQ5y0m3mf2/sbiSA/Fm4Wr9v2y+QaOAFeU2@vger.kernel.org
X-Gm-Message-State: AOJu0YzauQ7m/LxG7F5/v6QR4Sz/0/CRnq5HFbqE7tfx318jWibCGpxx
	8LTdPgCaV2qbTkNuegCA/4MoDS78jAQL8vxUIFwGxaFNMVGBP7lqE8Xg8iOO1IdNuRytB4blCTX
	0URQawHucEzhi4M04jGKfbrdBbMUfK3m/IFCq
X-Google-Smtp-Source: AGHT+IGBJEGpd9nQo0o209R0pXE8dMLJ0OAC0OgWVKOeU4WwTY9FO3DmQPqrzs2Q2l7L/01n09HMzEfWkSHfOjpUeOI=
X-Received: by 2002:a05:622a:1827:b0:458:1d2b:35f6 with SMTP id
 d75a77b69052e-46100b9b324mr1762321cf.24.1729554204431; Mon, 21 Oct 2024
 16:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-4-xur@google.com>
 <CAK7LNARqnhZuDf75_juBtdK0GV8jL_aDjnuyU=-8zjdCZetF1g@mail.gmail.com>
In-Reply-To: <CAK7LNARqnhZuDf75_juBtdK0GV8jL_aDjnuyU=-8zjdCZetF1g@mail.gmail.com>
From: Rong Xu <xur@google.com>
Date: Mon, 21 Oct 2024 16:43:12 -0700
Message-ID: <CAF1bQ=S1Hv=fJxk38dYkRTAXWQO_4W8QLTfbNRbihg8UvUKvGQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] Change the symbols order when --ffuntion-sections
 is enabled
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

On Sun, Oct 20, 2024 at 7:15=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Tue, Oct 15, 2024 at 6:33=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> >
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
> > a suffix to "..".
>
>
>
> Why not for ".text.fixup"?
>
> $ git grep --name-only '\.text\.fixup' | xargs sed -i
> 's/\.text\.fixup/.text..fixup/g'
>

I did not move .text.fixup because it currently groups together with TEXT_M=
AIN.

Yes. For all the kernel annotated sections, we can replace them with a
".." string.
For compiler generate strings, like .unlikely, .hot, and .split, we
need a compiler change
for that (maybe under an option). The process will be long.
Or we can use an extra script, like objcopy to change them?

>
>
> I do not know how to rename other sections that are generated by compiler=
s.
>
>
>
>
> > This patch modifies the order of subsections within the
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
> >  include/asm-generic/vmlinux.lds.h | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index eeadbaeccf88..5df589c60401 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -554,9 +554,21 @@
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
> > +#define TEXT_TEXT                                                     =
 \
>
>
> Why did you do this conditionally?
>
> You are making this even more unmaintainable.

Again, we don't want to change the default build.

If you think the change can apply to the default build, we would be
happy to remove the condition.

>
>
>
>
>
> > +               ALIGN_FUNCTION();                                      =
 \
> > +               *(.text.asan.* .text.tsan.*)                           =
 \
> > +               *(.text.unknown .text.unknown.*)                       =
 \
> > +               *(.text.unlikely .text.unlikely.*)                     =
 \
> > +               . =3D ALIGN(PAGE_SIZE);                                =
   \
> > +               *(.text.hot .text.hot.*)                               =
 \
> > +               *(TEXT_MAIN .text.fixup)                               =
 \
> > +               NOINSTR_TEXT                                           =
 \
> > +               *(.ref.text)
> > +#else
> >  #define TEXT_TEXT                                                     =
 \
> >                 ALIGN_FUNCTION();                                      =
 \
> >                 *(.text.hot .text.hot.*)                               =
 \
> > @@ -566,6 +578,7 @@
> >                 NOINSTR_TEXT                                           =
 \
> >                 *(.ref.text)                                           =
 \
> >                 *(.text.asan.* .text.tsan.*)
> > +#endif
> >
> >
> >  /* sched.text is aling to function alignment to secure we have same
> > --
> > 2.47.0.rc1.288.g06298d1525-goog
> >
> >
>
>
> --
> Best Regards
> Masahiro Yamada

