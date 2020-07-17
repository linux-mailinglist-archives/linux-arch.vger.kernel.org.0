Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857BF223998
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 12:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgGQKn5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 06:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgGQKn4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jul 2020 06:43:56 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B1F20775;
        Fri, 17 Jul 2020 10:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594982636;
        bh=tMXpu57E8Vx7cqcnyKoKA4Db0cNZFac86QieI1k1G7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CK8HTzbW5jB5n7zXDrkue0wGo8BaekBTsYKRLiz2jydjNFmCdMU4P9w01S7XptT5a
         5NPbKI40mHeFrJVBw337jP2fD9pRU5PxhdtGMfX4c2NxVgqh7TrSz8rB8OmA5zzIew
         hPhOS4WRrBv8QCh8bJUOeJ9/lWYjDpN+2z3hVC4k=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic/mmiowb: Allow mmiowb_set_pending() when preemptible()
Date:   Fri, 17 Jul 2020 11:43:43 +0100
Message-Id: <159497652409.524891.6561966096386113237.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200716112816.7356-1-will@kernel.org>
References: <20200716112816.7356-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 16 Jul 2020 12:28:16 +0100, Will Deacon wrote:
> Although mmiowb() is concerned only with serialising MMIO writes occuring
> in contexts where a spinlock is held, the call to mmiowb_set_pending()
> from the MMIO write accessors can occur in preemptible contexts, such
> as during driver probe() functions where ordering between CPUs is not
> usually a concern, assuming that the task migration path provides the
> necessary ordering guarantees.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] asm-generic/mmiowb: Allow mmiowb_set_pending() when preemptible()
      https://git.kernel.org/arm64/c/bd024e82e4cd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
