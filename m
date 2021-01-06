Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779102EC6F1
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jan 2021 00:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbhAFXhV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 18:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbhAFXhV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2021 18:37:21 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469FFC061786;
        Wed,  6 Jan 2021 15:36:41 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v19so3309193pgj.12;
        Wed, 06 Jan 2021 15:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:newsgroups:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J7Eq4Crap1XNnquwBWJgU7Gq2lMLJrkQQZ+4V+b8zVo=;
        b=Ikhj1y7Vjrt3Pb1Kb1VlRzH8pFfUGIHUcN2BphVXdCtY/IauGLy5PP/3cf6gnZuElR
         Qvdp1wvAb4ZIbtzIQw1quUsfOrSjZ+NeezH0kGZZ1V8wPbHqCys9mcpRX8xHXO1rZws1
         lW3cxUsrGp1PSXpCN6Nhlo0jrDQj5rhd/cppcmQLjnBmKBHqdwt3ZlfY2qZQ9Hck1YHw
         tSxz5MWFMtk7DFyY2sp3P/XX9vG/Ep6angk2sDL9xJXIoKNFNzC5vQgtyOxQptXWGNxJ
         6cPkUuwtdwlWPqYvqjOwB3IoMlLu4klebSjp2i3iKZd1CSNd4UKMPH5xTvefOE6UT7OV
         YUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:newsgroups:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J7Eq4Crap1XNnquwBWJgU7Gq2lMLJrkQQZ+4V+b8zVo=;
        b=XebGeMYV75jNzbLGqUKNQtymAEa8dfdbbEcnitrTDC3pLsRsXBCT/CQY4ngJ2SVFjP
         9rKLM3NxtbBaW6veXRQbB9Ift9rXw97Jn1UBWDT4YRCCuAK2rXwsbfTwufQUHGTKlNyS
         8eW/+hYEF0C7gfxgH18ZuKs+Jz42VdTbr3LGjoHMWFCpbUB3qBx6HmM1zzv61oiDi8AJ
         M+XqR2WWO0Chf9wefNlCgOAQCkJ68SQLQ1FTdpPw7fkKeHEVHN/8odeZeV+DzQPKi0PP
         hPdrA+c1I6nrB3rfKfCRJnoE3Hhge6sHy4lZ+dWUvwb+elsYISmuIGM0L9v+eb1ivn56
         ZClA==
X-Gm-Message-State: AOAM5317+gVHVcla3sj8JGqt8TThf+q1AJa42u/lTG3+guPlDPkfPxfN
        Q6Y18ETRA8RRYZIjftGRef4=
X-Google-Smtp-Source: ABdhPJzQ2nOrZN3OQezwWTal114R08A0zhGMDMyLMKuquAnZcndOTNQ2StMM0xwnZ4+WmLfAQbf7tg==
X-Received: by 2002:a63:c1e:: with SMTP id b30mr6870662pgl.72.1609976200772;
        Wed, 06 Jan 2021 15:36:40 -0800 (PST)
Received: from [192.168.50.50] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id b12sm3547242pft.114.2021.01.06.15.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 15:36:40 -0800 (PST)
Sender: Vineet Gupta <vineetg76@gmail.com>
Subject: ARC no console output (was Re: [PATCH 1/2] init/console: Use ttynull
 as a fallback when there is no console)
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
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
Newsgroups: gmane.linux.kernel
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
From:   Vineet Gupta <vgupta@synopsys.com>
Message-ID: <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
Date:   Wed, 6 Jan 2021 15:36:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201111135450.11214-2-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+CC Buildroot folks

Hi Petr,

On 11/11/20 5:54 AM, Petr Mladek wrote:
> stdin, stdout, and stderr standard I/O stream are created for the init
> process. They are not available when there is no console registered
> for /dev/console. It might lead to a crash when the init process
> tries to use them, see the commit 48021f98130880dd742 ("printk: handle
> blank console arguments passed in.").
> 
> Normally, ttySX and ttyX consoles are used as a fallback when no consoles
> are defined via the command line, device tree, or SPCR. But there
> will be no console registered when an invalid console name is configured
> or when the configured consoles do not exist on the system.
> 
> Users even try to avoid the console intentionally, for example,
> by using console="" or console=null. It is used on production
> systems where the serial port or terminal are not visible to
> users. Pushing messages to these consoles would just unnecessary
> slowdown the system.
> 
> Make sure that stdin, stdout, stderr, and /dev/console are always
> available by a fallback to the existing ttynull driver. It has
> been implemented for exactly this purpose but it was used only
> when explicitly configured.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

> --- a/init/main.c
> +++ b/init/main.c
> @@ -1470,8 +1470,14 @@ void __init console_on_rootfs(void)
>   	struct file *file = filp_open("/dev/console", O_RDWR, 0);
>   
>   	if (IS_ERR(file)) {
> -		pr_err("Warning: unable to open an initial console.\n");
> -		return;
> +		pr_err("Warning: unable to open an initial console. Fallback to ttynull.\n");
> +		register_ttynull_console();
> +
> +		file = filp_open("/dev/console", O_RDWR, 0);
> +		if (IS_ERR(file)) {
> +			pr_err("Warning: Failed to add ttynull console. No stdin, stdout, and stderr for the init process!\n");
> +			return;
> +		}


This breaks ARC booting (no output on console).

Our Buildroot based setup has dynamic /dev where /dev/console doesn't 
exist statically and there's a primoridla /init shell script which does 
following

/bin/mount -t devtmpfs devtmpfs /dev
exec 0</dev/console
exec 1>/dev/console
exec 2>/dev/console
exec /sbin/init "$@"

Buildroot has had this way of handling missing /dev/console since 2011 
[1] and [2].

Please advise what needs to be done to unbork boot. Otherwise this seems 
like a kernel change which breaks user-space and needs to be backed-out 
(or perhaps conditionalize on CONFIG_NULL_TTY. I'm surprised it hasn't 
been reported by any other  embedded folks

Thx,
-Vineet

[1] http://lists.busybox.net/pipermail/buildroot/2011-July/044505.html
[2] http://lists.busybox.net/pipermail/buildroot/2011-August/044832.html
