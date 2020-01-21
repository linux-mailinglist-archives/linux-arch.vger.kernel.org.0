Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5828144656
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 22:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgAUVTk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 16:19:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36778 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728748AbgAUVTk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 16:19:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579641578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUDc746gEw7bmqdrDee21GPcvrO5Acs+G0v791qb43c=;
        b=S9Yu3+P3dLrjAR0ppmzmmGFvZZLAxmuqWcSDg1CU4pamGDSk/tCUOFGOgKxI67dkp715zC
        LoJjriDv/mt7c+B2cnmaUz5IPSURqu9taw+sXq0GbPc08LPUzCcChh4gIap8xLZRt8kit5
        79JZzmnJiDIR5YucLWQf3zA8k7haDnI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-nWyzJNnJPCGv599a_xH9dg-1; Tue, 21 Jan 2020 16:19:36 -0500
X-MC-Unique: nWyzJNnJPCGv599a_xH9dg-1
Received: by mail-wr1-f72.google.com with SMTP id u18so1989075wrn.11
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2020 13:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hUDc746gEw7bmqdrDee21GPcvrO5Acs+G0v791qb43c=;
        b=bb9KXw9a7PnMwtv9gd1AWwRB0SFtnF7zipEb6yPATD/K93QJMJFquZZMimcUVOcuDe
         xX7bNUYbiHAWQA+PWYWHSHPMG3r9BYzc2p3rDINjw9vRaeifRnuPKas4a4MfMkJnd70A
         1UhdZUyT8tD6nb8XGtrNmp7WpZg2PMak41h/vHae0oYWWA4FLlWYxwLDVPmflRlv9Fve
         5/EF+bFobGSUWHJlm/0PUtZFgfHcNMO2N3Kn1sg6w894mlU2Anr8GurnhcVmo3wgsbDK
         dI+31+6TUbRi9VcEZ0OcqDAVgo/hdoqc4tBW77OkKSmya3Izow+/+tUKW6pnw3zKTqzU
         Osdw==
X-Gm-Message-State: APjAAAWqU2xPkHTxog2USgeP0pzb7NoeSunnodCaWwGHNE1oRUxorier
        inaxPM6U8O0RyRydGIExFNqWJHwBNbeQOaSqAny9kfPIC620Sv1WjkJiTwdSardsvRDwt7WRoKu
        jimcH64c2c04StOB+QzyYxg==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr7108154wru.52.1579641574577;
        Tue, 21 Jan 2020 13:19:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoPnkxLxUGe7WRD6VylEoIv+x6W5+cow3h5Z9Uz8mj37YpcfxZ7pVN18YIIyxft0zVUg14Tg==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr7108137wru.52.1579641574308;
        Tue, 21 Jan 2020 13:19:34 -0800 (PST)
Received: from x1.bristot.me ([83.136.205.253])
        by smtp.gmail.com with ESMTPSA id v22sm872400wml.11.2020.01.21.13.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 13:19:33 -0800 (PST)
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
To:     Peter Zijlstra <peterz@infradead.org>,
        Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <20200121135034.GA14946@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <e10414a6-dbfc-a666-18b8-a0499c93a203@redhat.com>
Date:   Tue, 21 Jan 2020 22:19:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121135034.GA14946@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/21/20 2:50 PM, Peter Zijlstra wrote:
> On Tue, Jan 21, 2020 at 02:29:49PM +0100, Peter Zijlstra wrote:
>> On Mon, Dec 30, 2019 at 02:40:41PM -0500, Alex Kogan wrote:
>>
>>> +/*
>>> + * Controls the threshold for the number of intra-node lock hand-offs before
>>> + * the NUMA-aware variant of spinlock is forced to be passed to a thread on
>>> + * another NUMA node. By default, the chosen value provides reasonable
>>> + * long-term fairness without sacrificing performance compared to a lock
>>> + * that does not have any fairness guarantees. The default setting can
>>> + * be changed with the "numa_spinlock_threshold" boot option.
>>> + */
>>> +int intra_node_handoff_threshold __ro_after_init = 1 << 16;
>> There is a distinct lack of quantitative data to back up that
>> 'reasonable' claim there.
>>
>> Where is the table of inter-node latencies observed for the various
>> values tested, and on what criteria is this number deemed reasonable?
>>
>> To me, 64k lock hold times seems like a giant number, entirely outside
>> of reasonable.
> Daniel, IIRC you just did a paper on constructing worst case latencies
> from measuring pieces. Do you have data on average lock hold times?
> 

I am still writing the paper, but I do not have the (avg) lock times. It is it
is in the TODO list, though!

-- Daniel

