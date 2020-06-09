Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B6A1F39DB
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 13:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgFILgr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jun 2020 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgFILgq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2020 07:36:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B517BC05BD1E;
        Tue,  9 Jun 2020 04:36:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r9so2495669wmh.2;
        Tue, 09 Jun 2020 04:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fJYvnclAzUmRLcosHFWh9bntbC7vT1JGF1oeBQ8Fq+s=;
        b=P2R1mKLhXQWVtCHOxyai+DAZG41BWFjzm6j5avzQXpSxNuWLd0zI2ZAIIc4x6l13KB
         GEcfW60U9ZqCVsXLm6z7mcme2KgyqBb5RWZc70Hk0AZ6Mtu+pis4mraUV6zQJH8zljMV
         qYWcjAv1XASWjh+/rDLdQNtMWElHzIr/os7SwX0XTelKWCK5SeyY1cJuyvsrbCneQa9F
         aC6/pkYQzN7xovrsGRi9bT5EkdkW63s+3+44tBo9v9cQWQrRqCQlpxOSqUVmholNMdDP
         shbRCf93kJQnue9etZw6zuflr/vzK0Nn9J8yiv593lo4AHo3RmMikB9eQjXZAGG1PiEm
         patA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fJYvnclAzUmRLcosHFWh9bntbC7vT1JGF1oeBQ8Fq+s=;
        b=VizZYzlSjh08k9S2PO05zY9dEAj5xTPN8I/NCMvzcQnspNORCfX077ynGU1mskDXL/
         BLDwu/pT3li2IIZqOLtT99dW3XtRgeA342HSGQkrQNlxkd5WNBmMYm0OEqqgcfx8CFbH
         49Kiwmv9T7OcolDUgVzAiT71wnth/XjNQlKBLOsA15QNy69ET9KCWbv65w0ajioIyCus
         6TLS2vwPkRLL01X6Kc4AgvVFHLwCnDYznLkq1O8cekeEy+MtWpfuGqZKgVuqANu7sVPm
         IdH4tqMN0TVhmJYNeNaBs9Eby9ImzUvq0wGf9N2aS48vFWkdtSRBNg0N2pXH+2QWV1Wn
         7+3g==
X-Gm-Message-State: AOAM533qFlia8QSXrRB2glqH9iaE4j0QXv7IsONc0TkX27Wn9tgQzf+T
        VzbgPlxGZRyfdGXuUZLRGmE=
X-Google-Smtp-Source: ABdhPJyM2GfdDSPkYVRuDWbPh+MpdEr3Po9Fi8MZXny0ZoMELo/Ho+aLHDQS1ZFhLdAvqQECBsw8NQ==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr3447033wmh.37.1591702604028;
        Tue, 09 Jun 2020 04:36:44 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:8201:b2fb:3ef8:ca:1604? ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id z206sm2699467wmg.30.2020.06.09.04.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 04:36:43 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/6] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
To:     Dave Martin <Dave.Martin@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <1084d017-54f3-475c-be1b-aabc801d9a71@gmail.com>
Date:   Tue, 9 Jun 2020 13:36:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Dave,

I've applied this patch (manually, because 4/6 is not yet applied).
I have a question below.

On 5/27/20 11:17 PM, Dave Martin wrote:
> Add documentation for the PR_PAC_RESET_KEYS ioctl added in Linux
> 5.0 for arm64.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> 
> ---
> 
> Since v1:
> 
>  * Clarify explicitly that PR_PAC_RESET_KEYS is redundant when combined
>    with execve().
> 
>  * Move error condition details into the prctl description, to avoid
>    excessive duplication while keeping keeping related pieces of text
>    closer together.
> 
>  * In lieu of having a separate man page to cross reference for detailed
>    guidance, cross-reference the kernel documentation.
> 
>  * Add safety warning.  This is deliberately vague, pending ongoing
>    discussions with libc folks.
> ---
>  man2/prctl.2 | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 

[...]

> +.IP
> +.B Warning:
> +Because the compiler or run-time environment
> +may be using some or all of the keys,
> +a successful

Things got a bit garbled here. I think the next few lines should have been 
at the end.
> +.IP
> +For more information, see the kernel source file
> +.I Documentation/arm64/pointer\-authentication.rst
> +.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
> +(or
> +.I Documentation/arm64/pointer\-authentication.txt
> +before Linux 5.3).
> +.B PR_PAC_RESET_KEYS
> +may crash the calling process.
> +The conditions for using it safely are complex and system-dependent.
> +Don't use it unless you know what you are doing.

I applied the following change after your patch; is it okay?

 .IP
 .B Warning:
 Because the compiler or run-time environment
 may be using some or all of the keys,
 a successful
+may crash the calling process.
+The conditions for using it safely are complex and system-dependent.
+Don't use it unless you know what you are doing.
 .IP
 For more information, see the kernel source file
 .I Documentation/arm64/pointer\-authentication.rst
@@ -1020,9 +1023,6 @@ For more information, see the kernel source file
 .I Documentation/arm64/pointer\-authentication.txt
 before Linux 5.3).
 .B PR_PAC_RESET_KEYS
-may crash the calling process.
-The conditions for using it safely are complex and system-dependent.
-Don't use it unless you know what you are doing.
 .\" prctl PR_SET_PDEATHSIG
 .TP
 .BR PR_SET_PDEATHSIG " (since Linux 2.1.57)"

[...]

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
