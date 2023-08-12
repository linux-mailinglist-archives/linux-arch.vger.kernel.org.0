Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756CD779C27
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 02:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbjHLAtB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 20:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjHLAtA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 20:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2D835BB
        for <linux-arch@vger.kernel.org>; Fri, 11 Aug 2023 17:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691801278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLC/yOAR2d4wIWdWwjFchmmeIa+RdcqwrFVJ1+GuKDw=;
        b=YPKCaRmJNmgl8pKS+WQ6hlqvXnewKU5X3zgXjU+qK9jBcUNcFfgjiALKxhciJKehRm/Hm5
        FpszXFKNTnTtgwDxmVgjRUX0uDHeB0f3jLkFOmwRSQqP+vd4T5+RP3jTdfrWttGFMZLtEO
        aLHhRhTwwneZ256bP+Sp2pBcD7ZRlgM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-lUtXwiZgPMmXVj5sVgtwdQ-1; Fri, 11 Aug 2023 20:47:54 -0400
X-MC-Unique: lUtXwiZgPMmXVj5sVgtwdQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 918563C0ED49;
        Sat, 12 Aug 2023 00:47:53 +0000 (UTC)
Received: from [10.22.17.82] (unknown [10.22.17.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E04A2166B25;
        Sat, 12 Aug 2023 00:47:51 +0000 (UTC)
Message-ID: <2f84b806-193a-6d7c-71fe-cc718e9455f9@redhat.com>
Date:   Fri, 11 Aug 2023 20:47:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V10 18/19] locking/qspinlock: Move pv_ops into x86
 directory
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
        paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, conor.dooley@microchip.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230802164701.192791-1-guoren@kernel.org>
 <20230802164701.192791-19-guoren@kernel.org>
 <5cf1117c-d537-703c-cdcf-f43c5bd9ed1b@redhat.com>
 <CAJF2gTQ6zJrcyOVCqF+xDXTEzFYUVQuTP0rKy=K6R99TQ05CrA@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAJF2gTQ6zJrcyOVCqF+xDXTEzFYUVQuTP0rKy=K6R99TQ05CrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 8/11/23 20:24, Guo Ren wrote:
> On Sat, Aug 12, 2023 at 4:42 AM Waiman Long <longman@redhat.com> wrote:
>> On 8/2/23 12:47, guoren@kernel.org wrote:
>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>
>>> The pv_ops belongs to x86 custom infrastructure and cleans up the
>>> cna_configure_spin_lock_slowpath() with standard code. This is
>>> preparation for riscv support CNA qspoinlock.
>> CNA qspinlock has not been merged into mainline yet. I will suggest you
>> drop the last 2 patches for now. Of course, you can provide benchmark
>> data to boost the case for the inclusion of the CNA qspinlock patch into
>> the mainline.
> Yes, my lazy, I would separate paravirt and CNA from this series.

paravirt is OK, it is just that CNA hasn't been merged yet.

Cheers,
Longman

>
>> Cheers,
>> Longman
>>
>

