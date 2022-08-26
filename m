Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA85A327B
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 01:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiHZXS4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 19:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiHZXSz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 19:18:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914FADFB7B
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 16:18:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b16so3814707edd.4
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=a3WYMeaYaKAXqi2vNnTDqTlRNok0/Jvq98Wuc+dfeDo=;
        b=HEiGlMlGQUJaVg6lEvjGY+FKjsfHMo57rRYGePuvlcz/0r2RbwWl9AtQ0dGbw3JwQF
         3nm0V4DsSpmJ1F/Qb1N3WOegj48Mjuee1S0ycHZCQsGeThmAHohlwZ89qr/K5ZO79OUZ
         SfLgX1wpW84KIwtOyBasYRFkKxE4seAGCIO8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=a3WYMeaYaKAXqi2vNnTDqTlRNok0/Jvq98Wuc+dfeDo=;
        b=55wXxOkepjVppdzi3M0CXbMpKuw8ZNLczMR/WY/Ej9tlor89E3JqR1gRt9tFYknHu+
         RyWQVr4P+iMGYN8IkbGnfTNo/D3WQCrnKuqcoSr8weFYFUAFjduwYuVROKsbI64f/mu0
         tw1mRGUSR2r7SJOst/630gBeLQiKUZKSgZq+DgpzsjmMlr9hL3Ukwk5pozXlFYjiB3l4
         453ZwUnoDKmfJaHsKBX4DM4XMCociUvd0f3baECcZdsnukBkTzufgA7YKqMhWoyf7V7d
         ObTiKf94Iai6Tmf9mgYGLYiWNkkRFyaW2k2EDYsPQsfooOkwZkSqtHrno3VT6MhVN0nh
         iSug==
X-Gm-Message-State: ACgBeo3N4OP6SqMTb5hBlqs2zicKs6OhXWk19troi3x38//kJ7ktIIcx
        CHhMLiyfZLptNq2v/TPp+t2aVpzHCrNg40MIvCI=
X-Google-Smtp-Source: AA6agR7sTurIJTZr6e7++Lpz08gdx6WeXjax3xXCKDWtzCoChA1awThTqEImjlBP09SZ0uJNB1dd5g==
X-Received: by 2002:a05:6402:5193:b0:43e:1d52:fd70 with SMTP id q19-20020a056402519300b0043e1d52fd70mr8323689edd.150.1661555932904;
        Fri, 26 Aug 2022 16:18:52 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id g24-20020a50d0d8000000b0044786c2c5c1sm1962814edf.3.2022.08.26.16.18.52
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 16:18:52 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso1545559wmr.3
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 16:18:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:3a6:28:bc59 with SMTP id
 g14-20020a05600c4ece00b003a60028bc59mr923809wmq.154.1661555931704; Fri, 26
 Aug 2022 16:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
 <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com>
 <CAHk-=wh91FqN2sNSRFZPxfGnqAbJ1o66ew8TXh+neM9hW0xZiA@mail.gmail.com>
 <alpine.LRH.2.02.2208261620210.9648@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=whO2sd233T8AXNMhYztPiF9hae+1ePOX1fEMEu6Ow1CQQ@mail.gmail.com>
In-Reply-To: <CAHk-=whO2sd233T8AXNMhYztPiF9hae+1ePOX1fEMEu6Ow1CQQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 16:18:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+vA+V_vYjC7gcy2mEJhwp6VB8u_RCizAF4rmH0TZb2A@mail.gmail.com>
Message-ID: <CAHk-=wi+vA+V_vYjC7gcy2mEJhwp6VB8u_RCizAF4rmH0TZb2A@mail.gmail.com>
Subject: Re: [PATCH] provide arch_test_bit_acquire for architectures that
 define test_bit
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 4:10 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Looks good to me, except I'd just do
>
> #define arch_test_bit_acquire arch_test_bit
>
> on hexagon rather than duplicate that function.

Oh, except you didn't quite duplicate it, you added the "memory"
clober to it to make sure it's ordered.

Which looks correct to me, even if the "almost entirely duplicated" is
a bit annoying.

                   Linus
