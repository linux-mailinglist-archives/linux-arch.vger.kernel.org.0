Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9FE0F4220
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 09:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfKHIcj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 03:32:39 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41913 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfKHIcj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 03:32:39 -0500
Received: by mail-ot1-f65.google.com with SMTP id 94so4515726oty.8;
        Fri, 08 Nov 2019 00:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mb8MvPT80CBr0Al9ctm+EN0Y96m3kmKlyXiJXBeWesc=;
        b=fgMh1EIYV4Y0YabHSKdtuGUb4920S4s6bAulfWlrA+uKAtZgW+erW6HelTjL83wygp
         Lg89tSUJ2N41T5XtLTIE6gjQPLh4enWv6zKZ//jdDDw+VoGAbhgrvCZOjsxLTDCyKj+e
         3ghZzR2HPzVLObbyKXZHoYsC7ciRt0Fn0ShjhnZ6036obJoHd4skS+Q3n/2ebTEfuexa
         0D15YHjoM+6LMklOThdZcAunJbFWfYdcXoqowtCRD8IymL91+qERqpOeNDrB2WMLJK6x
         ManJohNZoCVfSajIJGsgzUppgEuMvnfrIJyi6pdAQ73B1TD0l41GAn2hvcCE54MV7PSv
         aY1g==
X-Gm-Message-State: APjAAAWcABHFGKZBPIv3p3LnkYuXB562jZuj+ipn/Bo2aGyhXSWw3zHi
        YdPBJYSBcKnZT3/D4pB1CwI84lB+cDQnJOWsdk0=
X-Google-Smtp-Source: APXvYqw+43SGPSED0AJZnzsx4nEcpKNktTl/12Rw+DSczrLXTnm64tHUPqVN8uYM7eIOKZWrtAAa7/8vyyyqFua3Kw4=
X-Received: by 2002:a05:6830:2363:: with SMTP id r3mr7709762oth.39.1573201958505;
 Fri, 08 Nov 2019 00:32:38 -0800 (PST)
MIME-Version: 1.0
References: <1572850587-20314-1-git-send-email-rppt@kernel.org>
 <1572850587-20314-6-git-send-email-rppt@kernel.org> <CAMuHMdUG3V7uxzhbetw75vVeobeP0-bQySb3r=0V5XujUF123g@mail.gmail.com>
 <20191104094748.GB23288@rapoport-lnx> <CAMuHMdVHsNyLxhaxZcVdLvQ1PUnb=2_+ECPWVD0234V+qu+kOw@mail.gmail.com>
 <3d908bbf-0469-c53b-dd86-87df98f40ee7@gmail.com>
In-Reply-To: <3d908bbf-0469-c53b-dd86-87df98f40ee7@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Nov 2019 09:32:27 +0100
Message-ID: <CAMuHMdVe-7=587nMWK_FcHzsm1TLckwTY9JxKHM_Gg8+ogZsgA@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] m68k: mm: use pgtable-nopXd instead of 4level-fixup
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>,
        Richard Weinberger <richard@nod.at>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-um@lists.infradead.org,
        sparclinux <sparclinux@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Michael,

On Fri, Nov 8, 2019 at 5:30 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 04.11.2019 um 22:53 schrieb Geert Uytterhoeven:
> >>> This indeed boots fine on ARAnyM, which emulates on 68040.
> >>> It would be good to have some boot testing on '020/030, too.
> >>
> >> To be honest, I have no idea how to to that :)
> >
> > Sure. This was more a request for the fellow m68k users.
> > But don't worry too much about it.  If it breaks '020/'030, we can fix
> > that later.
>
> Boots fine on 030, too.

Thanks a lot for testing!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
