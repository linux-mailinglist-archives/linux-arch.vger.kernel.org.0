Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D925C5BB
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgICPuS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 11:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbgICPuQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 11:50:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895BEC061244
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 08:50:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s205so4324335lja.7
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uN+gKvfGO60O5JMjCBhAHk4zCyy59uX9CdJNtZFrNw=;
        b=hYB6yqqQVYLw5W4wbNtwYxGosDDACrqFPkFRzSxq5GUdwnRcqWSZf+3pDJZG3l4qpj
         XIsM8mhEThCQIKY5Q71Pb3tabJeQfFtxozky3wgH9Fge0iOyyl06stPcVEls4DGKyFgJ
         F0YpC38xMkAjv0zbD8B0d2Ya5VsmSKKtjzeEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uN+gKvfGO60O5JMjCBhAHk4zCyy59uX9CdJNtZFrNw=;
        b=PAZKvzfUlxyEXxYDsDQYx6C+FnwmVEiBAlhuKM96Vbkw2rflRXNbkOBS4ofYkD4w4X
         bvlzNrkHMKMeX1TuaEzikiVD+RQUSW28ywWrF8CnFmc1SmNXWtLJtanl86Q/Ww5uFS8p
         BA3HwQbM6NSMc2mYIEylHV68uXlianTCx/a+xu2qB/EOhSaK6dluSwv55O0mjGwNZAL5
         3e5HCNlEd+YIL3Whoc6tzJvWhRv0FbHp1PPBqwwnaf75aY3A0PL+mbKG9gxzcehCMxLQ
         FF8jrhQZFQPfQf+ncrn2xUorTVueJ7UHMmZukl0RCINl1oC/+yfuVY/DRcMtF3l1TbV5
         rGlQ==
X-Gm-Message-State: AOAM532JAxV652i2pKHWq0Sa79SS0pA+AKWgTTGknlzm2LyhOaTYgNPc
        o6LWj32F47dHy0nBdmelGai+wH0/LRYbNg==
X-Google-Smtp-Source: ABdhPJzXTCp2Ef4k+5IDtfiHj+n1oAeez1YY92iMy17umhc4mb5UILXnjek50YS/zrb52uZNgTqQYw==
X-Received: by 2002:a2e:b808:: with SMTP id u8mr1712065ljo.62.1599148212219;
        Thu, 03 Sep 2020 08:50:12 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id u5sm667265lfq.17.2020.09.03.08.50.07
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:50:07 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id q8so2180850lfb.6
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 08:50:07 -0700 (PDT)
X-Received: by 2002:a05:6512:403:: with SMTP id u3mr1627887lfk.10.1599148206752;
 Thu, 03 Sep 2020 08:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de>
In-Reply-To: <20200903142242.925828-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Sep 2020 08:49:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=jtTcwSox8RY-skN83c40WXZOfwid-91FDgRdk0xwrw@mail.gmail.com>
Message-ID: <CAHk-=wh=jtTcwSox8RY-skN83c40WXZOfwid-91FDgRdk0xwrw@mail.gmail.com>
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 3, 2020 at 7:22 AM Christoph Hellwig <hch@lst.de> wrote:
>
> [Note to Linus: I'd like to get this into linux-next rather earlier
> than later.  Do you think it is ok to add this tree to linux-next?]

This whole series looks really good to me now, with each patch looking
like a clear cleanup on its own.

So ack on the whole series, and yes, please get this into linux-next
and ready for 5.10. Whether through Al or something else.

Thanks,

               Linus
