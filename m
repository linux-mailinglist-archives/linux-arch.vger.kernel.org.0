Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F245E301BBD
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 13:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbhAXMFh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 07:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbhAXMFf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 07:05:35 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8BEC061573;
        Sun, 24 Jan 2021 04:04:55 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q20so6744822pfu.8;
        Sun, 24 Jan 2021 04:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=PDAPpKGJ0bTpmZBGx4ylhGlHNA52pbsxkqqZU/p/cQE=;
        b=N1+Ohqsxn1BBliytIL9FWntOw4uoZXJpJmq3olgCDZcMrsdKpIjBtCdm6Q1jifEvmr
         kKRew8+LLCRezG16J/ebB8KtQ7KiCQNFkVwXeQHonGKnLwdx3pnJMlwxY2i71MIQnrvP
         N7GzBDYqlDwotX3C5JSVYTSqBH27RoWQJCvMG1YSJ3wyEYf7e7HaRXmXDBYUFxJqIhwS
         DxWX5BCxSNBYX9fXe2SdS/Mr0od6c3/i0ZtOT4HHqZjK/UdnhKU6ngpKD+oQLnfiNCbl
         pxAyJlUgQ66A38zjsN/RzOC23VxklUz+MxZ8XqfVIleSePqQl3Kc32R5kKbWcavSe14h
         rbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=PDAPpKGJ0bTpmZBGx4ylhGlHNA52pbsxkqqZU/p/cQE=;
        b=EbBwJ9JDp9xBZgA8f7CwYdsMyRXhncwB0ZroeWWf381YzzuIg0IE0jKWi1Sxv5hgB6
         MVMFqC/swajei3gGE3s3IOkNEVr7a6aUFdf4Li7v4QIjvAYDh+3dIl+6mOThSyaR46ng
         bSadM7J9IF72+O8lRdW8JpVGTXcWg+ItXRkmxnv6D4NkyZquIj42ctgGvVmklhzUnFW2
         NvDahOCRRjvo3RvF/hHz9Gbo9lybVCOe84KTF1N5RW92HzVPykFs22WZOsdzV26zPSWx
         aXqiweKISU99TJaEDmlYYpkwsfoHhkTgOS9OAN/n/KleRXN1eSkOCJhzIhYgYPvx7uXh
         Pqlg==
X-Gm-Message-State: AOAM5301LZE2GMATMaFP4gIG0Td8OWBVKSBw0XA1mjwzhiRxqDnBmKfU
        hgWR66CzHF52O4D+DyaCrug=
X-Google-Smtp-Source: ABdhPJw0uJzRaMZJamLkCUg0NzjWJZ3f8wx59FYHNHPFfq58pfs7SdkANYAREpz+MFCRwlu/xnW1ig==
X-Received: by 2002:aa7:978e:0:b029:1bd:f965:66dd with SMTP id o14-20020aa7978e0000b02901bdf96566ddmr1977761pfp.46.1611489894337;
        Sun, 24 Jan 2021 04:04:54 -0800 (PST)
Received: from localhost ([124.170.13.62])
        by smtp.gmail.com with ESMTPSA id 78sm10076194pfx.127.2021.01.24.04.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 04:04:53 -0800 (PST)
Date:   Sun, 24 Jan 2021 22:04:47 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v10 04/12] mm/ioremap: rename ioremap_*_range to
 vmap_*_range
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
        <20210124082230.2118861-5-npiggin@gmail.com>
        <20210124113636.GD694255@infradead.org>
In-Reply-To: <20210124113636.GD694255@infradead.org>
MIME-Version: 1.0
Message-Id: <1611489705.hu96tutmbn.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christoph Hellwig's message of January 24, 2021 9:36 pm:
> On Sun, Jan 24, 2021 at 06:22:22PM +1000, Nicholas Piggin wrote:
>> This will be used as a generic kernel virtual mapping function, so
>> re-name it in preparation.
>=20
> The new name looks ok, but shouldn't it also move to vmalloc.c with
> the more generic name and purpose?
>=20

Yes, I moved it in a later patch to make reviewing easier. Rename in=20
this one then the move patch is cut and paste.

Thanks,
Nick
