Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95DC78CD7A
	for <lists+linux-arch@lfdr.de>; Tue, 29 Aug 2023 22:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbjH2UUd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Aug 2023 16:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240509AbjH2UUM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Aug 2023 16:20:12 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C031BE;
        Tue, 29 Aug 2023 13:20:08 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a36b52b4a4so114701b6e.1;
        Tue, 29 Aug 2023 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693340408; x=1693945208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dPLASuyRHqr5emQFn0tjFMLNpyleK0mRYR0JeYXXEd4=;
        b=dJ4fsVO7B9Wqzz3co24/hU4d9UBxPoXJlGFSRP/WsPjWbukX0nWzowMyOiwNv86pVv
         5Bco6QQ2reUSVNMO4jkJBRkMqYvWsWh1lrCsr1ZlaDis9UmDk+rc6E57yZm6qpGE3WbN
         3hFWVA9Vm9C4FdimDEDDfLPWnT/Z37yTKFzLOBjpey++2WTfXYf4qsf3Rj/a8ciBEUxf
         nH9vVS+a6h9mTsFiMsYCYwTF8dhlWlbrwxHQ91HDmEusa09UL6guYpYJEiY9J+qSRFXb
         RK8bGhI1tuKIdoMuIk7mFUh9HShj1CbyHHeukvThzD4IYbr1VgXkzR4GUnpsgqSbgd8t
         VJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693340408; x=1693945208;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPLASuyRHqr5emQFn0tjFMLNpyleK0mRYR0JeYXXEd4=;
        b=Bv4T0qFT53Xij1SUeOlP9Yy0Z3nQzx9ZA/VyUDIYPLI+Jy0S2SOyk4LXk+xKrhV56w
         5k17zjIZsr43rFNFYbRUQQQ8wVcSqpiCWxmvwFJmslF/mWcgt7PVM8DRjk0R/0sNXftE
         5ZxhAtNQopEzQ8OcxnrJJ5qytdPrDZoSI69UkMtFyTu3YVone6ukkgVkkLWf7/w3xSIC
         th66O3Drww6tU+MJ0JpP7PFb0JIHezmCc2J37QBvvsHyf9IU8odDldAzcsex+mZnkK/s
         3dDGVsbG33ghM87mchRc8b3gOuFO6yQ/ChQ3FBf6mjhnMiZ7d3dH2KvMwldOgYdxWC/L
         trlQ==
X-Gm-Message-State: AOJu0YxsZOEZEqBVHMfzhkEoyPsku1tSvnB0POkcaG7iIIffbMlzqLGl
        OSHca6FF0fQqotfyD0mvIgtn9I1DsdS77suX7E1S4LgD
X-Google-Smtp-Source: AGHT+IFPVfeuAryUVSPtgazrKBqFMai7x1CNri4TuB/RyWuOSyukq4INi0uf70AF+Q6nvF/wsRLepbQtHqNdtq6Ngw8=
X-Received: by 2002:a05:6808:23c6:b0:3a8:6a40:7dc0 with SMTP id
 bq6-20020a05680823c600b003a86a407dc0mr2599820oib.18.1693340407961; Tue, 29
 Aug 2023 13:20:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1141:0:b0:4f0:1250:dd51 with HTTP; Tue, 29 Aug 2023
 13:20:07 -0700 (PDT)
In-Reply-To: <CAHk-=wgemNj9GBepSEJXS5N99rr9wLkL668UC9TsKH45NnJ7Mg@mail.gmail.com>
References: <20230828170732.2526618-1-mjguzik@gmail.com> <CAHk-=wj=YwAsPUHN7Drem=Gj9xT6vvxgZx77ZecZVxOYYXpC0w@mail.gmail.com>
 <CAGudoHHnCKwObL7Y_4hiX7FmREiX6cGfte5EuyGitbXwe_RhkQ@mail.gmail.com> <CAHk-=wgemNj9GBepSEJXS5N99rr9wLkL668UC9TsKH45NnJ7Mg@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 29 Aug 2023 22:20:07 +0200
Message-ID: <CAGudoHFNPb8CHGNK+msCE70bPZkKyCom7g_7Laja+AVoAN5CXQ@mail.gmail.com>
Subject: Re: [PATCH] x86: bring back rep movsq for user access on CPUs without ERMS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/29/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, 29 Aug 2023 at 12:45, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> So I think I know how to fix it, but I'm going to sleep on it.
>
> I think you can just skip the %r8 games, and do that
>
>         leal (%rax,%rcx,8),%rcx
>
> in the exception fixup code, since %rax will have the low bits of the
> byte count, and %rcx will have the remaining qword count.
>
> We should also have some test-case for partial reads somewhere, but I
> have to admit that when I did the cleanup patches I just wrote some
> silly test myself (ie just doing a 'mmap()' and then reading/writing
> into the end of that mmap at different offsets.
>
> I didn't save that hacky thing, I'm afraid.
>

Ye I was planning on writing some tests to illustrate this works as
intended and v1 does not. Part of why I'm going to take more time,
there is no rush patching this.

> I also tried to figure out if there is any CPU we should care about
> that doesn't like 'rep movsq', but I think you are right that there
> really isn't. The "good enough" rep things were introduced in the PPro
> if I recall correctly, and while you could disable them in the BIOS,
> by the time Intel did 64-bit in Northwood (?) it was pretty much
> standard.
>

gcc already inlines rep movsq for copies which fit, so....

On that note I'm going to submit a patch to whack non-rep clear_page as well.

> So yeah, no reason to have the unrolled loop at all, and I think your
> patch is fine conceptually, just needs fixing and testing for the
> partial success case.
>
> Oh, and you should also remove the clobbers of r8-r11 in the
> copy_user_generic() inline asm in <asm/uaccess_64.h> when you've fixed
> the exception handling. The only reason for those clobbers were for
> that unrolled register use.
>
> So only %rax ends up being a clobber for the rep_movs_alternative
> case, as far as I can tell.
>

Ok, I'll patch it up.

That label reorg was cosmetics, did not matter. But that bad fixup
thing was quite avoidable by checking what original movsq was doing,
which I should have done before sending v1. Sorry for the lame patch
on that front. ;) (fwiw I did multiple kernel builds and whatnot with
it, nothing blew up)

Thanks for the review.

-- 
Mateusz Guzik <mjguzik gmail.com>
