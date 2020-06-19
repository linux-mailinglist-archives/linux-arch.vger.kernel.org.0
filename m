Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E382003DF
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jun 2020 10:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgFSI3H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jun 2020 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbgFSI3C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jun 2020 04:29:02 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48295C0613EF
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 01:29:01 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g139so4263118lfd.10
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 01:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=irVvm75B8uOjhet4ds9NewlHhGnanjSr3qTRTZzIUE4=;
        b=qkbi8YvZIpYdgXOhuLz+oLhk6FU5nre6FOh8jwCxVM9654uCe38mG3xi4sHqGzzDyG
         SEH1hJrw2TFIChHUxX1ZXnbwARwg6RC5j0BV0+jMRPStvzbKMhHOWFkkmEsrWjqdX5F+
         D1IOfQlW2zLQg/nVx9gJMOxi4uOERKvqBd1S1RhEt6EhjY5th0/tAvBfP2KAJAM96y7o
         h72udRwv1GPKxwptl875dVONvJoltvXpQNW88Rr7UCqkXi2dwlS43kJ7lnlN+shZedPc
         UEpFi+EUsizwMgSG5KrzWkYQzjXdopu2qfdbxfjTUi6dvlVTSJe8cWAu3gdUIqCShHxT
         T2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=irVvm75B8uOjhet4ds9NewlHhGnanjSr3qTRTZzIUE4=;
        b=Q6qMhpydDNnHx47QMok8coYHufdK1kYikTXJ4WFuvxpK/YncwJmeJ9IjoWdDadrPEi
         9e2YWBQawwopXhoxNNvmsK6xCAVBZXIcuVs469xxN+yCZsPnjt5GfXM6hD9zvPTNbgHU
         GUR1yajTuEwqwPO1tLOF2XYQPxg1iiVcFq7TGh6xtAFqoZLNwfD4lg0/9efNwNerb+sb
         5t5RHL8cdnGt26y9BuoBJ2GV/C2eY+Y3IDZdj04ubIP7Qa+j9jlMSfwYf1HJkKK/dw7f
         xT/u3TxJyCmR82XRf3aDjM4WEqtcjoF+cVT41UTQ7kFNoAxvth/FwIiV5v2fMzwAIduj
         tiVA==
X-Gm-Message-State: AOAM531osiFSD1bvzRpsq2Tn3p5+0qSZcwRXuf4IV2qEDcB/1xCYTD4/
        HH0CYDwMvFhA44VOajy0pGP4gA==
X-Google-Smtp-Source: ABdhPJxnSAk4hCfsyIu7N052ONa1UuRXTstPiF0JmLx3L/kM6WdrlnqV1xaj4A+uNl5wLop8yEYwoQ==
X-Received: by 2002:ac2:5c49:: with SMTP id s9mr1327184lfp.90.1592555339610;
        Fri, 19 Jun 2020 01:28:59 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:8c9:4beb:2ce8:f19d:33e5:571e? ([2a00:1fa0:8c9:4beb:2ce8:f19d:33e5:571e])
        by smtp.gmail.com with ESMTPSA id a16sm1058721ljb.107.2020.06.19.01.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 01:28:58 -0700 (PDT)
Subject: Re: [PATCH 3/6] exec: cleanup the count() function
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200618144627.114057-1-hch@lst.de>
 <20200618144627.114057-4-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <04e7876b-a8f3-3f6e-939c-bb0764ece1ac@cogentembedded.com>
Date:   Fri, 19 Jun 2020 11:28:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618144627.114057-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

On 18.06.2020 17:46, Christoph Hellwig wrote:

> Remove the max argument as it is hard wired to MAX_ARG_STRINGS, and

    Technically, argument is what's actually passed to a function, you're 
removing a function parameter.

> give the function a slightly less generic name.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]

MBR, Sergei
