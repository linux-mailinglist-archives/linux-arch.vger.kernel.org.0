Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709615BB559
	for <lists+linux-arch@lfdr.de>; Sat, 17 Sep 2022 03:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiIQBcW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 21:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiIQBcU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 21:32:20 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2737BD0B8
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 18:32:16 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t62so8145604oie.10
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 18:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BlVQwXVfr3GW5iAF6OT2YMTv6rkyyGCnSP6Ag3jREYU=;
        b=KP+HNwDETUuPHLPcIapFdjnoF2cUScO3YXyr8jfUFet6LzZxXtjL1a9d5PDo4/pRYG
         8cdGuQDun45WLXn09gwMq4miu1+Wfmgf5C10SUtvLKiJylwDvbIGKFfHpydRHY1XlmjD
         K4Snl08qVjp19NDbWD0K/wYGVVR1PRdZuW+4u8dKOKo0+G8pjFNiQTGPC2jjurepOjQF
         0h7kbUTkGqbz423D0olnF+OATvKeTZ5SJqIjxYUKnpRtOf56nC+x1rkBSPExdpc5gZJd
         6oQk/O20nbHyGdOFiiLUJZ3EifAF3rSX6cXNMFIQ59Xp/X2vjnv6yz5HBLZd4clS878g
         ZD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BlVQwXVfr3GW5iAF6OT2YMTv6rkyyGCnSP6Ag3jREYU=;
        b=odlhdYDHDeU09ztEAzm6V7Pr3bk+QLem+Rdcx/Yr5OHBnSf3++zY+QurCusR8Avo+g
         3L2X27g+5sN+SDKf+f77hceSoZJaSvHECvHXFypB7w6c+raUyA1AhA0Ex+X43+QNEkws
         0bhUnAky54a0QoomggDnbxCdsdmQDNBeJD8n4XiYi3ufG6cUmKFJEfPIEhpUBCpMVDVs
         TMGBn0/JbrPm9/+QKUUyaEfqIY3oz3sdFO1JngKOoXUCopsVIWrg4syRYBNjWQG9jhWP
         XkcSkK+nBcsd2jG6ggiZkpyBF4/AiFtGd4ietdCvAORlilijP/tSzG7U17iNgt4zB6uv
         5VQA==
X-Gm-Message-State: ACrzQf31xTGzWrIZy52NphliP+sEpzpfAzZB6FkMHn65RhQvotODh7e9
        XACVVs29uzjwweltz4OVGiOtykloIAw92KdeZuS1gg==
X-Google-Smtp-Source: AMsMyM4JyQBf2phyIkZLp3fghM4p+hZVmExpKQsnCaRgJb+PYCFIowVBZpaDctVfmjLRm5A0Bg40Mqp40BiGc6ovbTk=
X-Received: by 2002:a05:6808:49:b0:350:77ce:3368 with SMTP id
 v9-20020a056808004900b0035077ce3368mr956893oic.195.1663378336284; Fri, 16 Sep
 2022 18:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220916103817.9490-1-guoren@kernel.org> <20220916103817.9490-2-guoren@kernel.org>
In-Reply-To: <20220916103817.9490-2-guoren@kernel.org>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Sat, 17 Sep 2022 02:32:01 +0100
Message-ID: <CABgGipWdm+-pOrj-ROR8fsVO7JEr4m64z7+zNW1_NszW74e5SA@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: ftrace: Fixup panic by disabling preemption
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, rostedt@goodmis.org,
        greentime.hu@sifive.com, zong.li@sifive.com, jrtc27@jrtc27.com,
        mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Yes, by disabling preemption and ensuring all sub-functions called by
the busy waiting loop of stop_machine, which happens to be true on
non-preemptive kernels, solve the problem from the original
implementation.

Andy Chiu <andy.chiu@sifive.com>
