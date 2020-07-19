Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E33E2253AF
	for <lists+linux-arch@lfdr.de>; Sun, 19 Jul 2020 21:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgGST2e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Jul 2020 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgGST2d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jul 2020 15:28:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9E6C0619D4
        for <linux-arch@vger.kernel.org>; Sun, 19 Jul 2020 12:28:33 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u12so8609753lff.2
        for <linux-arch@vger.kernel.org>; Sun, 19 Jul 2020 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOzG0VwI/nHjqcTTd/0RSnaqr0ty8WGWju2cNR/S0kY=;
        b=EXMQsuOcBH+qn3lSJ6Zx5JRTyYr/4OdJYaSMa4Bry4+gKY7gSdpbzK3GfXZScLAxXq
         pXBClpedVFxqvZNlQm7uABVvo9duzFbRns/ysfziBPCqArrRWPV4Ovr73eJqvwGS5A9t
         TMG9FhnMf83M1eb05gEyFrEkjtO/hs/Oz//jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOzG0VwI/nHjqcTTd/0RSnaqr0ty8WGWju2cNR/S0kY=;
        b=oAzGZTDXQdDctJxzv/uXSthW98HYBiSv/LQoyGvZ/sJV0HSX2MN6SRLEdArXofz3K2
         34Gf7h9EaptvlEE9NMAnyAgOZ7lNtYKVLcZY89OZDwnclNMgVeUTjwBNEmv12H2JwphQ
         8xUYM1JWgnGQ0HcrhRlXOeIf8D8AcVND7Dh8hbAqxEnTV9Nlvzv87G/ex7eiha88kOGZ
         VOTbFg0PCPchdcn9VmiUdzbm2bodk8Hs1/mnV6WjD3r/GiCCYx2SSVcQY1KnJO8BmhCU
         gLn7SybM8QpfR5JmkAxErWMvKRMeVVMV+n3ixpXagPXlk04gqwFkalLTGfB7bMa3HAe7
         MdOA==
X-Gm-Message-State: AOAM533H0Q7BCq258GPlXe83SFcRKckOKpXlwTf0jNV2ZgC8pgJ8+owv
        DsD9OOrpcD4i4byBmik2tjAJ/LccbPw=
X-Google-Smtp-Source: ABdhPJzs4p4lm77cUER72JWHZloMPgps1T49awsboTtxNz4OcYqiyMBAyOWvB2dah+RDALgOrZ28hg==
X-Received: by 2002:a19:4c57:: with SMTP id z84mr8485391lfa.92.1595186911246;
        Sun, 19 Jul 2020 12:28:31 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id i24sm3305532lfg.83.2020.07.19.12.28.29
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 12:28:30 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id r19so17886721ljn.12
        for <linux-arch@vger.kernel.org>; Sun, 19 Jul 2020 12:28:29 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr9071955ljj.312.1595186909554;
 Sun, 19 Jul 2020 12:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200719031733.GI2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200719031733.GI2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Jul 2020 12:28:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
Message-ID: <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
Subject: Re: [RFC] raw_copy_from_user() semantics
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 18, 2020 at 8:17 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         So any byte-squeezing loop of that sort would break on a bunch
> of architectures.

I think we should try to get rid of the exact semantics.

If "copy_from/to_user()" takes a fault because it does a
larger-than-byte access (and with unrolling, it could be a _lot_
larger than one byte: x86 dcurrently has that "generic" case that
isn't used very much, but it unrolls 8-byte accesses 8 times, so it
does a 64-byte block that we could just say "if any fo those didn't
work, then you're done), then the copy failed. The exact number of
bytes we _could_ have copied is not important.

So we could simplify the x86 end condition too and remove all the
"handle_tail" complexity.

                  Linus

(*) Yes, it aligns things to 64-byte boundaries too, but only for the
write side, not the read side.
