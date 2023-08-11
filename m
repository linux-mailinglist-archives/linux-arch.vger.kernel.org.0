Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC387797D4
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 21:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjHKTfP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 15:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjHKTfO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 15:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F761FE3
        for <linux-arch@vger.kernel.org>; Fri, 11 Aug 2023 12:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691782478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4ViBLckjSjhNPhrCupJ24JN3joY3lkNEYQ4wLCKCu0=;
        b=OZSFs1B2KzPe5/6CvQvoQuUkYLz+xqd4UgMkMjsljAoidEORbyQ5FyYY26S0QqthZcb9PO
        AJ/h0JACTGS7zZAATiI7jVwWw+fMG9tr7FuB+f4ks+CIe5ETCZlUrXGRCW1jVNfHDbE038
        eYy78BNMoLpcqFDoqoIh6w2Ih5Bhet4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-Rl9t6dKwP9qAeaYIUQeYSA-1; Fri, 11 Aug 2023 15:34:28 -0400
X-MC-Unique: Rl9t6dKwP9qAeaYIUQeYSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3FF685C6F4;
        Fri, 11 Aug 2023 19:34:23 +0000 (UTC)
Received: from [10.22.17.82] (unknown [10.22.17.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4ACD11121314;
        Fri, 11 Aug 2023 19:34:20 +0000 (UTC)
Message-ID: <ec070d3b-80fb-b625-cde1-80ead49c6227@redhat.com>
Date:   Fri, 11 Aug 2023 15:34:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V10 04/19] riscv: qspinlock: Add basic queued_spinlock
 support
Content-Language: en-US
To:     guoren@kernel.org, paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
        paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, conor.dooley@microchip.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230802164701.192791-1-guoren@kernel.org>
 <20230802164701.192791-5-guoren@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230802164701.192791-5-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 8/2/23 12:46, guoren@kernel.org wrote:
> 	\
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> new file mode 100644
> index 000000000000..c644a92d4548
> --- /dev/null
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_RISCV_SPINLOCK_H
> +#define __ASM_RISCV_SPINLOCK_H
> +
> +#ifdef CONFIG_QUEUED_SPINLOCKS
> +#define _Q_PENDING_LOOPS	(1 << 9)
> +#endif
> +
> +#ifdef CONFIG_QUEUED_SPINLOCKS

You can merge the two "#ifdef CONFIG_QUEUED_SPINLOCKS" into single one 
to avoid the duplication.

Cheers,
Longman

> +#include <asm/qspinlock.h>
> +#include <asm/qrwlock.h>
> +#else
> +#include <asm-generic/spinlock.h>
> +#endif
> +
> +#endif /* __ASM_RISCV_SPINLOCK_H */

