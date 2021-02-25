Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B82D324E60
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 11:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhBYKi1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 05:38:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234517AbhBYKfx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Feb 2021 05:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614249265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NA0XhNNgXWdKWddYRBJjHOR9CD09LFOv4oAxt+/QKh8=;
        b=WdDPOmJMbQqk2KIzJr4ckI2A0+ta0zHd1vnLd0BFaRrtSB//xK7HFmmhZuuiPPJylza3y0
        3x6sRE5UmHJPRwtIoQNx1VoNuwU3at0Smw31KGAOH6AdB7hPLFQ/piGPX3+JGdrBzfiS0e
        8nuIGRj6FcoZOTTduWukG9/SA31Bzew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-yrGz6ss2PRqE8fSc9ob9ug-1; Thu, 25 Feb 2021 05:34:21 -0500
X-MC-Unique: yrGz6ss2PRqE8fSc9ob9ug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6854B19611A2;
        Thu, 25 Feb 2021 10:34:18 +0000 (UTC)
Received: from [10.36.114.58] (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 658C619801;
        Thu, 25 Feb 2021 10:34:14 +0000 (UTC)
Subject: Re: [PATCH 2/3] Documentation: riscv: Add documentation that
 describes the VM layout
To:     Alexandre Ghiti <alex@ghiti.fr>, Jonathan Corbet <corbet@lwn.net>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5279e97c-3841-717c-2a16-c249a61573f9@redhat.com>
Date:   Thu, 25 Feb 2021 11:34:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210225080453.1314-3-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

                  |            |                  |         |> + 
ffffffc000000000 | -256    GB | ffffffc7ffffffff |   32 GB | kasan
> +   ffffffcefee00000 | -196    GB | ffffffcefeffffff |    2 MB | fixmap
> +   ffffffceff000000 | -196    GB | ffffffceffffffff |   16 MB | PCI io
> +   ffffffcf00000000 | -196    GB | ffffffcfffffffff |    4 GB | vmemmap
> +   ffffffd000000000 | -192    GB | ffffffdfffffffff |   64 GB | vmalloc/ioremap space
> +   ffffffe000000000 | -128    GB | ffffffff7fffffff |  126 GB | direct mapping of all physical memory

^ So you could never ever have more than 126 GB, correct?

I assume that's nothing new.

-- 
Thanks,

David / dhildenb

