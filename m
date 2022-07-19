Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99EC57A8D6
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jul 2022 23:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiGSVRx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jul 2022 17:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiGSVRw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 17:17:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EC15E831;
        Tue, 19 Jul 2022 14:17:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso204211pjc.1;
        Tue, 19 Jul 2022 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t8zVqsxAh6PCRXieEJpi3l5hMbcl20okCByenmGuHWI=;
        b=UUP6D56+h2cKFc6QdtHcf9FTK+iDXbTS9hwa7O+E4kOnuP/KjlsqG8DSaHQPfTdZHU
         rnOdRthpThvEu8Jmhez1bAwaePFVcPqUjNUCQO2PNeY2+U1uTJfgXYp+vV6EQc7N9lMu
         adxox/MRXhrotXd8HQGxaEXZ2uyeDFMKNkjlXdRtVEUqVdRpT/edltSSk5i8km3n61J0
         vCQKQKogZr0W4GBKKP1fshbzSgUlWTbrd2zlK79F/GRPrYoPVi+tF8DudvoZrtnYEhp9
         pjmtemAkqpwpcHRn0JWH6ksRVaMu37vBnJPgfEB1wGzSJiDUWwOvDLpEM/AS6NsZfGoz
         yiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t8zVqsxAh6PCRXieEJpi3l5hMbcl20okCByenmGuHWI=;
        b=09G7r/Ptog+BflN8ncsjWfy2yECANcPnLCA/vtr5oMf9dIWhNOiEySzaFVM8kg8LDL
         HVDMXDRbhWWrwB3aX8ECevdFElZQFGljf+mnPVKeso1WtG4dL1V/3z9vBe3z5p/m6mP8
         YYEkvZS6j3uqxQ43CkDG7bmANm7bnbMzLrFtjIUVsMG6i4SdTBMtFUG4aNA0BFz/+aQL
         pNlJ6C+7bOAL4oLN0BArIOl8L6B3/OnHEwVrPqOQiCSqtpnyDL0VhMrNwl7TitMhm5sX
         IgTFGQr7SE/L07W3D90AzXwlK+voLqAog8QBUFXBH5iQX8uaXX1oYbjAQ0mqR6yTOap6
         oZ6Q==
X-Gm-Message-State: AJIora/O1CFwpfyz07WSx/rHSaWT4mAInb/v4Q86YgNmwEkAILoA47xD
        R+nRmpEUKTKPEIhZEspcLSY=
X-Google-Smtp-Source: AGRyM1t9d5EKKKQwZ65RaxzCplS05DEpUzR8MtNVBcQEoUzTSrVGJHJGXOUmFe1RfjO6mFQsF4sXVg==
X-Received: by 2002:a17:90b:4c10:b0:1ef:eb4a:fbb with SMTP id na16-20020a17090b4c1000b001efeb4a0fbbmr1426728pjb.121.1658265470437;
        Tue, 19 Jul 2022 14:17:50 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id gi12-20020a17090b110c00b001e29ddf9f4fsm60022pjb.3.2022.07.19.14.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 14:17:49 -0700 (PDT)
Message-ID: <e790fbe4-aa9c-a5a4-d445-1c4cad8e93e2@gmail.com>
Date:   Tue, 19 Jul 2022 14:17:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] tools: Fixed MIPS builds due to struct flock
 re-definition
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
References: <20220715185551.3951955-1-f.fainelli@gmail.com>
 <CAK8P3a3cuTknZaLZCFGwZtMfbd1qAFWEtXMcvVHsXoJn8EUCOg@mail.gmail.com>
 <2656551b-2c6f-9f0d-93a6-ef6177ec265e@gmail.com>
 <CAK8P3a1LnCz32DixQ2VuBh+c64+CNqNJ8v2Nk0X6P8kYA4=-gQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAK8P3a1LnCz32DixQ2VuBh+c64+CNqNJ8v2Nk0X6P8kYA4=-gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 7/19/2022 2:15 PM, Arnd Bergmann wrote:
> On Tue, Jul 19, 2022 at 9:05 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 7/19/2022 12:42 AM, Arnd Bergmann wrote:
> 
>>> I applied this to the asm-generic tree, but now I'm having second thoughts, as
>>> this only changes the tools/include/ version but not the version we ship to user
>>> space. Normally these are meant to be kept in sync.
>>
>> Thanks! Just to be clear, applying just your patch is not enough as the
>> original build issue is still present, so we would need my change plus
>> yours, I think that is what you intended but just wanted to double
>> confirm.
> 
> Yes, this was just the diff on top of your patch, I've folded it into a single
> commit now.
> 
>> On a side note your tree at:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/refs/heads
>>
>> does not appear to have it included/pushed out yet, should I be looking
>> at another git tree?
> 
> Pushed it out now. There is the main asm-generic branch that is in
> linux-next, and the asm-generic-fixes branch that I should send after
> the build bots report success.
> 
> I've merged the fixes branch into the main branch for testing for the
> moment, but will undo the merge when I forward the contents.

All good, thanks a lot!
-- 
Florian
