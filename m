Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D4B7A2BC0
	for <lists+linux-arch@lfdr.de>; Sat, 16 Sep 2023 02:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjIPASg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 20:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbjIPASS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 20:18:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F8D359F
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 17:12:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso43049351fa.1
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 17:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694823135; x=1695427935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8c5EEQNtbw0MpT7TQp8klkowES4X88JiAqVKAD/YI88=;
        b=Kd3BMSYjbbvPOWTTM4CSQw06scNUtIM7X+/+Xxcj/NQbFZZIZpB2uoOHMj/vsVouFB
         3/N4IBFgDUVm/ykCtJk47Cs2CmdYcJaMHjLbZBG7YbImPXFabw7pYzG9z9v8+5Rvms5c
         FHrNAuCAW8A6B3isutwnIgGLSB48IBtwDBhXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694823135; x=1695427935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8c5EEQNtbw0MpT7TQp8klkowES4X88JiAqVKAD/YI88=;
        b=q6GxxNlmm3BE09EeG6B5OkTvfNU8rVijWgXJY8Jronlu4ClXE14Y4+axNM7BTOGEjI
         qxNYN2m3rZ5qfJRx//aqkVBXQ0GqFo0wBt+/q9khOfOhbnyCf9PLLtpBes6P3gUI1gxm
         shztWHkaDzysBo/+2VoVHqqcJg6HM3bVhE4tVsDo/eXdh7r3VKDFDQ03m3Uy+v0Ad6QW
         afmpE3R7WTGUblQdVgkff1yPf+m4+yw1BbeVNzYkFaGXRB3Kdi7DQ4gv1+h4Sh9lQLT2
         ij1EX7JOHxaPDNVxTnpiGOdBHnX0yATqswtm6TTCllZMWyR0W1Wbea/u/k/HSJyGjBIF
         kpQQ==
X-Gm-Message-State: AOJu0YxKYhf/9Elh9J9fX5Feq1hyAphTUpLvCYz35z6aNSBhpG5GqoAn
        SuhVp7fiGSvdR2nAqMXi+LDxV5AqnugG+QoNkgYVIi3Y
X-Google-Smtp-Source: AGHT+IFM0029SVvG9I7NoQr/twcVQfof/D1a2RuYopaBUWCQtWXGKW+sdCOjFcriQ8718FfVHcu7Wg==
X-Received: by 2002:a2e:9cc1:0:b0:2bd:c3d:1dd5 with SMTP id g1-20020a2e9cc1000000b002bd0c3d1dd5mr2759257ljj.32.1694823134655;
        Fri, 15 Sep 2023 17:12:14 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906854b00b0099ccee57ac2sm3006851ejy.194.2023.09.15.17.12.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:12:13 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-530196c780dso2812721a12.1
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 17:12:13 -0700 (PDT)
X-Received: by 2002:aa7:d758:0:b0:525:6d6e:ed53 with SMTP id
 a24-20020aa7d758000000b005256d6eed53mr2493234eds.27.1694823132722; Fri, 15
 Sep 2023 17:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-3-willy@infradead.org>
In-Reply-To: <20230915183707.2707298-3-willy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 17:11:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
Message-ID: <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
Subject: Re: [PATCH 02/17] iomap: Protect read_bytes_pending with the state_lock
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 15 Sept 2023 at 11:37, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Perform one atomic operation (acquiring the spinlock) instead of
> two (spinlock & atomic_sub) per read completion.

I think this may be a worthwhile thing to do, but...

> -static void iomap_finish_folio_read(struct folio *folio, size_t offset,
> +static void iomap_finish_folio_read(struct folio *folio, size_t off,

this function really turns into a mess.

The diff is hard to read, and I'm not talking about the 'offset' ->
'off' part, but about how now about half of the function has various
'if (ifs)' tests spread out.

And I think it actually hides what is going on.

If you decide to combine all the "if (ifs)" parts on one side, and
then simplify the end result, you actually end up with a much
easier-to-read function.

I think it ends up looking like this:

  static void iomap_finish_folio_read(struct folio *folio, size_t off,
                  size_t len, int error)
  {
        struct iomap_folio_state *ifs = folio->private;
        bool uptodate = true;
        bool finished = true;

        if (ifs) {
                unsigned long flags;

                spin_lock_irqsave(&ifs->state_lock, flags);

                if (!error)
                        uptodate = ifs_set_range_uptodate(folio, ifs,
off, len);

                ifs->read_bytes_pending -= len;
                finished = !ifs->read_bytes_pending;
                spin_unlock_irqrestore(&ifs->state_lock, flags);
        }

        if (unlikely(error))
                folio_set_error(folio);
        else if (uptodate)
                folio_mark_uptodate(folio);
        if (finished)
                folio_unlock(folio);
  }

but that was just a quick hack-work by me (the above does, for
example, depend on folio_mark_uptodate() not needing the
ifs->state_lock, so the shared parts then got moved out).

I think the above looks a *lot* more legible than having three
different versions of "if (ifs)" spread out in the function, and it
also makes the parts that are actually protected by ifs->state_lock a
lot more obvious.

But again: I looked at your patch, found it very hard to follow, and
then decided to quickly do a "what  happens if I apply the patch and
then try to simplify the result".

I might have made some simplification error. But please give that a look, ok?

              Linus
