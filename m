Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E7173D539
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jun 2023 01:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjFYXSy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Jun 2023 19:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFYXSu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jun 2023 19:18:50 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF3BE48
        for <linux-arch@vger.kernel.org>; Sun, 25 Jun 2023 16:18:49 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b74791c948so550700a34.3
        for <linux-arch@vger.kernel.org>; Sun, 25 Jun 2023 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687735128; x=1690327128;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDL2PKiCA+/rhTNU/RAXiTe/8UXzMDcm38qWTk5tJaQ=;
        b=tu7dW0UyTp0mbURYV03AZvvKUB4EVAEcPqmwPKifx/K6gEigd69ommTY9v5e4nGdRx
         /0otvCAopXVymmCSoHypSyDlf9xa1cF4Kmctg6BScYq6FYWD3JBeImtg6vw3uF1qmWPr
         ReafK4WQwDw0MvGYascISNXIOH3YJzftIe5cHHdtQSYmeu+RO97F22cpndpVWDwvL3hx
         HTQg7aaiwXj5ZcRhLWvILn0XjjqgAkdkibWIlxI5mVQZtEVNWDFKv7tl3qKIltrGD5ja
         8+CvrypKjlJYVZA48SrlVUr31ndK+p9YAsamy6n1kZGIXiCOZh0jFUzwSBBHpbM92Ji0
         cneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687735128; x=1690327128;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDL2PKiCA+/rhTNU/RAXiTe/8UXzMDcm38qWTk5tJaQ=;
        b=RBw/61E1PLlcV7rK0FYiXe9iJXqnyupP2Wv8+3aUp/dThj+Rd8k/dwty944WZmShVD
         MTfIE8Ayk9yJczy2CCU5Wyl8zszQxVTDJ2y8Qay6qX2Dt92avR6g1Y01cDidq/N3TEZ2
         vqTSOdt+4zjHEa6sh3hdk6y9uG96SSBlg7OyrmYCyQjqMpYCMhzhQS7QDx3ldkugLtRs
         QMewXAVt+3kzLOMwZNxeDJyL5gL4PXqDaN8Q6cc5Fwr1nnEwA9TT15Wp5SFp1ON6pZUb
         JR8U8Fb9sSplr/Vmn+jrBfIGX+qw9srOsSRZ9vPsX53aRioSPXjPZ5xLq6Vmg0c04uXu
         tqog==
X-Gm-Message-State: AC+VfDxUvEtMrOsm0riEA1b+2F1flYDDEpxhdSVWkIR/qju+uqM8O+F4
        yeE2Gf+c7wOcJ6o6aQbXZ4wRiLn8o/ijA6x2zok=
X-Google-Smtp-Source: ACHHUZ4/jIK86E2AaG1hAy2VpPXCHPHwDhZQtOvqja6+oaQ8pw774vDwDuHysXGDTibRWjqAJFzsWg==
X-Received: by 2002:a05:6830:14d4:b0:6b4:7292:5a1a with SMTP id t20-20020a05683014d400b006b472925a1amr21628341otq.28.1687735128612;
        Sun, 25 Jun 2023 16:18:48 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id p19-20020a62ab13000000b00678afd48250sm188041pff.218.2023.06.25.16.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 16:18:48 -0700 (PDT)
In-Reply-To: <20230614013018.2168426-1-guoren@kernel.org>
References: <20230614013018.2168426-1-guoren@kernel.org>
Subject: Re: [PATCH -next V13 0/3] riscv: Add independent irq/softirq
 stacks support
Message-Id: <168773507359.1389.408207279075698188.b4-ty@rivosinc.com>
Date:   Sun, 25 Jun 2023 16:17:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        jszhang@kernel.org, bjorn@kernel.org, cleger@rivosinc.com,
        guoren@kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On Tue, 13 Jun 2023 21:30:15 -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> This patch series adds independent irq/softirq stacks to decrease the
> press of the thread stack. Also, add a thread STACK_SIZE config for
> users to adjust the proper size during compile time.
> 
> This patch series belonged to the generic entry, which has been merged
> to for-next now.
> 
> [...]

Applied, thanks!

[1/3] riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
      https://git.kernel.org/palmer/c/163e76cc6ef4
[2/3] riscv: stack: Support HAVE_SOFTIRQ_ON_OWN_STACK
      https://git.kernel.org/palmer/c/dd69d07a5a6c
[3/3] riscv: stack: Add config of thread stack size
      https://git.kernel.org/palmer/c/a7555f6b62e7

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

