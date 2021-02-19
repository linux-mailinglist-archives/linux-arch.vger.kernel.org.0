Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE81531F570
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 08:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBSHqp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Feb 2021 02:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBSHqj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Feb 2021 02:46:39 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD44AC061574;
        Thu, 18 Feb 2021 23:45:58 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d13so2925097plg.0;
        Thu, 18 Feb 2021 23:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=NT29Aq6GZEcythHq+8xV0bdKo/+iRT415c6oc0P2LMM=;
        b=jkCRi8fw6mKJu2CJVxprPAlpsVPevMqO82EY4jJLdgDTuZVfK+cFcf6N04sds0NWIG
         g2K1qEcDYGaCPVIaLUOUvFJqshuJWH95kgkNAkrvgEs9e3AxnBKZNkPl91O2qJXxKjtO
         39m5bumf3eoBQIysURVFRtASsCZ7sosNd81cNGCEUVrYEUAJaZyoY2NXj24lt4HGE8tN
         ym0U7IgAW/twVDi+kzmRkoHgE12bfG7UHtNzC6rzQG2kloxXSg6vqv8gJ5tdPgUPi76K
         WrowOqaj63HjnTxD6sVIqhcTwM8N0Tey4EJtf8NuluPptIh4PZJJWvBFTWLSVQBMVgFz
         4u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=NT29Aq6GZEcythHq+8xV0bdKo/+iRT415c6oc0P2LMM=;
        b=St0G9IMRFcOAwdsKFlm+jYeK+SABdzwJ21XmathpJDo/bwWm86a2tm8z0TnNEjdip/
         6wStLFVmf6pVWG9NsoBP+bdGRPmMQJM7sH94v7kJ8zuKaUv98+W0eYFSPvvfi5RDVTem
         wdshjFb19P21fhovBfRpFupTS4DOXxLPRtR2GbL/PebN1boS7Ns+5U29W7ceisip5rzo
         r1a1d7E3XlMhShXUPL6n8yhjP22d6IY+79m1Pk9eqWMoFUMrtNdM6tyx/go293OUk3kr
         eFfIcKklrpL4bDny9RbpaWpzPAkyqqXuczVDp400BX4d7q6fkmbl+j0JvoY+EueZAthe
         /2dQ==
X-Gm-Message-State: AOAM533NrteSJjWkBwRC+PE1uRiVYEJYKnwuN18Nu2m1AsCdpeXd//EP
        6oKVUBjhGKL71QWFqvry4Zk=
X-Google-Smtp-Source: ABdhPJw+jFkauS9YW6sy6aFIkTwI+asLmyHYBTpOgq6M/ukmSzhFYihO1OShoOb3e1vitsi8p7WftA==
X-Received: by 2002:a17:902:7b96:b029:de:7ae6:b8db with SMTP id w22-20020a1709027b96b02900de7ae6b8dbmr712101pll.0.1613720758458;
        Thu, 18 Feb 2021 23:45:58 -0800 (PST)
Received: from localhost (14-201-150-91.tpgi.com.au. [14.201.150.91])
        by smtp.gmail.com with ESMTPSA id 184sm9079328pfc.176.2021.02.18.23.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 23:45:57 -0800 (PST)
Date:   Fri, 19 Feb 2021 17:45:52 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v12 13/14] mm/vmalloc: Hugepage vmalloc mappings
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ding Tianhong <dingtianhong@huawei.com>, linux-mm@kvack.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
        <20210202110515.3575274-14-npiggin@gmail.com>
        <e18ef38c-ecef-b15c-29b1-bd4acf0e7fe5@huawei.com>
In-Reply-To: <e18ef38c-ecef-b15c-29b1-bd4acf0e7fe5@huawei.com>
MIME-Version: 1.0
Message-Id: <1613720396.pnvmwaa8om.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Ding Tianhong's message of February 19, 2021 1:45 pm:
> Hi Nicholas:
>=20
> I met some problem for this patch, like this:
>=20
> kva =3D vmalloc(3*1024k);
>=20
> remap_vmalloc_range(xxx, kva, xxx)
>=20
> It failed because that the check for page_count(page) is null so return, =
it break the some logic for current modules.
> because the new huge page is not valid for composed page.

Hey Ding, that's a good catch. How are you testing this stuff, do you=20
have a particular driver that does this?

> I think some guys really don't get used to the changes for the vmalloc th=
at the small pages was transparency to the hugepage
> when the size is bigger than the PMD_SIZE.

I think in this case vmalloc could allocate the large page as a compound
page which would solve this problem I think? (without having actually=20
tested it)

> can we think about give a new static huge page to fix it? just like use a=
 a new vmalloc_huge_xxx function to disginguish the current function,
> the user could choose to use the transparent hugepage or static hugepage =
for vmalloc.

Yeah that's a good question, there are a few things in the huge vmalloc=20
code that accounts things as small pages and you can't assume large or=20
small. If there is benefit from forcing large pages that could certainly
be added.

Interestingly, remap_vmalloc_range in theory could map the pages as=20
large in userspace as well. That takes more work but if something
really needs that for performance, it could be done.

Thanks,
Nick
