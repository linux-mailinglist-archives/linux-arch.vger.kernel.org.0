Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03444226AB3
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jul 2020 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbgGTQgw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jul 2020 12:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732980AbgGTQgn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 12:36:43 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C49C061794
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 09:36:43 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id x9so13854528ila.3
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gBnhc9kYq0E6+vqUJS1jDU/1F1sS+K3Lh6YLjAXrPIA=;
        b=IJM4F9kEuWWZ9HWNrJw+/v44b3wlVooucvBHu8ZYu8BUTGD5nEtsKNyzUXoTwNSTEY
         +bYLs/oEfkJ7TI+wg3wqDbe/+j2D8FZZ+9w2kK7V4HwSe+AzjwElQJfRiaflWvmPXZgr
         bXgpTKOrNGv2fnoAHU35bus/WtnzUUcC7j8iH6Sp3HbSK+FymkGn0BgI/YffgYLJR0ox
         sBgfdmHN6KCjmzreGDBnzbbO3cvKE4LDgna3CAHCOSG27AtgoCLXhS4OGzLlFFlF/CaO
         SvOcMUX2AWEnvyi4W69b4nj3DC+Yr5/MXaC6sOpNKcUKRHLr/ofvZzc87WX/VE814Tgs
         C6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gBnhc9kYq0E6+vqUJS1jDU/1F1sS+K3Lh6YLjAXrPIA=;
        b=apGGiFtEniBCslCmKQ+pesOhd4/P7f+8gAtc7Irg7DsvOpW9dmySHKI9hlSWzszd9c
         JN9kiT33Qwnzt2Iw6MIdFInHFVokHD91J3AOefyYVkQsMYbqL8+6KWbBJQ31yX5zp+Og
         w54Of+qNNZ0nBnfhNns2h691f4XRsVz7fLXZx2IW6mZzB+ZMj1iwGkxVVGIRFfcEDBVW
         1nxXj07bV7ui8Ef47at8MbxClF9G22F4dZYb55iAoTyxOptmQf3l6hAF8bOvzoTPbpuQ
         JxII69i7fCNUQtSgD4dFfarVLjr0Tcpstgbbb4s5ZWwoIvLhkk2xLGqUsuGAEo4iRVDV
         6k8Q==
X-Gm-Message-State: AOAM531npF57yGXFfyX2asQx8XScxFBiI1saEUWZ4bk7l8g/8XgGVABx
        jYo5bqt+uUkZ3tISpjykAl/ZyQ==
X-Google-Smtp-Source: ABdhPJxukhVb2zn3N2KCfVMsxmqpS2RZySUveN6hPJ2GEvDdyWHhLuaqHOHq9wpkvxNqmBkiJFxtrA==
X-Received: by 2002:a92:7306:: with SMTP id o6mr23184732ilc.90.1595263002078;
        Mon, 20 Jul 2020 09:36:42 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w15sm9315257ila.65.2020.07.20.09.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 09:36:41 -0700 (PDT)
Subject: Re: io_uring vs in_compat_syscall()
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20200720061046.GA10678@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ceb21006-26d0-b216-84a9-5da0b89b5fbf@kernel.dk>
Date:   Mon, 20 Jul 2020 10:36:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720061046.GA10678@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/20/20 12:10 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> I just found a (so far theoretical) issue with the io_uring submission
> offloading to workqueues or threads.  We have lots of places using
> in_compat_syscall() to check if a syscall needs compat treatmenet.
> While the biggest users is iocttl(), we also have a fair amount of
> places using in_compat_task() in read and write methods, and these
> will not do the wrong thing when used with io_uring under certain
> conditions.  I'm not sure how to best fix this, except for making sure
> in_compat_syscall() returns true one way or another for these cases.

We can probably propagate this information in the io_kiocb via a flag,
and have the io-wq worker set TS_COMPAT if that's the case.

-- 
Jens Axboe

