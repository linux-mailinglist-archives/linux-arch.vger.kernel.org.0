Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2824DBB05
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 00:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344975AbiCPX3k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 19:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343911AbiCPX3k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 19:29:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A29167C4
        for <linux-arch@vger.kernel.org>; Wed, 16 Mar 2022 16:28:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id kx13-20020a17090b228d00b001c6715c9847so1662766pjb.1
        for <linux-arch@vger.kernel.org>; Wed, 16 Mar 2022 16:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=G2OlpynL+svPG/qBCVApCbgh8fee1f/XrsL4DL/Bf0Q=;
        b=OtaZ9yqhWB4tye3HNb/4HSG53Ngt9PyiVKbt4tKiDRePwVvwEya9svqm2s5w3VOs8/
         yc5YXBiYJ5lI37j7IwRDhHc86YnavSlVsh0QAtvZb4djSLS4+IhqRPG1UroOa6lAYHr2
         MmdFeBcb5MqiiXN9c0cZAnTi3wMI/B1Z3iSzCUEZVZYrwPOrXxRi/ycPnKNM2hdrjT1d
         ie9NE6P8P/kdLZ/hzrBMaChScpMTxQMof4mqs0RbevtIK7WFu960AcDmPUpRF2qSwADe
         J1d0UjMM8OCE0iWgumuCsMKONO032+3frQbABHiQ0inzP7hO/d2ZcCst7FmOhhFQK3zm
         GXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=G2OlpynL+svPG/qBCVApCbgh8fee1f/XrsL4DL/Bf0Q=;
        b=DTcKmotojsh3gESECSfB5Qaxhn59yVTlrWHug7bcbxMJXBx3yAdDwZWAeTgpgryWPv
         BxrVWL5FHrR9v4swjYey1O1ccvYNdNeTcPQDcqS6Si6oV+q9gXi4oovdNBDCxaBSHnhh
         x2alANShnbOTg/eVtYmcAaq+SnRgWnYuI2k5fpgN3qoVpkpXR5S9AhBEfEqxE4yr7mUm
         CpQ8uR3sFt3Ktg7574MJsfweHch+0szQ8A6hR4tKB+aZ8BN6n+8Orr/Of5R9+X0R5O3k
         hx6tnxfs51jXHoGB5eW6nLYfqJlMBKywa/UcT9iDmxFB7hrLvzsqv4Kh+18DI0nsptcq
         AATQ==
X-Gm-Message-State: AOAM5307TxKWVsHQQ1p8ecXAZ87U6PYfiLGklcUh7AI+JKpi4HGOzFvr
        4lXiBaTqUKaQsWOXHP8zNC6Dug==
X-Google-Smtp-Source: ABdhPJwvtB81UtChoOLXVE+LBbgrtmta/Nk4/MhmrLCtsDTPfNUpp+6kUErqrPWaxRw1IuW1/C269Q==
X-Received: by 2002:a17:90a:4306:b0:1b9:80b3:7a3d with SMTP id q6-20020a17090a430600b001b980b37a3dmr12666080pjg.66.1647473304308;
        Wed, 16 Mar 2022 16:28:24 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id i187-20020a626dc4000000b004f6e0f346e7sm4189585pfc.39.2022.03.16.16.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 16:28:23 -0700 (PDT)
Subject: [PATCH 0/5] Generic Ticket Spinlocks
Date:   Wed, 16 Mar 2022 16:25:55 -0700
Message-Id: <20220316232600.20419-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, mingo@redhat.com, Will Deacon <will@kernel.org>,
        longman@redhat.com, boqun.feng@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org, peterz@infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Peter sent an RFC out about a year ago
<https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>,
but after a spirited discussion it looks like we lost track of things.
IIRC there was broad consensus on this being the way to go, but there
was a lot of discussion so I wasn't sure.  Given that it's been a year,
I figured it'd be best to just send this out again formatted a bit more
explicitly as a patch.

This has had almost no testing (just a build test on RISC-V defconfig),
but I wanted to send it out largely as-is because I didn't have a SOB
from Peter on the code.  I had sent around something sort of similar in
spirit, but this looks completely re-written.  Just to play it safe I
wanted to send out almost exactly as it was posted.  I'd probably rename
this tspinlock and tspinlock_types, as the mis-match kind of makes my
eyes go funny, but I don't really care that much.  I'll also go through
the other ports and see if there's any more candidates, I seem to
remember there having been more than just OpenRISC but it's been a
while.

I'm in no big rush for this and given the complex HW dependencies I
think it's best to target it for 5.19, that'd give us a full merge
window for folks to test/benchmark it on their systems to make sure it's
OK.  RISC-V has a forward progress guarantee so we should be safe, but
these can always trip things up.
