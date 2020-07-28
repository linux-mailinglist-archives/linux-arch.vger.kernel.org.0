Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DF823121C
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 21:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgG1TCa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 15:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgG1TCa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jul 2020 15:02:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96DCC061794
        for <linux-arch@vger.kernel.org>; Tue, 28 Jul 2020 12:02:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j22so5699736lfm.2
        for <linux-arch@vger.kernel.org>; Tue, 28 Jul 2020 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5wY8dZVxLVDVtXV0Fno8TPWZHbBOBFdSVrj3/KpG98=;
        b=AJA0ly/Zta9n3Y6hwB1XZB7k4bPFf2Zn/XboyPgtxJYz8WbIUbemvozhjISY4XlOzG
         JexmZnEhqI4D5U5maVR0XCMxSJjPMspx4qGCGNITUi21GtMvpfMhxkKF+XW60bxsVjFL
         gcqEYLwZg3eqggW9txrqGfEFleISyfIQRk9aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5wY8dZVxLVDVtXV0Fno8TPWZHbBOBFdSVrj3/KpG98=;
        b=PJysQlWoj8qcgr1IbYdubWsvcnaKMVhQn1Lby/JwNiZXt+AlL9MGTFVHCap3jNYFPo
         RL3cJXSVxTSsFVb6Fq7tHFZfcNuTbVIW3kHaVllO/5Z4Xd3Waayn7hhCz0VOc9GVLZrD
         9ElrI+YzbOx6dgPhzS+h1c+U2BfuwHRxhMfnOvIxGpMRUU5ec9MBQN8bKlAM+mDIb+ta
         od/QRnGdco1dnXPXKkNx62WG66L2vWBlmAKaogsaXeJ1Bega2+YFTG3wueBxZc1SDAFp
         Z0sW9mQbGtBNv0JHAupkxXvV5wHJJjaHdZqHGZ8PansPGVvmz/YfLAC6c3vJc58k1y2e
         SNWA==
X-Gm-Message-State: AOAM530yjYi56IrMVBrKTYaqzm3JvmSND3iZ4mG/PiugHFSHPf3wat08
        8fzE1HqVnI7XCWUBsuB0IChENUZauAE=
X-Google-Smtp-Source: ABdhPJyO4OxYISpgg4S+LiiL842jHdg/IsVYT0cVIUjGy7t9/UEmsi226DMCagcF8cAvjbT4TDRZwg==
X-Received: by 2002:ac2:5502:: with SMTP id j2mr13623350lfk.50.1595962947438;
        Tue, 28 Jul 2020 12:02:27 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b2sm3625182lji.63.2020.07.28.12.02.25
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 12:02:25 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id y18so11579604lfh.11
        for <linux-arch@vger.kernel.org>; Tue, 28 Jul 2020 12:02:25 -0700 (PDT)
X-Received: by 2002:a05:6512:2082:: with SMTP id t2mr15641334lfr.142.1595962944925;
 Tue, 28 Jul 2020 12:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200723211432.b31831a0df3bc2cbdae31b40@linux-foundation.org>
 <20200724041508.QlTbrHnfh%akpm@linux-foundation.org> <CAHk-=wguPA=pDskR-eMMjwR5LDEaMXrqbmDbrKr0u=wV1LE4rg@mail.gmail.com>
 <CAHk-=wh4kmU5FdT=Yy7N9wA=se=ALbrquCrOkjCMhiQnOBLvDA@mail.gmail.com>
 <0323de82-cfbd-8506-fa9c-a702703dd654@linux.alibaba.com> <20200727110512.GB25400@gaia>
 <39560818-463f-da3a-fc9e-3a4a0a082f61@linux.alibaba.com> <eb1f5cb4-7c3d-df42-f4aa-804e12df45e2@linux.alibaba.com>
 <CAHk-=wha6f0gF1SJg96R77h0oTuc_oO7-37wD=mYGy6TyJOwbQ@mail.gmail.com> <1595932767.wga6c4yy6a.astroid@bobo.none>
In-Reply-To: <1595932767.wga6c4yy6a.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Jul 2020 12:02:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrgRqeEo-YUgec7yQNkN+_+sHBP-NtCnfktCFEuPHTDQ@mail.gmail.com>
Message-ID: <CAHk-=wgrgRqeEo-YUgec7yQNkN+_+sHBP-NtCnfktCFEuPHTDQ@mail.gmail.com>
Subject: Re: [patch 01/15] mm/memory.c: avoid access flag update TLB flush for
 retried page fault
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hdanton@sina.com>,
        Hugh Dickins <hughd@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Xu <xuyu@linux.alibaba.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 28, 2020 at 3:53 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The quirk is a problem with coprocessor where it's supposed to
> invalidate the translation after a fault but it doesn't, so we can get a
> read-only TLB stuck after something else does a RO->RW upgrade on the
> TLB. Something like that IIRC.  Coprocessors have their own MMU which
> lives in the nest not the core, so you need a global TLB flush to
> invalidate that thing.

So I assumed, but it does seem confused.

Why? Because if there are stale translations on the co-processor,
there's no guarantee that one of the CPU's will have them and take a
fault.

So I'm not seeing why a core CPU doing spurious TLB invalidation would
follow from "stale TLB in the Nest".

If anything, I think "we have a coprocessor that needs to never have
stale TLB entries" would impact the _regular_ TLB invalidates (by
update_mmu_cache()) and perhaps make those more aggressive, exactly
because the coprocessor may not handle the fault as gracefully.

I dunno. I don't know the coprocessor side well enough to judge, I'm
just looking at it from a conceptual standpoint.

          Linus
