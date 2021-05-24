Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3A438F07E
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbhEXQDi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 12:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235991AbhEXQCb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 12:02:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 770DF61413;
        Mon, 24 May 2021 15:48:01 +0000 (UTC)
Date:   Mon, 24 May 2021 16:47:59 +0100
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
Subject: Re: [PATCH v6 20/21] arm64: Remove logic to kill 32-bit tasks on
 64-bit-only cores
Message-ID: <20210524154758.GG14645@arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-21-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-21-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 10:47:24AM +0100, Will Deacon wrote:
> The scheduler now knows enough about these braindead systems to place
> 32-bit tasks accordingly, so throw out the safety checks and allow the
> ret-to-user path to avoid do_notify_resume() if there is nothing to do.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
