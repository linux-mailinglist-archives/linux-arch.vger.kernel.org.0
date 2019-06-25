Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD7E54F51
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 14:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfFYMuT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 08:50:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35353 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbfFYMuT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2019 08:50:19 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so2823590qto.2;
        Tue, 25 Jun 2019 05:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dt4FAsKSMoVKj0i+IMYCtujJr8k7Hly0E+J9au4yRjM=;
        b=hvAHNFEl9TrZ0GflvnyPfz5PVP4Xm6zHwoBw1Db0aOq7iMNnj9B/ghuYP0/E57ZwpD
         i816BgQHg/UAfYzzu1idnJu4WcoWfr/tr3YhGkYgkam+0sQ+Y2ObNWQzIzFU78fGjMlX
         qM0l7uGUeAreppAgavPhSdAIuztJL1d8JtYk22Uj/YFHzLujXZRy3G9OSr2zP5hjwXYr
         DzzaQd/NMdz8aBJ54IeaN+2TZW3Hn1gym7EuW/bAG/gOwxJvURuQYxwt+/+/TZ2KA3ci
         NzTh4XRNsXpffEKvTiiPANIbR1xyhTcF2oXYk9sZN8KcT9yqq/Wr1W7KnfMUck5OLZsV
         TxCA==
X-Gm-Message-State: APjAAAU8tCUCZxxn6fsaO4LM55FLSBIPhQ2FjvkBlGT3nTO/LMQFT9qf
        d+4fBJKmLQkdS8uW8ZFlnAbIcPMAL6ISxFrCu74pBvrV
X-Google-Smtp-Source: APXvYqx4dJx2NgJZ6E9ESrrfFIuQiqpqiluOKZbPW2AmD3mqQsk/raxStvMwmqNVKtWebchKGbvkNoy6MZg+zOhuIBg=
X-Received: by 2002:aed:2bc1:: with SMTP id e59mr114099487qtd.7.1561467018169;
 Tue, 25 Jun 2019 05:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190625085616.GA32399@lst.de> <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de>
 <20190625112146.GA9580@angband.pl> <401b12c0-d175-2720-d26c-b96ce3b28c71@physik.fu-berlin.de>
In-Reply-To: <401b12c0-d175-2720-d26c-b96ce3b28c71@physik.fu-berlin.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Jun 2019 14:50:01 +0200
Message-ID: <CAK8P3a3irwwwCQ_kPh5BTg-jGGbJOj=3fhVrTDBUZgH1V7bpFQ@mail.gmail.com>
Subject: Re: [RFC] remove arch/sh?
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 25, 2019 at 2:02 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Adam,
>
> On 6/25/19 1:21 PM, Adam Borowski wrote:
> >> We're still using sh4 in Debian
> >
> > I wouldn't call it "used": it has popcon of 1, and despite watching many
> > Debian channels, I don't recall hearing a word about sh4 in quite a while.
>
> So, according to your logic, Debian should drop the mips64el (popcon 1)
> and riscv64 ports (popcon 2) [1]?
>
> > Hardware development is dead: we were promised modern silicon by j-core
> > after original patents expired, but after J2 nothing happened, there was
> > silence from their side, and now https://j-core.org is down.
>
> It's not dead. You can still run it on an FPGA, the code is freely available.
> Plus, the architecture seems to be still in use in the industry [2].

It would be nice if one of the maintainers or the remaining users could go
through the code though and figure out which bits are definitely dead
(e.g. sh5), don't build, or are incomplete and not worked on for a long
time, compared to the bits that are known to work and that someone
is still using or at least playing with.
I guess a lot of the SoCs that have no board support other than
the Hitachi/Renesas reference platform can go away too, as any products
based on those boards have long stopped updating their kernels.

       Arnd
