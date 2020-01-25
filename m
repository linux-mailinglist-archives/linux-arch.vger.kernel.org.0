Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1942E149782
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2020 20:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgAYTlw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jan 2020 14:41:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22794 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726780AbgAYTlw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jan 2020 14:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579981310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AgpWBVZ2Zmngb4zlRI3WuIHZKM7LDWwyVepAeoXIIIw=;
        b=UobfgHjSGNTtIUqscxGN8TjnsxspaL94gUHshVjkPCwfPbOKBZ8SUam0fsMxfMVU8+HH6l
        /q+/USV+aO4eWam0aTX7ncXzbykl1eDUjuDvcVQBBoAC9rFSeqVLb0fMUw2owT9I7Q3QLv
        btWRP/moFjN6MisvnnUZ/RqQGiIIFCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-9INydv1jPCy2zEZg_D8bFQ-1; Sat, 25 Jan 2020 14:41:45 -0500
X-MC-Unique: 9INydv1jPCy2zEZg_D8bFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22CD91800D48;
        Sat, 25 Jan 2020 19:41:42 +0000 (UTC)
Received: from llong.remote.csb (ovpn-121-36.rdu2.redhat.com [10.10.121.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F9172718F;
        Sat, 25 Jan 2020 19:41:37 +0000 (UTC)
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
To:     paulmck@kernel.org
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200124222434.GA7196@paulmck-ThinkPad-P72>
 <6AAE7FC6-F5DE-4067-8BC4-77F27948CD09@oracle.com>
 <20200125005713.GZ2935@paulmck-ThinkPad-P72>
 <02defadb-217d-7803-88a1-ec72a37eda28@redhat.com>
 <adb4fb09-f374-4d64-096b-ba9ad8b35fd5@redhat.com>
 <20200125045844.GC2935@paulmck-ThinkPad-P72>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <967f99ee-b781-43f4-d8ba-af83786c429c@redhat.com>
Date:   Sat, 25 Jan 2020 14:41:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200125045844.GC2935@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/24/20 11:58 PM, Paul E. McKenney wrote:
> On Fri, Jan 24, 2020 at 09:17:05PM -0500, Waiman Long wrote:
>> On 1/24/20 8:59 PM, Waiman Long wrote:
>>>> You called it!  I will play with QEMU's -numa argument to see if I can get
>>>> CNA to run for me.  Please accept my apologies for the false alarm.
>>>>
>>>> 							Thanx, Paul
>>>>
>>> CNA is not currently supported in a VM guest simply because the numa
>>> information is not reliable. You will have to run it on baremetal to
>>> test it. Sorry for that.
>> Correction. There is a command line option to force CNA lock to be used
>> in a VM. Use the "numa_spinlock=on" boot command line parameter.
> As I understand it, I need to use a series of -numa arguments to qemu
> combined with the numa_spinlock=on (or =1) on the kernel command line.
> If the kernel thinks that there is only one NUMA node, it appears to
> avoid doing CNA.
>
> Correct?
>
> 							Thanx, Paul
>
In auto-detection mode (the default), CNA will only be turned on when
paravirt qspinlock is not enabled first and there are at least 2 numa
nodes. The "numa_spinlock=on" option will force it on even when both of
the above conditions are false.

Cheers,
Longman

