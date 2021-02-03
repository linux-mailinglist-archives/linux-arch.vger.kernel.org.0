Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA2930DFF3
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 17:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhBCQos (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 11:44:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhBCQor (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 11:44:47 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1207564F7C;
        Wed,  3 Feb 2021 16:44:00 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l7LG1-00Bnsm-Sk; Wed, 03 Feb 2021 16:43:57 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     arnd@arndb.de, Quentin Perret <qperret@google.com>,
        catalin.marinas@arm.com, will@kernel.org
Cc:     ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH 0/2] KVM: arm64: Stub exports in nvhe code
Date:   Wed,  3 Feb 2021 16:43:48 +0000
Message-Id: <161237062025.1419625.13086305573512898143.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203141931.615898-1-qperret@google.com>
References: <20210203141931.615898-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: arnd@arndb.de, qperret@google.com, catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, kernel-team@android.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 3 Feb 2021 14:19:29 +0000, Quentin Perret wrote:
> In the context of the currently ongoing work to remove the host kernel
> from the TCB under KVM/arm64, I have been trying to wrap the host kernel
> with a stage 2 page-table -- see [1].
> 
> Using this infrastructure, I attempted to unmap the .hyp. sections from
> the host stage 2 as it really shouldn't need to access them. But by
> doing so, I realized quickly the module loader was getting very confused
> by the usage of EXPORT_SYMBOL() macros in library functions that have
> been pulled into the EL2 object, and that we end up linking modules
> against the EL2 copy of e.g. memset. And so, this series essentially
> tries to fix this.
> 
> [...]

Applied to kvm-arm64/misc-5.12, thanks!

[1/2] asm-generic: export: Stub EXPORT_SYMBOL with __DISABLE_EXPORTS
      commit: 54effa653246c35997f5e990e0134be5be09f9d1
[2/2] KVM: arm64: Stub EXPORT_SYMBOL for nVHE EL2 code
      commit: bbc075e01ceac50e0a8353b520544f3089e94e44

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


