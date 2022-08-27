Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9065A38EF
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 18:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiH0Q4x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 12:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiH0Q4v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 12:56:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6A959251
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 09:56:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kk26so8265689ejc.11
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WAEr4zCif0zp++lZAUWZkj4GJhtO7eOsEWQzvmzftQQ=;
        b=Usv9scAAadihgjNYDL+pCD+vdqOGF1X0cWC9MSgKis7DY1nR47sOn/fUFAwpVGARg2
         R28Rkid0Z4bmdsM2qMAaJdSP1ygPFSKxdXwNRtDIYxO/YduZhQYknWZKo4dOrEu2FVgH
         hZLhNoIfLH15LdDClrvelFDdmfGzL5gJ5DcEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WAEr4zCif0zp++lZAUWZkj4GJhtO7eOsEWQzvmzftQQ=;
        b=Pxd6kCleABOSldggMSnqKhNwp53j1fjiU+3ZLx/PTKvJfx9J1IDYpwdaC/OAoidcPI
         EuoVackidRMqJe6xzZCtfXx2m3kH3UiTnHRXmCc5AXG8Taf/IVjLfGzjPKCvKrQ7Ofg7
         PvsPEHJsFq11RUUF7Bi/JoYaud8b9k6qlDWM+mGABafwjfRfpzmkZc5y+yiuNbH1fDvG
         4lk8kbgVbQ6RVlRLi+W+wmUDql8kxO9HItP2XOwMNzZN+64Op0jDdXqPl+TZcMprw4rC
         WsbFLGTXH7qqtQ0rOeKIW1Q9nF2RZRGMG4qaPFXA+3M7hn9cnMC0NkXyL7wL7LcxL4Sp
         gGyw==
X-Gm-Message-State: ACgBeo11ciXRttim/yDl6De1ShADpTnKUAN+tbkQWjc7FxSKIrP0ypa/
        KmVHaUiAfLVmA095zo0RZpugV4KzYfM7AhywpB0=
X-Google-Smtp-Source: AA6agR68l/5iso5/UjxZiGdMZ9JuSTzmfL7tLH9snnTXJE4YFBvf5OC8PKe4IogXmrrTnRqVnVLjag==
X-Received: by 2002:a17:906:cc16:b0:73d:c874:f89e with SMTP id ml22-20020a170906cc1600b0073dc874f89emr8943833ejb.666.1661619409050;
        Sat, 27 Aug 2022 09:56:49 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906498a00b007307c4c8a5dsm2232673eju.58.2022.08.27.09.56.48
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 09:56:48 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id s23so2292293wmj.4
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 09:56:48 -0700 (PDT)
X-Received: by 2002:a05:600c:2195:b0:3a6:b3c:c100 with SMTP id
 e21-20020a05600c219500b003a60b3cc100mr2617660wme.8.1661619061056; Sat, 27 Aug
 2022 09:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
 <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com>
 <CAHk-=wh91FqN2sNSRFZPxfGnqAbJ1o66ew8TXh+neM9hW0xZiA@mail.gmail.com>
 <alpine.LRH.2.02.2208261620210.9648@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=whO2sd233T8AXNMhYztPiF9hae+1ePOX1fEMEu6Ow1CQQ@mail.gmail.com> <alpine.LRH.2.02.2208270720500.18630@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208270720500.18630@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Aug 2022 09:50:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyBQzofeFc1a1d2=HKcrTCLDi_FY+K2NG0R4e-9epqPw@mail.gmail.com>
Message-ID: <CAHk-=whyBQzofeFc1a1d2=HKcrTCLDi_FY+K2NG0R4e-9epqPw@mail.gmail.com>
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

On Sat, Aug 27, 2022 at 4:38 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> I compile-tested this patch on alpha, s390x, m68k, sh, sparc32, sparc64.
> So, you can commit it to close these uncompilable-kernel reports.

Thanks, done.

                Linus
