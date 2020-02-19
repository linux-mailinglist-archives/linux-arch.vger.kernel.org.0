Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499D8164F4B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 20:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSTy2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 14:54:28 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38602 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgBSTy1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 14:54:27 -0500
Received: by mail-qt1-f195.google.com with SMTP id i23so1152555qtr.5
        for <linux-arch@vger.kernel.org>; Wed, 19 Feb 2020 11:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GZ9YXuE15eVQ1m82XL11R20aCz4heFp3V/a8Xs8KTDk=;
        b=ODVc7IEJfwpkmKIQUqFybHBw620ekiVwat/n9Ac5Pfspu1Q4DuB58gmJDIsLNVVBR7
         EpgFHQfjMKK9d8IFitaDW17i9XWGMOavG4yOJnvYsg02g18N65AN1jFk1HcjJ57HAFxd
         Srq5n3/4F5KJ984TW6fFo2kUw679IcjtmPWAcaOWdAcZSMUz+MUTctzRJjL6rDujJi/Y
         EZ5twEFC1HpJvBQ4+fhBpkHpbsTIlkaMeDsXOufmgAI9ouoTt9BWBKfdT8kf7Xff3/mQ
         zcrvJjierCEsOXBM6EBzIlWLE2Y6UQ4XbCxlvapTQbBcZKR3JvyWwjtYZpGRKgkQ/k9/
         vfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GZ9YXuE15eVQ1m82XL11R20aCz4heFp3V/a8Xs8KTDk=;
        b=tbHObyqFx1zO6rWoZ8LOXAivbkQhWSpY8f8PGrzxeJdqpXKrp8yv610+t8wEVoS/zb
         ydH7b1NoZrLC4LlM5ud4QPnyYPNb9bPFgKGDSHCCgWKLNoIRPWFHUk+af9rdC2JhR3/+
         XW5R+MaTBgQISvu7Cb0nYR/Kuq9RRkEvVQOLloxo2IeVRaTIosHpliUrEd+TxOHaORSK
         H96ppJ/5zbOgkGml3FdI+OgC0fyRF60zwL+WelW9de11SadaTg8pkIZTIWv7DE6e1eMq
         5Z0o28jeQDgW94k5C4ucTNouvjsvTBypXVJ9aRuruSuYrNcX9mwLx0OCVvo6rdyptKqL
         cfYA==
X-Gm-Message-State: APjAAAXZXjB+Sz18n1oHdvjBO0t5ALwrMzsrFmlqF7sjA9nMmpGGg/ig
        UAKDBepGnDcz7L+apWspIca6Nw==
X-Google-Smtp-Source: APXvYqwUhupndXBE09xsDkgUA7kwgC2NQShW8nuUAvL8wUSkyIakN42anJqBWpm/nMwac3dxI/meAg==
X-Received: by 2002:aed:3fb7:: with SMTP id s52mr22354651qth.97.1582142065790;
        Wed, 19 Feb 2020 11:54:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p8sm490083qtn.71.2020.02.19.11.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 11:54:25 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4VQO-0006DL-Tx; Wed, 19 Feb 2020 15:54:24 -0400
Date:   Wed, 19 Feb 2020 15:54:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
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
Message-ID: <20200219195424.GW31668@ziepe.ca>
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
> > Godbolt says clang is happy if it is written as:
> >
> >   if (&__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0])
> >
> > Which is probably the best compromise. The type here is const char
> > *[], so it would be a shame to see it go.
> 
> If the "address" is never dereferenced, but only used for arithmetic
> (in a way that the the pointed to type is irrelevant), does the
> pointed to type matter? 

The type is used here:

        if (*pos < start_index)
                return __start___trace_bprintk_fmt + *pos;

The return expression should be a const char **

Presumably the caller of find_next derferences it.

Jason
