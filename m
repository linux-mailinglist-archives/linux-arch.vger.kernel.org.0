Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11C26A3B6B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 08:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjB0HBc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 02:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0HBb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 02:01:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0621A495;
        Sun, 26 Feb 2023 23:01:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30E1FB80C95;
        Mon, 27 Feb 2023 07:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DC5C433EF;
        Mon, 27 Feb 2023 07:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677481287;
        bh=yx/JP9DY2+Ns9YVFs9b7YUupR2IltXfb3fYeyIdlu7A=;
        h=From:To:Cc:Subject:Date:From;
        b=sQCMBnx+0V3Gmv7jt08xoll+puX2HcX25pJDjIQdeH3qCULUDhqB9/kyBelmHP9R7
         eEeLzM1MszQi14iFaMSD4eVNHiwYRdbaB81zuZa89n0oLd6fO/xQrgCfqE1fmAhXu3
         RAzh8DvKCSAqQ8ll20J7ubzHikTYMN4snlwrCTLMT5VuWCKC/KefYUbDCBFAfox53Z
         ats5QoLwd50Wvi6VvJKRrOj/EfEGHY6Kj6cOULJSq58UDHkR+fiha7/f/tXbBHTkAL
         Z8MtXFUwFbgXmQyP4bvCHwKI7a2F2CFQGDla762TKw9RLHNSIQ0PBpjCxY8pEKde+E
         OQeFu1KJSXabQ==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v6.3
Date:   Mon, 27 Feb 2023 02:01:22 -0500
Message-Id: <20230227070122.1840809-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

Please pull the latest csky changes from:

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.3

for you to fetch changes up to 4a3ec00957fdf182be705d46e77acacc430f7d65:

  csky: delay: Add function alignment (2022-12-29 23:47:52 -0500)

----------------------------------------------------------------
rch/csky patches for 6.3

The pull request we've done:
 - Optimize delay accuracy

----------------------------------------------------------------
Jialu Xu (1):
      csky: delay: Add function alignment

 arch/csky/lib/delay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
