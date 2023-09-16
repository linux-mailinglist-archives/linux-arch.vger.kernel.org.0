Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825767A2C44
	for <lists+linux-arch@lfdr.de>; Sat, 16 Sep 2023 02:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbjIPAdA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 20:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbjIPAcr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 20:32:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6C11738
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 17:32:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-502b1bbe5c3so4456818e87.1
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 17:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694824321; x=1695429121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hXxPKtz5nN+DfsuKg6sOZlo1Msf7kjZ/mu4lVCkpHMY=;
        b=Q2etY6S6wKtXFJHa27AXeqkuzXd23OkFpret8P3qK3hBJ+UYxb86DQbkQCeEYGmvVw
         mV7QHEP6/lihowvpG7hqAqg8BoW9FC7QAid1ZWcnn7Snmu/RqEOXkrsLrmTMcBzsztaw
         lQSxiJLcHRvrdHaiGNZerJZ1MAUfruogawF2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824321; x=1695429121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXxPKtz5nN+DfsuKg6sOZlo1Msf7kjZ/mu4lVCkpHMY=;
        b=sEGH6qJUJwc3miGiZyDylCo5Nr3vYIWZFQEqCVaNVMu/8oXp1tHGYImW1lyKb8WgWc
         W8NAIE7rhln3X0DzgLlRKwy9ycf/E8feKDcscHgXyb3kF8RL8mXnTw8aeyTVd2CSDx+s
         TKxyWFtF369df1Fxpyvbb8tAqMJ84b90zJNCQkeWPkz41MaWPv/o9kkYacuuV8J6BKLr
         0pJyrheGfzhjvOAXxwO1f3+SK3mvarXaC/aK5E4oHsx2r4loL+gS3dlFlllfk5kaxmxO
         xvFqhPHxFkFnpoUEWMfNk0RzbiSQabvxVikv44sR6rtK9duAWv1v599RdAJDD8s+NivZ
         XoGw==
X-Gm-Message-State: AOJu0YyXbM2yPIwZ+ke+MXHsXMaZ7zCeEQWltJVKMQeuoT3C7S9BYF87
        WQo1GGmsfD2NFGG85C0jLPDY3rfIlXJdQHmfDWzXb51m
X-Google-Smtp-Source: AGHT+IE0uhOjsqskSqIRPiQ+GXKY72keEuyg/eAcaIGN1rm2MYIeccHEZlTqIn5Sbv0o3ALuFhDiPw==
X-Received: by 2002:a05:6512:3b81:b0:500:b0e8:a899 with SMTP id g1-20020a0565123b8100b00500b0e8a899mr3265325lfv.30.1694824320809;
        Fri, 15 Sep 2023 17:32:00 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r27-20020ac24d1b000000b004fe202a5c7csm796405lfi.135.2023.09.15.17.32.00
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:32:00 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2bfb12b24e5so43026651fa.0
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 17:32:00 -0700 (PDT)
X-Received: by 2002:a2e:9084:0:b0:2bb:b626:5044 with SMTP id
 l4-20020a2e9084000000b002bbb6265044mr3003230ljg.6.1694824319872; Fri, 15 Sep
 2023 17:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org>
In-Reply-To: <20230915183707.2707298-1-willy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 17:31:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjU44TsEkoae6HuJi8JcTHMr01JSi_ZhiVTVSwpKvBtXA@mail.gmail.com>
Message-ID: <CAHk-=wjU44TsEkoae6HuJi8JcTHMr01JSi_ZhiVTVSwpKvBtXA@mail.gmail.com>
Subject: Re: [PATCH 00/17] Add folio_end_read
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 15 Sept 2023 at 11:37, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> I don't have any performance numbers; I'm hoping Nick might provide some
> since PPC seems particularly unhappy with write-after-write hazards.

I suspect you can't see the extra atomic in the IO paths.

The existing trick with bit #7 is because we do a lot of
page_lock/unlock pairs even when there is no actual IO. So it's worth
it because page_unlock() really traditionally shows up quite a bit.
But once you actually do IO, I think the effect is not measurable.

That said, the series doesn't look *wrong*, although I did note a few
things that just made me go "that looks very strange to me" in there.

                      Linus
