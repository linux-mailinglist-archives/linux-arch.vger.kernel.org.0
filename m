Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2810E589563
	for <lists+linux-arch@lfdr.de>; Thu,  4 Aug 2022 02:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbiHDAkG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 20:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbiHDAkF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 20:40:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7229C5C358
        for <linux-arch@vger.kernel.org>; Wed,  3 Aug 2022 17:40:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so3927099pjl.0
        for <linux-arch@vger.kernel.org>; Wed, 03 Aug 2022 17:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=jvKWTVIxcauh9PFk41tQ+LyMLwxAATFaP9MhP7PSwT8=;
        b=bYgsxccATxr5gR70WihR7eSZ+FddLWnPtqWukNcii1SubcxY9or8IkShvtxnkxFPWL
         jsyFc5+7CD5VErCGJZg/Ayjp51iFzoOaL43FTkZtSP99CX/5h6/370/w9+uEdSQHv2lC
         ZVXmAQ1Ez9olfEoxq/FlnbA4wAvW6ItqIXqVNuYuRDtKy1MXlbYUvrFtFjkdA9WlwGEB
         CnKQOO8MxsHAKeUJm8nFfK3GFkoRbiRL1ZBmQ6x+mqNtAxiRmvz2pR+PTiBlX6Kz7Aay
         XGZaUkHqeBCF2GK/YKsR6uFlpySA0VAVCepBbobvJuEbs5EdBfFg8UyUfR14qhz+B382
         OzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=jvKWTVIxcauh9PFk41tQ+LyMLwxAATFaP9MhP7PSwT8=;
        b=BzHs8g6SbrjGv9ksj5Quf0WdlkEVN0f2WLvVWGFvUsEoxH3X5bSA5YlO/iRDimiG7O
         o4VB9URBVJjE0To2s5Zj9z2sB7sWU8mXk/y3pV3j28bmt2XJ+fS7cWE4Y3sUGUf47T3a
         q1l/gEc38AwVjIhSz22vVxoyw4Aki/9NSaYsweKSfYACQBJDfeqgLQkrpZh6FozPZu/s
         4E8MHvfe9r2Oj3Zx9XVM2XU6989uUc/ynzX5725fw/TYswgVdQrEwb+dKg41ybaK6HGA
         evjFC3RMowPRF86ivgVSiRId5wAk7o8T3539Wp4/ZISdEAGUjJLosJRRS9rE7MJdg9YG
         gqlg==
X-Gm-Message-State: ACgBeo2WyvA/uWH0I3NkFMU+k5ti/b3mR1WW4zNeSwe8kKjvYVr+M3t6
        DrX89EM3YYwIuFQ4U7vpQk5I6g==
X-Google-Smtp-Source: AA6agR7qe/jIK8QLsJ/+BcJEqvmad1YhMJZyrA8YpWoICly0GeGVlRrQWb5n9vnPqpMYWzFm9R3/tg==
X-Received: by 2002:a17:902:e750:b0:16f:3f32:6f5c with SMTP id p16-20020a170902e75000b0016f3f326f5cmr459502plf.106.1659573602844;
        Wed, 03 Aug 2022 17:40:02 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902710500b0016d987d7f76sm2538265pll.11.2022.08.03.17.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 17:40:02 -0700 (PDT)
Date:   Wed, 03 Aug 2022 17:40:02 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Aug 2022 17:40:00 PDT (-0700)
Subject:     Re: [PATCH] uapi: Fixup strace compile error
In-Reply-To: <20220613142947.GA4110@lst.de>
CC:     guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux@roeck-us.net, heiko@sntech.de,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com,
        esyr@redhat.com, Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-f091aa29-2a87-4d82-9bab-f35533de7161@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 13 Jun 2022 07:29:47 PDT (-0700), Christoph Hellwig wrote:
> The change looks fine, but the commit log could use some work, please
> move the notes from the back to the front and make them a standalone
> commit log and just drop the rest.

I'm digging through old stuff and don't see a v2, not sure if I just 
missed it.  Either way I don't think it's really a RISC-V thing so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

in case that helps.

Thanks!
