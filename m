Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7C06AACD
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 16:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfGPOoL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 10:44:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfGPOoK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jul 2019 10:44:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14A2E85546;
        Tue, 16 Jul 2019 14:44:10 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-180.rdu2.redhat.com [10.10.122.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 457726013A;
        Tue, 16 Jul 2019 14:44:07 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <77bba626-f3e6-45a8-aae8-43b945d0fab9@redhat.com>
 <32DD898E-0F5E-4A63-9795-F78411B77A98@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8ceec931-2921-6ee6-2642-476b4a12281e@redhat.com>
Date:   Tue, 16 Jul 2019 10:44:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <32DD898E-0F5E-4A63-9795-F78411B77A98@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 16 Jul 2019 14:44:10 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/16/19 10:26 AM, Alex Kogan wrote:
>> On Jul 15, 2019, at 5:30 PM, Waiman Long <longman@redhat.com> wrote:
>>
>> On 7/15/19 3:25 PM, Alex Kogan wrote:
>>
>>> /*
>>> - * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
>>> - * size and four of them will fit nicely in one 64-byte cacheline. For
>>> - * pvqspinlock, however, we need more space for extra data. To accommodate
>>> - * that, we insert two more long words to pad it up to 32 bytes. IOW, only
>>> - * two of them can fit in a cacheline in this case. That is OK as it is rare
>>> - * to have more than 2 levels of slowpath nesting in actual use. We don't
>>> - * want to penalize pvqspinlocks to optimize for a rare case in native
>>> - * qspinlocks.
>>> + * On 64-bit architectures, the mcs_spinlock structure will be 20 bytes in
>>> + * size. For pvqspinlock or the NUMA-aware variant, however, we need more
>>> + * space for extra data. To accommodate that, we insert two more long words
>>> + * to pad it up to 36 bytes.
>>>  */
>> The 20 bytes figure is wrong. It is actually 24 bytes for 64-bit as the
>> mcs_spinlock structure is 8-byte aligned. For better cacheline
>> alignment, I will like to keep mcs_spinlock to 16 bytes as before.
>> Instead, you can use encode_tail() to store the CNA node pointer in
>> "locked". For instance, use (encode_tail() << 1) in locked to
>> distinguish it from the regular locked=1 value.
> I think this can work.
> decode_tail() will get the actual node pointer from the encoded value.
> And that would keep the size of mcs_spinlock intact.
> Good idea, thanks!
>
> BTW, maybe better change those function names to encode_node() / decode_node() then?

The names look good to me.


>
>>> s
>>> +
>>> +static void cna_init_node(struct mcs_spinlock *node)
>>> +{
>>> +	struct cna_node *cn = CNA_NODE(node);
>>> +	struct mcs_spinlock *base_node;
>>> +	int cpuid;
>>> +
>>> +	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
>>> +	/* we store a pointer in the node's @locked field */
>>> +	BUILD_BUG_ON(sizeof(uintptr_t) > sizeof_field(struct mcs_spinlock, locked));
>>> +
>>> +	cpuid = smp_processor_id();
>>> +	cn->numa_node = cpu_to_node(cpuid);
>>> +
>>> +	base_node = this_cpu_ptr(&qnodes[0].mcs);
>>> +	cn->encoded_tail = encode_tail(cpuid, base_node->count - 1);
>>> +}
>>
>> I think you can use an early_init call to initialize the numa_node and
>> encoded_tail values for all the per-cpu CNA nodes instead of doing it
>> every time a node is used. If it turns out that pv_qspinlock is used,
>> the pv_node_init() will properly re-initialize it.
> Yes, this should work. Thanks.
>
> BTW, should not we initialize `cpu` in pv_init_node() that same way?

We would also initialize cpu this way in pv_init_node. The
smp_processor_id() call is relatively cheap, but the initialization done
here is more expensive.


>> The only thing left
>> to do here is perhaps setting tail to NULL.
> There is no need to initialize cna_node.tail — we never access it unless
> the node is at the head of the secondary queue, and in that case we 
> initialize it before placing the node at the head of that queue 
> (see find_successor()).

OK.

-Longman

