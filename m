Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6842ED62F
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 18:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbhAGR65 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 12:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbhAGR65 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jan 2021 12:58:57 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD30C0612F5;
        Thu,  7 Jan 2021 09:58:16 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id h10so4322184pfo.9;
        Thu, 07 Jan 2021 09:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:newsgroups:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hTkzqrCNdP0r0M/fUFV1DV/mK3Fh5BcFABP+peFArds=;
        b=qCvkVAW7GzxhEniptCfQUtsKyYzGgk5rW8/4bIz9sHBwE2Isgyhd8KBe6UAyM8Om/T
         sfbjGnIEXiGsEvsYfifeQBcslPMSQgo6d1CzPtsRE7jQhLkUSGNCqpkyK0T7/33ToOyP
         ZdNl89k8ISaTpcBjDLOPgP4J10ovwyXlIGNSdTQXUz3eJvZQiRU8j1snMV0JeOaVl/GZ
         ZTuoKvnaoyjtKBz4tMOaJL95TCMnBGbeUGrU35UnBUAVP0VNdzWfh0n6fFrtPbIbw4UJ
         yrXT19r8VLm8dP4Y+Pzr+xrDiew06eQvAElhECUmGZVZTfCgyx/AdVANdd6y5c8kJc8D
         zAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:newsgroups:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hTkzqrCNdP0r0M/fUFV1DV/mK3Fh5BcFABP+peFArds=;
        b=nnKQGFsYci/EdRNH7/zYH4/StZCEyRrsBDXm6+aNhX5mqTOcvkSq/A0Cme2ZnTGDv6
         rDb/yFnRQ2KRs816pLkpdxYS61qKCo1DArj9NceYRrH5XpAXItNrTFIohABFNSqnLKRg
         OEGSaDhEW7Dzz0mNEXOZRGRk+jvLLWKBJL1139tyqC2NKVWiLd4EzohQdK338JTmrRlv
         Xpn6Yt19C/wbDfajgHWwOqciqmHb5k+VJ3bfM5nbnbAbjFdZmfxY4HkRy4ajpIFTbq63
         PfNb0owkUyJqnem9oNdzei0r9A87WADAyj3Zm7OYWM6AGSmR9VMR654JC3spEGg9xHTX
         7B6Q==
X-Gm-Message-State: AOAM532JoNI0rqANNYMLdpRIaNT/0YNbzVAO5Ia1+JNr13RKBGbZKT9m
        a/Sev61kWyn1hE1O5bjSHjY=
X-Google-Smtp-Source: ABdhPJzR/BNW8sCHTSftdbijHuVAAOcy+X7BgxMPUvq3C6Xv33E/J822bkKqzWyqjeNNDD3G1v/Ozw==
X-Received: by 2002:aa7:93cf:0:b029:19d:e287:b02b with SMTP id y15-20020aa793cf0000b029019de287b02bmr9856835pff.66.1610042296286;
        Thu, 07 Jan 2021 09:58:16 -0800 (PST)
Received: from [192.168.50.50] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id o193sm6623174pfg.27.2021.01.07.09.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 09:58:09 -0800 (PST)
Sender: Vineet Gupta <vineetg76@gmail.com>
Subject: Re: ARC no console output (was Re: [PATCH 1/2] init/console: Use
 ttynull as a fallback when there is no console)
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, buildroot@busybox.net,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arch@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>
Newsgroups: gmane.linux.kernel.cross-arch,gmane.linux.kernel,gmane.linux.kernel.arc
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
 <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
 <8735zdm86m.fsf@jogness.linutronix.de>
 <50ade852-c598-6476-1f4b-9a3f8d11d143@synopsys.com> <X/c/ONCYz2QQdvOP@alley>
From:   Vineet Gupta <vgupta@synopsys.com>
Message-ID: <466644f5-bed7-caef-9fcd-e66208f65545@synopsys.com>
Date:   Thu, 7 Jan 2021 09:58:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X/c/ONCYz2QQdvOP@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/7/21 9:04 AM, Petr Mladek wrote:
> On Thu 2021-01-07 08:43:16, Vineet Gupta wrote:
>> Hi John,
>>
>> On 1/7/21 1:02 AM, John Ogness wrote:
>>> Hi Vineet,
>>>
>>> On 2021-01-06, Vineet Gupta <vgupta@synopsys.com> wrote:
>>>> This breaks ARC booting (no output on console).
>>>
>>> Could you provide the kernel boot arguments that you use? This series is
>>> partly about addressing users that have used boot arguments that are
>>> technically incorrect (even if had worked). Seeing the boot arguments of
>>> users that are not experiencing problems may help to reveal some of the
>>> unusual console usages until now.
>>
>>
>> Kernel command line: earlycon=uart8250,mmio32,0xf0005000,115200n8
>> console=ttyS0,115200n8 debug print-fatal-signals=1
> 
> This is strange, the problematic patch should use ttynull
> only as a fallback. It should not be used when a particular console
> is defined on the command line.

What happens in my case is console_on_rootfs() doesn't find /dev/console 
and switching to ttynull. /dev is not present because devtmpfs doesn't 
automount for initramfs.

> The only explanation would be that ttyS0 gets registered too late
> and ttynull is added as a fallback in the meantime.

I don't know if ttyS0 console should have registered already but even if 
it did - the /dev node missing would not have helped ?

> 
> Anyway, I propose the revert the problematic patch for 5.11-rc3,
> see
> https://lore.kernel.org/lkml/20210107164400.17904-2-pmladek@suse.com/
> This mystery is a good reason to avoid bigger changes at this stage.
> 
> Best Regards,
> Petr
> 

