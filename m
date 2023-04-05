Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6116D7C21
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbjDEMBP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 08:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjDEMBM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 08:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A0440C4
        for <linux-arch@vger.kernel.org>; Wed,  5 Apr 2023 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680696023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RSlHLlJfuqzoKBsSMqongiC+StHcDiIfT1vSmb6xVfw=;
        b=P+Dw/F8nfqRsT1SxunmJf/x1jdDiEbgxXATtELrFwIqV1RWClahoK0GNst/6csJqPYAT8h
        KnJFw6dYSPM9onT+1vpHWcCxJjge2dlgSKNAwc3GVhUNx5FtI9YncVgjeYueVjNP6HLeV4
        WtQYtC3uyDVkVm8rR8GSWzsPW0pBuMI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-Q8A5m4L8M3CgAQr7VWRoxA-1; Wed, 05 Apr 2023 08:00:22 -0400
X-MC-Unique: Q8A5m4L8M3CgAQr7VWRoxA-1
Received: by mail-wm1-f71.google.com with SMTP id ay37-20020a05600c1e2500b003ee69edec16so19051068wmb.5
        for <linux-arch@vger.kernel.org>; Wed, 05 Apr 2023 05:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680696020;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSlHLlJfuqzoKBsSMqongiC+StHcDiIfT1vSmb6xVfw=;
        b=yxthopHIXcXCnSJZ/AuPWmR+PJYOTA0TGPCVHKuWjwxnnjeOUqILOah0Zl1Wl092N8
         JPlqrXjQYwNEWlqw+fRBILfCESUfUKpkhDUKYOcnLSsR343WOC1EbSCeH7x2xH0tTF6b
         ljxMKECrwDmyEKTXZuzQKaDyXDKfqvK6NLa3YEsWQWh9kiPuIXBaPIj0wtgSPwfh7MmG
         tfVhGkdG6KOCZZBPkgN3HGCNvYbuwEQ7yl62Z9+W/XM9Dc5DX5B7P6AXRxNrCF2P6LU4
         1VvFuMgSe6bp+k/r2XY6nH4vkGx70jU7zK1Kx+/bSXo/EGzg/qJuSdCaTmnOiWd0TyVz
         7o0A==
X-Gm-Message-State: AAQBX9dk+svtLudzZjTAeyyTJycmzzJy2Og+kF5U5kjnOqIOmR36E+n4
        f5uCJ04I7rdrD2E9gl2aNSSp9E08zEubaqGEJnczZvcT8oN0qb5yZu1kPu3SL3sOwAYPYZiDzro
        FfBwIrjKOnjNxpQuz+7JLnA==
X-Received: by 2002:adf:f851:0:b0:2c6:85ef:4086 with SMTP id d17-20020adff851000000b002c685ef4086mr4082474wrq.32.1680696020601;
        Wed, 05 Apr 2023 05:00:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350a1LUfUOKuj3jMotBlpC19SVSB9cyW7enGegvzefcAmYdi8D6SEfOrURf0tsGiN5OpOE9NhWQ==
X-Received: by 2002:adf:f851:0:b0:2c6:85ef:4086 with SMTP id d17-20020adff851000000b002c685ef4086mr4082439wrq.32.1680696020257;
        Wed, 05 Apr 2023 05:00:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id b13-20020adff24d000000b002c573778432sm14717731wrp.102.2023.04.05.05.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 05:00:19 -0700 (PDT)
Message-ID: <480e9492-2043-4788-eaff-4995e9e3b56e@redhat.com>
Date:   Wed, 5 Apr 2023 14:00:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org,
        paulmck@kernel.org, jpoimboe@kernel.org, samitolvanen@google.com,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, vschneid@redhat.com,
        dhildenb@redhat.com, alougovs@redhat.com
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com> <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen>
 <20230405114148.GA351571@hirez.programming.kicks-ass.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230405114148.GA351571@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05.04.23 13:41, Peter Zijlstra wrote:
> On Wed, Apr 05, 2023 at 01:10:07PM +0200, Frederic Weisbecker wrote:
>> On Wed, Apr 05, 2023 at 12:44:04PM +0200, Frederic Weisbecker wrote:
>>> On Tue, Apr 04, 2023 at 04:42:24PM +0300, Yair Podemsky wrote:
>>>> +	int state = atomic_read(&ct->state);
>>>> +	/* will return true only for cpus in kernel space */
>>>> +	return state & CT_STATE_MASK == CONTEXT_KERNEL;
>>>> +}
>>>
>>> Also note that this doesn't stricly prevent userspace from being interrupted.
>>> You may well observe the CPU in kernel but it may receive the IPI later after
>>> switching to userspace.
>>>
>>> We could arrange for avoiding that with marking ct->state with a pending work bit
>>> to flush upon user entry/exit but that's a bit more overhead so I first need to
>>> know about your expectations here, ie: can you tolerate such an occasional
>>> interruption or not?
>>
>> Bah, actually what can we do to prevent from that racy IPI? Not much I fear...
> 
> Yeah, so I don't think that's actually a problem. The premise is that
> *IFF* NOHZ_FULL stays in userspace, then it will never observe the IPI.
> 
> If it violates this by doing syscalls or other kernel entries; it gets
> to keep the pieces.

Yair is currently on vacation, so I'm replying on his behalf.

Indeed, RT userspace is supposed to not call into the kernel, that's the 
premise.

-- 
Thanks,

David / dhildenb

