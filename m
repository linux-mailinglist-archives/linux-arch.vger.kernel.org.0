Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4590C24D38E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 13:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgHULL1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 07:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHULL0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 07:11:26 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B430C061385;
        Fri, 21 Aug 2020 04:11:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so859008pgf.0;
        Fri, 21 Aug 2020 04:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=O0JOI3uzd7ucCmR5qeZbGG+pRLYOys3ZnqIcbO7aSA8=;
        b=raPLPjcfRS5fGs6GsJeKHoRE7KZtMB/Kmt/+3TpNhYGZEkTmc9rqs5EaeEt2jXkwmR
         Pjke8YLKuCt52Qjfrrzo1cjJGbM51qa/lguoTsbuRVTntBeFV6YmmbbY91kIBTfhraZt
         ep/meXsgBak78BLiUDvktrLgzmxL4hY2nlMLVL2+jskO41rg2XgfixV0JeShCBEwUwgm
         Yfwnv4PKI0n4/IwHrjUQClJ3xVdb5ixzGgAZH867Y6KYjBhurxhwLe5fjo/8pWJU+JOg
         50NpKfxgOc2nACLFdQ9cfs9a4AaFxhk/lnmJj9JSeIi1b8zizgfXdoE1Obx8JMc2l11N
         2ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=O0JOI3uzd7ucCmR5qeZbGG+pRLYOys3ZnqIcbO7aSA8=;
        b=Rk8lQE6ZPXQI14P5ymuKkmbUvHo3v33lkEmgBj5qG+NLnAqmHoo+4sj6rcGDxVeaph
         NfMFtM6J/JnQVdpWWxIJXJQszrKDOXsOMEODBlev5IzdID5SUEewr4yEqEbcSMBN4rha
         H9K6UU7HP4i8pfArg8JSZhnPiShcfdzYcp5dnX1Gl+yrvmwFqzpM141dr3Ibwj1+dQ4g
         LyaqYpyDoh3RaE2bp+IObqweCIpAM5hhSmYMPEszTiIdLRiUVC/WZ1pAJuPFNauf1UyM
         iBiw7aWd+FDg2dKRMtch4r7RdMDwaY1Q7AsCMVCJwnW+xjmpnXsM2f2N1/SAEmZtUMma
         x1IA==
X-Gm-Message-State: AOAM533sh+3XQQzFhqeO496g54hDRSLdDrpRps5UNCbWQDrvKwHlQMuD
        hw5j52y9CLjDeiVk/7bKhYRNm4YMwpY=
X-Google-Smtp-Source: ABdhPJyN95KoCLSGpi+TFBy6i2yfFQWUvteLJM7qPop/EXa6ZcjYNEgf2G5C1Xl8hpt0GydW8Ox0Hw==
X-Received: by 2002:a65:6287:: with SMTP id f7mr1981459pgv.307.1598008285896;
        Fri, 21 Aug 2020 04:11:25 -0700 (PDT)
Received: from localhost (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id o7sm1613042pjl.48.2020.08.21.04.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 04:11:25 -0700 (PDT)
Date:   Fri, 21 Aug 2020 21:11:19 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 0/8] huge vmalloc mappings
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-mm@kvack.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>
References: <20200821044427.736424-1-npiggin@gmail.com>
        <bc7537f4-abc6-b7cc-ccd3-420098fec917@csgroup.eu>
In-Reply-To: <bc7537f4-abc6-b7cc-ccd3-420098fec917@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1598006399.kdw772nr6n.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of August 21, 2020 3:47 pm:
>=20
>=20
> Le 21/08/2020 =C3=A0 06:44, Nicholas Piggin a =C3=A9crit=C2=A0:
>> I made this powerpc-only for the time being. It shouldn't be too hard to
>> add support for other archs that define HUGE_VMAP. I have booted x86
>> with it enabled, just may not have audited everything.
>=20
> I like this series, but if I understand correctly it enables huge=20
> vmalloc mappings only for hugepages sizes matching a page directory=20
> levels, ie on a PPC32 it would work only for 4M hugepages.

Yeah it really just uses the HUGE_VMAP mapping which is already there.

> On the 8xx, we only have 8M and 512k hugepages. Any change that it can=20
> support these as well one day ?

The vmap_range interface can now handle that, then adding support is the
main work. Either make it weak and arch can override it, or add some
arch helpers to make the generic version create the huge pages if it's
not too ugly. Then you get those large pages for ioremap for free.

The vmalloc part to allocate and try to map a bigger page size and use=20
it is quite trivial to change from PMD to an arch specific size.

Thanks,
Nick

