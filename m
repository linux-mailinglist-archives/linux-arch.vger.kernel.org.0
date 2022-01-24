Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3D549A68C
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jan 2022 03:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346692AbiAYCSY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jan 2022 21:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2364482AbiAXXsQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jan 2022 18:48:16 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C6DC07E313
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 13:43:19 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 9so5671711iou.2
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 13:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bwyi05nr6wT2ZFWR22PTFFEqIa15MbmZhLkPDJsvpx0=;
        b=RHC6VLVvqaubbaCRsVngcmpEX70I5qMnda30/M7WCCZwC5f0cqpQ3RymomMsBkULmw
         nf5/S3hSqeRVgjITKXpsUWSCPJ1zSs0WErq91oJeo4EwKAl5NWPxbZD95UmjUoLTZfxV
         UKqLgKCXjmYxAMpQTBGbu1bs6koOmgR3YMUPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bwyi05nr6wT2ZFWR22PTFFEqIa15MbmZhLkPDJsvpx0=;
        b=2BmVpcmYS3pqeoF0oXEyUwvwxEn8Es/wOSp+4FqUIvUDXjpMc+0puzeUh9Mh4+iF2N
         o3bNFyJjvMVj5bmx9/Fph0o7WLqQzxGcuUWRTxxPOuFnIn61PmQfNW8OIaXqnxnDroBH
         KCbyuYfXFJ0spIoaf16CDPBdJs7WOkZ7JCh+eNg38+cYwENqUu3E9Jve/cYi4CHRSEIc
         dEeec1GiWsapEf/mBwmtD/OqJXYEYlm+Kuuv0L4uWMk8ktlFLpvaW7VURAbBAPnZVZ4t
         d0PawR7l8s+OCIT3cCisslURy2sfCMh2/Lb0Yf9yVjUdCqzeV1H95R7HAtTEFjzdK8aN
         cSyA==
X-Gm-Message-State: AOAM532n9LUJtDGpAk6t3V1E2l4pEE8Kc2v0At74rJwAP7ggbZfvKdkA
        swWqorgqMHv0ZHf3CMvIF37pSNWhJ19urg==
X-Google-Smtp-Source: ABdhPJwHkPUKHj5OwyLcvli9H+TcGZKIhAz21GNkgHYqaDxD02X/edk57JJlKIf3+zwqY6DfHYtCew==
X-Received: by 2002:a02:cb01:: with SMTP id j1mr1627163jap.194.1643060598679;
        Mon, 24 Jan 2022 13:43:18 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id l13sm4331335ilh.46.2022.01.24.13.43.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 13:43:17 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id i62so5603146ioa.1
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 13:43:17 -0800 (PST)
X-Received: by 2002:a02:9043:: with SMTP id y3mr7723156jaf.263.1643060597485;
 Mon, 24 Jan 2022 13:43:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643015752.git.christophe.leroy@csgroup.eu> <848d857871f457f4df37e80fad468d615b237c24.1643015752.git.christophe.leroy@csgroup.eu>
In-Reply-To: <848d857871f457f4df37e80fad468d615b237c24.1643015752.git.christophe.leroy@csgroup.eu>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Jan 2022 13:43:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VMUA+8RFOSkVQTmBDrHPSYSG5VBVA_EKKQuBjF0ZZKpQ@mail.gmail.com>
Message-ID: <CAD=FV=VMUA+8RFOSkVQTmBDrHPSYSG5VBVA_EKKQuBjF0ZZKpQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] modules: Add CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Mon, Jan 24, 2022 at 1:22 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -2022,8 +2022,11 @@ static int kdb_lsmod(int argc, const char **argv)
>                 if (mod->state == MODULE_STATE_UNFORMED)
>                         continue;
>
> -               kdb_printf("%-20s%8u  0x%px ", mod->name,
> -                          mod->core_layout.size, (void *)mod);
> +               kdb_printf("%-20s%8u", mod->name, mod->core_layout.size);
> +#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> +               kdb_printf("/%8u  0x%px ", mod->data_layout.size);

Just counting percentages and arguments, it seems like something's
wrong in the above print statement.

-Doug
