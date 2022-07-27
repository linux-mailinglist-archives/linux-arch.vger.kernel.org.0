Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419EE58297B
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jul 2022 17:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiG0PVb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jul 2022 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiG0PV1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jul 2022 11:21:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D1EDE9C;
        Wed, 27 Jul 2022 08:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23ECD6191A;
        Wed, 27 Jul 2022 15:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85982C433D6;
        Wed, 27 Jul 2022 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658935285;
        bh=PTGpZZnmXzxe20uHjDrH7NKOWIbim/FkPV1h7SW2u+A=;
        h=From:Date:Subject:To:Cc:From;
        b=L9sn2Ms4yoDltiyuzUHS4Dm2EXNXzulccKkWawR8/ZUY7A3PjLXNfc7QVcGuh4CvA
         LVvNHO0ZywVU9wa7ofeJ2vAHxXOVGijr63k+6GYwUOcpRxCjoJQTqUN9Mj7JuaxpKW
         Zqyac7nL8wndZamtEKaeXFNOFjFbNDVhM/FZKxTSwyHN0NV8l45co/y0YHBSs5ttAe
         oOESPSgfQdv9FfKziRpexWwT2Q1LIjh3bhA6szdYUUUgT7eufQWyjGBdwEE91jsDaX
         OsS0zA4ed1FHoOMEngPq5kh3RK2jrrcy+gSRWu2v9SWT49Ns0hGGMKgmZUuLywfzIj
         fWKi/qQlFsXFg==
Received: by mail-wr1-f48.google.com with SMTP id bn9so13981423wrb.9;
        Wed, 27 Jul 2022 08:21:25 -0700 (PDT)
X-Gm-Message-State: AJIora9fERP+1gNfkiFHg8VE7nKi2JFpwtzH87+cx20aZMraHuYhJBab
        COK88V+qw1yzaOBKdoRv3BVlLxHrV2KgytSgogY=
X-Google-Smtp-Source: AGRyM1t/RxxhiPUSJ2Td8BQcYWSbO+epKS3o6KxZhc40U3TiZKiZFxkhRGm/a+3wrlZZy6eFn/ZCLauo1xzfx1mYjx4=
X-Received: by 2002:a5d:52d0:0:b0:21e:4923:fa09 with SMTP id
 r16-20020a5d52d0000000b0021e4923fa09mr15040811wrv.244.1658935283836; Wed, 27
 Jul 2022 08:21:23 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 27 Jul 2022 17:21:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a13Z96qf7O=94XkfWsq8yC3QTzFv0by7i180DSn10b-CA@mail.gmail.com>
Message-ID: <CAK8P3a13Z96qf7O=94XkfWsq8yC3QTzFv0by7i180DSn10b-CA@mail.gmail.com>
Subject: [GIT PULL] asm-generic fixes for 5.19, part 2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-fixes-5.19-2

for you to fetch changes up to e2a619ca0b38f2114347b7078b8a67d72d457a3d:

  asm-generic: remove a broken and needless ifdef conditional
(2022-07-22 15:00:00 +0200)

----------------------------------------------------------------
asm-generic fixes for 5.19, part 2

Two more bug fixes for asm-generic, one addressing an incorrect
Kconfig symbol reference and another one fixing a build failure
for the perf tool on mips and possibly others.

----------------------------------------------------------------
Florian Fainelli (1):
      tools: Fixed MIPS builds due to struct flock re-definition

Lukas Bulwahn (1):
      asm-generic: remove a broken and needless ifdef conditional

 include/asm-generic/io.h               |  2 --
 include/uapi/asm-generic/fcntl.h       |  2 ++
 tools/include/uapi/asm-generic/fcntl.h | 11 ++++++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)
