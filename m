Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5686888A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2019 14:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfGOMG3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jul 2019 08:06:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41690 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfGOMG3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jul 2019 08:06:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id v22so11333503qkj.8;
        Mon, 15 Jul 2019 05:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cl8fDId4/8QdGjR+ayI3FcLePor06MbJHULp8GCJKtk=;
        b=DeVNT+G+l2StUlKmVzi7UErSRUQYnDZcJ07Rf/j5h3QcvhayKMDntTHE0coV2LkXQf
         VJ4Z5n0tvSyzr4AyKwlNl7gjpKJJeFuFaiuXg838H0GMKS2ZGVK90P9+NM32FWqlDVnD
         nNos57HDPumJGVoF6Vpvg/RFDVX23wGXYJDkqfoiXS7Dsp2pUJlko8WhJaTKIe6p2a71
         /b67FCxGrA2j1m1ImrVKp2WiTBbGGuU2LdsReI3Dn4x0Gi/cXARh0HIJy5S8rMM0B0Jo
         HgwO2929GaJBu6NZJoCwi2SMlXX8bswspSmHk8l0mWFOP+zDAxASYri/SqFO6OeB0wX0
         DyaQ==
X-Gm-Message-State: APjAAAXkEmRZbJXJmCcrGT/jcz0636uh7fkg5JrhzUN+4adepczs29r7
        VhERosjdxHP1ZNdbF4xgnJ4WtKxjshxJ2nYDGDA=
X-Google-Smtp-Source: APXvYqzOzy1BQovNrI4wf0QckC9Y14s/TsOOmOEX3kolRkeedjgmgv2klwhlPpnIy2ydnxHhQsXkexEhcoFLdIZO7Ik=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr15732795qka.138.1563192388030;
 Mon, 15 Jul 2019 05:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <7b963f9a-21b1-4c6d-3ece-556d018508b4@virtuozzo.com> <3d9eef14-4059-0f8a-e76f-a8a09d730913@virtuozzo.com>
In-Reply-To: <3d9eef14-4059-0f8a-e76f-a8a09d730913@virtuozzo.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Jul 2019 14:06:10 +0200
Message-ID: <CAK8P3a1sT6y+oWKm4ou1=Y+1n5=1_S6UhJN9kkZ6iMxw18O5yw@mail.gmail.com>
Subject: Re: [PATCH] generic arch_futex_atomic_op_inuser() cleanup
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 15, 2019 at 12:29 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Looks like this code is dead and therefore looks strange.
> I've found it during manual code review and decided to send patch
> to pay your attention to this problem.
> Probably it's better to remove this code at all?
>
> On 7/15/19 1:27 PM, Vasily Averin wrote:
> > Access to 'op' variable does not require pagefault_disable(),
> > 'ret' variable should be initialized before using,
> > 'oldval' variable can be replaced by constant.
> >
> > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

I'm not following the reasoning for any of the changes here. Why do you
think we don't need the pagefault_disable() around get_user()/put_user(),
and which part of the funtion is dead code?

       Arnd
