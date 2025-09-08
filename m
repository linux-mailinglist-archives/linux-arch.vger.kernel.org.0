Return-Path: <linux-arch+bounces-13399-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC522B4824A
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 03:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108023C15F7
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 01:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09BF1DE2C2;
	Mon,  8 Sep 2025 01:51:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB9199931;
	Mon,  8 Sep 2025 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296286; cv=none; b=jDuvpVDN9ZWpXQh3VOTMJE3qpz/nxy5qtho5xICHqZfMNmQ3Fgb7R4JrVcHisHptS5tWLAglxH9KUeymrkFj7QISPEPpVowUD57y/ZyIaXFBZHUKBDY8L/OHYMDNCQcIltCqZzVdFZXEQ7AXT/NfgijimB55mHtLd0sW+yGgpy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296286; c=relaxed/simple;
	bh=Rnd0oa7meviIzF6tXYf3+YacGjLDhyniXj2520WWRro=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EWQZf76Q5Q61tP7GAV590xO3XXyQjzsADfYElxZbkiOw6namX+JapuYfE43v3hg/RtVXzzDADK/q0PMOyQaoO/2r1Z9/WC77xD4Fuq0uio6JvmPcncl6wjOha6fGwjbONCx2tvMETHmoAOMK+Nr2DUEYlTBME9hAf01RhWsGI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cKqbb58x4z1R94P;
	Mon,  8 Sep 2025 09:48:11 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B41E1800D0;
	Mon,  8 Sep 2025 09:51:13 +0800 (CST)
Received: from kwepemn200010.china.huawei.com (7.202.194.133) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 09:51:08 +0800
Received: from [10.174.178.56] (10.174.178.56) by
 kwepemn200010.china.huawei.com (7.202.194.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 09:51:07 +0800
Message-ID: <57ed90e4-7030-4088-85e2-a166736a86f0@huawei.com>
Date: Mon, 8 Sep 2025 09:51:02 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] once: fix race by moving DO_ONCE to separate section
To: Eric Dumazet <edumazet@google.com>
CC: <bobo.shaobowang@huawei.com>, <xiexiuqi@huawei.com>, <arnd@arndb.de>,
	<masahiroy@kernel.org>, <kuba@kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <xiqi2@huawei.com>
References: <20250906134934.1739528-1-xiqi2@huawei.com>
 <CANn89iLi4CQZhAw7DKVauk0+cC+nBjoVuHgAan=cOsCP07Jh=w@mail.gmail.com>
Content-Language: en-GB
From: Qi Xi <xiqi2@huawei.com>
In-Reply-To: <CANn89iLi4CQZhAw7DKVauk0+cC+nBjoVuHgAan=cOsCP07Jh=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn200010.china.huawei.com (7.202.194.133)

Hello Eric,

DO_ONCE_LITE_IF() in once_lite.h is used by WARN_ON_ONCE() and other warning
macros. Keep its ___done flag in the .data..once section and allow resetting
by clear_warn_once, as originally intended.

In contrast, DO_ONCE() is used for functions like get_random_once() and
relies on its ___done flag for internal synchronization.  We should not 
reset
DO_ONCE() by clear_warn_once and move the flag to the new .data..do_once 
section.

I'll send the v2 patch with the comment.

Qi

On 06/09/2025 22:34, Eric Dumazet wrote:
> On Sat, Sep 6, 2025 at 6:58 AM Qi Xi <xiqi2@huawei.com> wrote:
>> The commit c2c60ea37e5b ("once: use __section(".data.once")") moved
>> DO_ONCE's ___done variable to .data.once section, which conflicts with
>> WARN_ONCE series macros that also use the same section.
>>
>> This creates a race condition when clear_warn_once is used:
>>
>> Thread 1 (DO_ONCE)             Thread 2 (DO_ONCE)
>> __do_once_start
>>      read ___done (false)
>>      acquire once_lock
>> execute func
>> __do_once_done
>>      write ___done (true)      __do_once_start
>>      release once_lock             // Thread 3 clear_warn_once reset ___done
>>                                    read ___done (false)
>>                                    acquire once_lock
>>                                execute func
>> schedule once_work            __do_once_done
>> once_deferred: OK                 write ___done (true)
>> static_branch_disable             release once_lock
>>                                schedule once_work
>>                                once_deferred:
>>                                    BUG_ON(!static_key_enabled)
> Should we  use this section as well in include/linux/once_lite.h ?
>
> Or add a comment there explaining that there is a difference
> between the two variants, I am not sure this was explicitly mentioned
> in the past.

