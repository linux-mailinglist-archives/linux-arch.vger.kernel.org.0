Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264316444B0
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 14:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiLFNgA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 08:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiLFNfy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 08:35:54 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31962B246
        for <linux-arch@vger.kernel.org>; Tue,  6 Dec 2022 05:35:51 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-381662c78a9so151919917b3.7
        for <linux-arch@vger.kernel.org>; Tue, 06 Dec 2022 05:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=TCK443oiEJFvojnvhbzqc3uMLoscq7n2jFvnlC6zxMliQXUJOSEmIcB7ySZg/5Nswe
         Hbr9Hvsg10w79MmD1YPPp+L1bXs2NIAAAejAsGUI+/UibW3/Q/zLb+6VLxswodO91BIL
         b2zJL5DgCeTBzhHolW3SzYRpEJw6FD7Y62znQalxJ564b8iG8KFAgyLi8iC//4gIZ530
         g0J5MDDRcg3bqblKJ+8SVtykIFIaysjjkxD/XgSghs9/hLQsdawc0uXPBWSgLgVEyytZ
         nAFRuOzxBzzA9s8zv/zUdDm+kitKQJVuM12S4+23kHZAcVx/26fg0JxnmdDNdLuzKaBS
         nisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=1061QD9cCgaK28/rUAo1mtN4qJhQx0qR1GU3mjuxD3f3dCrmqJn206xcHXfHmxMApc
         RkjqLC0fb/2ixC9Fx4ZK+296Zxvuj89B99AxjBjKxGMuEXv6Sq+1mE3K/jc8plUmxpr0
         qAD07pt8o3mDxdLQHDrMPAyZlPkOeQqNCPHtz516yMttQkLfLmAU/WvVa+zex70pVCYc
         Tg3VKzjxjHv3II14Se9xUApDEfDBf3vMIuUZbRUWeUK5y13pzAaoE24LWMoeyJuAb0hU
         4ABayD7BqYdp68+KXTbidODBrixCk01iJ90Wy1rbBIipSeF4rOv6Vt6vY0r/bS9NbaVS
         Yw6g==
X-Gm-Message-State: ANoB5pmu/o3tAFufUROTFwI8HNU5mTMmQVdUhHdil8QUwxUfty/Xf8rL
        RMLoSE08GQQb/zSA7kNlbZjFrXBH98nI6uW+8Zk=
X-Google-Smtp-Source: AA0mqf7PeQ6MX4rXU0c5RBrAC8mWU0XIcPU5wXJ9ovfjUldkzuZzqBzDkJDKDyAUOkQSTG8CriEXwDPaJjIZfMoc63s=
X-Received: by 2002:a0d:cad7:0:b0:360:65a3:46c with SMTP id
 m206-20020a0dcad7000000b0036065a3046cmr1297350ywd.119.1670333751094; Tue, 06
 Dec 2022 05:35:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a205:b0:314:d2a3:70a with HTTP; Tue, 6 Dec 2022
 05:35:50 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <mrkojofofone01@gmail.com>
Date:   Tue, 6 Dec 2022 13:35:50 +0000
Message-ID: <CACJtp8s5dnnJ0WK9eKtMtoiSithTta4FV2iCzTtQdcgQsoKQrA@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
