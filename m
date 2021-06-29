Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD403B6C3C
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jun 2021 03:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhF2Bux (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 21:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhF2Buu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 21:50:50 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C29C061760;
        Mon, 28 Jun 2021 18:48:22 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id h18so2333186qve.1;
        Mon, 28 Jun 2021 18:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zwISlu4t3dplgWD20RF908rV5PcoQEWx07KHDpdjYT8=;
        b=oAfx9elvsqm/3Q6uACk/S/oJi2vyR7eJQOLDBtuFTBImyroQPtRQhxAeIjgiHCrkTb
         sx8GyMHGnUjAazJJ2OPAF7P6p7H86t4lpJ3WJW2WXehAngMztSeDmbi7rkriKqvSDFWq
         0bW65X8zsIqJbvr3BDFLAQjyrcnAup5qI5SaHiqPy8B2pcNJ5zK5SyzTCWJndftCWSWf
         h87AQ+F2edC0MeUUxcsYTwqh4jieGoAknDI5acQOmsT1HS5I4/+LwzldPUGdDJROucgD
         q4iSGAkMcFKiAaJ75+Vf6R3wsvRXF7ut8bejPlqgLdwLXiE4fbHMeFJTDwhYT8l9te83
         NA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zwISlu4t3dplgWD20RF908rV5PcoQEWx07KHDpdjYT8=;
        b=EnNya0I/g4koJe39wmxOknwXFujYzG7sBjb/kBqOFlkj6d5EJAN6KKLVW2fODHHs/5
         sGmH3tlipmTThdsmENEAjNN2d/GUCOeaDeO1lRNxc9AevvImU5irRdS2DQkC6QVANEVE
         d7dLAU/aIKiMZKgSEYhK4cAZ55zk2KnbT+wdwHEUmACy5bSmACU9ocqr2M1PLgEGGf1g
         LV//1AOMpeWB7HU7cVpUvS66JpsaRhuEQck41cFexWBW293iuOzZuKF2EhAXTixWNMT1
         TkD1ougugkJX4D3xpH21JNiOYDF3lhOOHBN8ro0d73aB71FoAFmbTwvSkOIafR7n//jL
         VTFA==
X-Gm-Message-State: AOAM533/P56/31qlOBtAIllFRaJRuLXks1kP2E1oaJnBSvKvJjxmfkT9
        wdsW/ubixY9969tqBGVAw2CZOMxyDsc=
X-Google-Smtp-Source: ABdhPJyCNkPgTNy9l7vkOxhw0EStOdNQTIlQr9+wz2mDIdXu4xaL6F951FXY9LPEPEZs802msOuX1w==
X-Received: by 2002:a05:6214:13ac:: with SMTP id h12mr8220005qvz.48.1624931301428;
        Mon, 28 Jun 2021 18:48:21 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id t187sm11089487qkc.56.2021.06.28.18.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:48:21 -0700 (PDT)
Date:   Mon, 28 Jun 2021 18:48:20 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
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
Message-ID: <YNp75K4n9KQD5Cw3@yury-ThinkPad>
References: <20210612123639.329047-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612123639.329047-1-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 12, 2021 at 05:36:31AM -0700, Yury Norov wrote:
> find_first_*_bit() is simpler and faster than 'next' version [1], and they
> work identically if start == 0. But in many cases kernel code uses the
> 'next' version where 'first' can be used. This series addresses this issue.
> 
> Patches 1-3 move find.h under include/linux as it simplifies development.
> Patches 4-8 switch the kernel and tools to find_first_*_bit() implementation
> where appropriate. 

Guys, do we have any blocker for this series? If not, I'd like to have it
merged in this window.

And this too: https://lore.kernel.org/lkml/YNirnaYw1GSxg1jK@yury-ThinkPad/T/
