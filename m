Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575414C5F12
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 22:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiB0V3h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Feb 2022 16:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiB0V3h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Feb 2022 16:29:37 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F584BFDB;
        Sun, 27 Feb 2022 13:28:59 -0800 (PST)
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MaIvV-1nlAWC1tuH-00WHCz; Sun, 27 Feb 2022 22:28:57 +0100
Received: by mail-wm1-f52.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so4764783wmj.0;
        Sun, 27 Feb 2022 13:28:57 -0800 (PST)
X-Gm-Message-State: AOAM532Yh0EM/vUi3XrRrspMDFAX2SaJ5rv7tdetecnYVjti06tDdWFO
        SH4Tvha2ueTqxdoi4bWFQM5ZpyECPT48oZb8Ix0=
X-Google-Smtp-Source: ABdhPJzPpJK3kNFeFtCRMNEMS0Me6SFTBXzOWyPSNiCvLYylg14xxS+eF0Aj0iTsHF8iMxcR3IMA0ji5lT283orHBm0=
X-Received: by 2002:a05:600c:4f8e:b0:381:6de4:fccc with SMTP id
 n14-20020a05600c4f8e00b003816de4fcccmr442954wmq.82.1645997337125; Sun, 27 Feb
 2022 13:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
 <20220226124249.GU614@gate.crashing.org> <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com>
 <20220227010956.GW614@gate.crashing.org>
In-Reply-To: <20220227010956.GW614@gate.crashing.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 27 Feb 2022 22:28:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2bocgetbPQzy5xWhnW=mOdGynp_pWrPt6KeVTkEfEwKg@mail.gmail.com>
Message-ID: <CAK8P3a2bocgetbPQzy5xWhnW=mOdGynp_pWrPt6KeVTkEfEwKg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ciFczsxT+CkOslJ2l0u6JWGBxbS4E0kMNdAbJTITFYATBX0CNY2
 7+AncTxqmDLOwHEmCgBAUSM4aZJ94QW7o94x4sG/Exo+a/3yH3UynluzSL8WE0Q7Ryykbeh
 U4U/Uvp21ZFndObDj62+2BzyVnp58UAEMZ8xHlSXfA3O7T1ZzMsKegffhGe3EQdziId/cOx
 GDhtYvmjUydW/4Tzfc84w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:41G5XSrR0U0=:gBsDSllfoD+0ibXraVqNyP
 kJjWSAvD2hKOfVjLs9CRKkacECdySQjOxpVjft8KH4KvMgsh46wS3pzgjtX6Ph4KegHnmQdWc
 GffFcsPLAg96Npv+LNkXad9BKE3IRfJDXwk6K/+saBMYf2DBl/NX4X9+kVj4pWvBqm3XlgSEQ
 SVipWz6hBhfdex9J7KzA8IM7t7eHCoiYMNEQ2uZfHGsysToRqnJzQODFWmS4fOTdyxaLDNfVo
 dJK+2dpccs+SA56Rjszlb7Z1gQ83X4t3rcLn/03pYbumtiNisVOD+d+OY0jB29Rd9vvxqqxwg
 KeUXPUWsqV13Z6yUZcUg26t10sVEZCz2CUBOzzQcugLXPo3q4rU3N5czJ2ecgfNQVdfws+bPh
 5KE11bZW0Fpg5Ckt5PJvGqWkJMqBTqOzavSXoCcPUcj5apqh4yMUJvtrx4S3vcDjt4KFHoozk
 qbcvtCEwNGZjTeA/RCX4LA3Z8HNi7u89KgQ2F9I5nD0cSkdJe6tZuHSyJtlK4S7fBZrHaagXI
 1UL6SdJwViVICwSccjTQFUeEsLLZx45To6XD6cfeofgUHc0Ql6A3M35gzm1hyJy2qdu6+JdE0
 fN/dAEcvVh5FQTyDubi2hmjA9lcDqr89j27mC9jgEp70KsDt25fR/dtB1a3h+1dfNM01KIv1D
 R2vFWO47yLKp0Btc/jNJxGCKnAaamQ9WC56lWxr5pnHzBvCqUPq+dxAfOhUsZGDF2nC0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 27, 2022 at 2:09 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> So imo we should just never do this by default, not just if the nasty
> -fwrapv or nastier -fno-strict-overflow is used, just like we suggest
> in our own documentation.  The only valid reason -Wshift-negative-value
> is in -Wextra is it warns for situations that always are undefined
> behaviour (even if not in GCC).

Ok, I just realized that this is specific to the i915 driver because
that, unlike
most of the kernel builds with -Wextra by default. -Wextra is enabled when
users ask for a 'make W=1' build in linux, and i915 is one of just three
drivers that enable an equivalent set of warnings, the other ones
being greybus and btrfs.

This means to work around the extra warnings, we also just need to disable
it in the W=1 part of scripts/Makefile.extrawarn, as well as the three drivers
that copy those options, but not the default warnings that don't include them.

> Could you open a GCC PR for this?  The current situation is quite
> suboptimal, and what we document as our implementation choice is much
> more useful!

I hope I managed to capture the issue in
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104711

         Arnd
