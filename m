Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4824164C60
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgBSRoo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:44:44 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36862 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBSRoo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 12:44:44 -0500
Received: by mail-pj1-f67.google.com with SMTP id gv17so372031pjb.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Feb 2020 09:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Zerwr5LVoD9w0G00G1YsmnKd+u52a5G2yVAzT73CuQ=;
        b=ezxabv3hlXaPKMrbyel92GCxKOdqEfJfkncTl9L1UwG6liI1neuaZftEVFBsHwlFGi
         ildP/XITFnjN+SBQsZOKh01ai+2P7DSunNk4ZxKbBkdxzVx5E2JFakDUiOwg2LzOmv6g
         kOn0EEwkPhT5wmsYUqUuG03F9EajzmECYOKF/X3EmUva/uldBTWbjlnlxTB/bufIEoEA
         f39vAdwOJe1DBsTeNBwAth2+QIXKU4Z383+etxjE9atpUHqRsLcFta4Z8kYt6MrFzQcw
         aOVgxiFcJxB0D/PMlQ1uKNxNRTolrBFoXqNOdRp5kMpKrH7MMqL9KAUM1eWk1NDA5CFy
         eKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Zerwr5LVoD9w0G00G1YsmnKd+u52a5G2yVAzT73CuQ=;
        b=EcgRpQnG6z580V2DWeECP+xm+LLki55CQ8rEPum6qRDJNJE/TbwzkIig/DmawXEHpg
         cPuTwM8qh6h9uZI8vFXs9YtnpAQ7X8WZf7fMjLoEGTfrjUw6OkD0/tkWg9n1Ab9H2+Lk
         eqb/vp/CFefN9zkLtr6TNELRSAi7zAcS0n5gdJvaBdaAalIKtOJBEE8Z5maqCBzQ+Sio
         DYcXkfbemE91dNA4nJOeSsomTNeRgZGbeqZ/cDuvKkcPnRBjVtyU2FDmgUYdkXLe3aDb
         TMQVJP+jjwbyXaM6ls9QXob+c++zEnLxLVB6kQdMJrb9xbS41zw/0LLVPBtuksO0UWxL
         eXkQ==
X-Gm-Message-State: APjAAAWIJH7/AHbenHlMAEe8fovqUaTeKlo/Qsiu98/fKB0qClIWChH3
        sy+940339Qjd0++dy7UgUzL8HhWtmxLKkXYvGVTi7w==
X-Google-Smtp-Source: APXvYqwgwaJwqCbIGiJG/t9AN5GA3UaekcGZBPD9itMUe9n7Ox0RNcbqUdR+MZqmN6x0VvswiWfk9cfEyYh8GYYpsCY=
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr26529137plo.179.1582134282820;
 Wed, 19 Feb 2020 09:44:42 -0800 (PST)
MIME-Version: 1.0
References: <20200219045423.54190-1-natechancellor@gmail.com>
 <20200219045423.54190-4-natechancellor@gmail.com> <20200219093445.386f1c09@gandalf.local.home>
In-Reply-To: <20200219093445.386f1c09@gandalf.local.home>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Feb 2020 09:44:31 -0800
Message-ID: <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
To:     Steven Rostedt <rostedt@goodmis.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 6:34 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 18 Feb 2020 21:54:20 -0700
> Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> > Clang warns:
> >
> > ../kernel/trace/trace.c:9335:33: warning: array comparison always
> > evaluates to true [-Wtautological-compare]
> >         if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
> >                                        ^
> > 1 warning generated.
> >
> > These are not true arrays, they are linker defined symbols, which are
> > just addresses so there is not a real issue here. Use the
> > COMPARE_SECTIONS macro to silence this warning by casting the linker
> > defined symbols to unsigned long, which keeps the logic the same.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/765
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  kernel/trace/trace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index c797a15a1fc7..e1f3b16e457b 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -9332,7 +9332,7 @@ __init static int tracer_alloc_buffers(void)
> >               goto out_free_buffer_mask;
> >
> >       /* Only allocate trace_printk buffers if a trace_printk exists */
> > -     if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
> > +     if (COMPARE_SECTIONS(__stop___trace_bprintk_fmt, !=, __start___trace_bprintk_fmt))
>
> Sorry, but this is really ugly and unreadable. Please find some other
> solution to fix this.
>
> NAK-by: Steven Rostedt
>

Hey Nathan,
Thanks for the series; enabling the warning will help us find more
bugs.  Revisiting what the warning is about, I checked on this
"referring to symbols defined in linker scripts from C" pattern.  This
document [0] (by no means definitive, but I think it has a good idea)
says:

Linker symbols that represent a data address: In C code, declare the
variable as an extern variable. Then, refer to the value of the linker
symbol using the & operator. Because the variable is at a valid data
address, we know that a data pointer can represent the value.
Linker symbols for an arbitrary address: In C code, declare this as an
extern symbol. The type does not matter. If you are using GCC
extensions, declare it as "extern void".

Indeed, it seems that Clang is happier with that pattern:
https://godbolt.org/z/sW3t5W

Looking at __stop___trace_bprintk_fmt in particular:

kernel/trace/trace.h
1923:extern const char *__stop___trace_bprintk_fmt[];

(Should be `extern const void __stop___trace_bprintk_fmt;` void since
we don't access any data or function from that symbol, just compare
its address)

kernel/trace/trace_printk.c
260: start_index = __stop___trace_bprintk_fmt - __start___trace_bprintk_fmt;

(Should be `start_index = (uintptr_t)__stop___trace_bprintk_fmt -
(uintptr_t)__start___trace_bprintk_fmt;`) (storing the result in an
int worries me a little, but maybe that refactoring can be saved for
another day)

kernel/trace/trace.c
9335: if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)

(Should be `if (&__stop___trace_bprintk_fmt -
&__start___trace_bprintk_fmt)`.  That's not a significant change to
the existing code, and is quite legible IMO)

Steven, thoughts?

[0] http://downloads.ti.com/docs/esd/SPRUI03/using-linker-symbols-in-c-c-applications-slau1318080.html
-- 
Thanks,
~Nick Desaulniers
