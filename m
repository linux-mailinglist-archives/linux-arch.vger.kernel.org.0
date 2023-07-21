Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6226D75CA58
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 16:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGUOnF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjGUOmz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 10:42:55 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E8C35AF
        for <linux-arch@vger.kernel.org>; Fri, 21 Jul 2023 07:42:46 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-78706966220so19452939f.1
        for <linux-arch@vger.kernel.org>; Fri, 21 Jul 2023 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689950565; x=1690555365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdDHMIe9cztVUm68exPMuhOaghi2gznh0/5nfFVFao4=;
        b=Iw2r8lt3EXE/lGJI+Z+TgbWkqdCuKO2xgSx5o8bmML8JjgAavmXg1Gq6ZaHuWhxt45
         VvliDNpZgJr2cdlOGgYFDaW7zgv8FWGcMq9otkJWFVQp9pI7WQ0HyDNWopuSJLb6jxXw
         xpUVBg9uCjXXnH2nfZSMzTckgj36b70IRJf/qgnD5oFEZM3waIb36a7TrUulAzqKDre7
         g6pEvkKU3M6o2M2XsBg7fXhCD63lSsArv+5t9CwTRqSv/HHmGPQTPDpWQsDfFt5s57E/
         otFznxO9gm1N/9tGZ79U3SYpFrhoEHorvXTo3QPKtXwqwbEydF+2UHawVPZW+a69kW+p
         /STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689950565; x=1690555365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdDHMIe9cztVUm68exPMuhOaghi2gznh0/5nfFVFao4=;
        b=Q9pdZnkP6OS78wtI+f3D96Ko0nv1thOnunNNAW88aaVDVigUM3PDRvh5t85h0FNPwL
         UAJpV5n1qss+uuMj6WT4Hu1N8y7C+MSEMVYFgy4rcnxqGvi1kaMRq+7k2/iIv31N0Zao
         f0LLxs3pzTlavsSIt1VdJn8dWhs8aPmiznH++aSrOZwZlVsm+6PGzRl4T7ROWeqAJaJ3
         JCVOrPhKrhhsqwFLQhfvvDu9+MiUCDTqGOTDneN+DCKGQGZ0dUgZCJcg+Xd7h6JC+1Nz
         T+saTQFZvwd8y7BUXQhg0twSgSEunr6rM05QVUTfI34ctYU0RcSmvtLvMbtQfNoOl2d5
         rSkg==
X-Gm-Message-State: ABy/qLZQxf5eHKvrLvxUI0kbNZnVdZ7oyUw63k9JOHMSD6DL8xvW0dRm
        ZGiaUADmYyx7992mW9ZF91D/fg==
X-Google-Smtp-Source: APBJJlEExOyixeH70jR2MtHJXYkNWk5o6Fv6eRLxjUzamtH1I6IPD96oIUz9hnM/aNDVt+3ptMz7rg==
X-Received: by 2002:a6b:b4d5:0:b0:788:2d78:813c with SMTP id d204-20020a6bb4d5000000b007882d78813cmr2070896iof.0.1689950565765;
        Fri, 21 Jul 2023 07:42:45 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d94cf000000b00786cf14a8absm1134207ior.43.2023.07.21.07.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:42:45 -0700 (PDT)
Message-ID: <8ab771e5-a8a7-8588-7877-76c9658afcd3@kernel.dk>
Date:   Fri, 21 Jul 2023 08:42:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 00/14] futex: More futex2 bits
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
References: <20230721102237.268073801@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230721102237.268073801@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/21/23 4:22?AM, Peter Zijlstra wrote:
> Hi,
> 
> New version of the futex2 patches. These are actually tested and appear to work
> as expected.
> 
> I'm hoping to get at least the first 3 patches merged such that Jens can base
> the io_uring futex patches on them.

First 4 now, as we'll need the validate patch as well!

-- 
Jens Axboe

