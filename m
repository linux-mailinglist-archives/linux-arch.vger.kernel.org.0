Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BF654A150
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 23:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349315AbiFMVZo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jun 2022 17:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347782AbiFMVZ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 17:25:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B11133
        for <linux-arch@vger.kernel.org>; Mon, 13 Jun 2022 14:14:08 -0700 (PDT)
Received: from mail-yw1-f180.google.com ([209.85.128.180]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MA7b8-1ntfaW3rMQ-00BeiQ for <linux-arch@vger.kernel.org>; Mon, 13 Jun 2022
 23:14:07 +0200
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3137eb64b67so10704927b3.12
        for <linux-arch@vger.kernel.org>; Mon, 13 Jun 2022 14:14:06 -0700 (PDT)
X-Gm-Message-State: AJIora8MvsAwwXpA+cqN1WDnpLw3uNNa0D64KS8lsg4b7yOPu3GLLQmM
        vfn1k4gC97Q4IP25Vf73pE+0cW7AhUa+Mt1eAlI=
X-Google-Smtp-Source: AGRyM1tJd2MWHVKh9bBI9MTkHj5Hly3SOeNtXxo33Ok5nK0q+OTF3XVZjp1WNtDmPOMJnLFuQnTasLZFfTef8lCAdzM=
X-Received: by 2002:a0d:d84d:0:b0:314:2bfd:ddf3 with SMTP id
 a74-20020a0dd84d000000b003142bfdddf3mr1905526ywe.347.1655154845811; Mon, 13
 Jun 2022 14:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220613182746.114115-1-bigeasy@linutronix.de>
In-Reply-To: <20220613182746.114115-1-bigeasy@linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Jun 2022 23:13:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a18cCESYki+4_3UgALRUq1MKmjSZvfXEyKHxgSENYfnXw@mail.gmail.com>
Message-ID: <CAK8P3a18cCESYki+4_3UgALRUq1MKmjSZvfXEyKHxgSENYfnXw@mail.gmail.com>
Subject: Re: [PATCH] generic/softirq: Disable softirq stacks on PREEMPT_RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9AokjQMjOQVdd6Oe//tu501YPKrYgJpQ03mhTeyqoV0xa2xKins
 kV8+YX5G7F71fLVXjF3c+P9AjJKbSxaMjHMemzsqNnslJQARJd3j/ssJilT2cuQ7NlXps8J
 dwdVsYu6xuipgxm6x2R5BOpScewPT29FT1KSQPMDXsrG3yF2peIeTNvEOtze1h7c2aXnLzu
 p1GG6XrC05+za32wK2ntg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tvFP+55AyQ4=:k1/Srt6iEpJAKV7hbQtRtm
 ypIPlwWCMKPd3tegoflWKrFwbRKxuo8VfIEjBNHd8kxm8PP9u5qbfhmILs1n/3lqFi6OIcEgd
 uqQoOmALa2ORXBhbZgxFmsXGOcYkrMFFrXSTbyR/Z/+YMFqSqvKeYwnoPDkOoJ/0C5CY4FT2f
 enSCnp5iFdGjgzwPXEykHG5tVhqG2YlMxarhZk5KHvPAc9v2wAxjjgUTZk0+7kD5yzAzwFT/V
 fQAZbuc0NBhgoPEu9/Zzmit6IsXUDy46ltlM6wgk4r/Qk79pzt7mUL2zkJZXXhEWFD/CsBIdm
 pdlnvBoIQJWkbgZay1HJfatNWXAcMgxjxn6y3XdzIkeiaFTqR8/xjNdfHiff4/1flx0QIWy6w
 PPFOyzVVOrJOv9dBn+TB9hs+csE/K1prggQuNkd8YNbN3AvoKL1eFjlHjCx3V+UqY65hKu8qt
 DaoSZ5xQ/yaociY5qhk07g1BdjuKM6lQuogbvrzY45sPOu6xcljHTE6UGR2Keom3EPAfn/oXr
 fvEZkrMCjaThWoYGbih+0xV/Q2j9cDifIv9R/npYUMhCTDRJXIQkGmUjU8dyE/iM1ScOyqV9x
 tr51KDdp7TuuueD5BIz8W9nU87TgNRPh13tNaXPMvqmLWky6YaCPYb9nNSzTvDECDI33GSn0f
 eAsLRpJ3iimTqyWEP4laY+eWYfH35Sc2Wz3O05jteuQXcCGD650HXDRMzF/7bAIwjZLBQjTgX
 SxAILda7lgzFUUlMBqcb8lxrc8MstQBukkXrLQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 13, 2022 at 8:27 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> PREEMPT_RT preempts softirqs and the current implementation avoids
> do_softirq_own_stack() and only uses __do_softirq().
>
> Disable the unused softirqs stacks on PREEMPT_RT to safe some memory and
> ensure that do_softirq_own_stack() is not used which is not expected.
>
> [bigeasy: commit description.]
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

It's probably best to keep this together with the corresponding architecture
specific changes. I was a bit worried about bisection at first, but
then realized
that this is not a problem for mainline since ARCH_SUPPORTS_RT is not
yet enabled on any architecture.

How are softirqs called on preempt_rt? Does this result in higher stack usage
for the normal task stacks again, or are they run in separate threads anyway?

          Arnd
