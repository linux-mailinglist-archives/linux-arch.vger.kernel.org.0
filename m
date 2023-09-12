Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8260D79DA3C
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 22:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjILUs3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Sep 2023 16:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjILUs3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Sep 2023 16:48:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2013A10D3
        for <linux-arch@vger.kernel.org>; Tue, 12 Sep 2023 13:48:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-501bd164fbfso9940495e87.0
        for <linux-arch@vger.kernel.org>; Tue, 12 Sep 2023 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694551703; x=1695156503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hv80f3uDeX+bprELwtiGX3ZT6QuXvl6UBldMet1HOC8=;
        b=TxoxlD5wJ9ARnL0xVpGBzb3beYAA9gnS79hlfxVWWSJl12JcExYO8Qk2rlFbAg8mhn
         gOZfqd8yjYQt5YuELvyg2sdaPN6pYt89YA+KVACkU2NywnF1eAAa3o923o8f3FOx62gk
         wjG0CLl+RDgbOn46edkm6zaELpBkbg5VPSfBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694551703; x=1695156503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hv80f3uDeX+bprELwtiGX3ZT6QuXvl6UBldMet1HOC8=;
        b=ZM+tUTyDxf3P8qzRKAelUcMbyhofknfeHHbJhqNngqpUTGFIbaKzssAETCqjodggNB
         mW1N7IfVpJURK7B3Dz3btGLJYRtRnmrks2AugU+au0koYRIoNN7iZvaNXQVCCdPUrg3a
         gwhqSpdGW6V6mezW9JBk7cZApVWtH1Dd+FcwkO0d7dj2OfELUcJjFJXXZmtVE7s55XfV
         OS7KeL0x5nPy1KMlOKcjDQgZ1ynIgHcKtiyVKbllWBU3nmuRKDv5j47LWdnCM4+2oFiW
         6LxyPRicH/HsoVZsaTOe4TbQ//mIrg96U/aTl7h5BYmd2tqQFay0YIKIu2gon8kqAa7N
         rpwg==
X-Gm-Message-State: AOJu0YyFyrYpuTn6YdN5d8yTwDTS749I0V1rA6JGbPCUveWs5nrTYOgP
        xRXATJ+yLRKWYxpbvAepkz3ianuwfnxGXqv10jgri5Tn
X-Google-Smtp-Source: AGHT+IGGh8ZjSTSacqqttf4C5+473dXkDGwHZfOdB0D35hBzJxKaqV41oNVgd+OIddgHcQddOpPzZg==
X-Received: by 2002:a05:6512:3f08:b0:500:9d4a:89fa with SMTP id y8-20020a0565123f0800b005009d4a89famr636743lfa.22.1694551703092;
        Tue, 12 Sep 2023 13:48:23 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906044a00b0099d0a8ccb5fsm7352645eja.152.2023.09.12.13.48.21
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 13:48:22 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so69383555e9.0
        for <linux-arch@vger.kernel.org>; Tue, 12 Sep 2023 13:48:21 -0700 (PDT)
X-Received: by 2002:a05:600c:2288:b0:401:d803:6246 with SMTP id
 8-20020a05600c228800b00401d8036246mr553079wmf.2.1694551701487; Tue, 12 Sep
 2023 13:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <27ba3536633c4e43b65f1dcd0a82c0de@AcuMS.aculab.com>
 <CAGudoHHUWZNz0OU5yCqOBkeifSYKhm4y6WO1x+q5pDPt1j3+GA@mail.gmail.com>
 <9a5dd401bf154a0aace0e5f781a3580c@AcuMS.aculab.com> <CAGudoHEuY1cMFStdRAjb8aWbHNqy8Pbeavk6tPB+u=rYzFDF+Q@mail.gmail.com>
 <ed0ac0937cdf4bb99b273fc0396b46b9@AcuMS.aculab.com> <CAHk-=wiXw+NSW6usWH31Y6n4CnF5LiOs_vJREb8_U290W9w3KQ@mail.gmail.com>
 <fa01f553d57e436c8a7f5b1c2aae23a9@AcuMS.aculab.com>
In-Reply-To: <fa01f553d57e436c8a7f5b1c2aae23a9@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Sep 2023 13:48:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whC8TaarEhz2ie_w01r34hQHNCTiZLAs6e42ewP7+cvoA@mail.gmail.com>
Message-ID: <CAHk-=whC8TaarEhz2ie_w01r34hQHNCTiZLAs6e42ewP7+cvoA@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     David Laight <David.Laight@aculab.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 12 Sept 2023 at 12:41, David Laight <David.Laight@aculab.com> wrote:
>
> What I found seemed to imply that 'rep movsq' used the same internal
> logic as 'rep movsb' (pretty easy to do in hardware)

Christ.

I told you. It's pretty easy in hardware  AS LONG AS IT'S ALIGNED.

And if it's unaligned, "rep movsq" is FUNDAMENTALLY HARDER.

Really.

                    Linus
