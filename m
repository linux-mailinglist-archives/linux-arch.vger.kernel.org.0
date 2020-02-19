Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07503164D7C
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 19:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBSSQW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 13:16:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45920 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgBSSQV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 13:16:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id d9so882022qte.12
        for <linux-arch@vger.kernel.org>; Wed, 19 Feb 2020 10:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L3uNdVhyvZUZMuONp/GCn48zcnEYXAubnE18F0EpTYo=;
        b=fgvJbvEH/Gwc8c+GGSSzc8CRe7dKArbQeuM7TCQXWN9NSMQRyIIGLsjoZiK95AGFHy
         YKVGCWTrXC7zy3J7kd4QvE+d5oFpLNpp5KWYh+Wu4gphonXZiY1tpkmVJ7spFgdPB/7F
         86b9rMJQZ/ppDaQihWkHpPo6cIjtVKrAOpmIut1GNAE6g8gn6kms+YEvN5IPLs0QiHr0
         9RD6LrC61uMCPHWBALwkRKsYx9Pr4WSEkElty5oc8QEqu9j9Tycizdz9tqBKpGcTofbx
         +jURzssSi9PEYE8K5qgbkAB5UzDQ03yYv0YmUA4On5GyN2e/XuF0m8YuOgav0oufiVn3
         cskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L3uNdVhyvZUZMuONp/GCn48zcnEYXAubnE18F0EpTYo=;
        b=Pvfipt6PIEC6bpCR3iwJ0SIqWjy6xhmktEt16QXX5aeH1NFY7Y3u1PP85oOnqJKOS+
         bf9fQVn0DKw0mG5oZdM/+23MJ4dNu49n4ts0ZOnVNk1GoZBsjIkEwIQxgmoqHUt5FLlQ
         JlcLcCy84cDRKZTKcuNA6nGtJGf8Tltvx2T39vYqRfr/vy6XCzQBKLE3cGJJGZqUu2QD
         +BybCx4KO86PHmdQSYMoGCeUfVB8liFRHR+lLKUXma+HOa+2eIleOfXJTBHAwo6P+eMz
         pSavO3VSh+gJVZylMgoS2msZs6bgdKzgZFY2HIhLybbExEZikqq/9sP0EsbKUfPQ875D
         Tlyw==
X-Gm-Message-State: APjAAAUzwvjXIbELjk+Au1WUq8uH2fD6/tKJqUlktnej/a3utm81j+QT
        SK0fouGdZG9PIkOmXaIAao0WRA==
X-Google-Smtp-Source: APXvYqx7BLkUJdcYX7+yBiOE3TbwLXzLrFnlr9aCs+2LjYI6+iSMS9Q/QMToPsqB+g6BrST8LbIhfw==
X-Received: by 2002:ac8:958:: with SMTP id z24mr23429096qth.40.1582136180447;
        Wed, 19 Feb 2020 10:16:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p18sm233866qkp.47.2020.02.19.10.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 10:16:20 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4TtT-0004LS-IK; Wed, 19 Feb 2020 14:16:19 -0400
Date:   Wed, 19 Feb 2020 14:16:19 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
Message-ID: <20200219181619.GV31668@ziepe.ca>
References: <20200219045423.54190-1-natechancellor@gmail.com>
 <20200219045423.54190-4-natechancellor@gmail.com>
 <20200219093445.386f1c09@gandalf.local.home>
 <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 09:44:31AM -0800, Nick Desaulniers wrote:
> On Wed, Feb 19, 2020 at 6:34 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 18 Feb 2020 21:54:20 -0700
> > Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > > Clang warns:
> > >
> > > ../kernel/trace/trace.c:9335:33: warning: array comparison always
> > > evaluates to true [-Wtautological-compare]
> > >         if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
> > >                                        ^
> > > 1 warning generated.
> > >
> > > These are not true arrays, they are linker defined symbols, which are
> > > just addresses so there is not a real issue here. Use the
> > > COMPARE_SECTIONS macro to silence this warning by casting the linker
> > > defined symbols to unsigned long, which keeps the logic the same.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/765
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > >  kernel/trace/trace.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > > index c797a15a1fc7..e1f3b16e457b 100644
> > > +++ b/kernel/trace/trace.c
> > > @@ -9332,7 +9332,7 @@ __init static int tracer_alloc_buffers(void)
> > >               goto out_free_buffer_mask;
> > >
> > >       /* Only allocate trace_printk buffers if a trace_printk exists */
> > > -     if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
> > > +     if (COMPARE_SECTIONS(__stop___trace_bprintk_fmt, !=, __start___trace_bprintk_fmt))
> >
> > Sorry, but this is really ugly and unreadable. Please find some other
> > solution to fix this.
> >
> > NAK-by: Steven Rostedt
> >
> 
> Hey Nathan,
> Thanks for the series; enabling the warning will help us find more
> bugs.  Revisiting what the warning is about, I checked on this
> "referring to symbols defined in linker scripts from C" pattern.  This
> document [0] (by no means definitive, but I think it has a good idea)
> says:
> 
> Linker symbols that represent a data address: In C code, declare the
> variable as an extern variable. Then, refer to the value of the linker
> symbol using the & operator. Because the variable is at a valid data
> address, we know that a data pointer can represent the value.
> Linker symbols for an arbitrary address: In C code, declare this as an
> extern symbol. The type does not matter. If you are using GCC
> extensions, declare it as "extern void".
> 
> Indeed, it seems that Clang is happier with that pattern:
> https://godbolt.org/z/sW3t5W
> 
> Looking at __stop___trace_bprintk_fmt in particular:
> 
> kernel/trace/trace.h
> 1923:extern const char *__stop___trace_bprintk_fmt[];

Godbolt says clang is happy if it is written as:

  if (&__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0])

Which is probably the best compromise. The type here is const char
*[], so it would be a shame to see it go.

I think this warning is specific to arrays and is designed to detect
programmer errors like:
  int a[1];
  int b[1];
  return a < b;

Where the author intended to use memcmp()

Jason
