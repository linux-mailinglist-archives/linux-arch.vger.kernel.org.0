Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61C8325C58
	for <lists+linux-arch@lfdr.de>; Fri, 26 Feb 2021 05:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBZEHz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 23:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBZEHv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 23:07:51 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E374C061574;
        Thu, 25 Feb 2021 20:07:11 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id a2so5825785qtw.12;
        Thu, 25 Feb 2021 20:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VNgVP5bO+x0vJy5odPkV2uB2UEUJ5Qp9L2ilIKOZuM0=;
        b=R7Tm6zfTEojM846VH5x9z6bj2dYJBkSaEVL27dcTk9dMrKOhGWHlwjCoh+psbk3uQQ
         6KDYjOHUyteQGwmqOphNoxyRmnIDVNLigOwILPaZ+sePyn2Zr8g9NmrbRYggr3Jm/kj5
         PNaanpcSQmFfzUgSJE1RRR9JQabCKTx50/4BiAZBFNP06vBRuYv6whvhEkDC6bns8av6
         M/JZ/cIO4SMsyGRwMJMEs2sIlwqY3cPClskP+ZHMOe7tR+3CiR2avsQ5usD7CMHn6joS
         FhAuvHxwP/CkhiRwMXjTQkhkjKq2kj/pczc/Vrpf3LefI7aZMUebr53pUEdT3R6XFJSJ
         CFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VNgVP5bO+x0vJy5odPkV2uB2UEUJ5Qp9L2ilIKOZuM0=;
        b=KbdYhJBZG8KOaUKUQ5iiNLWqzmmhhqylo799Tadq2bxjxBgrAFCz7tX+0qlSiJLJ9q
         L9DnnkDq77K+bQIRoCzPu/gzK/8utzEE+JMoQREnKmD5feA6DLrSVy5FseME2Je/RRpR
         TtsgI9VF7w19CW7eNIgpyi3rt/bL+JwChyzALLjKtqbtaBlb/7f9FhMoKuZ5VZIsAzmh
         hN1qn7VVA81S77HcLgR68ifGyy40t25NDdljN8OcH444sO4OZP4oDJXoBahL3y5h9XSf
         UeDgsTWiwfguydXSFls82NQHUwIN93RUqdCiOS+FSbR1xq041g9dYAOiUG8JKYr+c7ky
         0jxw==
X-Gm-Message-State: AOAM5320nnlVbgkTlOqZnJfaFP5NegX7YZHAIMwaLC/MbvEYcVXevZMJ
        T0wyb7wuuhZq0ozkRi398W8=
X-Google-Smtp-Source: ABdhPJzrXnJVeX5vcyvuCgBKuy7gwJQV4Gg2l/0ma11hXSewE9YNqnUiTmwzN3aclIIWVb0LZemIJw==
X-Received: by 2002:aed:3fc5:: with SMTP id w5mr1337679qth.76.1614312429586;
        Thu, 25 Feb 2021 20:07:09 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id u133sm5531844qka.116.2021.02.25.20.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 20:07:09 -0800 (PST)
Date:   Thu, 25 Feb 2021 20:07:08 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 2/2] MIPS: enable GENERIC_FIND_FIRST_BIT
Message-ID: <20210226040708.GA1427525@yury-ThinkPad>
References: <20210225135700.1381396-1-yury.norov@gmail.com>
 <20210225135700.1381396-3-yury.norov@gmail.com>
 <CAAhV-H5Xt+1c_gCOpudzizurEbVXYonf_wWg9sTaCKWcONEL-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5Xt+1c_gCOpudzizurEbVXYonf_wWg9sTaCKWcONEL-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 26, 2021 at 09:22:18AM +0800, Huacai Chen wrote:
> Hi, Yury,
> 
> On Thu, Feb 25, 2021 at 9:59 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > From: Alexander Lobakin <alobakin@pm.me>
> >
> > MIPS doesn't have architecture-optimized bitsearching functions,
> > like find_{first,next}_bit() etc.
> Emm, I think MIPS can use clo/clz to optimize bitsearching functions.

find_{first,next}_bit() is about manipulating the bitmaps bigger that
a single word, and some arches (arm) implement their own find_bit()
functions. find_bit() is not a replacement of __ffs() and ffz().

> Huacai
> 
> > It's absolutely harmless to enable GENERIC_FIND_FIRST_BIT as this
> > functionality is not new at all and well-tested. It provides more
> > optimized code and saves some .text memory (32 R2):
> >
> > add/remove: 4/1 grow/shrink: 1/53 up/down: 216/-372 (-156)
> >
> > Users of for_each_set_bit() like hotpath gic_handle_shared_int()
> > will also benefit from this.
> >
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  arch/mips/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index d89efba3d8a4..164bdd715d4b 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -26,6 +26,7 @@ config MIPS
> >         select GENERIC_ATOMIC64 if !64BIT
> >         select GENERIC_CMOS_UPDATE
> >         select GENERIC_CPU_AUTOPROBE
> > +       select GENERIC_FIND_FIRST_BIT
> >         select GENERIC_GETTIMEOFDAY
> >         select GENERIC_IOMAP
> >         select GENERIC_IRQ_PROBE
> > --
> > 2.25.1
> >
