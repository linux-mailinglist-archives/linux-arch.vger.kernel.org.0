Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B279BC55
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 02:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjIKVFZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242130AbjIKPXL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 11:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6339AF2
        for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2023 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694445744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6+UTvfQcsvDPdhGXSi2AAvjsiLi7Cpcaa64YOiSPW8=;
        b=GIx1PCfcghqizZ3eCJswALXpXzG1i2Qzr1f8bqkBmd3YOU8DcwOW8Vj86x6+R0/Cx/0vjI
        YENd0sAi10zu9pwoxUYdt0n18l7YdzOQX95AurV7sDAEJt5Tc6cRkL4q0uBRAJ/aA9JnUL
        99TtdlYqTYpniYaGS+RUvZ7ygReG87M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-lqKOgAgdOfK27hptzaDxOw-1; Mon, 11 Sep 2023 11:22:20 -0400
X-MC-Unique: lqKOgAgdOfK27hptzaDxOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79C873C1ACE8;
        Mon, 11 Sep 2023 15:22:18 +0000 (UTC)
Received: from [10.22.32.237] (unknown [10.22.32.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CB4040C200B;
        Mon, 11 Sep 2023 15:22:16 +0000 (UTC)
Message-ID: <11f2a7a5-5219-a46e-5d16-4bdd400f5d9b@redhat.com>
Date:   Mon, 11 Sep 2023 11:22:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V11 07/17] riscv: qspinlock: Introduce qspinlock param for
 command line
Content-Language: en-US
To:     guoren@kernel.org, paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
        paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, conor.dooley@microchip.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-8-guoren@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230910082911.3378782-8-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/10/23 04:29, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Allow cmdline to force the kernel to use queued_spinlock when
> CONFIG_RISCV_COMBO_SPINLOCKS=y.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  2 ++
>   arch/riscv/kernel/setup.c                       | 16 +++++++++++++++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7dfb540c4f6c..61cacb8dfd0e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4693,6 +4693,8 @@
>   			[KNL] Number of legacy pty's. Overwrites compiled-in
>   			default number.
>   
> +	qspinlock	[RISCV] Force to use qspinlock or auto-detect spinlock.
> +
>   	qspinlock.numa_spinlock_threshold_ns=	[NUMA, PV_OPS]
>   			Set the time threshold in nanoseconds for the
>   			number of intra-node lock hand-offs before the

Your patch series is still based on top of numa-aware qspinlock patchset 
which isn't upstream yet. Please rebase it without that as that will 
cause merge conflict during upstream merge.

Cheers,
Longman

