Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28044718BBC
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjEaVXA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEaVW7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:22:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4CAB3;
        Wed, 31 May 2023 14:22:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5147e8972a1so337517a12.0;
        Wed, 31 May 2023 14:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568177; x=1688160177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQC0Taw9DGW/ijDYPQDBEhLOfb54DcOaqiw5dKW4RRw=;
        b=fQbgXhP7vZD5Cb5UboaK4p5MsA/A1lgkFfndrv+/e6Xdt9DuyuFoNjaL9zWH1qYT8K
         9H4c8AZT060gPZ4qDCi2b+rM/kjePV2T6Imlsc17d+sLCRR+86fQR75zjnq2I9yil0Tv
         GV02WUh3oqGASMqxsvRnMBECZ20TovHpByejrsq8QjgwfCTtd9/p3y2Saso2RPn45O7D
         mor9RvUFMe89ioFgsQ9qVPOKBP5ORxy8pnIocKTgdXne7HdJaxb5yVWqxYV8DglitDJG
         ML38K61GcbMU1RVEiCAq4wcoCUt0nRaS+djaA5bo2qRQL1Jsszs8QOE7SEeSqBY2azdd
         UYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568177; x=1688160177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQC0Taw9DGW/ijDYPQDBEhLOfb54DcOaqiw5dKW4RRw=;
        b=T82SmXIl6uMkylIKwqx9tDpzHm8Rof+9GXLristfgAjc1o1AMSSttybczfsvtiJoVP
         /GDXU5qzwNR5Mvu0VKB45ioySYOBrjT4ovMZJw/1UCNdy02UeYddUTyvon2X0xay9wq7
         5i4aVM0+SQUXkt3ONHjDsLNpzv4Lmh8U4T0uBEN3Xr4jB3gQkKiKWA0cQM5mbIJnxCJx
         f/V5y9zfAVHm+W7pyvZsVDi/TlSLu6VVQuC9AeiNaQZt4fhujlpg/wFYSlwkiU4jdl+0
         ksTgKulydltW3C9LRqFrh36Mm1AhTUZstD98T05uJW8icqsHbRRzsxUWfJ+EtJf8U4na
         speA==
X-Gm-Message-State: AC+VfDy4LAW4Vi9Nhvpu9Z9mkgxi2FJ5ycIW0Bjf/LcNC0TDxzgLj0YQ
        AnoHbPexyPEotmCjFm8UbI+jsi1IFJapfg==
X-Google-Smtp-Source: ACHHUZ58AfxanTFy84gvgH+WbnI8SDn1e0skiaPsqfAo0ulKz1ynaHRQnVTu+7rCnWtzRmHPssV4kw==
X-Received: by 2002:a17:907:6d27:b0:96f:f50b:9b15 with SMTP id sa39-20020a1709076d2700b0096ff50b9b15mr6512573ejc.35.1685568176853;
        Wed, 31 May 2023 14:22:56 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170907174400b0096f7500502csm9594497ejc.199.2023.05.31.14.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:22:56 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-crypto@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 5/7] crypto: update some Arm documentation references
Date:   Wed, 31 May 2023 23:22:55 +0200
Message-ID: <2283368.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20230529144856.102755-6-corbet@lwn.net>
References: <20230529144856.102755-1-corbet@lwn.net>
 <20230529144856.102755-6-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dne ponedeljek, 29. maj 2023 ob 16:48:54 CEST je Jonathan Corbet napisal(a):
> The Arm documentation has moved to Documentation/arch/arm; update a
> set of references under crypto/allwinner to match.
> 
> Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-sunxi@lists.linux.dev
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


