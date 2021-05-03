Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FF43721C9
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 22:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhECUqC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 16:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhECUp7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 May 2021 16:45:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9414A610C8;
        Mon,  3 May 2021 20:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620074705;
        bh=1F6+JdYLwP5EEoYq0ZoUt/GniSDWi8wSsSObVn3JkiE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KGZ8krZ1HgWGyMiwk3DZ6oUeY57w7Ayx7ESQ2Gv51Czn4RjZ4mwVEMsmaGfnxGiTo
         J1MHvX3CGNq5XJYEcgb1ecqPaEtbtQlvwMNIhBC72P0Kl+u6ESZtOi0OJLlUojg2zJ
         0qcky4Cn+h6VcIKVsNSqD6shmSOJZksJnCliMtgmWOCBZoY1S2W0lyA0pbeP+4PjwS
         z/F+1MZoZIFoz6ythY3vEG3OmPwu106cxoroITIdeirBrm3kc36QlOAf4tnDT1crb9
         wcVxgzMiyzygDyjzcDByzziLF2cgu3/GqrVlekRVQEx97/dlMp9F2KJD9t0fWZju9d
         6xOjs01vBPHCQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 81FFC609E9;
        Mon,  3 May 2021 20:45:05 +0000 (UTC)
Subject: Re: [GIT PULL] csky changes for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210503164518.33972-1-guoren@kernel.org>
References: <20210503164518.33972-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-csky.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210503164518.33972-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.13-rc1
X-PR-Tracked-Commit-Id: e58a41c2226847fb1446f3942dc1b55af8acfe02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cda689f8708b6bef0b921c3a17fcdecbe959a079
Message-Id: <162007470547.4403.10162729492427609078.pr-tracker-bot@kernel.org>
Date:   Mon, 03 May 2021 20:45:05 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Tue,  4 May 2021 00:45:18 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cda689f8708b6bef0b921c3a17fcdecbe959a079

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
