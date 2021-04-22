Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C608368755
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 21:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbhDVTlj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 15:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236668AbhDVTlj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Apr 2021 15:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619120463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6s69Vc1JVO1C/KitZXv6PHxtifVMVmdc7g9HprfJ1I=;
        b=a2jI2t9dmOqC595qxcnqKPq1MJURZr9KRJN/3/dSELN/UbYoA57VDpvSnc0JsyTkgC4Iyv
        LOGM5H04BjL3Hivl2uSzaAhoeyHzj4rr79y0zg9JZSDvql/PR7tt6bx0MgUYlHqqt7reCP
        GJChMO88JhPYNCEynVZaRYXqfbdGanA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-saxNpNEbMP6cGnOvzzObiw-1; Thu, 22 Apr 2021 15:41:01 -0400
X-MC-Unique: saxNpNEbMP6cGnOvzzObiw-1
Received: by mail-qv1-f71.google.com with SMTP id y14-20020a0cf14e0000b029019ff951fd16so15631453qvl.12
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 12:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=k6s69Vc1JVO1C/KitZXv6PHxtifVMVmdc7g9HprfJ1I=;
        b=ehhIuEKcQV/501kyTLslzyIxjjqPTzN/C6cKpBiSp8ayrtghGw+ExQE+oO/L0b9pk+
         Aye+yuvPY3fgKZ49KGTpLVOECxnop301YHwwKkRWPJSyfw4msdIZUB3x6h3zX3c/qMDR
         nAmQsp1DnXpPLQbbvXCG6HQO8Ph6XlR7Gj3oHQ+mzqSDl55YksmHV0sHDEpekpoGIgcR
         I1jnAX2c7KL39Xmz+uB+VobtmrUGhNIn2xBtGk7OonlDbcQyMvVCnWgO9SVolPIDbAej
         pjfczzL1AcBRB3tLH3rk1CsS3vp4XOa0/LtXWZPa4smi5G/soCj/OiwFWXi9d5u7rwGU
         Ou5Q==
X-Gm-Message-State: AOAM5318m6QvEqgcGNNasVplvi0c4eLakqroc5oT5Vw79RzhCywpT6Li
        bAAulmcC3yyLDULXAiWF2cCBIeaOMUj4JM2D1a+OnGaVK96BO+zQohJmo+RjS23PsZSeTnpXCxJ
        Fh9EvNpYmhVALQu+7nglC6A==
X-Received: by 2002:a05:622a:486:: with SMTP id p6mr124890qtx.98.1619120461127;
        Thu, 22 Apr 2021 12:41:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw26o1fq4SUq8AjaV9A02QdlXMa58WsaWpt61xtbPijGtt+MgJTuq0edRMBFLJwGY3H0rmZZA==
X-Received: by 2002:a05:622a:486:: with SMTP id p6mr124872qtx.98.1619120460991;
        Thu, 22 Apr 2021 12:41:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:184:417f:70c0::42e6])
        by smtp.gmail.com with ESMTPSA id a63sm2838849qkf.132.2021.04.22.12.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 12:41:00 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] bits: Add tests of GENMASK
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        akpm@linux-foundation.org
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, emil.l.velikov@gmail.com,
        geert@linux-m68k.org, keescook@chromium.org,
        linus.walleij@linaro.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, syednwaris@gmail.com,
        vilhelm.gray@gmail.com, yamada.masahiro@socionext.com
References: <20200620213632.60c2c6b99ec9cf9392fa128d@linux-foundation.org>
 <20200621054210.14804-1-rikard.falkeborn@gmail.com>
 <20200621054210.14804-2-rikard.falkeborn@gmail.com>
From:   Nico Pache <npache@redhat.com>
Message-ID: <935a7b98-ab4c-15af-3bf0-aa7c1f9de068@redhat.com>
Date:   Thu, 22 Apr 2021 15:40:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20200621054210.14804-2-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hey,

Where is TEST_GENMASK_FAILURES being defined? This fails when compiling this

test as a module.

Am I missing something here?

Cheers!

-- Nico

On 6/21/20 1:42 AM, Rikard Falkeborn wrote:
> [Snip...] 
> +#ifdef TEST_GENMASK_FAILURES
> +	/* these should fail compilation */
> +	GENMASK(0, 1);
> +	GENMASK(0, 10);
> +	GENMASK(9, 10);
> +#endif
> [Snap..] 

