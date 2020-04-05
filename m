Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F9E19EAA7
	for <lists+linux-arch@lfdr.de>; Sun,  5 Apr 2020 13:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgDELOr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Apr 2020 07:14:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37825 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgDELOr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Apr 2020 07:14:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so13967575wrm.4;
        Sun, 05 Apr 2020 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=NxJKrbYiQ4xe+r7i0H/o0qPIvinu13Q5NjffxcFXndY=;
        b=tmuPFlShLkL/FtM6K000R0oIzbEJBdxtfaZ2Bp7ll7HAhcaoM4vmVqtI9An+MPUhjL
         CQZy46bFQ+2giUsJaV70ct6TXxsWTiXEGCcBa3dkqCIHgfiGzEa825SZRMTufg+h8wyR
         p3ts4bZbPZZRfULPr3SDm0NbQRs9GNe2/gBjZzBejNQ2yDjRc+c3EvHF17htbo4eW134
         XUtQr4hx/UomkRbXlvh+AUa2VwC4ta8hCjVALJ3tqapeQnKyvrp+b1zuEnHw/8jbmRfN
         doDExUHLxCmJ/l4j77DTp7usvNwPweO50tXVS9kCPuO0cPH7RKfytk47dZUCGZhd6gH6
         FIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=NxJKrbYiQ4xe+r7i0H/o0qPIvinu13Q5NjffxcFXndY=;
        b=pQEwvrpaIPlSjn5WN/4I7BWYRoDKVqfLp+FcbdRwIyQC7/Te6Zmr/J4J844ZKoJnxl
         n296DeTs4JZnkTNX+WsEnTDXXl6QreatbQqV6SoNUaBOGxt73Pglj2C0QoEe8zsxl37S
         oZekQCAVgPXVWw0P7kUpIlQN9G4wF8LERklCWL9b2bQpn9VwmYuVn/FP8Ds6e57OMaKr
         SXoXvveEVhhS2SH9zQjKg2HEBLt5OHhd9KZfD6H2NMkFDlxWZ86zKr6V88mBatJkbRJr
         3kaxr73yb2qZs8txNTPXG6g3FW2dUNdu6jD5gp07AW1ZmSaC88L2/X50W/DwHHR9XaeY
         cbTg==
X-Gm-Message-State: AGi0PuatMQzX1COVonN1W3e+dnGGMMrd2HNthEODM2zZ3V5M9ZHjq3ge
        +D/3n8HzW3f8L9Q0R6SKueOI2F34DmQigMKGThw=
X-Google-Smtp-Source: APiQypJo+6EuZfrkPrLQzDLqUU6JycKAfBtQI7non1VFonreceCbe9cNRfQjuuVbBjWlchnfwHmCBimpf6PFBTUnZlQ=
X-Received: by 2002:adf:bb94:: with SMTP id q20mr3453756wrg.179.1586085284762;
 Sun, 05 Apr 2020 04:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200228002244.15240-1-keescook@chromium.org> <CA+icZUWTnP8DYfbaMwKtJbG30v7bB4w6=ywo8gn8fvwr731mUQ@mail.gmail.com>
 <202004021023.D3D8AA3BE@keescook>
In-Reply-To: <202004021023.D3D8AA3BE@keescook>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 5 Apr 2020 13:15:01 +0200
Message-ID: <CA+icZUXi_iA7XkTEbrK7b6m673iG9qPKnDBE1V0JRywDLBc9jw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Enable orphan section warning
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 2, 2020 at 7:26 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Apr 02, 2020 at 06:20:57PM +0200, Sedat Dilek wrote:
> > On Fri, Feb 28, 2020 at 1:22 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Hi!
> > >
> > > A recent bug was solved for builds linked with ld.lld, and tracking
> > > it down took way longer than it needed to (a year). Ultimately, it
> > > boiled down to differences between ld.bfd and ld.lld's handling of
> > > orphan sections. Similarly, the recent FGKASLR series brough up orphan
> > > section handling too[2]. In both cases, it would have been nice if the
> > > linker was running with --orphan-handling=warn so that surprise sections
> > > wouldn't silently get mapped into the kernel image at locations up to
> > > the whim of the linker's orphan handling logic. Instead, all desired
> > > sections should be explicitly identified in the linker script (to be
> > > either kept or discarded) with any orphans throwing a warning. The
> > > powerpc architecture actually already does this, so this series seeks
> > > to extend this coverage to x86, arm64, and arm.
> > >
> > > This series depends on tip/x86/boot (where recent .eh_frame fixes[3]
> > > landed), and has a minor conflict[4] with the ARM tree (related to
> > > the earlier mentioned bug). As it uses refactorings in the asm-generic
> > > linker script, and makes changes to kbuild, I think the cleanest place
> > > for this series to land would also be through -tip. Once again (like
> > > my READ_IMPLIES_EXEC series), I'm looking to get maintainer Acks so
> > > this can go all together with the least disruption. Splitting it up by
> > > architecture seems needlessly difficult.
> > >
> > > Thanks!
> > >
> >
> > Hi Kees,
> >
> > what is the status of this patchset?
> > Looks like it is not in tip or linux-next Git.
>
> Based on the feedback, I have 3 TODO items:
>
> - track down and eliminate (or explain) the source of the .got.plt on arm64
> - enable orphan warnings for _all_ architectures
> - refactor final link logic to perform the orphan warning in a clean way
>
> I'm working through these (and other work) still. I'm hoping to have
> another version up some time next week.
>

Please CC when possible with a pointer to a git-link.

Thanks.

- sed@ -
