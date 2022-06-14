Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823F154ADF1
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jun 2022 12:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiFNKIb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 06:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbiFNKIL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 06:08:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66DC340C6
        for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2022 03:08:09 -0700 (PDT)
Received: from mail-yw1-f175.google.com ([209.85.128.175]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M4K2r-1o1Ka61Ytl-000Lu6 for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2022
 12:08:07 +0200
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2ef5380669cso24031667b3.9
        for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2022 03:08:07 -0700 (PDT)
X-Gm-Message-State: AJIora/unkXhU6BnYg6LVKSRd68G/JzezgZnyclEFOpax4QIEIqQwtOC
        LxekHUYxjEwPTu+NaJg2+Eaj1w4CeGpWuZ/sZ5w=
X-Google-Smtp-Source: AGRyM1u+d/X8R22p65Pd/0U6tZ897sRvSQP3SabtjbvAR2W82yqgVxt8GLpP124xPN2TKmjKuESGtRa5Jm2svDcrEfs=
X-Received: by 2002:a0d:d84d:0:b0:314:2bfd:ddf3 with SMTP id
 a74-20020a0dd84d000000b003142bfdddf3mr4741305ywe.347.1655201285911; Tue, 14
 Jun 2022 03:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220613182746.114115-1-bigeasy@linutronix.de>
 <CAK8P3a18cCESYki+4_3UgALRUq1MKmjSZvfXEyKHxgSENYfnXw@mail.gmail.com> <Yqg0sNLrtyMvhMNY@linutronix.de>
In-Reply-To: <Yqg0sNLrtyMvhMNY@linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jun 2022 12:07:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2KxBgdu66tbc4YEUDsjZrRRs3t78NNPLj3K9XFB+BFAg@mail.gmail.com>
Message-ID: <CAK8P3a2KxBgdu66tbc4YEUDsjZrRRs3t78NNPLj3K9XFB+BFAg@mail.gmail.com>
Subject: Re: [PATCH] generic/softirq: Disable softirq stacks on PREEMPT_RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UX11tM7jBbbp68OC/pYfGpkeCt4hwGvdwlpKwOoleegjEHCUCnc
 g198gM0aoBPOLM1DKfTXwThmhZusDFDfYJ18x/YBqRAaeU5vxk7Y+fORqDVqRMMzxAECmwo
 a2m5ktNLNfZV8bb3WBq7JjzhcJtn17AcfIWZhsTvViFxMVSwW+m3jP9geCvKivd6sV/OiwW
 WplOvPMXCugmVi4wLwqXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RMTZ/BNiaKY=:UI0L0i7pyrN1V3BqmzAk9k
 4LdKSbVlCUSJUWEObJlNONtkzSbLZeQZXQs9o4wiQjdwRaTGZqqs8lCIG//y3cnyeIyARskkv
 VeHQfF5NEnN5u5HB32SmYYV011hLIG/TZNnzICTUJSd+8BPX/2rgga0lkXv35c5aRSZ8dgk58
 1XdmEQnStPcqP+VgihXbqixK88cU5zL9R7rkrGQpJpQ0wzNAKIdeP9YdoAM4xVwhyRUGba9qK
 HU8Kc4LNZ8bERDx1lYCwe8dQyE1cHSgQQ8bD1sZ2jHg/mRGuibs1JC1iOg8jpmC/oJeRSclAv
 S30fmvj6Dvo9m8cqdFEasjAnblIHnXrP4L+SZlslOKDPvrUVdX8mV9G5bv3OzFWmPO9PK5pWS
 KRwpk8tFhdIP4IP/UkM8bzJS4u9jalF0heKj7semoiAyJ6LvJdtBpd75aHP+YYu4KyFAV80S0
 nAECC4zq7Y9pccvuEHAMW+CADyqfkgncKEy1CzJTeHaYWIzcqGgXMWrwn90OEssQcSu+Ay8bl
 apqbdHEUI0tymTM81R4meR2pYjnRSbjeH7bDpYBGQgM3LtbjU7Y5zkWfg0Uri7x47H/KKlB9p
 9gOm+66iZcUjP/oUf9Qj4AW2evxJMiRuBL6lDaiMvQGPcbm+J9YfcCt0hOdKe07vk0DcGtCP7
 RwfySnaTdtcqzx1Ybv9EGfZScxcERU9vApfbdW8ZZ+byuhUJRd2Jp2l1rfZv4woaF/J6U2rDA
 1naYj7Xgs2t6ccfyN804UFr/KCHGxaNLyPRcTw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 14, 2022 at 9:11 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-06-13 23:13:49 [+0200], Arnd Bergmann wrote:
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > It's probably best to keep this together with the corresponding architecture
> > specific changes. I was a bit worried about bisection at first, but
> > then realized
> > that this is not a problem for mainline since ARCH_SUPPORTS_RT is not
> > yet enabled on any architecture.
>
> So where do I put this patch to? If I remember correctly then arm64 is
> using this. ARM has its own thing and x86 has this change already.

I don't see HAVE_SOFTIRQ_ON_OWN_STACK for arm, parisc, powerpc,
s390, sh, sparc and x86, but not arm64. I would suggest having a single
patch that does the same change across all architectures that don't already do
this, and then merging it either through tip or through my asm-generic tree.

> - ksoftirqd thread.
> - in the force-threaded interrupt after the main handler.
> - any time after bh-counter hits zero due local_bh_enable().
>
> The last one will cause higher task stacks.

Does this mean it only happens when a softirq gets raised from task context
(which would be predictable), or also at an arbitrary time if it gets raised
by a non-threaded hardirq or IPI?

        Arnd
