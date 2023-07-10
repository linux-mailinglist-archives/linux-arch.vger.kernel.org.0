Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FED74CED8
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 09:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjGJHrE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 03:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjGJHrD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 03:47:03 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FEA92
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 00:47:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26307d808a4so3211487a91.1
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2023 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688975222; x=1691567222;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBQz0IOlrvvG27I0CCcV8HFmVTwl6NNK9WzR6JerA6A=;
        b=nl8ecPKLwEV8OvG18s+n2VqRieJ03LeYhN2VXukdYQelprE3vHvfakWdB5PECxppHK
         6D0koYT0d6h1bm/Q8nDcLL/hmLO17hqzBazXE6fK9XFy5CK0Cp9aSe980SYzWkKDTbGc
         L7uPUv2KAsOi0vIRjHv2Lc8XEs3omnUdBw6KVcTqS/xBD79TYEkqrOE1Ag+giNrCsz1p
         lZIvmnaKkaXoLByHxSficQTNvEDXxHQo0Q14ZZx2rwOBcasGweyEbv5LKORF7Ux6Li9I
         QfIS+8MEj+GDrxdIVjFjwryPOd0XjqojOWxJd4rVBWIoGuuMpW1RAjLxgiltxyNowom3
         Ao5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688975222; x=1691567222;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBQz0IOlrvvG27I0CCcV8HFmVTwl6NNK9WzR6JerA6A=;
        b=IUl0cazBtpE+vAFvMZ9tFrct93MKiA0Uy0SCsBoUVLNbxVVQqeAjjhEs7NNS2zLf6z
         3vzEOwUebQijjWAYnCS+t9A+uxnWS8lTVhlljXRgoaLJLcKKpg8e26VG6RjP8Vnntvpf
         IPTmq/NJNrX8FeXogjGyg8ekOouI5OtN1GN2N+RIHJZjJuRG9XCF9KEm67bpf6wC1Oa2
         0ngk4fWovFdVB550egK0IVEfiS5yJxRvwicGU3aJZB6elYmjBYrR57DikkQ0rq01onTW
         g8/SamZl/ahK56/NTK4hzZPpnOKAvcmFrC/w116dHq/s4QaKmUdCq2ANkJ/m9aBE9Ft0
         5KaA==
X-Gm-Message-State: ABy/qLaISeSk9rmcgrF5quYn+SNYI7gkSDPTORn3IYbDhpXsSWqUS1q5
        39v4x9pgAy9damqg94op0PnYtfbPev0YbJZC3zs=
X-Google-Smtp-Source: APBJJlGfcPVY3MO8MtIAMwKg+hgql4At5ONGALGZzieYWAbtDPkx2shna9uiCb7lre4srMIAkmCFb1ckyvCYtp7JOxg=
X-Received: by 2002:a17:90a:448d:b0:263:bc7b:a76d with SMTP id
 t13-20020a17090a448d00b00263bc7ba76dmr12925220pjg.4.1688975222391; Mon, 10
 Jul 2023 00:47:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:8188:b0:d4:ff3c:e811 with HTTP; Mon, 10 Jul 2023
 00:47:01 -0700 (PDT)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <mrdavidkekeli01@gmail.com>
Date:   Mon, 10 Jul 2023 09:47:01 +0200
Message-ID: <CAMsn+iB_ebMvSyEO0xijZPkvFtZrrEug6=i9ZAYTHv5mVVBs_w@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

My Greeting, Did you receive the letter i sent to you.Please answer
me.Regard, Mr.Abraham,
