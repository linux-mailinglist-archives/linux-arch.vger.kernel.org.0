Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBA335F9EF
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 19:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350411AbhDNRbw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 13:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233568AbhDNRbu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 13:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618421487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pwu8ITVpaktX/oaFXebOFcED+CIuIn8065SfkxgfWGI=;
        b=iTt40Y0tPmQzD8yLHF5bBjlU3I1o9EYos+2WhgWVijeVp0hRx3wYbL6tNQeN0HpfQS4ymr
        WHm2ELVDAyf0rRTTw7GhK74+CEsD//MGm7AVFIRoihvLxIs0yN0XG2rS6yVt9hKfs0DDeu
        Amjyff9iOBjHuXupCdLLhVa/QC4+zv4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-i9tRVYHdO8uGsLLm6lUFRw-1; Wed, 14 Apr 2021 13:31:25 -0400
X-MC-Unique: i9tRVYHdO8uGsLLm6lUFRw-1
Received: by mail-qt1-f197.google.com with SMTP id o15-20020ac872cf0000b02901b358afcd96so2375223qtp.1
        for <linux-arch@vger.kernel.org>; Wed, 14 Apr 2021 10:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Pwu8ITVpaktX/oaFXebOFcED+CIuIn8065SfkxgfWGI=;
        b=M6x4UbQLP9NrEkORJuLVpPbD0+t9s3jtbukpRlpSsOfWCRHsq8O4azNEh0GLUZ83cd
         n1LoHIT06igZuyrhf+nbuLoRRcxxe5TBmdlvGd94KP4ESVcJUmuoex9cNi/wRLu5XQ9n
         U2BbSEU8GNNMfQPxEusNd5S84/zoBIn/TiKR1lZboJZ51IcpXew6Xo6/LmYyYW+7Nano
         DLjP7QjHBGUljqDOvGvmz//SwBa0KTIRbAI9VnejlERBdhazqocJTwyTuzW44bWLOxX0
         ZmmmM0f7hfnykb/8O0IUN4jrnzbnZMy2kfcqEqXWtBjkKWjOUf3WNt01IvE263VFyzVi
         zqkg==
X-Gm-Message-State: AOAM533XldzPD8SEczyIvo85kcnMK+5BXRwZhOp6eVoXRonwZ0I8Oa5l
        oo3Ycc1ofs3UmQ6S5Y8sBPRuY6ltIXoOKdUDtovNMBLrtrXPxYDDIzFCIvQj7jbJ73itqz96H2y
        mqr8t946LvIgMxf2y/4MNag==
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr6147256qkf.482.1618421480635;
        Wed, 14 Apr 2021 10:31:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRXvclwrtNw0vyg4pKHWPDmETRkr+Mf1wxudR7KTzhxmhPecsOFB7lkLfuIC0V32mXc/loLw==
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr6147223qkf.482.1618421480434;
        Wed, 14 Apr 2021 10:31:20 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id t17sm18505qtr.42.2021.04.14.10.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 10:31:19 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [External] : Re: [PATCH v14 4/6] locking/qspinlock: Introduce
 starvation avoidance into CNA
To:     Andi Kleen <ak@linux.intel.com>, Waiman Long <llong@redhat.com>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
 <20210401153156.1165900-5-alex.kogan@oracle.com>
 <87mtu2vhzz.fsf@linux.intel.com>
 <CA1141EF-76A8-47A9-97B9-3CB2FC246B1A@oracle.com>
 <4a9dbfa7-db68-a2dc-9018-a5b74f0f421c@redhat.com>
 <20210414172602.GW3762101@tassilo.jf.intel.com>
Message-ID: <6c968acd-dda2-ed1f-6582-b7811030761e@redhat.com>
Date:   Wed, 14 Apr 2021 13:31:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210414172602.GW3762101@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/14/21 1:26 PM, Andi Kleen wrote:
>> The CNA code, if enabled, will be in vmlinux, not in a kernel module. As a
>> result, I think a module parameter will be no different from a kernel
>> command line parameter in this regard.
> You can still change it in /sys at runtime, even if it's in the vmlinux.

I see, thank for the clarification.

Cheers,
Longman

