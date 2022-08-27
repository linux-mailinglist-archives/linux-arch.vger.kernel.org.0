Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7D5A3915
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiH0RDe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 13:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiH0RDd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 13:03:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC90255AC
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 10:03:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b16so5521307edd.4
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rRDti8pG5KQhB9aQRg3hhb8VtLpSc2P6R68v5/WJ7bA=;
        b=fZrwq1K/4KC18yPfoKnLiFQb9JiKd8RuKuMcF0++26zFG1xldWwkxC7D3GluruvgS7
         EEsixWQ/CLV8XthQXHxUVNJH2QWxAGoV6o8GvRcG5g36PyXM4yoJj9IdVd6YQnFW2daA
         FV4no7gR7FsbzmjcNWHJzFVyEUwwjZ5OVkjEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rRDti8pG5KQhB9aQRg3hhb8VtLpSc2P6R68v5/WJ7bA=;
        b=jYof6fwIg9leVJ8daiPi6KHOw5XSBI0V+j+KK3WWWbSm7a6bSbgIMB4YooExiXapUj
         Tcht3fz1wIUZTUQo0JK6Mp3Uc9RXua3HFYFQNgjJ+p7Zk1LMbEEMDUtYCrVWk37bE92V
         SBbxkZilT5hk4lsCjmHqL9+yuS1+V0toSfcYstSohVmP85noMy5629/ESoNwKD6yAKbl
         NQaB9gP49knyS6AXHV5N8rWA60V4/Nrze1stcYhsxCE4xmJ3D1FR/HXuSFQAdTv+2Li/
         ByFO+nrtHpGEfuOCU4+vakhgBp7a0afDJffJ2ELcu73m3Y1vQ5dZlUjdfAOIDWohVNxe
         8Www==
X-Gm-Message-State: ACgBeo3Mqt66mgpzvGTa4KTcttVvmtNJIKydpiTW+SloxbGAuksYSkLe
        Vffp2vrBZd4M90pAz4/7cLELzVFhDf/7o5VTqbU=
X-Google-Smtp-Source: AA6agR65srPlX9w9Dl8DwzBgNOMQ4i2y83pHlvr+ITLSUyBBt/LXO7+qj5u0HuxrLMmvcw/ZeDYbkQ==
X-Received: by 2002:a05:6402:538a:b0:43a:298e:bc2b with SMTP id ew10-20020a056402538a00b0043a298ebc2bmr10515934edb.125.1661619809576;
        Sat, 27 Aug 2022 10:03:29 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id h5-20020a50cdc5000000b0043b986751a7sm3031418edj.41.2022.08.27.10.03.28
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 10:03:28 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id n17so5260301wrm.4
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 10:03:28 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr2570178wrv.97.1661619808375; Sat, 27 Aug
 2022 10:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <YwniL0M7Rxz8lua+@debian>
In-Reply-To: <YwniL0M7Rxz8lua+@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Aug 2022 10:03:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjY6WuwQ3CSP1GDutLQ4GiQNE1FBms3hBO1PZDB_uwOcg@mail.gmail.com>
Message-ID: <CAHk-=wjY6WuwQ3CSP1GDutLQ4GiQNE1FBms3hBO1PZDB_uwOcg@mail.gmail.com>
Subject: Re: mainline build failure due to 8238b4579866 ("wait_on_bit: add an
 acquire memory barrier")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Aug 27, 2022 at 2:21 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> I will be happy to test any patch or provide any extra log if needed.

This should now be fixed by commit d6ffe6067a54 ("provide
arch_test_bit_acquire for architectures that define test_bit").

                 Linus
