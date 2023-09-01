Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA4A78F6CC
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 03:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbjIABp7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 31 Aug 2023 21:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjIABp7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Aug 2023 21:45:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A964E70;
        Thu, 31 Aug 2023 18:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D52960C90;
        Fri,  1 Sep 2023 01:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9E2C433C8;
        Fri,  1 Sep 2023 01:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693532755;
        bh=qZ6Rjna243ZbZ2eAsw7+XS5/ep1LvQGHVuzoTy6/+kI=;
        h=From:To:Cc:Subject:Date:From;
        b=iEfpE5szYnsuQh+Ttxdv5K4EJTvd9twnAwlhn2PsBPjrLopkAdYJSDtZ5RxnWDA/E
         kNIc900FCgMePXBN5+lbNGpDrbZbJI45Fb8JWXZJKp/PUf/3LPnwUTjsI0IfocCPRv
         1cAONmnzV9FBRQTHnkgYGEI/jq31Lz08q/07dFecHAt/EUnsnKqg0FlUpNAxxkiIyv
         amWUA9ubIZ2la1436j0P33Dn5K+cG96JUofR6Pwhfskp0HaNlAcDhuSJhO6JP95+9r
         4kp24jWOzy4o065SKGLri9+/TR1y8pB1nc3e6bMoUuFAF4BaolCvQpgd93ExNUR2EK
         16L2iaQZMKFgQ==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org, guoren@kernel.org,
        sudipm.mukherjee@gmail.com, linux@roeck-us.net
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky 2nd changes for v6.6
Date:   Thu, 31 Aug 2023 21:45:48 -0400
Message-Id: <20230901014548.2885411-1-guoren@kernel.org>
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

Please pull the 2nd v6.6 changes from:

The following changes since commit c8171a86b27401aa1f492dd1f080f3102264f1ab:

  csky: Fixup -Wmissing-prototypes warning (2023-08-10 23:06:32 -0400)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.6-2

for you to fetch changes up to 5195c35ac4f09bc45bde23b98d74c4f5d62bea65:

  csky: Fixup compile error (2023-08-30 05:54:47 -0400)

----------------------------------------------------------------
arch/csky 2nd patches for 6.6

Only one fixup:
 - Fixup compile error by missing header file

----------------------------------------------------------------
Guo Ren (1):
      csky: Fixup compile error

 arch/csky/include/asm/traps.h | 2 ++
 1 file changed, 2 insertions(+)
