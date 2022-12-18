Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392F96504A7
	for <lists+linux-arch@lfdr.de>; Sun, 18 Dec 2022 21:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiLRUvx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Dec 2022 15:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLRUvw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Dec 2022 15:51:52 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF0CB1FF
        for <linux-arch@vger.kernel.org>; Sun, 18 Dec 2022 12:51:50 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id e6so2983021qkl.4
        for <linux-arch@vger.kernel.org>; Sun, 18 Dec 2022 12:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ausil.us; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PK6Xhn1pRmUhw+cc6jr8M+nX0xE/ouv6dZZq3MtT0BY=;
        b=FLdEIbHRmldWlRuXIFPmnjsvmxxYoIxVvFaOcVUuu9mg19Iswg3SShC4imPxLVoqbI
         55v0UPj3apJs0MVcvSNBssdxIVVIElUn9ikuUIGGHSuFfUWjcPtP2TSjaDSu/gr1fM6M
         Bput4lTgRe1XjL0NDjtG7/auo7W2hor/zDzlsCz7PgkgTNGQWlebsYYyvrjoa/PyyaSX
         PmRngWKnjxkFuIoJTbv6DQm5Peo2kOSJPglC6hp4rERYcjDgtdZZT6dOWXzpdgeUnIlH
         64OZck5PI82KlDkb2WSgc/4m1rQGvFZupjS1oUu2B8WMkk2W0Q5FxFedoCyb89C1DFdW
         VTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PK6Xhn1pRmUhw+cc6jr8M+nX0xE/ouv6dZZq3MtT0BY=;
        b=QQOxhFXNxPEwS3mSuq1IZId9q61TRRzWXuo9k1z6mVy+DB2Csq0a8owYeUB6gFx4Aq
         xNOmCrwx2ROYdtyGuh5HS5EIWI1hHImDzbO4BX0JYW7qFLocGbYM8i5/tTLV++LaAbiq
         5qWMOS9LzAxzI9fMLVQD39hedmLzgNzpxOxcRBG2mPm2hJYonB0/71r6NRqx09OGrb0w
         gRaIUOkyD9u4/IovnV/wyP2PCIlQOo52faWhCizvHej+Gjf910NQmDqYfcjr56eQxZbk
         OLvD1n45y54PSe09r5n8MOPmOH8SUUEEUnynGZVkJy8a72JBsGwjxgE8EnFOiodf6BGm
         pefw==
X-Gm-Message-State: ANoB5pmLZAPbe89corACU3GIjMg45oSsOwLHZ+mmiMMrEolDTnbo5LbY
        as39B6jHs597mC1ZTwYSmIu/nke4+/+FA9+QdfIZaSeju9Iqp0+j15IxAg==
X-Google-Smtp-Source: AA0mqf7dZc2pJGg90cDpqPPxKmiYOBVUEtgZ64CO7v9uXueTqVLXJJVmbs9KWVKT+S0E6s+j646J2kuNHTeP9HhAtks=
X-Received: by 2002:a05:620a:b03:b0:6ff:8ac7:ad53 with SMTP id
 t3-20020a05620a0b0300b006ff8ac7ad53mr939105qkg.679.1671396708943; Sun, 18 Dec
 2022 12:51:48 -0800 (PST)
MIME-Version: 1.0
From:   Dennis Gilmore <dennis@ausil.us>
Date:   Sun, 18 Dec 2022 14:51:38 -0600
Message-ID: <CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com>
Subject: BUG: arm64: missing build-id from vmlinux
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The changes in https://lore.kernel.org/linux-arm-kernel/166783716442.32724.935158280857906499.b4-ty@kernel.org/T/
result in vmlinux no longer having a build-id. At the least, this
causes rpm builds to fail. Reverting the patch does bring back a
build-id, but there may be a different way to fix the regression

Dennis
