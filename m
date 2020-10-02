Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF7C2817E2
	for <lists+linux-arch@lfdr.de>; Fri,  2 Oct 2020 18:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgJBQ1c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Oct 2020 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733260AbgJBQ1a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Oct 2020 12:27:30 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C55C0613D0
        for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2020 09:27:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s205so1671270lja.7
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2020 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XESAsar1PPbow9QXM6iPAt7dZfh4lXWZnIFR2ENhSp8=;
        b=dQd4p/GwRMxd2rF8gBrN78ey6p2K8zuzTy3s9sWMNAin9xHfUCuyFLi919lpEWk9Dc
         zCAWOHW6ysQaFQHfncwjPw8GtCF9mIdVDdsTyJBxdGYxPtsWb34P9+jGkQhhAkEUnrzR
         +hu0t3g2U6uMrarSu3VT/dg6iysw2VK0TvQ0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XESAsar1PPbow9QXM6iPAt7dZfh4lXWZnIFR2ENhSp8=;
        b=PimMz3ywCY/vedhrA1NzqnJsW6GaPoz1dbOIMvd4RQPrgWZayxb8jm/OSCgy1hxaCQ
         AD//18A9jNL2XLHBNdKrsgW1/x8k1Nw3nt8698QBpM5h1uJhoBtwq5ES3Z2XR8XI00Ni
         cYEsQQY0/OEqAZA5ogOIAjmX+pJRVqzK9onMAz2ODoFFzfhrBoErE37Ye6ldZZ0u4F2W
         ErX1qIGRpNrpFyPCrqG0wSaoF1B3k2g3Op2UOSgGZd/Cmt5KQSSWXP3fsi6NKY+ZNgac
         YdZoImQrgO6WZQIDowc1a63bE95tAmLGDOYXtQZDhHzggmPhwoxPmlcTQpvWe/AUAUxc
         T/bw==
X-Gm-Message-State: AOAM530jfmDvhSF2GQpQpTxLId1/a5oI3+I7U7lFCcv1V1i4wY8cHy0z
        1DTiGyXNNcBMGnmKy7pChMiuuTqCAzQ1Cg==
X-Google-Smtp-Source: ABdhPJwAkyi2CIpN/6L9XRM5x5qBER9kceXgCYaIny6+Dmp87rADhpqK71op/k6txA/ooC3WXkZE8Q==
X-Received: by 2002:a2e:90c3:: with SMTP id o3mr904182ljg.147.1601656048128;
        Fri, 02 Oct 2020 09:27:28 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id n3sm375074lfq.274.2020.10.02.09.27.26
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 09:27:26 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y2so2568620lfy.10
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2020 09:27:26 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr1257887lfg.344.1601656045931;
 Fri, 02 Oct 2020 09:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de> <20200903142242.925828-6-hch@lst.de>
 <20201001223852.GA855@sol.localdomain> <20201001224051.GI3421308@ZenIV.linux.org.uk>
In-Reply-To: <20201001224051.GI3421308@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Oct 2020 09:27:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
Message-ID: <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
Subject: Re: [PATCH 05/14] fs: don't allow kernel reads and writes without
 iter ops
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 1, 2020 at 3:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Better
>         loff_t dummy = 0;
> ...
>                 wr = __kernel_write(file, data, bytes, &dummy);

No, just fix __kernel_write() to work correctly.

The fact is, NULL _is_ the right pointer for ppos these days.

That commit by Christoph is buggy: it replaces new_sync_write() with a
buggy open-coded version.

Notice how new_sync_write does

        kiocb.ki_pos = (ppos ? *ppos : 0);
,,,
        if (ret > 0 && ppos)
                *ppos = kiocb.ki_pos;

but the open-coded version doesn't.

So just fix that in linux-next. The *last* thing we want is to have
different semantics for the "same" kernel functions.

               Linus
