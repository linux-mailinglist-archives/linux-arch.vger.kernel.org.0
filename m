Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64AC492C67
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jan 2022 18:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiARRa6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jan 2022 12:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiARRa5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jan 2022 12:30:57 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90FBC061574;
        Tue, 18 Jan 2022 09:30:56 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id br17so73689132lfb.6;
        Tue, 18 Jan 2022 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kd+ihHSa65bZsYesw4D/FyTF+Vo+oGBmiX15FDAQBXk=;
        b=e13PFa9kUnXLdHA7Q1zZ95wii6tWgGfOPp0QNoBAFP/eLrG1Ubit7uyDezbQqsrGnv
         8roNME9Q6nZjaWFe/sfws3oDxQGesuTonq0wNGYGZ380zn5cZyfyWB6h4phl5TvbbECQ
         BWC8Z4lLxrH9Ow9SutdvCZYOWDac7fOJdUC6WM9JATZRpgbrTVLUEW1woV/L4N4BX4MM
         RqUSfdenWGAOf9wHTXdbmN0KhcesEenPbMRLQBF2CbC/K9sF4slFVaOiLHFhSP/NCVTk
         4tnVLabvDMxIkSUAI8gdZsGIyquPUiDcWSK/0XEyKSM53rV1VCbKcwn+eWjZirqb0i+H
         zchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kd+ihHSa65bZsYesw4D/FyTF+Vo+oGBmiX15FDAQBXk=;
        b=FiaOqv8alezADDYkJB5RQEo16rRPpLkSLvKzNzutpwsMLAmjQj3cKq00eaQ3HGCArR
         KKYpn6OMO3bDmF1catH1IWAcBxUqxhn2P1NwanW6x8QrczIFsvBDOks66q0YW04H8gpe
         IDU9quAKkxfIhT1zDyDqjw+bp9eOH84UFLzue7WJ9YrLeUMuyMDR8KG71oVbOheb4UPT
         nCf4CE4L3UodxLKjHOFEi2Hfx4mXQtzdpA+IUHATeGGnjeuvW8tNJlW+UcM3qOkMSQTk
         T/5BPX28UGHtQBUKLf8G3CFzKrx+FW4FT6vpB6wpt8Ldiv6L951oYmj+YGeX5ltng1sz
         /liA==
X-Gm-Message-State: AOAM531G00kt7prpSzdb4+7mKjTFUd8Dn5yRY/7qgMNl+kKvaCIz2Dld
        GLeabaRv8sou7F7Jo9yt9C0tUw9e+vQ=
X-Google-Smtp-Source: ABdhPJxvN0s/tHa9KOkWnm2uUIZUZLh8EQBSFrgC9FL8hALhMK6XhLbQQsY/Z1iA+1VidzrnHhLOFw==
X-Received: by 2002:ac2:5217:: with SMTP id a23mr22664021lfl.684.1642527055166;
        Tue, 18 Jan 2022 09:30:55 -0800 (PST)
Received: from [192.168.2.145] (46-138-227-157.dynamic.spd-mgts.ru. [46.138.227.157])
        by smtp.googlemail.com with ESMTPSA id t6sm1751911lfl.286.2022.01.18.09.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 09:30:54 -0800 (PST)
Message-ID: <99353796-eea7-b765-f355-46e50f1b8773@gmail.com>
Date:   Tue, 18 Jan 2022 20:30:53 +0300
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
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <87iluqtcj3.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

11.01.2022 20:20, Eric W. Biederman пишет:
> Dmitry Osipenko <digetx@gmail.com> writes:
> 
>> 08.01.2022 21:13, Eric W. Biederman пишет:
>>> Dmitry Osipenko <digetx@gmail.com> writes:
>>>
>>>> 05.01.2022 22:58, Eric W. Biederman пишет:
>>>>>
>>>>> I have not yet been able to figure out how to run gst-pluggin-scanner in
>>>>> a way that triggers this yet.  In truth I can't figure out how to
>>>>> run gst-pluggin-scanner in a useful way.
>>>>>
>>>>> I am going to set up some unit tests and see if I can reproduce your
>>>>> hang another way, but if you could give me some more information on what
>>>>> you are doing to trigger this I would appreciate it.
>>>>
>>>> Thanks, Eric. The distro is Arch Linux, but it's a development
>>>> environment where I'm running latest GStreamer from git master. I'll try
>>>> to figure out the reproduction steps and get back to you.
>>>
>>> Thank you.
>>>
>>> Until I can figure out why this is causing problems I have dropped the
>>> following two patches from my queue:
>>>  signal: Make SIGKILL during coredumps an explicit special case
>>>  signal: Drop signals received after a fatal signal has been processed
>>>
>>> I have replaced them with the following two patches that just do what
>>> is needed for the rest of the code in the series:
>>>  signal: Have prepare_signal detect coredumps using
>>>  signal: Make coredump handling explicit in complete_signal
>>>
>>> Perversely my failure to change the SIGKILL handling when coredumps are
>>> happening proves to me that I need to change the SIGKILL handling when
>>> coredumps are happening to make the code more maintainable.
>>
>> Eric, thank you again. I started to look at the reproduction steps and
>> haven't completed it yet. Turned out the problem affects only older
>> NVIDIA Tegra2 Cortex-A9 CPU that lacks support of ARM NEON instructions
>> set, hence the problem isn't visible on x86 and other CPUs out of the
>> box. I'll need to check whether the problem could be simulated on all
>> arches or maybe it's specific to VFP exception handling of ARM32.
> 
> It sounds like the gstreamer plugins only fail on certain hardware on
> arm32, and things don't hang in coredumps unless the plugins fail.
> That does make things tricky to minimize.
> 
> I have just verified that the known problematic code is not
> in linux-next for Jan 11 2022.
> 
> If folks as they have time can double check linux-next and verify all is
> well I would appreciate it.  I don't expect that there are problems but
> sometimes one problem hides another.

Hello Eric,

I reproduced the trouble on x86_64.

Here are the reproduction steps, using ArchLinux and linux-next-20211224:

```
sudo pacman -S base-devel git mesa glu meson wget
git clone https://github.com/grate-driver/gstreamer.git
cd gstreamer
git checkout sigill
meson --prefix=/usr -Dgst-plugins-base:playback=enabled -Dgst-devtools:validate=disabled build
cd build
sudo ninja install
wget https://www.peach.themazzone.com/big_buck_bunny_720p_h264.mov
rm -r ~/.cache/gstreamer-1.0
gst-play-1.0 ./big_buck_bunny_720p_h264.mov
```

The SIGILL, thrown by [1], causes the hang. There is no hang using v5.16.1 kernel. 

[1] https://github.com/grate-driver/gstreamer/commit/006f9a2ee6dcf7b31c9b5413815d6054d82a3b2f

