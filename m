Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A957E483E86
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 09:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiADI5M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 03:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiADI5M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 03:57:12 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAF5C061761
        for <linux-arch@vger.kernel.org>; Tue,  4 Jan 2022 00:57:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q16so74713552wrg.7
        for <linux-arch@vger.kernel.org>; Tue, 04 Jan 2022 00:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4cF4HbSP7vj3/CJACW3D9vQewImE5qZUDPLvd4VxrNc=;
        b=WDTtVW0ZIN118o8KdQnCZPX+LwjGEWfMQuz7r+8GNiIXtcf8rxQGtn0+Tz/XRGO7Fb
         Ty9TavyQLy7lhJQqhg+gQCYHPCh5uUcvxC8wz2/hkgFI6FloDAbmuQC9WaQ9SApDvjas
         OVW1WuGjiAmmYcbSxjcOviiTtD13ezQfApfoccZkkOLE/LGanLWdqpSLobHGfJOyu+Vk
         E+QvBOS9XZcgFVBZSjOxnJAkDFjB4Ly5o37L1QoyAnLCYZoU2ls9kAT3nu33WV/xg/6V
         zRlUCVtcHlcSwqiFC/2TIySvhlirIj/lkKJpOLug+Qjfeh66LBz0LhX2swkyb0mofyDP
         xuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4cF4HbSP7vj3/CJACW3D9vQewImE5qZUDPLvd4VxrNc=;
        b=xQGTQgPZYMyCzyov+vTLB5ja3RLwUbuSkzwoctQS91/49I3XHz1avb6CPz/qPl4kFP
         px4zhT796Yb9K8y85DNoXxmQ3kzdOJGISXcziDkyShSc/YLIyLqzIgq0Sgx/IAdSM5Bk
         pBGHx0GN1PeiFwu/32UE0joKssFLwbKr4K15IgZTUf/anZS8EFM3I+eg3ZcpH39zQPdG
         2dT3R7+K9ioE3LJ3lfo3wUox8A1B7oHcDWI+o45xliYLmgTj4y/VEfG9Pri55bKVzlmL
         h1wKrWkeNxT9KD0vwDzwCPos1t/wI8lxCo5tsN1rQaco6uFDoo9CCz4IfE9nDsFWXv1O
         JAvg==
X-Gm-Message-State: AOAM533xKVWpoH+79S/GhG7pG14dGNDHinGeomY9/r1hUogNjbcsf0+Q
        cbauPakmJvcUbHmZqu7qmYUhoMKjpPctjcQB
X-Google-Smtp-Source: ABdhPJwdUe03TxCmaVHV+/esRqk7C9abrtFsmQ5AAstXJU4XjIvFk/t2hSFYK6qduk4yzEW5/Oe8Eg==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr40336287wrs.136.1641286630238;
        Tue, 04 Jan 2022 00:57:10 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:89f7:42f5:f994:4724? ([2a01:e34:ed2f:f020:89f7:42f5:f994:4724])
        by smtp.googlemail.com with ESMTPSA id e13sm39811439wmq.10.2022.01.04.00.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 00:57:09 -0800 (PST)
Subject: Re: [PATCH v5 1/6] powercap/drivers/dtpm: Move dtpm table from init
 to data section
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-2-daniel.lezcano@linaro.org>
 <CAPDyKFpY4i0Mtb==8zknsuG0HdhPW2fXFvEN+AJScVmT65A-ow@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ea956f88-e627-3485-e20f-d050499eae10@linaro.org>
Date:   Tue, 4 Jan 2022 09:57:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpY4i0Mtb==8zknsuG0HdhPW2fXFvEN+AJScVmT65A-ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Hi Ulf,

thanks for your comments

On 31/12/2021 14:33, Ulf Hansson wrote:
> On Sat, 18 Dec 2021 at 14:00, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> The dtpm table is used to let the different dtpm backends to register
>> their setup callbacks in a single place and preventing to export
>> multiple functions all around the kernel. That allows the dtpm code to
>> be self-encapsulated.
> 
> Well, that's not entirely true. The dtpm code and its backends (or
> ops, whatever we call them) are already maintained from a single
> place, the /drivers/powercap/* directory. I assume we intend to keep
> it like this going forward too, right?

Hopefully we can add more devices like the battery or the backlight, but
I'm not sure they will be in drivers/powercap.

> That is also what patch4 with the devfreq backend continues to conform to.
> 
>>
>> The dtpm hierarchy will be passed as a parameter by a platform
>> specific code and that will lead to the creation of the different dtpm
>> nodes.
>>
>> The function creating the hierarchy could be called from a module at
>> init time or when it is loaded. However, at this moment the table is
>> already freed as it belongs to the init section and the creation will
>> lead to a invalid memory access.
>>
>> Fix this by moving the table to the data section.
> 
> With the above said, I find it a bit odd to put a table in the data
> section like this. Especially, since the only remaining argument for
> why, is to avoid exporting functions, which isn't needed anyway.
> 
> I mean, it would be silly if we should continue to put subsystem
> specific tables in here, to just let them contain a set of subsystem
> specific callbacks.

Do you have an alternative without introducing cyclic dependencies ?



>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Kind regards
> Uffe
> 
>> ---
>>  include/asm-generic/vmlinux.lds.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index 42f3866bca69..50d494d94d6c 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -362,7 +362,8 @@
>>         BRANCH_PROFILE()                                                \
>>         TRACE_PRINTKS()                                                 \
>>         BPF_RAW_TP()                                                    \
>> -       TRACEPOINT_STR()
>> +       TRACEPOINT_STR()                                                \
>> +       DTPM_TABLE()
>>
>>  /*
>>   * Data section helpers
>> @@ -723,7 +724,6 @@
>>         ACPI_PROBE_TABLE(irqchip)                                       \
>>         ACPI_PROBE_TABLE(timer)                                         \
>>         THERMAL_TABLE(governor)                                         \
>> -       DTPM_TABLE()                                                    \
>>         EARLYCON_TABLE()                                                \
>>         LSM_TABLE()                                                     \
>>         EARLY_LSM_TABLE()                                               \
>> --
>> 2.25.1
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
