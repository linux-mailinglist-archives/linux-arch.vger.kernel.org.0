Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7643A2C47
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 15:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFJNB6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 09:01:58 -0400
Received: from foss.arm.com ([217.140.110.172]:59420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230153AbhFJNB5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jun 2021 09:01:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EBF6106F;
        Thu, 10 Jun 2021 06:00:01 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7F2A3F73D;
        Thu, 10 Jun 2021 05:59:58 -0700 (PDT)
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
Subject: Re: [PATCH v9 08/20] cpuset: Cleanup cpuset_cpus_allowed_fallback() use in select_fallback_rq()
In-Reply-To: <20210608180313.11502-9-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org> <20210608180313.11502-9-will@kernel.org>
Date:   Thu, 10 Jun 2021 13:59:56 +0100
Message-ID: <877dj1dgdv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 08/06/21 19:03, Will Deacon wrote:
> select_fallback_rq() only needs to recheck for an allowed CPU if the
> affinity mask of the task has changed since the last check.
>
> Return a 'bool' from cpuset_cpus_allowed_fallback() to indicate whether
> the affinity mask was updated, and use this to elide the allowed check
> when the mask has been left alone.
>
> No functional change.
>
> Suggested-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Thanks!

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
