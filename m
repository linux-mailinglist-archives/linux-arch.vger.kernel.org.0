Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D604F212A
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 06:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiDECVz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 22:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiDECVy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 22:21:54 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC8A41856B;
        Mon,  4 Apr 2022 18:17:08 -0700 (PDT)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2351D5xo003801;
        Tue, 5 Apr 2022 10:13:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2351D5xo003801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649121185;
        bh=1XB8+03FMw6quXMbGDHBGH2OtifIRC6gyEDeKLl9zco=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fykuV1TsMj3k9Ws57DHlBBiTRfCJLa78wHm24isrFs0OYjWLYXMwTpBYPIq4cXIEn
         HbOl44nWGcfnHr7bWwaB7WnXkTOOfHkk6+jdAmUjgu4Ndoevp2LwXY3h4udSNspNqP
         vqdDv5VRBBqCoS/VT7h39RpohTeG1pg896jeODp9E4NQh+Sd78v12Z6++gJ6PnlzYP
         L8It+ZYbHlhIJWQ1iMWnGF8CYqvynrJxAFL6w72QZb8r+++bKVfZ+kTyvQYYPvSiCM
         SzCvzpqI0sJxlfL/s/jJtSPm/hmJCMC5Aqg82tgHAACtvpK/A51PmBOuRL2dfZPuBp
         hO3NWsHy8f70Q==
X-Nifty-SrcIP: [209.85.215.172]
Received: by mail-pg1-f172.google.com with SMTP id 125so1420894pgc.11;
        Mon, 04 Apr 2022 18:13:05 -0700 (PDT)
X-Gm-Message-State: AOAM532dgC25C3ebR1RXPtQl+w0G1FdAUP3WmD0agZ99S01hrjQrrqMB
        ByahInHY5xGkqtG0ZhB/KcTO780LNK6GweZnrUk=
X-Google-Smtp-Source: ABdhPJzLBjj4278xvNykiD3w2yfsWF6xRsbcL3Ms+s4YFFRyIBmJxQbqTeWwwPYUkRsLo2sjYt6EdjjfGmwkd6VfZgE=
X-Received: by 2002:a05:6a00:234f:b0:4fa:f52b:46a1 with SMTP id
 j15-20020a056a00234f00b004faf52b46a1mr1137771pfj.32.1649121184875; Mon, 04
 Apr 2022 18:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-3-masahiroy@kernel.org> <YkqhQhJIQEL2qh8C@infradead.org>
 <YkssI2uDHRq41zjw@google.com>
In-Reply-To: <YkssI2uDHRq41zjw@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 5 Apr 2022 10:12:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQDD4u5acyG7m4mziz-nz3D2u+ukdZZB+jZah_3JZFMTQ@mail.gmail.com>
Message-ID: <CAK7LNAQDD4u5acyG7m4mziz-nz3D2u+ukdZZB+jZah_3JZFMTQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] kbuild: prevent exported headers from including
 <stdlib.h>, <stdbool.h>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 5, 2022 at 2:34 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Mon, Apr 04, 2022 at 12:41:54AM -0700, Christoph Hellwig wrote:
> > On Mon, Apr 04, 2022 at 03:19:42PM +0900, Masahiro Yamada wrote:
> > > If we can make kernel headers self-contained (that is, none of exported
> > > kernel headers includes system headers), we will be able to add the
> > > -nostdinc flag, but that is much far from where we stand now.
>
> This is something I'd like to see done. IMO, the kernel headers should
> be the independent variable of which the libc is the dependendent
> variable.
>
> Android's libc, Bionic, is making use of the UAPI headers. They are
> doing some rewriting of UAPI headers, but I'd like to see what needs to
> be upstreamed from there. I just noticed
> include/uapi/linux/libc-compat.h, which seems like a good place for such
> compat related issues.
>
> In particular, having UAPI_HEADER_TESTS depend on CC_CAN_LINK is
> something I think we can works towards removing. The header tests
> themselves don't link; they force a dependency on a prebuilt libc
> sysroot, and they only need the headers from the sysroot because of this
> existing circular dependency between kernel headers and libc headers.
>
> I'd be happy to be explicitly cc'ed on changes like this series, going
> forward. Masahiro, if there's parts you'd like me to help with besides
> just code review, please let me know how I can help.


I wanted to make uapi headers as self-contained as possible,
but I did not see much progress.

I just fixed up some low-hanging fruits, but there are still
many remaining issues.

Thank you very much for your contribution:
https://lore.kernel.org/all/20220404175448.46200-1-ndesaulniers@google.com/

If you eliminate other issues, that would be appreciated.


> >
> > What is still missing for that?



-- 
Best Regards
Masahiro Yamada
