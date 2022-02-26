Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539274C5875
	for <lists+linux-arch@lfdr.de>; Sat, 26 Feb 2022 23:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiBZWPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Feb 2022 17:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiBZWPJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Feb 2022 17:15:09 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA961DF847;
        Sat, 26 Feb 2022 14:14:33 -0800 (PST)
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M8xwu-1nKFJh3DWw-0066R7; Sat, 26 Feb 2022 23:14:31 +0100
Received: by mail-wm1-f53.google.com with SMTP id c192so3637559wma.4;
        Sat, 26 Feb 2022 14:14:31 -0800 (PST)
X-Gm-Message-State: AOAM531ND0p4kXnNDC2sgqSdiW71n870mm+gJysDzjYw/NmMtaNszQjt
        wlJU2aBNAFW+iL2bAA+RjPmAOtUvbUffsQIyE9M=
X-Google-Smtp-Source: ABdhPJzDQiG2WJNNyU8zXyeqkp2/I2pIvAnATyav1sudQ7qVyIelNKbafaciVu8AmGz8pwOL7x9RptXoWVX/tSfEtXg=
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id
 l39-20020a05600c1d2700b0037c74bb2b4dmr8048471wms.82.1645913671403; Sat, 26
 Feb 2022 14:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com> <20220226124249.GU614@gate.crashing.org>
In-Reply-To: <20220226124249.GU614@gate.crashing.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 26 Feb 2022 23:14:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com>
Message-ID: <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jakob <jakobkoschel@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
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
X-Provags-ID: V03:K1:xn4Py0/5Y7Hjx1O//gsXYXBSKmsbC6odn+cPwMNzUI8Y+fIeSSP
 Hj462lJ4Q4D5EFIrLOOh2pwGhu7tuZ7S/1BVZvLoG6DAYkIeZgdVGPQCKK2Gm3Cekf/1PgR
 /C3ouG85TCr9oBOySbCjNHXt9t83BU3qhV2iPur8UX/CuFj7DotbZVQUZX5zbMqTdYRlBow
 CY4yER406apypIAcPVDJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qjD9mkA5UcY=:StnJtyKtnG8xOJDRhVQhLw
 12qJNthjXWjR24fOAGFkBoxgNE+jlqosTdOOJEzTuLj3o0hAZ10iFcm5behvSkaY0uRLhP6zf
 A3p2fPIaRiYux6VAeSpOnGO48dda32K8fMh9hxeGT+hrEkX343cbCZkWB7eBm1mM6fNBmN5C0
 +ywKLCj0MAH1FvT567NaXZZU3fnbgmKytopgnu/eEYPaMsagy1cRcYU1ucNg3vGGC7DuGsL1e
 bIZCLnXZkfsP0MQJ2QhXSJO8pp1QwTaUXM7QwYDEMSv9VQAgL13g1wrqr9Lv6AwYrg20+1Yhl
 VGoySiWGL5k3cPvLQaos1uh/xugE87Tv0Vj66Qs9Sloi/1IWKBsUNq6zZsAzUcKuachba6+NV
 p/KUkQXh+sY/upvg7sRzO+QVJKNtlwOkAArrpG8Yaw0C1Bw6JwSL16GB0/EzcCS7S77yzSCCa
 Pbpb26Fo9sN9jt45eHjVYvDWz9Hlr3jfX6iMmw8jVCU7o/l/U0V+Zvg++iN2+uLL5sr347XVE
 /wzKE5mLj02cyWn5u0Pgo/9j4hq4TpLDhuhyNjNBesnTZx2y1IUdjf9JdsJPVItexVEGtgHn9
 0SrQDgelixKlggD7x2OkqW35B6nNSbbICfz92XAFSQywE0K2t5jGfkc6lstfxGYPW8F4cXtuc
 AIoA0aitl9tL9EfzbI+idu3PXaVS/R08CK5E3F6BPYPttbU98aiD/t4N2yH//vY561Vp0L8Ct
 0AXBufQRlXvaBlhGpWrro40mXDUlz4mqIMOFHURP6edgsOSoOAZvBBRBBgRuLBVk1djSJWB/i
 5iUokMkxa4Ns/fNegjc6f16I5m9JFDaE3x9McEcANFuAqIJf74=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 26, 2022 at 1:42 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Wed, Feb 23, 2022 at 11:23:39AM -0800, Linus Torvalds wrote:

> > That said, we seem to only have two cases of it in the kernel, at
> > least by a x86-64 allmodconfig build. So we could examine the types
> > there, or we could just add '-Wno-shift-negative-value".
>
> Yes.
>
> The only reason the warning exists is because it is undefined behaviour
> (not implementation-defined or anything).  The reason it is that in the
> standard is that it is hard to implement and even describe for machines
> that are not two's complement.  However relevant that is today :-)

Could gcc follow the clang behavior then and skip the warning and
sanitizer for this case when -fno-strict-overflow or -fwrapv are used?

         Arnd
