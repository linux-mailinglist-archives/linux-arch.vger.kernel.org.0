Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54CE96BD1C
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 15:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfGQNft (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 09:35:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbfGQNft (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 09:35:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EFE3159465;
        Wed, 17 Jul 2019 13:35:48 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85BC65DA34;
        Wed, 17 Jul 2019 13:35:46 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <9fa54e98-0b9b-0931-db32-c6bd6ccfe75b@redhat.com>
 <20190717074435.GU3419@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <378093ad-46cc-7ecb-5a06-1e22ee5ce4a1@redhat.com>
Date:   Wed, 17 Jul 2019 09:35:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190717074435.GU3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 17 Jul 2019 13:35:49 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/17/19 3:44 AM, Peter Zijlstra wrote:
> On Tue, Jul 16, 2019 at 10:16:29PM -0400, Waiman Long wrote:
>>  A simple graphic to illustrate those queues will help too, for example
> Very much yes!
>
>> /*
>>  * MCS lock holder
>>  * ===============
>>  *    mcs_node
>>  *   +--------+      +----+         +----+
>>  *   | next   | ---> |next| -> ...  |next| -> NULL  [Main queue]
>>  *   | locked | -+   +----+         +----+
>>  *   +--------+  |
>>  *               |   +----+         +----+
>>  *               +-> |next| -> ...  |next| -> X     [Secondary queue]
>>  *    cna_node       +----+         +----+
>>  *   +--------*                       ^
>>  *   | tail   | ----------------------+
>>  *   +--------*   
> Almost; IIUC that cna_node is the same as the one from locked, so you
> end up with something like:
>
>>  *    mcs_node
>>  *   +--------+      +----+         +----+
>>  *   | next   | ---> |next| -> ...  |next| -> NULL  [Main queue]
>>  *   | locked | -+   +----+         +----+
>>  *   +--------+  |
>>  *               |   +---------+         +----+
>>  *               +-> |mcs::next| -> ...  |next| -> NULL     [Secondary queue]
>>  *                   |cna::tail| -+      +----+
>>  *                   +---------+  |        ^
>>  *                                +--------+
>>  *
>>  * N.B. locked = 1 if secondary queue is absent.
>>  */

Yes, you are right. Thanks for the correction.

Cheers,
Longman

