Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163AB1D0F60
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 12:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbgEMKK3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 06:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgEMKK2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 06:10:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EBDC061A0C;
        Wed, 13 May 2020 03:10:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j5so20166094wrq.2;
        Wed, 13 May 2020 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kln4h5TjLT1rYbRFL6+I0gOBR5qgTfdeId+fz9C5vOA=;
        b=URlU1PHnV4AqNaLREDZ4zw9nB27Zcd+0jvX7P7KYiC/XaCp3ZGEERK7Sn31HBweRG/
         bm/CbcYSo3tkW9NOAIV1qc0IQuTSrkcE7Ed85lie6Czcn3KyVeWZqOJs90MMznoYjBTi
         eZUhDUTqKIWdg+Zk9udH+oZemYWMrD3YAbkOQ82EbOjIVU1nm2fa3wJsM1/PASSTAewa
         J2h0iCanTy6OPB9ap8+GLPWwxETK0/1XNLIMFYe/h3ZnoG3OLGsvc2SFr8Y93Ly+e7g/
         W6/9E5grAWoi9y6DgiEAJjeq/Yv2D5knCFtB6JnUu8PBo8dOFF1wEQwj1TT8fvDYtBNX
         Dc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kln4h5TjLT1rYbRFL6+I0gOBR5qgTfdeId+fz9C5vOA=;
        b=XqRmO2Lu8zWrGKgCcQUsLTqC0/UA9007FUITwfwzRdGc9nH4Hm0I7Lv7QPYXC8yKoI
         JdmlbbuNRbDkUXRC1pBw3BKl2PbagYgRjxZv3uNU3HxWKThZbmTj6ZiVWWt3sHNwebJG
         ZE9Pa68uQ/zSgz2dcM/w8KtcM3Rh9gWX2KhTCMwc5YhTxNn5ve/Pc/nx8BsKxRrZSN4M
         umIy8u/9LvIEYEC1KyRWq9pReCcw5L0nPGz7n35veUB2l5MY091VRg/2XcK+2dzobmoT
         Nb92qSqA3KfnoRwfCOVUXQOCQdQYucVCmNBtNaMtUYZJ1CXyJXWecWnJASXJdlI2Oq+m
         T7aA==
X-Gm-Message-State: AOAM532q4VyNYc7W/G3raz+LXe6sJUeViCM9OqtjZqwInjTEtGy2VAIZ
        E88SUkwAQi4jOFWS4mjOw34=
X-Google-Smtp-Source: ABdhPJxgL9tpiq55O6Q30AmJZjScEl1dYlzNP+lcolwTwgr1fIRNSmkDPrLcHqBTDr3NyxoOjncpag==
X-Received: by 2002:a5d:6584:: with SMTP id q4mr9012757wru.12.1589364626822;
        Wed, 13 May 2020 03:10:26 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id q184sm35495597wma.25.2020.05.13.03.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 03:10:26 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/14] prctl.2: Add health warning
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-3-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <93c5bfe6-fbbe-93ca-ef9c-91228c99d31b@gmail.com>
Date:   Wed, 13 May 2020 12:10:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-3-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On 5/12/20 6:36 PM, Dave Martin wrote:
> In reality, almost every prctl interferes with assumptions that the
> compiler and C library / runtime rely on.  prctl() can therefore
> make userspace explode in a variety ways that are likely to be hard
> to debug.
> 
> This is not obvious to the uninitiated, so add a warning.

Patch applied. But see my comments on patch 04. I may want to 
circle back on this patch later, since the wording feels a 
little strong to me (we simply must use prctl for some things, 
and not all of those things break user-space/runtime as far 
as I know). If you have some thoughts on softening the warning,
let me know.

Cheers,

Michael

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  man2/prctl.2 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 7932ada..a35b748 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -66,6 +66,11 @@ prctl \- operations on a process or thread
>  manipulates various aspects of the behavior
>  of the calling thread or process.
>  .PP
> +Note that careless use of
> +.BR prctl ()
> +can confuse the userspace run-time environment,
> +so these operations should be used with care (if at all).
> +.PP
>  .BR prctl ()
>  is called with a first argument describing what to do
>  (with values defined in \fI<linux/prctl.h>\fP), and further
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
