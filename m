Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA633D933A
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 18:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhG1Q2L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 12:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhG1Q2K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 12:28:10 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C084DC061757;
        Wed, 28 Jul 2021 09:28:07 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id f11so3630581ioj.3;
        Wed, 28 Jul 2021 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AF4TJrGWFJFMtVLuei7JHJB4Gj1GjFvl4JwVKfpCTQg=;
        b=N4dFDdweMRNGIxbTls1wouDVv77PoGKNvdayOSofsdxbOx+HYtPYODvvE2cufKyswB
         2lABzznnLC/fwRL1Ev/ZT2LJgrwE3FCxHwkBgcGhxeTLrpUhiLzWfNDPWeNtOMHCw2MT
         VUknTvdIAHPjj/xH8t/G9d0MN6m5wJPWid7c92vAT4ji6dX/duT14dYthsuv5AiTcCQm
         vzq0Km+9MmKJCe7GROt/D5Qm++HHzhvlXaPUXkAMKi4ojMOa6pfWxkdE/pLFaIIP9pPY
         S8RlROTfGWLoS/AdI/ch+nmftRxakXYe04STS9mICjkUYsYEqTE3QwtKrPSoFTe1f2yH
         vU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AF4TJrGWFJFMtVLuei7JHJB4Gj1GjFvl4JwVKfpCTQg=;
        b=CRxtWONnzmvLZEPqmbraQQbtDmo13TzvtSovhKvk2u0cKiOscF1OVAg5NhQwXu/I6m
         iy3bw345zAekMIG9aABpA/DyHRxH/5zGIB+bG4Pl+6z8nIjSHp/u03fHnGcL0InHurWp
         xao6p0qcI/KAEDeqJWPsRBjEU0AgKztcGlE3BIj2Usk4voQ+EBchr/FksW3+xYB9cJ+S
         bp44/qPrQfrROCuoyo/XE9VXdqC9h8dACfImcpH6gY72VRlF/G1DLLco4hQZfaZQu7/0
         oSqZx4tu4oTqywzLmOR3Qz36vDu+vc8qsPzcQQNj0VrUM7A0GOkcP+KjmyjI2wKrExqk
         +snQ==
X-Gm-Message-State: AOAM530Uk263JmI24dlAmvQxa1TRE+Il7odMLcIQAVs802ORiNbOCdex
        nvlCBP05BIsTgqjWzD5El3c=
X-Google-Smtp-Source: ABdhPJy59XDX6D0NjCNN5Abp58chFAMk9RYToI8QqF65aTuJCga7stE7tEYRvATnalm4oQ854CaD/A==
X-Received: by 2002:a05:6602:2424:: with SMTP id g4mr217928iob.189.1627489687199;
        Wed, 28 Jul 2021 09:28:07 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id w14sm275939ioa.47.2021.07.28.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:28:06 -0700 (PDT)
Date:   Wed, 28 Jul 2021 09:28:05 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Hildenbrand <david@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 0/8] all: use find_next_*_bit() instead of
 find_first_*_bit() where possible
Message-ID: <YQGFlSSCKPVCdSo7@yury-ThinkPad>
References: <20210612123639.329047-1-yury.norov@gmail.com>
 <YQFxJnB+cH4SU9I3@yury-ThinkPad>
 <7fd3eda0658e7ef4ba0463ecd39f7a17dbd4e5c3.camel@perches.com>
 <YQF97Q1a0NL9VBr9@yury-ThinkPad>
 <911b290063ecab50aef8da606ddbc2e27dffa6d7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <911b290063ecab50aef8da606ddbc2e27dffa6d7.camel@perches.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 28, 2021 at 09:06:18AM -0700, Joe Perches wrote:
> On Wed, 2021-07-28 at 08:55 -0700, Yury Norov wrote:
> > On Wed, Jul 28, 2021 at 08:13:32AM -0700, Joe Perches wrote:
> > > On Wed, 2021-07-28 at 08:00 -0700, Yury Norov wrote:
> > > > Ping again.
> > > > 
> > > > The rebased series together with other bitmap patches can be found
> > > > here:
> > > > 
> > > > https://github.com/norov/linux/tree/bitmap-20210716
> > > []
> > > > >  .../bitops => include/linux}/find.h           | 149 +++++++++++++++++-
> > > 
> > > A file named find.h in a directory named bitops seems relatively sensible,
> > > but a bitops specific file named find.h in include/linux does not.
> >  
> > 
> > I'm OK with any name, it's not supposed to be included directly. What
> > do you think about bitmap_find.h, or can you suggest a better name?
> 
> Dunno.
> 
> But I'm a bit curious about the duplicate function naming (conflicts?)
> with functions in include/linux/bitmap.h

What names duplicate?
