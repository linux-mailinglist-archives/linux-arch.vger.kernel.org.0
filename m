Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F426AD370
	for <lists+linux-arch@lfdr.de>; Tue,  7 Mar 2023 01:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCGAtB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 19:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjCGAtA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 19:49:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D5532E4D;
        Mon,  6 Mar 2023 16:48:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33EBE6119F;
        Tue,  7 Mar 2023 00:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B8C7C4339C;
        Tue,  7 Mar 2023 00:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678150138;
        bh=DTBF08PUaWnq+/WZrF7wRg3Gw3DZpD56+OYHF2OwmDU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Y07kUCp2hLM8zvBJFe4OvNqBFVagn6t9EukGAZvud6hbysxiSK4EOkMznK70nfH6L
         0imkuDlS3T+d34hzLqbRZHIqG48prR0uSiuR8sk95nSw5j14kWp30nd+iKo/L7m4Y3
         TD2QvOLBkbWcdPrhdOGToM9C+mGKvKDdobAgTQX4PisWjy0VPKMhuTlOVOV2WWTVtz
         9KDQWWlTfudUG2qUssDCMv0Zbx1KgMv3OtQ3G9yUfKBFNpmeraaIPsM6eVmIogglql
         044cOWU0nhh4ZWyQZWXbdSxkyRS2QK0x5TwK3hVBxo0dx93tMoKEtPYNonTSWx9Znv
         xLzrI36/6Bj3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63BDEE68C3A;
        Tue,  7 Mar 2023 00:48:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/10] alpha: fix livelock in uaccess
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167815013840.19612.4686188583677266510.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Mar 2023 00:48:58 +0000
References: <Y9l0EDRr9DpNb5Pb@ZenIV>
In-Reply-To: <Y9l0EDRr9DpNb5Pb@ZenIV>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        monstr@monstr.eu, dinguyen@kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, torvalds@linux-foundation.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Al Viro <viro@zeniv.linux.org.uk>:

On Tue, 31 Jan 2023 20:03:28 +0000 you wrote:
> alpha equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
> If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
> end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
> to page tables.  In such case we must *not* return to the faulting insn -
> that would repeat the entire thing without making any progress; what we need
> instead is to treat that as failed (user) memory access.
> 
> [...]

Here is the summary with links:
  - [01/10] alpha: fix livelock in uaccess
    (no matching commit)
  - [02/10] hexagon: fix livelock in uaccess
    (no matching commit)
  - [03/10] ia64: fix livelock in uaccess
    (no matching commit)
  - [04/10] m68k: fix livelock in uaccess
    (no matching commit)
  - [05/10] microblaze: fix livelock in uaccess
    (no matching commit)
  - [06/10] nios2: fix livelock in uaccess
    (no matching commit)
  - [07/10] openrisc: fix livelock in uaccess
    (no matching commit)
  - [08/10] parisc: fix livelock in uaccess
    (no matching commit)
  - [09/10] riscv: fix livelock in uaccess
    https://git.kernel.org/riscv/c/d835eb3a57de
  - [10/10] sparc: fix livelock in uaccess
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


