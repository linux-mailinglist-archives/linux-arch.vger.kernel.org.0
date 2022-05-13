Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BECF525E3F
	for <lists+linux-arch@lfdr.de>; Fri, 13 May 2022 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378827AbiEMJBt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 May 2022 05:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378804AbiEMJBl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 May 2022 05:01:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD585F24F;
        Fri, 13 May 2022 02:01:33 -0700 (PDT)
Received: from mail-yw1-f176.google.com ([209.85.128.176]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MMG6Y-1nWFb80dqI-00JHj9; Fri, 13 May 2022 11:01:32 +0200
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2fb965b34easo83680247b3.1;
        Fri, 13 May 2022 02:01:31 -0700 (PDT)
X-Gm-Message-State: AOAM53297uzcC/WAdMeqdsNUVmIRzdr7QKPdKim7kyL/b2Fy5OgePPtd
        mvIsc8Wd6+KnUBlzWSJGzRZtSWUSte0CV5ZBxvk=
X-Google-Smtp-Source: ABdhPJzrlAxbB2WlV+T6hacGoKYQwogQS2X5FpxwY1JmBe5loevDpOQJBYLFShoPKy5+y04wxk3x6hO+CKU5irjtm3Y=
X-Received: by 2002:a81:54e:0:b0:2fe:c027:1ca7 with SMTP id
 75-20020a81054e000000b002fec0271ca7mr385860ywf.249.1652432490729; Fri, 13 May
 2022 02:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <CAK8P3a3RWypZ2H6zRTdEWMvg608VFVAoNAQZbUM4GbW7uAWk8A@mail.gmail.com> <CAK7LNASxCvbqTLaUmVmmp_cKFNCj8hfVUA2kzEBYRf+u45Y3TQ@mail.gmail.com>
In-Reply-To: <CAK7LNASxCvbqTLaUmVmmp_cKFNCj8hfVUA2kzEBYRf+u45Y3TQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 May 2022 11:01:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3GbHJOk5MyKL9TnUXdpEoaUM4_XfzXyc=Xi6c_84cZ=w@mail.gmail.com>
Message-ID: <CAK8P3a3GbHJOk5MyKL9TnUXdpEoaUM4_XfzXyc=Xi6c_84cZ=w@mail.gmail.com>
Subject: Re: [PATCH 0/8] UAPI: make more exported headers self-contained, and
 put them into test coverage
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8+sWc5iiLNYSwEmrqulgKw9PBBxsZhOrdADjN/VRwNPN7H5Mnzf
 dt6xSEO3ZTmzbIDf1XPhekDwVV4082zgHd8pfFZZL7A9Lbjs4V0I0vXrON//Rmkjdh6FcaI
 2Szxg899l3Sln4jZdwu/viZf4FP1GZ2pjyQQhW22WKZ1ENOEkeqQh/HtQdr5CVU29UqT3f7
 0jb3ghZNnOZRL7fi1vIyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D5BKf+s0HyE=:6qTPtDQFJVP5WHq1cUIRPg
 5Vg4bsNlddzMQkLwbH0rzx8V0yU7Qik0HFfNRuvh3gts0AMbM3e31hSzENM8hf3cmb2bkosVy
 YwyjiSm73TMJ3dVhPVHQ1drfdTNmmfgcZJTIEUVhROEWwXKoRa7pkLpDGyiHgypOR1pxx3Lqp
 zSuc84J6TQVijvQdgJfeJ6OaOQYR7hUe/SEXSdRvNNLBX1o2C9wc6F8nN615fWXVb+bsfm3Ep
 OaBB0rUFcJ70/Vgkg2bkvkhWxWdN39mwrBNZ2p8hz9z+rvUkZlVpCjN3qAj+ioJbMV0024m9Q
 Ie0xWBORIjqVlowgrMn3SH/HZ6z1bQ2J49E92Ur+2rcmtd/tp67IO7t9AEa0JYWPFDs8IRELI
 yNHIqa43ToJ0KgCjUZ2kMQhlvZxxQRm/88EZNiHUB97itmIjbhi/8N/ZcuTNlR0wcRSWhgUhn
 5j7tGP9Z3PZfsiElmo2SfZSxHj6fquppQ3mJnGeCjPknLT5K/NtC6axZt/UNQQVN6PRFHH/mo
 tcM2EdHYPzu8Vu1tiJ1jdKkhDIWwRO+CLKP9qqaiXDjtrb6xIlbujajBGD+FDiumv6dfUYWwB
 PHRXh75GShGDNKOIlzoHMRLIEc2kU/Z7mkVvJBlJSfAqYhqgbv+u/PXnIPPf1/dleiPs7S01m
 LgzSozqEEER3/gZ+mqFJcYMCiq/NH1ffbaLkuV94bOH2vVQJuIzf8wxhujoB7FCDj3Ak=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 13, 2022 at 10:43 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi Arnd,
>
> On Mon, Apr 4, 2022 at 4:35 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Apr 4, 2022 at 8:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > >
> > > Here are more efforts to put more headers to UAPI compile testing
> > > (CONFIG_UAPI_HEADER_TEST).
> > >
> > > I am sending this series to Arnd because he has deep knowledge for the
> > > kernel APIs and manages asm-generic pull requests.
> >
> > These all look good to me, I can apply them for 5.19 but would wait
> > a few days for others to comment.
>
> Can you apply 01-06 for the next MW?
>
> I got a 0-day bot report for 07, but
> I may not have time to come back to it
> in this development cycle.

Ok, done now. What about patch 8? I left it out for now, but could
include it as well
if you want.

        Arnd
