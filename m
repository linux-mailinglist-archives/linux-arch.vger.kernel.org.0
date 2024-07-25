Return-Path: <linux-arch+bounces-5632-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF7793C796
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 19:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D5A2822CE
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7715819DF54;
	Thu, 25 Jul 2024 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="sv2rZIsu"
X-Original-To: linux-arch@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A1C14A82
	for <linux-arch@vger.kernel.org>; Thu, 25 Jul 2024 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927817; cv=none; b=UsMKcaDc20F5ISmByyqu8LB75SRt4+ZvriMvbvgVv5ZpBTOimcQaAMvyNAc7w4fpTuQ2C60Eego8l5FE9M+Ash3yMio8xQKgF3ex09oteafJtztLcPfIHIILsQIJNG/ea8PYkBpVX/J31Nlxhgei6ineteJvPpCZ6rdAm5t8/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927817; c=relaxed/simple;
	bh=6+NYjaaWQjPgYA8E4Kvwk5zgAalJY3/PEZO6lBK4bYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBfOvsJBXrRda+MEfnDF/C4SWgVmT+aE6ffgC+oJZ0K0Efq29USZPGQSkRrD8PSZd5Wbmg0p1RtxRI+ZPmQsCK5IfscLLkX0pnSIMp+smdFZcG+zF4V9a3MJbpk5Q3RK2R+IBJMs5/B2dtNY1ZEsvLy/7BaE4mNCEmVlrLRJDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=sv2rZIsu; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id X22gsAgcOUZkEX22hsDYMn; Thu, 25 Jul 2024 19:14:16 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1721927656; bh=NfPTdF6NiK8Ugj9UJnwjr7KjQLdt6YNvXp7SXJiAaTA=;
	h=From;
	b=sv2rZIsuh+TZrJuuwjVZQ+UNjifdwjxYosNmNRvlVCw3eTselSqPsCJJ+mfWUKChB
	 IOW33olXIzZzs49jRf2lXOOZh9jSEas/WyD9vlIUHYsMa58AYH02usPcCXsVq30MxA
	 w9UnOEfc3/FF8gl3OtLWEnMDA3ETw4T+AHiiamykbU37SUDAIUf4qAmMUaeeRdqomW
	 53FHICYBUJER18vN9zpu0yI7fUDZf/FdS9ETOvwQaFrRlXx/FEJfsuqm3Q16TqPvSl
	 BWUZOheBPOTcHIQmeHKLax//MkJWiEHZrHbcmk64/nw7G1Mhd6PbCLw1W2HB6KVhan
	 OofMRLPiVNNVg==
X-CNFS-Analysis: v=2.4 cv=P43xhTAu c=1 sm=1 tr=0 ts=66a287e8 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=2a-IQ_BPnOOq8STWmVUA:9 a=QEXdDO2ut3YA:10
Message-ID: <68584887-3dec-4ce5-8892-86af50651c41@libero.it>
Date: Thu, 25 Jul 2024 19:14:14 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
To: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Youling Tang <youling.tang@linux.dev>,
 Luis Chamberlain <mcgrof@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Youling Tang <tangyouling@kylinos.cn>
References: <20240723083239.41533-1-youling.tang@linux.dev>
 <20240723083239.41533-2-youling.tang@linux.dev>
 <Zp-_RDk5n5431yyh@infradead.org>
 <0a63dfd1-ead3-4db3-a38c-2bc1db65f354@linux.dev>
 <ZqEhMCjdFwC3wF4u@infradead.org>
 <895360e3-97bb-4188-a91d-eaca3302bd43@linux.dev>
 <ZqJjsg3s7H5cTWlT@infradead.org>
 <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
 <ZqJwa2-SsIf0aA_l@infradead.org>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <ZqJwa2-SsIf0aA_l@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfG/Wvh0SRpiC6+9TK5wDnJHkad1zDDvsaBJvq3RV0wxQe/gsCv892ru65MTczmo5pUQbMVX1NrSDKvwqHfPhuJBf0ZxGzZeEL+a+mvbgls/Akdt1xnWI
 QVhkfaLd9wCv/5kE+RXroTc8NBaqfGNvTkgm8wW/kV+ID+bMQPyU9v2N50kCXz/az8FjEsLILcwQkb56M9QCNJLf5/x4Edv+D9ZhMzYbSo8fSwZGhzvPUhFy
 alLW3nbg9ry6fouAwd6fMSP76dUADaS1CRxSpsHzaCoHNwECubxa/2NXm3ZYxMpcjU8sN2MtV21GcpexDxmy+Sr3xbx+P6Vt1DU7fGY56SSYqSvs5k73a0Du
 GxpE2dsJ5cD+U0N9zYReAO4pGZvz3VWIDnOB06t6HoHLF24cazVbsYQuF6IIM2VQm7Mbu1G8Jd56XLbPJb4RCy1Z1fkWC6H3z8C7pr/rpSYiK3hhZBwrFydP
 fUV66fKGVnIFcE1O24B5weWxHgrN1goxpDFVQDc77xc6wCo7bDDaJuZCdAvJHBUQWMiYTlZRbSMOBMvY1xkCktZX2iS13vdrThLlld56N+oUhO0t70FYx+uj
 YxVqoXAL4Ts8d2ykDkeTVr3CUL4HiWTiWGozXnb8THEphRoSBFPeFuOUBiETwenwSU0MOY11dbBFOqGBybicQS69laD9aAqO314s+9tUAJrvzHltLzTYuD/q
 PdS1vxWgkiPYI+0XgUX2wtTCNSW5xE4Skow3bECu2B4KzzaztlFzYA==

On 25/07/2024 17.34, Christoph Hellwig wrote:
> On Thu, Jul 25, 2024 at 05:30:58PM +0200, Arnd Bergmann wrote:
>> Now I think we could just make the module_init() macro
>> do the same thing as a built-in initcall() and put
>> an entry in a special section, to let you have multiple
>> entry points in a loadable module.
>>
>> There are still at least two problems though:
>>
>> - while link order is defined between files in a module,
>>    I don't think there is any guarantee for the order between
>>    two initcalls of the same level within a single file.
> 
> I think the sanest answer is to only allow one per file.  If you
> are in the same file anyway calling one function from the other
> is not a big burden.  It really is when they are spread over files
> when it is annoying, and the three examples show that pretty
> clearly.
> 
>> - For built-in code we don't have to worry about matching
>>    the order of the exit calls since they don't exist there.
>>    As I understand, the interesting part of this patch
>>    series is about making sure the order matches between
>>    init and exit, so there still needs to be a way to
>>    express a pair of such calls.
> 
> That's why you want a single macro to define the init and exit
> callbacks, so that the order can be matched up and so that
> error unwinding can use the relative position easily.
> 

Instead of relying to the "expected" order of the compiler/linker,
why doesn't manage the chain explicitly ? Something like:

struct __subexitcall_node {
	void (*exitfn)(void);
	struct subexitcall_node  *next;

static inline void __subexitcall_rollback(struct __subexitcall_node *p)
{
	while (p) {
		p->exitfn();
		p = p->next;
	}
}

#define __subinitcall_noexit(initfn, rollback)					\
do {										\
	int _ret;								\
	_ret = initfn();							\
	if (_ret < 0) {								\
		__subexitcall_rollback(rollback);				\
		return _ret;							\
	}									\
} while (0)

#define __subinitcall(initfn, exitfn, rollback)						\
do {											\
	static subexitcall_node node = {exitfn, rollback->head};	                \
	__subinitcall_noexit(initfn, rollback);						\
	rollback = &node;
} while (0)


#define MODULE_SUBINIT_INIT(rollback) \
	struct __subexitcall_node	*rollback = NULL

#define MODULE_SUBINIT_CALL(initfn, exitfn, rollback) \
	__subinitcall(initfn, exitfn, rollback)

#define MODULE_SUBINIT_CALL_NOEXIT(initfn, rollback) \
	__subinitcall_noexit(initfn, rollback)

#define MODULE_SUBEXIT(rollback) 		\
do {						\
	__subexitcall_rollback(rollback);	\
	rollback = NULL;			\
} while(0)

usage:

	MODULE_SUBINIT_INIT(rollback);

	
	MODULE_SUBINIT_CALL(init_a, exit_a, rollback);
	MODULE_SUBINIT_CALL(init_b, exit_b, rollback);
	MODULE_SUBINIT_CALL_NOEXIT(init_c, rollback);


	MODULE_SUBEXIT(rollback);

this would cost +1 pointer for each function. But this would save from situation like

	r = init_a();
	if (r)
		init_b();
	init_c();




-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


