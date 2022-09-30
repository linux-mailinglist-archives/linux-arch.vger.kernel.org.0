Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C76C5F0292
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 04:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiI3CKg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 22:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiI3CKf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 22:10:35 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E13858B47
        for <linux-arch@vger.kernel.org>; Thu, 29 Sep 2022 19:10:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c19so2027795qkm.7
        for <linux-arch@vger.kernel.org>; Thu, 29 Sep 2022 19:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date;
        bh=xQ1vcv44R7M+xHLcM3UdCcUJ0FmpQ9/QA/hIJR+H2UA=;
        b=tsMpAMYS9T/aBHCdNULlb4symf7nV2a0qI4uulrb83mI810ItUZOcxgQUmMLsIflWd
         gIn6QpROC4rtwYoF+fiE7XNB12Uc7sDypXc2V2jPO6+MhbXIoKRCkSZk81T63IiXMF/V
         nBRElBBq86G8iMEReqfWz+JUsgFXUSwsDpBAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xQ1vcv44R7M+xHLcM3UdCcUJ0FmpQ9/QA/hIJR+H2UA=;
        b=soDSu7gaKnQJLUKiw7nK2P4GJkcWKUIXDZ4BtrPJ+Dkf975YGpqp1nwYXkZFJhQ9xU
         UdrZempKAxhrcYvmUTtpnjPxw1mjd30QZ8yKq5wOZnlwuH01oTsFuKvAQjE7bf+gWBNy
         DG58f4U5TYYaJH+k97sh/3yacTYF15wDjNsQiYdChNuqcPvXtYjDzgtBB4lbBfzA01yB
         nk3E7GloX7zCQ272M4qzsHBjuyugvUzAy9hqAjRwo350DTj0Kz62xk2PkojWaLnmxAPq
         B+GwQfKGKQoQZIQosJQk4eCZCtkhu5+nIJfqYaoS/GrbMxXwDMSlN9D3ZBqBjOBLKoBQ
         kWxA==
X-Gm-Message-State: ACrzQf1Phgq+yNaewv30X1ir2uclg8Buf66h33qxBu/9+VXpNUxfbd5T
        MNF6YxMWv72rl5eCO5HV8BcCLw==
X-Google-Smtp-Source: AMsMyM5MVhaTNr4byx/DEtNI2aaHDknopcbm7jd8BfEuUcdE8O3eotOk8ohaZKJjOUyRx5pCcmzObw==
X-Received: by 2002:a37:686:0:b0:6ce:3883:5ec7 with SMTP id 128-20020a370686000000b006ce38835ec7mr4471547qkg.301.1664503833083;
        Thu, 29 Sep 2022 19:10:33 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id dt35-20020a05620a47a300b006ce3cffa2c8sm1095285qkb.43.2022.09.29.19.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 19:10:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] locking/memory-barriers.txt: Improve documentation for writel() usage
Date:   Thu, 29 Sep 2022 22:10:31 -0400
Message-Id: <CCD8EFA1-D0CF-4E57-905C-E7CA8E4DA56F@joelfernandes.org>
References: <20220930020355.98534-1-parav@nvidia.com>
Cc:     bagasdotme@gmail.com, arnd@arndb.de, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
        akiyks@gmail.com, dlustig@nvidia.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
In-Reply-To: <20220930020355.98534-1-parav@nvidia.com>
To:     Parav Pandit <parav@nvidia.com>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

> On Sep 29, 2022, at 10:04 PM, Parav Pandit <parav@nvidia.com> wrote:
>=20
> =EF=BB=BFThe cited commit describes that when using writel(), explcit wmb(=
)
> is not needed. wmb() is an expensive barrier. writel() uses the needed
> I/O barrier instead of expensive wmb().

Because you mentioned it in the commit message, Why not mention in the docum=
entation text as well that writel() has the needed I/O barrier in it?

>=20
> Hence update the example to be more accurate that matches the current
> implementation.

That would make it more accurate, since accuracy is your goal.

thanks,

 - Joel


>=20
> commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO=
 ordering example")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
> ---
> changelog:
> v0->v1:
> - Corrected to mention I/O barrier instead of dma_wmb().
> - removed numbered references in commit log
> - corrected typo 'explcit' to 'explicit' in commit log
> ---
> Documentation/memory-barriers.txt | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barr=
iers.txt
> index 832b5d36e279..2d77a7411e52 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1927,10 +1927,11 @@ There are some more advanced barrier functions:
>      before we read the data from the descriptor, and the dma_wmb() allows=

>      us to guarantee the data is written to the descriptor before the devi=
ce
>      can see it now has ownership.  The dma_mb() implies both a dma_rmb() a=
nd
> -     a dma_wmb().  Note that, when using writel(), a prior wmb() is not n=
eeded
> -     to guarantee that the cache coherent memory writes have completed be=
fore
> -     writing to the MMIO region.  The cheaper writel_relaxed() does not p=
rovide
> -     this guarantee and must not be used here.
> +     a dma_wmb().  Note that, when using writel(), a prior I/O barrier is=
 not
> +     needed to guarantee that the cache coherent memory writes have compl=
eted
> +     before writing to the MMIO region.  The cheaper writel_relaxed() doe=
s not
> +     provide this guarantee and must not be used here. Hence, writeX() is=
 always
> +     preferred.
>=20
>      See the subsection "Kernel I/O barrier effects" for more information o=
n
>      relaxed I/O accessors and the Documentation/core-api/dma-api.rst file=
 for
> --=20
> 2.26.2
>=20
