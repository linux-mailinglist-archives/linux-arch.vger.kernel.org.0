Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011295FAADA
	for <lists+linux-arch@lfdr.de>; Tue, 11 Oct 2022 04:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJKC6f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 22:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJKC6d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 22:58:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED075F9B7;
        Mon, 10 Oct 2022 19:58:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3FF0B81100;
        Tue, 11 Oct 2022 02:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9997EC433D6;
        Tue, 11 Oct 2022 02:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665457110;
        bh=sJ2hDBfDeW7niye2H56TYUg09Uc+oivGcC5AImfpxaM=;
        h=From:To:Cc:Subject:Date:From;
        b=rYBi9+tWGQZBj0w7bXEt2L4r//iPuZ13NBvNkvDk1fM1xo9IARHZg3g2IbjJgfwjS
         ox1Yknl8+RZJPsDv5YKYB4mUcN+bGMCX1bidczNzKwrpr6H1j0QXmnbmhkImf4+1VG
         b4AkrFnvX5nRAll3WzWP6gTOOVdDFyVQJb2tZ1TEVuKBzQAR7x8g5flyOOX5hl8a0b
         g44LvOZzKrDVrjGcSXyDoxiuGQZPBXoSfMvT/DwILV3MdEK+w/pwasXA+AuuidUdNl
         E5mTAy6fDhc7gCgPsWB+GZDXMQV4yRCgcKOBlOBNrdnp/GDkuUT5hqQxm+rY6MNTKF
         RaqpaXvECI5IA==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     lyj7694@gmail.com, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 0/3] docs/memory-barriers/kokr: Update the content
Date:   Mon, 10 Oct 2022 19:58:06 -0700
Message-Id: <20221011025809.25821-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are updates to memory-barriers.txt that not applied to the Korean
translation.  This patchset applies the changes.

Changes from v1
(https://lore.kernel.org/all/20221008174928.13479-1-sj@kernel.org/)
- Drop first one, which is not for translation and already pulled
- Use better expressions for Korean (Yunjae Lee)
- Fix a typo (Yunjae Lee)

SeongJae Park (3):
  docs/memory-barriers.txt/kokr: introduce io_stop_wc() and add
    implementation for ARM64
  docs/memory-barriers.txt/kokr: Add memory barrier dma_mb()
  docs/memory-barriers.txt/kokr: Fix confusing name of 'data dependency
    barrier'

 .../translations/ko_KR/memory-barriers.txt    | 149 ++++++++++--------
 1 file changed, 85 insertions(+), 64 deletions(-)

-- 
2.17.1

