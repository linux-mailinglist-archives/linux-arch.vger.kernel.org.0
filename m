Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5303A36D9
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jun 2021 00:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhFJWMg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 18:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFJWMg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jun 2021 18:12:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350ECC061574
        for <linux-arch@vger.kernel.org>; Thu, 10 Jun 2021 15:10:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u24so34846775edy.11
        for <linux-arch@vger.kernel.org>; Thu, 10 Jun 2021 15:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IH1SveIFJ5wJ6kocsX0s8v3WiB0uqtridXReuF2KUMY=;
        b=Qzof8FNEW2Ba5XPZGpDfZSR6rdtd6WGsu717h8Er0yjM+Qrz/xmDEYF47olKQxMaDV
         /WuPvFIxyme1vchmGP1HhMrAqH5OzNDJ6D669STTMCTBS8PPP8U2SeAmmSAiNv3xHWUT
         sYS5gTDilCKxc+IrHBQDdFNyeZ8axOedobMUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IH1SveIFJ5wJ6kocsX0s8v3WiB0uqtridXReuF2KUMY=;
        b=XQwS4Q+18gBAG16gIDBVjT59dcOcI5+W0UsdLdns4803Kw9f7yqs7rQn6C046zBt4G
         vpiNrQCzoHFjCz1YJI2s0hZF8KcZapLZc+NFAK0hKMxW+YUdq3M7QnuKV137q4uIN0SA
         jmE8+xF9M8n7kBNc/ZNx7hBPPw+fAU2ZP347uNWpOKeFUnngy80zJBOpgu7H/jg6t2tK
         k6GhWnKaUcsl1LoPKj4xMX6+/UkGcpmhbW80fHYqXyDiRxnHXa77WmYfUK1zYJZCzCmx
         mT+2+CfeiMhsby9DZh2Ikp50xsHwvyUv7PZxyjrFqsf0TnB3cS7sDN2QnkMqo+cx8sWC
         UUnA==
X-Gm-Message-State: AOAM5320JsPJOy66eUoyjy+KEmUMDZebF2+d83mPNELbtO4kkLFslH7k
        KSZBX+Tm2ELNfQE+qN/4Ot5hagzzttqfoDwXNRg=
X-Google-Smtp-Source: ABdhPJyssYsjis3j4KWZNQtO08DyRByznBlXN+uafErzQUpG3UCn80zDI8Bs/xlGFKJi6S3Limqmsg==
X-Received: by 2002:aa7:d0cc:: with SMTP id u12mr640203edo.48.1623363021477;
        Thu, 10 Jun 2021 15:10:21 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id qh23sm1451822ejb.77.2021.06.10.15.10.21
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 15:10:21 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id l1so1445654ejb.6
        for <linux-arch@vger.kernel.org>; Thu, 10 Jun 2021 15:10:21 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr578806lfl.253.1623362689248;
 Thu, 10 Jun 2021 15:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <87sg1p30a1.fsf@disp2133>
In-Reply-To: <87sg1p30a1.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jun 2021 15:04:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
Message-ID: <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>,
        Daniel Jacobowitz <drow@nevyn.them.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 10, 2021 at 1:58 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The problem is sometimes we read all of the registers from
> a context where they are not all saved.

Ouch. Yes. And this is really painful because none of the *normal*
architectures do this, so it gets absolutely no coverage.

> I think at this point we need to say that the architectures that have a
> do this need to be fixed to at least call do_exit and the kernel
> function in create_io_thread with the deeper stack.

Yeah. We traditionally have that requirement for fork() and friends
too (vfork/clone), so adding exit and io_uring to do so seems like the
most straightforward thing.

But I really wish we had some way to test and trigger this so that we
wouldn't get caught on this before. Something in task_pt_regs() that
catches "this doesn't actually work" and does a WARN_ON_ONCE() on the
affected architectures?

               Linus
