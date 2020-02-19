Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84877164ED3
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 20:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgBSTWw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 14:22:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36701 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgBSTWw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 14:22:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id j20so1278301otq.3;
        Wed, 19 Feb 2020 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nGyzNqwmfC+StEGiPL2xQ9nSi3AHwKN4sRF+U5rIpw4=;
        b=JbyfA+6+JJDbDgo5q7DXJkywgq8p9fWfaHY9hcamDR9TIm1I8w5p0TslUp6LsE340e
         Li294B0nCtY/sJUUB+3ldTqvUSUPubHJ3Itp3Yjg4K1QLM4bCa9yrMh8WDC7QkcYc55x
         FVK+j9UdRhw5HtmGQNaLX8F/GtyjcEbFZApN0Ag3jG4VxXN9dIUwvrJOMbtplHukePML
         zAG1lUuE1Orv/jQfCeiFsv3MwuWcPSH6WqCiE0Tj3bUAPABINb+DsIj0c0qHNlO97jy6
         ITSfedy7wCZYK0t3u9u9ENvrs8lXiPtqcCPoQd+DnsxaKpmJnF79JyApAwSvV09bOgDT
         OJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nGyzNqwmfC+StEGiPL2xQ9nSi3AHwKN4sRF+U5rIpw4=;
        b=S1dOFSE+tMBQV6XP9G469B4WZrJVUyU6zBRy0oa62oNhKJVd6XZKOszUBQUB5ueNDh
         zGv+gaAydWuAjsm64PB05LUVrwv9RXBY8DlQE5KWj8Ps90kwYuvzCxIgVd7i6DBhwjL+
         5w8IfYbO6EX2Add4PwD9aglp9t9XP01tyXueshF7SuaL0DhINc0orcBv8Mppw9lmJOtk
         1UV5vmwK6T7NMHIFCvy5Y3lulUDlbbDZNdmfnUFAkbPqn/tTRWV1CDh8sgJEQY8Pbjeg
         OStlvFetd3riEogsJGsuuiG56XpamT6Yr7rhOy10sZeWEOP9ceBzo/FxqjstQWPwhXyA
         NvOw==
X-Gm-Message-State: APjAAAUAQziFsnd1pZOzr2QzcmONoSJoV9KgyLK4/9foiFHUhzDz/ijd
        T8XJbhcDDoXpwMIXQNPfqXY=
X-Google-Smtp-Source: APXvYqxlEJNDcB79lMPiHrXtK79931NtdsnXY6+4CaCPWiQIDJF9SmeBFXKLjspoTxKQ8Ag/rEDtGw==
X-Received: by 2002:a9d:6b84:: with SMTP id b4mr20963596otq.190.1582140170892;
        Wed, 19 Feb 2020 11:22:50 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id t9sm211166otm.76.2020.02.19.11.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 11:22:50 -0800 (PST)
Date:   Wed, 19 Feb 2020 12:22:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20200219192249.GA8840@ubuntu-m2-xlarge-x86>
References: <20200219045423.54190-1-natechancellor@gmail.com>
 <20200219045423.54190-4-natechancellor@gmail.com>
 <20200219093445.386f1c09@gandalf.local.home>
 <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
 <20200219181619.GV31668@ziepe.ca>
 <CAKwvOd=8vb5eOjiLg96zr25Xsq_Xge_Ym7RsNqKK8g+ZR9KWzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=8vb5eOjiLg96zr25Xsq_Xge_Ym7RsNqKK8g+ZR9KWzA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 11:11:19AM -0800, Nick Desaulniers wrote:
> On Wed, Feb 19, 2020 at 10:16 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Feb 19, 2020 at 09:44:31AM -0800, Nick Desaulniers wrote:
> > > Hey Nathan,
> > > Thanks for the series; enabling the warning will help us find more
> > > bugs.  Revisiting what the warning is about, I checked on this
> > > "referring to symbols defined in linker scripts from C" pattern.  This
> > > document [0] (by no means definitive, but I think it has a good idea)
> > > says:
> > >
> > > Linker symbols that represent a data address: In C code, declare the
> > > variable as an extern variable. Then, refer to the value of the linker
> > > symbol using the & operator. Because the variable is at a valid data
> > > address, we know that a data pointer can represent the value.
> > > Linker symbols for an arbitrary address: In C code, declare this as an
> > > extern symbol. The type does not matter. If you are using GCC
> > > extensions, declare it as "extern void".
> > >
> > > Indeed, it seems that Clang is happier with that pattern:
> > > https://godbolt.org/z/sW3t5W
> > >
> > > Looking at __stop___trace_bprintk_fmt in particular:
> > >
> > > kernel/trace/trace.h
> > > 1923:extern const char *__stop___trace_bprintk_fmt[];
> >
> > Godbolt says clang is happy if it is written as:
> >
> >   if (&__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0])
> >
> > Which is probably the best compromise. The type here is const char
> > *[], so it would be a shame to see it go.
> 
> If the "address" is never dereferenced, but only used for arithmetic
> (in a way that the the pointed to type is irrelevant), does the
> pointed to type matter?  I don't feel strongly either way, but we seem
> to have found two additional possible solutions for these warnings,
> which is my ultimate goal. Nathan, hopefully those are some ideas you
> can work with to address the additional cases throughout the kernel?
> 
> -- 
> Thanks,
> ~Nick Desaulniers

Yes, thank you for the analysis and further discussion! I have done some
rudimentary printk debugging in QEMU and it looks like these are produce
the same value:

__stop___trace_bprintk_fmt
&__stop___trace_bprintk_fmt
&__start___trace_bprintk_fmt[0]

as well as

__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt
&__stop___trace_bprintk_fmt != &__start___trace_bprintk_fmt
&__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0]

I'll use the second one once I confirm this is true in all callspots
with both Clang and GCC, since it looks cleaner. Let me know if there
are any objections to that.

Cheers,
Nathan
