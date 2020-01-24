Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B149148CB6
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 18:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgAXRFj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 12:05:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45522 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbgAXRFj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 12:05:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so1394813pfg.12
        for <linux-arch@vger.kernel.org>; Fri, 24 Jan 2020 09:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OkgBXD4HoXPiY/eoWfExnajwU8sKoQVfDOiDrJRorLo=;
        b=McZaGI6vyq1BWIQC6oi0i4XR1wu9ZgLauYAINexyUbPdvtYF5zHeiukPw0Vg6kpZj/
         ZB1lFF+v2Y30ZdT3HV6KN8gYssTjoZRAHyEeFlmW8BZT0Y2x9j6HAU8a2sTQ945qFXym
         SbVlXsD4jyKsMHc08K1Vi2b1qaxxC9njRxvSruGCLOTCYZvK32BkKYEN3Mv11i2Y1MO5
         yOmC1V5bcTh/mHyn9W+qRzAReSaoJpZXWkEhxqaGNiBbiqMRJChcs7l+AQE0BR7xnKLd
         J36Ol2u2ZqJth00o0Y1sOZHe3K7OsOD+2Fl5Lg9f4b0o4+okVVsUI2uxTtvkB+el7xQQ
         555A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OkgBXD4HoXPiY/eoWfExnajwU8sKoQVfDOiDrJRorLo=;
        b=KgjTvaSMZ8la3B2xWk/3tj1XO/GuGbw83E4uVQTb9sjG3Y2CHEUjHZEVqtvFZ7llGR
         /cBX/EAZzTkkzGsdqJmgU9ITiXMhSkWkcmFHKZuMLzTMTJqcB/djb+qKvoHW93DiUBev
         Onuf25vGJfwQyEB0TAqYeizgYN5uE0tTWB7M8IzVUfvyGQSYoDS5w9O1GOoK+55BEIPl
         /3WGMKGxDpcXe6E7K0+t/OqbVMReQ/ypRtaRpyImQRrtAd1E6ETCtt/e2ZNEIyFhOs4I
         HNh2of48RO1oIf4PU7mX+Ipb/UClXEK3WDMRsNMdoJf81beo46zlypcJwyJetN049RTQ
         VCwg==
X-Gm-Message-State: APjAAAUATxy5aZ6IkmYVfJjbVcx26pIlTxctq/X+KSjXGCLacO6Mw0+B
        Z7EwFRtxIaTQG8CnyLWCokCcZuJrm8nl2ApL8JON7A==
X-Google-Smtp-Source: APXvYqzgkx6QXwnBzvxRHKvAZa1GjV9zApqlw7PX8mk9SON/0IorTfzK9SaNo/bIyx9KtPnlmJz/q3pUOkhUvFVoxx8=
X-Received: by 2002:aa7:946a:: with SMTP id t10mr4146497pfq.165.1579885538456;
 Fri, 24 Jan 2020 09:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org> <20200123153341.19947-10-will@kernel.org>
 <CAKwvOd=Bp+FWXHUKZnk+_dN=jTYZGdc_QVhErC3N-Frpk4mssQ@mail.gmail.com> <20200124082637.GZ14914@hirez.programming.kicks-ass.net>
In-Reply-To: <20200124082637.GZ14914@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 24 Jan 2020 09:05:27 -0800
Message-ID: <CAKwvOdmFMnCgr3rP5vNkj_H1SnBJ6drdBP1RSGxzfYzSiWGfLg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] compiler/gcc: Raise minimum GCC version for
 kernel builds to 4.8
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
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

On Fri, Jan 24, 2020 at 12:26 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 23, 2020 at 10:36:37AM -0800, Nick Desaulniers wrote:
> > On Thu, Jan 23, 2020 at 7:34 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > It is very rare to see versions of GCC prior to 4.8 being used to build
> > > the mainline kernel. These old compilers are also know to have codegen
> > > issues which can lead to silent miscompilation:
> > >
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> > >
> > > Raise the minimum GCC version for kernel build to 4.8 and remove some
> > > tautological Kconfig dependencies as a consequence.
> > >
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Thanks for the patch.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > I wouldn't mind if this patch preceded the earlier one in the series
> > adding the warning, should the series require a v2 and if folks are
> > generally ok with bumping the min version.
>
> If I hadn't actually read your reply, I would have never spotted that
> reviewed-by tag, hidden in a blob of text like that.
>
> Adding some whitespace before and after, such that it stands out a
> little more, might avoid such issues.

Ack. Do maintainers have tools for fetching patch series and
automating collecting Reviewed-by tags, or is it all extremely manual?

-- 
Thanks,
~Nick Desaulniers
