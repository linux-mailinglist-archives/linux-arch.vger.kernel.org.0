Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226DED8264
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2019 23:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfJOVrZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Oct 2019 17:47:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41969 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbfJOVrY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Oct 2019 17:47:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id r2so15645633lfn.8
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2019 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iKBAZQ4xjT2H3VBhqEDygDjsoO3OrXWHV1qvzKsg6h8=;
        b=eRTA7Y2CR106ubYgppU9AiKB36JGkMp2b525X7AN3j/XcF7eLbUaKXlFv/rViWY6ix
         ZyQP1ASnR5/wN6NVGyHLurSLBElwdONMtqPjyJIbyjjzlfJcbS2XG9xoqv9aty4Tx4RT
         C2KiiZ6vvkn0YO995uPMfi4p9S9yGM/cCoFHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iKBAZQ4xjT2H3VBhqEDygDjsoO3OrXWHV1qvzKsg6h8=;
        b=KV9mqkuVc8kbEij6yh2okCTBcm6Pcs7uqIXciQ83KTnXnsW2aTwm15Yu+6VzrBvwE4
         0C2YXAYWBzuwfpBTPyd3c6X5xX/NikIRL07rz1l0UgQvml1EGDajJc0+rhSPDucSLTjd
         9ib6qlSNDWu9j1qNtXZpeiVY26BY6x+ZV94ctnXTM9QhKS2W11bm09uLzquZTBuLyZG8
         blETwh2pHax4zciR1t3GSySbas2gYQQPlXTny5XvQvdMOKetqQID/7G4pE3ZeEMxApN1
         ttp7Bn/dCV6ZMZUbFK0OO6bih6d7HffbfaiUI/wyNtr8nfZfg9bHCTL32tSodOPWmh4c
         5U8g==
X-Gm-Message-State: APjAAAWFjIsVFTyeBYoKko8uGOiIikctTQCnyaB9ZOw0oZm+G4CnJ2rq
        HVIdmwmjP3NjVLeasCeisI6MSdHfO30=
X-Google-Smtp-Source: APXvYqyXRfYjBzExatE13vghULwm1O2cZ9UJveodPKKqWz8DvpJizs7od94ndwnv/5ZlNqoRQurAww==
X-Received: by 2002:a19:6917:: with SMTP id e23mr702833lfc.4.1571176042012;
        Tue, 15 Oct 2019 14:47:22 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id m15sm5231067ljh.50.2019.10.15.14.47.18
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 14:47:19 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id v24so21822758ljj.3
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2019 14:47:18 -0700 (PDT)
X-Received: by 2002:a2e:8310:: with SMTP id a16mr18060112ljh.48.1571176038634;
 Tue, 15 Oct 2019 14:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191015191926.9281-1-vgupta@synopsys.com> <20191015191926.9281-4-vgupta@synopsys.com>
In-Reply-To: <20191015191926.9281-4-vgupta@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 14:47:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg470=r9YPMLyJdgr-aLvHSnDOFwFx=Y=_HPAW-aqyFRg@mail.gmail.com>
Message-ID: <CAHk-=wg470=r9YPMLyJdgr-aLvHSnDOFwFx=Y=_HPAW-aqyFRg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] asm-generic/tlb: stub out p4d_free_tlb() if nop4d ...
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 15, 2019 at 12:19 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> This came up when removing __ARCH_HAS_5LEVEL_HACK for ARC as code bloat
> from this routine not required in a 2-level paging setup

Similarly acked,

          Linus
