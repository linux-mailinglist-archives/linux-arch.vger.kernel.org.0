Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FF2445B75
	for <lists+linux-arch@lfdr.de>; Thu,  4 Nov 2021 22:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhKDVFY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Nov 2021 17:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhKDVFY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Nov 2021 17:05:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A344BC061714
        for <linux-arch@vger.kernel.org>; Thu,  4 Nov 2021 14:02:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id o18so14489774lfu.13
        for <linux-arch@vger.kernel.org>; Thu, 04 Nov 2021 14:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bq4tNMI44duy5gStAC9/koIu9ir5RqQr9dPHfcHLD5M=;
        b=hMZPfTtv+EhsjGdIcH16mAZzdVz4fL1d35blRrUFmsmFaTErgyobsVEm78IGiZPb7L
         zHjWgLn5ROhjkcg7s4vW4NbsFBLcJ5YaWw8UdiUQqZU+/7FFiaOJTd/xqJGryO6knOvd
         711vd8csqK17V/vYfs/xwvkJGuoDHYzgzfIe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bq4tNMI44duy5gStAC9/koIu9ir5RqQr9dPHfcHLD5M=;
        b=pg6Ju5Hdt8vpYiSvcb53SbTVZguAIf5LbQgRLFMHYXJN7lNfZD3tTJ52Im+MvrIOrA
         S8BxwsJT0sLk3vkWj/+5W6a7hkDZLrHYPb9BRqCNMmNVKqyTtpZMZEh31XJ7bJ6WRVlP
         HpWizokjO3PNugh8OyEf3kEFGaTvKSFYVH7h8ITwknUzbuwwrApoIVcmz1tkJIvhlvXr
         ZtHmehYpMWprfav8o5jsCqCkkL/8BTZNy1LoGfpug6heFHPu/YqQpCsetK+5k3Yc8HZY
         /D37QPYbWtMokZeZkGmjKzLeOI1Q/FyVZuq4XpOHj1mt/BkbhZL3zvTOxXZVrAhWeEIZ
         xSyg==
X-Gm-Message-State: AOAM532FYF63xI8GusFvMM4WNAGi7IiAb9raKkbbO9IGwQuUr8tRO0gU
        CpXpKqMYIppemiD21KrhKle6e+vkVzHjKrN6
X-Google-Smtp-Source: ABdhPJzG9EnkztOs77ZLRnH3A5gF21VyhwVdyd1ziWHe7ytGi0MECdDK8xJclg1iUgOaC+Ud7jDPcA==
X-Received: by 2002:a05:6512:139d:: with SMTP id p29mr50276201lfa.492.1636059763671;
        Thu, 04 Nov 2021 14:02:43 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id j17sm581987lfe.64.2021.11.04.14.02.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 14:02:42 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id d12so11029076lfv.6
        for <linux-arch@vger.kernel.org>; Thu, 04 Nov 2021 14:02:41 -0700 (PDT)
X-Received: by 2002:a05:6512:3993:: with SMTP id j19mr46421657lfu.402.1636059760874;
 Thu, 04 Nov 2021 14:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <YYP1lAq46NWzhOf0@casper.infradead.org> <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
 <YYQowGK3oIAA5Yei@casper.infradead.org>
In-Reply-To: <YYQowGK3oIAA5Yei@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Nov 2021 14:02:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgY7VOwC9dFGGLZ4_-udzTFkxv6kWbBQg9bSJ5vtHcncA@mail.gmail.com>
Message-ID: <CAHk-=wgY7VOwC9dFGGLZ4_-udzTFkxv6kWbBQg9bSJ5vtHcncA@mail.gmail.com>
Subject: Re: flush_dcache_page vs kunmap_local
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 4, 2021 at 11:39 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Nov 04, 2021 at 08:30:55AM -0700, Linus Torvalds wrote:
> > Why did this come up? Do you actually have some hardware or situation
> > that cares?
>
> Oh, we're doing review of the XFS/iomap folio patches, which led to
> looking at zero_user_segments(), and I realised that memzero_page()
> was now functionally identical to zero_user().  And you'd been quite
> specific about not having flush_dcache_page() in there, so ... I wondered
> if you'd had a change of mind.

Ugh. I guess it ends up being there whether I like it or not. All that
"zero_user_segments() stuff is too ugly for words, though, so I think
whoever wrote it must have been on some interesting pharmaceuticals.

What the hell are the two start/end things? And most users actually
just want a single page and should never have used that thing. Nasty.

I'm not touching that with a ten-foot pole.

              Linus
