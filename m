Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B156278FFEE
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 17:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjIAP3c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Sep 2023 11:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjIAP3c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2023 11:29:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D2FE72
        for <linux-arch@vger.kernel.org>; Fri,  1 Sep 2023 08:29:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99357737980so262039766b.2
        for <linux-arch@vger.kernel.org>; Fri, 01 Sep 2023 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693582166; x=1694186966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5l3JwwWVrV2EjXXwh71SJgTd61hiM3tGe0OpAkkaoxA=;
        b=VZzPy92sd++HK77grxqQfGou39SUqnWhzRn1+pstSeILYcEBGJaPWhX4OWKKTcYPvT
         I5UaGqs5CeXe/GU//zTIQKNnGfUgOYCCAFWQpW9PT8gWr30om1fTTEkbrIpYV/5z70CM
         e7mANVog+OcouPMxYpU1nZWcFNHMm/NsiYLX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693582166; x=1694186966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5l3JwwWVrV2EjXXwh71SJgTd61hiM3tGe0OpAkkaoxA=;
        b=VHvHbggWimPNo5PZCs3+EVbiReB1Z+ePKx0MUcATOUpaQashHVlE7GXlUUL83I01KD
         lB28PUG7Fjz2/3XGkODtL/4I8UE4S5wKxHekM32nIfbCVv+9uspzw9kNEnnecGcuXYYs
         fsbQZ0voj9Cdywon8wNHM6JqNMJXdgTtNxTeMNZkFT4hZypzJlG0JK3B4d3OfId+V//z
         NMQKR/cf0TNtY/IKLLCPFMS6TyRd+dGdgkj9doUeabwZSfb8Fz/rYvwl+E/8T/cVuTr7
         wMEgDDn1SloVL5ZD6kGE1zPH2sc/3qE4PJM51EyuetmsGb5m1onJNq6xSu+vFyzODTSN
         psTA==
X-Gm-Message-State: AOJu0YyeDrYMJ7ZC3bMUPuONcwXFVBF5ixOmroYlPW+EmBLK1BGRb/mi
        cdQTywK7nq8ippg6MNoBXH6gTdFzAAtvV/R6FFj3t6O3
X-Google-Smtp-Source: AGHT+IHayIipWmcq6pnj6eUq2jTbMW6Rid21yRh2GW/926SB0538mAaiqsOkZOSS+ypcW+cZyS00Pw==
X-Received: by 2002:a17:906:8a57:b0:9a5:d2f5:ab50 with SMTP id gx23-20020a1709068a5700b009a5d2f5ab50mr2120448ejc.67.1693582166578;
        Fri, 01 Sep 2023 08:29:26 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id kt8-20020a170906aac800b0099df2ddfc37sm2071584ejb.165.2023.09.01.08.29.26
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:29:26 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99c136ee106so263682766b.1
        for <linux-arch@vger.kernel.org>; Fri, 01 Sep 2023 08:29:26 -0700 (PDT)
X-Received: by 2002:a17:906:519d:b0:9a2:96d2:b1e8 with SMTP id
 y29-20020a170906519d00b009a296d2b1e8mr2255791ejk.54.1693582165864; Fri, 01
 Sep 2023 08:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
In-Reply-To: <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Sep 2023 08:29:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7MDktwhh9FPFRTEQOLEgFxNcNhm+znsMevSyY1+aLyw@mail.gmail.com>
Message-ID: <CAHk-=wg7MDktwhh9FPFRTEQOLEgFxNcNhm+znsMevSyY1+aLyw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 1 Sept 2023 at 08:20, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> cp_new_stat and the counterpart for statx can dodge this rep mov by
> filling user memory directly.

Yeah, they could be made to use the "unsafe_put_user()" machinery
these days, and we could go back to the good old days of avoiding the
extra temp buffer.

> I'm going to patch this, but first I want to address the bigger
> problem of glibc implementing fstat as newfstatat, demolishing perf of
> that op. In their defense currently they have no choice as this is the
> only exporter of the "new" struct stat. I'll be sending a long email
> to fsdevel soon(tm) with a proposed fix.

I wouldn't mind re-instating the "copy directly to user space rather
than go through a temporary buffer", for the stat family of functions,
so please do..

> So I was wondering if rep movsq is any worse than ERMS'ed rep movsb
> when there is no tail to handle and the buffer is aligned to a page,
> or more to the point if clear_page gets any benefit for going with
> movsb.

Hard to tell. 'movsq' is *historically* better, and likely on all
current microarchitectures.

But 'movsb' is actually in many ways easier for the CPU to optimize,
because there's no question of the sub-chunking if anything is not
aligned just rught.

             Linus
