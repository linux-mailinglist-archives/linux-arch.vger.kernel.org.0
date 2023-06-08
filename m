Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7C172813C
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 15:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbjFHNWl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 09:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbjFHNWg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 09:22:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C7030E3;
        Thu,  8 Jun 2023 06:22:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-256712e2be3so431806a91.2;
        Thu, 08 Jun 2023 06:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686230517; x=1688822517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUpqpc1vO98VvPTojUeoZHMgHdxf8edJLSZpZAoYY1Q=;
        b=GFdfNlDhI2h5Vj6jjGBsG3lM3KLO/u1f4p2776N3e7Q9v5n7blWmcaAvwubQeYQ5cG
         NSIpA3OnQAIu0C8C+Og5Lz8OqMC8zNGy46TlOcy/stu/zGCzLJAp8B4OAMQ0XMRAkMjA
         7dmHga27hfrjNANSQonQJDyjtpbvyqJswrYICaFECy2mTbKw4Xtxwhw202yxl856rzQJ
         uEDlGJDRK7V3IzLQbH8G8ShwRMBznPau5ie+KDcsIkLb0wLFmSBTdVIUcO+sdXGk2gO/
         h5zzdd0x20rov+DBs7fsy/P/Qk+7XX7gW50aVKmsR0XP7zLb2MAoyjNoQlkD6F5YOjBC
         U2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686230517; x=1688822517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aUpqpc1vO98VvPTojUeoZHMgHdxf8edJLSZpZAoYY1Q=;
        b=gajLublP2qxBSX5ENNFW/mvKe00mM+82qTPE5XOViuvIgDqRFoPhJHRaUAZ5jNvpym
         BrFwNlcCctWHQLBYTk3Wt/8uziYQ1N/CESoTEsbgcNNrvvMSGxPKcXE5EbfKfaJCpzrN
         c9feoE+TualUG6wJtO0rhuf6fSbh6hTTXNN+BneNpssG0fqd7Hvqo+aoh50jo/fd11lT
         sQh+FKXwQQmrImrvaopsEgeluKjLi/TsoY+0WVPjDPVCgIQNo9o10soE36SSyr6P7ShT
         abv6ncCPqqjbHfZi+kb4LQAWtXsB8D6AG1himkRoW6IBxmKFGMYCCjQv/qozIqyCKOts
         yfMA==
X-Gm-Message-State: AC+VfDxzg4I+lJWkdquXgsUxudDynDxE2wQ2NAMZCTORO3lLADQRkD/O
        M0Kr1xm31Jm8GQWJODkZatg=
X-Google-Smtp-Source: ACHHUZ5v7OccQU0mX3rPvGQ9M9hPjSXa0rt0RKJ05d1ypkaUZPzmjsimU/fHsSUq8TWpAFVZDKkL0w==
X-Received: by 2002:a17:90b:905:b0:259:bf1:3030 with SMTP id bo5-20020a17090b090500b002590bf13030mr7284342pjb.42.1686230516833;
        Thu, 08 Jun 2023 06:21:56 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id n17-20020a6563d1000000b00513cc8c9597sm1153505pgv.10.2023.06.08.06.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 06:21:56 -0700 (PDT)
Message-ID: <ae2d45da-b0c7-5d2a-8532-3562c31ca820@gmail.com>
Date:   Thu, 8 Jun 2023 21:21:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/9] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-3-ltykernel@gmail.com>
 <BYAPR21MB1688903C92A708680FFE7B91D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <BYAPR21MB1688903C92A708680FFE7B91D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 6/8/2023 9:06 PM, Michael Kelley (LINUX) wrote:
> From: Tianyu Lan<ltykernel@gmail.com>  Sent: Thursday, June 1, 2023 8:16 AM
>> SEV-SNP guest provides vtl(Virtual Trust Level) and
>> get it from Hyper-V hvcall via register hvcall HVCALL_
>> GET_VP_REGISTERS.
>>
>> During initialization of VMBus, vtl needs to be set in the
>> VMBus init message.
> Let's clean up this commit message a bit.  I would suggest:
> 
> SEV-SNP guests on Hyper-V can run at multiple Virtual Trust
> Levels (VTL).  During boot, get the VTL at which we're running
> using the GET_VP_REGISTERs hypercall, and save the value
> for future use.  Then during VMBus initialization, set the VTL
> with the saved value as required in the VMBus init message.
> 

Will update. Thanks to rework change log.
