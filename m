Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3759957B4C4
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jul 2022 12:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbiGTKvC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jul 2022 06:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiGTKvB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jul 2022 06:51:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68E325E90;
        Wed, 20 Jul 2022 03:50:59 -0700 (PDT)
Received: from mail-yb1-f180.google.com ([209.85.219.180]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MHWvH-1oIGA43Cs5-00Dafe; Wed, 20 Jul 2022 12:50:57 +0200
Received: by mail-yb1-f180.google.com with SMTP id r3so31448676ybr.6;
        Wed, 20 Jul 2022 03:50:57 -0700 (PDT)
X-Gm-Message-State: AJIora+rwUUhLfsdlNMZTpRQq11LFFPG82naYolx5uDazs1RlnRXiYsT
        qtK4LzSUF5JGwLn6tFNp5ZqdSbTpXcXbqY+D/3w=
X-Google-Smtp-Source: AGRyM1tBRMTZAOLkCSrWeM9lOgL7tKWZk8rYWNHxclKHzsaDcuczmA0/1wZXc39YCwugw2C0ZMWGEXKaZjRPuqvwfh8=
X-Received: by 2002:a25:808c:0:b0:670:7d94:f2a with SMTP id
 n12-20020a25808c000000b006707d940f2amr8739178ybk.452.1658314256329; Wed, 20
 Jul 2022 03:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a12-atmqjtjqi-RhFXH2Kwa-hxYcxy3Ftz2YjY5yyPHqg@mail.gmail.com>
 <mhng-f5938c9b-7fc1-4b0c-9449-7dd1431f5446@palmerdabbelt-glaptop>
 <CAKXUXMzpWsdKYbcu5MxvrAEMLHv4_2OGv2bRYEsQaze5trUSiQ@mail.gmail.com>
 <CAK8P3a32m42gT9qz+Ldvr8okYGOc=kKeoJTGNWyYT71N8tJfEA@mail.gmail.com>
 <4ff47e50-8702-1177-612b-73d9700e47c5@microchip.com> <CAK8P3a01x_ETchX2Vwm9oNaFJDhVZEu+G-2vRwegqKkMe54m6g@mail.gmail.com>
 <CAKXUXMxOUs31SkGb0JD=nmHxgFy4tQ5vn6yD6ivgRpbSAxm7mA@mail.gmail.com>
In-Reply-To: <CAKXUXMxOUs31SkGb0JD=nmHxgFy4tQ5vn6yD6ivgRpbSAxm7mA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jul 2022 12:50:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3K8PnPF7KEEVb=hquZsjXiatCkyXe9B_RLBcse2jU5LQ@mail.gmail.com>
Message-ID: <CAK8P3a3K8PnPF7KEEVb=hquZsjXiatCkyXe9B_RLBcse2jU5LQ@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jsHCyT7O6w8Ky7eqhBbCVdvUyGL4mEFwt0463REio7LBL3eCrQF
 nIuxtY/OYl630VCjUk7E9bdirZVUQSK2aXFGssXGvQx3yw8E7ixhENIwvuSY2CK927AplQL
 jWnfdr/7G/RWq99tCUxGzqjDnmAFXjT0PnABZKuf61vZtGx8wkbJQIWuNCsDX7JrpZx7kxx
 EvMjSjj//sq94QcTtIkyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:agORFtKC/Jo=:drMgcuJRGEM+NRWS5yLfgh
 sK0xOLbpTV/2skp90XEyrNxcISsXa0mT+QPOKVEksjpYCpiBMaALBrZjbW6ZUED2qRX44fhzd
 3XK45uCo6rj0VAaExcoAtOnLSk8dd+B1Gn96uNnmocBV35O+/2MrBwTj5leDPH8TAqVdj22Bz
 eKjJv5Judc3OYblnmAKXKEO8TD3o2WXqBO66kmVodS4fyqcpa/24vRLARyyRCUP0VE2YwkaaU
 4mUjshmdPpAsM5w/rcL7PFU4E3gYxh/jG91yTEVr/gGJgGbmPL1FpCZzG3e7+LaaOOqpOs1Tz
 VuPfECflF5R1OGPGH07ghZbpDk+Kk67WHnLZ5R6IZvefmXaP9+G1amjL8lLmBM2JuSLpk/5th
 J7R1Nnob+MPdhUuIAhQzpO1Hxtyf2h0lBukm2G4EfuzJtR/Pwrf/ci8W91r5zl42169cQ2md0
 r24hF/4YZWnw73Zj0wbWW9B1spHgT+7dUVEEtaBuk/i2uKjcitRgz2NhMU+AQgCnIjL+cYknr
 Ug+mXuA7yyz6HY60hKKpyzmnRKnQEdvC1jtVmeFFM6V2IFy0L7p/0AuwPqrc1bt225q7oikGs
 20aIvcCpEuhKwy3HirUpB1RoUtA+z3epfq2LsfUa6TURrpgOtT0ulAlriTxnrEf8DMGlfsIFz
 TlFwP/ITNyfwNy4QAjNd1MA/5hPnvZzFbiaoJJPeeLJ5+sWs6rdq74UIL62c3DdjmraaI3SEi
 TThFrxQGTJuyNk1WcPEwDyIh4f6Wj3Blf0kRWg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 7, 2022 at 4:41 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> On Thu, Jul 7, 2022 at 3:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Jul 7, 2022 at 2:20 PM <Conor.Dooley@microchip.com> wrote:

> > lkft just found a build failure:
> >
> > https://gitlab.com/Linaro/lkft/users/arnd.bergmann/asm-generic/-/jobs/2691154818
> >
> > I have not investigated what went wrong, but it does look like an actual
> > regression, so I'll wait for Lukas to follow up with a new version of the patch.
>
> Thanks for your testing. I will look into it. Probably it is due to
> some more rigor during builds (-Werror and new warning types in the
> default build) since I proposed the patch in October 2021. That should
> be easy to fix, but let us see. I will send a PATCH v2 soon.

Any update on this? I have another bugfix for asm-generic now and was planning
to send a pull request with both. If you don't have the updated patch
ready yet, this
will have to go into 5.21 instead.

      Arnd
