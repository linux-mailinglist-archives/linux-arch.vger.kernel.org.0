Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E83EE9204
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 22:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfJ2V0C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 17:26:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43482 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2V0C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 17:26:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id s4so226882ljj.10;
        Tue, 29 Oct 2019 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ti1k4N8j2ZSElZ5dQiM1ptrNLuExzcmkQM4fcrPhug=;
        b=OiijxmXmDw8P398uaEva7r04QCjWRg147Ojy43qdzFiORUHXmzlcQYpHw4me8PMAYE
         uMrzRHBdPRMPf0Gf9ZwIogJDJu8UadWcLFn5EuR+QRFuNCDPj0n+8d2KgHLX+x8aF75Z
         FFsf4WhYIeYMPXkTcofKrRzy5CgYGAzbwJo+Gu1HvhNJWhjvzEm1nlrBjteZATk6ymgd
         rrORkjsyWTMNHHgZQRNuxTVbZsN2ORHRT0eb3JgOxjEQ8bDsz60/2BBUvS7ASnqqCYk7
         WmvCQkyjpyAeLQZcVJHieNl8JV+AqBeogHSsYodi1LauRPg8jPYFnWw7neEx8iAAheHn
         1i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ti1k4N8j2ZSElZ5dQiM1ptrNLuExzcmkQM4fcrPhug=;
        b=lMAgAQ9QnqeqaaS0QRKZe7hQ3jLX3skNyKCdqWPuswkqjaNiUv2WIKYova8bRm0a6R
         A93GEX2HAj3TqHZFJmjbdWowBwR+T1TJCWh+pa/Gyu8u3h+5zLx+Gkbr1zHEa/jED4fo
         nFAW885UIDH9vo64SqejkeMEOSUTVDm02r0v3HH9dUl7I3Ny19Bfzy1+hqvjFbFUovjx
         VRJcwxGUHWfGvkMxXi2149GfJD2CiLtaju//gT4kYcTulTjvcpPCONkow2bKdKjK9WxC
         vWMAxxtEacUrAWZrL85q+4BAWb1fdWu9t4sud4CAq/0rtm7+a7tP+92z8VWZAR4tdX1N
         F41Q==
X-Gm-Message-State: APjAAAXXD7qoSIZcWuIeMGhMGp2VM4NZLRmwnsYcxT73MHX7pnogTr4S
        HoDyXfO1eG9c4CLvOMuNWP0X6i3YJrB8Ov0v7dY=
X-Google-Smtp-Source: APXvYqy4POa3tJsYU9H82PDElDMXH0pN6cP1ClC2av7/QUUwp2nsI5wn7l82Uy/tKFwNYAEnh/LvfKtD7BKwBI5TjC4=
X-Received: by 2002:a2e:8990:: with SMTP id c16mr2024514lji.226.1572384360091;
 Tue, 29 Oct 2019 14:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191029200026.9790-1-jim.cromie@gmail.com> <e9835376-1efe-1d1b-4a99-8bb920e04a08@rasmusvillemoes.dk>
In-Reply-To: <e9835376-1efe-1d1b-4a99-8bb920e04a08@rasmusvillemoes.dk>
From:   jim.cromie@gmail.com
Date:   Tue, 29 Oct 2019 15:25:33 -0600
Message-ID: <CAJfuBxyEjhxkO5jv_qy17-EwrMyPfh6b_1EBCVyxyymH9qQVhg@mail.gmail.com>
Subject: Re: [PATCH 04/16] dyndbg: rename __verbose section to __dyndbg
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 29, 2019 at 2:37 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 29/10/2019 21.00, Jim Cromie wrote:
> > dyndbg populates its callsite info into __verbose section, change that
> > to a more specific and descriptive name, __dyndbg.
>
> Yeah, that has always bugged me. Ack to that part.
>
> > Also, per checkpatch:
> >   move extern struct _ddebug __(start|stop)__dyndbg[] to header file
>
> Hm, why? checkpatch should often be ignored. Since we only refer to
> those symbols in the .c file, there's no reason to pollute every other
> translation unit with those declarations. Having declarations in a
> header makes sense when the actual entity gets defined in some .c file
> (which hopefully also includes the header). But these are defined by the
> linker, so there's no type safety to be had.
>

checkpatch wasnt in a mood to explain itself,
but the other simplification seemed good, credit by association

I guess the action-at-a-distance feel to the linker magic
and the extern qualifier, swung me toward heeding the advice.
OTOH, as you note, only dyndbg should be mucking with the symbols.



> >   simplify __attribute(..) to __section(__dyndbg) declaration.
>
> Makes sense, since you're munching the thing anyway.
>
> Rasmus
