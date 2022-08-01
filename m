Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A240D5862C1
	for <lists+linux-arch@lfdr.de>; Mon,  1 Aug 2022 04:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbiHACmn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 31 Jul 2022 22:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbiHACmm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 Jul 2022 22:42:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0423913D09;
        Sun, 31 Jul 2022 19:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6C64DCE10EA;
        Mon,  1 Aug 2022 02:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9041DC433D7;
        Mon,  1 Aug 2022 02:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659321758;
        bh=9ke7wuBcM5VhyQdFVxfwibQmfudWIzLnjDOb14h6Ja4=;
        h=From:To:Cc:Subject:Date:From;
        b=PmHhtgUFj4Z3IeaU4vw1EHJwF3Gpxf/QQGtvUhCIKqruAY75UTPw6qlS7cQihi5fC
         NocxhB05+QrPmKOe5E4NUQ2a5eKRiUsnFzyDF2J6gEvuRvt+EFYh/E6Nfg7Vd4uUhO
         RW/YuiAMLzpm039vsy+RvBqMaB6/lrg0UdyBFt3XBoufLf+hL1ctN1iIgNc3S1B2Lg
         PAfHWk7GCyX1Gpv/7BSpQGBeC2W9ydImq1LuvAYR+u+NvD8aaYXAzz2WBOe69V4RK1
         wVGGHA6oCsPsws5aoxnTYZKQDKbm4TQV1jxKoMKCCa6iKrE3iULLs3NiHuo3cMTmfG
         agtyWvlq0VagQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 0/2] Fixup and coding convention
Date:   Sun, 31 Jul 2022 22:42:27 -0400
Message-Id: <20220801024229.567397-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Two small modifications for fixup abiv1 compile and coding convention. 

Guo Ren (2):
  csky: cmpxchg: Coding convention for BUILD_BUG()
  csky: abiv1: Fixup compile error

 arch/csky/abiv1/inc/abi/string.h |  6 ++++++
 arch/csky/include/asm/cmpxchg.h  | 11 +++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.36.1

