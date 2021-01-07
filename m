Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA34F2ED48F
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 17:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbhAGQoB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jan 2021 11:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGQoB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jan 2021 11:44:01 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C549EC0612F4;
        Thu,  7 Jan 2021 08:43:20 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id be12so3828575plb.4;
        Thu, 07 Jan 2021 08:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:newsgroups:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NnHGgaTL7UJZGdN03aVyVWo38iGyqoEYM1bR0ga7ij8=;
        b=DrAmz6OBWqnVg7ucMJbCtL4YazKAfGIm509SyM01kSqP0G8aafO2z3H+4244zPYKVj
         cn/KNKIWDSxtoR8eeNDCL5WuZWVZacvA6eokmHjrK5Q8lFurU8BjNHgbt7rnSgfjsj+Q
         I7bjSOYqCdwlaJU9SC3byuce66eC3Ug043c0XYxCD3OHAR6wbX4EDY254+IAioPpTGC5
         to4Ev2xT6QAYyaStqeSreEChxg/fEbsqMNjusCYeIovdaSQdyAcujIqOlhTM/4B6/VTd
         JML2vhCh0moW1vD/dbfTI9ZDeUnUJ9THl5/VhAu5nSNQImg5WTXZ3GANu3qMtHthDour
         vI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:newsgroups:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NnHGgaTL7UJZGdN03aVyVWo38iGyqoEYM1bR0ga7ij8=;
        b=bO9J8FNZvoKSuIpxdCcyRmEi4iIQflqFwz44EloQMIsSJVK3cyWAw+5NEuWZcgvHdO
         JZ8P807CJpmrmQ1kuxr/VT6PLLyZxgZ26A1HaQpgP7K3oPykaWnRibZ+sa7t3MlO0FCy
         /t40w66/uS0V1ic1MFl50JAdvy52KE2GFBlqfvl/btraASelA+7YjxewVd6UWUS49q7K
         D/6x5hcJ3ndulH+VGTnyH6WYsTsYvx4WrIrGlGhX2+LofskvqDIB/qSWEFUjJHG7ZRoz
         Un7qsVi0JH2R6lC5HPAHXiI8WmE6Ayhaz4hBvLv9kMXM8meaiMWVaqtw7exx21xJYirI
         PyNQ==
X-Gm-Message-State: AOAM532vx4CCFc7ccAHtSPNfj+5Yk0dxlrjaiI7fX7D4MgNSfWYKmCKJ
        Pr8U5LRDrluX5fbqX7sETeo=
X-Google-Smtp-Source: ABdhPJxeFpK8dX2MRlk52dm8MVC7U1Wjp9mS+gZUH1TWKFk0rS3lrwNPwAwOB8oy4gd/b5q8vye6qQ==
X-Received: by 2002:a17:902:8d82:b029:dc:20b8:3c19 with SMTP id v2-20020a1709028d82b02900dc20b83c19mr9753673plo.29.1610037800309;
        Thu, 07 Jan 2021 08:43:20 -0800 (PST)
Received: from [192.168.50.50] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id y3sm6135773pjb.18.2021.01.07.08.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 08:43:19 -0800 (PST)
Sender: Vineet Gupta <vineetg76@gmail.com>
Subject: Re: ARC no console output (was Re: [PATCH 1/2] init/console: Use
 ttynull as a fallback when there is no console)
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
From:   Vineet Gupta <vgupta@synopsys.com>
Message-ID: <50ade852-c598-6476-1f4b-9a3f8d11d143@synopsys.com>
Date:   Thu, 7 Jan 2021 08:43:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <8735zdm86m.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi John,

On 1/7/21 1:02 AM, John Ogness wrote:
> Hi Vineet,
> 
> On 2021-01-06, Vineet Gupta <vgupta@synopsys.com> wrote:
>> This breaks ARC booting (no output on console).
> 
> Could you provide the kernel boot arguments that you use? This series is
> partly about addressing users that have used boot arguments that are
> technically incorrect (even if had worked). Seeing the boot arguments of
> users that are not experiencing problems may help to reveal some of the
> unusual console usages until now.


Kernel command line: earlycon=uart8250,mmio32,0xf0005000,115200n8 
console=ttyS0,115200n8 debug print-fatal-signals=1

And we do have serial driver built-in.

Thx,
-Vineet
