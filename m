Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324F4719563
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 10:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjFAIWR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 04:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjFAIWQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 04:22:16 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DC59F;
        Thu,  1 Jun 2023 01:22:14 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bacfcc7d1b2so555015276.2;
        Thu, 01 Jun 2023 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685607734; x=1688199734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3q8fSv1CYQ8OeBSkoHHq8yQzPVMEdcVj1sJJBohCe0=;
        b=scnpKoycafdSA6Zmoxe64NtU1IPtpP1XoN7u6BxbHgaNpHHpBaRgfB2X/NbVQI3XUI
         S43vtnrb0VpUQFKtCtNAL2Z4eQGxKB9jkDmQzBef6OSmzPFkANcNw2nEHbBaxtIGRJFx
         F2gdbWX0/JO50BjGXzMMRjG/dVaN6/37Aaxe3j2XyiD9NBGl22snChdmfv7CpIBT4YsT
         wzEsBAOaAGJLasaxdabRza57BmBoAT7cVmGOq5aUEFhtYj/c1WejBdPyTkL2OU+y9vxz
         zNiBma0es8vOX0CahjWds9KH8J6DH6xHzp6sGGczNoDJQcyp7Q2snP8wt+QQc7Qs4GOa
         fyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685607734; x=1688199734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3q8fSv1CYQ8OeBSkoHHq8yQzPVMEdcVj1sJJBohCe0=;
        b=PNfLrFx1d8QyiKkZnnmgvsKJ3pmH81y78IwvI4EM5RfWc9Fl9ZXuleVqCbbF311n3I
         v80muihQL9NceIMTJjFK32DgxoiJ/Jd8dHPFTVzZeLpw6455zF+/c3YxeFv/lor6ilFi
         9y48LUHuV+jcu4esfAWr2t99zyTwkj0ctqgRZRl3aLYcQEPiicgUs3xE5VF3QoJ1lnd8
         sW1oY4pqnFe46aP2FeOg5UpagFZwxFR7jYD8awlCUv5mKXPc9UTl+j9McZhPMjlB/rST
         l5e68Tp5iVTsz//qXEceVHYfHUbgjXwmh8XZdIx18CnxHREQKdVV9I/qbAIVCe5kGz6M
         cGTw==
X-Gm-Message-State: AC+VfDxAnQ1Hwhiea5G9woCGF5ERAyKLLFeB77R1vcI27ZMEdU61SKEH
        omelXN46uRdwICwAfkEokLsWn62eoIIWdZewkEY=
X-Google-Smtp-Source: ACHHUZ4BVGpqKx729yAA7sIpRRuJCk9B2q39qd4V84f+TNhLT6e1WTgI1mcqI+pCtHVuJpHfepvjflFti312UIm7bGk=
X-Received: by 2002:a0d:f5c2:0:b0:568:d63e:dd2c with SMTP id
 e185-20020a0df5c2000000b00568d63edd2cmr6202683ywf.11.1685607733835; Thu, 01
 Jun 2023 01:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230531213032.25338-1-vishal.moola@gmail.com>
 <20230531213032.25338-31-vishal.moola@gmail.com> <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
 <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
In-Reply-To: <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 1 Jun 2023 01:22:03 -0700
Message-ID: <CAOzc2pxnb6WXoVK5JXX42R0Q6FK59Q1uebQskK2fxLn6DuicqA@mail.gmail.com>
Subject: Re: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 1, 2023 at 12:28=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Geert!
>
> On Thu, 2023-06-01 at 09:20 +0200, Geert Uytterhoeven wrote:
> > On Wed, May 31, 2023 at 11:33=E2=80=AFPM Vishal Moola (Oracle)
> > <vishal.moola@gmail.com> wrote:
> > > Part of the conversions to replace pgtable constructor/destructors wi=
th
> > > ptdesc equivalents. Also cleans up some spacing issues.
> > >
> > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> >
> > LGTM, so
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I assume this series is supposed to go through some mm tree?

Hi Adrian,
I was going to have Andrew take this through mm-unstable
once it gets enough review.
