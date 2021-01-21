Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A7D2FE38C
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 08:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbhAUHMF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 02:12:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbhAUHLn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 02:11:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A602C23877;
        Thu, 21 Jan 2021 07:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611213062;
        bh=X8yOPN+hKmInC/DRSvodSFKBWlat9kFmX3xsgoJYdZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZqcEJytwGxeNaHcnvuLUiVfmLw7fhsyYn0CZzeYSEo72ucAxqD3uCMlcLjF/eruTZ
         X+KA2Q2gvs1JukSAUPxZ6musFFJ0U+JMOewc2vX0JboxpJ5LDVeUxx6vYkbBniOxJ7
         3p2vTQSU6uBtX7O8IrLyoC8xBbcBFityIyZ7oQBG4Qrc9p3zNL7DIoPfwWTQv5Ou5o
         Nan+Hb1k261xsaANI8jq22CN6R6SiPVfh50x1DobHHJXCcnFoHFRzy3iZ93QoVjbhM
         1Ugf+0pIl8lKm8A0zI2Djb1Y9HOmKy64oLz+mb46cO03JZiO8CZqOESiCtt0X038A/
         SADfJTHxrVlnQ==
Received: by mail-lf1-f45.google.com with SMTP id q8so1080723lfm.10;
        Wed, 20 Jan 2021 23:11:01 -0800 (PST)
X-Gm-Message-State: AOAM531HpiAUzSKyL41H2UL6X73uMb6sLwarylDvAB6z6T26KsJuqKru
        b/RG9CP4Q6Ono7u94a5HZkY1mxLJ4KPT6wM7nic=
X-Google-Smtp-Source: ABdhPJzrttCf3+Cf6MMkmGYKoV85CCdb2RCt8TvCgNmGnsV7Nlh6bzvtcwOMXaI/OwHAiLYaSy2Mj1Q8injhDzcn47c=
X-Received: by 2002:ac2:4ade:: with SMTP id m30mr2534205lfp.231.1611213059919;
 Wed, 20 Jan 2021 23:10:59 -0800 (PST)
MIME-Version: 1.0
References: <1608478763-60148-1-git-send-email-guoren@kernel.org> <X/buKPr5OCH3C32J@hirez.programming.kicks-ass.net>
In-Reply-To: <X/buKPr5OCH3C32J@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 21 Jan 2021 15:10:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSLLC8yLzLNkuRwLXBihs3uy9TXVVKRpEF9mM4nN4FopQ@mail.gmail.com>
Message-ID: <CAJF2gTSLLC8yLzLNkuRwLXBihs3uy9TXVVKRpEF9mM4nN4FopQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] csky: Remove custom asm/atomic.h implementation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

On Thu, Jan 7, 2021 at 7:19 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Dec 20, 2020 at 03:39:19PM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Use generic atomic implementation based on cmpxchg. So remove csky
> > asm/atomic.h.
>
> Clarification would be good. Typically cmpxchg() loops perform
> sub-optimal on LL/SC architectures, due to the double loop construction.

Yes, you are right. But I still want to use comm cmpxchg instead of my
implementation. Maybe in the future, we'll optimize it back.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
