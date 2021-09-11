Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938A04074B3
	for <lists+linux-arch@lfdr.de>; Sat, 11 Sep 2021 04:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhIKCjz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Sep 2021 22:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbhIKCjz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Sep 2021 22:39:55 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB7CC061574;
        Fri, 10 Sep 2021 19:38:43 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id x137so3332217vsx.1;
        Fri, 10 Sep 2021 19:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aW+ZVGbPVSNBQ73btRhAUuj6asXoMiMDa/u/F2G13vI=;
        b=ftQ0uKjMn5tPFV5bwG8Z7q6OzfWOzJhUVAd5/qWpyNovHPDvXTahUNVairz/H+YKnd
         xdLw7VlDgOnrB3OLS31WNj2XJcH4A4OmRKd6f/YykMyyvui8bwM7RvN403XywqLnvbeq
         99bAxikzAyeF93A8u2rcz5IgpP4zWg1YGK4oZUo8KgUIaU8uiyWJhhiQSOelSQM84/yH
         7/dOiqGjpFuLhafxKRoFu2B8m1uEyLgEPe2VcT6r5sXPb8dxpbaLtiHDIeU+DW9vazN9
         JhuH/xlVhwHFjQ8oIFXvFEKf54hw1FZnEXT8XlASJ9g8TPWMhNh4zxwVH5RKDJde0It3
         9Jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aW+ZVGbPVSNBQ73btRhAUuj6asXoMiMDa/u/F2G13vI=;
        b=gAcgV3UGkzmvnjnkgZtUlSH8xdO1Lm0bFRVPdXIUQSpcT+PeUZJtLVPTRnhTMmEccj
         oDEkWpaxs8di1QTfz8jGxYULJQwSsB7jK1wFpLySgaevDiznE6U/vy8jbc9yMxHw40IA
         gBA7F+mrTG6n/rvzZBpPG3tR4IqUAaQJF/IbeDIB5WFegBBi0zhfZySkCjqmFoEPwaKN
         cOeBx725MKvSi4rqxaS7idOAoBxUh9GmiyOYYAfZo+DsYyJs0dIYOXbFchu0MhKrCd4G
         Q7Hv5q55RCo/wUSTB9CXZp2CO2t15e0a8fdTX8Td6D1DlsS0KWTP2jL8NnnLEUoiyIHF
         Huvg==
X-Gm-Message-State: AOAM530ZfmDmaP15d7zLrcFcJzvUZkV32zpuaXscN7T5wSDZNr5722gu
        oDYrAbM+Bix5543cRrfaBRDw5Lx8FcyJNMOah9w=
X-Google-Smtp-Source: ABdhPJyQOhZeVbMc1c7mVO/ypSmFl93WdNeuctGrk2DAfbRh2kLiX/GlrOl0lTJ/fwFPk+3BVvcLg9le0eny7DIjTtQ=
X-Received: by 2002:a05:6102:214c:: with SMTP id h12mr196015vsg.3.1631327922727;
 Fri, 10 Sep 2021 19:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
 <20210903095213.797973-19-chenhuacai@loongson.cn> <YTjbaz7iea1kwGYb@robh.at.kernel.org>
 <YTs0WGYEFZp8uIO7@infradead.org>
In-Reply-To: <YTs0WGYEFZp8uIO7@infradead.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 11 Sep 2021 10:38:31 +0800
Message-ID: <CAAhV-H7LVFeirw5D7FBW8mfG=o=WydvUcZ_eemxe0c820KCwgA@mail.gmail.com>
Subject: Re: [PATCH V2 18/22] LoongArch: Add PCI controller support
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Christoph,

On Fri, Sep 10, 2021 at 6:35 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Why is this whole series not on linux-kernel?
When I was a newbie sending patches to the linux community for the
first time, maintainers told me that if a series is more than 15
patches, then sending to linux-kernel means killing the mail list. So
... I only send it to linux-arch. :)

Huacai
