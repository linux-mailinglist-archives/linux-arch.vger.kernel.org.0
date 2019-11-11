Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB727F71D9
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 11:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKKK1t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 05:27:49 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:35633 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfKKK1s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Nov 2019 05:27:48 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N3K9E-1hmpgx2PIo-010ORl; Mon, 11 Nov 2019 11:27:45 +0100
Received: by mail-qk1-f175.google.com with SMTP id z23so10656773qkj.10;
        Mon, 11 Nov 2019 02:27:44 -0800 (PST)
X-Gm-Message-State: APjAAAULs6wahQR09QYfNE1m6lDQ9CQ8pxVtikC33hSdUApyGiuDBM/j
        BSYkNQcH8zP655hfuafngRC3eTIDoUXLmeVmd+0=
X-Google-Smtp-Source: APXvYqyGcZLqyAcsV/LYDmC4LmwcrdvTKQ+w9XPWbssEa676VSOvhgPE+TuvbqMkbxFWBQMzT6WHPBHBJZYF9AVQbpE=
X-Received: by 2002:a37:4f0a:: with SMTP id d10mr9711437qkb.286.1573468063366;
 Mon, 11 Nov 2019 02:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20191029064834.23438-1-hch@lst.de> <20191029064834.23438-11-hch@lst.de>
 <CAK8P3a2o4R+E2hTrHrmNy7K1ki3_98aWE5a-fjkQ_NWW=xd_gQ@mail.gmail.com> <20191111101531.GA12294@lst.de>
In-Reply-To: <20191111101531.GA12294@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 11:27:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0rTvfPP2LUMw8EC0xz5gfZP5+NUkoaZBJrtYYfr6YRig@mail.gmail.com>
Message-ID: <CAK8P3a0rTvfPP2LUMw8EC0xz5gfZP5+NUkoaZBJrtYYfr6YRig@mail.gmail.com>
Subject: Re: [PATCH 10/21] asm-generic: ioremap_uc should behave the same with
 and without MMU
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>, openrisc@lists.librecores.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GkivQCpdGWFh606DM+vaZn5tEaom79mzbDAs7XKVPKHD/g0ePK9
 201/HVq3eg8zhxayfN21MCbyF1GGFaa3VOkRd1FphyeZzTf0WaI5HjQPn0ZNaOrOaP5e2Hy
 hQEsUv9iWzLIBAYi2aGA3DyScJkiJfWaiUbn4bsVjsxgF3kUeJhoorrI7JKDGhGcRDfhO8v
 Br8PDyVGEX6jUhHWooUXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GUU5HWu/Btg=:Kv1hrs/fv2SjYJXwVcUNiv
 /1X99/Cat12CjFMO0w3Shy1KVnUIcc638DE+mm/Z2H6mHFqF1D5oLyKRW16442UfY1tsN0Kpg
 WfCNKgEuWzA8LX47ywhTOlSGD67FNOgoWnM7m2xVn+AZql2jVZfGEM1bF7tFAIznSY6XZsk9K
 sTTz3ILnuAyhUurudsbqEUFu4/RbUwBpsvCfnLvx+UVfjzzKQ3ZS2/dzXlX6PoRT81C1H5dGE
 8xcrOCfX1Xgm5XuFuZj61C/ORU8+rJ4y4kfPJLs1iuxWJNytVZCiJQdn82fvyO20poSIOWdR+
 sp/OYWCHfwYDCI5T90BK1y0vKfW3RdzZc3c7y8dJzpg8/E19kex13wuRyrAEXltoLEcwFlPXt
 NWCyNfBmtknPmtCPsZ2D6bLdT0CS9qhLq+bzZK+78Hi+c3pzB1Cb2VTpLUxj9P86q8pvmCqOG
 gekJ+qlc1/2dZW3fIx6gZEOQ8bkQqVkzyHetoK5GAW3brrqYDlsJ1fO8EuIGvTyjt2kTITA91
 3b/YDfbeEERPVbXOvtWEufFuWwhw88V1XJdlIF//dtap8SZCstmVHWJRqv9t1JvKAloRFv3Q8
 jwMVJNIq1H6Mtbt4cyguVwiefC5L093cVQlvmre55h+1EhUiPfCB4VQ6aES7y3hSOMOmehrBU
 kk9pBMHHylWvlzo0OGRaLR7+sTuQyRQH2sCdU1wQcHZKQe0eW+E6phOYesAjoOnG/WWEoPdz9
 BKnNQF6PBQZJ17NLwpTbNvKTPvNvt+K1YQGtHrQ+Uzrki+JxQ4xZNarEXMn6VLdQlooMXOuos
 3AeIuZhkkfFe5lYjGGYWYCCINn3jjEI8MIWHsc4pLO7zhD97J/B4fhQfKFDjchAdn/dqGn0Jk
 eq3AJbBdIX15byFF2Oog==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 11, 2019 at 11:15 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 11, 2019 at 11:09:05AM +0100, Arnd Bergmann wrote:
> > Maybe we could move the definition into the atyfb driver itself?
> >
> > As I understand it, the difference between ioremap()/ioremap_nocache()
> > and ioremap_uc() only exists on pre-PAT x86-32 systems (i.e. 486, P5,
> > Ppro, PII, K6, VIA C3), while on more modern systems (all non-x86,
> > PentiumIII, Athlon, VIA C7)  those three are meant to be synonyms
> > anyway.
>
> That's not how I understood it.  Based on the code and the UC-
> explanation ioremap_uc always overrides the MTRR, which can still
> be present on more modern x86 systems.

As I understand, the point is that on PAT-enabled systems, the
normal ioremap() *also* overrides the MTRR, citing from
Documentation/x86/pat.rst:

  ====  =======  ===  =========================  =====================
  MTRR  Non-PAT  PAT  Linux ioremap value        Effective memory type
  ====  =======  ===  =========================  =====================
        PAT                                        Non-PAT |  PAT
        |PCD                                               |
        ||PWT                                              |
        |||                                                |
  WC    000      WB   _PAGE_CACHE_MODE_WB             WC   |   WC
  WC    001      WC   _PAGE_CACHE_MODE_WC             WC*  |   WC
  WC    010      UC-  _PAGE_CACHE_MODE_UC_MINUS       WC*  |   UC
  WC    011      UC   _PAGE_CACHE_MODE_UC             UC   |   UC
  ====  =======  ===  =========================  =====================

> In fact I remember a patch
> floating around very recently adding another ioremap_uc caller in
> some Atom platform device driver that works around buggy MTRR
> tables.  Also this series actually adds a new override and a few
> callers for ia64 platform code, which works very similar to x86
> based on the comments in the code.  That being said I'm not sure
> the callers in ia64 are really required, but it was the safest thing
> to do as part of this cleanup.

Ok, fair enough. Let's just go with your version for now, if only to not
hold your series up more. I'd still suggest we change atyfb to only
use ioremap_uc() on i386 and maybe ia64. I can send a patch for that.

      Arnd
