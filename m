Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A984F7731
	for <lists+linux-arch@lfdr.de>; Thu,  7 Apr 2022 09:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbiDGHTg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Apr 2022 03:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241678AbiDGHTe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Apr 2022 03:19:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2708519609E;
        Thu,  7 Apr 2022 00:17:34 -0700 (PDT)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mq1GE-1oO5ct1Jxa-00nDWp; Thu, 07 Apr 2022 09:17:33 +0200
Received: by mail-wr1-f42.google.com with SMTP id b19so6412450wrh.11;
        Thu, 07 Apr 2022 00:17:33 -0700 (PDT)
X-Gm-Message-State: AOAM5302p6FooesM2MlclI+GR3UKP8YLM4PiD8K9/EY4x0cnFds+tfdi
        p7uJEKY9J+7LBF9tAX1pf1acn89KFq3c2ivWQ2w=
X-Google-Smtp-Source: ABdhPJwmNfPDNFMCTxQF72bGloQ9R7ixTS1WuENFc4sxAk/2DHt8y1oYiTEoK7GHAg/mvQl2A58Tcb9T0D1qJhBrXSI=
X-Received: by 2002:a5d:6505:0:b0:205:9a98:e184 with SMTP id
 x5-20020a5d6505000000b002059a98e184mr8948149wru.317.1649315852910; Thu, 07
 Apr 2022 00:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <Yib9F5SqKda/nH9c@infradead.org> <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org> <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <CAMuHMdWcg+171ggdVC4gwbQ=RUf+cYrX3o9uSpDxo-XXEJ5Qgw@mail.gmail.com> <c3e7ee64-68fc-ed53-4a90-9f9296583d7c@landley.net>
In-Reply-To: <c3e7ee64-68fc-ed53-4a90-9f9296583d7c@landley.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Apr 2022 09:17:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a14b6djqPw8Dea5uW2PPEABbe0pNXV5EX0529oDrW1ZAg@mail.gmail.com>
Message-ID: <CAK8P3a14b6djqPw8Dea5uW2PPEABbe0pNXV5EX0529oDrW1ZAg@mail.gmail.com>
Subject: Re: [RFC PULL] remove arch/h8300
To:     Rob Landley <rob@landley.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Yo2hm0QgwdDiZWgQYLhkXYPauJG70GP755RV1AWo8wIVvD/MUvj
 YEfgbQBnSdVWploJP6kdu8d4cBq4C8p1jGw1W7Fdul3S6ddMi9QvPqQh3QTEARECDATDf6s
 Uk+JVdrBs80xnRnP+6SSZv3MWP3fIPf/ygCsX8Zmk3idXRktBukUmTBWtDlaSbjkvlNcElz
 wO6jjxfljNlmw/yZRGF5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7npattaJtsU=:Ap0U6VUR0inRdjgkys9djw
 3Z7Z0OGP8FdcSfCguG8yi26yaxTmUHHLyF5W6Kz/EJjpBfX2McXJOBk2h0ocBU0Swqi/XY/zr
 C/Q9fx86UTr9BYeA5YkyB9TBIAmoX0Bd1WL5izun3YcshAj3JupG3afv8SgxPlAJiIpmp5MZP
 q1CJ5TyArE3GB124uu455f8hwXOmlu3EawdlXlg9AZ8qWfOP5vpnX8ge2h12pYXQuFGilXSfc
 4/RtNbxI1xhhYet1Dh3MP08k0xdlUoofGAgQd/I0ssTH7b6WXEnyBiWgbKlP0CoJ/XTqLUlPk
 CeGMKQB93rE0Pm+xAd3zVLZzqystdWQ4gx9u+z0J+95KewqQ0jGV7jhFsG1QnDfrNjR8LeaJC
 ovLeyI/HoiNw2QmUCAsB6TMWHpDd9JMQrvRA4iE51wFeY69pNRVHfzca6thW0fh290yp/tMKj
 7FCmej6Uj9aBQuLvnP8g9lAl822aSCrbBYCofeqGCSAfqoSWw7IChm3/ZCQresGSJ1BG0PowW
 T6rEMF0HBJYuiLGwIb3Q4L7arnox3z/ogFKdHQ83ZDosVzxwNEgN+B18E41g60uNy6JXK3965
 kJq3R8CnaJG5KQm+l82D7s8z3kbXs7BLM0x3X+JdRiVjiDdkJF6IajG5QOI6KwCGM9cyFjRWv
 o5ksJ9K/7Mcoxuk5x1NER9lQU4475HkQcX/VjPyE8hj+r4JLwCrWe0RabAQtsPAeDoaWwLIRE
 keQgOWwHRQjkVPHH+dvCto0vjagZZsYggSoAhHjhytM+o99GR/tQM9gPgtHax2tc9M/eizazU
 OzMUBYGnZwZT5gogz8G/52L640SiTMftGg4a5m7Ie7I6d1MbGU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 6, 2022 at 11:25 PM Rob Landley <rob@landley.net> wrote:

> I'm interested in H8300 because it's a tiny architecture (under 6k lines total,
> in 93 files) and thus a good way to see what a minimal Linux port looks like. If
> somebody would like to suggest a different one for that...

Anything that is maintained is usually a better example, and it helps when the
code is not old enough to have accumulated a lot of historic baggage.

The arch/riscv/ code is generally a good example base for others to copy.
It's not nearly as small, but that is mostly because it implements optional
features that could be left out. csky is a smaller example that is also
fairly clean and new, but less featureful.

         Arnd
