Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0274FEA80
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 01:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiDLX3b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 19:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiDLX2Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 19:28:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD89F392
        for <linux-arch@vger.kernel.org>; Tue, 12 Apr 2022 15:32:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s2so307638pfh.6
        for <linux-arch@vger.kernel.org>; Tue, 12 Apr 2022 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=UTSp/G8zwV18QcS++FuQzWULt0VtGmmOqsMfzG5ErkA=;
        b=2u8RZR5Z/ycl0/rlZlTpBfbAQMR7bXJ9y/kQiA4x/saJN2+hoVZnRddqJRcYY7lb2v
         Bjodb+LUw3QTYFHpteR0dVcP6+jjnQlsCS2yVTUPgAvAxhQH75k3PFMoYpY6TcXVJXKy
         JudGJnkgu6CrhOQLuBs8YxpJVIjKnGliYLhm3kWUrWEIfz+27mq+rL0MLrS8sbQXWZrI
         TM3hM45jKo3JLLTbPZWOzw4mttlmyYdOIXO71hIow4aJYgK5BDO+uhK9qlDEA1o4UzPc
         MC44eMEGnQEArcYYjgJJcZcNJr56zFC6KsUykNSU1QOvOTGRE6FBdf8bZjZO/OGZ7EQ4
         tqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=UTSp/G8zwV18QcS++FuQzWULt0VtGmmOqsMfzG5ErkA=;
        b=Es7YnJX4WMtl8NSS59h+n1e3DPR6l0Zj6W98Ss5in+ss0y+NP8kOC/DPlv9tS12e6E
         MCnPcLnqYtGmwZ4yu7cJ8as5xClTY+5sP4LLsz07Dsgd+8SNDRDpWxWQBYNAWUSOms5+
         QVsLu0F8XmNi93MY/eUsvtnLJPiNj5Fq8pVNlhUvjnHH9gxf/UOf1J84C3EQXIN74UGY
         3TMRk4rocZ42TqXYM1TKInm0V2du1aZOTvQKi/qa0PECzu7Iobaw6gzrHwoxkRuj7VpH
         uURUPqWGj9DbYXnB3scGwjD8It7eyzJFLXKyAjgXI7JviOQA2JoKZ1rOWDvZxZzh74qB
         HtRg==
X-Gm-Message-State: AOAM5338QWdJf2Z+mQIPCx0f53e5wd0afbMAil4NsKI3UC5h/7sAtkeP
        MQh73E/aRMM2dosXRFOEr6iayw==
X-Google-Smtp-Source: ABdhPJxfJJwMFnMw12ISX69ykkGJykL+olL9K1M/959vnjtHTUaLHqNf2JTnUA5fym5wfUqCsaxWhQ==
X-Received: by 2002:a65:6a07:0:b0:39d:8c35:426b with SMTP id m7-20020a656a07000000b0039d8c35426bmr5415538pgu.171.1649802720473;
        Tue, 12 Apr 2022 15:32:00 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090aa38600b001ca2f87d271sm535902pjp.15.2022.04.12.15.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 15:31:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     alobakin@pm.me, linux-crypto@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org, kch@nvidia.com,
        kbusch@kernel.org, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, martin.petersen@oracle.com,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20220412215220.75677-1-alobakin@pm.me>
References: <20220412215220.75677-1-alobakin@pm.me>
Subject: Re: [PATCH RESEND] asm-generic: fix __get_unaligned_be48() on 32 bit platforms
Message-Id: <164980271890.301666.4533609890818235558.b4-ty@kernel.dk>
Date:   Tue, 12 Apr 2022 16:31:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 12 Apr 2022 21:59:16 +0000, Alexander Lobakin wrote:
> While testing the new macros for working with 48 bit containers,
> I faced a weird problem:
> 
> 32 + 16: 0x2ef6e8da 0x79e60000
> 48: 0xffffe8da + 0x79e60000
> 
> All the bits starting from the 32nd were getting 1d in 9/10 cases.
> The debug showed:
> 
> [...]

Applied, thanks!

[1/1] asm-generic: fix __get_unaligned_be48() on 32 bit platforms
      commit: b97687527be85a55e12804c98745c5619eadcc32

Best regards,
-- 
Jens Axboe


