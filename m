Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9973A4F9772
	for <lists+linux-arch@lfdr.de>; Fri,  8 Apr 2022 15:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbiDHOBB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Apr 2022 10:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiDHOA7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Apr 2022 10:00:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9BD6C905;
        Fri,  8 Apr 2022 06:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B061A61AE1;
        Fri,  8 Apr 2022 13:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8110C385AA;
        Fri,  8 Apr 2022 13:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649426335;
        bh=bDBwdys85RCakFFbygvOdphtQTA9miuiqFibn2MIMFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeA26bBevVgo6sbJzPJXamDO8E3ns/pz20ZNfr/4yRgmVpFBvscC184viL/LX11hU
         CD7+aJE00Kjo9bk1ElwXNi+skHXiJ+iskOUp+OMkltZaxXxTTbfQFqxbL/k7/OSSZN
         N+uMGu37NDp/7VhbOex7Iyhc36pjZYZEjVMsnR23nQy3HLdYE1lLONI3vTtBMweeWI
         PAs2Y0Y+9ghBS7PrZtAc7B5mZRRvCAw8bIi9He0MU67mtZQulVPCrja/esFrjYYuvA
         yrsaXkDTlAvZy+wqrxspiwEm/OT1rSxyL0bGt88Psnktz2ujzjTVPFTrnohVgMCCrD
         6KdtWv3cu8fLQ==
From:   Will Deacon <will@kernel.org>
To:     gregkh@linuxfoundation.org, guoren@kernel.org, arnd@arndb.de
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Guo Ren <guoren@linux.alibaba.com>, linux-csky@vger.kernel.org
Subject: Re: [PATCH V4 0/4] arch: patch_text: Fixup last cpu should be master
Date:   Fri,  8 Apr 2022 14:58:45 +0100
Message-Id: <164941462755.3967238.7784714539452982763.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220407073323.743224-1-guoren@kernel.org>
References: <20220407073323.743224-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 7 Apr 2022 15:33:19 +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> These patch_text implementations are using stop_machine_cpuslocked
> infrastructure with atomic cpu_count. The original idea: When the
> master CPU patch_text, the others should wait for it. But current
> implementation is using the first CPU as master, which couldn't
> guarantee the remaining CPUs are waiting. This patch changes the
> last CPU as the master to solve the potential risk.
> 
> [...]

Applied first patch only to arm64 (for-next/fixes), thanks!

[1/4] arm64: patch_text: Fixup last cpu should be master
      https://git.kernel.org/arm64/c/31a099dbd91e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
