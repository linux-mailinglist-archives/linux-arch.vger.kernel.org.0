Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47B854CD46
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345705AbiFOPmJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jun 2022 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347569AbiFOPmG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2022 11:42:06 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6E333EB3;
        Wed, 15 Jun 2022 08:42:05 -0700 (PDT)
Received: from mail-yw1-f170.google.com ([209.85.128.170]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MpD39-1nMsUO29NP-00qmZw; Wed, 15 Jun 2022 17:42:03 +0200
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31336535373so65529697b3.2;
        Wed, 15 Jun 2022 08:42:02 -0700 (PDT)
X-Gm-Message-State: AJIora++c+Wn/IOsx9pCgv7/Nzu9gHCVZW360JjfwTsj2olgqMQARQMb
        3jcRfUUpFG/Larpdm4QhU//MFCefbtkSYPBh3QM=
X-Google-Smtp-Source: AGRyM1tvSYqmEMcQOHNj9RHGvPD3N77JHNbv7mv6qEA4arhJQHb8/8PCIV9TGNOQcD+GB1sbS5DvpPMqr/97f5KSeYo=
X-Received: by 2002:a81:2f84:0:b0:314:2bfd:bf1f with SMTP id
 v126-20020a812f84000000b003142bfdbf1fmr292750ywv.320.1655307721907; Wed, 15
 Jun 2022 08:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <YqjQ5kso7czrmYPW@linutronix.de> <YqmC1aAm+O7RD2IH@infradead.org>
In-Reply-To: <YqmC1aAm+O7RD2IH@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jun 2022 17:41:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1QmeAscV-Ory-Dae4RoLvDSPEjEgFGQHR9U8jUervGuA@mail.gmail.com>
Message-ID: <CAK8P3a1QmeAscV-Ory-Dae4RoLvDSPEjEgFGQHR9U8jUervGuA@mail.gmail.com>
Subject: Re: [PATCH] arch/*: Disable softirq stacks on PREEMPT_RT.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:f9gWmAOWQ4mJqq9vnpq340BcszasWXWP8oa3AU2ZDOsKL9mj5K4
 axGZkpi9mmoxgs0WXgG3u+bl9+r5z0klO1aPIC+E9liMAY1Z5keTOuuIvd9COoa1z3dHYCO
 HUpNxWrMZHSJ1AVVZttzC3QOj5oTyk2Nk/JRicTpoS1XzgA9fafttu3wHtrnSqgX26plHb9
 6IrOqhsgAx7H5uDrUHIFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wdbNn5/MWQQ=:eB+gLs0OdaEHc9PgXzSq80
 otKA4DpR1wzlE+IVSQ4haIZTS8bLUm+Q29mzbBOW9FnhsLADvZNKABrYoVhSA9+Ke1n9/z5BI
 jx8LBbyznrgV//3pkaIfWAAwbBrHEJ1hYvN0/D0aAPkHJebtkU8FrT3FtRMcEff0k0rbusvzA
 qt46cbpUxXdvsPTu2caIgFV1xOoNwGx6IsUVz1daRLh7uhZCxRRJagl+FOEK4tVeKRU6jyaXH
 C4I+D9DwXvTk3hWfyLzfm1dsmd4+puXl5qSLW6C1SYhvkOOl+U91UiL2/YWHwmzv/PnbephLa
 M6qiTVygrH6NhJGSZm6r4WIo/TxmjBHuKxDHLmHcSJxnMP5Jz98ibEmdxdoqKfNoewSB+tSTU
 IAVG7adFJh0H9M1Ul+yBKE06woGOS/pqFKviYMpDiFOufxxTYj2esD1pSaMkPUJ0phRvDcfJM
 1MIjXsp09s1HJ3n3TZ98+Az5TzAx5LH2hexdwvlKO87w5kL9ViRscUXEdXwtQ0Zcvmey+FVxW
 RXK74aNyGCEbC3Y6T7r0oPl3jS9JQ+AlfZhZo2vHbVTG2xue80SGI+DFn1lLYCyUMjaVRcEPq
 piTmF3/dcBfhc93w/yKrCq1scQHFm5mDG2iNEHNanPZcdDIW7K6M2J+PKmhMa4J1P+5BCwDQD
 BeEWCQlG2vfhhIp3GkLkg/yrg4Rxlpt0MuFjReXfLoym6mwHX5cRsDoCCUvO1IrWSbgS225Zm
 s/5qFdU+mlLZ6ckw6tPGB0jOHovQHJjZr7T3m+YUBysEop1+p8B3GhTY37qciq3NtcIr1eCU+
 Aqccn4+JrnMgPPRPdLVN6TtmIOoh3l7bADPDv3TuncikH9FYdliaknx9U8c5iaWfsBRi6ybEZ
 dnxfu08HVFEYW8C38xYw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 15, 2022 at 8:57 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jun 14, 2022 at 08:18:14PM +0200, Sebastian Andrzej Siewior wrote:
> > Disable the unused softirqs stacks on PREEMPT_RT to safe some memory and
>
> s/safe/save/


Applied to the asm-generic tree with the above fixup, thanks!

      Arnd
