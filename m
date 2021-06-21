Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A6E3AED19
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhFUQI4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 12:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFUQI4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 12:08:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8A4C061756
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 09:06:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a11so18031106lfg.11
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 09:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grhn+4m03Hl/IKclIMEKcZj1BLiA+WR5DwYi+XwSseA=;
        b=Q+nWm9WmmmSMbAxOkMaCB9u9prznIbKgUSttcPTWKdMtZ0odlvJvuPtW7JSazKaLeU
         cUPduhuCaDSDV5BTOvqkmm6hpl1DHLT5xIUhJ6DyinLbPrgEFXS3Mk2MEy94+LkhkW80
         T4Lwo23p+PNIoBoAY6ZkmX/O+y56kyOcECF3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grhn+4m03Hl/IKclIMEKcZj1BLiA+WR5DwYi+XwSseA=;
        b=EjiCBLp22a8OyiFKmwZvmEAm2NY1EOCiJhpuLRtJgJkKKcDeIB68U/CgZGI00H0xOz
         YwLDWtAnUC569CQKTMVYSTUEbm8UBSaU0xZONQu6d3WPGiv85PmXUxYXQUGQUSjVWaZf
         y8UGm7cEdCJf30FYu1ZYRqB15UIFlO6Ab+VYspjXZqy9ub/QcwEgk1I64g1ry8AriKS8
         DZ025Ln8BV8YT3JGa9CQmn0OpXQ6CZ0gJ3AVmUpJ9Jv9sryx6KmfhAazAhTi+TqIdtTf
         OCJhQTWTn/QFpOAgGXURuwDL9kECkn9ZSc47RUJzuQo9vmIvJWGMzdcWTmZVmB2KQiu8
         m1eQ==
X-Gm-Message-State: AOAM5304DqfXLQJZQxtcCcpGST7DcdUdGME+9TLYtyswGnNDxn4EnJx5
        DS2gB9yYPhKkSRYQ70DQC0NcnTCUZzS0y0lnZA0=
X-Google-Smtp-Source: ABdhPJwuFDaalfW/Gc5lnAc+LQUSZmYmu9p5UcfuItPnCDU7bLP1dhVfp2Wyf/s9NgIoPzoEvI9f8Q==
X-Received: by 2002:a05:6512:3592:: with SMTP id m18mr2863885lfr.389.1624291599344;
        Mon, 21 Jun 2021 09:06:39 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id z30sm1916367lfu.42.2021.06.21.09.06.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 09:06:38 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id x24so31056844lfr.10
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 09:06:38 -0700 (PDT)
X-Received: by 2002:a05:6512:baa:: with SMTP id b42mr14369828lfv.487.1624291598641;
 Mon, 21 Jun 2021 09:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <1624176865-15570-1-git-send-email-schmitzmic@gmail.com>
 <1624176865-15570-3-git-send-email-schmitzmic@gmail.com> <1547f9bc-441-6cfb-ad7c-57f7584dd63@linux-m68k.org>
In-Reply-To: <1547f9bc-441-6cfb-ad7c-57f7584dd63@linux-m68k.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Jun 2021 09:06:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2COuoJM822vRSxu8Wny6Qpe-XvpSyJhPJKMeXdYXe5w@mail.gmail.com>
Message-ID: <CAHk-=wh2COuoJM822vRSxu8Wny6Qpe-XvpSyJhPJKMeXdYXe5w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] m68k: correctly handle IO worker stack frame set-up
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 20, 2021 at 8:57 PM Finn Thain <fthain@linux-m68k.org> wrote:
>
> When the patch author is not the message sender, the message (commit log
> entry) would normally begin with "From: Author <author@example.com>".

Yes,. But in this case (as, honestly, with most of the trial patches I
send out) I'm perfectly happy to not get authorship attribution.
That's particularly true for something that I can't even test, and is
to code that I don't really know all that well.

I'm a big believer in trying to make sure people get proper credit and
attribution, but I'm also the one exception to the rule.

I get too much credit already, I don't need it for the patches that I
send out that are "I think something like this should work" and then
others do the heavy lifting of actually testing them and making sure
everything is good.

                 Linus
