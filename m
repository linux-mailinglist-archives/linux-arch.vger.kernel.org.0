Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E11376D82
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 01:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhEGX4M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 May 2021 19:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhEGX4M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 May 2021 19:56:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639E4C061574
        for <linux-arch@vger.kernel.org>; Fri,  7 May 2021 16:55:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x20so15048847lfu.6
        for <linux-arch@vger.kernel.org>; Fri, 07 May 2021 16:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDWJpUYmPPrkWqh/DpQreXEAXgVxI78KHgUhVmuROJY=;
        b=bAm5Ql5fOqSQmXEpAgHiRH580ICA55MB2VHmk9uSnuKh6sX3gBT0sxUiLe9tugQXHV
         xPuYrutsGdw9bMxPVweU6xAja+iWUIg18TiZQ9aNH2cXIRNK5mUdJFglXjh+B+seedSf
         Av/0nlLTEWl9quCHTc+aDXWuD10MgloAMF+aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDWJpUYmPPrkWqh/DpQreXEAXgVxI78KHgUhVmuROJY=;
        b=cNJ56dZKcLUb21lpDNpQIQPYovnkIk3OCuKjw2ZJY6rmEfxAcGDX2Q2PWTi94yxqQw
         p7KyK25oUh+zz7Uhh48Mvc9vEALGGY5DGwyx9wIOAeQYBkQnHJOmZQD7eweP97eBDPZp
         nFIAMNhjcpwf3qgpILfX5Qea3tV68+NMcOPCOfUqFLZInI0WaZz4J1eX4IGPoAmA+2uG
         IN+rl8d9gT0vg0UAJXK3qwBtpCFv80k315OLK0CDvXfyfvQ8RQM+B3/NMAqPlS1yWiwp
         /RObDxdzexVHQrA2hs4NhAWNQVsPjiL/8GI6k4uUhxl78cR+4uTsuHJU6RGAktTWccW4
         9ADw==
X-Gm-Message-State: AOAM530kIK8h+XhJ78fps0roCtH8U9ewVUWKBKmG4Y9GlxAZflVO9emI
        0Ye/3VheyfD+4nmsdZKnmHTXBi7hEvExaaEdtmc=
X-Google-Smtp-Source: ABdhPJyzJupHiSpWT+0pDlvQXPR+e6EZjHWRvmrPzQpTXMC9I5FqCQPiaXuTV927t5fRcgPPric1PQ==
X-Received: by 2002:ac2:5f58:: with SMTP id 24mr8336043lfz.200.1620431709738;
        Fri, 07 May 2021 16:55:09 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id l28sm1469243lfk.95.2021.05.07.16.55.09
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 16:55:09 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id x19so15044746lfa.2
        for <linux-arch@vger.kernel.org>; Fri, 07 May 2021 16:55:09 -0700 (PDT)
X-Received: by 2002:ac2:5e6e:: with SMTP id a14mr7887858lfr.201.1620431708918;
 Fri, 07 May 2021 16:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210507220813.365382-1-arnd@kernel.org> <20210507220813.365382-13-arnd@kernel.org>
In-Reply-To: <20210507220813.365382-13-arnd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 May 2021 16:54:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiqLPZbiWFZ3rDNCY0fm=dFR3SSDONvrVNVbkOQmQS1vw@mail.gmail.com>
Message-ID: <CAHk-=wiqLPZbiWFZ3rDNCY0fm=dFR3SSDONvrVNVbkOQmQS1vw@mail.gmail.com>
Subject: Re: [RFC 12/12] asm-generic: simplify asm/unaligned.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 7, 2021 at 3:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The get_unaligned()/put_unaligned() implementations are much more complex
> than necessary, now that all architectures use the same code.

Thanks for doing this, it looks good to me.

I suspect it's still slightly unnecessarily complicated - why is that
get_unaligned() not just

  #define get_unaligned(ptr) \
        __get_unaligned_t(typeof(*__ptr), __ptr)

Because I'm not seeing the reason for doing that "__auto_type __ptr"
thing - the argument to a "typeof()" isn't actually evaluated.

Maybe I'm just nit-picking, this certainly is a huge improvement regardless.

             Linus
