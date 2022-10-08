Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A015F8654
	for <lists+linux-arch@lfdr.de>; Sat,  8 Oct 2022 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJHRtx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Oct 2022 13:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiJHRtv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Oct 2022 13:49:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91C215FE3;
        Sat,  8 Oct 2022 10:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D5E5B80B6E;
        Sat,  8 Oct 2022 17:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7874BC433D7;
        Sat,  8 Oct 2022 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665251386;
        bh=rhu4tXwJzEldn38Q3iAECeDkTTaB/gJXB15p4JdG7Po=;
        h=From:To:Cc:Subject:Date:From;
        b=KdxC3MeYBrkOWUzs2CkoPIlvzx63uadcYz3zz5/zsHkwYRIx4rbnJxJARWBBMPR4Z
         arkyyNNpTjTIEJVIB4i1BNe+UHf1b0Ncv4C0cXS+9wJsjW3buIl5zZWrBzAwLQgEuL
         csaSWSvDhUSIkJyUFb0yL60ksDOuWvX3dgpyO7amY3fryxSOOYgkhTNLW9/dkBZf7z
         bzv1wGXx3l7U9/AKlGGRSadKmBZINASJUb4es/Fy3fEZporpWaULj0o7ZDiQLG27U1
         bCd0FUMNSFyBg1oZ95jbVWyfUzZY6lgAWQVIDKYAVNy/NoIw1yDAT/2C+0lwwWCXgN
         MJygrqc701ySA==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/4] docs/memory-barriers.txt: Fix nits and update Korean translation
Date:   Sat,  8 Oct 2022 10:49:24 -0700
Message-Id: <20221008174928.13479-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset fixes one trivial nit in memory-barriers.txt (patch 1) and
updates Korean translation to match the content of the original one
(patches 2-4).

SeongJae Park (4):
  docs/memory-barriers.txt: Add a missed closing parenthesis
  docs/memory-barriers.txt/kokr: introduce io_stop_wc() and add
    implementation for ARM64
  docs/memory-barriers.txt/kokr: Add memory barrier dma_mb()
  docs/memory-barriers.txt/kokr: Fix confusing name of 'data dependency
    barrier'

 Documentation/memory-barriers.txt             |   2 +-
 .../translations/ko_KR/memory-barriers.txt    | 149 ++++++++++--------
 2 files changed, 86 insertions(+), 65 deletions(-)

-- 
2.17.1

