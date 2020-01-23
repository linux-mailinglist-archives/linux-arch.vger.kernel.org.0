Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE981470FF
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 19:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAWSpU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 13:45:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43035 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWSpU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 13:45:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id x6so1930618pfo.10
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 10:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvsi3+mVRugxOCmIL81uU90/b28J/511mNG/ZrCHXHA=;
        b=ToaFsl9G1rGPH6lAtDVZr8Oaf9j7/1qd9QX6XKweW63AEwNAI3TZBjgIWkg78QTkoQ
         5NmMT4+6HP8VbbljIG7r9SHWggAETrPh9wqEYEHzoaNjGip0j6I9C9ha46HGXtcNioxJ
         YlUaEbzH2m3KjCIN7z0mcVzW/J/Xi1JN7jkawQxCcRDfdoBpDGhbRZGdUvXyeiCyKo1f
         wV8YWAXwj4KEUSWtkq7Gq3dqjX2YfORkOX67a07l4ZYeUpAZxEtQIRj3SKlhU/RR9L3w
         UNCked2iDLQ+0Hn2IuxGfTvvQEDcKJNLyG+VEK2wi9Htl/hEnLhsH9I4kgJaEr9joRJp
         r2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvsi3+mVRugxOCmIL81uU90/b28J/511mNG/ZrCHXHA=;
        b=nbnoompiR5wu7I48IMAgtYhcJHhwVYB6JgxoziQgHgCzl6O+Be8GETLMgVLJ7IhunG
         gEqLs48UNTK49BhC+eYVoc4o5TK2ZKdJApdN1tp0ULKp20G8NmhyYGiODAM26y8f1VUf
         6MWbGT0LWu0cYBuyV8rHciF9EjN70luuhmYcsgiZTUjC3FTtfk+YizVING7ZIzcHXbln
         E6gTz0NSdGm5N39GnWmo7VvDd4nfQ+zikoBNHCkiquSwekFuW1Mh5DKYChrinRhwcXOT
         3pbQdzcClvbxkOi4eYBNrrli6wcIt006FXghZrWlAsIUJk+dAb2uG+aG4XWAtAymHDmK
         GVkw==
X-Gm-Message-State: APjAAAUre6V+wKj2XzrzX30CJViorU0ulsbckHwJxssjogu4pcGJy8Tq
        mMQNAl2Zi/oPUWlOslgkiuwlFRH3S/+6byIm1QNpaw==
X-Google-Smtp-Source: APXvYqyMHe8Nhew2tJBHBmTJOvyY2uoTq78E8EWJb0A/uv7w1kn1M4Th80XISCR7i0gIfcuuv6uzV9EEjHNjJkWphzo=
X-Received: by 2002:a63:590e:: with SMTP id n14mr210602pgb.10.1579805119253;
 Thu, 23 Jan 2020 10:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org> <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
 <20200123171641.GC20126@willie-the-truck> <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
In-Reply-To: <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 Jan 2020 10:45:08 -0800
Message-ID: <CAKwvOdkFGTeVQPm8Z3Y7mQ-=6d5CFxmEJ+hBb8ns2r2H1cb0hQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
To:     David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 9:32 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Will Deacon
> > Sent: 23 January 2020 17:17
> >
> > I think it depends how much we care about those older compilers. My series
> > first moves it to "Good luck mate, you're on your own" and then follows up

I wish the actual warning was worded that way. :P

> > with a "Let me take that off you it's sharp".

> Oh - and I need to find a newer compiler :-(

What distro are you using? Does it have a package for a newer
compiler?  I'm honestly curious about what policies if any the kernel
has for supporting developer's toolchains from their distributions.
(ie. Arnd usually has pretty good stats what distro's use which
version of GCC and are still supported; Do we strive to not break
them? Is asking kernel devs to compile their own toolchain too much to
ask?  Is it still if they're using really old distro's/toolchains that
we don't want to support?  Do we survey kernel devs about what they're
using?).  Apologies if this is already documented somewhere, but if
not I'd eventually like to brainstorm and write it down somewhere in
the tree.  Documentation/process/changes.rst doesn't really answer the
above questions, I think.

-- 
Thanks,
~Nick Desaulniers
