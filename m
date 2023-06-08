Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54CD727A92
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 10:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjFHIzw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 04:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbjFHIzt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 04:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DD510EA
        for <linux-arch@vger.kernel.org>; Thu,  8 Jun 2023 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686214502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hy3A1Ua9yZiMcI9cw8LBoikuGcbbLc5s+RNFFyFQvUg=;
        b=M2PgnelvxFy6ovywi/8M5eutj3cIS5slZ9ExqO+IvZdDDA+B5cgCw5yt2b7IcCRbBLEsUt
        pUMPdQ0fboBdbMM85KEw7fUIm/eK2sjj6AXxJ1n9hVQ7jyF8J5TSUCdwRM6BtEAbp2TCgH
        alrCF2qpEWusAmbncb3tAlzzDIF+Vo0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-w2Im70g5OFKEMJ-6lfM2_w-1; Thu, 08 Jun 2023 04:54:59 -0400
X-MC-Unique: w2Im70g5OFKEMJ-6lfM2_w-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75d558057f6so48575285a.3
        for <linux-arch@vger.kernel.org>; Thu, 08 Jun 2023 01:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214499; x=1688806499;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy3A1Ua9yZiMcI9cw8LBoikuGcbbLc5s+RNFFyFQvUg=;
        b=G1MlM5V6f9UXr2RhWUEVjBM+LR3yZQeq90E6TjEd6vM9TaETlZwWrO+6qrtnlOzflN
         bDvQ6b0gPzmj6lBx46ipB/LVJngo+Bw2124wf69tEieHp3UUBmIwoJIsCb3iDG1lOjhp
         4HDbmP3D3hvh2UFQIbikAe3UELOT5Ut27sgmEzI+oeFFgIzNlE8g6/h8CrSUFVcSMTDH
         NKVtSd1IQ2KIswXo4IPYKmBLXOa4STcW00AEGnyqDXK/ClzW+OfRrchvlYcx7GVazrvr
         uT0MAp499GI+vKTlTnpOg5VwglXC4N8VEFU7UHp9qtF+57ceNx6hl/s6jC7MTZJkHu2q
         ZUKQ==
X-Gm-Message-State: AC+VfDw0x/QRdaBqLA5CzpMOLv4JjxIxh/AgaIypnGTFwQ8YIzZlp5cy
        4O9OSQaZmHrxdSGPuagck+eex1eTWb9gUOiBk0q8yy9imEVluN4Gym8xbLaVsG6IKjqXEY4YR4e
        7dSHOMFBrWfH2BGixL12V0Q==
X-Received: by 2002:a05:620a:27cc:b0:75d:5803:a20 with SMTP id i12-20020a05620a27cc00b0075d58030a20mr4694390qkp.68.1686214499113;
        Thu, 08 Jun 2023 01:54:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60oKmeuw06BMJkmeUPBP5oGcgJHw6hr4LDQE1HQbUBnKu5b4VIu+yrq+1gpDjw9S/JAlbteQ==
X-Received: by 2002:a05:620a:27cc:b0:75d:5803:a20 with SMTP id i12-20020a05620a27cc00b0075d58030a20mr4694360qkp.68.1686214497800;
        Thu, 08 Jun 2023 01:54:57 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id pa29-20020a05620a831d00b0074d3233487dsm182509qkn.114.2023.06.08.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:54:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] drivers: hv: Mark shared pages unencrypted in
 SEV-SNP enlightened guest
In-Reply-To: <2803e5d6-58bc-57f1-0721-226333238883@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-5-ltykernel@gmail.com> <87zg5ejchp.fsf@redhat.com>
 <2803e5d6-58bc-57f1-0721-226333238883@gmail.com>
Date:   Thu, 08 Jun 2023 10:54:53 +0200
Message-ID: <87cz26jpuq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> On 6/5/2023 8:54 PM, Vitaly Kuznetsov wrote:
>>> @@ -402,7 +417,14 @@ int hv_common_cpu_die(unsigned int cpu)
>>>   
>>>   	local_irq_restore(flags);
>>>   
>>> -	kfree(mem);
>>> +	if (hv_isolation_type_en_snp()) {
>>> +		ret = set_memory_encrypted((unsigned long)mem, pgcount);
>>> +		if (ret)
>>> +			pr_warn("Hyper-V: Failed to encrypt input arg on cpu%d: %d\n",
>>> +				cpu, ret);
>>> +		/* It's unsafe to free 'mem'. */
>>> +		return 0;
>> Why is it unsafe to free 'mem' if ret == 0? Also, why don't we want to
>> proparate non-zero 'ret' from here to fail CPU offlining?
>> 
>
> Based on Michael's patch the mem will not be freed during cpu offline.
> https://lwn.net/ml/linux-kernel/87cz2j5zrc.fsf@redhat.com/
> So I think it's unnessary to encrypt the mem again here.

Good, you can probably include Michael's patch in your next submission
then (unless it gets merged before that).

-- 
Vitaly

