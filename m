Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5106F525E39
	for <lists+linux-arch@lfdr.de>; Fri, 13 May 2022 11:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378412AbiEMJPE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 May 2022 05:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378923AbiEMJPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 May 2022 05:15:03 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14CA1882BE;
        Fri, 13 May 2022 02:15:01 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 24D9ERqI026893;
        Fri, 13 May 2022 18:14:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 24D9ERqI026893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652433267;
        bh=MNi8P0TIeSQvF6fTUb5WzkP1pBowEJarOeoYmEQnwsE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zQE0jkQj4fxQFUd6EbU1MkOTv9AjSliQKbEYBJXTgTx2rJBxDleE2nvQ/vRYuDOt+
         rtvl/5syIfBWq5aIlK6JpH3Oc8J9TVWI9VlTxC4F6ZhVK/eT5QNl3rRKfy6cBNZG/W
         YSWeW5/F1QziK+y/hcyLjnYPXAHZB0DxYe7oo35sTqz95bXkbru8Vdc+XOgJDmGu1P
         74d5eHnIYfVbRlNvhQfMP83Z4Omt0xC4Gs7gezEsXNTS0XFbTDOh7Z9evuVCMmDUi/
         cK6edwCc4+3NxaTiVY8dP3U5aHg2mF6cHODuFrfN1RXuF7ftUugQQTBklwCnB9NEut
         z8nLjcV9QphUw==
X-Nifty-SrcIP: [209.85.214.181]
Received: by mail-pl1-f181.google.com with SMTP id i1so7371870plg.7;
        Fri, 13 May 2022 02:14:27 -0700 (PDT)
X-Gm-Message-State: AOAM531X4EpGk32h/PLldDUkd1buIOwhyIOCziwNAqPQuLZkI/tkNR2Y
        k1VbUYlDJP4CJSckkcRV61JlDObsP7fs/vpaJeY=
X-Google-Smtp-Source: ABdhPJygABMRI0O9lGJUpfjyuPvMB+Gl4wNhupLUDv7TQImq96vVJ5o7/bbbI9PWKpzKzpd4U892qwF9cIRI4g1/SLs=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr3956625plh.99.1652433266603; Fri, 13 May
 2022 02:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <CAK8P3a3RWypZ2H6zRTdEWMvg608VFVAoNAQZbUM4GbW7uAWk8A@mail.gmail.com>
 <CAK7LNASxCvbqTLaUmVmmp_cKFNCj8hfVUA2kzEBYRf+u45Y3TQ@mail.gmail.com> <CAK8P3a3GbHJOk5MyKL9TnUXdpEoaUM4_XfzXyc=Xi6c_84cZ=w@mail.gmail.com>
In-Reply-To: <CAK8P3a3GbHJOk5MyKL9TnUXdpEoaUM4_XfzXyc=Xi6c_84cZ=w@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 13 May 2022 18:13:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT86MTKnN0b1bXkojHR4n9tTXVw__cL3QCbUrtMAQ1N1A@mail.gmail.com>
Message-ID: <CAK7LNAT86MTKnN0b1bXkojHR4n9tTXVw__cL3QCbUrtMAQ1N1A@mail.gmail.com>
Subject: Re: [PATCH 0/8] UAPI: make more exported headers self-contained, and
 put them into test coverage
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 13, 2022 at 6:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, May 13, 2022 at 10:43 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Hi Arnd,
> >
> > On Mon, Apr 4, 2022 at 4:35 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Mon, Apr 4, 2022 at 8:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > >
> > > > Here are more efforts to put more headers to UAPI compile testing
> > > > (CONFIG_UAPI_HEADER_TEST).
> > > >
> > > > I am sending this series to Arnd because he has deep knowledge for the
> > > > kernel APIs and manages asm-generic pull requests.
> > >
> > > These all look good to me, I can apply them for 5.19 but would wait
> > > a few days for others to comment.
> >
> > Can you apply 01-06 for the next MW?
> >
> > I got a 0-day bot report for 07, but
> > I may not have time to come back to it
> > in this development cycle.
>
> Ok, done now. What about patch 8? I left it out for now, but could
> include it as well
> if you want.
>
>         Arnd


No.

08 depends on 07.

We do not have __kernel_uintptr_t  yet.




-- 
Best Regards
Masahiro Yamada
