Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EA530D21A
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 04:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhBCDVt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 22:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhBCDNU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 22:13:20 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D10C061573;
        Tue,  2 Feb 2021 19:01:54 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g3so13656676plp.2;
        Tue, 02 Feb 2021 19:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=1D1lbt3Rz38vk3ZD1aJTQKM02Emv7JinCawTwnh8mas=;
        b=sjnb/xpg2f3ib4neVS501ZZ2+5QYiUqICTfujzksFFyQvYH9TTRQ1OHrQ42QsKAXSw
         bYeMWQeeyhhJ2MqhVAjE/WET+Lr0Z5huKLrYJ8ysoXbZDvjSBYqrbZV2uDM/7yce2mp4
         xqiKORJgRDQ2BObp815Hkg/jms8ML0Waag35kaQiy4qmqOHdGz92PvVy8Q7IB/VJMguq
         lHOoJy5FAmrj4d4B6yT8Dc98F4Lvm3ysZk3pWiatccBV6pgOgdhhBhtMFa3uP5o4RDHo
         MYU9ebBwx4j4daf2bNPsakaE9OJcuDEYdJ07eo99qx2mYqdjYpE59yOSMBlWXXOBZ5ui
         FWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=1D1lbt3Rz38vk3ZD1aJTQKM02Emv7JinCawTwnh8mas=;
        b=WZjMecXcWWDQVxjGRw3gYx0yXFiZxnPLDji+jYcguCqPHXRQlZeNl6VOJmUUT4YYM0
         /YgfqAcy12bho83b5v80HGDL24zVU5p1yl/C75YrH/PjRJs1inThWTPA7EpUG5L1/qAJ
         sVYNOOlg+1hVqlFLcY1zsD5IG4dZL3MCpEF01a2pBaLDk9YmknXrwOmuppG8CCIwCoTY
         /Qbd/jMYz3pGUI1kddtEp2P2wOjqAVgjXHS9u9fF+mCa+ZiM82M78rWsLhKKRGU7rK0Z
         2pgPV3UOsqPvLI1NeZQPoe1WGR4Fb28HxmVc3ZNuXtt3MZkD64ZXPsXHv+i1D2Z+vBbZ
         e6sQ==
X-Gm-Message-State: AOAM532gZvNDoFXgBGlBNZP32TpTnn83p9wW5MzqCWfUd7rzgoD9cCIz
        qe15lYvtamwrfWUArT+tYcM=
X-Google-Smtp-Source: ABdhPJzMyqDrlccGlrZjTkYB9avc7WfWGiiIvH2N7+xa6oX+t0dwLupW2e+1/RqMFKXpP4AxmXtK+Q==
X-Received: by 2002:a17:902:a40b:b029:e0:1096:7fb with SMTP id p11-20020a170902a40bb02900e0109607fbmr1125710plq.40.1612321313502;
        Tue, 02 Feb 2021 19:01:53 -0800 (PST)
Received: from localhost (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id 78sm322545pfx.127.2021.02.02.19.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:01:53 -0800 (PST)
Date:   Wed, 03 Feb 2021 13:01:47 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v12 01/14] ARM: mm: add missing pud_page define to 2-level
 page tables
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
        <20210202110515.3575274-2-npiggin@gmail.com>
        <20210202111319.GL1463@shell.armlinux.org.uk>
In-Reply-To: <20210202111319.GL1463@shell.armlinux.org.uk>
MIME-Version: 1.0
Message-Id: <1612321006.e59gckigqu.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Russell King - ARM Linux admin's message of February 2, 2021 =
9:13 pm:
> On Tue, Feb 02, 2021 at 09:05:02PM +1000, Nicholas Piggin wrote:
>> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtab=
le.h
>> index c02f24400369..d63a5bb6bd0c 100644
>> --- a/arch/arm/include/asm/pgtable.h
>> +++ b/arch/arm/include/asm/pgtable.h
>> @@ -166,6 +166,9 @@ extern struct page *empty_zero_page;
>> =20
>>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>> =20
>> +#define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
>> +#define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
>=20
> As there is no PUD, does it really make sense to return a valid
> struct page (which will be the PTE page) for pud_page(), which is
> several tables above?

There is no PUD on 3-level either, and the pgtable-nopud.h which it uses=20
also passes down p4d_page to pud_page, so by convention...

Although in this case at least for my next patch it won't acutally use=20
pud_page unless it's a leaf entry so maybe it shouldn't get called
anyway.

Thanks,
Nick
