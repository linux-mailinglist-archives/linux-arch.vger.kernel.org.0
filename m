Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF78921D29A
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 11:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgGMJNJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 05:13:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42757 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGMJNI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 05:13:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id g37so8992259otb.9;
        Mon, 13 Jul 2020 02:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Kvnn1U97jZEFNfOWUSAsH/gkQzeVqu192LUXU0iCy4=;
        b=t3Dsv0rpGcYRgtqb6ZOQlxcLFQUqVYy4my2L7w6LZpqG3/5ZKsTdc0VCIxRF6kg0nj
         mMIOngGZM/aTS6lDsjh4m82jlhR4v367v/z5ItIBol6hxOWwl/jxlBfGeqeq4xzi+yBK
         Y1Dv1FY8ZgBcpRCk91vh8UwZ9B2czwKU9usuy1fhp0OdDf5KKtKwb4mMUt1ZUq4XGyo2
         8MKT9UNpUn8Osz/YItM/w1u+/YYZVOzstp4SSh7KJhN0CALHv5x4WkAaYBtmzLf7TSjk
         MnU006iFt3QaU+1CienqYHYQu5GCmy1/VC7yM5SOc5cgaQu/H/KWg+2DtPvJbIMj6j7s
         tCIQ==
X-Gm-Message-State: AOAM533fLQE40oN/MY2fOLQBxc+s4Crm1J5LMV7NFJHPFEU1DejoQIIb
        RGSSaGjsMmDhnpgP7RvvubJQz/cq28kPNnNdcHI=
X-Google-Smtp-Source: ABdhPJzCNB4z3cnwFxg40yF0vD7KxhFEnVze7JJzdymORNXy473eBLB/B4cnQoGYWPXmt7S7GLNnpSjsEbLKguPGOEk=
X-Received: by 2002:a05:6830:1451:: with SMTP id w17mr56644751otp.250.1594631587724;
 Mon, 13 Jul 2020 02:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200710135706.537715-1-hch@lst.de> <20200710135706.537715-6-hch@lst.de>
In-Reply-To: <20200710135706.537715-6-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jul 2020 11:12:56 +0200
Message-ID: <CAMuHMdVyy+cj+mpRJAW=1=3aOJWvUrLhXjJxKvVFdFcGr_RJRA@mail.gmail.com>
Subject: Re: [PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 10, 2020 at 3:57 PM Christoph Hellwig <hch@lst.de> wrote:
> Add helpers to wraper the get_fs/set_fs magic for undoing any damage

to wrap

> done by set_fs(KERNEL_DS).  There is no real functional benefit, but this
> documents the intent of these calls better, and will allow stubbing the
> functions out easily for kernels builds that do not allow address space
> overrides in the future.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/include/asm/tlbflush.h | 12 ++++++------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
