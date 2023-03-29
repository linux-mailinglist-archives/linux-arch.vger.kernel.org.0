Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1F56CF227
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 20:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjC2SaE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 14:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjC2SaD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 14:30:03 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A181AE;
        Wed, 29 Mar 2023 11:30:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B6F05C0113;
        Wed, 29 Mar 2023 14:30:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 29 Mar 2023 14:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680114600; x=1680201000; bh=jt
        UeQPVJjXi/stLWa+kfwMo4rgQ3KCBiTjULiP2HHys=; b=UgPnxvCpStaQdvhhw0
        9uMnnlu2am++cII5XZ8kzcwFimW1IPakFan3gFzYpORsk6wjT+f+JkwY8LTdBiFB
        6mgqLWZm6g08/ekZmZH1MsF+G02ZmahmxRmmd7j88I8yeBvTZdSd8m5urRiNnTB7
        cFNiXqmqbr5FOBUS+P5hCWgDw/NnnVZOSMQ9H5zBO3uCzYVLV4UCbwny1au2STxI
        Tnws/1sO01G4cGCZJFsWmFV/uoHw9z9HY1kxXzMf0odWCm5sxK2mdxdQyT/1DxDb
        JMaxRBUCvLnT8s55VLfi0V4/dUkRp//lvzC7qqRrs/guEunwcrBxJIiptBe9hnV/
        jMGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680114600; x=1680201000; bh=jtUeQPVJjXi/s
        tLWa+kfwMo4rgQ3KCBiTjULiP2HHys=; b=DxLL10GCQtJYNYZTwCtX0ctgDObHM
        97wmnWNjs3zxVonJnswdv9uWyKv7LodPCzQW0OY9NAEzpT0KHz6yKNCEdcg+xQ8z
        aRRatmKAZTuGto8A/yolWhCGjV9Bx69Or/Qljjy+vzsYOk+dijdLeD6gVMr3X6d+
        ajSXy73ZWbazNGzPM0blwi6LCGvZ8gdTi51ZiOxzvOKAWJPpCGmLsXEkJUU5HG12
        iheUkNP9isr98Mwij6Ye9wakeP1oFhZhdWHFibKIIRNnR6OnCZ4sl7jH/s1kAG7m
        7M50nvz+encephcNB1jokaANqNR6Q0Z/JVCVfaMODXAATaubC/hxG+zkw==
X-ME-Sender: <xms:p4MkZFxx34GHrA5nPcMNV4V23rX8fg4Utb6joJxQT80I8bx7sAFpEw>
    <xme:p4MkZFQIwpxjN6WyvvQdXbO-wbU3FvO2cIzGJE6qjJT-RWYcBLdbnGwqmaZ79LG1W
    0Biehm6kGymapMR1lM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehiedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:p4MkZPVb6Y5pAtSF7219-bVEQ1G4F6yttNRWUNWgbFvMPWXGqCed_Q>
    <xmx:p4MkZHixuQJlq-4f9V6JbctweX2bEQspTCz2GBJI8koRHumEf0Ma-g>
    <xmx:p4MkZHAkZuWIlGYy2lZnHbFOVDBZMtQJaoMWQmMN-fThso5Ndgoaxw>
    <xmx:qIMkZJxwMhtfFXemgZQiJvpNGyShRdUgShYDqAAq1RG92TuOgivf_A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6A0B7B60089; Wed, 29 Mar 2023 14:29:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <50851727-4edd-4d26-a93f-d4780bad4b2e@app.fastmail.com>
In-Reply-To: <20230329160322.GA4477@redhat.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
 <20230329151515.GA913@redhat.com>
 <9a456346-e207-44e1-873e-40d21334e01b@app.fastmail.com>
 <20230329160322.GA4477@redhat.com>
Date:   Wed, 29 Mar 2023 20:29:38 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Oleg Nesterov" <oleg@redhat.com>
Cc:     "Gregory Price" <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>, avagin@gmail.com,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>, krisman@collabora.com,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Jonathan Corbet" <corbet@lwn.net>, shuah <shuah@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, tongtiangen@huawei.com,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Gregory Price" <gregory.price@memverge.com>
Subject: Re: [PATCH v14 1/4] asm-generic,arm64: create task variant of access_ok
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 29, 2023, at 18:03, Oleg Nesterov wrote:
> On 03/29, Arnd Bergmann wrote:
>>
>> I think the idea of TASK_SIZE_MAX is that it is a compile-time constant and in fact independent of current, while TASK_SIZE
>> takes TIF_32BIT into account.
>
> Say, arch/loongarch defines TASK_SIZE which depends on 
> test_thread_flag(TIF_32BIT_ADDR)
> but it doesn't define TASK_SIZE_MAX, so __access_ok() will use TASK_SIZE.

I'd consider that a bug in loongarch, though it's
as harmless as it gets: The only downside is that
it's missing an optimization from constant-folding
the value, and since there is no CONFIG_COMPAT on
loongarch yet, it doesn't even have a different
value.

TASK_SIZE_MAX become mandatory here when I worked
on the optimized access_ok() across architectures,
and the reason it's safe to use is that access_ok()
has to only guarantee that a task cannot access
data that it can't already access, i.e. kernel
data. Passing a pointer between TASK_SIZE and
TASK_SIZE_MAX will still cause a -EFAULT error
because of the trap.

    Arnd
