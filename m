Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4EA7B503B
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 12:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbjJBK0e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 06:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbjJBK0b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 06:26:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC29A6;
        Mon,  2 Oct 2023 03:26:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzcYh1lwxz67nbv;
        Mon,  2 Oct 2023 18:26:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 11:26:22 +0100
Date:   Mon, 2 Oct 2023 11:26:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ravi Jonnalagadda <ravis.opensrc@micron.com>
CC:     <linux-mm@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dietmar.eggemann@arm.com>, <vincent.guittot@linaro.org>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        <aneesh.kumar@linux.ibm.com>, <gregory.price@memverge.com>,
        <ying.huang@intel.com>, <jgroves@micron.com>,
        <sthanneeru@micron.com>, <emirakhur@micron.com>,
        <vtanna@micron.com>
Subject: Re: [PATCH 1/2] memory tier: Introduce sysfs for tier interleave
 weights.
Message-ID: <20231002112622.0000220a@Huawei.com>
In-Reply-To: <20230927095002.10245-2-ravis.opensrc@micron.com>
References: <20230927095002.10245-1-ravis.opensrc@micron.com>
        <20230927095002.10245-2-ravis.opensrc@micron.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 27 Sep 2023 15:20:01 +0530
Ravi Jonnalagadda <ravis.opensrc@micron.com> wrote:

> From: Srinivasulu Thanneeru <sthanneeru@micron.com>
> 
> Allocating pages across tiers is accomplished by provisioning
> interleave weights for each tier, with the distribution based on
> these weight values.
> By default, all tiers will have a weight of 1, which means
> default standard page allocation. By default all nodes within
> tier will have weight of 1.
> 
> Signed-off-by: Srinivasulu Thanneeru <sthanneeru@micron.com>
> Co-authored-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>

ABI docs?  

Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers

A few trivial comments inline.
> ---
>  include/linux/memory-tiers.h |  2 ++
>  mm/memory-tiers.c            | 46 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 437441cdf78f..c62d286749d0 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -19,6 +19,8 @@
>   */
>  #define MEMTIER_ADISTANCE_DRAM	((4 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
>  
> +#define MAX_TIER_INTERLEAVE_WEIGHT 100
> +
>  struct memory_tier;
>  struct memory_dev_type {
>  	/* list of memory types that are part of same tier as this type */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 37a4f59d9585..7e06c9e0fa41 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -13,6 +13,11 @@ struct memory_tier {
>  	struct list_head list;
>  	/* list of all memory types part of this tier */
>  	struct list_head memory_types;
> +	/*
> +	 * By default all tiers will have weight as 1, which means they
> +	 * follow default standard allocation.
> +	 */
> +	unsigned short interleave_weight;

If you are going to use fixed size, keep it going.
u16 (u8 as per below comment probably makes more sense)


>  	/*
>  	 * start value of abstract distance. memory tier maps
>  	 * an abstract distance  range,
> @@ -145,8 +150,45 @@ static ssize_t nodelist_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(nodelist);
>  
> +static ssize_t interleave_weight_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	struct memory_tier *tier = to_memory_tier(dev);
> +
> +	mutex_lock(&memory_tier_lock);
> +	ret = sysfs_emit(buf, "%u\n", tier->interleave_weight);
> +	mutex_unlock(&memory_tier_lock);

For this one

	guard(mutex)(&memory_tier_lock);
	return sysfs_emit()...

would perhaps be slightly nicer
 (see below)

> +
> +	return ret;
> +}
> +
> +static ssize_t interleave_weight_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t size)
> +{
> +	unsigned short value;
> +	int ret;
> +	struct memory_tier *tier = to_memory_tier(dev);
> +
> +	ret = kstrtou16(buf, 0, &value);

Why u16?  Max is 100.  I'd not mind if you just put it in an
unsigned int, but seems odd to chose a specific size and
pick one that is twice as big as needed!

> +
> +	if (ret)
> +		return ret;
> +	if (value > MAX_TIER_INTERLEAVE_WEIGHT)
> +		return -EINVAL;
> +
> +	mutex_lock(&memory_tier_lock);

You could play with the new cleanup.h	 toys though it doesn't save a lot here.

	scoped_guard(mutex)(&memory_tier_lock)
		tier->interleave_weight = value;

> +	tier->interleave_weight = value;
> +	mutex_unlock(&memory_tier_lock);
> +
> +	return size;
> +}
> +static DEVICE_ATTR_RW(interleave_weight);
> +
>  static struct attribute *memtier_dev_attrs[] = {
>  	&dev_attr_nodelist.attr,
> +	&dev_attr_interleave_weight.attr,
>  	NULL
>  };
>  
> @@ -489,8 +531,10 @@ static struct memory_tier *set_node_memory_tier(int node)
>  	memtype = node_memory_types[node].memtype;
>  	node_set(node, memtype->nodes);
>  	memtier = find_create_memory_tier(memtype);
> -	if (!IS_ERR(memtier))
> +	if (!IS_ERR(memtier)) {
>  		rcu_assign_pointer(pgdat->memtier, memtier);
> +		memtier->interleave_weight = 1;
> +	}
>  	return memtier;
>  }
>  

