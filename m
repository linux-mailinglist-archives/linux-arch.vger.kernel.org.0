Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18072230824
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 12:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgG1Kxb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 06:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgG1Kxa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jul 2020 06:53:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEACC061794;
        Tue, 28 Jul 2020 03:53:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k1so11320293pjt.5;
        Tue, 28 Jul 2020 03:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=agRMqGGlf6WEhzng1JHJTfSL3lgFlGnxzJ0Cav+bYwY=;
        b=LOlyux900DwySJrPY4APfRX1lil/nI28/QfYF1AYlmE+78dPK5RYl6rQ+sD5+x5MA7
         playMugBZGJPi4cNxmeP+cB0atQX1/GTXF03Pb/x2CQuKNPkiq1Waz1Ky+uypI3zPBSW
         YxU5r/gfiPvvENminX12cG6746FlKyqgYVwOqF0W5IlOPxW4T/F2yNlR2vFRm8/RzuPL
         P1B0c7lbUooXxICuyibePBquJuQisL8LvIEyaJISfFRcWpoYQESGRDwq8TevCKApJ6e/
         fJla/uli1Og8SbOWaKOadogeThM5RYLbSZ5LSpD9XEG3FW2zmhtctXWhQqI+shiRcdy8
         7X2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=agRMqGGlf6WEhzng1JHJTfSL3lgFlGnxzJ0Cav+bYwY=;
        b=QvnoEQ9CBQ6TFqk9tu+Mn5DqHBZgYaJ2xsBqz1c29fb2Ikf/NOB4tRPzyOvQSbaoth
         OtsA24NcQNQ2EHHIs7SBkVMHYEUDMFees7ZS1c8MHHiM2YIpo6MZpjWGKO1cDqIZPsSv
         5yV0S22sf+bKifLB3H+9BhYSlNJy3bHd2vbocwFj3GXi0iq1Nozo0Q/81S9YfV1UJM+4
         0Gy7qhs2b10oMB72uNcycM5R2dB5d7g9rsEkRGVXZaZZ0oak/LkoGxzee/MfQrXOrVTe
         qa43A3dIAiB4S6sD0L0aBo5p0SG+eXtR6ge4BCjxmhr0m15CfPZ27UJdEO02Fc0AdhY3
         hA4g==
X-Gm-Message-State: AOAM530eqWN5q46iaJtHPMeL3Swm8sBkUODnHFxFcqGkS50Yn7jZ5SLp
        Mom318Vmf580P4l27Jemtq7eQApH
X-Google-Smtp-Source: ABdhPJzDyUiZdoRIhWil/eQB9vL3D+ZkGma3UEEEz2L1OSFLOod9x5RLtms6ZoVyeVTnVsDId/pLZw==
X-Received: by 2002:a17:902:fe10:: with SMTP id g16mr955299plj.227.1595933609963;
        Tue, 28 Jul 2020 03:53:29 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id z11sm17894138pfk.46.2020.07.28.03.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:53:29 -0700 (PDT)
Date:   Tue, 28 Jul 2020 20:53:23 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [patch 01/15] mm/memory.c: avoid access flag update TLB flush for
 retried page fault
To:     linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hdanton@sina.com>,
        Hugh Dickins <hughd@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Xu <xuyu@linux.alibaba.com>, linuxppc-dev@lists.ozlabs.org
References: <20200723211432.b31831a0df3bc2cbdae31b40@linux-foundation.org>
        <20200724041508.QlTbrHnfh%akpm@linux-foundation.org>
        <CAHk-=wguPA=pDskR-eMMjwR5LDEaMXrqbmDbrKr0u=wV1LE4rg@mail.gmail.com>
        <CAHk-=wh4kmU5FdT=Yy7N9wA=se=ALbrquCrOkjCMhiQnOBLvDA@mail.gmail.com>
        <0323de82-cfbd-8506-fa9c-a702703dd654@linux.alibaba.com>
        <20200727110512.GB25400@gaia>
        <39560818-463f-da3a-fc9e-3a4a0a082f61@linux.alibaba.com>
        <eb1f5cb4-7c3d-df42-f4aa-804e12df45e2@linux.alibaba.com>
        <CAHk-=wha6f0gF1SJg96R77h0oTuc_oO7-37wD=mYGy6TyJOwbQ@mail.gmail.com>
In-Reply-To: <CAHk-=wha6f0gF1SJg96R77h0oTuc_oO7-37wD=mYGy6TyJOwbQ@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1595932767.wga6c4yy6a.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Linus Torvalds's message of July 28, 2020 4:37 am:
> [ Adding linux-arch, just to make other architectures aware of this issue=
 too.
>=20
>   We have a "flush_tlb_fix_spurious_fault()" thing to take care of the
> "TLB may contain stale entries, we can't take the same fault over and
> over again" situation.
>=20
>   On x86, it's a no-op, because x86 doesn't do that. x86 will re-walk
> the page tables - or possibly just always invalidate the faulting TLB
> entry - before taking a fault, so there can be no long-term stale
> TLB's.

[snip]

>   It looks like powerpc people at least thought about this, and only
> do it if there is a coprocessor. Which sounds a bit confused, but I
> don't know the rules.

I'm not sure about ppc32 and 64e, I'm almost certain they should do a=20
local flush if anyting, and someone with a good understanding of the=20
ISAs and CPUs might be able to nop it entirely. I agree global can't=20
ever really make sense (except as a default because we have no generic=20
local flush).

powerpc/64s reloads translations after taking a fault, so it's fine with=20
a nop here.

The quirk is a problem with coprocessor where it's supposed to=20
invalidate the translation after a fault but it doesn't, so we can get a=20
read-only TLB stuck after something else does a RO->RW upgrade on the=20
TLB. Something like that IIRC.  Coprocessors have their own MMU which=20
lives in the nest not the core, so you need a global TLB flush to
invalidate that thing.

Thanks,
Nick
