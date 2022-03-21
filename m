Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524DC4E24AA
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 11:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbiCUKvQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 06:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346498AbiCUKvO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 06:51:14 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA69E33E05;
        Mon, 21 Mar 2022 03:49:45 -0700 (PDT)
Received: from mail-lj1-f174.google.com ([209.85.208.174]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N63i4-1o7j4y0AO0-016OGt; Mon, 21 Mar 2022 11:49:44 +0100
Received: by mail-lj1-f174.google.com with SMTP id 17so4269401ljw.8;
        Mon, 21 Mar 2022 03:49:43 -0700 (PDT)
X-Gm-Message-State: AOAM533fEfKyRDrZl6t5ZGj0/hTxVU3+Q71+iJK8Mpc4XkNfkp1gAo6H
        p2hKIlCXOlWKUyooNf879P11KDvamRqofD2bEgk=
X-Google-Smtp-Source: ABdhPJzcZ0Yxl2PaNSM+qTLSuTVghKJG3OLAZNn+JUNcoqLnve1kS8gk8xn9EpeRekkC77XHfghVaNA2oBBlHj9vNLU=
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id
 e12-20020a056000178c00b002040648b4c4mr6283444wrg.219.1647856201405; Mon, 21
 Mar 2022 02:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-3-chenhuacai@loongson.cn>
 <CAK8P3a2gKGuMTLawFSf1hd3LY7rCVUquTPVHMcxBTok6+y-Rag@mail.gmail.com> <CAAhV-H6eDSU20gjLgEKM318i1ksk23thv9cLJKmAo_cBzjtEkw@mail.gmail.com>
In-Reply-To: <CAAhV-H6eDSU20gjLgEKM318i1ksk23thv9cLJKmAo_cBzjtEkw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 10:49:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0PXeEAvZeq0djqCFqPSkFe5z-bg81kcs69ZTcBSL=24Q@mail.gmail.com>
Message-ID: <CAK8P3a0PXeEAvZeq0djqCFqPSkFe5z-bg81kcs69ZTcBSL=24Q@mail.gmail.com>
Subject: Re: [PATCH V8 10/22] LoongArch: Add exception/interrupt handling
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YoaeS4jNV/JubHRnF4GIrDNIMQNQmUO1gQu8S3NIm8f/RE/rKV6
 Dj4TegO2P6SEPv6EMhaH+ipnUUQGfji0yPu/I7NGFMqGnrRfPztjMoPZpE9ICiadMbEHlur
 /g0U2q7gJhR+Pr3+Lo9Svw+6VKExaLPmKG3AJYlyxnXi9Bo7YSogW3CpqEtptzO2ovBm2bm
 L+3OZIs0KtSfxHojkkBNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ml/XYeb+7Tc=:Yf1FWxdgbKn0Ji8IgXKODS
 pKYHfR9ttwBrINb1uxK5fiD2QaTJlo3WBl96fUdM1zD7pvc84ylCS/8lxdCSlA4fAETjxATwc
 8pujZ9+trxJMmJsh7hBE8SshtzczxZrx+WGseKLqf48BjRkUNZHYZMrziv6uvNWnsTuhjAXbZ
 WXQnReI9jVrfmyX6T224qlp3k8sKZo17fupBCvVgT8SGE9NsOQZCcGUrA6Y0M3OU5AxBvfZJ8
 GJ18HAXZ3/rCXT0YtgSkLGnX1b5Jf/VIK+lUKNlNmf/RILSSDIOoMlUplaXsKYwc0+rkBxSYL
 t4pyaF1+W/KcOSL3OKv1HI2Z8DTwvXZMNBSevGiThWwXHISCGoTdMY8RWCwb+HV/jGCITVJ4C
 6UBbtBdWi1sM21s5yCafx3QCGBUb46kyR4Nh7jI0wpvXs2QBgocQE+jO1ENtqBYOFvibz6xzF
 LdEdt6ZNG+I2fWM4pyNMAYFs4neDRneG+XxUw6M1Aj3oEQI7lBY9baA4SkNX3DrnCOzMb1I+w
 ySAjVYdYg/7hCOjQ/L68gh21NAhB52+Ky99ZgsRSWVTZlnQdPeulCAkizwOT8a/9v84535AsZ
 q21obqH30JD1vV6WtvuRNyn+Yhb++ON9jFELtxiJLvhNlu/0oAaBhCYNcaS6ElldjMHQtbDeS
 1psRTY5VUYYQZzpNuL42SuIosIriV71s3e1h+LH52XQl6EVwxQ8YvOV6xatXmjhDGTvreIr1O
 UGWuqxFSR0kipQebTTFk7tQVuHAczVS/W1nYNN89+YUuWHWRYH/Tk8/IFCDI2dbTYF3LbtBH7
 K+lN/4iMG6kX+7mBARcv85Ru221KSOLddg/7tJCQj2K2FV8DDk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 21, 2022 at 9:46 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Mon, Mar 21, 2022 at 4:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > > +unsigned long eentry;
> > > +EXPORT_SYMBOL_GPL(eentry);
> > > +unsigned long tlbrentry;
> > > +EXPORT_SYMBOL_GPL(tlbrentry);
> >
> > Why are these exported to modules? Maybe add a comment here, or remove
> > the export if it's not actually needed.
>
> They are used by the kvm module in our internal repo.

Ok, that is fine then. For the moment, please add a comment about it here,
or remove the exports in the initial merge and add them back when you
submit the kvm code.

       Arnd
