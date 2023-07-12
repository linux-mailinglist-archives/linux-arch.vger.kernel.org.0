Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D017509C4
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jul 2023 15:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjGLNk4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jul 2023 09:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjGLNk4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jul 2023 09:40:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3224319BC
        for <linux-arch@vger.kernel.org>; Wed, 12 Jul 2023 06:40:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666e64e97e2so3908721b3a.1
        for <linux-arch@vger.kernel.org>; Wed, 12 Jul 2023 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689169254; x=1691761254;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Kqh6fNIY9AJljwrK0e2rNLKBwfhh3ijZgx+ok+fnrI=;
        b=5EEoH9hI3BRpj2k/wZBtzWVgxdQWeCG9MGqEeequWdxBEGrdLj7Fvi2FV7Ph5MuL1s
         x0rQUYf/MUXN4WMG2g9ORlwQpo8h4oK3qBQdyBdGbLd+rL77EqH6G27LcOaHq6E2+g+z
         17McHVpC5lE5vi7aWaxmfSYNman4xCnTDNf22eM1cbCpTik9xPLD54dLEgJs7IyO0t2z
         F/WPkuK8g7m0eAHx6yMATB46qdro5jRbxjAfonFDv9uRNgHq2ln+nxze86OMLdIgAghl
         nZUv6OPqsbrt6t9CPga55Jes0G+j8o9vxSJVOvisc9CGq4FfmI9tDOQXq0/zRyiXQtLt
         61Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689169254; x=1691761254;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Kqh6fNIY9AJljwrK0e2rNLKBwfhh3ijZgx+ok+fnrI=;
        b=T8m3MxbE7kMQS4MR4LmFKmAuhtd5BalZ3aZdejMjkYlS0ZDwZ/z2Rj+oiwh+WCHbBS
         m5OpgSKMSKHTZKIDPuJ76DGuuGqAOxbq5Uyjs9WXX5dnft2eQkxKrrPl71pzcSzzh33O
         LcSnWkKQjngV5ccp+lrp+MhqcBDlez8SNd8gRpUFciQMlFW7s9SGFqsnrszLRKMVoGFr
         /YP7EAHAbCGZXEDx4PL3c9Ov1aUOeHB6eu1nQZSMOBvnwU06w9tqVUYhhmcUyVlcJy1n
         ySx92tqqKcyTIxu3DfUeAsGLU/yCndu4vurD3YtLwTzLZLGtBGHCOd5TOf8xYcSK925/
         U9LQ==
X-Gm-Message-State: ABy/qLb+bhATa3TLTKH69jQGh6i5thlfulg/vKyLPr6B90dS61KbXP3d
        sltJimVmkez6+ilCjbi7IbRVrZjsrenv7qOLScc=
X-Google-Smtp-Source: APBJJlHhCR4FyKSMod5bL33rCVPPYzjI//x+UGhJ4p+/Acc0Ye58uNfbCQ5C1waGuZMXeHcsBSwFVw==
X-Received: by 2002:aa7:88c1:0:b0:682:f529:6d69 with SMTP id k1-20020aa788c1000000b00682f5296d69mr10775524pff.7.1689169254368;
        Wed, 12 Jul 2023 06:40:54 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id c24-20020a62e818000000b0067aea93af40sm3648425pfi.2.2023.07.12.06.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:40:53 -0700 (PDT)
In-Reply-To: <20230628091213.2908149-1-guoren@kernel.org>
References: <20230628091213.2908149-1-guoren@kernel.org>
Subject: Re: [PATCH] riscv: sigcontext: Correct the comment of sigreturn
Message-Id: <168916917326.11308.11157139765378457247.b4-ty@rivosinc.com>
Date:   Wed, 12 Jul 2023 06:39:33 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, guoren@kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On Wed, 28 Jun 2023 05:12:13 -0400, guoren@kernel.org wrote:
> The real-time signals enlarged the sigset_t type, and most architectures
> have changed to using rt_sigreturn as the only way. The riscv is one of
> them, and there is no sys_sigreturn in it. Only some old architecture
> preserved sys_sigreturn as part of the historical burden.
> 
> 

Applied, thanks!

[1/1] riscv: sigcontext: Correct the comment of sigreturn
      https://git.kernel.org/palmer/c/471aba2e4760

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

