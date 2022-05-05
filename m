Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4A551BDB5
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 13:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356620AbiEELJO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 5 May 2022 07:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356545AbiEELJO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 07:09:14 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A03F13D68;
        Thu,  5 May 2022 04:05:29 -0700 (PDT)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N6bsM-1ntcJS163q-0182Xn; Thu, 05 May 2022 13:05:28 +0200
Received: by mail-wr1-f43.google.com with SMTP id b19so5599157wrh.11;
        Thu, 05 May 2022 04:05:28 -0700 (PDT)
X-Gm-Message-State: AOAM532/XuQ+VxCW+RCJlBYDifqthSn+DzppiqEiO0MXfdy9Lw2E8mwU
        AmTRs8BJlhS1+ChRbtvn1xzCo8mnDEnJc7hJUME=
X-Google-Smtp-Source: ABdhPJxGGq5Fa9Cx5SSfnKSUo4b+MfSDkdVAVLGUTqD/GBtgFGV3C400pAFOppOt2I8pMGzWGNhT2WNvFkyhjBMEOv4=
X-Received: by 2002:a5d:49cb:0:b0:20a:cee3:54fc with SMTP id
 t11-20020a5d49cb000000b0020acee354fcmr19580488wrs.12.1651748727768; Thu, 05
 May 2022 04:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220430153626.30660-1-palmer@rivosinc.com> <20220430153626.30660-3-palmer@rivosinc.com>
 <7375410.EvYhyI6sBW@diego>
In-Reply-To: <7375410.EvYhyI6sBW@diego>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 May 2022 13:05:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2fLg9DJvQeOAFhRQk-O72PAhJ77CLQ+Pz_Vvh1WV1APQ@mail.gmail.com>
Message-ID: <CAK8P3a2fLg9DJvQeOAFhRQk-O72PAhJ77CLQ+Pz_Vvh1WV1APQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] asm-generic: qspinlock: Indicate the use of
 mixed-size atomics
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Jisheng Zhang <jszhang@kernel.org>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:QysLADnJBunexLp/VCtIkDOzKmjNjjUU2GxeczuxJ6drISdwCcZ
 sEAlEW8THoAaog2NWGf0dK6cn1QMdZU1Y0xy3ph/vSNkTng9Csu++f7XgDol4y+nBjXU4CD
 x+ymU3d1p/NSwHjHWpb3AN+XquqUvSAyQR9Bg5roWAaHcSn+tY17mxJAC7WmXtMNh6SHUtc
 rADN6ZPKHDshur69Frhmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TjhMztt8YDc=:4dnBppYatAR7PxXLHcu0eo
 yFaNulrHg6PxYbAlJi5oFrgK9d2ktnedOe3BxGnYgdV333sxEmIiZtvkOrwKGQty5J9Q3HRvw
 mxuygVf/EKkVsqBKdv4ymcdQ/9lPIssIv/RSUNbQql7WEb3QRddo7lKjLb9v61vofV1wwDGQT
 lwTUa/aBCTw1z6g0slx213YmzOb8zkN4FOAEYp10fnJaw4ra+xjHKynTWCe0sSSdtJ6z2id4x
 CERoJaVnoTFzh5Ms7328cFAtAYuV5OAAPo7DUVyTSQJ+LfJIu3jODNK6ZjFE0M9F2x2NqVxH7
 QtvLGaCFkEqvBRUKQLBiV/VkviNW6Qg46JzeCx2L03mGGHhAOVqZ33Fq23ChS5R5UTCfZACjA
 sfIHuVhYToKIhq7qp/3c9aD+RGWlwjZmWuDNbuXoXjrinkt5bJIUYUkQbr3rJdAHSobISsWUO
 86aOpf2cv3OcNfpVL1RG6NGll2R7r/0YmAeMlQOS+OKm8aBsMsnut/Ynf7g7ghZ+o6zwph60B
 y9A419lJMhUv2Ju528xhjq+GBFrYlskHssSxN9wJb8vW9NuH6qOGs1YXOCWmN++5Omqs0A7n4
 9jk71gJDgFTTtsITTzbGALziXOuUv7ybUy/S6X0odsB8Mde8O3/4gnpCnDciJekfKq0vpiFHm
 5tyh3SCPUHYwQkjns6wJqi3fu1420CLXTz0HCP4TfPhIw1KdzSqZ3GOrSxP8X6elweiEz6PTt
 WBvoftQcRQy2sRPRNyXyIeMxApzdSJDfbs2iT5zoyRaenRNrKmyEbr3XVVBavjcd3F5lrQY8d
 Zm4K0sx3qhPTkkL1m8Wmfpg9b8g8R2H58GYmUehIZgLk3k6SIQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 4, 2022 at 2:02 PM Heiko Stübner <heiko@sntech.de> wrote:
> > index d74b13825501..95be3f3c28b5 100644
> > --- a/include/asm-generic/qspinlock.h
> > +++ b/include/asm-generic/qspinlock.h
> > @@ -2,6 +2,37 @@
> >  /*
> >   * Queued spinlock
> >   *
> > + * A 'generic' spinlock implementation that is based on MCS locks. An
>
> _For_ an architecture that's ... ?
>
> > + * architecture that's looking for a 'generic' spinlock, please first consider
> > + * ticket-lock.h and only come looking here when you've considered all the
> > + * constraints below and can show your hardware does actually perform better
> > + * with qspinlock.
> > + *
> > + *
>
> double empty line is probably not necessary
>

I've applied the series to the asm-generic tree now, and edited both the above
as you suggested in the process, to save Palmer the v5.

         Arnd
