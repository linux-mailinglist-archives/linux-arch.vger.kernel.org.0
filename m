Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61555A3050
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 22:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344556AbiHZUHr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 16:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbiHZUHq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 16:07:46 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEC896FD7
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 13:07:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb36so5079081ejc.10
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5uVZvH0WBz/SiP6nDdXQ7fNSiMZNJF3T+BwdwEHBsbs=;
        b=Q/cENHnXRHQfPHNlmHyDlTvWdskTaGpvXdx0YnDNLNS/0RX8WPb1jR5KgVLVBJcIU7
         CSIyrv1NiJyoL5ax12gNIDW8tYBDTItBrtCw3Zl97Jwccpq1Ui0p68Ku4B3uDzrqFg8v
         uNufxLhtMvXsQPswhXy+3+QAszhCgZrLluj6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5uVZvH0WBz/SiP6nDdXQ7fNSiMZNJF3T+BwdwEHBsbs=;
        b=iwlVvKr0mA2++NylAzMZtxOul+CGzMoTWWk34qoFT67NjIvpAVqA9u0PRNRn68zNlF
         dojjJ2RYNPXhXSii9StKs3YNbOhXndq4bHmEjd1MhpHDsdcNLTNnj8kBjp13qqWGQip7
         9mT/7mYk5r0F+K28ET+xRgqMyJNWytCBrJ83H4phWRu2iSNBZwazNXtpbNog2AqXEI68
         OPGrfgC42cr0Csc6IaCNM5LBCcVC85CGCVFC9NqtSeQSdevzD96B/Wou6FXvbNTIyO7X
         /TgrOw0o9KpfzhzNO1NqGRPdxMGsfJcvHJwOl+3GhniwXj3NH6zt7XQY6oyGYvgA/lRF
         73Uw==
X-Gm-Message-State: ACgBeo1YmMABfYAM2sg5dKG+xtUMpeXHgcI3+GMyQSr1L110OC1qu8Ds
        BxCn5N3Pe8YOU+V3t+a0P6SOv7yYUIvU114LWDk=
X-Google-Smtp-Source: AA6agR4cptY/4YzOjwbxWycdOZWLG3P0jgTS1db5fmnZ8dbBXP44R9P6WdLtUZv56LCA8+q0uhY1eQ==
X-Received: by 2002:a17:907:9693:b0:73d:cc84:deb with SMTP id hd19-20020a170907969300b0073dcc840debmr6328559ejc.552.1661544463440;
        Fri, 26 Aug 2022 13:07:43 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id n7-20020a50cc47000000b00447bf35685csm1732597edi.60.2022.08.26.13.07.40
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 13:07:41 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id bu22so2661366wrb.3
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 13:07:40 -0700 (PDT)
X-Received: by 2002:a5d:4052:0:b0:225:8b55:67fd with SMTP id
 w18-20020a5d4052000000b002258b5567fdmr637361wrp.281.1661544460541; Fri, 26
 Aug 2022 13:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
 <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com> <alpine.LRH.2.02.2208261550380.6969@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208261550380.6969@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 13:07:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCN6moKefrRBECCon6675vh=6+yWGu0N5zu7G5eGh+wg@mail.gmail.com>
Message-ID: <CAHk-=wgCN6moKefrRBECCon6675vh=6+yWGu0N5zu7G5eGh+wg@mail.gmail.com>
Subject: Re: [PATCH] provide arch_test_bit_acquire for architectures that
 define test_bit
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
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

[ Crossed emails ]

On Fri, Aug 26, 2022 at 1:03 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> +static __always_inline bool
> +arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
> +{
> +       unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +       return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
> +}
> +

I'd suggest you just do

  #define arch_test_bit_acquire generic_test_bit_acquire

in each of these files, instead of duplicating that function over and
over again..

Because the generic version always exists, since it comes from
generic-non-atomic.h, which is included directly from
<linux/bitops.h>.

                  Linus
