Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002242E04B9
	for <lists+linux-arch@lfdr.de>; Tue, 22 Dec 2020 04:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgLVDZk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Dec 2020 22:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgLVDZk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Dec 2020 22:25:40 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405A0C0613D3;
        Mon, 21 Dec 2020 19:25:00 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v3so6687033plz.13;
        Mon, 21 Dec 2020 19:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=RaIPy33YYEHJBauFMKe6av1pPOpX7ysWVTHsmm1YmMM=;
        b=ewOT59Q9HpQla5OCbUNuYsgXbMc8UhzAb+Znyajenyzz8BwWRCoAZgSTwmYWDMkF0W
         5HMlPZgNEUaUqWG94oTI1QX/x2zNWvpyoFwdmJhNeWJr7ZEOb6v6q3os0P37EXZ+o9Cq
         Nk54nLNx1tvUUNqyZcDmu5Z0eGsOzS+gRsbXlvkrLfFP2tOB5sdT3nO0kTrfpcLI2PWr
         UjpRcZ4Z79RM2Ow9kDy1E463PuAByhGGXjmfrmszZO+NiMscBbvnLek9ylz2/nbuW+jy
         QGMFJNginIEiJVPO5aUVK5hVnU7ALVWMrlu1PUPzFDECCwn6HGgXmagXgyAjOYYZiGno
         zHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=RaIPy33YYEHJBauFMKe6av1pPOpX7ysWVTHsmm1YmMM=;
        b=Ay8YPg8VD9AruaWeiMCd+wGO4grVkl1uvMrXkjqj2G1wZBcxm3zPyYBKd9c7AYR/4X
         Shl/IaMtDFxvVPrmMThIMUYm2La3P9TwNbHiPcWg5v+p/0LKiKHGhDNGP7BPA0GfLdRi
         z0BQTH1Yiw/KTmQ+nfeD/jWzpxpJRCeBf4/z+frbfZVZAsKTBifpjMKCo4XJqzaUHnao
         V3VFBcZYRiJhnF90lv4X2U9Rnbxxj20oeIL4oZCWlB1wBTHmbC3wGsjJTLlKRzHQlqmf
         kAz5zaBHPn3MzpQI+FUB6QVp81jqW9u0NoUOGOS57iRMXBk5GWPcWvEeF5QvKea/CeKX
         jjTw==
X-Gm-Message-State: AOAM530J91ixCtRoDFVtm86Yae0nfpGHG020fNDtiN7evH06ex0oiCpz
        oUyqFWccQUZb7qHYdo1JBnc=
X-Google-Smtp-Source: ABdhPJzkTvnjsHxReSw4V5fj0dM0Vu8lxpxM+IrNd8ypuWhbpX9Lip2Ep3vWvroEYcLFo35d/NhuoA==
X-Received: by 2002:a17:902:778e:b029:da:feef:8f2d with SMTP id o14-20020a170902778eb02900dafeef8f2dmr19315658pll.25.1608607499815;
        Mon, 21 Dec 2020 19:24:59 -0800 (PST)
Received: from localhost (193-116-97-30.tpgi.com.au. [193.116.97.30])
        by smtp.gmail.com with ESMTPSA id c23sm3432480pgc.72.2020.12.21.19.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 19:24:59 -0800 (PST)
Date:   Tue, 22 Dec 2020 13:24:53 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 3/3] mm: optimise pte dirty/accessed bit setting by
 demand based pte insertion
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, Bibo Mao <maobibo@loongson.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Huang Pei <huangpei@loongson.cn>, linux-arch@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20201220045535.848591-1-npiggin@gmail.com>
        <20201220045535.848591-4-npiggin@gmail.com>
        <alpine.LSU.2.11.2012211000260.1880@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2012211000260.1880@eggly.anvils>
MIME-Version: 1.0
Message-Id: <1608606460.clzumasfvm.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Hugh Dickins's message of December 22, 2020 4:21 am:
> Hi Nick,
>=20
> On Sun, 20 Dec 2020, Nicholas Piggin wrote:
>=20
>> Similarly to the previous patch, this tries to optimise dirty/accessed
>> bits in ptes to avoid access costs of hardware setting them.
>>=20
>> This tidies up a few last cases where dirty/accessed faults can be seen,
>> and subsumes the pte_sw_mkyoung helper -- it's not just architectures
>> with explicit software dirty/accessed bits that take expensive faults to
>> modify ptes.
>>=20
>> The vast majority of the remaining dirty/accessed faults on kbuild
>> workloads after this patch are from NUMA migration, due to
>> remove_migration_pte inserting old/clean ptes.
>=20
> Are you sure about this patch? It looks wrong to me: because isn't
> _PAGE_ACCESSED (young) already included in the vm_page_prot __S001 etc?
>=20
> I haven't checked all instances below, but in general, that's why the
> existing code tends not to bother to mkyoung, but does sometimes mkold
> (admittedly confusing).

There might have been one or two cases where it didn't come directly
from vm_page_prot, but it was a few rebases and updates ago. I did see
one or two places where powerpc was taking faults. Good point though I=20
can test again and see, and I might split the patch.

>=20
> A quick check on x86 and powerpc looks like they do have _PAGE_ACCESSED
> in there; and IIRC that's true, or ought to be true, of all architectures=
.
>=20
> Maybe not mips, which I see you have singled out: I remember going round
> this loop a few months ago with mips, where strange changes were being
> proposed to compensate for not having that bit in their vm_page_prot.
> I didn't follow through to see how that ended up, but I did suggest
> mips needed to follow the same convention as the other architectures.

Yeah the main thing is to try get all architectures doing the same thing
and get rid of that sw_mkyoung too. Given the (Intel) x86 result of the
heavy micro-fault, I don't think anybody is special and we should=20
require them to follow the same behaviour unless it's proven that one
needs something different.

If we can get all arch to set accessed in vm_page_prot and get rid of=20
most of these mkyoung()s then all the better. And it actually looks like
MIPS may be changing direction:

https://lore.kernel.org/linux-arch/20200919074731.22372-1-huangpei@loongson=
.cn/

What's the chances of that going upstream for the next merge window? It
seems like the right thing to do.

Thanks,
Nick
