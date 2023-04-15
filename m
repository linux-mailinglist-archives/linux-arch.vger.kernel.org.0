Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0616E3457
	for <lists+linux-arch@lfdr.de>; Sun, 16 Apr 2023 00:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDOW5y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Apr 2023 18:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjDOW5x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Apr 2023 18:57:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B357410F0
        for <linux-arch@vger.kernel.org>; Sat, 15 Apr 2023 15:57:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id hg12so7522276pjb.2
        for <linux-arch@vger.kernel.org>; Sat, 15 Apr 2023 15:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1681599471; x=1684191471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jm23euiY98fsN22kiG5rHbRtDdr3VWwy800+EazcFQ=;
        b=GBfLzDMaedtUl6MyPA5MjqwskjXDB8bXlQkls/cGP4aq1jUv7RrRFtXHLwgTEGVidb
         x+yYSroQA1+8wmK2nLvfaVEN3cMOIs5qH3X54gCP+KRH3xJ+4SmDE1grbMoFifyFXlPc
         RI0xSxywOQMml3hnpp2skrtAslxJZk2wR9p79TDktIn6BkkyDaCbEmvvHIRn0QjEWqht
         8eQQirlYYZgBQ/JwhSrlewqOHstVPBpK4duQ8aUnfUE+nLGCySqyLX1g1NOzCO3wSxFa
         jm9ygqNznrgQ9S2/G24r7ngYQJBkMGHFycKgNG88gySGQA40KnO1k13R5U3FnMpOhOD2
         Pi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681599471; x=1684191471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jm23euiY98fsN22kiG5rHbRtDdr3VWwy800+EazcFQ=;
        b=CV/ryGDlp9yZEHzbI+O7IZ8BCeucR8EoJ3FyG+tsxZZYzn0YcmIUrQBpWP4DOtN13O
         6eoXzU6rP7ztNOG6HoFm3UzGgYIo1t9qfeqc6GV88QVeAfShmf4HDcV12tVQYnhecse6
         OIeK2WQQpDnkI2u9tpCrdlx2O4xt7RhKRdh9Tfjj+BRz8NFJjNlgw6kiJyOPr6D7khsa
         NfTyPd+U3ZmuPcELTDRnILK9DZYwoJWJIWjX3yy/wgB+YkISzr6J6vLHvOXKiR3gZ+vk
         W9KAR72tbYkDWlMMIcdBRoz/4IpQm+TOSYBCUICHqFH0G24kzozUWIcUoVHXI2CJuBfd
         CCgQ==
X-Gm-Message-State: AAQBX9d+OOYCOLe38Afc4i7kwMYfnvYnajpzBp/2w7rutgaDfU53RLMh
        OFBuwmfK5GDR9mNryOe7x7DgRQ==
X-Google-Smtp-Source: AKy350atP7YyE1uh5Cv1o1OIAdHqZyYd5TMCJvKCXUcCmogo34GyZWci+oDz1ExgkYU+uGfEZj3q7Q==
X-Received: by 2002:a17:902:d583:b0:1a0:6bd4:ea78 with SMTP id k3-20020a170902d58300b001a06bd4ea78mr7929045plh.31.1681599471180;
        Sat, 15 Apr 2023 15:57:51 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902b48d00b001a68991e1b3sm4801780plr.263.2023.04.15.15.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 15:57:51 -0700 (PDT)
Date:   Sat, 15 Apr 2023 15:57:48 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     david.keisarschm@mail.huji.ac.il
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>, Jason@zx2c4.com,
        keescook@chromium.org, ilay.bahat1@gmail.com, aksecurity@gmail.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 3/3] Replace invocation of weak PRNG
Message-ID: <20230415155748.2c9663a9@hermes.local>
In-Reply-To: <20230415173756.5520-1-david.keisarschm@mail.huji.ac.il>
References: <20230415173756.5520-1-david.keisarschm@mail.huji.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 15 Apr 2023 20:37:53 +0300
david.keisarschm@mail.huji.ac.il wrote:

>  include/uapi/linux/netfilter/xt_connmark.h    |  40 +-
>  include/uapi/linux/netfilter/xt_dscp.h        |  27 +-
>  include/uapi/linux/netfilter/xt_mark.h        |  17 +-
>  include/uapi/linux/netfilter/xt_rateest.h     |  38 +-
>  include/uapi/linux/netfilter/xt_tcpmss.h      |  13 +-
>  include/uapi/linux/netfilter_ipv4/ipt_ecn.h   |  40 +-
>  include/uapi/linux/netfilter_ipv4/ipt_ttl.h   |  14 +-
>  include/uapi/linux/netfilter_ipv6/ip6t_hl.h   |  14 +-
>  net/netfilter/xt_dscp.c                       | 149 ++++---
>  net/netfilter/xt_hl.c                         | 164 +++++---
>  net/netfilter/xt_rateest.c                    | 282 ++++++++-----
>  net/netfilter/xt_tcpmss.c                     | 378 ++++++++++++++----
>  ...Z6.0+pooncelock+pooncelock+pombonce.litmus |  12 +-

NAK
You sucked in some unrelated netfilter stuff.
