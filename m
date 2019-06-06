Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF88F37804
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 17:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfFFPdC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 11:33:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbfFFPdB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 11:33:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D950C550BB;
        Thu,  6 Jun 2019 15:32:54 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B88DC7D901;
        Thu,  6 Jun 2019 15:32:46 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com, Rahul Yadav <rahul.x.yadav@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
 <C0BC44A5-875C-4BED-A616-D380F6CF25D5@oracle.com>
 <20190605204003.GC3402@hirez.programming.kicks-ass.net>
 <6426D627-77EE-471C-B02A-A85271B666E9@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <409b5d52-1f7d-7f60-04c7-e791e069239f@redhat.com>
Date:   Thu, 6 Jun 2019 11:32:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6426D627-77EE-471C-B02A-A85271B666E9@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 06 Jun 2019 15:33:01 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/6/19 11:21 AM, Alex Kogan wrote:
>>> Also, the paravirt code is under arch/x86, while CNA is generic (not
>>> x86-specific).  Do you still want to see CNA-related patching residing
>>> under arch/x86?
>>>
>>> We still need a config option (something like NUMA_AWARE_SPINLOCKS) to
>>> enable CNA patching under this config only, correct?
>> There is the static_call() stuff that could be generic; I posted a new
>> version of that today (x86 only for now, but IIRC there's arm64 patches
>> for that around somewhere too).
> The static_call technique appears as the more desirable long-term approach, but I think it would be prudent to keep the patches decoupled for now so we can move forward with less entanglements.
> So unless anyone objects, we will work on plugging into the existing patching for pv.
> And we will keep that code under arch/x86, but will be open for any suggestion to move it elsewhere.
>
If you mean making the CNV code depends on PARAVIRT_SPINLOCKS for now,
that is fine. The code should be under kernel/locking. You shouldn't put
it somewhere under arch/x86.

-Longman

