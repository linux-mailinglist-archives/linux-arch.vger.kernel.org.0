Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789C179104A
	for <lists+linux-arch@lfdr.de>; Mon,  4 Sep 2023 05:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351229AbjIDDSR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 23:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjIDDSR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 23:18:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83FA103
        for <linux-arch@vger.kernel.org>; Sun,  3 Sep 2023 20:18:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so3943288a12.0
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 20:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693797492; x=1694402292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRiIbAFg9Tz0ie5BKjJ3bgiyNx9YoHAeVLR3Pw+mO9w=;
        b=dIPlkmCz0F5zNX/tRpeEC/4t7L2pfB2AnErHazb63A5trEhd1OluiwyXjG3dx+xZ0N
         hhasWg0Gzky7//3OJGIZRj/fgJpxlMhjwktmV540sA73n1zS2AFKK1gEqXDTx0LH3/qT
         0/k8bI6/mMgPOQ9kUS9kiWxYsVZBSDXqh0QtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693797492; x=1694402292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRiIbAFg9Tz0ie5BKjJ3bgiyNx9YoHAeVLR3Pw+mO9w=;
        b=P6JQCLtNn/s45entxko7SuqMEpphT7n1rqlL/xJ7GDHzSI/dPp5+3H50T5eghnUos3
         7eI7VYUg+JxTnBJQW63/dislmIbGt9+SyxiZCJSZnq2lNsZmJCBrfW7dR3Z3CwyZAanL
         tXEaIsRvQPtdPtD9QXXRWdxIT0nEjAsK6x9GDIyJpssAxfLnj+VmA4wOZyRUZQ3lPrnR
         FXxjUTNx/ict/ulbrDHkBrY/Pi42vsg5GGPJdZ0v+GAfLJ91sk3FpC7iFmWj9Q7N1aXT
         TRz+tC1IdeMk39ylWr18tQy5e5MPwRAqb1Iy/DdE7QCj1zGf0GtyzOZz/SpN/frbmYJd
         wNDQ==
X-Gm-Message-State: AOJu0YxCpRMscDSxnDhP/J7PxEtk1522IvNKyp39SOdbpIutpeDba2eS
        JRNVmxuA9J1Vr8T0Yt6/BXXO8ia08Nh42qOlL9SEoGi6
X-Google-Smtp-Source: AGHT+IHSzH6GbcLJo/u43yth4v1htIrahpD+LlJWaeHsQUeRpIdG6eexKCJ+9dXwOg6w+jxnf06j6w==
X-Received: by 2002:a05:6402:50cb:b0:525:4d74:be8c with SMTP id h11-20020a05640250cb00b005254d74be8cmr13253956edb.14.1693797491807;
        Sun, 03 Sep 2023 20:18:11 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id w4-20020aa7da44000000b0052241b8fd0bsm5206852eds.29.2023.09.03.20.18.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 20:18:11 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99c93638322so207598966b.1
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 20:18:10 -0700 (PDT)
X-Received: by 2002:a17:906:5d0f:b0:9a5:a7cd:1f02 with SMTP id
 g15-20020a1709065d0f00b009a5a7cd1f02mr13692231ejt.13.1693797490682; Sun, 03
 Sep 2023 20:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com> <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
 <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com> <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
In-Reply-To: <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 20:17:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnEF7-+DL+71wVgnJG1xjeHAQjzqMAULgQq_uhWfP0ZA@mail.gmail.com>
Message-ID: <CAHk-=whnEF7-+DL+71wVgnJG1xjeHAQjzqMAULgQq_uhWfP0ZA@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 3 Sept 2023 at 20:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Try it and you'll see it is not even *remotely* as easy as you claim.
> Not when you have to deal with random sizes and padding of 20+
> different architectures.

Perhaps more importantly, nobody actually seems to have the energy to care.

As shown by the fact that even the current really simple "just define
INIT_STRUCT_STAT_PADDING to avoid a pointless memset in a hot path"
has been taken up by exactly zero other architectures than x86.

I wasn't going to fight that kind of history of apathy.

              Linus
