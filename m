Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5B53B378B
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jun 2021 22:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhFXUHI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Jun 2021 16:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhFXUHH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 16:07:07 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A5CC061574
        for <linux-arch@vger.kernel.org>; Thu, 24 Jun 2021 13:04:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z22so9372278ljh.8
        for <linux-arch@vger.kernel.org>; Thu, 24 Jun 2021 13:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpe9lEwhUIwO0xWlospxCxEaXe3xRtOW0AcnGSWOsWM=;
        b=V94FyFfUNYCwwe5Eb2/5kXStEjd/SAXTGvq9l3G716GpB3crhuLMAj4BaMF1jfEK7l
         hV9Mh/oX2jaBezpijTHMrktNaoBzZ2MLDXYRj+Z1Tsy6ssSFue4MMET/K4ItVOa7I6ly
         u5rW/mU/nBnbe/kLYL8ohoz+2IaV4nvB4PYLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpe9lEwhUIwO0xWlospxCxEaXe3xRtOW0AcnGSWOsWM=;
        b=skfLezWmHX5DhdCWIT63ykxPnd+YaIuGhmPR83hUmS4xokbfWYwE84JUx8PFx7g2zP
         ueQt08LwRIII8VG45n2HTsWPm/Y5kVWwkQG3xsDQu/RLtYx744xi7mhZnU3a8p3RjIIX
         VZkYbv57dM40mjpL5cCJuYf478AW6Vykb2J0hNruskWxena+Hy+2kPvDlDhaf9nDeIpV
         4AsNrNZDK3GxwEl1cUYzAOWynHqEuDrpSijKoFvVKoou+VfarCcFHlbcG36IUb9JaA5q
         JoXGmKvwjlmmVJTmHzw64v+PF6ohXsstjfoCTxBRAbYwE4nJcrCEnDC/f+fMkKzeDniG
         1cqA==
X-Gm-Message-State: AOAM531+jUoBhzF0tunOXkuxrVVsn0vlUI4K89/yhy3mO84AWgPAcWdE
        zOM3zTN4uJDxqj9op4AeTgTbt/eZXCJdyAtp
X-Google-Smtp-Source: ABdhPJwlib/tfBIakml9h4sY6iK6tJdhlGhxYzjqW254XPhdSBhtolgFVGaWue9PNvUsZcjhTwR9eQ==
X-Received: by 2002:a2e:90cf:: with SMTP id o15mr5152017ljg.451.1624565084466;
        Thu, 24 Jun 2021 13:04:44 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c7sm346126lfm.50.2021.06.24.13.04.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 13:04:42 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id u11so9376141ljh.2
        for <linux-arch@vger.kernel.org>; Thu, 24 Jun 2021 13:04:41 -0700 (PDT)
X-Received: by 2002:a2e:850e:: with SMTP id j14mr3525901lji.251.1624565080001;
 Thu, 24 Jun 2021 13:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133> <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk> <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <87a6njf0ia.fsf@disp2133> <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
 <87tulpbp19.fsf@disp2133> <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
 <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133> <87czsb6q9r.fsf_-_@disp2133>
In-Reply-To: <87czsb6q9r.fsf_-_@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Jun 2021 13:04:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2OpVrBD38A5Re4=rSSWnjwg3GcmsxtAPeHVSmQZy1VA@mail.gmail.com>
Message-ID: <CAHk-=wi2OpVrBD38A5Re4=rSSWnjwg3GcmsxtAPeHVSmQZy1VA@mail.gmail.com>
Subject: Re: [PATCH 4/9] signal: Factor start_group_exit out of complete_signal
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I don't really mind the patch, but this patch doesn't actually do what
it says it does.

It factors out start_group_exit_locked() - which all looks good.

But then it also creates that new start_group_exit() function and
makes the declaration for it, and nothing actually uses it. Yet.

I'd do that second part later when you actually introduce the use in
the next patch (5/9).

Hmm?

           Linus
