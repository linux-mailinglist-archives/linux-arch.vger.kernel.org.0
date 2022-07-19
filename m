Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A5C578F20
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jul 2022 02:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbiGSARg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Jul 2022 20:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiGSARf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Jul 2022 20:17:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A372F6349;
        Mon, 18 Jul 2022 17:17:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 5so10495006plk.9;
        Mon, 18 Jul 2022 17:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=7Voy8x4hq/Io3/fC7rr8/pnXiYjGneXM+CTyZShqxH0=;
        b=hg/ZsqiKtd+dN+FrNe3IqgScPtci1LI9Q3LC+WpsP2UaYsfKeWKF1FIuGT/ZRrR0V7
         wEg4GyZAqCsju630oexwPaR6TQ+mtCZsWDjNkfKY8GDy+NysH3WpwodEWrcjkrJjmWB7
         KSF+N1alVcbh4uE9cvuPrBZvVgmXxJIak4SN9bBAP1Ya6am3dZBBntBL0XebRr7aMwOE
         h9xLUk4Rdpg2YxFhD+D23KLlRPmVimufYmQdZp4JYZVKJqLXstRGxLW7KkH09VZtmbHs
         VrfDs4M/JoR2IoWivnXyK3RYeZ/hUjHYXtYf0MvVt6Anm9g4o/hNXT4LYf0O/Md+zbz3
         umFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=7Voy8x4hq/Io3/fC7rr8/pnXiYjGneXM+CTyZShqxH0=;
        b=UM4yMMwJjgUX5EObkzMLh5FMDLFPawD016q1An2o/OemGuQMtp+Wukc6aNXrzdda/K
         qM9LO38/XSyBeNc2EA58lGfU8Y6SljdFnIXoL7sPAU9DZeLhftoIaDCo6n0CxCJpuGAv
         2DJdWmZv6+5AdJqTINIWVr/YEufergb3cYT1XVoeXpJXCc58KpAio+BYl7tzNfy/O/DQ
         wcjlkr+qeE2fuFZ79hcgjoEkmMqmbpEEcCq5+Sqwshg41aye0C76hWSqaUs5fecBrmXn
         3Dth6XaS3F/AkhJrD8TQAQVRzvOLxJrmWf7iIutl0olejK4pdz8SB0o/Y4JwGhGVeRpF
         KBdw==
X-Gm-Message-State: AJIora9lthf3LYES+tqtrCWmIOhuE9OBISZd1AxyJkcTL3mLHZ80ijXz
        3oQJeWR2A6RMI+yfIzCRZcsW/Ml4JE0=
X-Google-Smtp-Source: AGRyM1tfLsy5d8QCz/p9MQZe8MQUjPHkRe2mGXMkYgff5fn2Li3xTmOK5b1B+yQ9mo3Kfy5LMCmAIg==
X-Received: by 2002:a17:90b:4c86:b0:1f0:3255:542e with SMTP id my6-20020a17090b4c8600b001f03255542emr35116557pjb.119.1658189852793;
        Mon, 18 Jul 2022 17:17:32 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027e4800b0016cbb46806asm9073697pln.278.2022.07.18.17.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 17:17:32 -0700 (PDT)
Message-ID: <643cdbc4-b539-f99f-6f3b-d3c5895d6038@gmail.com>
Date:   Mon, 18 Jul 2022 17:17:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] tools: Fixed MIPS builds due to struct flock
 re-definition
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, hch@lst.de,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Cc:     nathan@kernel.org, naresh.kamboju@linaro.org, heiko@sntech.de,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
References: <20220715185551.3951955-1-f.fainelli@gmail.com>
 <846d3845-1536-3306-b68d-d0097a2ff8ff@gmail.com>
In-Reply-To: <846d3845-1536-3306-b68d-d0097a2ff8ff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 7/16/2022 4:21 PM, Florian Fainelli wrote:
> Le 15/07/2022 à 11:55, Florian Fainelli a écrit :
>> Building perf for MIPS failed after 9f79b8b72339 ("uapi: simplify
>> __ARCH_FLOCK{,64}_PAD a little") with the following error:
>>
>>    CC
>> /home/fainelli/work/buildroot/output/bmips/build/linux-custom/tools/perf/trace/beauty/fcntl.o
>> In file included from
>> ../../../../host/mipsel-buildroot-linux-gnu/sysroot/usr/include/asm/fcntl.h:77,
>>                   from ../include/uapi/linux/fcntl.h:5,
>>                   from trace/beauty/fcntl.c:10:
>> ../include/uapi/asm-generic/fcntl.h:188:8: error: redefinition of
>> 'struct flock'
>>   struct flock {
>>          ^~~~~
>> In file included from ../include/uapi/linux/fcntl.h:5,
>>                   from trace/beauty/fcntl.c:10:
>> ../../../../host/mipsel-buildroot-linux-gnu/sysroot/usr/include/asm/fcntl.h:63:8:
>> note: originally defined here
>>   struct flock {
>>          ^~~~~
>>
>> This is due to the local copy under
>> tools/include/uapi/asm-generic/fcntl.h including the toolchain's kernel
>> headers which already define 'struct flock' and define
>> HAVE_ARCH_STRUCT_FLOCK to future inclusions make a decision as to
>> whether re-defining 'struct flock' is appropriate or not.
>>
>> Make sure what do not re-define 'struct flock'
>> when HAVE_ARCH_STRUCT_FLOCK is already defined.
>>
>> Fixes: 9f79b8b72339 ("uapi: simplify __ARCH_FLOCK{,64}_PAD a little")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
> 
> Any chance to apply this patch prior to v5.19 being final? Thanks!

Ping?
-- 
Florian
