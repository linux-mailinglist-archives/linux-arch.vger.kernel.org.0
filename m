Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A737A2BFA
	for <lists+linux-arch@lfdr.de>; Sat, 16 Sep 2023 02:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbjIPA3E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 20:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238441AbjIPA2s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 20:28:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4027D10D
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 17:27:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so8066138a12.1
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 17:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694824056; x=1695428856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E8Y6H+CGjrqtUwepfVg3ZapOU4tcqDJDh2TjsLFPfcI=;
        b=TcQG2Kb/Ip8PZWX2Cc3dnN58Lcb4fXG4xyYDtQTu/rKnLSdEkxpVSyDC/bSmfyG4iB
         ByiFLo9h+G356gxS9zNIYHVdUfDVD3r1NbBN918JCGUk/xkk4Nf0LzCw5g0+PMkU3TvU
         NVOh5inKCcyUTVoqS7mOSOg/iy2LR2HjB52xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824056; x=1695428856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8Y6H+CGjrqtUwepfVg3ZapOU4tcqDJDh2TjsLFPfcI=;
        b=Hvm/3J4iLXxwQGF+syj9058Hv9FDKRyb+sArr+RyIc+4yEgkYNaVutouz2pCNFNH7x
         hEJoA+Ns9Uvgu+lYMKjCVfjRAoafAmj4upXZZHRLUprc54i5qbb8HeH4+01uGotueehB
         d6QAKqa2BHkS+SJIkd79WqKJw/wOul/pwC0Pc2fYFG0+V3QRiz5Z+rKRu4cMcDdSgOgq
         zxK+ziyZvwbSKnsHfpyT/6ZuGnbRDLuTBb54QdOuubswTFD7jED7Sy4dY3OkMYbOHIa9
         BxRQFu/zKYbGJZYtjfZapWSPeLdU1Y1M0lMQT5a0fUvs3+92dT1CUb+04N1vRzOXEGYh
         6fmA==
X-Gm-Message-State: AOJu0YxHYU4XA+s0BBh/9EMu76JOI5Tw5Inrnhdl3KAEMXxtPNF7w3VM
        cloRbaI2abxDVPg+Lw5FK0A8/kV7fqF/eVfl/LLksdze
X-Google-Smtp-Source: AGHT+IHyYmww3n6l5cHgY4rHQnPWt5BVCi/YZUzndsMMVyZcvkMSByS+oDSGO6uEn6QvAox5kI2Riw==
X-Received: by 2002:a17:906:530e:b0:9a9:e326:d0c2 with SMTP id h14-20020a170906530e00b009a9e326d0c2mr4867452ejo.4.1694824055953;
        Fri, 15 Sep 2023 17:27:35 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id rp9-20020a170906d96900b0099e05fb8f95sm3028455ejb.137.2023.09.15.17.27.35
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:27:35 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9a9d6b98845so827194166b.0
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 17:27:35 -0700 (PDT)
X-Received: by 2002:a17:907:80a:b0:9a9:405b:26d1 with SMTP id
 wv10-20020a170907080a00b009a9405b26d1mr8271589ejb.5.1694824054952; Fri, 15
 Sep 2023 17:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-9-willy@infradead.org>
In-Reply-To: <20230915183707.2707298-9-willy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 17:27:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com>
Message-ID: <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com>
Subject: Re: [PATCH 08/17] alpha: Implement xor_unlock_is_negative_byte
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
> +       "1:     ldl_l %0,%4\n"
> +       "       xor %0,%3,%0\n"
> +       "       xor %0,%3,%2\n"
> +       "       stl_c %0,%1\n"

What an odd thing to do.

Why don't you just save the old value? That double xor looks all kinds
of strange, and is a data dependency for no good reason that I can
see.

Why isn't this "ldl_l + mov %0,%2 + xor + stl_c" instead?

Not that I think alpha matters, but since I was looking through the
series, this just made me go "Whaa?"

                Linus
