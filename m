Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B092A0AEB
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 17:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgJ3QRK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 12:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgJ3QRK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 12:17:10 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73AD5206FA;
        Fri, 30 Oct 2020 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604074629;
        bh=1XXmHHhEPwy/7cidkEBKwAydIqQl1TzW+hR+L90xS6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=faetef4CnvLvjSwP4ByucucWvg8HsRt8BtMdcJGgd5nNAUI2yqoa2I1oLc6YpzxHC
         nU9JGegDNOx/9+pNiGPvPqU+GRVZBw1VSmNdpKKkPD4BB7l89H1b9uU8qNWO+dB/db
         1JfsP0bw2tMI3qCUqX7Zh0kwmJDa0govU569xV1I=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kYX5P-005nRP-8T; Fri, 30 Oct 2020 16:17:07 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com,
        Qais Yousef <qais.yousef@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-arch@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 0/6] An alternative series for asymmetric AArch32 systems
Date:   Fri, 30 Oct 2020 16:16:48 +0000
Message-Id: <160407459118.3016487.12247105988100320673.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027215118.27003-1-will@kernel.org>
References: <20201027215118.27003-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, peterz@infradead.org, kernel-team@android.com, qais.yousef@arm.com, catalin.marinas@arm.com, morten.rasmussen@arm.com, linux-arch@vger.kernel.org, surenb@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 27 Oct 2020 21:51:12 +0000, Will Deacon wrote:
> I was playing around with the asymmetric AArch32 RFCv2 from Qais:
> 
> https://lore.kernel.org/r/20201021104611.2744565-1-qais.yousef@arm.com
> 
> and ended up writing my own implementation this afternoon. I think it's
> smaller, simpler and easier to work with. In particular:
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: Handle Asymmetric AArch32 systems
      commit: 22f553842b14a1289c088a79a67fb479d3fa2a4e

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


