Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732EF7A2D60
	for <lists+linux-arch@lfdr.de>; Sat, 16 Sep 2023 04:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbjIPCPe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 22:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbjIPCPR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 22:15:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9ED1FCE
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 19:15:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ad8bba8125so354272366b.3
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 19:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694830510; x=1695435310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FbufmgnpA0aesZB//HGaq/RO2Y/ticw2RyjyAED+2xY=;
        b=NanDQtzLSn56DbN41fh7mYp+Cdf7CmrHSQHG1DhofFoaQ9727yFGL0Qxo6F7P8BvJK
         5EGwqZn3/fUukro+ACcvUx1MMOAGJaJ9ZUfkS/VaAhLbXvBtUGoEk8MjlD3C+gJ68gUj
         FvQ0uFfbULzhZ5g/syv9gwlwjNIOxVN5i6GWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694830510; x=1695435310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbufmgnpA0aesZB//HGaq/RO2Y/ticw2RyjyAED+2xY=;
        b=Sxatpb9lf3kBcidW2UTwduDPCZ5EDcPD8puCy2sUim3yuGz5D+xYMFrBAq7OxMtSsy
         tvbctw4IWhawW6ZL2yGgt4GXsSNzSZO2tjLmAurk2Y1LQUjLHlrOLlvOQWRzyCqqvzjO
         Xe481cbvqgntbsx0YlyST+oFlK8z4nJopfhmFLaibblfxH6YbQWI8GwVoZnAhrpSNzBj
         nNGCVgxyQ7aZtDw7M0pIEgEZW9PGyXxX8hRU+oChOtGOVr0AykP+vqGXyUz6xNg/Zr4m
         KQSCen+KrSG1iUlPpHoVU4G8iroUL0PHafYdZcv3JTt2gq0gW5glNTacu/Zb/XGZC9Ka
         2dJA==
X-Gm-Message-State: AOJu0Ywb9RiE3P3XCeAQFWqWJPhfRZEuKr0YSLvOkr/FJ4fnFX4BTJ3J
        32hC41aPLngrPh4KPjBgH1JyG2BkIxa2sPC+5mpE2Per
X-Google-Smtp-Source: AGHT+IGn4bFHqiZOeHMfHzNoXE7Ca/h0z3XB2/aC48zQpJSgMaFYd1dO7nkuIcOeis0+H7QvFXZmhw==
X-Received: by 2002:a17:906:8441:b0:9a4:dd49:da3e with SMTP id e1-20020a170906844100b009a4dd49da3emr2478305ejy.68.1694830510404;
        Fri, 15 Sep 2023 19:15:10 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906390d00b00982a92a849asm3102862eje.91.2023.09.15.19.15.09
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 19:15:09 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso353999266b.2
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 19:15:09 -0700 (PDT)
X-Received: by 2002:a17:906:cc9:b0:977:ecff:3367 with SMTP id
 l9-20020a1709060cc900b00977ecff3367mr2903210ejh.40.1694830509066; Fri, 15 Sep
 2023 19:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-9-willy@infradead.org>
 <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com>
 <ZQT4/gA4vIa/7H6q@casper.infradead.org> <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
In-Reply-To: <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 19:14:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+QEzoiUjeUkYqkJe4mcTQCshaAje51PiAuJu+REYxSA@mail.gmail.com>
Message-ID: <CAHk-=wj+QEzoiUjeUkYqkJe4mcTQCshaAje51PiAuJu+REYxSA@mail.gmail.com>
Subject: Re: [PATCH 08/17] alpha: Implement xor_unlock_is_negative_byte
To:     Matthew Wilcox <willy@infradead.org>
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

On Fri, 15 Sept 2023 at 19:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> No, I think "mov src,dst" is just a pseudo-op for "or src,src,dst",
> there's no actual "mov" instruction, iirc.

Bah. I looked it up. It's actually supposed to be "BIS r31,src,dst".

Where "BIS" is indeed what most sane people call just "or". I think
it's "BIt Set", but the assembler will accept the normal "or" mnemonic
too.

There's BIC ("BIt Clear") too. Also known as "and with complement".

I assume it comes from some VAX background. Or maybe it's just a NIH
thing and alpha wanted to be "special".

              Linus
