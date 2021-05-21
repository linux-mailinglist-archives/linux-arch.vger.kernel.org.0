Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD95B38C54B
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhEUK5F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 06:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhEUK5F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 06:57:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F49A6108D;
        Fri, 21 May 2021 10:55:39 +0000 (UTC)
Date:   Fri, 21 May 2021 11:55:37 +0100
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
Subject: Re: [PATCH v6 04/21] arm64: Kill 32-bit applications scheduled on
 64-bit-only CPUs
Message-ID: <20210521105536.GF6675@arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-5-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-5-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 10:47:08AM +0100, Will Deacon wrote:
> Scheduling a 32-bit application on a 64-bit-only CPU is a bad idea.
> 
> Ensure that 32-bit applications always take the slow-path when returning
> to userspace on a system with mismatched support at EL0, so that we can
> avoid trying to run on a 64-bit-only CPU and force a SIGKILL instead.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
