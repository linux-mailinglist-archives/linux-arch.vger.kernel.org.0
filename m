Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D04324F90
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 12:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBYL5G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 06:57:06 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:41931 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhBYL5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 06:57:06 -0500
Received: from [192.168.43.237] (35.161.185.81.rev.sfr.net [81.185.161.35])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 85E2B200008;
        Thu, 25 Feb 2021 11:56:12 +0000 (UTC)
Subject: Re: [PATCH 2/3] Documentation: riscv: Add documentation that
 describes the VM layout
To:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
References: <20210225080453.1314-1-alex@ghiti.fr>
 <20210225080453.1314-3-alex@ghiti.fr>
 <5279e97c-3841-717c-2a16-c249a61573f9@redhat.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <7d9036d9-488b-47cc-4673-1b10c11baad0@ghiti.fr>
Date:   Thu, 25 Feb 2021 06:56:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <5279e97c-3841-717c-2a16-c249a61573f9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Le 2/25/21 à 5:34 AM, David Hildenbrand a écrit :
>                   |            |                  |         |> + 
> ffffffc000000000 | -256    GB | ffffffc7ffffffff |   32 GB | kasan
>> +   ffffffcefee00000 | -196    GB | ffffffcefeffffff |    2 MB | fixmap
>> +   ffffffceff000000 | -196    GB | ffffffceffffffff |   16 MB | PCI io
>> +   ffffffcf00000000 | -196    GB | ffffffcfffffffff |    4 GB | vmemmap
>> +   ffffffd000000000 | -192    GB | ffffffdfffffffff |   64 GB | 
>> vmalloc/ioremap space
>> +   ffffffe000000000 | -128    GB | ffffffff7fffffff |  126 GB | 
>> direct mapping of all physical memory
> 
> ^ So you could never ever have more than 126 GB, correct?
> 
> I assume that's nothing new.
> 

Before this patch, the limit was 128GB, so in my sense, there is nothing 
new. If ever we want to increase that limit, we'll just have to lower 
PAGE_OFFSET, there is still some unused virtual addresses after kasan 
for example.

Thanks,

Alex
