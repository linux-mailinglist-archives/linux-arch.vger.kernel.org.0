Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2417E30DE12
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 16:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhBCPZm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 10:25:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233745AbhBCPZj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 10:25:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E86064E50;
        Wed,  3 Feb 2021 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612365898;
        bh=b6GRiq4QWZI2rziuLd7GuwpX6MNv51A8gcYBBvehiio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b6Y16Cv346MxftHyKt9CjWlbJT3BUlf8fpmSRvBh9qH1up5WGKfAVm2q0gqQ7fxmW
         0cPpkWQQtzxsDzT3G422p0zCLvepCyf5ghZd6xCuYNtvNdyrkiDjzYoENxjPUGctAJ
         l7X6Al+Yjvo0osO70Mn4QGsRq0QlPCyIjo4f/HboaU19+bgKIgKp8bkSsIuS/ysEiM
         3aTgKiAQu9g7W7hmgzoge1tRFBuzCHajRrhVWfI7+YZZ6LoGiZFMojJEe+UnFvhUsL
         q/v4Vw2fDx/qmRFmVVpq2GLD4+Qa1PHc3o+YF9LYzaT9TUJks7u33wS6x+CMp6HR2z
         RhfG/FIp5RF1A==
Date:   Wed, 3 Feb 2021 15:24:52 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     arnd@arndb.de, maz@kernel.org, catalin.marinas@arm.com,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, ardb@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com
Subject: Re: [PATCH 1/2] asm-generic: export: Stub EXPORT_SYMBOL with
 __DISABLE_EXPORTS
Message-ID: <20210203152452.GA18974@willie-the-truck>
References: <20210203141931.615898-1-qperret@google.com>
 <20210203141931.615898-2-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203141931.615898-2-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:19:30PM +0000, Quentin Perret wrote:
> It is currently possible to stub EXPORT_SYMBOL() macros in C code using
> __DISABLE_EXPORTS, which is necessary to run in constrained environments
> such as the EFI stub or the decompressor. But this currently doesn't
> apply to exports from assembly, which can lead to somewhat confusing
> situations.
> 
> Consolidate the __DISABLE_EXPORTS infrastructure by checking it from
> asm-generic/export.h as well.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  include/asm-generic/export.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Will Deacon <will@kernel.org>

Will
