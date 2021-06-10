Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B543A2C44
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 14:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFJNBq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 09:01:46 -0400
Received: from foss.arm.com ([217.140.110.172]:59392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhFJNBq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jun 2021 09:01:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EBAF106F;
        Thu, 10 Jun 2021 05:59:49 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C90F13F73D;
        Thu, 10 Jun 2021 05:59:46 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v9 06/20] cpuset: Don't use the cpu_possible_mask as a last resort for cgroup v1
In-Reply-To: <20210608180313.11502-7-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org> <20210608180313.11502-7-will@kernel.org>
Date:   Thu, 10 Jun 2021 13:59:41 +0100
Message-ID: <878s3hdgea.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 08/06/21 19:02, Will Deacon wrote:
> If the scheduler cannot find an allowed CPU for a task,
> cpuset_cpus_allowed_fallback() will widen the affinity to cpu_possible_mask
> if cgroup v1 is in use.
>
> In preparation for allowing architectures to provide their own fallback
> mask, just return early if we're either using cgroup v1 or we're using
> cgroup v2 with a mask that contains invalid CPUs. This will allow
> select_fallback_rq() to figure out the mask by itself.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
