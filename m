Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23B3A517C
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jun 2021 02:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhFMAeg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Jun 2021 20:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFMAed (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jun 2021 20:34:33 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8116C061574;
        Sat, 12 Jun 2021 17:32:31 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id w4so11169323qvr.11;
        Sat, 12 Jun 2021 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FNzPKnSXhXWUUtCqhfyDGdE5DfwKp+pUbI/lt2bIt54=;
        b=X7BVkoFhomXc6Mr06l1zFOCcjKm24UnyDK5ut72hZIk362Qp/5S0LB6lpqL+26jwad
         EFrFv6ZkFQT5s5kFXyH9bf4zYqqN40npBqk6sE94E78HmvMKff+5yE0dOE4QqRtOW9ng
         6Z6etzslhE82ujx/f2Q/K68YF1s7XhjhSsF0+eqfzi9d2UD2ICH1MFAaW/J/Dc40n3kV
         rjPj+A34eK9hKcCuE2MV+YBJCAitL6JFRy8amaN6D7V8VlcSPqsXPt76fUTM9P3JP/WR
         cMKqm1m/+TzPSBHQ0vtgsQkosdhEzQVXp9k558BWb9AKRIuFxXMd6/hP+DM3QhlLCRbs
         aMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FNzPKnSXhXWUUtCqhfyDGdE5DfwKp+pUbI/lt2bIt54=;
        b=Df/odb75Ffx6CQgqi1FerD/xcjVnk0fSnTbo5roqNK3TB7iaTueJGQKIjnDVUevr8r
         iVNFY29AF6mqFgbMC7Hjh4OsM6a0GeA//DPQJyPTYQPQYH1t964PHll41BZR2wN/axAw
         bKwdNamji5K8jE6J88d4Dw+LyR7ALOYw15xFCVACA/Mkalk1+xS6mRcuWxiCAyOoJqOm
         oYNvzTwyHce8pzTY+aNnKKEwL6BOMEs1HmVYNKmMdDCUuFWo4dV4iI4wVnB3xNL3w8c6
         gvAGgxBqg9HA4BrIZhBU8W2R/4yTP5C+zOfwOOdrgSEJNrAkzMd/bP1uHHPY+kCftJ/M
         eWTg==
X-Gm-Message-State: AOAM531PveSiXQ5ma0gv6UGKV7wJQlXAUDFeoGOJxIuMB72lugve0Kmk
        mH1zhKieFcquSg3BNXb6YcY=
X-Google-Smtp-Source: ABdhPJzem78VQKF5fPsK00zoYwH1QbcT2d8vLvKIOk+qMLiPR4DzgIdzj4zIy4RMpWfZs7QkFTtEvw==
X-Received: by 2002:ad4:424b:: with SMTP id l11mr11991733qvq.58.1623544349820;
        Sat, 12 Jun 2021 17:32:29 -0700 (PDT)
Received: from localhost ([12.21.13.160])
        by smtp.gmail.com with ESMTPSA id 7sm7076168qtx.33.2021.06.12.17.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 17:32:29 -0700 (PDT)
Date:   Sat, 12 Jun 2021 17:32:28 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
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
Subject: Re: [PATCH 7/8] all: replace find_next{,_zero}_bit with
 find_first{,_zero}_bit where appropriate
Message-ID: <YMVSHCY9yEocmfVD@yury-ThinkPad>
References: <20210612123639.329047-1-yury.norov@gmail.com>
 <20210612123639.329047-8-yury.norov@gmail.com>
 <CAHp75VerU1NJMweWCR7MsE9hiMFZyJP8m751OFKmGrJ1gVhMWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VerU1NJMweWCR7MsE9hiMFZyJP8m751OFKmGrJ1gVhMWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 13, 2021 at 12:47:31AM +0300, Andy Shevchenko wrote:
> On Sat, Jun 12, 2021 at 3:39 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > find_first{,_zero}_bit is a more effective analogue of 'next' version if
> > start == 0. This patch replaces 'next' with 'first' where things look
> > trivial.
> 
> Depending on the maintainers (but I think there will be at least few
> in this case) they would like to have this be split on a per-driver
> basis.
> I counted 17 patches. I would split.
> 
> Since many of them are independent you may send without Cc'ing all
> non-relevant people in each case.

submitting-patches.rst says:

        On the other hand, if you make a single change to numerous files,
        group those changes into a single patch.  Thus a single logical change
        is contained within a single patch.

Also refer 96d4f267e40f9 ("Remove 'type' argument from access_ok() functioin.")

Yury
