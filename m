Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FBC48A9FC
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 09:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiAKI7o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 03:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiAKI7m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 03:59:42 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15C5C06173F;
        Tue, 11 Jan 2022 00:59:41 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o12so53844485lfk.1;
        Tue, 11 Jan 2022 00:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6nEJxrC4VF52kQQsquVABp1lWQCr9hliOF685p20gBY=;
        b=TDKbVRvR44rzTiWqaqeJCI2IErsf3K0AkKOncfqrFtzCzzxK0kVQGxuBrfemty+iwh
         0U+AAgBavx+nHC4eWULR8BXDxf1ae1PWYQKKyR9VEXWTtpmD91dMh/7W2ePDJsiUO6xS
         +WVvOGvz1bwB+kuzAT0mLPsQk68VBZU9J6Rjk6FTY2W3pljRrPNFy61Y1v56J8JQ9Ncb
         c3/EdlKXieuTpMbAg/7xj15dezkz8QwP/Lsqzfh7CoydmWvA9hS/Nc7qoTyLFdAQUHsY
         FRS5MvyOhhl+s0D7THITRbRSoSIT2JEZH0u7ds61zsXuSYYFuj1E2FZj0Aqi68FPoxUd
         Mq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6nEJxrC4VF52kQQsquVABp1lWQCr9hliOF685p20gBY=;
        b=3a2+GyhdIMkR9QmVZQfYXy8WiaKPbOgmzkAFXJmhHK1SVAijqts2ZBvpQURqXIqzrV
         zB57344K8t2BUC1FVIGlkwLa9G11j+SMw7b842z3BsphGdEGLZ3O6Uefcu3156qFqm23
         P3sdPUuNurvPEw8hV2xdxhkdz8Dg3ds+neyKMxkfa3PLvRHGPLwcjH0Fe1d4gBZqj/wh
         QU+YNgnJeLkHCh+CcY0Rl960+TD3Tvklb9m8NYraYPB1Oz5ikKPVNAey1zsJ1On7RfcU
         6goZQdDvWWpMkHpaO4KjHvLoqvxbh5AX62Z6OtTnoBXrvDkjbpioYPGSGJqfj7bPZ3Cy
         OC2A==
X-Gm-Message-State: AOAM531q8u4sUMogXJgV84QSfiaPzcsqJlJf61nIDRJ9SXwP/PpGXeKl
        4k3M2LSpTLJ0Qg3WAP6ZK/0=
X-Google-Smtp-Source: ABdhPJxDW5jjSr6LF6rIE41gSK6F+vTyYsZ3vnc92yuIWqQPeWNguXcIK0Tz6CGWst39vHdVQa1Rdg==
X-Received: by 2002:a2e:9c07:: with SMTP id s7mr2246267lji.476.1641891580304;
        Tue, 11 Jan 2022 00:59:40 -0800 (PST)
Received: from ?IPv6:2a00:1370:810c:714f:a10:76ff:fe69:21b6? ([2a00:1370:810c:714f:a10:76ff:fe69:21b6])
        by smtp.googlemail.com with ESMTPSA id e8sm1246693lji.2.2022.01.11.00.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 00:59:39 -0800 (PST)
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211213225350.27481-1-ebiederm@xmission.com>
 <9363765f-9883-75ee-70f1-a1a8e9841812@gmail.com>
 <87pmp67y4r.fsf@email.froward.int.ebiederm.org>
 <5bbb54c4-7504-cd28-5dde-4e5965496625@gmail.com>
 <87bl0m14ew.fsf@email.froward.int.ebiederm.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6692758a-0af2-67e0-26fd-365625b3ad0c@gmail.com>
Date:   Tue, 11 Jan 2022 11:59:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87bl0m14ew.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

08.01.2022 21:13, Eric W. Biederman пишет:
> Dmitry Osipenko <digetx@gmail.com> writes:
> 
>> 05.01.2022 22:58, Eric W. Biederman пишет:
>>>
>>> I have not yet been able to figure out how to run gst-pluggin-scanner in
>>> a way that triggers this yet.  In truth I can't figure out how to
>>> run gst-pluggin-scanner in a useful way.
>>>
>>> I am going to set up some unit tests and see if I can reproduce your
>>> hang another way, but if you could give me some more information on what
>>> you are doing to trigger this I would appreciate it.
>>
>> Thanks, Eric. The distro is Arch Linux, but it's a development
>> environment where I'm running latest GStreamer from git master. I'll try
>> to figure out the reproduction steps and get back to you.
> 
> Thank you.
> 
> Until I can figure out why this is causing problems I have dropped the
> following two patches from my queue:
>  signal: Make SIGKILL during coredumps an explicit special case
>  signal: Drop signals received after a fatal signal has been processed
> 
> I have replaced them with the following two patches that just do what
> is needed for the rest of the code in the series:
>  signal: Have prepare_signal detect coredumps using
>  signal: Make coredump handling explicit in complete_signal
> 
> Perversely my failure to change the SIGKILL handling when coredumps are
> happening proves to me that I need to change the SIGKILL handling when
> coredumps are happening to make the code more maintainable.

Eric, thank you again. I started to look at the reproduction steps and
haven't completed it yet. Turned out the problem affects only older
NVIDIA Tegra2 Cortex-A9 CPU that lacks support of ARM NEON instructions
set, hence the problem isn't visible on x86 and other CPUs out of the
box. I'll need to check whether the problem could be simulated on all
arches or maybe it's specific to VFP exception handling of ARM32.
