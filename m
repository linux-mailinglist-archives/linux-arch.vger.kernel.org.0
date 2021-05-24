Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBB038EC7B
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 17:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhEXPPp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 11:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235230AbhEXPJm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 11:09:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD06C60698;
        Mon, 24 May 2021 14:57:50 +0000 (UTC)
Date:   Mon, 24 May 2021 15:57:48 +0100
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
Subject: Re: [PATCH v6 16/21] arm64: Implement task_cpu_possible_mask()
Message-ID: <20210524145747.GC14645@arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-17-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-17-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 10:47:20AM +0100, Will Deacon wrote:
> Provide an implementation of task_cpu_possible_mask() so that we can
> prevent 64-bit-only cores being added to the 'cpus_mask' for compat
> tasks on systems with mismatched 32-bit support at EL0,
> 
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
