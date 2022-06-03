Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2AC53C96F
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 13:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244115AbiFCLdQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 07:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244040AbiFCLdL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 07:33:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0703C733
        for <linux-arch@vger.kernel.org>; Fri,  3 Jun 2022 04:33:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h5so10082304wrb.0
        for <linux-arch@vger.kernel.org>; Fri, 03 Jun 2022 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=PaEzrm9U0WjJMxkE+zbw8yGRv0uhjcRl9sFl9vmbKpk=;
        b=jd2M5ci6kw29Z5Ep1D/Fy3EfjZBMjGFL0gAHqOijXroWbariraQkgVFGD+Zq1Ffq+3
         HBHb7yuNTC6AHAOS9skKngRDHJttP0hygfDHYAJWWAb/sbIX46Quf4mG3/T7I4lWleu7
         XCmURv9OmyhHMdSfi6ceoBXmASCqI6qF/4MJriQFPmbZpAL6fwsQToRCu14lfPh8CzrL
         vJyaubiYBwsTy+48OLKu/UF68tGv/tccbefw3b788NAtofCai6tMPdORyLsjpS3Ag07c
         I8d6+vK8u5vSHVnW+x1YH4GgA8isyPkq4Xu8zp0o4uLowOH329uLrNakW6TcLlzWilOV
         0yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=PaEzrm9U0WjJMxkE+zbw8yGRv0uhjcRl9sFl9vmbKpk=;
        b=1soew7BIb9uCKTUnfRJjaCe3a0uBTwrKENmNVsr0n4G4BVY/aBjNmFgpx33NgGx06e
         VnAP+ADYlXSX6VWQI/XvHjndE3eldda38/8eNHNtJwGBpVLy32z6258wUZEipOw3SeW7
         ENjIwY38yyk8AswK+gYnzNbNQ8weT+QVzYEpIIc/MUNp3rPTJSksDzuBM3JIJ9Zhkpyx
         s5a2edK2AqBwwmfhgmpsEyYG6OKmDhfKA4FBJRCYz+goONsiPoEuCO1r00uHEvskvb6Z
         tBx7qnXgdW37NpXVZ9HQUItiYtMAUtHzd4+V7N85tmKpwyPJDaMXTz0TzfxWhAfpA8l7
         cpYQ==
X-Gm-Message-State: AOAM530CNKfV8Y/79O1E0TT7TxSpEtkXLOwKmZZdwoWMlsNb3XAmvrGS
        Ym/Sf8SE886pH86SVsqvOcP4IUbZLbsAAq0O3GQ=
X-Google-Smtp-Source: ABdhPJzRVgFo2R9R0SFZzg3zzjIJIEWKnY3FH3aUkXX4RvwEXgOAVQHQPXOBe+HAkyYrZ3oIkGvL2YY6j8Kf1a2qQb0=
X-Received: by 2002:a05:6000:1f89:b0:210:552a:644c with SMTP id
 bw9-20020a0560001f8900b00210552a644cmr7583573wrb.667.1654255979750; Fri, 03
 Jun 2022 04:32:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:64ed:0:0:0:0:0 with HTTP; Fri, 3 Jun 2022 04:32:58 -0700 (PDT)
Reply-To: markwillima00@gmail.com
From:   Mark <mariamabdul888@gmail.com>
Date:   Fri, 3 Jun 2022 04:32:58 -0700
Message-ID: <CAP9xyD1jdj5ift2Tq-tPU4g8vGaYyZJGAFwyP1O1Bkdve=SVTQ@mail.gmail.com>
Subject: Re: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

Good day,

The HSBC Bank is a financial institution in United Kingdom. We
promotes long-term,sustainable and broad-based economic growth in
developing and emerging countries by providing financial support like
loans and investment to large, small and
medium-sized companies (SMEs) as well as fast-growing enterprises
which in turn helps to create secure and permanent jobs and reduce
poverty.

If you need fund to promotes your business, project(Project Funding),
Loan, planning, budgeting and expansion of your business(s) , do not
hesitate to indicate your interest as we are here to serve you better
by granting your request.


Thank you
Mr:Mark
