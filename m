Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AABCFA25
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2019 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfD3NZm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Apr 2019 09:25:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44028 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbfD3NZk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Apr 2019 09:25:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id g4so15999380qtq.10;
        Tue, 30 Apr 2019 06:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bsjY1DmhUhB9DtBTlNGVuJNSnH75cc+kYQnpfUCErno=;
        b=nEXaelipnSNjl18ud7hweMuSiRlTDhwtjK6591mx7kIbpu4NzmYATgUohq3AKIk61r
         elwjqBZjah3x9W2qXA7bYCLvzkzl4QyADiwjXf5sgaC1kmHPnuB7RVP+LrmbAtHfJs/Q
         Bc3GXtKNlXRZVah56xbD2wvMItrFd98ygoFkQpYMSwNTWOMQL+928pqk940RHfLEfgu7
         GRUIBHr6ncmMfn+uZqy+GtbtoY9bWbZUdYkC1uSYP4LtKxRl9IaFRgX55ukGp4bAySXH
         FtQovYU49Sl/D9kBYihaN35EFQMu5bkLXm1OPGYg6gr99UBxxxxMT4qUyLNT3JgcZvw7
         2jyg==
X-Gm-Message-State: APjAAAUNbtiWYIpP2MxL2z/K4yQ3MISJ3l4nrSa6DTilpJxN+YhvqbLM
        H5jzKVQsuCgy1Gljbs1f1SzLWwO62/mEAONq6ETtZe1H
X-Google-Smtp-Source: APXvYqybjaI1IwCBTFJUaMgt5CyjzbFifgqt09o7eG704nNEEpC7JPV9jSbZdWGCoQgFFeSJV62/CpkGkHL9lFIfoJw=
X-Received: by 2002:ac8:2692:: with SMTP id 18mr54601227qto.343.1556630738805;
 Tue, 30 Apr 2019 06:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
 <20190402161256.11044-3-daniel.lezcano@linaro.org> <1555922585.26198.19.camel@intel.com>
 <fb45157c-38c4-7940-3252-af459d446323@linaro.org> <1555999165.26198.39.camel@intel.com>
 <2c0bc40d-328a-fc96-73da-9d65fee253fb@linaro.org>
In-Reply-To: <2c0bc40d-328a-fc96-73da-9d65fee253fb@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Apr 2019 15:25:21 +0200
Message-ID: <CAK8P3a2LAZnBKigo9v0qzaa-WAYkuoueF_jyJtaFrMeLXnDDow@mail.gmail.com>
Subject: Re: [PATCH 3/7] thermal/drivers/core: Add init section table for self-encapsulation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 29, 2019 at 1:23 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 23/04/2019 07:59, Zhang Rui wrote:
> > Hi, Daniel,
> >
> > thanks for clarifying.
> > It is true that we need to make thermal framework ready as early as
> > possible. And a static table works for me as long as vmlinux.lds.h is
> > the proper place.
> >
> > Arnd,
> > are you okay with this patch? if yes, I suppose I can take it through
> > my tree, right?
>
> Arnd?

Sorry for missing this earlier. I have no objections to this, or to merging
it through the thermal tree.

Acked-by: Arnd Bergmann <arnd@arndb.de>
