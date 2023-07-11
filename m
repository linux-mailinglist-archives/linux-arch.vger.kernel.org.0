Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF54374F9BD
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 23:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjGKVae (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 17:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGKVad (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 17:30:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732D5E77
        for <linux-arch@vger.kernel.org>; Tue, 11 Jul 2023 14:30:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso9840845ad.2
        for <linux-arch@vger.kernel.org>; Tue, 11 Jul 2023 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689111032; x=1691703032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vppmwRRbyi5GVcqEuzCwPvW7VSP+pm8Knc+bGCD6gFQ=;
        b=juHvMnq0uCdj1HrRrOHCtvwCA9TetWPKCCAqRCWccouGKKaqd02BVbQ7UQ36p5PJt5
         iv7CfkmNlhEj7Bgo8J/R+bjVipGnHcitAhpid5NVPXlIMYXs0xfCSMhiil55sQ2gx1FY
         6PX1x5/5QqPiZLJITUBToOOzNPzNKyvODmJjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689111032; x=1691703032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vppmwRRbyi5GVcqEuzCwPvW7VSP+pm8Knc+bGCD6gFQ=;
        b=jxpmVJMgqYA3AmtXYLYPmhAeLKgEJLakzDPGKwzUgcP8tIHWALAVUsgshjIOgVoc1E
         VsoAPyI8bCjrU+8PlEEPd+GS/IL6BXoMSK3fswNAlpU8yOzc6altVQmCYwBcaZ7T1TbP
         EjugMUzi2xBkczCLeaavW9ome91KHTVOhhLlmYRLWnydMhaWtwxiZsR/FG7/9E7U8Rd5
         JtOJ3xl226cWhnv3ZtSzKNpBfAimmf0Tes2I9FbLnbBcUzJ4KC/Lqv5VqS89kuuvM9Pb
         K8B37C9nKyx2qamgb3zQFEkjTqlIRmSQY8uvUTkwFWVr3pcAWeMGGpHEnA3GFme9bd5/
         hxxw==
X-Gm-Message-State: ABy/qLa2YJZss/NvVqoFuEGMIHHwrn9DGauXULzi0Zh9p9BVkuaHHxMa
        tKrniSSYHoMR4WGZcaYwTsKDvQ==
X-Google-Smtp-Source: APBJJlFyso7NqCnY006Lit+lDEdWaICt+E2jnc/okglEaclfY4HCJ6PPxwcl4jkaSABEJ7oX78F+Kw==
X-Received: by 2002:a17:902:da89:b0:1b8:5541:9d5b with SMTP id j9-20020a170902da8900b001b855419d5bmr14314325plx.17.1689111031869;
        Tue, 11 Jul 2023 14:30:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b9c5e07bc3sm43847plw.238.2023.07.11.14.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:30:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     arnd@arndb.de, Petr Pavlu <petr.pavlu@suse.com>
Cc:     Kees Cook <keescook@chromium.org>, will@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmlinux.lds.h: Remove a reference to no longer used sections .text..refcount
Date:   Tue, 11 Jul 2023 14:30:22 -0700
Message-Id: <168911102014.3161793.10168759191370577926.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711125054.9000-1-petr.pavlu@suse.com>
References: <20230711125054.9000-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On Tue, 11 Jul 2023 14:50:54 +0200, Petr Pavlu wrote:
> Sections .text..refcount were previously used to hold an error path code
> for fast refcount overflow protection on x86, see commit 7a46ec0e2f48
> ("locking/refcounts, x86/asm: Implement fast refcount overflow
> protection") and commit 564c9cc84e2a ("locking/refcounts, x86/asm: Use
> unique .text section for refcount exceptions").
> 
> The code was replaced and removed in commit fb041bb7c0a9
> ("locking/refcount: Consolidate implementations of refcount_t") and no
> sections .text..refcount are present since then.
> 
> [...]

Applied, thanks!

[1/1] vmlinux.lds.h: Remove a reference to no longer used sections .text..refcount
      https://git.kernel.org/kees/c/5fc522485598

Best regards,
-- 
Kees Cook

