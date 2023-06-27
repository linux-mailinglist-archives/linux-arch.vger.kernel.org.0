Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE1740562
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 23:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjF0VBf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 17:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjF0VBe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 17:01:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3656A1FFA;
        Tue, 27 Jun 2023 14:01:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6686708c986so4897503b3a.0;
        Tue, 27 Jun 2023 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687899692; x=1690491692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P+M7tEnjJDtu150UIK78eMZjmbGUtM7e5Fjt8nWZ0yk=;
        b=EEAFfmkXxvxLQKSckNGd2ZSV3KFogeID+Fu07F5vObGax9BbbGTHMjNPkWpqJAJVcH
         pQvHfFi3MuvS2en7hgib7UJpPWUapwBCg8rlberKLmSq3DFWM7/xIZN7INLmmqEHLsUh
         qitezyDQfhSscafezpHggVgt0WLI8tgIl0uMXCJdPAHvlcj4VIjJKb6j7/ZGCnIDizgv
         wo2zP75PWYpQesW5XMNkIMNlUWOk9aqZVrMomyrANyuVHFRGKdh0f6XzxRPe0kewrYvm
         0KzGKCqgMKcTqBBhxX7lyhj56QxI4SK/fKCSdPeLy85gsmtVFv88cBuoZEpsI4YCe97K
         o/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687899692; x=1690491692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+M7tEnjJDtu150UIK78eMZjmbGUtM7e5Fjt8nWZ0yk=;
        b=XEcNktcyj6O1zStJG/kLVD/USwEI4r94JhYpeY5heTC8dKqDIsMWlaL4AqIGTUjL6N
         6p8QxNPd4jOgmO/oXZL0HwtJkfMlCvHeZQLxbPBes42aSblMzDWRu3ANTITpALig2jNQ
         JZ6Ls0XEOReuXFGciEWqZnmZ+7SKD2a7i1/PxPq0e+LfqSDBn0SID0XiuGKNp5Gy8cD0
         D3c9s7nJ7iU17s3yQjFlbgeX5PK09jEV+cb8km1JRQ/yE/nZvG9+vCQJ11YyeFb53PnS
         yAd5CoWTiP52Bxz8OAyqiy7nIMZ6EPNB0LQ2rGYUl3/SHTCX02UyUQiJrEEoj8Th1C0X
         OsRw==
X-Gm-Message-State: AC+VfDzB188lDQP6jSR6yvdYWlDnv5M448VsJUObqPGuV/stGJxb6wCi
        u5j4wjw2XiW+6yctpQewT2Ld3s1LxlE=
X-Google-Smtp-Source: ACHHUZ5Ms+IS+/rtXxolIJxIsutHi1fnnUiL8cEAZTZ1vZL/Fg4JF6S5Mmuw32zf0DumOU0QNMHuig==
X-Received: by 2002:a17:902:f542:b0:1b5:91:4693 with SMTP id h2-20020a170902f54200b001b500914693mr14752161plf.1.1687899692466;
        Tue, 27 Jun 2023 14:01:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jl3-20020a170903134300b001ac6b926621sm6363521plb.292.2023.06.27.14.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 14:01:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2b7e8b1d-1697-6a25-434d-352f95e6fff2@roeck-us.net>
Date:   Tue, 27 Jun 2023 14:01:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Vishal Moola <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
 <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
 <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
 <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net>
 <b6a5753b-8874-6465-f690-094ee753e038@roeck-us.net>
 <CAOzc2pxdqeaRjYLfOqvMW-AEobTzD9xOP+MyP9nxgEbi1T2r7Q@mail.gmail.com>
 <c3751051-7fc7-7129-b9a7-ead71c576ace@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <c3751051-7fc7-7129-b9a7-ead71c576ace@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/27/23 13:05, Dinh Nguyen wrote:
> 
> 
> On 6/27/23 14:56, Vishal Moola wrote:
>> On Tue, Jun 27, 2023 at 12:14 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On 6/27/23 12:10, Guenter Roeck wrote:
>>>> On 6/27/23 10:42, Vishal Moola wrote:
>>>>> On Mon, Jun 26, 2023 at 10:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>>
>>>>>> On Thu, Jun 22, 2023 at 01:57:38PM -0700, Vishal Moola (Oracle) wrote:
>>>>>>> Part of the conversions to replace pgtable constructor/destructors with
>>>>>>> ptdesc equivalents.
>>>>>>>
>>>>>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>>>>>> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
>>>>>>
>>>>>> This patch causes all nios2 builds to fail.
>>>>>
>>>>> It looks like you tried to apply this patch on its own. This patch depends
>>>>> on patches 01-12 of this patchset to compile properly. I've cross-compiled
>>>>> this architecture and it worked, but let me know if something fails
>>>>> when its applied on top of those patches (or the rest of the patchset).
>>>>
>>>>
>>>> No, I did not try to apply this patch on its own. I tried to build yesterday's
>>>> pending-fixes branch of linux-next.
>>>>
>>>
>>> A quick check shows that the build fails with next-20230627. See log below.
>>
>> Ah it looks like this one slipped into -next on its own somehow? Stephen, please
>> drop this patch from -next; it shouldn't be in without the rest of the
>> patchset which
>> I intend to have Andrew take through the mm tree.
>>
> 
> I apologize, but I queue this patch up for Linus and it's been pulled for this merge window. I didn't realize you were going to take this patchset through another tree.
> 
> Sorry about that.
> 

Yes, indeed, I just confirmed that all nios2 builds in the mainline kernel
are now broken.

Guenter

