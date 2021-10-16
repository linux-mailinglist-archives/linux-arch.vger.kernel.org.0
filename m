Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A1043008A
	for <lists+linux-arch@lfdr.de>; Sat, 16 Oct 2021 08:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbhJPGaU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 Oct 2021 02:30:20 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:43113 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233802AbhJPGaU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 16 Oct 2021 02:30:20 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HWY9Q53xqz9sSL;
        Sat, 16 Oct 2021 08:28:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k-Fz29ksyfF0; Sat, 16 Oct 2021 08:28:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HWY9Q3nwlz9sSH;
        Sat, 16 Oct 2021 08:28:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E0778B765;
        Sat, 16 Oct 2021 08:28:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4rYxWz_zPmYc; Sat, 16 Oct 2021 08:28:10 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.36])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 215348B763;
        Sat, 16 Oct 2021 08:28:09 +0200 (CEST)
Subject: Re: [PATCH v2 13/13] lkdtm: Add a test for function descriptors
 protection
To:     Kees Cook <keescook@chromium.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
 <08a3dfbc55e1c7a0a1917b22f0ca6cabd9895ab2.1634190022.git.christophe.leroy@csgroup.eu>
 <202110151433.6270D717@keescook>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b11bab54-04bd-4244-a043-b3d8df34967b@csgroup.eu>
Date:   Sat, 16 Oct 2021 08:28:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202110151433.6270D717@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 15/10/2021 à 23:35, Kees Cook a écrit :
> On Thu, Oct 14, 2021 at 07:50:02AM +0200, Christophe Leroy wrote:
>> Add WRITE_OPD to check that you can't modify function
>> descriptors.
>>
>> Gives the following result when function descriptors are
>> not protected:
>>
>> 	lkdtm: Performing direct entry WRITE_OPD
>> 	lkdtm: attempting bad 16 bytes write at c00000000269b358
>> 	lkdtm: FAIL: survived bad write
>> 	lkdtm: do_nothing was hijacked!
>>
>> Looks like a standard compiler barrier(); is not enough to force
>> GCC to use the modified function descriptor. Add to add a fake empty
>> inline assembly to force GCC to reload the function descriptor.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   drivers/misc/lkdtm/core.c  |  1 +
>>   drivers/misc/lkdtm/lkdtm.h |  1 +
>>   drivers/misc/lkdtm/perms.c | 22 ++++++++++++++++++++++
>>   3 files changed, 24 insertions(+)
>>
>> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
>> index fe6fd34b8caf..de092aa03b5d 100644
>> --- a/drivers/misc/lkdtm/core.c
>> +++ b/drivers/misc/lkdtm/core.c
>> @@ -148,6 +148,7 @@ static const struct crashtype crashtypes[] = {
>>   	CRASHTYPE(WRITE_RO),
>>   	CRASHTYPE(WRITE_RO_AFTER_INIT),
>>   	CRASHTYPE(WRITE_KERN),
>> +	CRASHTYPE(WRITE_OPD),
>>   	CRASHTYPE(REFCOUNT_INC_OVERFLOW),
>>   	CRASHTYPE(REFCOUNT_ADD_OVERFLOW),
>>   	CRASHTYPE(REFCOUNT_INC_NOT_ZERO_OVERFLOW),
>> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
>> index c212a253edde..188bd0fd6575 100644
>> --- a/drivers/misc/lkdtm/lkdtm.h
>> +++ b/drivers/misc/lkdtm/lkdtm.h
>> @@ -105,6 +105,7 @@ void __init lkdtm_perms_init(void);
>>   void lkdtm_WRITE_RO(void);
>>   void lkdtm_WRITE_RO_AFTER_INIT(void);
>>   void lkdtm_WRITE_KERN(void);
>> +void lkdtm_WRITE_OPD(void);
>>   void lkdtm_EXEC_DATA(void);
>>   void lkdtm_EXEC_STACK(void);
>>   void lkdtm_EXEC_KMALLOC(void);
>> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
>> index 96b3ebfcb8ed..3870bc82d40d 100644
>> --- a/drivers/misc/lkdtm/perms.c
>> +++ b/drivers/misc/lkdtm/perms.c
>> @@ -44,6 +44,11 @@ static noinline void do_overwritten(void)
>>   	return;
>>   }
>>   
>> +static noinline void do_almost_nothing(void)
>> +{
>> +	pr_info("do_nothing was hijacked!\n");
>> +}
>> +
>>   static void *setup_function_descriptor(func_desc_t *fdesc, void *dst)
>>   {
>>   	memcpy(fdesc, do_nothing, sizeof(*fdesc));
>> @@ -143,6 +148,23 @@ void lkdtm_WRITE_KERN(void)
>>   	do_overwritten();
>>   }
>>   
>> +void lkdtm_WRITE_OPD(void)
>> +{
>> +	size_t size = sizeof(func_desc_t);
>> +	void (*func)(void) = do_nothing;
>> +
>> +	if (!have_function_descriptors()) {
>> +		pr_info("Platform doesn't have function descriptors.\n");
> 
> This should be more explicit ('xfail'):
> 
> 	pr_info("XFAIL: platform doesn't use function descriptors.\n");

Ok


> 
>> +		return;
>> +	}
>> +	pr_info("attempting bad %zu bytes write at %px\n", size, do_nothing);
>> +	memcpy(do_nothing, do_almost_nothing, size);
>> +	pr_err("FAIL: survived bad write\n");
>> +
>> +	asm("" : "=m"(func));
> 
> Since this is a descriptor, I assume no icache flush is needed. Are
> function descriptors strictly dcache? (Is anything besides just a
> barrier needed?)

No flush is needed, the code just loads the function address from memory 
into CTR, loads R2 and branch to CTR:

	 19c:	e9 21 00 70 	ld      r9,112(r1)
	 1a0:	e9 49 00 00 	ld      r10,0(r9)
	 1a4:	7d 49 03 a6 	mtctr   r10
	 1a8:	e8 49 00 08 	ld      r2,8(r9)
	 1ac:	4e 80 04 21 	bctrl


> 
>> +	func();
>> +}
>> +
>>   void lkdtm_EXEC_DATA(void)
>>   {
>>   	execute_location(data_area, CODE_WRITE);
>> -- 
>> 2.31.1
>>
> 
