Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427013EC247
	for <lists+linux-arch@lfdr.de>; Sat, 14 Aug 2021 13:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbhHNLLM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Aug 2021 07:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237914AbhHNLLJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 14 Aug 2021 07:11:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EF1460F51
        for <linux-arch@vger.kernel.org>; Sat, 14 Aug 2021 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628939441;
        bh=rkDgDdpkO/JqHbsQYeGaGIj7eikwk1E8KW7UX+6l+LU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vk2mr5WAlTh5wGQSLPiR6ndTGhjHj5oKVN9wFf4kuGC6d7VznDj5pG8mjT7vWbnzz
         F73G8FKjWo4oJIHgtlurbTKTk/GW457o7MJ1+bsliYAscbUL3acTxrss2slQVsuiCp
         W4kulMG9Vl2/kxY/s6Imh/oP6X0QYuUmUyr4N1HGFXZ3wiXFfIsMGvD/jpWcOn/bli
         xoO0kQofarzUclD4ZvlqscxU4x0rJoLuOm6dlqucJdA5MXAU0AClAcKycUVD4DtGsD
         i0gmBMj691G8PseBlpPo9FzPkGUo36YHpyvHoddCqStTuIHz9V/VX2ANbhdqGyaMjc
         EWCp3t0hQPQ8Q==
Received: by mail-wm1-f47.google.com with SMTP id o1-20020a05600c5101b02902e676fe1f04so8913204wms.1
        for <linux-arch@vger.kernel.org>; Sat, 14 Aug 2021 04:10:41 -0700 (PDT)
X-Gm-Message-State: AOAM531ap6vJylKEi57+wOQqKV1jkMcBgz5YFFpJoIOj/BjP8iYYau85
        x0jjw28ulGGxYjrRVUZKO1CD14g/CTYVYZn2Pnc=
X-Google-Smtp-Source: ABdhPJzE2ZAKru/1GXre1wcF7jinFcMzkvFVrP1YpB0HL6ulmMyxzbsLPV3y25MQQXt/XDETZ5LNz+vUkdFDBb14wz8=
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr6588803wmq.43.1628939440084;
 Sat, 14 Aug 2021 04:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210722124814.778059-1-arnd@kernel.org> <110b8a69-db5e-e5bc-4391-856a2ed45495@kernel.org>
In-Reply-To: <110b8a69-db5e-e5bc-4391-856a2ed45495@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 14 Aug 2021 13:10:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1nqueufafRxvmk+jtpM3g3HWjQL-jWSMWiRm5WG0dLEQ@mail.gmail.com>
Message-ID: <CAK8P3a1nqueufafRxvmk+jtpM3g3HWjQL-jWSMWiRm5WG0dLEQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] asm-generic: strncpy_from_user/strnlen_user cleanup
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Cain <bcain@codeaurora.org>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 14, 2021 at 3:04 AM Vineet Gupta <vgupta@kernel.org> wrote:
> On 7/22/21 5:48 AM, Arnd Bergmann wrote:
> > If I hear no objections from architecture maintainers or new
> > build regressions, I'll queue these up in the asm-generic tree
> > for 5.15.
> >
> >         Arnd
> >
> > Link: https://lore.kernel.org/linux-arch/20210515101803.924427-1-arnd@kernel.org/
>
> Are you planning to add this to asm-generic tree for 5.15 anytime soon.

Actually I just did that yesterday, but it was too late for linux-next
that day. ;-)

> Also while there, any chance you could pick up [1] too which was Acked
> by Will.

Done now as well, thanks for the pointer.

       Arnd
