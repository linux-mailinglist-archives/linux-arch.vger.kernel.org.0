Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DCE287C5E
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 21:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgJHTTQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 15:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgJHTTQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 15:19:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A729C0613D2
        for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2020 12:19:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d24so3994603ljg.10
        for <linux-arch@vger.kernel.org>; Thu, 08 Oct 2020 12:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLobhkDgMpUWz2pJORCgop3syUH7fcgMKrUPVgxHAdI=;
        b=hmXnbzPKpSgjWs9M2fRi5hEgC+fwO6C1/Jc+P0qlXOlpvBCDiKPiG4xNu6ezw/60jl
         Zvc3kYbG0dADcUDP5O/JojvRVuE0myuouvllwYlaUmWD59PlL2ikvH+enAS39VkIJOAe
         1D5N4EDZB2eC7BKNS28AktA5ezAYxTztmf6tI/L5idZ2KkZ33spPxPo3aiMpVIn3PzD5
         RSQnX83DqjPXT2ZTpC3pRHB62W5U+S5WOQ80T50d4jA96kQIh7ZdKeRkQ++vq3batz1p
         s5Q52bMA41mrY8TliVD1fnQIPZFGC/VVWRFeUxzzEn/ALNM0Udxve3XINkKY/6TH1GrV
         f9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLobhkDgMpUWz2pJORCgop3syUH7fcgMKrUPVgxHAdI=;
        b=iSVEGdjBhEnN9wohyF7gYlNee0FdO6N7lIlLLN7apHzlmnGYU3PZPdfJUQAe2mCj3s
         xcxc6UUxCxjOf3knn/HDHwEoRchbfnMI9C6vMjpmJteV5SlYDK5pkxEakmPs6n/XwhPz
         684u1DmJ0RvSwG3XxGmKEqOmi9tkE1UAme71SFdN1JZMBFPbqUuYbWsA+6hIVkZAim70
         +JRz0mHoRPox4ladVau5rFHPT/yo9ykLDQkacrO897MSyV6b2yUO01ixjgXShK8zlE+o
         vs2VNfqa1BlTHNM83OdrnkIajFGDoMPKRFZWM7kXe8gBgZQtw7/hlXMkdX5N06wTB7jO
         dJ3Q==
X-Gm-Message-State: AOAM532x/inxGBaeMWkji8asbhCFPlUXKNInEgTOwO4z/MCOiUN19Ggu
        /1bsWWGV0sP/OdhkOObdr7M6bc3K7YFbOgYHueU=
X-Google-Smtp-Source: ABdhPJxoWhxrcz6ZKWp7UW4JH0rzAtd9i8iDjW6KV+3kOWjgaoq93s+wMxuFJWSoH629L8ybJLVp+1mC/xgSQyBVm9s=
X-Received: by 2002:a2e:6816:: with SMTP id c22mr4164363lja.200.1602184754450;
 Thu, 08 Oct 2020 12:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com> <7a39c85a38658227d3daf6443babb7733d1a1ff4.1601960644.git.thehajime@gmail.com>
 <27868819-fbd7-9eec-0520-d2fb9b6bf4a6@cambridgegreys.com> <6d8dd929722e419894824a07792ac8c5b2659de9.camel@sipsolutions.net>
 <3f0aab8f38971360240e1e04bd6b90a8dcadec86.camel@sipsolutions.net>
 <2f3c3a54-7d68-6dc9-a65a-37fb4599b194@cambridgegreys.com> <m2zh4w517g.wl-thehajime@gmail.com>
In-Reply-To: <m2zh4w517g.wl-thehajime@gmail.com>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Thu, 8 Oct 2020 22:19:03 +0300
Message-ID: <CAMoF9u3cGYDj8dmZfu559n2HcOPGc_twXk=z32mavO9hPufkFg@mail.gmail.com>
Subject: Re: [RFC v7 18/21] um: host: add utilities functions
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        Akira Moroo <retrage01@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 8, 2020 at 3:52 PM Hajime Tazaki <thehajime@gmail.com> wrote:
>
>
> On Thu, 08 Oct 2020 00:10:23 +0900,
> Anton Ivanov wrote:
> >
> >
> > On 07/10/2020 16:03, Johannes Berg wrote:
> > > On Wed, 2020-10-07 at 17:02 +0200, Johannes Berg wrote:
> > >> On Wed, 2020-10-07 at 15:53 +0100, Anton Ivanov wrote:
> > >>> These are actually different on different architectures. These look
> > >>> like the x86 values.
>
> Those variables are based on tools/um/include/lkl/asm-generic/errno.h,
> which is generated from include/uapi/asm-generic/errno.h, which LKL
> kernel eats for its values.
>
> This is the part of patch 12/21.
>
> > >>> IMHO a kernel strerror() would be the right way of dealing with this
> > >>> in the long term (i understand that we cannot call the platform one,
> > >>> because it may be different from the internal Linux errors). It will
> > >>> be useful in a lot of other places.
> > >>>
> > >>> If we leave it as is, we need to make this arch specific at some
> > >>> point.
>
> So, this particular code does not contain arch specific part I
> believe.
> # Tavi, correct me if I'm wrong.
>

I think Anton was saying that we should do it properly with C99 to
avoid potential issues with changes in configuration and I agree that
is the way to go.
