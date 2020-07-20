Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4812262A2
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jul 2020 16:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGTOzq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jul 2020 10:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTOzp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 10:55:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6A8C061794;
        Mon, 20 Jul 2020 07:55:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k27so10407988pgm.2;
        Mon, 20 Jul 2020 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fnqbnijwClMci6tPbDEsjP556VCP5ZOUnv3MSoBXeYE=;
        b=obmB5/lPOQz3AzvyG/2VXvcAL2NVyqvUp/WDzPZuC0X99oO+puiKNH5SmvXqtGUMxQ
         ZwLaTqnZRihuuAE0kDCE93oc7+UZUbVmuWofEIHX8Wk43IgRMCJtfexfk4af/TnkNUa+
         b1KMQtXkMeHVhEg04OcRwqnmI+j3jqVgZaOaFAr9leMZRePpyIzF3lT5VjaqULUNABQa
         NHk3CJ55gwjmcvnt31dtPgmR/H8DalAa1EqiI9biTgNvDKbKNzV/Z2dJRgmFgIyawQ/i
         6lLh13kuGX5UA5j4JZyyd2d92BOZ2hTMEAphuPyZXA4ZQKmj/ym/xzdcbiiOAgv5+jVX
         z0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fnqbnijwClMci6tPbDEsjP556VCP5ZOUnv3MSoBXeYE=;
        b=mfXoiyghSM6oJdtYNNu0WY9aa7Uni/jefydyqDaIcLPNPoj5Eh03KKYT5DNLorRKuw
         Fuv13CWtmCxTVa53sHdEVdbAUDgcz01+Eb2IbJvIOxc9P/X6IKv6prvt/58LH3nakIGl
         5+LzvJObqvucF2QoK9Y2Hih5pOS55J3fFK/sy1PTpNOrQVOuS/8VgC4vNjHS91/mf2ZK
         W6euXKRIpKZqmPj7wkJ3Ex9fXglKbLgMSuCii/GPrjjJzR+wY8x0Eml98SSp+Udm1ZBR
         UfCXbiwGpiOHg3IKw/5NLULGwdEiph+s6QMQMdk0lFVEeC5YTpwgpX1wQISitE4yijuI
         RWDg==
X-Gm-Message-State: AOAM530bfPlzvVnSMVQMq95Uo45TrGbHK+pRIQiS3USrOB0xAeLNVZuZ
        cAG6fQMqh9teBS6rMM2tSyo=
X-Google-Smtp-Source: ABdhPJzdpCZ2gP92UV6oH70h6AIHA4wJstXUDN042hpqclo3Yv6f70pl/T6XbIaPYF0u9pBA55X8iw==
X-Received: by 2002:a63:8c5c:: with SMTP id q28mr18771110pgn.111.1595256945183;
        Mon, 20 Jul 2020 07:55:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h23sm17008916pfo.166.2020.07.20.07.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 07:55:44 -0700 (PDT)
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in addr_limit_user_check
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Maydell <peter.maydell@linaro.org>
References: <20200714105505.935079-1-hch@lst.de>
 <20200714105505.935079-2-hch@lst.de> <20200718013849.GA157764@roeck-us.net>
 <20200718094846.GA8593@lst.de>
 <fe1d4a6d-e32d-6994-a08b-40134000e988@roeck-us.net>
 <20200720100104.GA20196@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c6099697-5ccd-22b4-f5cb-cbe1c14644a9@roeck-us.net>
Date:   Mon, 20 Jul 2020 07:55:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720100104.GA20196@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/20/20 3:01 AM, Christoph Hellwig wrote:
> To try to reproduce your report I built a mps2_defconfig kernel
> and then run the qemu command line manually extraced from your
> script below, using a mainline qemu built for arm-softmmu, but it
> crashes with the following message even for the baseline kernel.
> 
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
> 
> R00=00000000 R01=00000000 R02=00000000 R03=00000000
> R04=00000000 R05=00000000 R06=00000000 R07=00000000
> R08=00000000 R09=00000000 R10=00000000 R11=00000000
> R12=00000000 R13=ffffffe0 R14=fffffff9 R15=00000000
> XPSR=40000003 -Z-- A handler
> FPSCR: 00000000
> 
> Does anyone have an idea what this means?
> 

Ah, sorry, you can't use the upstream version of qemu to test mps2-an385
Linux images. You'll have to use a version from https://github.com/groeck/qemu.
I'd recommend to use the v5.0.0-local branch.

I had to make some changes to qemu to be able to boot mps2-an385.
I tried to submit those changes into upstream qemu, but that was
rejected because, as I was told, the qemu implementation
would no longer reflect the real hardware with those changes in
place.

Guenter
