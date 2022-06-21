Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2365553538
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 17:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352201AbiFUPIb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 11:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352255AbiFUPI3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 11:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1A65BF67
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2022 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655824108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zUfLoKzkVAlW2Smcn1hCVbKkiGHkkqH1tY8/PyMPFmc=;
        b=ZQwlDo2hKXyqbMaem1Qtmqz2Apz3mqrErHDcNw9LvjXjsMGQDb6ZDrNmDbfXUJCIfLYWAI
        3fuRxsUIOqG2w7yGi/cgt6BSRsDAN4cNOlCddCzegLbB564TgcgxQcugPPM8BZM40qOyJK
        M2ifUgDQxluE6Y7b5iKAmHOisxeET6k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-yJ7nw58YM5iNu96pCFOFnw-1; Tue, 21 Jun 2022 11:08:23 -0400
X-MC-Unique: yJ7nw58YM5iNu96pCFOFnw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B19BB185A7A4;
        Tue, 21 Jun 2022 15:08:22 +0000 (UTC)
Received: from [10.22.34.147] (unknown [10.22.34.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D60AC492C3B;
        Tue, 21 Jun 2022 15:08:21 +0000 (UTC)
Message-ID: <7adc9e19-7ffc-4b11-3e18-6e3a5225638f@redhat.com>
Date:   Tue, 21 Jun 2022 11:08:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V6 0/2] riscv: Support qspinlock with generic headers
Content-Language: en-US
To:     guoren@kernel.org, palmer@rivosinc.com, arnd@arndb.de,
        peterz@infradead.org, boqun.feng@gmail.com,
        Conor.Dooley@microchip.com, chenhuacai@loongson.cn,
        kernel@xen0n.name, r@hev.cc, shorne@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
References: <20220621144920.2945595-1-guoren@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220621144920.2945595-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/21/22 10:49, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Enable qspinlock and meet the requirements mentioned in a8ad07e5240c9
> ("asm-generic: qspinlock: Indicate the use of mixed-size atomics").
>
> RISC-V LR/SC pairs could provide a strong/weak forward guarantee that
> depends on micro-architecture. And RISC-V ISA spec has given out
> several limitations to let hardware support strict forward guarantee
> (RISC-V User ISA - 8.3 Eventual Success of Store-Conditional
> Instructions):
> We restricted the length of LR/SC loops to fit within 64 contiguous
> instruction bytes in the base ISA to avoid undue restrictions on
> instruction cache and TLB size and associativity. Similarly, we

Does the 64 contiguous bytes need to be cacheline aligned?

Regards,
Longman

