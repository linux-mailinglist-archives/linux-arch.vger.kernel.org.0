Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24B338EC7A
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhEXPPp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 11:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235229AbhEXPJm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 11:09:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ED2261241;
        Mon, 24 May 2021 15:02:36 +0000 (UTC)
Date:   Mon, 24 May 2021 16:02:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 17/21] arm64: exec: Adjust affinity for compat tasks
 with mismatched 32-bit EL0
Message-ID: <20210524150233.GD14645@arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-18-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-18-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 10:47:21AM +0100, Will Deacon wrote:
> When exec'ing a 32-bit task on a system with mismatched support for
> 32-bit EL0, try to ensure that it starts life on a CPU that can actually
> run it.
> 
> Similarly, when exec'ing a 64-bit task on such a system, try to restore
> the old affinity mask if it was previously restricted.
> 
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
