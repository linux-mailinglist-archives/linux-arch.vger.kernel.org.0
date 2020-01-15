Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB04813BDC1
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2020 11:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgAOKtW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 05:49:22 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:32843 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOKtW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jan 2020 05:49:22 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MWAay-1jApfm21pi-00Xa9s; Wed, 15 Jan 2020 11:49:20 +0100
Received: by mail-qk1-f179.google.com with SMTP id x129so15152028qke.8;
        Wed, 15 Jan 2020 02:49:20 -0800 (PST)
X-Gm-Message-State: APjAAAUS+G+kHEaD3VnBKf2Be0T/HuC9ycpmmCkUlkdzy0LSqyzoO57y
        i7t76cYoAPnThnktoI+RfU9etpEW/Tzo+Mql/+M=
X-Google-Smtp-Source: APXvYqx/5s855DLcrc1gRr+GKEkvylSSHgSnuAyI754FsKb/zhyBUMBjzYxvxT5+lGlSwqkoG8sWPpdvRZpbxm+d9Gw=
X-Received: by 2002:a37:84a:: with SMTP id 71mr25699141qki.138.1579085359252;
 Wed, 15 Jan 2020 02:49:19 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com>
 <20200114213914.198223-1-ndesaulniers@google.com>
In-Reply-To: <20200114213914.198223-1-ndesaulniers@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jan 2020 11:49:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3JfUjm88CLqkvAmCoEA1FsmQ33sfHGK4=Y5iuhWxet5Q@mail.gmail.com>
Message-ID: <CAK8P3a3JfUjm88CLqkvAmCoEA1FsmQ33sfHGK4=Y5iuhWxet5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Q5qixYB3a1v4oUpjiPFKsupY0vRc/WhIhIV2W+YOmaig7Ji2CzT
 UMKhoOID58MNc71U5purxEfZ4M5bjTWD6hvoLoHF05hsoKbeHM1ZpYizUC/TbsuShgN1QTH
 7LL6PEy5W2j+MOYfTP/K53aqVHyUuraDgl2OS/SLytbsCQciXgJ2B4CTT9xy67DAm+8rX+M
 0zTY0Enw38HMRMS2L1eFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yNPqsFBf42k=:6LFXgCJMYu9dcqahQa8E6N
 QzCc/Se57zAT+n99E938ETYZAEg6+yIgbo1jb25YpgOrHBSRa4fYwCFZiJjWkmRYWvz5F+Fwf
 o0GpAp/B7kLYsZOUyN3N4ZgZS6GwaWI3zHeFaRgIKmFomCD+fW/F1K6Iel/Qnu/ZlsSJs+G73
 dwgkutaRsDoVxvAGSkfEP032J6saCluLep5ulEwtmdwX9VkoT0EH5pXvotCXg1TWVUMLpcaTg
 S1V0oTWp5axqXPSuOKMIr+K3ayZ/0jV/1NjwVmtzngWBGP1E/oo/PDzuUJHhj59tuu5chC0S4
 xjfzs0bt1jNVz3/6XRsign++c/RPaHbaZaNCNbuOCaNpUgjVd8U7aGJtJf0h3inzjYffJ0B6H
 glNSdEtNcIjvGamTsgNacY5AEucmb6H6+0/RJeGb8o1wL5TNU7feV7mOQCkhfTx+03pLjMT9g
 DF/8+nt+yreizVeHIT2Q/ZuPAdadeHsGSloeJAdtnOGN9Gh/H1EfhGrpGmiP8FxzgwQtmvG40
 lVCLOn03/L/GeU9nlQmIJthM8cjaGtWO9Pv/LR8J9V91emnDMuYYw/ZTlB0pVK0qBsNc7ueCW
 rKbDM1KhlkPTPIH1gnXUTkC+as7P22smNj9RSwFkpAOPYV6M9W/1tbq5a4Jodbr86gr0kC/1g
 3PXxW+DKo5rVrtMNw/HyjmmwtALuhWEvp6f3tjdmYrt9/iccAaZywb8zgAIU/BTE7BJGTuCb8
 SRSR7H/1YlC/ILSQcuuAwCirXYafm1BFbqWzl2PrwoDTHS90jCoej+VcPYcQpIRDlgO9Suu10
 YAMA2bYZP/jbsRof6RgHDDM1Amswdzvao62BMrJOtxn4VWFyZPP+aH/WaSHfL8LIImar2OaTm
 tLTFloo5RcETiiCEthNQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 14, 2020 at 10:39 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jan 10, 2020 at 06:35:02PM +0100, Arnd Bergmann wrote:
> > On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> > > discarding the 'volatile' qualifier:
> > >
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> > >
> > > We've been working around this using some nasty hacks which make
> > > READ_ONCE() both horribly complicated and also prevent us from enforcing
> > > that it is only used on scalar types. Since GCC 4.8 is pretty old for
> > > kernel builds now, emit a warning if we detect it during the build.
> >
> > No objection to recommending gcc-4.8, but I think this should either
> > just warn once during the kernel build instead of for every file, or
> > it should become a hard requirement.
>
> Yeah, hard requirement sounds good to me. Arnd, do you have stats on which
> distros have which versions of GCC (IIRC, you had some stats for the GCC 4.6
> upgrade)? This allows us to clean up more cruft in the kernel (grep for
> GCC_VERSION).

This is the list that Kirill and I came up with in the thread I linked to

> - Debian 8.0 Jessie has 4.9.2, EOL 2020-05
> - Ubuntu 14.04 LTS Trusty has 4.8.2, EOL 2019-04;
> - Fedora 21 has 4.9.2, EOL 2015-12;
> - OpenSUSE 42.3 has 4.8.5, EOL 2019-06;
> - RHEL 7.7 has 4.8.5, EOL 2024-06;
> - RHEL 6.9 has 4.4.7, EOL 2020-11;
> - SUSE 12-SP4 has 4.8.6, EOL 2024, extended support 2027
> - Oracle 7.6 has 4.8.5, EOL ?;
> - Slackware 14.1 (no EOL announced): gcc-4.8

In an older thread about moving to gcc-4.3 or 4.6 as a minimum,
this were the even older distros:

> - RHEL 5.x has 4.1; extended support EOL 2020
> - SLES11 had gcc-4.3; extended support EOL 2022
> - Debian  Wheezy (oldoldstable) had gcc-4.6, EOL 2018.
> - OpenWRT 12.07 Attitude Adjustment had gcc-4.6
>    and is still used with devices that have only 4MB flash / 32 MB RAM

      Arnd
