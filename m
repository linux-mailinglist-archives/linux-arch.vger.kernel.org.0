Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511D521F61D
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 17:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgGNP1e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 11:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNP1e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 11:27:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28858C061755
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:27:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r19so23258060ljn.12
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCyLOhQV57mz1Tz9y5V98kqwmWTue4420M9y+zk47sY=;
        b=JrWgTBRdBX1cUe5aCb73+TsaK4ECM13FS6SYZxjTTs/VcET75Za3d/5OpAFolMLiG2
         rmM293nxQKfX4PiAjnofjoAJ6qAZh+dcMJ5TZE8IAzVTRLCvzUlr0FPZQ4Ha2hKtav0P
         Hy7ruQElpq2zZYq8uOxErUU6Ocv4g8NOdw6hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCyLOhQV57mz1Tz9y5V98kqwmWTue4420M9y+zk47sY=;
        b=Ry2dW8sajbFEdHFwS4IQTI4biEdkfma75eYSBhRIWXH9s0XB8zt7OXtQU0BRLMeT93
         3x+x3M914aXaUpcG3OANaUBUoMArBk7OUvZ2WhhjZPC5t1YNHbAyXtDJLQdcgCYYd6aj
         eY4PzSGiImwZkYXAogmQ2dZWNqMJ3oujNzRzAqneCTmdf71vu6PxN2wDtfv7tsML/j+F
         +MAT4YPVI6pCQglT7XQ7IcZaVOkuAt1VeB84yung9kSI3sHz6j4DBKNsw4aPN4JWL2GU
         yqneY6mgXZhRm9rOAVF7YE8d3meBKtaw+7v5KORhu63s+07EuBdBjWnwkR8BiNx/EhsH
         bQFg==
X-Gm-Message-State: AOAM532/tpLZYTsFblY9MZYWHahOLttxnZ6ZUOKRwH6xZPpTKsmq3hpm
        v4DdQ22WvnY3MnPrLIaznAz1lqqN0fk=
X-Google-Smtp-Source: ABdhPJywCrUQ87QoqSgpdsjdlE8d0rzeYsfsLJWrAyvQGkR1bWT3so/q9ctO3fVaAVdHTkftVmv/yg==
X-Received: by 2002:a2e:9792:: with SMTP id y18mr2788590lji.172.1594740452404;
        Tue, 14 Jul 2020 08:27:32 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id a5sm5368081lfh.15.2020.07.14.08.27.30
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:27:31 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id q7so23329988ljm.1
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:27:30 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr2701790ljj.312.1594740450439;
 Tue, 14 Jul 2020 08:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-5-hch@lst.de>
In-Reply-To: <20200714105505.935079-5-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 08:27:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpYFEPMfYmNR-9SuPaeC432sC7nmZrismRHQEiR2GM4g@mail.gmail.com>
Message-ID: <CAHk-=wgpYFEPMfYmNR-9SuPaeC432sC7nmZrismRHQEiR2GM4g@mail.gmail.com>
Subject: Re: [PATCH 4/6] uaccess: remove segment_eq
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ack, just with a note:

On Tue, Jul 14, 2020 at 4:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -33,7 +33,7 @@ static inline void set_fs(mm_segment_t fs)
>         set_thread_flag(TIF_FSCHECK);
>  }
>
> -#define segment_eq(a, b)       ((a).seg == (b).seg)
> +#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
>  #define user_addr_max() (current->thread.addr_limit.seg)

This "uaccess_kernel()" interface is a better model anyway, because at
least on x86 (and from a quick glance at others), we might avoid the
exact equality comparison, and instead do simpler/better things.

On x86-64, for example, checking whether the limit has the high bit
set is not only more flexible and correct, it's much cheaper too.

Of course, trying to get rid of all this means that it doesn't matter
so much, but it would probably have been good to do this part years
ago regardless.

                  Linus
