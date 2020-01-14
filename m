Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E47613B467
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 22:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgANVdM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 16:33:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35118 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANVdM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 16:33:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id j1so16077886lja.2
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 13:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5uoKw2YKLElJKDx+jK5wl0K2xjBXMt47XAsAkyAM+o=;
        b=gVkyh4tPO8RK11oXNRTkFnFw5qS02VpB8fRn7yuyjXBrIM8r/+uUtu3n5AJSu/v+0r
         3KVUAw32daILdFTdwNmZ41g6fmO4U+5YEKf3aZPOaD0BxhRqx8Hhmkwlmzo36zFaxnqP
         lOdeXPMNVWW1hl8kB5QPM3J99EYMRT9fPNA7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5uoKw2YKLElJKDx+jK5wl0K2xjBXMt47XAsAkyAM+o=;
        b=cttU/MkPpernA7j1f9QZarLh0oOv2yIbYp8gpLFxsDMdKsUeZyW/E/dG/sGISg/VzQ
         V6YHy71QMHe9wElNnG11bixqAK6Y8uufx9rYAdDOTHwlrQUBFZfS5wRtcLbRtRKhL1vF
         2QqkXfhw1F4fz7Aay08mJ0Zt5+2oRtWn/ztkLnA9Gk5eOOuPXlWYwHO9MFxcqS7VtxWJ
         VxNO1nGf/YbGiVvXuO15ajmI1D5vQrWhcriBnv6hGZPlFnJXT8dyl1iu4U4sZz799HCl
         E5P1U2IL5Gnh7VqUBzhGtkPpxAVsWll9IT3r8nNJSd++NXurFyOmJtRyPyWxlWXRwOVA
         Ckfw==
X-Gm-Message-State: APjAAAV6p/TOdy5G/7Wnk/2etsZPEwcrBiuAOflvS9mk6jkKKTa0jrCQ
        Iw4hhc+GgbibXw8XN503H0GFjzXveU0=
X-Google-Smtp-Source: APXvYqwT3kAgaaeSDMmOeUCWtF9RuiAr5C2FWzNo/P1gWUmtWGLvVlaqCvGHhZ50ZtC8lZGPc+068Q==
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr15865103ljh.28.1579037588132;
        Tue, 14 Jan 2020 13:33:08 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 195sm8010968ljj.55.2020.01.14.13.33.06
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:33:07 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id u1so16087691ljk.7
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 13:33:06 -0800 (PST)
X-Received: by 2002:a2e:9510:: with SMTP id f16mr15481129ljh.249.1579037586642;
 Tue, 14 Jan 2020 13:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-2-vgupta@synopsys.com>
In-Reply-To: <20200114200846.29434-2-vgupta@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jan 2020 13:32:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjChjfOaDnGygOJpC36R6mtT7=Xf6wWTzD_wLJm=quu0Q@mail.gmail.com>
Message-ID: <CAHk-=wjChjfOaDnGygOJpC36R6mtT7=Xf6wWTzD_wLJm=quu0Q@mail.gmail.com>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 14, 2020 at 12:09 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> There are 2 generic varaints of strncpy_from_user() / strnlen_user()
>  (1). inline version in asm-generic/uaccess.h

I think we should get rid of this entirely. It's just a buggy garbage
implementation that nobody should ever actually use.

It does just about everything wrong that you *can* do, wrong,
including doing the NUL-filling termination of standard strncpy() that
"strncpy_from_user()" doesn't actually do.

So:

 - the asm-generic/uaccess.h __strncpy_from_user() function is just
horribly wrong

 - the generic/uaccess.h version of strncpy_from_user() shouldn't be
an inline function either, since the only thing it can do inline is
the bogus one-byte access check that _barely_ makes security work (you
also need to have a guard page to _actually_ make it work, and I'm not
atr all convinced that people do).

the whole thing is just broken and should be removed from a header file.

>  (2). optimized word-at-a-time version in lib/*

That is - outside of the original x86 strncpy_from_user() - the only
copy of this function that historically gets all the corner cases
right. And even those we've gotten wrong occasionally.

I would suggest that anybody who uses asm-generic/uaccess.h needs to
simply use the generic library version.

             Linus
