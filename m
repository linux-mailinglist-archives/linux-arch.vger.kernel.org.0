Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42D436D0C2
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 05:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhD1DJN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 23:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhD1DJM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Apr 2021 23:09:12 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118FBC061574;
        Tue, 27 Apr 2021 20:08:27 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso55321850otb.13;
        Tue, 27 Apr 2021 20:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xmdTijoDLORkIw+0S7iEnTgDeNz45rM1GzMm3pB0r3Q=;
        b=E60PKqhPnsx1RoPd49Ttuy5V/jjnnjy4s9nvsECw8d9ngkX5kWx0bNYKmWs6Fvdg+9
         dEQdLAg92vqDJvk74alawcgoe/uOPVPkB424s3heEtWZ+1whQi+3BIoUlVP6gYV9RBbR
         MZzJUct8HsbrHz3f8ZwhocvVgBUI3XDAPa0DAwWpOJGJkdA4UQdP774SGpiJVhtVtgxz
         MRUg9ZO5NCXqQW7r7c8U8+gELYFsS3tm2hAPto5ScBYU+3E6UYxKeHRZkJeU7mGu7mtj
         m9RUcnXpXLIvdMEf1ZHpwIekmZnkxhvnOQfddMT5+4kbq9fetdOFoipz6Lua6YTFuQx8
         QuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xmdTijoDLORkIw+0S7iEnTgDeNz45rM1GzMm3pB0r3Q=;
        b=AcYKAz1naKouywA9ns3cs3gd74zzEUvqtThcJmUSW9pQKluEbBxgcbnUfbYwhbqtdK
         nB7BxVL5i6ngqj0oM5ldqPNr5/skbLMJTSE7jqs3yVT1cKaBE61xLu678xckgLoBe5gF
         8RIWLOA0o1XvaBxREFClFfnVua4Det9gPSYG4XnqqkXPeJVz3+hOiwEC2fRayimJY6Hm
         Gl6iBQA3TEIf7p5GYE3BWwI5XeOtIsNOVs/GLBkfbB3Dq8t6MyDlAG9Aw4jv45ujyMAB
         t/QI+NyvIamYL3YjHdJU0v6gO8SIrQTNJDFYGv5LA4gok8z7ZTpgQcsx1YZzbUf84HhA
         TOtg==
X-Gm-Message-State: AOAM532OzdWghaik89ZwTzHLcmjIYm5i1itwG1lE32zG6AnRryg7JtLh
        RorDhe8QSfU2eJAi0u2ds5M=
X-Google-Smtp-Source: ABdhPJzdcBqIFjDHQrLChMKxRJ/luB0o9IU9eSINrCUpaZi5mgzUz9WKvQPRptFeTxvyKw9TPhTvpQ==
X-Received: by 2002:a9d:2de3:: with SMTP id g90mr12058195otb.274.1619579306483;
        Tue, 27 Apr 2021 20:08:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z2sm434333oto.24.2021.04.27.20.08.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Apr 2021 20:08:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Apr 2021 20:08:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: Re: [PATCH v8] RISC-V: enable XIP
Message-ID: <20210428030824.GA196954@roeck-us.net>
References: <20210413063514.23105-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413063514.23105-1-alex@ghiti.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 13, 2021 at 02:35:14AM -0400, Alexandre Ghiti wrote:
> From: Vitaly Wool <vitaly.wool@konsulko.com>
> 
> Introduce XIP (eXecute In Place) support for RISC-V platforms.
> It allows code to be executed directly from non-volatile storage
> directly addressable by the CPU, such as QSPI NOR flash which can
> be found on many RISC-V platforms. This makes way for significant
> optimization of RAM footprint. The XIP kernel is not compressed
> since it has to run directly from flash, so it will occupy more
> space on the non-volatile storage. The physical flash address used
> to link the kernel object files and for storing it has to be known
> at compile time and is represented by a Kconfig option.
> 
> XIP on RISC-V will for the time being only work on MMU-enabled
> kernels.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr> [ Rebase on top of "Move
> kernel mapping outside the linear mapping" ]
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

In next-20210426, when building riscv:allnoconfig or riscv:tinyconfig:

arch/riscv/kernel/setup.c: In function 'setup_arch':
arch/riscv/kernel/setup.c:284:32: error: implicit declaration of function 'XIP_FIXUP'

Guenter
