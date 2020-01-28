Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7617214BFF6
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2020 19:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgA1Sgw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jan 2020 13:36:52 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46580 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgA1Sgw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jan 2020 13:36:52 -0500
Received: by mail-yw1-f66.google.com with SMTP id u139so6955597ywf.13;
        Tue, 28 Jan 2020 10:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UAaJIyMCtfqDJNVGPg+VIxoXHpPloRjdhA2WOZPQuQo=;
        b=nnkrjD/4eh4orr4I9QZwg2tsLzI/F7M1p9TKAUtbzdELO0mgklmIYiLAd5geqGJB7u
         Vp9oLuyidZqIeV7sAIANKB3mkgnupXSadCS4j0ObyivnC1i/tOddlV+vsuPIAUU/ls0S
         tZdA+/o1Az2iRUa9PGDQFPxR9n3pBaosh6ftpPW/oUWtDGnEQR86U1UHFcHpkrH2Yoav
         qsqdzeTyoPS7xLCPxDSuogcNkMEJmctyj/vAJmazWs7EdBXnpdIM7fL9CgI6Mo0yJt9S
         mTieWkt4sPblkKDg4sBkH/Pz3ShgtahvE3GOOdX+stAg3SdoXe33CdibMKAfBbQ8fLQZ
         E22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UAaJIyMCtfqDJNVGPg+VIxoXHpPloRjdhA2WOZPQuQo=;
        b=NtKn0n3iOrcvT8wU5tX1XPsswCtOIwKf7w9Pv31p8GVH8Q6vKT0EhuQCq69BrSApo8
         LAgg3VwlFVBYqduZ+AW5uEaNr8BSqpxx7QCofrBTI4b8nZjQo36oCEDVWDLyWdhYtPau
         Y8tDNxTujanGxmpauGeZdGMQDV1NuiWpfS9Oif8aKZ5FuW4ghoqz+Gg8LoZ3HtGZucT2
         AMpJsjlJOvV8w4TvNhO6k4NhHSn9Jd3qntos/pwJ8fbdcllvPf0qO20DGH5Y/eLEH8BT
         EeBgfJM91wJkTFyHiUx2iDNTYwiDs0CbIbTaDCilHVy6gMoUB5C4ZdCbzQHO+D47NV7O
         ikhg==
X-Gm-Message-State: APjAAAX8997Rb5FkXJdKIbadhzmb2liggl+abXQAmp2ssFfktZujtoCh
        nOh6J53+CrzeaAGN4/LTwNE=
X-Google-Smtp-Source: APXvYqyzGvSY0gHjoEHGMOB4+0FYgIao/sa1DMQ5fP8MYcSTPmpU8qNnV4/4N227yIsPKr6z1eGTOA==
X-Received: by 2002:a0d:df15:: with SMTP id i21mr2024857ywe.73.1580236610860;
        Tue, 28 Jan 2020 10:36:50 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id t3sm8858935ywi.18.2020.01.28.10.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 10:36:50 -0800 (PST)
Subject: Re: [RFC v1 0/6] kunit: create a centralized executor to dispatch all
 KUnit tests
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20200106224022.GX11244@42.do-not-panic.com>
 <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
 <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com>
 <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com>
Date:   Tue, 28 Jan 2020 12:36:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/28/20 1:19 AM, Brendan Higgins wrote:
> On Mon, Jan 27, 2020 at 9:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 1/23/20 4:40 PM, Brendan Higgins wrote:
>>> Sorry for the late reply. I am still catching up from being on vacation.
>>>>> On Mon, Jan 6, 2020 at 2:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>>> It does beg the question if this means kunit is happy to not be a tool
>>>> to test pre basic setup stuff (terminology used in init.c, meaning prior
>>>> to running all init levels). I suspect this is the case.
>>>
>>> Not sure. I still haven't seen any cases where this is necessary, so I
>>> am not super worried about it. Regardless, I don't think this patchset
>>> really changes anything in that regard, we are moving from late_init
>>> to after late_init, so it isn't that big of a change for most use
>>> cases.
>>>
>>> Please share if you can think of some things that need to be tested in
>>> early init.
>>
>> I don't have a specific need for this right now.  I had not thought about
>> how the current kunit implementation forces all kunit tests to run at a
>> specific initcall level before reading this email thread.
>>
>> I can see the value of being able to have some tests run at different
>> initcall levels to verify what functionality is available and working
>> at different points in the boot sequence.
> 
> Let's cross that bridge when we get there. It should be fairly easy to
> add that functionality.

Yes. I just wanted to add the thought to the back of your mind so that
it does not get precluded by future changes to the kunit architecture.

> 
>> But more important than early initcall levels, I do not want the
>> framework to prevent using or testing code and data that are marked
>> as '__init'.  So it is important to retain a way to invoke the tests
>> while __init code and data are available, if there is also a change
>> to generally invoke the tests later.
> 
> Definitely. For now that still works as long as you don't build KUnit
> as a module, but I think Alan's new patches which allow KUnit to be
> run at runtime via debugfs could cause some difficulty there. Again,

Yes, Alan's patches are part of what triggered me thinking about the
issues I raised.


> we could add Kconfigs to control this, but the compiler nevertheless
> complains because it doesn't know what phase KUnit runs in.
> 
> Is there any way to tell the compiler that it is okay for non __init
> code to call __init code? I would prefer not to have a duplicate
> version of all the KUnit libraries with all the symbols marked __init.

I'm not sure.  The build messages have always been useful and valid in
my context, so I never thought to consider that possibility.

> Thoughts?
> .
> 

