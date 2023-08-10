Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB02777E18
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 18:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjHJQWs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 12:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjHJQWr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 12:22:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6F9A8;
        Thu, 10 Aug 2023 09:22:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdaeb0f29aso2876975ad.2;
        Thu, 10 Aug 2023 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691684566; x=1692289366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBxuuRBGx37tQ5XIQd6hBtuu9RLCe7TcvWshiqvJ6Ig=;
        b=hgQ8PWMkP2K0rSExr6a+qhX3F0ukmJLk0DfQrMX1iZo+xMyjKV9CoZegiNwm+EcG+r
         zJbcpKajI7y/wOrYxn+4CTSYBa+rUKUg6kHN8bfWMB1iblfeFHeDKSsshGJhRKLAkElF
         ejsC3aZtMvpojv5MhEsuJfIp4KENrn5ODkvDR+l/5ANrP2Cky6o9GIohuhthkV6umPf7
         32dAvU0TjigyGZ+tWhm8zVhyJsdVXVEzndpZTF97gZ1uGQuLkBzLQbshAg/oTAz58itK
         M4gc0zvUwbNGRbczqVL42RQtQ9U6fuS6EFUsGw6XUAsbxeJ5PhMD479ITmKOn1RFKMiv
         j4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684566; x=1692289366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LBxuuRBGx37tQ5XIQd6hBtuu9RLCe7TcvWshiqvJ6Ig=;
        b=iOcWVnjqO6k4bmTI6zPV8z9guLXTFkPwLdAam5CnLJdsUP7TErL3GinLpybHortwGG
         Y3lr7AxKV1o4iOKlO1EuagFly5HFr2wST5xzwmiCLF0qqAAgOHFTeqj/RBsdXBvNzGiZ
         y/brzYYGHsoce5KxDGdLYx58iG5QPadfQUbfF54lOdCzms2Jr9Z0lmH9lPCdTjyVlZnn
         KWh7dbDqGEJh8IhDekhjaU0nOOzebqG2lkxM+p9m0IdOlWPM1j+6FCI57luzt1voKV5A
         Me6XFGh/rgSkA30PpKMtXnd0YY5EHwJ3Lx+6y2ibx7bCxX09wXNnzyAzc6ykYAfZYkk+
         QLOQ==
X-Gm-Message-State: AOJu0Yzb0ZPrqkL8zVAPQUh0qqtAX0cHFvsIK3dHxcYPE6PV43fBnpmq
        BdaV5ZHjtyIoJgl18gpASko=
X-Google-Smtp-Source: AGHT+IGz0JmplIzBvF6jsyASn31jPQ/ydbP+pgRBs/DbtZZx8p0q2kZlCd/dGEz0nBARuWJVoVjFAg==
X-Received: by 2002:a17:902:bd4c:b0:1b1:99c9:8ce1 with SMTP id b12-20020a170902bd4c00b001b199c98ce1mr2330144plx.51.1691684566496;
        Thu, 10 Aug 2023 09:22:46 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001b9c960ffeasm1981122plg.47.2023.08.10.09.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 09:22:46 -0700 (PDT)
Message-ID: <da667608-a8aa-f5b8-1621-de29b3f19272@gmail.com>
Date:   Fri, 11 Aug 2023 00:22:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXTERNAL] [PATCH V2 2/9] x86/hyperv: Set Virtual Trust Level in
 VMBus init message
To:     Wei Liu <wei.liu@kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
 <20230627032248.2170007-3-ltykernel@gmail.com>
 <PUZP153MB0749BAAA8E288D76938704A5BE2DA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <ZNB3m6Qiml7JDTQ7@liuwe-devbox-debian-v2>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <ZNB3m6Qiml7JDTQ7@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/7/2023 12:48 PM, Wei Liu wrote:
> On Fri, Jul 07, 2023 at 09:07:54AM +0000, Saurabh Singh Sengar wrote:
>>
>>
>>> +
>>> +	ret = hv_do_hypercall(control, input, output);
>>> +	if (hv_result_success(ret))
>>> +		vtl = output->as64.low & HV_X64_VTL_MASK;
>>> +	else
>>> +		pr_err("Hyper-V: failed to get VTL! %lld", ret);
>>
>> In case of error this function will return vtl=0, which can be the valid value of vtl.
>> I suggest we initialize vtl with -1 so and then check for its return.
>>
>> This could be a good utility function which can be used for any Hyper-V VTL system, so think
>> of making it global ?
>>
> 
> Tianyu -- your thought on this?

In current user cases, the guest only runs in VTL0 and Hyper-V may
return VTL error in some cases but kernel still may run with 0 as VTL.

I just sent out v5 and set VTL to 0 by default if fail to get VTL from
Hyper-V and give out a warning log. The get_vtl() is only called on 
enlightened SEV-SNP guest. If there is new case that needs handle the 
error from Hyper-V when call VTL hvcall, we may add the logic later.
