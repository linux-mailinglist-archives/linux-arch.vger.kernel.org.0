Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8BB4230E9
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 21:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhJETsk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 15:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbhJETsj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 15:48:39 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC76CC061753
        for <linux-arch@vger.kernel.org>; Tue,  5 Oct 2021 12:46:48 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id p2so437770vst.10
        for <linux-arch@vger.kernel.org>; Tue, 05 Oct 2021 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbwUhuMxm8wviya953E+2y/7YeYTSfn0ydblYxORl38=;
        b=IYnkAcTszoNHR7peNGSuJcVo9fQ2RxLSX6x2JohB973rf+/tV/0AciX0CZ/cVUZa0X
         v2byVPDSTkYqRSV18GemThj7pzrmMsA9CNYU2JngTZa4S2BdD18NIhaDVxX4MHi4RXJn
         iKmIK3+zx01+A1KuABHNoFOwukPnO4sEK3RjjuDg6YYMaJkIciYakCKl6SU9rDl9iedE
         kO76hC2Do2ETWeIFeoafnhM/wVhcKAJF49+W1kkpLPRKmpzvvW7Oo8W4YRnVQj15TD7O
         nIVltM+U5OhABIng3iK9Qab5NykMGrd/n7k/M0+WPP9FESp3WQt37qi7kAvvJsgg/1rp
         Xwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbwUhuMxm8wviya953E+2y/7YeYTSfn0ydblYxORl38=;
        b=EASYS3RQvK2YgJ9YMkEiKtpyUxdwrpb/eNEqt0LDyyjzrF2Ksd+ccjwdi+T2zTeN+G
         YegXkw8mucxs/hT/BBvgimvW049PK77PBGcbL6Dq4SjoSmUhdV+tRIAdsAfai1FlzFa/
         YuGkEynyjOenJ3mAuMxBeyxbFTVlS1s6+pv8foOAwJTv6eFFdzwNBL1WEP6j/JyNj3by
         nAUzx/24lh9gppS4dwAm51OZ2L12ldRDQ8SsTTB9CRegr7zThBiFR48vwM3QOAUAG21U
         87+kvZM9dbM9OiJL+6Sjm3pOnD1hWDIndr+wKaxO5VnMg6ye3JtDKXGE+Z3F6yrAZeJm
         i7WA==
X-Gm-Message-State: AOAM530S+nzKz3iz4e0N2PzCcMYKw/RI0ixC9wwKMr17EVRoMCTDHvJ3
        eztojatoCf/rIJwRm+T3KmoOlbjzxlJ3RqGgGm71Jg==
X-Google-Smtp-Source: ABdhPJw1jRFug/BatrjktZwMcZuNKkTNFW8nGYixW20s2h09JWywJiPXGstRD3BEvJViKhu4dWaYW7Km4rlo1NIsaR0=
X-Received: by 2002:a67:df16:: with SMTP id s22mr20626648vsk.47.1633463207755;
 Tue, 05 Oct 2021 12:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210928194509.4133465-1-ramjiyani@google.com> <x49ilybjmdt.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49ilybjmdt.fsf@segfault.boston.devel.redhat.com>
From:   Ramji Jiyani <ramjiyani@google.com>
Date:   Tue, 5 Oct 2021 12:46:36 -0700
Message-ID: <CAKUd0B_vh5gxsjHVAoC4YTpwUA8vj6qKovza8OM391koM2t+hQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] aio: Add support for the POLLFREE
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, kernel-team@android.com,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Jeff:

On Tue, Oct 5, 2021 at 12:33 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Hi, Ramji,
>
> Thanks for the explanation of the use after free.  I went ahead and
> ran the patch through the libaio test suite and it passed.
>

Thanks for taking time to test and providing feedback.

> > -#define POLLFREE     (__force __poll_t)0x4000        /* currently only for epoll */
> > +#define POLLFREE     ((__force __poll_t)0x4000)
>
> You added parenthesis, here, and I'm not sure if that's a necessary part
> of this patch.

I added parenthesis to silence the checkpatch script. Should I just ignore it?
I'll send v2 with the change, if it is required.

>
> Other than that:
>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>
Thanks,
Ramji
