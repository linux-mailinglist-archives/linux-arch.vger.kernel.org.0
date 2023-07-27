Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBE37652A9
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjG0Lk3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 07:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjG0Lk2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 07:40:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E623B135;
        Thu, 27 Jul 2023 04:40:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso1403010e87.3;
        Thu, 27 Jul 2023 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690458025; x=1691062825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQNTkXPnx3vtxi9gXhe6F8GyptxWIzVy/cR8pZ3VmZI=;
        b=n+dzJVefXszARcjuYn0EuJDKH4yuffGCemwWfVAWg7ZPElofPkCeKOzMNgjDwlIOqj
         XZckvkessVyXYodF1UvhuOECm/TijRGu/fgNH4Ajq4t7HfAFkKQ9KevjJeKXapg8QxHW
         qhH+rrwJheMYUHlt0jYw1zJhoIECYux/vEpfDLj8PIJMtKfbikVMi9jzG2e7RS3fGSfj
         nx40Uk+jo0o91/rxBbIWje2meP7+ZE+Vkr1xHuA8yPoHsa62S9jTQ4//uTfmol4HQqoB
         jvmvyCPRWlpvpuev5zQFMwZfKpPKVlBpIGkDEsMENkPrnv16yVDmHtUOv/17KdjaDH2T
         FFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458025; x=1691062825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQNTkXPnx3vtxi9gXhe6F8GyptxWIzVy/cR8pZ3VmZI=;
        b=f17APbwW0MYwpFIC/THCaafpK0POUhVp1nZVmZL8vfLQAZ4JJjwPCRs+PvllzTbrGM
         Eue00UQ6wFZf72UpkIyZwyUGYPGQ5Dv+F9X1fjtYXWE60aVNgWCwMSYXDgPqvZ0Bf5NE
         775sAL9dkvkNCPNz9axbw/q3FtfFlBe/nD4NEj4LloJe83zsLG9CqFlTfeJWsopaZSQw
         XZFtlOhr7cTPdO/Yglzvc9Lshfh/p89xdZeP2Xc+HeiIfuixDkavLU7iGcxvghuWtsL1
         pR0B7FA8ThZL8EKTNzhBNGslsWozYLcaQ82PnWNoHe0Wl3Y2OP5vhImMGMnDzyHk6Pox
         lbLQ==
X-Gm-Message-State: ABy/qLaDKKzROr9Y+Ytmo8fl3xipRErYnj+/HYLgKQRbHGIth/UXyUkS
        EHafUWVnTjwqvMAgNXfpBG4=
X-Google-Smtp-Source: APBJJlFZcJdV/2tsOuTHdZeivtkzWTWVOio476KT8N8lXbV+wlSd2bdlofgtNZw6MIh0NjgWFabYQA==
X-Received: by 2002:a19:5f1c:0:b0:4fd:fc3d:cce7 with SMTP id t28-20020a195f1c000000b004fdfc3dcce7mr1288696lfb.44.1690458024822;
        Thu, 27 Jul 2023 04:40:24 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1511:5300:e4c6:3a45:7174:efa8? ([2a00:e180:1511:5300:e4c6:3a45:7174:efa8])
        by smtp.gmail.com with ESMTPSA id v16-20020a1cf710000000b003fc080acf68sm4459448wmh.34.2023.07.27.04.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 04:40:23 -0700 (PDT)
Message-ID: <dfe4bae7-13a0-3c5d-d671-f61b375cb0b4@gmail.com>
Date:   Thu, 27 Jul 2023 13:40:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Linaro-mm-sig] Re: [RFC PATCH 00/10] Device Memory TCP
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>
References: <12393cd2-4b09-4956-fff0-93ef3929ee37@kernel.org>
 <CAHS8izNPTwtk+zN7XYt-+ycpT+47LMcRrYXYh=suTXCZQ6-rVQ@mail.gmail.com>
 <ZLbUpdNYvyvkD27P@ziepe.ca> <20230718111508.6f0b9a83@kernel.org>
 <35f3ec37-11fe-19c8-9d6f-ae5a789843cb@kernel.org>
 <20230718112940.2c126677@kernel.org>
 <eb34f812-a866-a1a3-9f9b-7d5054d17609@kernel.org>
 <20230718154503.0421b4cd@kernel.org>
 <CAHS8izPORN=r2-hzYSgN4s_Aoo2dnwoJXrU5Hu=43sb8zsWyhQ@mail.gmail.com>
 <20230719105711.448f8cad@hermes.local> <ZLhww+P+7zhTTUk7@ziepe.ca>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <ZLhww+P+7zhTTUk7@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Am 20.07.23 um 01:24 schrieb Jason Gunthorpe:
> On Wed, Jul 19, 2023 at 10:57:11AM -0700, Stephen Hemminger wrote:
>
>> Naive idea.
>> Would it be possible for process to use mmap() on the GPU memory and then
>> do zero copy TCP receive some how? Or is this what is being proposed.
> It could be possible, but currently there is no API to recover the
> underlying dmabuf from the VMA backing the mmap.

Sorry for being a bit late, have been on vacation.

Well actually this was discussed before to work around problems with 
Windows applications through wine/proton.

Not 100% sure what the outcome of that was, but if I'm not completely 
mistaken getting the fd behind a VMA should be possible.

It might just not be the DMA-buf fd, because we use mmap() re-routing to 
be able to work around problems with the reverse tracking of mappings.

Christian.

>
> Also you can't just take arbitary struct pages from any old VMA and
> make them "netmem"
>
> Jason
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org

