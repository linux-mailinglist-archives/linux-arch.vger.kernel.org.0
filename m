Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAFA779145
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjHKODj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 10:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjHKODi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 10:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C27010E4;
        Fri, 11 Aug 2023 07:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B25967360;
        Fri, 11 Aug 2023 14:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F119C433C7;
        Fri, 11 Aug 2023 14:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762617;
        bh=og9zFJsSg2ygKq7CWavCrR6FMxp5scKltJc6fBwC7sU=;
        h=From:To:Cc:Subject:Date:From;
        b=JNP7qxsmiz3aIAhcrzVamnpAayV0nPix0xnWWXHD8oRKDOB1N+IHgkmSHKlglNoo9
         FYwzlPc0x5zJNiMjfhii6t0pYu3ZOlQVSkkSkdNDpdLq09eAeX2s04PggYGz2rg8mQ
         B7BpAdZyTfq7gM86pXu+66gUXPc0GjqSi5l3f8FytbWsm58LzWHD/g7BarHB8hc1gW
         E822kQJa7OtqlKo5m9ykmSoZ1adztzJkSKnASy91ek+yMbR3+f2A2OcIlIKLUpbtd4
         LQFDNctHXKXqkxXnJwXD5ZUeXfWB/Sr0O4lPV0XXZv7aBA3n+opdgNGAj2tKtZgkMK
         Vm1F6hW4YhjEg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 0/9] Kbuild: warning options cleanup and more warnings
Date:   Fri, 11 Aug 2023 16:03:18 +0200
Message-Id: <20230811140327.3754597-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

This is a series I've had in my randconfig test tree for a long
time, and I'd like to get these patches applied in mainline so I
can stop rebasing them on top of other changes, as well as get
fewer regressions.

There are roughly three groups of changes in here:

1. Clean up the Makefile and Makefile.extrawarn to be organized
   more logically so we can see which warnings are actually enabled
   at which level

2. Enable some of the warnings that have traditionally been disabled
   at either the W=1 or W=2 levels where they arguably should have
   been to start with

3. Enable some of the W=1 warnings by default now that the warnings
   we got in the past have been addressed.

I sent the -Wmissing-prototypes enablement separately, since that is
really the big one that probably found the most bugs but also still
caused the most warnings until my recent cleanups.

Along the same lines as that other series, I would hope that we
can get the first eight patches into the merge window, but should
probably give the last patch another release in linux-next before
any remaining output has been addressed and we can apply it.

     Arnd

Arnd Bergmann (9):
  Kbuild: only pass -fno-inline-functions-called-once for gcc
  Kbuild: consolidate warning flags in scripts/Makefile.extrawarn
  Kbuild: avoid duplicate warning options
  extrawarn: don't turn off -Wshift-negative-value for gcc-9
  extrawarn: enable format and stringop overflow warnings in W=1
  extrawarn: move -Wrestrict into W=1 warnings
  extrawarn: do not disable -Wmain at W=1 level
  extrawarn: enable more warnings in W=2
  [RFC] extrawarn: enable more W=1 warnings by default

 Makefile                   |  90 +------------------------
 scripts/Makefile.extrawarn | 133 ++++++++++++++++++++++++++++++++-----
 2 files changed, 118 insertions(+), 105 deletions(-)

-- 
2.39.2

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Lee Jones <lee@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org
