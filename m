Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C682C3011
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 19:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390881AbgKXSlE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 13:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390718AbgKXSlD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2020 13:41:03 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F93C0613D6;
        Tue, 24 Nov 2020 10:41:03 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id z21so30265984lfe.12;
        Tue, 24 Nov 2020 10:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JUB7Xs9QzVpt8Oml1/xqWcWXLiXlsrQkDAlaEfZx9MA=;
        b=Gu+s0COFP/i9mprayW0Q8znE1e18rNxnqEOaSHBI1/XSeDjYxUyySCZEKysJdqxaV1
         bRCSH/G2tsD4m61Qlrz+0wN+LMTfAJN+oUbUQZiUB7nwCs0keqm4WRpfovWzjJoY9rlb
         60SOv7QYqDEZ40HxOz5JWmupboBS8QyeowlcA/HvTPdvgiFc2t1R87/JaAoP8hjoCFP7
         bj3jorIrRaDJRjyUtfILIGki7Bdq5KiAjgvbPoclZihPD4i6NBerN1EK23rdVXNE/fqN
         adCi/q40XPFcJqFCIT1cvXJ9KraQOfnfz5YskaF6VVDIxdnOA0Hsm3j575fPPxZL+UyZ
         Nrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JUB7Xs9QzVpt8Oml1/xqWcWXLiXlsrQkDAlaEfZx9MA=;
        b=WOHHHnjLBWsCGIpyqjGmt9XcwgUFBiLFPvA84Fk9gTLiOHnrirjxgEuaNqfeuzhob/
         HJVmCvbcS8cRysx/tNG1kWt8l8DQj87P/8H9T0gig92QsAiRLaIW2MOfB/IrhDsmI/ME
         7CqFqNfIdHCMOLhnHhnGM+bVJSKlma7dJNA34IVaupJ8htutQOkpc/Sx7/ugatzLHoWC
         eB+yh1zmTux7hQ2qgYZxK4BT3itBUvScrTcBXZW4J/LlCrGzOelkp+LCG1KV+q2n4EyJ
         k3n81eZKfO7H1m2Gwf5Vq5HqNCTl46FkAyUAGLdAROABMVftTGVlwkQ8GbHyqQCEl+Kj
         OmIQ==
X-Gm-Message-State: AOAM530W2kOmOZ1R2YB/Jc0lxt+J+q7RMg5L26thAm1dOpetUoY8pyTH
        H4e/jW/iSzgePXdl0cSQOr4=
X-Google-Smtp-Source: ABdhPJy8JTUGHpeE8Abs3baDde8lb/U0Ejq9lcToygmR5X6z4VsvUuEa70WxT6PaHw16lehYXcVUXw==
X-Received: by 2002:a19:64f:: with SMTP id 76mr2525014lfg.569.1606243261968;
        Tue, 24 Nov 2020 10:41:01 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id y12sm1875322lfh.120.2020.11.24.10.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 10:41:01 -0800 (PST)
Subject: Re: [PATCH v2 04/10] seccomp: Migrate to use SYSCALL_WORK flag
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, hch@infradead.org, mingo@redhat.com,
        keescook@chromium.org, arnd@arndb.de, luto@amacapital.net,
        wad@chromium.org, rostedt@goodmis.org, paul@paul-moore.com,
        eparis@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, kernel@collabora.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20201116174206.2639648-1-krisman@collabora.com>
 <20201116174206.2639648-5-krisman@collabora.com>
 <20646400-0e16-0eb5-c829-3b77df8c38e3@gmail.com>
 <87360yprl0.fsf@collabora.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c97451ad-b8de-76cc-0849-47f9b3b32693@gmail.com>
Date:   Tue, 24 Nov 2020 21:41:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <87360yprl0.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

24.11.2020 20:55, Gabriel Krisman Bertazi пишет:
> Dmitry Osipenko <digetx@gmail.com> writes:
> 
>> Hi,
>>
>> This patch broke seccomp on arm32 using linux-next, chromium browser
>> doesn't work anymore and there are these errors in KMSG:
>>
>> Unhandled prefetch abort: breakpoint debug exception (0x002) at ...
>>
>> Note that arm doesn't use CONFIG_GENERIC_ENTRY. Please fix, thanks in
>> advance.
> 
> Hi Dmitry,
> 
> I believe this is the same problem reported yesterday on this thread
> 
>   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2390444.html
> 
> can you please try the patch I shared on that thread?
> 
>   https://lore.kernel.org/patchwork/patch/1344098/

It works, thank you.

Tested-by: Dmitry Osipenko <digetx@gmail.com>
