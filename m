Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5DD3D9261
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 17:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhG1Pzb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 11:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhG1Pzb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 11:55:31 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB1EC061757;
        Wed, 28 Jul 2021 08:55:28 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 190so2622912qkk.12;
        Wed, 28 Jul 2021 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hdboj5BmSVR+1HeROwEzl5Ukj+Hr+t08Y2X+nFridI0=;
        b=aYMicwx69WgyFWxh7agbW+s82ivWqpQPCfgcNw+cAuI/BGrZzD7CtQ3ncLw8993c5i
         40w+kYHlS4qaGbE+FH07f1ZNE8bqtl2ucsP0cjROUwr0K/SsYfa44eXWKjqP8X5UdmcK
         +gIKi3R9/UVsuBiQ/gjD4mtuLtFZdFIZAdy4rDLiydRRwbDTa/pR4z2aE7q9c3p1Y+vE
         Sl+lQqX4Xs0M7nO4t6xRReAN8s+qmaFerqkch1uHPMaXMe9mvP0nNFHQ2ALb45fHgLzZ
         NnpyaZeMleQrgQI7Cki7vEpDlYVgoDckyb/7u15gxJHXpKufm+DDBmgl4BQDwTgjQLTn
         7j+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hdboj5BmSVR+1HeROwEzl5Ukj+Hr+t08Y2X+nFridI0=;
        b=ZAlSSG7kpTXr4bEKc4qFrI3KaITEniBSBoofQhiX2KzgBX9AUsOB9A/K7o813EhvFO
         7+Xh9ns/aeyKGH1bn+D/rPEMTOVDlCDD7IFOya4RSd7NNr1eTYYoaUZGWHDPWODrPOmi
         TF4Mn2ZiAHgZbeMtK6MWhHHjuXNvxWPxAtTg2YsMlpTb5QsGbVJ+fcED8f0I5UqGLF71
         bXVxGvQ5+e9i/Nz/h52zg/NKb5O1SsqpsiM4GZ8CYpcg6II8L/jENCmjG0VRTppdiTn1
         cXq37VjA2cZmOPg9iRxeNRVfgSecZaX+kmK1t97TCioMub8ZCOm9ce0WO6koLMbqfzq8
         Zr0Q==
X-Gm-Message-State: AOAM531SZjqlRrS8VkL9JK83EFJbV69P11gl7ds7uABVNWcPPRuu7hi1
        u4qPkJtORoUCeJfHoTwybbY=
X-Google-Smtp-Source: ABdhPJyd0jl/DUwla2N2a5WMSdgvoClWOrKxHMWdX5oToyct2CKjdkdAPr1Vr3+HnTcKouwvopnBFw==
X-Received: by 2002:a05:620a:1907:: with SMTP id bj7mr295089qkb.315.1627487727636;
        Wed, 28 Jul 2021 08:55:27 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id l12sm108101qtx.45.2021.07.28.08.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 08:55:27 -0700 (PDT)
Date:   Wed, 28 Jul 2021 08:55:25 -0700
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
Message-ID: <YQF97Q1a0NL9VBr9@yury-ThinkPad>
References: <20210612123639.329047-1-yury.norov@gmail.com>
 <YQFxJnB+cH4SU9I3@yury-ThinkPad>
 <7fd3eda0658e7ef4ba0463ecd39f7a17dbd4e5c3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fd3eda0658e7ef4ba0463ecd39f7a17dbd4e5c3.camel@perches.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 28, 2021 at 08:13:32AM -0700, Joe Perches wrote:
> On Wed, 2021-07-28 at 08:00 -0700, Yury Norov wrote:
> > Ping again.
> > 
> > The rebased series together with other bitmap patches can be found
> > here:
> > 
> > https://github.com/norov/linux/tree/bitmap-20210716
> []
> > >  .../bitops => include/linux}/find.h           | 149 +++++++++++++++++-
> 
> A file named find.h in a directory named bitops seems relatively sensible,
> but a bitops specific file named find.h in include/linux does not.
 
I'm OK with any name, it's not supposed to be included directly. What
do you think about bitmap_find.h, or can you suggest a better name?
