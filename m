Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AB52B3B37
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 02:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgKPBtG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 Nov 2020 20:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgKPBtG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 Nov 2020 20:49:06 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452FEC0613CF;
        Sun, 15 Nov 2020 17:49:06 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d3so7542576plo.4;
        Sun, 15 Nov 2020 17:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=dwf4L1qwHkkiE8Qr6IfZkqYtpEVJ5wghNmjsqqSTRBc=;
        b=B1XiwTKYjUgE+/mAp4kiu26thv7ahq9rDf4oPdhAyuGegHghLtTgR5vyYuWkLOcPM1
         6671K7TtFw+Hw2ayTTTQGo1Iz5S0Cpvz76zSfVjSW1Ssd0u5qbB309W4SwlJt1oucziw
         urkfqy30eLgajtePU6K858M4Re9SMfnHrqakYjIaC1MrbEI1bdHt0q0DujbRFQ1j7gGb
         F5yFYv3GBEBTFlXNBwNvFW3M/9kV7B4ByNjQ66OAP47TUFcP/Ci54GAN0x4ibg9YkWha
         jZqFToWxP31WsGnR50kYVjZbXa2QmvJqAkCJgdqkKEotTxWcNb2B2G7udtgLWeIdH9X0
         5BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=dwf4L1qwHkkiE8Qr6IfZkqYtpEVJ5wghNmjsqqSTRBc=;
        b=owsaQ9xiblQNRAGvIWsnm3e8rvH2yErQTXMQ/XdGR/3pJvZFMv8WDQHiSpfcSxrfkn
         7dgknDUltxw6OwjyLbFBzCwSRh1pVBTxTILDGhB/yw2zdzJI37CCrHDQi9pp5eXUbsg9
         sktRibjSftYYUzIoK/5vvWnd7AK9Kc95RpsVuBc49rLfOpKd0B8HEupS9tOC3T8MyIGa
         O8oZ+Lzw1iNYZorhEdP8WXWvj05sdwGf4MnunnNLtVHVREp8LX2FRxCtohHkcV0jAr4L
         h5UraKY1Yur0eyh5jcgl0S6XeCUnMwLGISRv2DI7qO6Growd/sD5YSsixn9T+O36Uo5g
         GsQg==
X-Gm-Message-State: AOAM531hPqlCfuvSZ1XI89rIo/ncWLllX5QBPFJhihq+LDy42GWnzYYW
        GZCkIi9xNYMl5++2arZa8oyRLtwYSdo=
X-Google-Smtp-Source: ABdhPJw8wcYZ5fS5uDas78NkRnt336UK2Awawhc0c+GdfEv77aJJsBQSVnVn7t+uWhNF3OxG966FRw==
X-Received: by 2002:a17:902:9042:b029:d6:fe3f:6688 with SMTP id w2-20020a1709029042b02900d6fe3f6688mr10636858plz.75.1605491345753;
        Sun, 15 Nov 2020 17:49:05 -0800 (PST)
Received: from localhost (27-32-36-31.tpgi.com.au. [27.32.36.31])
        by smtp.gmail.com with ESMTPSA id h5sm16037129pfn.12.2020.11.15.17.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 17:49:05 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:48:58 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/3] asm-generic/atomic64: Add support for ARCH_ATOMIC
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will@kernel.org>
References: <20201111110723.3148665-1-npiggin@gmail.com>
        <20201111110723.3148665-2-npiggin@gmail.com>
        <3086114c-8af6-3863-0cbf-5d3956fcda95@csgroup.eu>
        <20201111134412.GT2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201111134412.GT2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1605491118.ek4lw8ppgq.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Peter Zijlstra's message of November 11, 2020 11:44 pm:
> On Wed, Nov 11, 2020 at 02:39:01PM +0100, Christophe Leroy wrote:
>> Hello,
>>=20
>> Le 11/11/2020 =C3=A0 12:07, Nicholas Piggin a =C3=A9crit=C2=A0:
>> > This passes atomic64 selftest on ppc32 on qemu (uniprocessor only)
>> > both before and after powerpc is converted to use ARCH_ATOMIC.
>>=20
>> Can you explain what this change does and why it is needed ?
>=20
> That certainly should've been in the Changelog. This enables atomic
> instrumentation, see asm-generic/atomic-instrumented.h. IOW, it makes
> atomic ops visible to K*SAN.
>=20

Right. This specific patch doesn't actually "do" anything except
allow generic atomic64 to be used with ARCH_ATOMIC. It does that
by re-naming some things to avoid name collisions and also providing
the arch_ prefix that ARCH_ATOMIC expects.

I don't know what should be in the changelog. I suppose the latter,
the former is discoverable by looking at ARCH_ATOMIC code and
patches but I guess it's polite and doesn't hurt to include the
former as well.

I'll send an update before long.

Thanks,
Nick
