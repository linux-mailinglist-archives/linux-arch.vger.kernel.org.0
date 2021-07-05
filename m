Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B8E3BB59D
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jul 2021 05:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhGEDhx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Jul 2021 23:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhGEDhw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Jul 2021 23:37:52 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C36C061762
        for <linux-arch@vger.kernel.org>; Sun,  4 Jul 2021 20:35:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id o18so16408398pgu.10
        for <linux-arch@vger.kernel.org>; Sun, 04 Jul 2021 20:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sA97bCXCaIAhWnb+YR7vIrZrUHxT70DILRled1e98Wg=;
        b=inDJBS2brM1eymEMmYzx86mblKrDCQWOtb4pAT0+UbL1Hz2kRNeRgeAEEXaacfirwd
         Qyy1TfBOPXNsUzot1HcfIekVmbqCck2CHWNfXMf8iA32i/BjNgtHw8sKvjcQr5BbCLpu
         dHbKcowD6sxCe+RNxUAoW0dVlL82a/nXhDD2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sA97bCXCaIAhWnb+YR7vIrZrUHxT70DILRled1e98Wg=;
        b=M2BF4ovfIl1ofn9FWZdgsC6xC6/iu234i89XR7N8A2flQPFcKByJmGKkynjydCsT2Y
         6OVXEznRHGBZwjclgy3Vtm8NNtk6/lC1DABZb9qoxF/NWhSF/Ty+0pCl/lHd2a/hJLEr
         jcQCb1kohyGxObP5Vme2OG8teIW0etaFG3mgw/nkdZjpUcaXTk5SaZN531p6rq/eFjxZ
         ROWhL3SWeSradgt0HYD72BRx0Au1EmPhpa3DnE5aOayqGwWgwo5/o/3NP9cfT4qB+v97
         +bz15Q94IIB2f3qtbcx0OUnNUMcg5DLewuSFw4luMPXIhv2ZK6/DRyFwL3d3TUoIeQAF
         ZH0A==
X-Gm-Message-State: AOAM532+vLLWA8s1xeHrmxX+NzRWnE7ZPCkhSC+lZsqCfpzI+ZwaokU3
        +B8gRdaLW51PGHFmz26bqsNPuA==
X-Google-Smtp-Source: ABdhPJzONfFCHFfgTqGGbW5wyh0ciobtJX/MJXb1ZXF3mpgRlAezjYI1jkwDW4EcJKVlbDqJgSqLNg==
X-Received: by 2002:a63:fa11:: with SMTP id y17mr13613461pgh.128.1625456114410;
        Sun, 04 Jul 2021 20:35:14 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:7a3a:c0d1:8813:add3])
        by smtp.gmail.com with ESMTPSA id r15sm6254176pje.12.2021.07.04.20.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 20:35:14 -0700 (PDT)
Date:   Mon, 5 Jul 2021 12:35:09 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 2/9] kallsyms: Fix address-checks for kernel related range
Message-ID: <YOJ97ewJYK/O1OYS@google.com>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
 <20210626073439.150586-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626073439.150586-3-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (21/06/26 15:34), Kefeng Wang wrote:
> The is_kernel_inittext/is_kernel_text/is_kernel function should not
> include the end address(the labels _einittext, _etext and _end) when
> check the address range.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Fixes: 04b8eb7a4ccd ("symbol lookup: introduce dereference_symbol_descriptor()")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
