Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061FE3EEF4C
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 17:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhHQPmT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Aug 2021 11:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbhHQPlK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Aug 2021 11:41:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2448C061764;
        Tue, 17 Aug 2021 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u2BzcnqSZsZ2CjWCbcjr6I/Lj+YghJDDrab9xd4gN/o=; b=CgyKkEgufJEEC8SUuIGuAVwUNw
        t7Jd3M61KkL72j9PTK/fpahwjz6+p89MBAvQ/JLqAlt05/023F5vG+TJX5iSSZuah6los43S5w9o+
        U8gDSg7TI/CsZTfB7q/vIHw3n1Dv9qOrSwSS62NnOgfX/geJa3tXWouWs2fMEqTAVUVFFqYpu9IRq
        rOMtUdCn0O0wz7twL8QtfYyaVs+WowxccmOSLX9BCD06AOvjAQ9D0g6a9KV4Cvwc542CpHURBGBcz
        WxntkvO8eUSJqolfi29NSi/2OMBQ3FOIK9wy2d1IMC6wVtUcx8Kche72/Doy1v6GueRD21ZRYajel
        kdluLNHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mG1CT-00AV02-Jn; Tue, 17 Aug 2021 15:40:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED33530019C;
        Tue, 17 Aug 2021 17:40:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D67542C8F5E09; Tue, 17 Aug 2021 17:40:24 +0200 (CEST)
Date:   Tue, 17 Aug 2021 17:40:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v11 07/16] sched: Split the guts of sched_setaffinity()
 into a helper function
Message-ID: <YRvYaGa4QnhV2q51@hirez.programming.kicks-ass.net>
References: <20210730112443.23245-1-will@kernel.org>
 <20210730112443.23245-8-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730112443.23245-8-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 30, 2021 at 12:24:34PM +0100, Will Deacon wrote:
> In preparation for replaying user affinity requests using a saved mask,
> split sched_setaffinity() up so that the initial task lookup and
> security checks are only performed when the request is coming directly
> from userspace.
> 
> Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Should not sched_setaffinity() update user_cpus_ptr when it isn't NULL,
such that the upcoming relax_compatible_cpus_allowed_ptr() preserve the
full user mask?
