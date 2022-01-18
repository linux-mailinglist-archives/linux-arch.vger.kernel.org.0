Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616C8492CE9
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jan 2022 19:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347661AbiARSCD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jan 2022 13:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbiARSCC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jan 2022 13:02:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CA8C061574;
        Tue, 18 Jan 2022 10:02:02 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x11so48298735lfa.2;
        Tue, 18 Jan 2022 10:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QiAYKjTm8yD92XhgjPaR67VG7bLzABGjG4SsDGOnGC0=;
        b=RLcSm7MEm7UV7/oj+FKDlyFwVsC8JJeQauMFbVIUrow6FpXJjO9HDUEo+Rd2EqDAuY
         8XdR5OMHFybg/QbPQ6fPJLmrbjDmeE6fwCmgvw0aRIeXp1ikMST7uKhRgLXCP4qGwO5v
         sri3lE0vJf/xkfMfhsVD8GhXOtmHs0lNSDiVOl7cq9nD8IJ8qrejhPNmurl5t3VaTGFS
         5HAy+wRTY6NEj83xhXa6SouxQEgtEBDJ/1ihH4YT3VTC3vZZ5eZpnI3AFRhTPdGDsrgO
         /xUSFd3id6/pJbgYv6haEksntoFiGMBVooeqYgIZlR/YbuaEFruZf4qYjI4bd04zCbf5
         Ea6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QiAYKjTm8yD92XhgjPaR67VG7bLzABGjG4SsDGOnGC0=;
        b=K/5l4o3Ja6f93VKkYKrf5/neR53kmIoDjYZ8INXlQ5Ee+BuEeosih+uOmINB5yq0Va
         nr9dCEeR7qej2X8mX8yOjuTHgyKEK75h73JIZHPYpWSWD3VQPDMMQKfo+L1OGopyYYIF
         VKG6fKlez2fgWyjMYvbVwrTRR2zyQA5IQF4/ltJudr0bkOZx0qRakHt8pvqd2NBQQ9H8
         uCtDhh+/06pq7NztZWw2fI0dW+3HR69O9Sx1IeYHRCswbqwodg+8ujbmH+QV90/mBuV9
         rgmMitjbhvYmu5Qt23UpK7LDfV33V+YBT4PppmXvyNBa7Bb+LpzFHzhBxjm+AfzThihF
         HEAA==
X-Gm-Message-State: AOAM531pwCYKoeCzHDjypo1EdgiQxkPHu7fa264wZJo5ojSGooJhHW29
        xRI+RkIgA+4dHRJM1CzExow=
X-Google-Smtp-Source: ABdhPJxhUpGZSX++90qH47a+zY/EYePc2AtzAPiEB+D9aUTOJQ2K36zKUUDRe2nplPSgW1+yhDsiaw==
X-Received: by 2002:a05:6512:39cc:: with SMTP id k12mr22210304lfu.372.1642528920783;
        Tue, 18 Jan 2022 10:02:00 -0800 (PST)
Received: from [192.168.2.145] (46-138-227-157.dynamic.spd-mgts.ru. [46.138.227.157])
        by smtp.googlemail.com with ESMTPSA id h13sm1755350lfe.226.2022.01.18.10.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 10:02:00 -0800 (PST)
Message-ID: <37ba0a3a-da54-0e35-41d6-d5fd766df618@gmail.com>
Date:   Tue, 18 Jan 2022 21:01:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
Content-Language: en-US
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
 <6692758a-0af2-67e0-26fd-365625b3ad0c@gmail.com>
 <87iluqtcj3.fsf@email.froward.int.ebiederm.org>
 <99353796-eea7-b765-f355-46e50f1b8773@gmail.com>
 <87o8496idj.fsf@email.froward.int.ebiederm.org>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <87o8496idj.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

18.01.2022 20:52, Eric W. Biederman пишет:
> Dmitry Osipenko <digetx@gmail.com> writes:
> 
>> 11.01.2022 20:20, Eric W. Biederman пишет:
>>> Dmitry Osipenko <digetx@gmail.com> writes:
>>>
>>>> 08.01.2022 21:13, Eric W. Biederman пишет:
>>>>> Dmitry Osipenko <digetx@gmail.com> writes:
>>>>>
>>>>>> 05.01.2022 22:58, Eric W. Biederman пишет:
>>>>>>>
>>>>>>> I have not yet been able to figure out how to run gst-pluggin-scanner in
>>>>>>> a way that triggers this yet.  In truth I can't figure out how to
>>>>>>> run gst-pluggin-scanner in a useful way.
>>>>>>>
>>>>>>> I am going to set up some unit tests and see if I can reproduce your
>>>>>>> hang another way, but if you could give me some more information on what
>>>>>>> you are doing to trigger this I would appreciate it.
>>>>>>
>>>>>> Thanks, Eric. The distro is Arch Linux, but it's a development
>>>>>> environment where I'm running latest GStreamer from git master. I'll try
>>>>>> to figure out the reproduction steps and get back to you.
>>>>>
>>>>> Thank you.
>>>>>
>>>>> Until I can figure out why this is causing problems I have dropped the
>>>>> following two patches from my queue:
>>>>>  signal: Make SIGKILL during coredumps an explicit special case
>>>>>  signal: Drop signals received after a fatal signal has been processed
>>>>>
>>>>> I have replaced them with the following two patches that just do what
>>>>> is needed for the rest of the code in the series:
>>>>>  signal: Have prepare_signal detect coredumps using
>>>>>  signal: Make coredump handling explicit in complete_signal
>>>>>
>>>>> Perversely my failure to change the SIGKILL handling when coredumps are
>>>>> happening proves to me that I need to change the SIGKILL handling when
>>>>> coredumps are happening to make the code more maintainable.
>>>>
>>>> Eric, thank you again. I started to look at the reproduction steps and
>>>> haven't completed it yet. Turned out the problem affects only older
>>>> NVIDIA Tegra2 Cortex-A9 CPU that lacks support of ARM NEON instructions
>>>> set, hence the problem isn't visible on x86 and other CPUs out of the
>>>> box. I'll need to check whether the problem could be simulated on all
>>>> arches or maybe it's specific to VFP exception handling of ARM32.
>>>
>>> It sounds like the gstreamer plugins only fail on certain hardware on
>>> arm32, and things don't hang in coredumps unless the plugins fail.
>>> That does make things tricky to minimize.
>>>
>>> I have just verified that the known problematic code is not
>>> in linux-next for Jan 11 2022.
>>>
>>> If folks as they have time can double check linux-next and verify all is
>>> well I would appreciate it.  I don't expect that there are problems but
>>> sometimes one problem hides another.
>>
>> Hello Eric,
>>
>> I reproduced the trouble on x86_64.
>>
>> Here are the reproduction steps, using ArchLinux and linux-next-20211224:
>>
>> ```
>> sudo pacman -S base-devel git mesa glu meson wget
>> git clone https://github.com/grate-driver/gstreamer.git
>> cd gstreamer
>> git checkout sigill
>> meson --prefix=/usr -Dgst-plugins-base:playback=enabled -Dgst-devtools:validate=disabled build
>> cd build
>> sudo ninja install
>> wget https://www.peach.themazzone.com/big_buck_bunny_720p_h264.mov
>> rm -r ~/.cache/gstreamer-1.0
>> gst-play-1.0 ./big_buck_bunny_720p_h264.mov
>> ```
>>
>> The SIGILL, thrown by [1], causes the hang. There is no hang using v5.16.1 kernel. 
>>
>> [1] https://github.com/grate-driver/gstreamer/commit/006f9a2ee6dcf7b31c9b5413815d6054d82a3b2f
> 
> Thank you.
> 
> I will verify this works before I add my updated version to
> my signal-for-v5.18 branch.
> 
> Have you by any chance tried a newer version of linux-next without
> commit fbc11520b58a ("signal: Make SIGKILL during coredumps an explicit
> special case") in it?
> 
> If not I will double check that my pulling the commit out does not break
> in the case you have documented.

Recent linux-next works fine.

